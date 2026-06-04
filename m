Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76D2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AB9113FD9;
	Thu,  4 Jun 2026 12:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IFi1e072";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2263C113FD6
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:41:41 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so1180542f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780576900; x=1781181700; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G1vgkxcaylBA8azApK5d6CMeHyMeuKB3ssqM3/nYuME=;
 b=IFi1e072OcrgxPVMTFdgr+pS6d7AsqhGZw8h/7iwRrWY+0o3DXwmxuERtzMqDY8mZq
 5hASAlMuKrNFSG/X+QqcfpZUGw1yvLKPVz3WKucQJWCl9HJdf/BQFukbou9+vPFBK05Z
 SfqOxV4h1SkpIq8zTo/BbhhQdp7+UxzF1BWd11MpJHSaxlvyHMUIrMz+gXzoyfGGieJ8
 xDwi4kb3AlKyWBWfnHibw64WN0II6au5otahpM4Nn7QrtnTFPYN5/jo+HvA8SHkqY+5F
 aZFK9sbqFVlgPGsTxUGaYUPU9pT+rqHoUDHKqruVbTxOdWYA7llCTEzmAdcrNQtOxht2
 NMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576900; x=1781181700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G1vgkxcaylBA8azApK5d6CMeHyMeuKB3ssqM3/nYuME=;
 b=PprIxQUyKxy1aGm3zkfnn0p56ZNhf7azY6RfKCR1pWwln6h5Fbgt9BvmBRZ1hcb6z1
 NkMwBKXMOj/r0vMmAlXmH2Mjx+rgQzY35yE+B9gTk4VtNXIhtjzBh/LyPcEioqZLDsU4
 YZX88nN5ESaFaT38CwG8/TtJ+e4KrfFfVtaeJAlmWBrJUz21DJUbm5cytJyjemCCgSzm
 VPrqEifpTJjSNhN45RzVaETpYjEHrfmBXGk/nKUq1jEtVpiRLm6ehF4vbOdY71GZCAom
 SskMrtS0GxHTR+S3JvqoBbUiMM5RMDBFbDbB3ZHn6mxxBktZLnEJiSjUs3FzTmgb06QL
 9hlA==
X-Gm-Message-State: AOJu0YwscYbtmjpJ2ddD/sBqA9qrKWR8HBDoXkGXSpz19OPdKXOdOyLl
 721bI9Bt6aGaDxzk+9mpRmrDdfhlAik/pqOomkPADeIVnQbpqYA91F21GGuf0jBm3Hr2BaTxn8f
 +BOwM
X-Gm-Gg: Acq92OGTfv70z0myo5FN/QmIu9Xr1HH8hiFrA3pbcV/IIdrWPLz9jqtOH80rdvYkSSj
 mytODP7cAB1wH9HPiO1MP58qfcOUh2eezgJCIWE8ZBZbN9jCQ6tLSZ0JpZtG3PsT5fII6QgF/Em
 peLfmXtc+GivlUQVoWTwPMe7BEpoYNiPEiWwFmgmi7e58LTdTHNOL4OtJvLF5OluZGoZj6VpDgN
 Kdz/PAB5yzMNRPNr4bLF7byeNfYL31Hi0gD1j8DfJlGOtW7sYY4YrKaT4J69XRd+5Fu3DQEWGIt
 B3HUnWzXYsfz/F0YhETB9AGmtESsJuvl9I9yil7GWi52LcmvvSmRPqjcIEB3cyEci6dkc/6Fsg4
 BAcP+28iOyz88It7j5gJS12YXly99ESLI8Je9VhKgjxKwACZolVVgnvXbOSpunFoA7TCBKEeR+R
 AKHmtVGAHdTdeWfaeDQDo1tl/WDZc9HVm8edtLGpb5TQ8Fm0og7JbfqRU=
X-Received: by 2002:adf:f1ce:0:b0:45e:f7ae:d599 with SMTP id
 ffacd0b85a97d-460276257eamr3727151f8f.25.1780576899309; 
 Thu, 04 Jun 2026 05:41:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm16242686f8f.25.2026.06.04.05.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:41:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Jun 2026 14:41:35 +0200
Subject: [PATCH 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-topic-sm8x50-vtdr6130-dsc-v1-1-09bcd1dff1fb@linaro.org>
References: <20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org>
In-Reply-To: <20260604-topic-sm8x50-vtdr6130-dsc-v1-0-09bcd1dff1fb@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iGIoz8y1+kxK+14436kxQSVWpsKrM1ada0Tll73iubA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqIXKBXsDigPKaWtmUskWy1IhWMEwjKdo/tOfBeFb4
 bTOVwZ6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaiFygQAKCRB33NvayMhJ0UDMD/
 0ZmDJf+5r63D6HghIWgKgYhGJPXRoxiL1JfJIiDoHdzEj2ncdviZUmB/5gIPHUC6oe3E+3YJ2D/EwE
 hXkvcB/iIFFT5OwzK5XtmbX/9fMtHE2T91GkhBMdVl08UbEREpIVkKKCQj7HhYDCrfw+WGXAhUhp8r
 BgRqxHSSxkTfE6ZQll6ZhA1Qo4A9p8uJcLCVf+fEwlhkbVtoXCqnGqrQjhdhmXxCYsvYzmES0iPAb3
 8nGxOs4fKwID2FLUX6BjZueL4XXPZpJDaxUz1F2u+RARVpvdv0Owoie29LVG/D2u+KCFnoC8VdTgEh
 lDiNoq/UBvz0hueUWReTY8pz3anyqbqlOzBbx/e7BJNiycFodVtpScGtEVIBMo2abnpte0FZLM+Nif
 S00BCs0meSUAtkXNo8CXH9iu8cfvXJReJ9GehwRd9PfcgdbB1vO+zL77w+BoP9NLVQPjRzNIGsFhwM
 wkqPJaJMCKC9SjLaxxzV5/OfJpupjA4xYJNnNfxjXQUoBCndxiQcpvUj6zaKTlwfHUkHMsAtbTkM0p
 Fi//lg5zFLDeiayX/nIWdD1B4njQJcVg6TBIWcyhmd0IVmq/EB7VgM7FTladPh7MbGLjViMm1D3Sqo
 5wW8R2cy8DfrmCbAA8+wy+atJgr6/b6VoWg0b3j3b6rBe3m9RLD8u88Ns92g==
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
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

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

