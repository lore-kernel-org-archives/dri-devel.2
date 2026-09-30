Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA9CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD2B10F1F1;
	Wed, 30 Sep 2026 07:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUrlilz6";
	dkim-atps=neutral
Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com
 [74.125.225.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7806310F1E1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:06:00 +0000 (UTC)
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-482f6351831so2900404f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751959; x=1791356759; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvheFf3XK3bdnPCaCOmKnThnJ8pBY5xBPxq0xunjLCk=;
 b=ZUrlilz6qotFKGIELMVzOMr5X7frTrkhw9oN6xEPQ/WEXT8ar4J5pUjiyOodX+3U61
 Els+fUUzidBJUOX9qdFMxs0gXtZOwJ1oxzZJdtI/GMePVG/zrW4oWEXKlgfTUK4kvPsR
 RDTrTVDELjcUKGhJFlLcwnrIz/Jx7vUNQ6vR32GvOACKz09iXtnf0273V4Mzbw0lRWmY
 frhq0NW4EUSlNLvkohJLm8WuGFnA2AT3FV6QwbLMHKtYbUa9i1aJZKWKpPgJNXil/qGf
 gAEkzOzIyC7fhhGEKh/dmgXBgDhA7uwPMP+w6w2zHdmnL+C/o+jz3tMCOWAZlsmA38i2
 jkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751959; x=1791356759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CvheFf3XK3bdnPCaCOmKnThnJ8pBY5xBPxq0xunjLCk=;
 b=cqAmpnokjOUe1Imv/CZXWDOPCX3iz9W5c9Ms5364KrGuqmln8F3q1GHVqPoy+hcE+P
 zLzWrCSXfzjP1niF+rK+gJBuZ9AX2fmTNHIB/uObK4WevwPav0YZ+UE8ydMU8twRCbmO
 Ko+YSitPWUu7ZGxrbBX69aJwFWPmInyhjCbAORSapwoqTKct7ItxlLjDZBSHuYJS/KXE
 pX3dDB/omoYqkiPiCcLMC0ZB1SsBYaP+sGZbHXRJZnnQUZNCCHw5AeriGq8tBiKujyId
 01vr4EJGbX7ICRQD/7oPxqj7hAL5HneZ3+z8zvFOAlw2OXdyGEWHiQ3DLZM3Qka/8kgG
 GP8w==
X-Gm-Message-State: AFq9FYLHYjiGohdMGJ+LPcPLqvlrZZvG9vBcloo+yfi1yNQDKU8DCGxH
 W3FLteGTdORbiu19eovUo33b8O3M79eI1sZarM1Jqp0gRWRyz3QwpCYu
X-Gm-Gg: AYBFou2eOkTM8KngXZKEg9eC+WTjsIaoYJpSHPTZTNzXVkWqWdaBDZ1vM/GScAtxEaf
 GUEpg8EIH5WUDF1UwqEC93nRgwBwkG7oQI0wHIlYWkA1EWWM6uSFs6SaEUK41KF3Nml0L5DqNkV
 joPO7iHihS0B02pBW4m/b4jCXh/1KPceZzZfGokehE0BoTJJY+CA9vz4S/s6tjuh0sexAY69H4c
 7Pra9NECGOQxz8XDpkDeM6vAiP/FuSgOP+Ybg+9lJFv5apCxabb8FFEUVYdsvv02caeaEtbk8Ak
 bo5uiPv2wGNSIEHH1r00vBd54l/+/FBxLnG9l8gHneusIcH+8b3i8N52SKDdBxzRlWTZwQMv4TI
 Sh0CPJQ2bDZLCSlpeNWl7V+21VUIg2DfHLMId4oKPHxYsVn2c0mV8BjamALEeEE7hSf8o8GpZZt
 y64ZK/cXaFpnBAw8dS/7eVnBICgNAenNNGkmziptcqHq/Ax98MGVnh19Ta7RNh/mXMCGrDe2Tb+
 zU2VrkXmzgoUXSl+x/ynb2qsU41pA==
X-Received: by 2002:adf:e00d:0:20b0:488:89ad:56c0 with SMTP id
 ffacd0b85a97d-48b03c72c0amr13090f8f.11.1790751958677; 
 Wed, 30 Sep 2026 00:05:58 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:05:57 -0700 (PDT)
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
Subject: [PATCH v1 2/6] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Wed, 30 Sep 2026 10:05:31 +0300
Message-ID: <20260930070535.47130-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070535.47130-1-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
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
 drivers/gpu/drm/tegra/rgb.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index bc1c93c7554c5..e72e076b13d5f 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -103,14 +104,19 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct tegra_output *output = encoder_to_output(encoder);
 	struct tegra_rgb *rgb = to_rgb(output);
-	u32 value;
+	struct drm_bridge_state *bridge_state;
+	u32 bus_flags, value;
+
+	/* Get but flags from the bridge state. */
+	bridge_state = drm_bridge_get_current_state(output->bridge);
+	bus_flags = bridge_state->input_bus_cfg.flags;
 
 	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
 
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* configure H- and V-sync signal polarities */
+	/* configure H- and V-sync and pixel clock signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -123,11 +129,31 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
 	else
 		value &= ~LVS_OUTPUT_POLARITY_LOW;
 
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE)
+		value |= LSC0_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LSC0_OUTPUT_POLARITY_LOW;
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

