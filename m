Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F2C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7467010F25F;
	Thu,  2 Jul 2026 09:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WES8QjeQ";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9C710E478
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:36:14 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-474560436c3so1463343f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782984973; x=1783589773; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GsoHiUWXQIKYIrEcMYDdQBqLZOx1ZPZka28vBGKJZ3E=;
 b=WES8QjeQCCbyWi6CO6Vl+G1Gq6ovVrz9m6JSUJ6fFTw7uxZrgjZTjUxYE7Zm3gkjqp
 g3c8oqjTmdxnzP/1AauTCl8vPtgX01lozoicQ/CzzNrsxenN6abT1Dy6w7yy0v76CJnq
 QrOCRLWVdDB1uJs3dlovX1ncTPKFRxITBZh2Got5sX7B4kK99H5kAZP07gIdMzVf3AU5
 rYGoaYFQUnBkvGDDHo67tkInwoGSjYyLP02ONjMeA2P5oo2lxa5GamTPJ6pIxVu4uWll
 ofkmxEYtoT2uHwKoh7T/j8BMNnl3Emd58cuGUAR4f4/ON4nNc3GHq/NHL9uRQedCoMjE
 y1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782984973; x=1783589773;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GsoHiUWXQIKYIrEcMYDdQBqLZOx1ZPZka28vBGKJZ3E=;
 b=RuNCDQNJWxs4QfoBP6GIvOwScp/LrincMt6HN5TDeNaRPqt3ROwwfsxDorax6DeOpI
 Iwrpn2qvGpteZlDXDg4MGN0aAkTpX8mRnqzeuQFCXzLza+onXRfdGCE8nb8/Um+Cpe2n
 /ljRRj1wvz4wZe3WFzIJjzqm0Kd8kwiAqMKiZTLy0HWBB4zeL3tq657tQPaN3ZhjNxni
 pZlB0sq7kWaeyvmgKlpzSeGOwrd5kjik8psXb3rZYUGi6pVnDzbQVPBSlTux9py71Q0y
 cC1XsoMr/eTuL+rHby4868xSXB1M0EJIUx2HSVStKHCdcj/stcTY+a4J0giN7/gAGe51
 jWiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iTaxVcrKgXj0DLg4/1WZm/k16xPE+wjBl8H+X9NOQjcb6sltn/ySV9tb1yF5GLtMcfLrYLBprJsw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC07pJI6sVSYo8DcXe8c4DfGNIiYGaBv/bbAENxIJRLTxYjy/+
 //mWTsJFLuu9h7Qrfia1H6b8bd5I9Ms9vRYZbU9+TSzgk6OZMTW2KiWo7C/FaLNbnbY=
X-Gm-Gg: AfdE7cng3kMurMYkaNO+yZF62AccxlQIXLJXwNLjhUhU3NsyNSMRyj0iXq9cUVwBU2T
 PTT3Oi84pR9NhNpt83Besld6MQjOlqGYnbyrzXK1qMvR8PpaVy8M2pgD9Vq70xxu/G0MaMrsIOk
 eVeqTvCbKzE8t1l8NScTu1Yg8wBEOKWLOo4WcHNPd+R/pqPg0WklKI26gGQXy6Hf/0y+YxKSyfj
 fOSkDLE62OUPadmtj37Bw0/ASB3CgIrIbzCC2AcshhLF6jkhvVQNbIjKrVrv79QAFbTsENksveD
 0IdlhxRzuHTk2VxwNIFc+zEOIjXXDwSs9V675Ry26IdakKVbm3kSd+0WtwHyqEBRrFxjMFhg77f
 NREQyPffamzdEC8nW5rSuV3e1112IK6QO2gBqOoTenZi3+Im1tZc4k6Z/iUJ1qxhkPUHteT6Yms
 6uK83g0sh4okyRDgrrot4mM7FjerIQ9gp70VRI6C/qV5r7
X-Received: by 2002:a05:600c:c4b7:b0:493:c785:e0d7 with SMTP id
 5b1f17b1804b1-493c785e283mr12795545e9.28.1782984972934; 
 Thu, 02 Jul 2026 02:36:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bf11eba5sm80524765e9.0.2026.07.02.02.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:36:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 Jul 2026 11:36:09 +0200
Subject: [PATCH v3 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-topic-sm8x50-vtdr6130-dsc-v3-1-db881a3fc026@linaro.org>
References: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
In-Reply-To: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3102;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Iiygr+7SLODMDZUD6oHxQRrjVtBJ+/vkm9ffdoYKzEQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqRjEKFnVeUtrCAn0hGIsP6nv7cSZCMDlDMPHtJcWf
 CROgYj+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakYxCgAKCRB33NvayMhJ0QhlEA
 CZVVNg5jWoJv93w1yODqdIao8o7i6EMWpQqyPQNIqzWZS8vCZZtLwVg5x6RQyvIx2WY9UdK5SYPlOk
 n5aSdY3IyFyFSjS41JWeVvws9BIayZEmPtZ2eFh6qdjqP44b5T8fVPgRDfrffZUtclqZmduRMX10Ny
 wmcZMmsGhaVq7rITl+JNrxxekQpJ6YgVa4t8c5WVdrQkpNalz9aWMFfz/COZlFHer/eJVPW9sSE4B/
 FLdZ+zmKJDftRfaXy7XeZ9uSWhT26RlZRqOsuIKX5yWdGPcKcO4u8Un6VmA17gu6gofpHk+peX6UH1
 CxFDcO/RdL9HJ8vDYbnVnonYDrabBt7FkN4bvLU40TpeXhsRnqL54L3tW+E6RhFIm2Qqh5PyuHSVqz
 8LJrndoIu8F1KBaP8xhiBFbJD02tDqcUzgk865wXR0NAoHQHRSEmnyA2KTxbY+484N7ThGMU5A3/P9
 zLCKQRBK4PPCdtgg3g4sN2TtuiGGjSJhbfGo7nG6dzWdiRSis+oxaqtgJQQ2HUh7E+7cdEUij0wOcT
 3opTBa5rgZunlQnfZcsXyiRZ/6FRXO1QiQTXyotnE6tn3j5Pk+cLpDjeTNZMkLpeAWZpDruK0mU26U
 fa1K+zzzN7xEiPkCJG+NarPhEvETtsRVPA7C0NCyHoAKAhX0VpCnXA3eX7sQ==
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
 drivers/gpu/drm/panel/Kconfig                   |  2 ++
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index c0cc2bb4a3eb..d4e6535f3595 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1352,6 +1352,8 @@ config DRM_PANEL_VISIONOX_VTDR6130
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	selecy DRM_DISPLAY_HELPER
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

