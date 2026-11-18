Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B571606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TV7Sdxs5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE7111206A;
	Wed, 18 Nov 2026 21:48:09 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50A6112066
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=8hwxCT8J6T3J+VUZm9acnDT4rPprAYYlG8dk+lTP2CE=; t=1795038476; x=2110398476; 
 b=TV7Sdxs5vONd5GlaDC0Ag8KzJfJcpku70q8PuLt35xLe5zi/ukcUcSK9A7kUgFAmJKP7oP6Ufy6
 qRSHPSC2LulV/IMR95mnOEHr66YKf4OOOW8LJ+rnUiSifgDhdERDBTD9B64sril8cpYRul/gUXO0/
 BKRw3/AX0VMnNj0Rrk1pr3LxN8xEYHxIvLGGRzy/hc/izEqnz97SGu7yenZq/1yC4gv83Xm4shsN5
 xNBnZ9V9m7DpV6StgmCIxymhH1ttjvK4x3OiDpUQPEZDjxkU3f5lOYtqoj01J7asA5G3zu/apsWIl
 b9Ccb3vU71aFk/+v74Osx5GcE8FLAR9Wj1yw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTnVS-00000001DOD-1YrF; Wed, 18 Nov 2026 22:47:54 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 18 Nov 2026 18:47:31 -0300
Subject: [PATCH 4/4] drm/vc4: Clear the slice caches before resetting a
 stalled GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-vc4-icache-workaround-v1-4-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3218; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9zffzSXj5cLqRqPiTxaIkEmj8QnZEXnsu3xIIn9DrVM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz2fLhHihYkBlYSAhnyUlGgi7iZke7zOs4Vs
 9JJnupRMiSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qqYZCACt4a0s9dGJaRujPek0YJ3j91vzQax2ccDNTOQVlBf2EjpVrjP4C7om7yfnCJ6OQ+/vWp4
 +Zc2ggP4I8fFSmoU144RNcx+nhvjc/o8owtsm9K6dUWVLwyT3kzLukkFNNUFHwaun8l0qkHHLO5
 EPqk+vV/dl41aCSMJE8eppB9wkVPOq/ymgGDCEZR1QFQQKlhxd1zoNIIb13dh9NlklV+rOVtoRk
 hYV5518TEfwKT9fyLbr4OVq6p+bJhJ4eGKoAdYWAI0RJtq+DBTV39p77JgVpA2d840+2ILMdSaD
 g2Lemh9iCZJUX5dkPwpoWFTPkn5iCFmrN14t76AR2WR8Fvx1
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Starting shader code at varying offsets makes the GFXH-16 icache livelock
unlikely, but not impossible. When the livelock happens, the QPUs make no
progress and the hangcheck resets the GPU, losing the job.

When the hangcheck finds no progress, clear the slice instruction and
uniforms caches and check again before resetting. If the stall is a
livelock, clearing the caches can break it and let the job continue.

Drop round_jiffies_up() from the hangcheck timer, so checks run every
100 ms instead of at the next whole second. This shortens the screen
freeze before the caches are cleared. Long jobs are unaffected: while the
control lists advance, the hangcheck won't clear the caches or reset the
GPU.

Cc: stable@vger.kernel.org
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/16652
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  5 +++++
 drivers/gpu/drm/vc4/vc4_gem.c | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 62ce83322d1b..dae325a3854d 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -218,6 +218,11 @@ struct vc4_dev {
 	struct {
 		struct timer_list timer;
 		struct work_struct reset_work;
+
+		/* The instruction and uniforms caches were cleared at the
+		 * last check that found no progress.
+		 */
+		bool caches_cleared;
 	} hangcheck;
 
 	struct drm_modeset_lock ctm_state_lock;
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 956be198f8a7..9898eb1ef077 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -43,8 +43,7 @@ vc4_queue_hangcheck(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
-	mod_timer(&vc4->hangcheck.timer,
-		  round_jiffies_up(jiffies + msecs_to_jiffies(100)));
+	mod_timer(&vc4->hangcheck.timer, jiffies + msecs_to_jiffies(100));
 }
 
 struct vc4_hang_state {
@@ -355,6 +354,7 @@ vc4_hangcheck_elapsed(struct timer_list *t)
 
 	/* If idle, we can stop watching for hangs. */
 	if (!bin_exec && !render_exec) {
+		vc4->hangcheck.caches_cleared = false;
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 		return;
 	}
@@ -371,11 +371,27 @@ vc4_hangcheck_elapsed(struct timer_list *t)
 			bin_exec->last_ct0ca = ct0ca;
 		if (render_exec)
 			render_exec->last_ct1ca = ct1ca;
+
+		vc4->hangcheck.caches_cleared = false;
+
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 		vc4_queue_hangcheck(dev);
 		return;
 	}
 
+	/* Clear the slice caches to workaround GFXH-16 */
+	if (!vc4->hangcheck.caches_cleared) {
+		V3D_WRITE(V3D_SLCACTL, VC4_SET_FIELD(0xf, V3D_SLCACTL_ICC) |
+			  VC4_SET_FIELD(0xf, V3D_SLCACTL_UCC));
+
+		vc4->hangcheck.caches_cleared = true;
+		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		vc4_queue_hangcheck(dev);
+		return;
+	}
+
+	vc4->hangcheck.caches_cleared = false;
+
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
 	/* We've gone too long with no progress, reset.  This has to

-- 
2.56.0

