Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BB1C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293BB10E6E2;
	Wed, 26 Aug 2026 14:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RAgeVG3A";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6CF10E0A5
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756180;
 bh=uptKXCpjgRj0Ud46HcaI4A0OYDF8I2rwFQqa96c4pXk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RAgeVG3AAKENnoIYwHgHjjtdfnVb45CtxuMhQHxRBztjoT0vu4efXsKyks3FBYjVW
 d849wvUwX6eNW4iQwrlNZBC1Ij5ObSmE8p1AYoD5EM2WjA57vM8e+aibGV90HOUSz4
 3dgfFCq0xGN+YZMxCKHH592gLTeilhAcMi0UUb3Gq7KwnhCO+OCBHYRw+piEmBwQRY
 7UO3hx+0LF475JugVLj/ByRxpQ8GSkQVtUFr/JgXaV6OTlZHK+wwKPgKOufQ4ql66E
 wIl+P+3T+oykEvyXjtjatNhIDIG9qKq2DhAYEDAb1pMpBN2tiGq2sNAR8B4Vc49QvY
 c0jT1xAIz8irw==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 475BB17E0BDC;
 Wed, 26 Aug 2026 16:56:20 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:01 +0200
Subject: [PATCH v4 02/18] drm/panthor: Revisit the reset logic to avoid
 reset request loss
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-2-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=4527;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=uptKXCpjgRj0Ud46HcaI4A0OYDF8I2rwFQqa96c4pXk=;
 b=KqZmmhSBhgGQnoG9uAVgDGOaGFTFzd4DbmDVtB2HTk/jc/TD5DDbSJAC8mMphPAh5iVnjerAP
 Nk8VhR6/vjeBMXGAbU7Ep5moIys9Cih8kvYm4SWuwWD3IHjczgvbAXZ
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

disable/enable_work() provide a ready to use mechanism to temporarily
disable a work item, so use that instead of the complex state machinery
based on the PM state.

This also allows us to automate the reset resubmission in case a reset
was received while the work item was disabled.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 36 +++++++++++++++++++++++++-------
 drivers/gpu/drm/panthor/panthor_device.h |  3 +--
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 7c55d0c45cfd..2974f4bc0bb1 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -181,6 +181,15 @@ static void panthor_device_free_page(struct drm_device *ddev, void *data)
 	__free_page(data);
 }
 
+static void enable_resets(struct panthor_device *ptdev)
+{
+	/* If a reset has been queued while the work was
+	 * disabled, reschedule it.
+	 */
+	if (enable_work(&ptdev->reset.work) && atomic_read(&ptdev->reset.pending))
+		queue_work(ptdev->reset.wq, &ptdev->reset.work);
+}
+
 int panthor_device_init(struct panthor_device *ptdev)
 {
 	u32 *dummy_page_virt;
@@ -256,6 +265,13 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	ptdev->phys_addr = res->start;
 
+	/* panthor_device_resume() calls enable_resets(), so we need to disable
+	 * the reset.work manually before this gets called to keep things
+	 * balanced. We don't bother re-enabling the work if the resume fails,
+	 * because the whole initialization will fail in that case, and the work
+	 * will vanish.
+	 */
+	disable_work(&ptdev->reset.work);
 	ret = devm_pm_runtime_enable(ptdev->base.dev);
 	if (ret)
 		return ret;
@@ -305,9 +321,6 @@ int panthor_device_init(struct panthor_device *ptdev)
 
 	panthor_gem_init(ptdev);
 
-	/* Now that everything is initialized, we can enable the reset work. */
-	enable_work(&ptdev->reset.work);
-
 	/* ~3 frames */
 	pm_runtime_set_autosuspend_delay(ptdev->base.dev, 50);
 	pm_runtime_use_autosuspend(ptdev->base.dev);
@@ -316,6 +329,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_disable_autosuspend;
 
+	/* Now that everything is initialized, we can enable the reset work. */
+	enable_resets(ptdev);
+
 	pm_runtime_put_autosuspend(ptdev->base.dev);
 	return 0;
 
@@ -534,10 +550,8 @@ int panthor_device_resume(struct device *dev)
 		/* If there was a reset pending at the time we suspended the
 		 * device, we force a slow reset.
 		 */
-		if (atomic_read(&ptdev->reset.pending)) {
+		if (atomic_cmpxchg(&ptdev->reset.pending, 1, 0))
 			ptdev->reset.fast = false;
-			atomic_set(&ptdev->reset.pending, 0);
-		}
 
 		ret = panthor_device_resume_hw_components(ptdev);
 		if (ret && ptdev->reset.fast) {
@@ -565,6 +579,9 @@ int panthor_device_resume(struct device *dev)
 			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
 	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_ACTIVE);
 	mutex_unlock(&ptdev->pm.mmio_lock);
+
+	/* Now that everything is resumed, we can re-enable the reset work. */
+	enable_resets(ptdev);
 	return 0;
 
 err_suspend_devfreq:
@@ -604,10 +621,13 @@ int panthor_device_suspend(struct device *dev)
 			    DRM_PANTHOR_USER_MMIO_OFFSET, 0, 1);
 	mutex_unlock(&ptdev->pm.mmio_lock);
 
+	/* Make sure we're not interrupted by resets after that point
+	 * until the GPU is resumed.
+	 */
+	disable_work_sync(&ptdev->reset.work);
+
 	if (panthor_device_is_initialized(ptdev) &&
 	    drm_dev_enter(&ptdev->base, &cookie)) {
-		cancel_work_sync(&ptdev->reset.work);
-
 		/* We prepare everything as if we were resetting the GPU.
 		 * The end of the reset will happen in the resume path though.
 		 */
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 6529e01e838d..f55baa21b25e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -389,8 +389,7 @@ void panthor_device_unplug(struct panthor_device *ptdev);
  */
 static inline void panthor_device_schedule_reset(struct panthor_device *ptdev)
 {
-	if (!atomic_cmpxchg(&ptdev->reset.pending, 0, 1) &&
-	    atomic_read(&ptdev->pm.state) == PANTHOR_DEVICE_PM_STATE_ACTIVE)
+	if (!atomic_cmpxchg(&ptdev->reset.pending, 0, 1))
 		queue_work(ptdev->reset.wq, &ptdev->reset.work);
 }
 

-- 
2.55.0

