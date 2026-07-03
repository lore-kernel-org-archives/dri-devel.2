Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04156C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B698B10F6D0;
	Fri,  3 Jul 2026 08:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FyYtATmr";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D73E10F6C5
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:10:25 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so166788f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783066224; x=1783671024; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nSPmWMOnYMh4YzScP5oQHK6zIv+hGpTPzQ1TRS7oZG0=;
 b=FyYtATmrvb31qGd4lncisws01Jrn6qvExVnfw9ltk5bomnkgBW5xQAuAw/QlKauP2X
 qDuZy/ov95hmgK+dvn9iZMlkNEAz/tSOGk9T2EKTLF4/4L6Me7WbyEAQEbJJACBt55EQ
 I0vUB04atIrCuYC89sta/rZDFR5J5n9J78kZV5vnCQQqStCZ30McHRXXuYP8z2sRU9YL
 ldf8fCLQgl7AvV+f8m4bGjUia3wb95X8Fx3e8lOmApByp14vS4JpvkIzzHLypdejeTS+
 FjqOitEsthx8MzqSuOSs58dcTw+Jg20+dZGbYHeo2G8xV37ZNr/mbS5upC/sRWkqRrAX
 nWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066224; x=1783671024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nSPmWMOnYMh4YzScP5oQHK6zIv+hGpTPzQ1TRS7oZG0=;
 b=JX7O2mJi1frrJmT2BCFS7lpHb92wGRYcR+A9V1INMtR37cqEELJzczp/EhOZ0JzX70
 4430ZEpIfjgzPWWSzeOUZhYniFVaYibeoM7JKt6F8/EMyic2nUW+0iVN/ahVQQqlfyvf
 b9MkpiJ8kKc+b3tPcnzNgjmhWyJLSqzJqAV4i+/BULamlOePg7sbIzZmTGFzBNso9cNc
 MFQraX0SpxfBsNtEvK/m0N015qY6mhFNAeqL0x/b474Qtie1ed4yNWoqlkGa9XIIj4Tv
 w8K8UuYVsVkgGkJzVa7+6CbsL0t2fNMB79FYw5dX1Sq+E8ErvvEGSLgSqrq28Kz/eXaQ
 bG/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVlpVVwHGzV3UH/AAo3LmQc82woT6NSPlj18U2ZbMtQS00K34fgknvS+UdZEHTH1jHh0voRtjdFtM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQXFg3FPPtbWFvR7UHp3BPdyrBf4KQGydpt/RbUfbq2Lw6KGmW
 W3WlV2Yf/LoBWuLsqTyaHImM9cuH3loTKTZfbAzNkvbaHpIklACMFGeW9OylfoQgaVk=
X-Gm-Gg: AfdE7cl4hbzZEcA5QvZ3rfmVR05q2/l9voUze0aZc6bYHRu2TMZCTQOFj1quOQ6d2QC
 3gxGkaxvI9oqmpxBe1rQNsxXQ8IH0079umwq3DiE6N7RTkeTuvXA27jsvrk9DzXNiAgJillA+AO
 8A35PwFI+Bv9Eh6QlbsI2L5tUhDBk7QTM58mKi+kbf+4SK8QWtUHSlTXhVR0SSPMTCprDoogUXd
 qkKPEC1/6mup2nDmvSj2+alolhrmt4b1LCfuyZdec36SDpEoq0zg+Y+ZPhcc2fY/3ciShUbm+8M
 KBgcp+CjzuaURyKp6jQejnDBkzdNViZk+tbf/G8RTKyJPEypUN4rB9anSpzhJyvRUQ6z/3B3weV
 vVCH7GqSyqeS1RTMOfWewe0eAewAmQTflLUmsmYdQooX4pCh4WnNbLtj5US2uKTRYTGcaQa7gFV
 37A+4BUEmGQQ9AjvdLL1F4uoA2ids=
X-Received: by 2002:a5d:5f54:0:b0:472:3090:d878 with SMTP id
 ffacd0b85a97d-477571cb785mr13709799f8f.4.1783066223396; 
 Fri, 03 Jul 2026 01:10:23 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a44d7sm14920012f8f.9.2026.07.03.01.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:10:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Jul 2026 10:10:19 +0200
Subject: [PATCH v4 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-topic-sm8x50-vtdr6130-dsc-v4-1-9eff51ec717a@linaro.org>
References: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
In-Reply-To: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8Zw0MXaPsWTl48e5TuYlrhdzoxfYdkEW8De0VsWE2Qc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqR25sF0x/xevRh6INh4UzdIjc3l6Qze2uwMfUqdJ9
 YqnSV3aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakdubAAKCRB33NvayMhJ0V2CEA
 CMCr4BZUhBdFJKI6Z3AXX7a7XNPIrKviWw/ixFpB4bVY8CWzeUDeQiv4XgcZetZxZebT7JULBXu3/I
 Q+dcUQVpVrGBDZeE7RF6EWMYaLvUF7flgoJAJKAbouWL5ELf3URnzT8OUsRKQ6wABz5KvUErdBi6un
 QU4oltuDAaPINQYH1bHu+CcMeTsxUgF6apXh10uPZVyAgRk/Jvk3PBLbn/Hn6Xz03KPfeOW7E4lS52
 WMKM7jv4dr7LwZqC/N8+MX8v4r4ObztuTnrlWprqfVxSLopkISqMzdjEIHc2FshdJZM0UoysP1/xxM
 Y485WKM1zetJU+qdYPx9HqLY3c0lV8WgnSwVjjKIrJNizdXRG9H1AF0jXDRwA/D6dkPW+1nGrcRj7p
 /kvOd1tIoa7C+ArIu1MSqQa+5H8FpxnCDVpLWbX8/hK6cyv3PWuxYCZiJoTF8TcBA+bZ/A1jd7qOSJ
 SyhjMj1An1JQXEXzKEnNd/v9vqJRjn2Sm+3Q6xI1z2tS69eEWuSZP803yb38ruXsFkE3a8pVwIBe+Z
 VLlDRp+A2vTHJ8fLDJmYCKxY5d+Dgzqp4/CRI2jDrjujaFhY0x2Cw46xK9k4KWr8rNJ/L4wazUl/z0
 tskjH2yIrTKE6NjQvlDNYWwrAICabAz3jVK3Aj8jtyYUg0Lsngh3KMwyym0g==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig                   |  2 ++
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index c0cc2bb4a3eb..fd2552203610 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -1352,6 +1352,8 @@ config DRM_PANEL_VISIONOX_VTDR6130
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
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

