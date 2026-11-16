Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4ED606A335
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nMHsD+SD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F6D10F167;
	Mon, 16 Nov 2026 15:11:09 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A1310F04F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:54 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so470079666b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841852; x=1795446652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3z6P0aYlufuvnlooWGHkbmG4E1HPBYeLov8HTyHzM/I=;
 b=nMHsD+SDaJb9+D2zo1s+hOPnAKd1aZnzQ1nLjOX3kySijNQ6aIlSpEhZtQL+e6XYJD
 ueNGb+NoiQ9ybFIglsTNjAuV/S4KayaIyT2W1eiSboip3JasFjIT9goi9oq8kdtrQJ5t
 7Uezlk43HPBXgBk3fj3NmviRfnoPZ3aknSqJ8YQtR0R/WEViIZCjbyyZkbcBUsSPfwNL
 1uYUMXPDwOTWeL3f4sUGxMxzeDBkl3VU0zszgmtG2CM4MIsmfeWBt9IP5o2dKskglMvf
 Uv4+mvrljKkOXMd2jkt0vf2S2uUEwr4Zae4UgspZpSf9lNXDur2Kd68Vhbw0wZHreJSZ
 znKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841852; x=1795446652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3z6P0aYlufuvnlooWGHkbmG4E1HPBYeLov8HTyHzM/I=;
 b=aS6KIVlwgFXl2EOEy6ZTcVaYn/GZ25xvt7bl04uEqhg+aJAardDa1mbcN60QAEDWLl
 lZ4N3GZnDf2bsq1O1l+eo3+XTlZk4PmFkkwLJf3WwmK7bJtm37+TP04Orvq1QzgMrX+s
 LxqlQTP5mC7BSNDhIXDTHNmn2K0h5+88KuaZ5M9b9xg/2+Bc+4kz4NFlSz98Y3Tm4oYc
 uRQ+8Cbn4sVUoFiGhFXWw3Raz43glmDAYUU1QpXiVivSQzufDIBwfMjqKfBOgerNB+Fy
 FqZSIgmrR9hqVsHh3yCu6JGy7SwnFSyp0MS6mXcBHaqPQO8hngsp919U7kGimnT4OGlw
 laKg==
X-Gm-Message-State: APuU4Z8p88y58g5LofHEE7DuUqdBbJXjYWvZc57h8ZxpIt0wvgwSm7Sy
 V+voGkTIPII/yHfycbhOd/S2xETTUELnMnJ/AQYN7KUclVpgA0HGp6Fd
X-Gm-Gg: AYBFou3VqHuWdOXx54Ky8oDIP0slRp17/qSL//09LmYpPpwNz6x8qPYxAOAJePcRpq3
 HSmqKVsBfv1L2bICoZxr8upTOPRJtcLFe+6Ok96n7yT/Eyyy9lss8h7R/tsCq+FrmBvVFY773Uo
 JIYvIepsXtCTsTXRsjku4HNMAWIhJf2G/qvjAKdAnv0HIid+79YyC2ECe37oyh2BW32ngszLfSI
 PmyEJ6OKjjo+I4url77wcUQ0I1EvPssEGje6AcpnTcdQoXcAvdmDUmH0BXIkmL9/sZ8834F2GeO
 KnM/LhDePsi9VMnRDlR2HyKLO7EqgpUEumzKuSuPspvO/8GlonDmyEKNbRNpjHiSyV+eDeSqkti
 AYV2BXpC+rCOD9OwlhS5bPYFdivaQ0d5zkI9u5EZUmSmh8MVWzOjcFmujDmU3VuHje+B/70mK36
 utEHcZoJ3fWtHbz5WGVU1bj1O84WqPA+Byq9+Ua7QUVymJSSQaouPSK5tx7M1TV6HzEUg7lID1b
 NAJhjJq7Su9Gnm31s7NhZ/Z2Z34NhaG5A82kigLMNUkTb/oTIGElI65Bhh4LUx+iMkID2KcK8dT
 WmLVOTsIkjU4XokrITYSMo8dpsYsICvsQq5T9ws+rM7Zd7zzNb9RlGK3vyrh/HpZ/r2A3EWGpL8
 aRahNJ+m0Dw==
X-Received: by 2002:a17:907:3ccc:b0:c49:a235:8e0c with SMTP id
 a640c23a62f3a-c509637e31dmr872386066b.22.1794841852361; 
 Mon, 16 Nov 2026 07:10:52 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Mon, 16 Nov 2026 17:10:15 +0200
Message-ID: <20261116151017.274764-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116151017.274764-1-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Parameterize configuration based on bus flags passed from the bridge or
panel. The list of supported flags includes now pixel clock polarity,
display enable (DE) polarity, and data alignment.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index d48d498068ac8..faecd6f94359f 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/media-bus-format.h>
 #include <linux/of.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	struct tegra_output *output = encoder_to_output(encoder);
 	struct tegra_rgb *rgb = to_rgb(output);
 	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
 	struct drm_display_mode *mode;
@@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
 	mode = &crtc_state->adjusted_mode;
 
+	/* Get but flags from the bridge state. */
+	bridge_state = drm_atomic_get_new_bridge_state(state, output->bridge);
+	if (bridge_state)
+		bus_flags = bridge_state->input_bus_cfg.flags;
+	else
+		bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+			    DRM_BUS_FLAG_DE_HIGH |
+			    DRM_BUS_FLAG_DATA_MSB_TO_LSB;
+
 	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
 
 	value = DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
 	tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
 
-	/* configure H- and V-sync signal polarities */
+	/* configure H- and V-sync and pixel clock signal polarities */
 	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
@@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
 	else
 		value &= ~LVS_OUTPUT_POLARITY_LOW;
 
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
+		value &= ~BIT(PIN_LSC0);
+	else
+		value |= BIT(PIN_LSC0);
+
 	tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
 
-	/* XXX: parameterize? */
-	value = DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
-		DISP_ORDER_RED_BLUE;
+	/* configure DE signal polarities */
+	value = tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
+		value |= BIT(PIN_LSPI);
+	else
+		value &= ~BIT(PIN_LSPI);
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

