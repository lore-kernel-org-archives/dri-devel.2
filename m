Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB82CDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D3A10EDE0;
	Wed, 24 Jun 2026 07:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oy3x+wEl";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673A310EC97
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:34:55 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso3222595e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782246894; x=1782851694; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5t3Yym7TNcn23mBBw6H+IPIGFaMcwRdXEZmNa7/R0B4=;
 b=oy3x+wElVO/IAN7ZXee5iwzWmc7pWBIk+sR5X5RyoD1TTeF2kJt0W7q/2OSXcNXb4k
 VHHMigEYNSWBhebcBVuiTNA7kKfP5agY7ZH3gvYOrDfPAAIJs5MD3JvtmH2MFaQndvTN
 vWT2xrH9iEoHVNGMDPwNj+I/C2PJhP//J8DuxeSGAmXHC+uM6UvxCBAg7629Hlj30HLD
 BXQnX/p7/Qvt6WnYn/+BnUGwDCmIEytbpo4FheLgYnYL752RFXChK0l3xjyxip7x4+nz
 oVo0LUqpoyi7pfd6gURK1HUs+vdgscuu8MfcsBqYGCHcgKY+yMlx83+pRwWLW8rKC8/x
 hOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782246894; x=1782851694;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t3Yym7TNcn23mBBw6H+IPIGFaMcwRdXEZmNa7/R0B4=;
 b=Kc/5wZzqKD1n+32Ck6iblib+O03RErE9yw3TFM/IKUuOva/CYqN074EOOQF9vNEQgO
 J21t7kWSjyRMVb1h0ckRO7fgh+BvMl0hz5XznZ7DnvIf13qlSgnac0E4x01CjkXE0cKG
 e12q1Jd6Fzw3A+PaMGO7LzJwpJoYFxzoTuRpUZihSvJVYpuMRhNgl6+kpmFvIeqQCUoj
 u2zpsd5XHTTU78+RZ5EjHmNPBsiKwEDJu4eS3na+t2Sx2r1DWmXiOnwxRnOWbSjP2Ph1
 +qwcHeUnoVsN/zTi+snlJAuE8dcL2f8TEHLSghVI7KDGcX/2/mn18GjlR1QgfAXn+psg
 bH5Q==
X-Gm-Message-State: AOJu0Yw0T/Q4hvEZVR8tPd+VjJ3kkuebnwMSEscwtN3SW8yIE2sQYe04
 7i2is8vkj/6/KX3xfBboJEF021QkBK/rGzXcisMd05YfNnej3pXWDVW0
X-Gm-Gg: AfdE7cmjx3TD/0oCuTioufxvPKr9WjpXseekwlSSD/qLuSsS8tiWSfGQHZZDwXABok6
 12o3h0PGkH/NRs1Pi+r3je6OIl9ZxkF/uB9SOFkQa6wAppDJBjOTvqoGtzKyCSKHux5nkXAWkGJ
 NbwFXI0fjHJ9KquA7Op8juNcCQkz1oHqPhEuzJA8zSqcpc5dKv1iJgJXVZUlJ0CM0e94ebsQn5i
 64S4Ez/3ruLHvTmU3EhtGgxQuxnQBgY8xzjoPxDjaFpf7hmfRHAWPqQyRIqe3wGgOl8Dmr3krRQ
 Tzkusx7LvjlOQjFvWZ6CCaJU9bO9DQDW4qyZYd8iycNRPio1VNYshyrOZleAYvAug+/y1aSJgvo
 yD7uIh8uge0KHbJ8bX55+Esa2kfI7MFsgo1cppf/KG6WJlucVL3OTEBt2T8Fs4acX+v9gj2Co5g
 DFHb2mS1ukqRBy3b2rZa/n
X-Received: by 2002:a05:600c:34c2:b0:492:465a:7e5b with SMTP id
 5b1f17b1804b1-4926087371bmr2714075e9.22.1782246893690; 
 Tue, 23 Jun 2026 13:34:53 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd154fdsm374613865e9.1.2026.06.23.13.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 13:34:53 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 22:34:40 +0200
Subject: [PATCH] drm/sun4i: Remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-sun4i_simple-v1-1-fa6696df1fad@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN/tOmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNj3eLSPJPM+OLM3IKcVF0j02QzCwsL01RjU0sloJaCotS0zAqwcdG
 xtbUAyL0mhF4AAAA=
X-Change-ID: 20260623-sun4i_simple-25c68885e359
To: Chen-Yu Tsai <wens@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

Simple KMS helper are deprecated since they only add an intermediate
layer between drivers and the atomic modesetting.
This patch removes the dependency on drm simple helpers from sun4i
DRM drivers.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c |  9 ++++++---
 drivers/gpu/drm/sun4i/sun4i_lvds.c     | 10 +++++++---
 drivers/gpu/drm/sun4i/sun4i_rgb.c      | 10 +++++++---
 drivers/gpu/drm/sun4i/sun4i_tv.c       | 10 +++++++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 +++++++---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  |  8 ++++++--
 6 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 8f64464621c9..e99f52ebb26f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -24,7 +24,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
@@ -172,6 +171,10 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder,
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
 }
 
+static const struct drm_encoder_funcs sun4i_hdmi_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs sun4i_hdmi_helper_funcs = {
 	.atomic_disable	= sun4i_hdmi_disable,
 	.atomic_enable	= sun4i_hdmi_enable,
@@ -624,8 +627,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&hdmi->encoder,
 			       &sun4i_hdmi_helper_funcs);
-	ret = drm_simple_encoder_init(drm, &hdmi->encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(drm, &hdmi->encoder, &sun4i_hdmi_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the HDMI encoder\n");
 		goto err_put_ddc_i2c;
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 6716e895ae8a..35a3f987c37a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -8,11 +8,11 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -89,6 +89,10 @@ static void sun4i_lvds_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
+static const struct drm_encoder_funcs sun4i_lvds_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs sun4i_lvds_enc_helper_funcs = {
 	.disable	= sun4i_lvds_encoder_disable,
 	.enable		= sun4i_lvds_encoder_enable,
@@ -115,8 +119,8 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 
 	drm_encoder_helper_add(&lvds->encoder,
 			       &sun4i_lvds_enc_helper_funcs);
-	ret = drm_simple_encoder_init(drm, &lvds->encoder,
-				      DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(drm, &lvds->encoder, &sun4i_lvds_enc_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialise the lvds encoder\n");
 		goto err_out;
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index dfb6acc42f02..9c3fbf1b949e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -10,11 +10,11 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -180,6 +180,10 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
+static const struct drm_encoder_funcs sun4i_rgb_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
@@ -207,8 +211,8 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
-	ret = drm_simple_encoder_init(drm, &rgb->encoder,
-				      DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(drm, &rgb->encoder, &sun4i_rgb_enc_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialise the rgb encoder\n");
 		goto err_out;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 814b77f278f6..ce22f1662c0c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -16,11 +16,11 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_drv.h"
@@ -391,6 +391,10 @@ static void sun4i_tv_enable(struct drm_encoder *encoder,
 			   SUN4I_TVE_EN_ENABLE);
 }
 
+static const struct drm_encoder_funcs sun4i_tv_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
 	.atomic_disable	= sun4i_tv_disable,
 	.atomic_enable	= sun4i_tv_enable,
@@ -474,8 +478,8 @@ static int sun4i_tv_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&tv->encoder,
 			       &sun4i_tv_helper_funcs);
-	ret = drm_simple_encoder_init(drm, &tv->encoder,
-				      DRM_MODE_ENCODER_TVDAC);
+	ret = drm_encoder_init(drm, &tv->encoder, &sun4i_tv_funcs,
+			       DRM_MODE_ENCODER_TVDAC, NULL);
 	if (ret) {
 		dev_err(dev, "Couldn't initialise the TV encoder\n");
 		goto err_disable_clk;
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c35b70d83e53..f0c9f0e573d2 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -20,11 +20,11 @@
 #include <linux/slab.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "sun4i_crtc.h"
 #include "sun4i_tcon.h"
@@ -842,6 +842,10 @@ static const struct drm_connector_funcs sun6i_dsi_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
+static const struct drm_encoder_funcs sun6i_dsi_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs sun6i_dsi_enc_helper_funcs = {
 	.disable	= sun6i_dsi_encoder_disable,
 	.enable		= sun6i_dsi_encoder_enable,
@@ -1056,8 +1060,8 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
-	ret = drm_simple_encoder_init(drm, &dsi->encoder,
-				      DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm, &dsi->encoder, &sun6i_dsi_enc_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(dsi->dev, "Couldn't initialise the DSI encoder\n");
 		return ret;
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 96532709c2a7..9694ad142a7d 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -9,8 +9,8 @@
 #include <linux/platform_device.h>
 
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "sun8i_dw_hdmi.h"
 #include "sun8i_tcon_top.h"
@@ -23,6 +23,9 @@ static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 
 	clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
 }
+static const struct drm_encoder_funcs sun8i_dw_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
 
 static const struct drm_encoder_helper_funcs
 sun8i_dw_hdmi_encoder_helper_funcs = {
@@ -180,7 +183,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_clk_tmds;
 
 	drm_encoder_helper_add(encoder, &sun8i_dw_hdmi_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, encoder, &sun8i_dw_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	plat_data->mode_valid = hdmi->quirks->mode_valid;
 	plat_data->use_drm_infoframe = hdmi->quirks->use_drm_infoframe;

---
base-commit: e2a6e04d045a56c6dc61e1eb9e2a6d7cf86512cd
change-id: 20260623-sun4i_simple-25c68885e359

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

