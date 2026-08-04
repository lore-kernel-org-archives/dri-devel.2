Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C98CC56202
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E37E10E9A3;
	Tue,  4 Aug 2026 10:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Yuke0yYE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E70A10E99A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838201;
 bh=IxNTkuNmGbCBaAyYnmtQYnwSXqfjegGebkYKXwCgjrg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Yuke0yYE+/10pWP7b+cwQySavj6vjESx0QFno7SVGWXnmOl2SW/V+oIRJ+oqZA9QV
 ahqNzWLJB9rBsXfpX0Wmk9qVivIDo1q6bk9tpFRHoZ+rAyzFzU7RwUd1BhCGIiEFya
 4ZTEp/4f/NZIiiNMIJJ6eCnTLKQmi9uY5kerYYeT2DyzcNmBnRWLoFJJkhYt4sF1er
 SY265tAiZp0G9luIlPzvKGoYjcTTYBiPGzJVErUZUbLIkMvqKfJ457Pf09igM/9ORd
 pmhoSC2zd6h2iZfLCBC8F9vFVXAIRingFSzUvM7LlU5MD7XVtKg/HSBUiSVUxVvgdt
 3q/IdJ4C1Q02w==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A2E2E17E11E6;
 Tue, 04 Aug 2026 12:10:00 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:51 +0200
Subject: [PATCH 12/12] drm/panthor: Fix unplug in the reset path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-12-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=6038;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=IxNTkuNmGbCBaAyYnmtQYnwSXqfjegGebkYKXwCgjrg=;
 b=0VypsmCoAzBuVv0BKjNGLP64WEoTBKF/lMs5VN7jfGKXjMwDuSz3xS3E30iK8W9QRaTbFpUc6
 Cma5b7gsAeDAzywB2+dlFxjKsp+jrRmA6OtJW5+W2OGHg5ACbOFV6y6
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

We can't use disable_work_sync() if panthor_device_unplug() is called
from the reset work or we'll deadlock. Pass a from_reset_work bool to
the panthor_device_unplug() function and lower the disable_work_sync()
to a disable_work() in that case.

We also add debugfs knobs to simulate this situation.

Maybe we should use a separate work and call device_release_driver()
instead of calling panthor_device_unplug() directly. This would allow
us to actually detach the device from panthor so it can later be
re-attached without an explicit unbind/bind or rmmod/modprobe sequence.
The problem is, this gets racy if the device is manually
unbound/rebound, and it's hard to fix that race, so let's keep this
for later.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 54 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_device.h | 10 +++++-
 drivers/gpu/drm/panthor/panthor_drv.c    |  2 +-
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 425990369b99..d350bda58bb3 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -93,7 +93,7 @@ static int panthor_device_stop_before_unplug(struct panthor_device *ptdev)
 	return ret;
 }
 
-void panthor_device_unplug(struct panthor_device *ptdev)
+void panthor_device_unplug(struct panthor_device *ptdev, bool from_reset_work)
 {
 	int ret;
 
@@ -121,7 +121,10 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	drm_dev_unplug(&ptdev->base);
 
 	/* Make sure we're not interrupted by resets while we're unplugging. */
-	disable_work_sync(&ptdev->reset.work);
+	if (!from_reset_work)
+		disable_work_sync(&ptdev->reset.work);
+	else
+		disable_work(&ptdev->reset.work);
 
 	/* Do anything we can to stop the HW. If we can't guarantee that the HW
 	 * is fully stopped, we also can't guarantee the resources it had access
@@ -189,13 +192,16 @@ static void panthor_device_reset_work(struct work_struct *work)
 	panthor_hw_soft_reset(ptdev);
 	panthor_hw_l2_power_on(ptdev);
 	panthor_mmu_post_reset(ptdev);
-	ret = panthor_fw_post_reset(ptdev);
+	if (ptdev->reset.fake_failure)
+		ret = -EIO;
+	else
+		ret = panthor_fw_post_reset(ptdev);
 	atomic_set(&ptdev->reset.pending, 0);
 	panthor_sched_post_reset(ptdev, ret != 0);
 	drm_dev_exit(cookie);
 
 	if (ret) {
-		panthor_device_unplug(ptdev);
+		panthor_device_unplug(ptdev, true);
 		drm_err(&ptdev->base, "Failed to boot MCU after reset, making device unusable.");
 	}
 }
@@ -694,6 +700,40 @@ DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_unplug_failure_fops,
 			 panthor_device_fake_unplug_failure_get,
 			 panthor_device_fake_unplug_failure_set, "%llu\n");
 
+static int panthor_device_fake_fw_reset_failure_get(void *data, u64 *val)
+{
+	struct panthor_device *ptdev = data;
+
+	*val = ptdev->reset.fake_failure ? 1 : 0;
+	return 0;
+}
+
+static int panthor_device_fake_fw_reset_failure_set(void *data, u64 val)
+{
+	struct panthor_device *ptdev = data;
+
+	ptdev->reset.fake_failure = val ? true : false;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_fw_reset_failure_fops,
+			 panthor_device_fake_fw_reset_failure_get,
+			 panthor_device_fake_fw_reset_failure_set, "%llu\n");
+
+static ssize_t panthor_device_reset_file_write(struct file *file,
+					       const char __user *, size_t size,
+					       loff_t *)
+{
+	struct panthor_device *ptdev = file_inode(file)->i_private;
+
+	panthor_device_schedule_reset(ptdev);
+	return size;
+}
+
+static const struct debugfs_short_fops panthor_device_reset_fops = {
+	.write = panthor_device_reset_file_write,
+};
+
 void panthor_device_debugfs_init(struct drm_minor *minor)
 {
 	struct panthor_device *ptdev = container_of(minor->dev, struct panthor_device, base);
@@ -701,6 +741,12 @@ void panthor_device_debugfs_init(struct drm_minor *minor)
 	debugfs_create_file("fake_unplug_failure", 0644,
 			    minor->debugfs_root, ptdev,
 			    &panthor_device_fake_unplug_failure_fops);
+	debugfs_create_file("fake_fw_reset_failure", 0644,
+			    minor->debugfs_root, ptdev,
+			    &panthor_device_fake_fw_reset_failure_fops);
+	debugfs_create_file("reset", 0200,
+			    minor->debugfs_root, ptdev,
+			    &panthor_device_reset_fops);
 	panthor_mmu_debugfs_init(minor);
 	panthor_gem_debugfs_init(minor);
 }
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f960109f4b5b..7d3db80fdfb6 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -310,6 +310,14 @@ struct panthor_device {
 		 * all FW sections to make sure we start from a fresh state.
 		 */
 		bool fast;
+
+		/**
+		 * @fake_failure: When true, pretend the FW boot in the reset path failed.
+		 *
+		 * This is important to check that we're doing the right thing in this very
+		 * unlikely case.
+		 */
+		bool fake_failure;
 	} reset;
 
 	/** @pm: Power management related data. */
@@ -398,7 +406,7 @@ struct panthor_file {
 };
 
 int panthor_device_init(struct panthor_device *ptdev);
-void panthor_device_unplug(struct panthor_device *ptdev);
+void panthor_device_unplug(struct panthor_device *ptdev, bool from_reset_work);
 
 /**
  * panthor_device_schedule_reset() - Schedules a reset operation
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 924a7ecd3733..730f7996985c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1827,7 +1827,7 @@ static void panthor_remove(struct platform_device *pdev)
 {
 	struct panthor_device *ptdev = platform_get_drvdata(pdev);
 
-	panthor_device_unplug(ptdev);
+	panthor_device_unplug(ptdev, false);
 }
 
 static ssize_t profiling_show(struct device *dev,

-- 
2.55.0

