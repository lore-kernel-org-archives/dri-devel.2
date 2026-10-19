Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D0BCCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2873110E92F;
	Mon, 19 Oct 2026 09:57:45 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F381210E936
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:57:28 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so1335458f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403847; x=1793008647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KXz6d61M5KD13QHimY2yBAnDg5P4a0+gl+DKibpYues=;
 b=OAwbIg6DRTwORWltevPf7AzD8dKtBWdhsBmcy5NCR0RFUpAieiMTjLuq8Aw/koD4HO
 vIHKUwHwF+ur2W/PguKC5N31kbul5VraM4faAoVA1Sns+qiDhfmj/XPclUqWWKrCSN7B
 o7U2V1Q43WDvPYAGHw3tqM35hj4JoDLU7LnXK2LTvOjZc/1798ia7GfOXDYJ1OXvqe2h
 O13ttTlJB/wETdMRWPDCIyf46XoA9sbmW+qYI2mmLy1wR9a/XbfVM7LsbDSDJSZ7NBOx
 USgqXYbcSFKR6BgERFKa8NpnzkssPB2K+32jQQ/Y6iTPhfRdeEMVbHzbEZxDo0cBk5cy
 vPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403847; x=1793008647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KXz6d61M5KD13QHimY2yBAnDg5P4a0+gl+DKibpYues=;
 b=PbRq5zoIwFUTfO+NKOyNwkk0D+IL/k0xkUsoAIjaBc59cJr8HartVZvB4iwCcZYszS
 dzOxFN7KXuC+TGSMRttreRURxd8Oe+gtSO+uaBu5qojBB7oZHwTkoqibVyYoeYHkAbU8
 YRKktNZcrwUiZULJI95WIV5rbGWyu2JWk5+ZrGUp7SfPQgHjY6QPRxtJVaUrn1qP/szH
 RmxdaGBKx63Nh2YWfND24CMvHO1V0vXmuf3VyjC8b42En96M5zBUetwMfpGksYt44OFw
 uqGStwbpDFmurrCXxPNzBjpvyXD4XbIsx3g11dnWH3a7Z0PgCKv/m+skx69acry5r/YX
 du7w==
X-Gm-Message-State: AFq9FYLftcwqxVWuhmTjluybmJFS5XxFbPyRC0+aIvdrTkrUnLXMBEBZ
 nLKOX//tiyDcRDL+g43cmzto5b3HPWVj9HFNv/0TyJmn9Tuu8OYinINN
X-Gm-Gg: AYBFou1NrmpiUzSywFgsKu3f2UfW1QkLlJwT8dsZvIJQly76gJLIAftq1zFN8jOaUf3
 85V4mklgCqJFmjeZ8ygrWuYJUNQovMbY64LOssR5B7+7dHNkbhnJryd/d17mfzygJ/rgJAm5pOl
 rASE2bx5eIBbaoRcizTvBlOmB59pz2ZFAaVhcYnSB45+dLfUVeU4G/i5k1mQY45t0bdWx0KcU8k
 tJaVD2RCbf/rw9m7D8em0Ql/GusV/TaE4Z03nfs/g3OhN8IPps4JSqATv1mYK/o44MLahW35h0s
 boVazcbfs/I7by11sez89HWeIR6Q6t63j7Mf7z9nMnzCXY+rEelsZ+RuS4DWXqWb4gBYlHUcfJE
 9MV3DKElEASywwFPGGWnOaDl73VoggSD04xgpuL9A5xU7+wE20WCJgqzgovbxPTBkP7SEqAcOVb
 JdSowLNoOIZJor81AWZ5Z2vn2yhBcdBHcK2qDU4trnjrp+fh4L2QXE7bokfaN+voFreXPHzem+f
 KhUKGT/UM9SR0cWbGk=
X-Received: by 2002:a05:6000:22ca:b0:48e:d57:9bad with SMTP id
 ffacd0b85a97d-48e1afe328bmr362780f8f.3.1792403847147; 
 Mon, 19 Oct 2026 02:57:27 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm21740089f8f.42.2026.10.19.02.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:57:26 -0700 (PDT)
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
Subject: [PATCH v3 2/7] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Mon, 19 Oct 2026 12:57:00 +0300
Message-ID: <20261019095705.91062-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019095705.91062-1-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
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
index b6d09a8d8e5ea..da9e37fe36689 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -104,14 +105,24 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
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
+		bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+			    DRM_BUS_FLAG_DE_HIGH |
+			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;
 
 	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
 
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* configure H- and V-sync signal polarities */
+	/* configure H- and V-sync and pixel clock signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -124,11 +135,31 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
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

