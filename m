Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A40CCD3439
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF83F10E97B;
	Tue,  5 May 2026 07:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZUqu1Fo";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3AF710E021
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 04:28:08 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8aca4e14411so48748426d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 21:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777955288; x=1778560088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=mWoD3Hi1a+L1RGrGj0FkLyIqbiSOhVi2o2xdns78woA=;
 b=JZUqu1FojRWP+0BudKBDEGW9fd1+mBaypLkxPu6yWSZbX0Qjk7Z92ygW+96/FGrmVM
 QbXWHtqW2Tkffufz2M+TtkCq+CpiOETgrpexPD1ybKSi9HDxzAQX+MfMPJZWaISDrr4z
 NY1E89dfIlecvqFRv/INdgikhk4gzwd3HjxFuKdOQGbRkNhO+zdYVOxGkiBFMxmNBZQB
 mKxku0+bci3F2c7QAaY2C7C59YOg+yDTmMAnUKq7Zueb0QXjs0ih1ZUZUoOzrk5eq3WH
 N6pEMqxt4ibLB+RXafCnKO2PiodvpdrVC0dvce8/uAic2vNdB2EiIPjkJthWR1aC0tAY
 z8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777955288; x=1778560088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWoD3Hi1a+L1RGrGj0FkLyIqbiSOhVi2o2xdns78woA=;
 b=VaEVDQmeqKmSuaYhtCfbzAWj8Z5nxS5O0zOgKjQf9FX03h+rd9xFsGTFGivyB0HEED
 y990t/OgqeQIC3wbGTrgdebJsr+kOY1gnN5LjNzkWOozE/mNy+eVb7hthON6Zprt3F6S
 62k3vKNnKrh5l4nWKhgvcJMHQrW7VbILAnDQ0LOxcm3yXgnh2c57QnEnozBanhQpjlyD
 e0i8ynNeIEh4o0YJyuZMPkPP+FCaWXvCD8KFMKJ5w8XzvZfdwcL05cicLc/XWRVIwq4Z
 F7EyekdHslHb7sjvVQRXAlWbZQKInSG3domyfe4MQP6AQdK98Np58/n5Hbxzd5Yh98XF
 Cw7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Sxsd/ONX1r6thwOeXEgLQlU/xvA9hEkn1Mb7hZ/9c+FBpc0i/l19ybdZCwjUdTgzqwYiB/MN0C7o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkSEtY2ivLlg/cvgk3GmXd9AOh6fGa56DwKyRyzI+E2d8Xu5QK
 QIxt5YkDnYJS1aOEZpKjY/UR36X94LPThp/rt8hbO5EqpHehl1iSGtP9
X-Gm-Gg: AeBDiet8GU+JE+WI/Em0//BZa+OB/frNrn3ckfddCyi1PsD22h96FtuSrbhQ/ZOsjcL
 ijclgyXERXYIgKtiZATq3nbId9okpU76NbAopaqsLW2rUvXlyU/eOPEXPECiPJEQwgO8djTvtcs
 yRNgTGWCiEp1145IrX9XHma5IJ9gP2e9n9J1YodBkkvZ5/9fF2cIu3BHXdUFdGjn7ts1e+Mt0tz
 XFfKb24LauilJE3u3EVRWzOFuHCcXEhrBqnlERswLMx1PVZvK9kQgGDbb3/YZds0wz8dS4Hmvky
 rEuBJhMwJ9oShHHnBFAmja6tZFxwZVYaSy6t31r7xUkfkoHsh2mOWzHyD9IZft70GHO2hPyqA2h
 Tz4ZuzN5GJgHdM2XsnoBQ1z2JH4owhdSU5vC0WkO1pWZXPJtWoXcI2mbHt+XDMyFg9WBzeH3G59
 v/zlinKzRKLk5JkDH3SeGg5K/2qkMMikWxB8D5ndBAhJVerd3kUE7fFbEGWQ==
X-Received: by 2002:a05:6214:4e81:b0:89c:d931:62ee with SMTP id
 6a1803df08f44-8b668922e33mr181752006d6.34.1777955287738; 
 Mon, 04 May 2026 21:28:07 -0700 (PDT)
Received: from 96364762d92a.hsd1.ct.comcast.net ([73.100.172.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm135811266d6.48.2026.05.04.21.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 21:28:07 -0700 (PDT)
From: Dominique Belhachemi <domibel@debian.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Cercueil <paul@crapouillou.net>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: verisilicon: support non-coherent DMA framebuffers
Date: Tue,  5 May 2026 04:26:31 +0000
Message-ID: <20260505042631.1916555-1-domibel@debian.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

Wire up the standard non-coherent path matching the ingenic DRM
driver.

Tested on StarFive JH7110 (VisionFive 2 v1.3B).

Signed-off-by: Dominique Belhachemi <domibel@debian.org>
---
 drivers/gpu/drm/verisilicon/vs_drm.c          | 31 +++++++++++++++++--
 drivers/gpu/drm/verisilicon/vs_drm.h          |  7 +++++
 .../gpu/drm/verisilicon/vs_primary_plane.c    | 11 ++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
index fd259d53f49f..52d8749445df 100644
--- a/drivers/gpu/drm/verisilicon/vs_drm.c
+++ b/drivers/gpu/drm/verisilicon/vs_drm.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/aperture.h>
-#include <linux/dma-mapping.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -49,6 +49,31 @@ static int vs_gem_dumb_create(struct drm_file *file_priv,
 
 DEFINE_DRM_GEM_FOPS(vs_drm_driver_fops);
 
+static struct drm_gem_object *vs_gem_create_object(struct drm_device *drm,
+						   size_t size)
+{
+	struct drm_gem_dma_object *obj;
+
+	obj = kzalloc_obj(*obj);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	obj->map_noncoherent = to_vs_drm_dev(drm)->noncoherent;
+
+	return &obj->base;
+}
+
+static struct drm_framebuffer *
+vs_gem_fb_create(struct drm_device *drm, struct drm_file *file,
+		 const struct drm_format_info *info,
+		 const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (to_vs_drm_dev(drm)->noncoherent)
+		return drm_gem_fb_create_with_dirty(drm, file, info, mode_cmd);
+
+	return drm_gem_fb_create(drm, file, info, mode_cmd);
+}
+
 static const struct drm_driver vs_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
 	.fops			= &vs_drm_driver_fops,
@@ -58,12 +83,13 @@ static const struct drm_driver vs_drm_driver = {
 	.minor	= DRIVER_MINOR,
 
 	/* GEM Operations */
+	.gem_create_object	= vs_gem_create_object,
 	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vs_gem_dumb_create),
 	DRM_FBDEV_DMA_DRIVER_OPS,
 };
 
 static const struct drm_mode_config_funcs vs_mode_config_funcs = {
-	.fb_create		= drm_gem_fb_create,
+	.fb_create		= vs_gem_fb_create,
 	.atomic_check		= drm_atomic_helper_check,
 	.atomic_commit		= drm_atomic_helper_commit,
 };
@@ -98,6 +124,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev)
 
 	drm = &vdrm->base;
 	vdrm->dc = dc;
+	vdrm->noncoherent = !of_dma_is_coherent(dev->of_node);
 	dc->drm_dev = vdrm;
 
 	ret = drmm_mode_config_init(drm);
diff --git a/drivers/gpu/drm/verisilicon/vs_drm.h b/drivers/gpu/drm/verisilicon/vs_drm.h
index 606338206a42..17704cd0df1d 100644
--- a/drivers/gpu/drm/verisilicon/vs_drm.h
+++ b/drivers/gpu/drm/verisilicon/vs_drm.h
@@ -18,8 +18,15 @@ struct vs_drm_dev {
 
 	struct vs_dc *dc;
 	struct vs_crtc *crtcs[VSDC_MAX_OUTPUTS];
+
+	bool noncoherent;
 };
 
+static inline struct vs_drm_dev *to_vs_drm_dev(struct drm_device *drm)
+{
+	return container_of(drm, struct vs_drm_dev, base);
+}
+
 int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev);
 void vs_drm_finalize(struct vs_dc *dc);
 void vs_drm_shutdown_handler(struct vs_dc *dc);
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
index e8fcb5958615..0049737f492b 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_atomic_helper.h>
@@ -16,8 +17,9 @@
 #include <drm/drm_print.h>
 
 #include "vs_crtc.h"
-#include "vs_plane.h"
 #include "vs_dc.h"
+#include "vs_drm.h"
+#include "vs_plane.h"
 #include "vs_primary_plane_regs.h"
 
 static int vs_primary_plane_atomic_check(struct drm_plane *plane,
@@ -86,6 +88,8 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
 static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 					   struct drm_atomic_state *atomic_state)
 {
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(atomic_state,
+									   plane);
 	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
 								       plane);
 	struct drm_framebuffer *fb = state->fb;
@@ -101,6 +105,8 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	drm_fb_dma_sync_non_coherent(plane->dev, old_state, state);
+
 	vcrtc = drm_crtc_to_vs_crtc(crtc);
 	output = vcrtc->id;
 	dc = vcrtc->dc;
@@ -169,5 +175,8 @@ struct drm_plane *vs_primary_plane_init(struct drm_device *drm_dev, struct vs_dc
 
 	drm_plane_helper_add(plane, &vs_primary_plane_helper_funcs);
 
+	if (to_vs_drm_dev(drm_dev)->noncoherent)
+		drm_plane_enable_fb_damage_clips(plane);
+
 	return plane;
 }
-- 
2.53.0

