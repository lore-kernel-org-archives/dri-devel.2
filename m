Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DCBC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2907310EB30;
	Tue, 11 Aug 2026 10:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UqZQVJFu";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF9910E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443471;
 bh=ryOmwVVB01y5hHhXlGNMY6pOLjAGiF1Kwfym+edbAZU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UqZQVJFuLyhwKk5gwh1DaBX4BUhJHcyWg84wlac0MVXdFp/RPlU1cDlNkUwGo+AFz
 1wBJ339W+i78P8+61OUQGi3Z+LQtakIgsH+T6YZHA41NGwQO8+cm+DLqsRRhlHCr2Z
 HHgX7qRDxi8X1MatVIJwnJ67T7eaocX1aiRvUSWz6tAHqTf9nZpjrIR0WruNiKEi7/
 WNKGTjvNMH/gzqpvByNSggeVeUpRFdowS77Aolkd7WV2SQXP+n60p+NPoDHyTsFVj1
 x/zASrDe/1LPnpKkdx2tyFx9qNYo2jtweRwngopMbeegfqjxGhxx2reHpo7s+ejCLH
 m+md5Z8bntkzw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D4CBA17E0FB1;
 Tue, 11 Aug 2026 12:17:50 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:41 +0200
Subject: [PATCH v2 07/17] drm/panthor: Move the debugfs initialization to
 panthor_device.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-7-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=2777;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ryOmwVVB01y5hHhXlGNMY6pOLjAGiF1Kwfym+edbAZU=;
 b=50qaObyjcRcVN/664J2FCwEEskACF+mQwo/7PxiBtJQHivoXbtTSBaGVnjMfkHTG0cotd7NHi
 Fq5p6bQb8W0AA0d8yWKx4ZjdIGlp6ieDi0kV71YgSyS8AOOtYNmAB5M
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  9 +++++++++
 drivers/gpu/drm/panthor/panthor_device.h |  4 ++++
 drivers/gpu/drm/panthor/panthor_drv.c    | 10 +---------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 393031ada315..d9eab6021145 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -13,6 +13,7 @@
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_print.h>
 
@@ -646,3 +647,11 @@ int panthor_device_suspend(struct device *dev)
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
index ea23dde90fea..10c96abf9cff 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -406,6 +406,10 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
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

