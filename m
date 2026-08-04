Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A5BC55ABF
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF8A10E994;
	Tue,  4 Aug 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JehKUtJI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 994CC10E12F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838196;
 bh=YqEY51AaClJsLFVXwpEXOrnUItYnhK9wUpsMaXBZvdQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JehKUtJIn46HZsbsnSzOrv+IYdVv4lkPswPEWx+LiRHJhlzn9veHDDOnmMSHg7caE
 F4jOkOP3k+irrUXj7Fnnjq/fGVb3cHQGjrIkKrJ8MAEKHbC7wGOLCORm4y/S8TNx0F
 klBcj/8Zn3oUI6BXP8sPshDKVznkL58NvHThsKZe/dB/GU6x7Ej8tcFPtn3U7q6/Lh
 9ljWSIwnSa3vmo8v0WVLXhY/TuaAuXomSso8pfZFGH91zigqCbzdOC4daoNZjX4Mp1
 YdPRLpupKpCV5DF0m5K7X+AUeGC/V0uJKMH5HZhWBvAdUI5bOb/SejdUB7Mc07E7XG
 Mc6j7qFIKdkbw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F1D8017E0FEA;
 Tue, 04 Aug 2026 12:09:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:42 +0200
Subject: [PATCH 03/12] drm/panthor: Move the debugfs initialization to
 panthor_device.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-3-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=2729;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=YqEY51AaClJsLFVXwpEXOrnUItYnhK9wUpsMaXBZvdQ=;
 b=U3EzBc/BQN0Bv89K/9d/DmfbJwt2M85uvQHrzSb8V5OEf6wn8YE0BdBc1npdhOmWMH2PhELGX
 e2ztH04jcN8DBjd8TmnuTXyuIrZgwJ7kNXIfcqQ/zpkqOWZGyq1otfE
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

Those are per-device debugfs-files, so it makes sense to have the
initialization logic in panthor_device.c.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  9 +++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  4 ++++
 drivers/gpu/drm/panthor/panthor_drv.c    | 10 +---------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 1aa86d00646f..7d336f160d1f 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
@@ -616,3 +617,11 @@ int panthor_device_suspend(struct device *dev)
 	atomic_set(&ptdev->pm.state, PANTHOR_DEVICE_PM_STATE_SUSPENDED);
 	return 0;
 }
+
+#ifdef CONFIG_DEBUG_FS
+void panthor_device_debugfs_init(struct drm_minor *minor)
+{
+	panthor_mmu_debugfs_init(minor);
+	panthor_gem_debugfs_init(minor);
+}
+#endif
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0fda64fbe5f2..a6b1a2a5fca4 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -403,6 +403,10 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
+#ifdef CONFIG_DEBUG_FS
+void panthor_device_debugfs_init(struct drm_minor *minor);
+#endif
+
 static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 {
 	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 46a3080b0b20..924a7ecd3733 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1764,14 +1764,6 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
-#ifdef CONFIG_DEBUG_FS
-static void panthor_debugfs_init(struct drm_minor *minor)
-{
-	panthor_mmu_debugfs_init(minor);
-	panthor_gem_debugfs_init(minor);
-}
-#endif
-
 /*
  * PanCSF driver version:
  * - 1.0 - initial interface
@@ -1807,7 +1799,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
 #ifdef CONFIG_DEBUG_FS
-	.debugfs_init = panthor_debugfs_init,
+	.debugfs_init = panthor_device_debugfs_init,
 #endif
 };
 

-- 
2.55.0

