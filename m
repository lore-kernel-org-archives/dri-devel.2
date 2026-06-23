Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF7BCDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D6110EDDC;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UkKqTIbf";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB2D10EB4F
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:19:55 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so7855383a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782220794; x=1782825594; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yxi/wE47a99ioZKRhiXdNPZKOFUf/VwFzstV1N+fI3o=;
 b=UkKqTIbfW7I74Ca7jiBs5nJsMP5zkxhkUvVMG+vRb+rJPnOjZxrP/52QDidud89HKo
 352w1vacnY9cAQTg8+DFCwJZXAddgrELVpCHuL5EvozLVJI85atLu1EyGqSViJIRyTD9
 B5UKqiaJWT6Fcn0gk3PyG3CBhSZ7qFj+DrJ1KPMAvS6LtH7aaPUmcTlvCVPBZYqK9vvl
 hvnBw3vgvIFLseD0Cc6yZkSagdiGh/siCeHQiC06OPz99yc9eAiUt96GyD0t2ruF/xmi
 dwarx8CCNML545Y7jJr0hKXaYzshZcjcXOREUlCLF1E6F8Z5zusR3HjdxU206ZofIdI5
 CS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220794; x=1782825594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yxi/wE47a99ioZKRhiXdNPZKOFUf/VwFzstV1N+fI3o=;
 b=laurAvsN1j807P6rZQdM1hsXCXT1UGpGuH5oVaB3FIL86DmNXMWwBhx1qFRA+5+Wox
 s8JZfvGYNDknz8jZZ0G+mc9ffOB0Kc46eqpPWCFVONmz6wFtvQ5Eb4svz4n7Rft23ENN
 HVvI2Htnj96M94NO//p3O4Ht4C5Z470y1wWtrPY7hPKFqcafwpgIHKWqXIAQD1w9Fyjp
 +8HQ1VqOUnHXGitJDHTsWTJD0aMbDTWdxvhXkeFazcCsBxTyx26fDA2U7cxa/4K6sJj9
 TQCUZMvn0jjTJrdNCUAmME/2Ctn6NW8d+MGARTiOtdmiM9tqEiSviuwitDgoSZVUT9j4
 FpZA==
X-Gm-Message-State: AOJu0YxuN9Hd00n8rEzuWai+S8rrtGmBXkDZUSLgztSNwMzkUeN3wdwp
 4nC2LBly5G0lzduNsz6Q1hiY78RdtLXVGaC8rq012wgZTS/C8G8SKHG5
X-Gm-Gg: AfdE7cno2BDkbtwUX+pv6MhgVrIH4suN568qr7bHYubVircztMSECMDjPKFDyGOrSMV
 CYaeG2XeYjP2+dJEe0otCfLE2ieroo2baSt/DzIV4SMvvdiWo6Yy2cXt8S6aGDrAR3AhZobOJuK
 pjjsfysg2lfJ6FhJktZXZezW/fuPm1QkKHUs551Jrf8DkpYFUEc7RviG/pru/QLGLxBrnoYXOTt
 KywysbNnc/z3ny3GITs8X9TXPhp5eFHMPDPcT8c2eJfw+mYYJo5xQoAYKraloXqvSwzNdysB6Vv
 uHAYTSby41bt1eXFbVVeZ17porHwkfMElTP3tyfQdiiJV4M/hrvBhI0mWdRwM29teEt5MlqcNuQ
 0syIiT/IHcZolvIUcHOwjY0oXMgqo57PKK+tvhiJqjL0PJybYrZDoA3I1ZDW1i9IZEE/eBTrsKE
 YRJ/LN7elaAnL8K6lu
X-Received: by 2002:a05:6402:3205:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-69711e0602bmr986767a12.23.1782220793768; 
 Tue, 23 Jun 2026 06:19:53 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6977b82f95dsm5060107a12.3.2026.06.23.06.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:19:53 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 23 Jun 2026 15:19:30 +0200
Subject: [PATCH v2 1/2] drm/exynos: Remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-exynos-drm-simple-v2-1-a8d59678b7d2@gmail.com>
References: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
In-Reply-To: <20260623-exynos-drm-simple-v2-0-a8d59678b7d2@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
This patch removes the dependency on drm simple helpers from exynos
DRM drivers.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_dp.c       |  9 +++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c  |  9 +++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c  |  9 +++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c |  9 +++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c     | 10 ++++++++--
 5 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index b80540328150..a2095fb43483 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -24,11 +24,11 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/exynos_drm.h>
 
 #include "exynos_drm_crtc.h"
@@ -79,6 +79,10 @@ static void exynos_dp_nop(struct drm_encoder *encoder)
 	/* do nothing */
 }
 
+static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
 	.mode_set = exynos_dp_mode_set,
 	.enable = exynos_dp_nop,
@@ -95,7 +99,8 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 
 	dp->drm_dev = drm_dev;
 
-	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 0dc36df6ada3..4a3d443a15e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -12,10 +12,10 @@
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include <video/of_videomode.h>
 #include <video/videomode.h>
@@ -140,6 +140,10 @@ static void exynos_dpi_disable(struct drm_encoder *encoder)
 	}
 }
 
+static const struct drm_encoder_funcs exynos_dpi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs exynos_dpi_encoder_helper_funcs = {
 	.mode_set = exynos_dpi_mode_set,
 	.enable = exynos_dpi_enable,
@@ -194,7 +198,8 @@ int exynos_dpi_bind(struct drm_device *dev, struct drm_encoder *encoder)
 {
 	int ret;
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(dev, encoder, &exynos_dpi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	drm_encoder_helper_add(encoder, &exynos_dpi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index c4d098ab7863..25c438cdc744 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -13,7 +13,7 @@
 
 #include <drm/bridge/samsung-dsim.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_drv.h"
@@ -22,6 +22,10 @@ struct exynos_dsi {
 	struct drm_encoder encoder;
 };
 
+static const struct drm_encoder_funcs exynos_drm_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static irqreturn_t exynos_dsi_te_irq_handler(struct samsung_dsim *dsim)
 {
 	struct exynos_dsi *dsi = dsim->priv;
@@ -79,7 +83,8 @@ static int exynos_dsi_bind(struct device *dev, struct device *master, void *data
 	struct drm_device *drm_dev = data;
 	int ret;
 
-	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm_dev, encoder, &exynos_drm_dsi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	ret = exynos_drm_set_possible_crtcs(encoder, EXYNOS_DISPLAY_TYPE_LCD);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 67bbf9b8bc0e..d905dc703c06 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -13,10 +13,10 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/exynos_drm.h>
 
@@ -403,6 +403,10 @@ static void exynos_vidi_disable(struct drm_encoder *encoder)
 {
 }
 
+static const struct drm_encoder_funcs exynos_vidi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs exynos_vidi_encoder_helper_funcs = {
 	.mode_set = exynos_vidi_mode_set,
 	.enable = exynos_vidi_enable,
@@ -445,7 +449,8 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(ctx->crtc);
 	}
 
-	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm_dev, encoder, &exynos_vidi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	drm_encoder_helper_add(encoder, &exynos_vidi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 09b2cabb236f..26baf5357997 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -36,9 +36,9 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "exynos_drm_crtc.h"
 #include "regs-hdmi.h"
@@ -1575,6 +1575,11 @@ static void hdmi_disable(struct drm_encoder *encoder)
 	mutex_unlock(&hdata->mutex);
 }
 
+static const struct drm_encoder_funcs exynos_hdmi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+
 static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_funcs = {
 	.mode_fixup	= hdmi_mode_fixup,
 	.enable		= hdmi_enable,
@@ -1862,7 +1867,8 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	hdata->phy_clk.enable = hdmiphy_clk_enable;
 
-	drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_TMDS);
+	drm_encoder_init(drm_dev, encoder, &exynos_hdmi_encoder_funcs,
+			 DRM_MODE_ENCODER_TMDS, NULL);
 
 	drm_encoder_helper_add(encoder, &exynos_hdmi_encoder_helper_funcs);
 

-- 
2.51.2

