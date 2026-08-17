Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6498C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016C910E849;
	Mon, 17 Aug 2026 15:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZsUSfP23";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0EF10E83B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=OJbpVAs2fZS+i/Mqgu6O8QS+YV95OP0FmKPkFvlU5XQ=; b=ZsUSfP236O/el057aQ0TX+HR1W
 Gx9OoKqaFoulvmW/cDaM/7EVkvs1I9jiOvsLcSQQUQ5HvTzfX3/qDCa4X88PWizVwtG3IGQcb3HCC
 6b+gSUmwjEd0WlxH+I0RoK8Yuy9ID2r+UFdRuqW7OwT9Y19yQFljheObjB6Hd0kmiTUmiOQFL43y6
 T6T3sC0H0SKj4FEcC0+/M47AlkvW2PKwjDSywCE9xpzK7dthVYIlAfEgVO/WHMr9AwA5z7iYzZOp4
 a8NRxo0cxE3QxoJMTqaJbAMNVZbJbkLyVR70Aq3DqEWcnohblQDUCT6RTF5n+AHotGtZJlr7ljPgt
 ViPvv53w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz3y-004eWD-Lm; Mon, 17 Aug 2026 17:15:46 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:31 -0300
Subject: [PATCH 1/6] drm/vc4: Bound the wait for a binner slot in the
 overflow work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-1-ee6c592b3836@igalia.com>
References: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
In-Reply-To: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4073; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=PFPJ35T9YKL1zqk9IrYWE17J09hzhFyZ2TAZ0TwzEeg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWdrpkInbBdiKMXgCn1Ziut5x6V9W8EASBH7
 50yCkv8bK6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qiorCADVg7RadSbF07snEJ043amBjQl6nFOxnIJBZMl06zLg+w3kFM94Z6fT/CxtXtjQNuYHEUB
 YgTfldJm5oUy8+zZzO3rtKrX6UYaUsfNiG02Ns8Y6gBwgEeIrxdg1zJ+W7uc+5lxOC6VL2pjVVg
 PisB9wD2hvrSNrjUHhZtmHq28jW+esqMNd/MCLaMlIW6jWNCDumXmOX3hPXzRzIijEj2Jmj5eQ0
 87qYKP7sK1KanrlFvpiQgrWr2X7AYIGHNbmk2aMEizSPpxuT8kb5ElroyPuE+TIlP7pNePa6C0P
 7ryN3m4XPYC1gQDRUQ0MzDOMnhNGHhcGdp+jLe/4ZJBM62+D
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

vc4_v3d_get_bin_slot() waits for a render job to retire when every binner
slot is in use, and the wait has no timeout. That suits its caller in
vc4_validate.c, which runs in a user task and already handles -EINTR and
-ERESTARTSYS, but vc4_overflow_mem_work() calls it from a kworker, where
an interruptible wait cannot be broken by a signal.

vc4_reset() cannot get past that. It reaches cancel_work_sync() through
vc4_irq_disable() before it calls vc4_irq_reset(), and
vc4_irq_finish_render_job() is the only place that advances
finished_seqno and wakes the queue. Once the render job being waited on is
itself hung, the work never returns, cancel_work_sync() never completes,
and the reset that would have freed the job never runs.

Pass the timeout in from the caller and give the overflow work a second.
vc4_overflow_mem_work() already handles a failed allocation by leaving the
binner stalled for the hangcheck to reset, and that reset now completes.

Assisted-by: Claude:claude-opus-5
Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h      | 2 +-
 drivers/gpu/drm/vc4/vc4_irq.c      | 4 +++-
 drivers/gpu/drm/vc4/vc4_v3d.c      | 4 ++--
 drivers/gpu/drm/vc4/vc4_validate.c | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 86e0e7c12901..35b9b574671b 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -1053,7 +1053,7 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 /* vc4_v3d.c */
 extern struct platform_driver vc4_v3d_driver;
 extern const struct of_device_id vc4_v3d_dt_match[];
-int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, uint64_t timeout_ns);
 int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used);
 void vc4_v3d_bin_bo_put(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 90c5194a1c93..95b1a8ad848b 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -57,6 +57,8 @@
 			 V3D_INT_FLDONE | \
 			 V3D_INT_FRDONE)
 
+#define VC4_OVERFLOW_SLOT_TIMEOUT_NS	NSEC_PER_SEC
+
 static void
 vc4_overflow_mem_work(struct work_struct *work)
 {
@@ -74,7 +76,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 
 	bo = vc4->bin_bo;
 
-	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
+	bin_bo_slot = vc4_v3d_get_bin_slot(vc4, VC4_OVERFLOW_SLOT_TIMEOUT_NS);
 	if (bin_bo_slot < 0) {
 		drm_err(&vc4->base, "Couldn't allocate binner overflow mem\n");
 		goto complete;
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index d2da8d2f8eeb..b943a003bcbc 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -152,7 +152,7 @@ void vc4_v3d_init_hw(struct drm_device *dev)
 	V3D_WRITE(V3D_VPMBASE, 0);
 }
 
-int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
+int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, uint64_t timeout_ns)
 {
 	struct drm_device *dev = &vc4->base;
 	unsigned long irqflags;
@@ -183,7 +183,7 @@ int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
 	if (seqno) {
-		int ret = vc4_wait_for_seqno(dev, seqno, ~0ull, true);
+		int ret = vc4_wait_for_seqno(dev, seqno, timeout_ns, true);
 
 		if (ret == 0)
 			goto try_again;
diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 7f2fadfde7a8..a7add99a65a2 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -385,7 +385,7 @@ validate_tile_binning_config(VALIDATE_ARGS)
 		return -EINVAL;
 	}
 
-	bin_slot = vc4_v3d_get_bin_slot(vc4);
+	bin_slot = vc4_v3d_get_bin_slot(vc4, ~0ull);
 	if (bin_slot < 0) {
 		if (bin_slot != -EINTR && bin_slot != -ERESTARTSYS) {
 			drm_err(dev, "Failed to allocate binner memory: %d\n",

-- 
2.55.0

