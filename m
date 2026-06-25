Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E22CDE010
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5276610F1DF;
	Thu, 25 Jun 2026 09:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="INTDXSu+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C2B110F1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:33:54 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4924593f45dso23576905e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782380033; x=1782984833; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v8ZTxuqiWcrBCq+pkmtlRNTt1ODfbYB+GmPFMSxFCnM=;
 b=INTDXSu+4qF+q/zbWZKcNctuWjvNPl5SUh7HZOvktsJNuo1MbRNVdvqzL8X1POvzzt
 /qWwEk9PEplEDVbuJbJxO39G1Rdl8ZR1RyW7gXU3OY9FopImu8aUmHbyBN/ewwwa5TEI
 kTFLC40pGwVv71VUxypRbjARLJxUD0UcYQCzELmIigKd3z8XTtIIzj7ThhyEEYw7HrG6
 nMbZqk0i6m7Gz28Z9ZgoTvhcJYJAeFzMrQTlpsOCswhlrWZOqqA6YAxw/dPjHw5YMh5G
 Fu2QFETBviYcIsylvlaa2W6m0oRf/8BCrJjadoKObTxDIL2QU4XSaMuaa48kNYDyduVS
 JJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380033; x=1782984833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v8ZTxuqiWcrBCq+pkmtlRNTt1ODfbYB+GmPFMSxFCnM=;
 b=jKp/X/ZwVDJg3Ny0S8NA+76f+85i2BZFDBe8FF380LUkhDxtvoSubMZLpbHpYJz2nm
 RGWGq7TzGO8nqvr9p2dyOuyNFoyw2sZRGIKJDWn2Pt3ut09ax648rJsnTxbJGCTjmb+E
 OctwAUKwZVM5HC3WWTlhMsSEEgg2F56v1XC62WpPDSPJg8N5spXCb7z7SjHkvdyj+Daa
 RKLUph6AJwXVphLHKqlAZPGuPTsW03BSJ+bW+NUORMUxPpRc3WG0s70uiIjvirdWZUps
 MAwdDncSg99L45MguQmafn1KwMlAGbbuRR9b0yATQQlpeWUp6S+e/cO2lwYaI3oO3clJ
 txtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OXg8tj3guISw3yqHAUfv7rV83N5zbXO/kYEy6AcbP36v/jaq8822pKYd4EfjhTtROJGEEVEQ+i88=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxujNpx76MqL5t7vuomaH16y+hILk1wjC1eZqfbeCa+sjZXL017
 pfSSg73DYl252Txao2u+73/yNNNGbYULLrwCXD5pWQBtMCTw7wfksTJU7jQMoB5dfc0=
X-Gm-Gg: AfdE7clX0KKhMra7Csnz3tNVvIIL6H/X8c+yZANc7rgTgSQj0jaIuyxdaoaWzP7JZGV
 94O5ebnqaoi6QgGZXHtqFNRiZdb//cVHC+xKyVmVq4yav/Eu6NbHHe9VPov3SYNrCr1uoovQt92
 Q20A0r4HbrIolxsjbP+ZkkTE81q05UzHnMzQAf9GQw2ORJl9IbUxMbgvbicHxA3hzozmxRgFkKE
 fjPfcnLvi6tjcLI1fFyRIguPSv6mHwJAt1kiyIAfai/73o98eAur+vqU/Xc1kKIgECDR4o3CWXE
 zZ9rj1QID1FD9SMzdXXuW5+xym6HHeEt/lEB7kez6PzJDcBqNux9RJwlIs6r7dqkwV4sWJx3JE0
 INqbvkefvp0e7Z+59z7dq0hP7gdFuOfaP7CSx2J2+V5MdAOvVj7NnPqW1K+emDv0nRRSZOXzfy/
 RrcKM/eAIYl4gC3feZnffQHUR5vWQR3GGJog==
X-Received: by 2002:a05:600c:4e94:b0:490:c2a2:b1d4 with SMTP id
 5b1f17b1804b1-492668933e5mr20437485e9.35.1782380032604; 
 Thu, 25 Jun 2026 02:33:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660a32ddsm40154745e9.1.2026.06.25.02.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:33:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jun 2026 11:33:48 +0200
Subject: [PATCH v2 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-topic-sm8x50-vtdr6130-dsc-v2-1-cd375ef0e0ce@linaro.org>
References: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
In-Reply-To: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MdVgHdfadA5/GTJS3XHHolJKFzKWuE/Xlx7DIXNZZTw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPPX9WtWjS40eQlA0c7MsvR8Q1VHx24Dh2BNDeUaH
 aP5kNveJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajz1/QAKCRB33NvayMhJ0QMWEA
 C3w4PIWzG3kVzfghLlyl+Nde7cB4FR9J7E3pSyn4QOIBDpgocLlfMsFXY35tCvy0SWWXQZps8BwjVI
 aYIBoQ9wBL5YjSXfHL4s+66ZUWKQ7GMKMQKohWEQXZu4bCVVsrWERQXT3qPsxMkqVxgTGVlEwtLGUw
 IRI5SYo1WENEK+hO/mFKwkctrCi7DuxGIPNpHdO+hopP5BGMMZh1RbNcslVLJK2X7lKGbd4pJ8ExXd
 p3NlR8cPcG9fexi+0t3GaQEtAC7vsN1/fmcoD2T9Cxv7InOxyqO8PtE9snN3y7O97k0a0oftqPtPnW
 /KNzVb6p+5c2o3paYvTHLT2diwEMQBNcpM5UWVDBr7IZUXmlM97ijURtZja1lQr8HDoMWyzm050vXJ
 1sPvMKxVFo+CEy8OHe03q1y2mRRTq3qYbWt3kZpXRgDmlKxZIOQBDaGbOw/WuBvc3u6/DzH3xGnxAD
 2ksplLeZkNPp0iKC5gU7pv92W0NOozj+ET6swbYBzTWMRaiE7ozwQTlL474KACYMs3nz/78n9W33Q6
 Jn0R07yjmtCE0aEAs16we1ngaJ2NQ35R+tWViaQ7n1O/ib9P4oUJI6hVTwnl0iXcZ3t172yrNbM4HC
 74Qn/uPBtUXJLZ53oliBPfKFExU7cKCr4MV7EYWEg13areEIPudR+b7P1i1g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Jun Nie <jun.nie@linaro.org>

Enable display compression (DSC v1.2) for 1080x2400 Visionox
VTDR6130 AMOLED DSI panel.

This panel is the default panel for the following devices:
- SM8550-QRD
- SM8550-HDK
- SM8650-QRD
- SM8650-HDK

Enable DSC since now functional in the MSM/DPU/DSI driver.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig                   |  1 +
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index c0cc2bb4a3eb..298c08f29326 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1352,6 +1352,7 @@ config DRM_PANEL_VISIONOX_VTDR6130
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
 	help
 	  Say Y here if you want to enable support for Visionox
 	  VTDR6130 1080x2400 AMOLED DSI panel.
diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index 97a79411e1ec..0cdcdbbc766d 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
@@ -17,6 +18,7 @@
 
 struct visionox_vtdr6130 {
 	struct drm_panel panel;
+	struct drm_dsc_config dsc;
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
@@ -47,9 +49,12 @@ static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
+	struct drm_dsc_picture_parameter_set pps;
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x01);
+
 	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
@@ -123,6 +128,9 @@ static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 	mipi_dsi_msleep(&dsi_ctx, 20);
 
+	drm_dsc_pps_payload_pack(&pps, dsi->dsc);
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+
 	return dsi_ctx.accum_err;
 }
 
@@ -269,6 +277,16 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
+	ctx->dsc.dsc_version_major = 0x1;
+	ctx->dsc.dsc_version_minor = 0x2;
+	ctx->dsc.slice_height = 40;
+	ctx->dsc.slice_width = 540;
+	ctx->dsc.slice_count = 2;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4;
+	ctx->dsc.block_pred_enable = true;
+
+	dsi->dsc = &ctx->dsc;
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |

-- 
2.34.1

