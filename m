Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C491CD8C8E
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5597710EA72;
	Sun,  7 Jun 2026 14:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cxBnkwzN";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E386710EA29
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 12:38:25 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso1822130f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 05:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780835904; x=1781440704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGJmTaj0v3fyny/5gzBI1fPt8RN2g4o65vx0LjqktFk=;
 b=cxBnkwzNTJNWrmC9sOMis/yvdLHIikHWt5cqrx+yFAdOIIUK/JywMc2PyKXwEavDtx
 kG4WnBqux/cXDOo2f+BSKaIuJZEkzpE0SS8sy3kvAOSbcAJ9BILx9/By0O5Gm3p/o6Ym
 Fem3h6eg6Migw8y7QwZ3X/M7K+LcF8u/X93l0lSxoML8q6JhKtvEqyTi1K+qVOAZv67M
 QJ9rKHICC/y1SSdnRfTuJzWQdaAowC12iOrQVU4/OmAKxCzRv/MGQES94GKkT50E7qfx
 /5MsiugthzJuOMwM4K5p2UF6mESdAlTAVQ288C7ML/G3m0rTS3E2QIpMnwvz5O5SoheK
 d52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780835904; x=1781440704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MGJmTaj0v3fyny/5gzBI1fPt8RN2g4o65vx0LjqktFk=;
 b=gwaQJ94kzM8vJ/glg4IeJU5DOXmfPmssRLGFRmbICxtW1hhfklc0wmpy2pVhVrukUW
 WLOr2qTjVjmCDnNt6EJ2vl6kjv0r6/6133pF6lsdb/n/iS+1arM7NUaHI6OO/S/F7GLm
 d+mZgObe7yfJNmvl3Jn/jmeQtlIFYRnm3zqH6G7yuQruBdLTP4NFL1CuHoYZ3C6tPs87
 cquvXq6NY6PcUVOTCEQZfqnWAG4NrZO2ib0jsoA5BdXVqlr0NnojZzPfN2mFr+ESzdqJ
 EZgclnr0KGPBQPIxfUH17QUZHJ/DycTnusdzV0TpnMaKKtdoxTqSvriZP+A/SCKiQClQ
 YeDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+++XjEoveRRDVA3yHUp2RCsOQb0E610FGl4ysUuFRP/44dj693acfZtv7lmm3uKeCFiC7q60S6OFI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyoi9tEf2GxyThURXXzk7T8zbZy96yTYBNwo1R7+K8sye74roHi
 ycy9L6yw6bIESMGmXORJQii2vljXlnhe1e3TsTAf2utzGozUWRpzR6yf
X-Gm-Gg: Acq92OGmnojfWys41zdSMkglhqwNxkMCWvv20c3QKZUB7BKesaBe879WISmN+RFvze+
 3H1S9U/ppi/+NUMCDjM78JSQRfoxGe1EnzAmIDraxdnJJJPirgXtUCNvH4S3k0Nr00lO7jdtZMd
 FiJW61+BGWF9D3gw7cbH77mprJT82ePuhEM67cohYpQpk2OPsUi26szG0bVo0+7gDkDoWjvmVGW
 vVj8hqFN6cit1U3Yzq2e3Thmqsk1Ly+lblt68Wx+T3kY8pirdRrXnTVi7keX3OgykhYJJTYNz6J
 rOttiL6JJCGsktD0MgpIUjSMhTQjmwaWq/FtqYqAysvoTCqOS/yPOW8NuyqVXwGg4jLXmkLuRsw
 Ys7gMyy5b3xQMq1CEXFruOllpNb3guFh7EnWgW5prK46IZ1EWTvwubG9x30vLFhFpXQxQSTQhdK
 CED7fVBDFFfGqhndm9mTsvhkLYgrbTgX7dRrsHLuyy956qaaTU3gdvZlgc4XL/lL1tvZ9CgPFEb
 w==
X-Received: by 2002:a5d:4f11:0:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-460304fdf18mr12781534f8f.20.1780835904234; 
 Sun, 07 Jun 2026 05:38:24 -0700 (PDT)
Received: from tiolaptop.tail72d7bd.ts.net ([194.35.121.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344558sm42201706f8f.18.2026.06.07.05.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 05:38:23 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
To: heiko@sntech.de
Cc: airlied@gmail.com, andy.yan@rock-chips.com, diogompaissilva@gmail.com,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: [PATCH v2] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
Date: Sun,  7 Jun 2026 14:37:40 +0200
Message-ID: <20260607123739.393974-2-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <5277524.h16uAIiOU7@phil>
References: <5277524.h16uAIiOU7@phil>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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
This patch removes the dependency on drm_simple_encoder_init from rockchip
DRM drivers by inlining this helper.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c  | 9 ++++++---
 drivers/gpu/drm/rockchip/cdn-dp-core.c           | 9 ++++++---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c  | 9 +++++++--
 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 8 ++++++--
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c      | 8 ++++++--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c   | 8 ++++++--
 drivers/gpu/drm/rockchip/rk3066_hdmi.c           | 8 ++++++--
 drivers/gpu/drm/rockchip/rockchip_lvds.c         | 9 +++++++--
 drivers/gpu/drm/rockchip/rockchip_rgb.c          | 8 ++++++--
 9 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 96bd3dd239d2..ca6701319f2f 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -30,7 +30,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -317,6 +316,10 @@ rockchip_dp_drm_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs rockchip_dp_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs rockchip_dp_encoder_helper_funcs = {
 	.mode_fixup = rockchip_dp_drm_encoder_mode_fixup,
 	.mode_set = rockchip_dp_drm_encoder_mode_set,
@@ -369,8 +372,8 @@ static int rockchip_dp_drm_create_encoder(struct rockchip_dp_device *dp)
 							     dev->of_node);
 	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_dp_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		DRM_ERROR("failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..060ffca1f3d8 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -23,7 +23,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
@@ -671,6 +670,10 @@ static int cdn_dp_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs cdn_dp_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs cdn_dp_encoder_helper_funcs = {
 	.atomic_check = cdn_dp_encoder_atomic_check,
 };
@@ -988,8 +991,8 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 							     dev->of_node);
 	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder,
-				      DRM_MODE_ENCODER_TMDS);
+	ret = drm_encoder_init(drm_dev, encoder, &cdn_dp_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS, NULL);
 	if (ret) {
 		DRM_ERROR("failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d3..a09b382d208e 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -25,7 +25,6 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -825,6 +824,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
 	clk_disable_unprepare(dsi->grf_clk);
 }
 
+static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 dw_mipi_dsi_encoder_helper_funcs = {
 	.atomic_check = dw_mipi_dsi_encoder_atomic_check,
@@ -840,7 +843,9 @@ static int rockchip_dsi_drm_create_encoder(struct dw_mipi_dsi_rockchip *dsi,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dsi->dev->of_node);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm_dev, encoder,
+				&dw_mipi_dsi_encoder_funcs,
+				DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index 0aea764e29b2..687afc5590cd 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -23,7 +23,6 @@
 #include <drm/bridge/dw_mipi_dsi2.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include <uapi/linux/videodev2.h>
 
@@ -275,6 +274,10 @@ dw_mipi_dsi2_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs dw_mipi_dsi2_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs
 dw_mipi_dsi2_encoder_helper_funcs = {
 	.atomic_enable = dw_mipi_dsi2_encoder_atomic_enable,
@@ -290,7 +293,8 @@ static int rockchip_dsi2_drm_create_encoder(struct dw_mipi_dsi2_rockchip *dsi2,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dsi2->dev->of_node);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm_dev, encoder, &dw_mipi_dsi2_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(dsi2->dev, "Failed to initialize encoder with drm\n");
 		return ret;
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0dc1eb5d2ae3..906264d65db3 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -16,7 +16,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -322,6 +321,10 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
+	.destroy    = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
 	.mode_fixup = dw_hdmi_rockchip_encoder_mode_fixup,
 	.mode_set   = dw_hdmi_rockchip_encoder_mode_set,
@@ -604,7 +607,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	}
 
 	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	platform_set_drvdata(pdev, hdmi);
 
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 1a09bcc96c3e..ed665352618f 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -23,7 +23,6 @@
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 
@@ -160,6 +159,10 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 	return ret;
 }
 
+static const struct drm_encoder_funcs dw_hdmi_qp_rockchip_encoder_funcs = {
+	.destroy	= drm_encoder_cleanup,
+};
+
 static const struct
 drm_encoder_helper_funcs dw_hdmi_qp_rockchip_encoder_helper_funcs = {
 	.enable		= dw_hdmi_qp_rockchip_encoder_enable,
@@ -586,7 +589,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 
 	drm_encoder_helper_add(encoder, &dw_hdmi_qp_rockchip_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, encoder, &dw_hdmi_qp_rockchip_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	platform_set_drvdata(pdev, hdmi);
 
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 9066ee2d1dff..a21df6f380f5 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -12,7 +12,6 @@
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
@@ -454,6 +453,10 @@ rk3066_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs rk3066_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rk3066_hdmi_encoder_helper_funcs = {
 	.atomic_check   = rk3066_hdmi_encoder_atomic_check,
@@ -696,7 +699,8 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 		return -EPROBE_DEFER;
 
 	drm_encoder_helper_add(encoder, &rk3066_hdmi_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm, encoder, &rk3066_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.funcs = &rk3066_hdmi_bridge_funcs;
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 75f898a10cbc..c3b30c622873 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -24,7 +24,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_lvds.h"
@@ -427,6 +426,10 @@ static void px30_lvds_encoder_disable(struct drm_encoder *encoder)
 	drm_panel_unprepare(lvds->panel);
 }
 
+static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rk3288_lvds_encoder_helper_funcs = {
 	.enable = rk3288_lvds_encoder_enable,
@@ -594,7 +597,9 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
 							     dev->of_node);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(drm_dev, encoder,
+				      &rockchip_lvds_encoder_funcs,
+				      DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret < 0) {
 		drm_err(drm_dev,
 			"failed to initialize encoder: %d\n", ret);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 5c0c6e2cc28d..b5b8322a1260 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -17,7 +17,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_rgb.h"
@@ -65,6 +64,10 @@ rockchip_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const
 struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
 	.atomic_check = rockchip_rgb_encoder_atomic_check,
@@ -127,7 +130,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	encoder = &rgb->encoder.encoder;
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize encoder: %d\n", ret);
-- 
2.51.2

