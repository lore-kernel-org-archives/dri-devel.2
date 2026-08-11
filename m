Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C9BC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852510EB41;
	Tue, 11 Aug 2026 10:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YbrHB5ZA";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C7010E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443476;
 bh=mUoAoXlDI7yZyvH60OvVhl7XJ24dV86jsycZLjHMo7U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YbrHB5ZAe69NiObLrwREIj5xxCMmeYtXrtI/5PpwyWd8hwk2/dKP6iHpD6B1ITruW
 JnpsElxANrgxpucAAFqogHaScUStHa4rGJztGMJ4WdIkBDN4Jm6Gvq6EhZ0ZpwZrcE
 yQXnzLRE4B2x1RK4LqwjYBYp2FMkytuUqkGEVGIZYwDb2MskPhBfyECtFd8QloZPLo
 ZPHPsBRVQ9HtZ9IVPV+GEWPeFWS0qz3NZl+kRmWMFDELlA02wbARM3pgoO+6oZoWQw
 BEExpeej2zCpNBaS5sS1/2dDPmLNjQhQrH4EwpO8cJRIgoc4d8zGlzHe8bKkQwzb2X
 0zIlehRXyqG9A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 306D517E12AE;
 Tue, 11 Aug 2026 12:17:56 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:51 +0200
Subject: [PATCH v2 17/17] drm/panthor: Add a debugfs knobs to simulate
 reset failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-17-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443467; l=3671;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=mUoAoXlDI7yZyvH60OvVhl7XJ24dV86jsycZLjHMo7U=;
 b=CMqGYTbeMGpUymG0t0PK1yg0WM9B44OlTt3NMAV6ERJsy93lVaqTECzIY8ai7sVkkc5EqSDlw
 4oHpHG/ZTJZDy2DqFiAvScHH5WunZCFwzYXMxoypj4lB59by8JZKnZj
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

It's almost impossible to trigger a situation where the reset
doesn't work now that the driver is more mature, so let's add two
knobs to exercise this error path:

- a knob to trigger a reset
- a knob to fake an error in the reset path

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 45 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_device.h |  8 ++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 012edf5d590c..09c9cc922e70 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -198,7 +198,10 @@ static void panthor_device_reset_work(struct work_struct *work)
 	panthor_hw_soft_reset(ptdev);
 	panthor_hw_l2_power_on(ptdev);
 	panthor_mmu_post_reset(ptdev);
-	ret = panthor_fw_post_reset(ptdev);
+	if (ptdev->reset.fake_failure)
+		ret = -EIO;
+	else
+		ret = panthor_fw_post_reset(ptdev);
 	panthor_sched_post_reset(ptdev, ret != 0);
 	drm_dev_exit(cookie);
 
@@ -699,6 +702,40 @@ DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_unplug_failure_fops,
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
@@ -706,6 +743,12 @@ void panthor_device_debugfs_init(struct drm_minor *minor)
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
index b2788373bfa9..160593824ef2 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -313,6 +313,14 @@ struct panthor_device {
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

-- 
2.55.0

