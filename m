Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED6ACA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732E910E037;
	Sun,  4 Oct 2026 15:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bM/e1+eH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F32B510E04F
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=q+7hK+nNbUgfzQl58ehyLiu8NC/ixiwyOC2IJdzSkAA=; b=bM/e1+eHWtINU4eTZTwzlmP/RJ
 9xqOQ5X128iNvCwncZ2QmanGfn7Og2TJm3rS8ZIA4KEfEJzkC6xYXAVjPtqBDUpwuFBVp/AgeExex
 /agYw5puyNI5SDu/TVByzVosyRdDmVTSEY4FTz7cPP6fXOJgA8PD0Rim8qRtrzB0fOsghnbnNGgfO
 +HU88oBLfe5j1fLc9QO3l1IX3KljcZbqZpmk56b/sS0NPyaLRHbQj3bg4XqttMu7uH4Oj/+hqFt+L
 4r0e8hvdEMmCf5Tq/n/xCG98RXsrlZDXLYvbGsPKK2MRpJnPREwI2CnblzCvEqlRA3+hhf6mOs/e1
 04V3E9Pg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOM5-00BNsh-Ei; Sun, 04 Oct 2026 17:42:25 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:02 -0300
Subject: [PATCH 02/11] drm/vc4: Drop the BO reservations outside of
 job_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-2-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=zdfZOgfqbatRc+cQ0Mbk0vbFQOPsH1YUVlZRRMCmaEc=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPW1pt4/52cSTrGnWz+f/L6rdpWhuTiKoYUM
 WnlpZ9/HEqJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1gAKCRA/8w6Kdoj6
 qk4RCACsdwu+vfDPkXftJAgVs5uewSQOseMRmX3KbBdOdTLpUHxWdSK9retZsKN/L+HPrOWeR+d
 Y2VZx/gh2uwf/J+0pkDpc0k9pcfXJCObKddJiqh7ySaUv4x5l1aejor5jwRP43VuVWouRxtLoEA
 mSVv8X6xXDGnvg9VHPky9gkt5qKyoN8BZ12A/VT4UGELCNzEalOJXGXGEU594csxwQx1vk4mYJA
 RxMhW1dD0GVHThwLPXtsP59/ij9HUljKVcw6e+mTJlUQhTrzo0/lR/tSikKzjUUhIUL3W6I2WDC
 PEj6m5LFc6P1ycaPn4XLdQF5LMvIGru7ZOke5Lr6VjVzQyVL
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

vc4_queue_submit() calls drm_exec_fini() with job_lock held and interrupts
disabled. Besides unlocking the reservations, drm_exec_fini() frees the
object array with kvfree(), which asks for preemptible task context or a
non-NMI interrupt, and may reach might_sleep() through vfree().

Considering that an array that exceeds a page can take the vmalloc
fallback, call drm_exec_fini() once job_lock is dropped. The reservations
are then held across the job kick, which is harmless as nothing in the
completion path takes a BO reservation.

Note that vc4_attach_fences() has to stay inside the critical section, as
it walks exec, which the job done worker is free to release as soon as
job_lock is dropped.

Fixes: 04630796c437 ("drm/vc4: Use DRM Execution Contexts")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index f4be154d4eb0..0fef9b48d3c6 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -647,8 +647,6 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	vc4_attach_fences(exec);
 
-	drm_exec_fini(exec_ctx);
-
 	list_add_tail(&exec->head, &vc4->bin_job_list);
 
 	/* If no bin job was executing and if the render job (if any) has the
@@ -665,6 +663,8 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	drm_exec_fini(exec_ctx);
+
 	if (out_sync) {
 		drm_syncobj_replace_fence(out_sync, &fence->base);
 		dma_fence_put(&fence->base);

-- 
2.55.0

