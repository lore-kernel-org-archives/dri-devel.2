Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D66EC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EEA10E6A7;
	Mon,  3 Aug 2026 13:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="roBGOB7/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734B310E60D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xkwWu4nUct9+ls+GGHocr+XJ5HrovmM0eVtqRfDKvHI=; b=roBGOB7/YN3GV6bm3Avz6BiL2u
 RK5JdZyN+OEcQ7RRuwPgKBVWjyOKshSgSfKI0+hOt0BYHOil6PU+kIuCbeTZs3PH+l+gDJENh5b8x
 CYA5DZDU3TXwcj3N6/P2vd9w9iUVZIV0en3/x9XBZMeTo0tRLyz6Y27Hr3P02Uc/wyyiOKbY7WW8c
 BKj8eqT3nBnARlayCylQE4Ik2jynfmXBZeB7bgEvyabXn1ebtsdO1gjo2MMM3I9oAPbraJRagJ2NI
 snuC2ZvUehiL8m1nFK6Z2y2xaQu8LmFcdNWsrSbXMJCrOADDR3g0QhXJ58+yFOpGZOwYENFucCD8g
 SXAH84zA==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wqsi3-00Cz51-PE; Mon, 03 Aug 2026 15:28:04 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/sysfs: Remove drm_class_device_(un)register()
Date: Mon,  3 Aug 2026 10:26:52 -0300
Message-ID: <20260803132706.1497980-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The last usage of the functions drm_class_device_register() and
drm_class_device_unregister() was removed in commit ed89fff97382
("drm/ttm: drop sysfs directory").

Remove such functions as they are no longer used.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/drm_sysfs.c      | 32 --------------------------------
 drivers/gpu/drm/ttm/ttm_module.c |  1 -
 include/drm/drm_sysfs.h          |  4 ----
 3 files changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a8728..7b16d32b6ff6 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -589,35 +589,3 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 	put_device(kdev);
 	return ERR_PTR(r);
 }
-
-/**
- * drm_class_device_register - register new device with the DRM sysfs class
- * @dev: device to register
- *
- * Registers a new &struct device within the DRM sysfs class. Essentially only
- * used by ttm to have a place for its global settings. Drivers should never use
- * this.
- */
-int drm_class_device_register(struct device *dev)
-{
-	if (!drm_class || IS_ERR(drm_class))
-		return -ENOENT;
-
-	dev->class = drm_class;
-	return device_register(dev);
-}
-EXPORT_SYMBOL_GPL(drm_class_device_register);
-
-/**
- * drm_class_device_unregister - unregister device with the DRM sysfs class
- * @dev: device to unregister
- *
- * Unregisters a &struct device from the DRM sysfs class. Essentially only used
- * by ttm to have a place for its global settings. Drivers should never use
- * this.
- */
-void drm_class_device_unregister(struct device *dev)
-{
-	return device_unregister(dev);
-}
-EXPORT_SYMBOL_GPL(drm_class_device_unregister);
diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
index aa137ead5cc5..3daace105930 100644
--- a/drivers/gpu/drm/ttm/ttm_module.c
+++ b/drivers/gpu/drm/ttm/ttm_module.c
@@ -34,7 +34,6 @@
 #include <linux/pgtable.h>
 #include <linux/sched.h>
 #include <linux/debugfs.h>
-#include <drm/drm_sysfs.h>
 #include <drm/ttm/ttm_caching.h>
 
 #include "ttm_module.h"
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 96a5d858404b..7695873a9456 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -3,13 +3,9 @@
 #define _DRM_SYSFS_H_
 
 struct drm_device;
-struct device;
 struct drm_connector;
 struct drm_property;
 
-int drm_class_device_register(struct device *dev);
-void drm_class_device_unregister(struct device *dev);
-
 void drm_sysfs_hotplug_event(struct drm_device *dev);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_property_event(struct drm_connector *connector,
-- 
2.55.0

