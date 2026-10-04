Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B1CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDCC10E1C5;
	Sun,  4 Oct 2026 16:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="frxHeiHH";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0156D10E1C5
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:31:32 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so3809585e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131491; x=1791736291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sLhusyP0ZK9/MPigGSZNdEACXF2TD7fqbQDb9u0lwRw=;
 b=frxHeiHHfOu3pOsAbuA7xrqhQK3hqEvGiWIZQFP9le2+67Bw4uo59LsQMVUmQiNVVk
 EtcmzY7yU0rRUAq39GHCIO4CD0r4NzkClWLSmaFK1WU74XNI9HHeIylLr0NGVJKkds3R
 t0+POm9WAlb8LGU9qd9Ldm+kZ7VLrCtIwEzN11kkWWNKjVYL1/bPuxma5Ia4F99+FeuJ
 yQpuH7hexAnVqbdAQvtgXhxTf35CB9AOs2F87eGKYjkNST2ITmLZ1zSqZBHjdsVMVfgy
 xyV07ZWRyq/fqbYYgz9UACCipJ5MsyWqn9WAfUdVgji8NAplOLM77yNRC8kzSb6dYdMp
 Ogzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131491; x=1791736291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sLhusyP0ZK9/MPigGSZNdEACXF2TD7fqbQDb9u0lwRw=;
 b=sYBZYm12JpQdcF5UHJeUwCAIyxpjYhxD/fA7SaUkpRxFfAdy4zaNZNgiZCAAuvS11Y
 gvZvwAVdVeACiDl6JpmE+yCibr4x3abw5N/HOBMdLds9vvsN5JnESRu4v6MOnEnNIve7
 /KHi7oudtlNz9Y1eAAMo2YnD5aAgtYzQhHHiWvhtPBWTws9q/lNIRCMxpeXb3eG4U6Tr
 U/j+RtiHi8uZ0WrUrjlZly1bxECmfGWYYlDloE4iNoIYRCLdRYe3yVJBGbYphXS9nPV7
 Dmq+07QAkJ7FXxGl4FU82EFj5xJ5D94XFS7vVBe1fsqHwoyoVwGjL0AzMstZcwq2e8iF
 Iueg==
X-Gm-Message-State: AFuF++khsSGzLa1EmbPLcolgbtB2812XHSH7XVcIfaBJfWFF7X3JPbq6
 SjuzEHgk3BbOaskONIImJykTocPXMeQuePpyP4aQfAVco/j30cM3rSTt
X-Gm-Gg: AYBFou1gemcMBPPSj8FGYuW0uHfxmQQsw4bAtNRrJomtJhOYDg7Cp1Z0DjgmGVKFubk
 jq0mU+WVG3binHHBMR00dPhGw1qkVNRs+UeiNnjAD9LrnqRLVrYJAnDfTbWrTaT+vUkNFcTNZeq
 x9NWCp5AFpKnfLndyP6U8w+xDORxywcfStBhIkyBPLSQumVqf+sUbVElUjSXPQ4z4TCKJ0/obrS
 YaoA0GOs2p3hrV/yxRjH0H1Zc96mfs0nTJEoomgkSepoDXGPICnv5QcHNt8RWs4jBLlHMFIQvYg
 WUe4bkPN23UKtQ/MVU58sbl15DkKoQJeYxozufvbAh3AAqJt9o06GCpRjY+kS6sXm8arB5rpJ12
 4m8+SJZ3akYsvV64SdM8AtQluDhTIKZRAt017+ehfcK5y/h1x4o5VrdKXi5NDV0+6PEyAmQ/8DL
 SzvKjp+jY8zodEzSVYdvE6jY+ZhmIELxccRjQBPYE9G5Ue86dZNdiWruRIPm7/MIo5Upu/siU1V
 JNSz/w7B8uGf2kn65o=
X-Received: by 2002:a05:600c:3b05:b0:49e:715d:95ca with SMTP id
 5b1f17b1804b1-4a027561e0fmr137493995e9.13.1791131491320; 
 Sun, 04 Oct 2026 09:31:31 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm315365035e9.1.2026.10.04.09.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:31:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/7] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Sun,  4 Oct 2026 19:31:09 +0300
Message-ID: <20261004163114.181800-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004163114.181800-1-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Parameterize configuration based on bus flags passed from the bridge or
panel. The list of supported flags includes now pixel clock polarity,
display enable (DE) polarity, and data alignment.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/rgb.c | 41 ++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index bc1c93c7554c5..8167447cec900 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -103,14 +104,24 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct tegra_output *output = encoder_to_output(encoder);
 	struct tegra_rgb *rgb = to_rgb(output);
-	u32 value;
+	struct drm_bridge_state *bridge_state;
+	u32 bus_flags, value;
+
+	/* Get but flags from the bridge state. */
+	bridge_state = drm_bridge_get_current_state(output->bridge);
+	if (bridge_state)
+		bus_flags = bridge_state->input_bus_cfg.flags;
+	else
+		bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+			    DRM_BUS_FLAG_DE_HIGH |
+			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;
 
 	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
 
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* configure H- and V-sync signal polarities */
+	/* configure H- and V-sync and pixel clock signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -123,11 +134,31 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	else
 		value &= ~LVS_OUTPUT_POLARITY_LOW;
 
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
+		value &= ~LSC0_OUTPUT_POLARITY_LOW;
+	else
+		value |= LSC0_OUTPUT_POLARITY_LOW;
+
 	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
 
-	/* XXX: parameterize? */
-	value = DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
-		DISP_ORDER_RED_BLUE;
+	/* configure DE signal polarities */
+	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
+		value |= LSPI_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LSPI_OUTPUT_POLARITY_LOW;
+
+	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	/* configure DATA order and alignment */
+	value = DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
+
+	if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
+		value |= DISP_ALIGNMENT_LSB;
+	else
+		value &= ~DISP_ALIGNMENT_LSB;
+
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL);
 
 	tegra_dc_commit(rgb->dc);
-- 
2.53.0

