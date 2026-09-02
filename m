Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5ECC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1875010EF29;
	Wed,  2 Sep 2026 10:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="RaA/e5eA";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB95E10EF29
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W9
 EeqDPtGbfRUrueo7yJ0lKN2M1jQ6g40CdEA+nhzJE=; b=RaA/e5eAlRyeKSfWPX
 Ci7srqWHtIJMNfiFSJjqznhyAOBt8HU2HdAefcaupQfsjWUkNZcFLvpAeiwplaHJ
 4txJV2mnsW6/Nr4q+eXaeNk+7EB/vfNSxDK6N1Ov1/4w3pU2+K2Ur/uXP28ItDRz
 bK3s0i80kuOqxpSFORpbdhpg0=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgBHcANt9ZdqPVzePQ--.34200S2;
 Wed, 02 Sep 2026 18:07:41 +0800 (CST)
From: oushixiong1025@163.com
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/radeon: Create the primary plane in the driver
Date: Wed,  2 Sep 2026 18:07:39 +0800
Message-Id: <20260902100739.627697-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgBHcANt9ZdqPVzePQ--.34200S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUXrWxZrWfAFyDJFyftFb_yoW5uFWDpF
 ZxCF9xtrs5tFs5Ga43ArZFyF45ua1fGw4Iqry2gwnI9rn8try7uF1xZwnrCF18JrZ7Jw1Y
 qF47Ca15Ar409aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFxRDUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4g0ZKGqX9W3nOgAA3m
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

From: Shixiong Ou <oushixiong@kylinos.cn>

drm_crtc_init() creates the primary plane from a fixed format list
without a "pixel blend mode" property, so drm_mode_config_validate()
warns although the display engine does support per-pixel alpha on the
primary surface.

Replace it with a driver-owned primary plane advertising XRGB8888 and
ARGB8888, with the blend mode property set to the PREMULTI mode
userspace has always assumed when the property was absent.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/radeon/radeon_display.c | 42 ++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aac6733ddd82..058ec866f02b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -30,6 +30,7 @@
 
 #include <asm/div64.h>
 
+#include <drm/drm_blend.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
@@ -38,6 +39,8 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
@@ -664,6 +667,19 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	return ret;
 }
 
+static const uint32_t radeon_primary_formats[] = {
+	/*
+	 * The display engine programs an ARGB8888 surface format for both
+	 * XRGB8888 and ARGB8888 framebuffers.
+	 */
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+};
+
+static const struct drm_plane_funcs radeon_primary_plane_funcs = {
+	DRM_PLANE_NON_ATOMIC_FUNCS,
+};
+
 static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.cursor_set2 = radeon_crtc_cursor_set2,
 	.cursor_move = radeon_crtc_cursor_move,
@@ -681,6 +697,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
+	struct drm_plane *primary;
+	int ret;
 
 	radeon_crtc = kzalloc_obj(*radeon_crtc);
 	if (radeon_crtc == NULL)
@@ -693,7 +711,29 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		return;
 	}
 
-	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
+	primary = __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
+					      &radeon_primary_plane_funcs,
+					      radeon_primary_formats,
+					      ARRAY_SIZE(radeon_primary_formats),
+					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(primary)) {
+		destroy_workqueue(radeon_crtc->flip_queue);
+		kfree(radeon_crtc);
+		return;
+	}
+
+	ret = drm_crtc_init_with_planes(dev, &radeon_crtc->base, primary, NULL,
+					&radeon_crtc_funcs, NULL);
+	if (ret) {
+		dev_err(dev->dev, "Failed to init CRTC %d: %d\n", index, ret);
+		drm_plane_cleanup(primary);
+		kfree(primary);
+		destroy_workqueue(radeon_crtc->flip_queue);
+		return;
+	}
+
+	drm_plane_create_blend_mode_property(primary,
+					     BIT(DRM_MODE_BLEND_PREMULTI));
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

