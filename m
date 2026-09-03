Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41135C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53D2F10F3C6;
	Thu,  3 Sep 2026 07:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="T1afkK9P";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD89E10F3C6
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rO
 11KFikic6g6mPklmVtRlETXgxPhzmlXRj0JBRmR7g=; b=T1afkK9PGyhw/f1bln
 oNSC1VaEdCfrR4YCBdfSnU/6VHlFgUFXrWMHg/Shi7xays20sxBfhYqUBddZ+oeJ
 C+hrxuqJhkv6M+C2Di/WUWYmOVoALDMbYJeCgeza8p/JC7JAGSoMN2pmvHeFGhZR
 F7J4bo88kLka3Ky35L01KefQ0=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wAnM5VDHplqh39MAQ--.9730S2; 
 Thu, 03 Sep 2026 15:14:11 +0800 (CST)
From: oushixiong1025@163.com
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/radeon: Create the primary plane in the driver
Date: Thu,  3 Sep 2026 15:14:09 +0800
Message-Id: <20260903071409.427010-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnM5VDHplqh39MAQ--.9730S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWUXrW3XryUZF17WF4fGrg_yoWrGF1kpF
 ZrCF9xtrn5tFs8Ga43AFW2yF45Cws3Gw4IqrnrKwnI9rn8tryxuFn3ZwnruF18JFZ7Jw15
 tF1UCw15Ar18u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnwIDUUUUU=
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-gOYp2qZHkNsdwAA33
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
ARGB8888, allocated by drmm_universal_plane_alloc(), with the blend
mode property set to the PREMULTI mode userspace has always assumed
when the property was absent.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
  - Open-code DRM_PLANE_NON_ATOMIC_FUNCS without .destroy, which
    drmm_universal_plane_alloc() rejects
  - Use drmm_universal_plane_alloc() for automatic cleanup
  - Move the formats comment above the array

 drivers/gpu/drm/radeon/radeon_display.c | 38 ++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aac6733ddd82..6427feb5a5c5 100644
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
@@ -664,6 +667,20 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	return ret;
 }
 
+/*
+ * The display engine programs an ARGB8888 surface format for both
+ * XRGB8888 and ARGB8888 framebuffers.
+ */
+static const uint32_t radeon_primary_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+};
+
+static const struct drm_plane_funcs radeon_primary_plane_funcs = {
+	.update_plane = drm_plane_helper_update_primary,
+	.disable_plane = drm_plane_helper_disable_primary,
+};
+
 static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.cursor_set2 = radeon_crtc_cursor_set2,
 	.cursor_move = radeon_crtc_cursor_move,
@@ -681,6 +698,7 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
+	struct drm_plane *primary;
 
 	radeon_crtc = kzalloc_obj(*radeon_crtc);
 	if (radeon_crtc == NULL)
@@ -693,7 +711,20 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		return;
 	}
 
-	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
+	primary = drmm_universal_plane_alloc(dev, struct drm_plane, dev, 0,
+					     &radeon_primary_plane_funcs,
+					     radeon_primary_formats,
+					     ARRAY_SIZE(radeon_primary_formats),
+					     NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (IS_ERR(primary))
+		goto err_free_crtc;
+
+	if (drm_crtc_init_with_planes(dev, &radeon_crtc->base, primary, NULL,
+				      &radeon_crtc_funcs, NULL))
+		goto err_free_crtc;
+
+	drm_plane_create_blend_mode_property(primary,
+					     BIT(DRM_MODE_BLEND_PREMULTI));
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
@@ -713,6 +744,11 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+	return;
+
+err_free_crtc:
+	destroy_workqueue(radeon_crtc->flip_queue);
+	kfree(radeon_crtc);
 }
 
 static const char *encoder_names[38] = {
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

