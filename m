Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9ED606A320
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bxiGpyUK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCB711260C;
	Thu, 22 Oct 2026 13:23:49 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F9F11260C
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:23:43 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso826002a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675421; x=1793280221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KXz6d61M5KD13QHimY2yBAnDg5P4a0+gl+DKibpYues=;
 b=bxiGpyUKVVb6db9QbWLCEl9CoFKI3jjqZ5oM9EzLOSpjCJwTxcFOGznMz9U5XalFRl
 6iFsrU+E/I+dQxC5cXIXo4K9oc+HnQvhStOvu/gZuG+UliaU6usf2IMfPrB14cKXzWTx
 x91eK7LtyTADgJZd/zscLjikPaO9/UxeLJrkCEdftkkizoo1m9JyGBn/ty1625f6uKo+
 f07XlecPzVet0AMINFFiIB1MwlyB0I3678LITbboo9Z8Q51rfyMeyh6Jbi/is6Q0gtyG
 r/u5QI+JE9D/JPEjUznyO7abL2ofmMXhdQ1Ar8iIl5ViWW7M6hi8JeeUO7RarSWMwmJa
 Irmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675421; x=1793280221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KXz6d61M5KD13QHimY2yBAnDg5P4a0+gl+DKibpYues=;
 b=lSiGOBi8F4wY2IB95TXblbAWXIpCFyZrZ1E7+wpXvbiFoaqNGkwbdj1uVsu64XSgvn
 qsVSmuZoRZ/80o/9iqIIpW8aaiR1xw3vnSmX8bHCzMqeAOcWnseT//hJoMTOFFPOy4Td
 cVYybUr+Ct2Jnii/h241DFlID4Tuh0+hQLCqoy1hhfPUj0GEGCuo3LbCB7vaYLZbXtKm
 ynYif+VPneC275vAUdIzmVNxU2Q8qXrddDHG0gzPKIkw1RkLmFf+sni23HvOk/XlIhi/
 CP9M4VCJ8PDZyOYlPYllTS4FOEL286CbQWpzoTtabzSPNPlEq8ICMcS3zhfutyvMYfXE
 UO1A==
X-Gm-Message-State: AFq9FYLFk0uudcQmLjX5XqwA1sVEME/G79dG6vSP2m/ea3Lz6zxqR/oo
 RUc+Va2Q45MYxByWdKEE+MX5vQ71NIAH6i0Jj8RwYtkpRFJvqmE8eEZm
X-Gm-Gg: AYBFou3dbTqw5nR2rbloZCBgG7oVNB5nwsnNbPfWobAA1ccqFJOBsVCM0t8peCibkQ6
 z5Rvtxi+3vImvWaP+q8Hs7PoRwblCUXQFV79CgS7FkyUFLdH++miIrfPiCev2LxdFwTrn4wfhyf
 o2y837D/ShE91lxj73QKEaryamOacF9yoSczoV8vEG3beHOcBE4PPDO4dic77gqY6WonEy21BWD
 Rco5XDCvMmurXTCkl8MRsyUwd2FA7rhRPLUKaPvZUmDIXC8L7CQ9TNElGdbD9v/MGsf60Nud39Q
 jv8J8xgcEqvM42ZKqP1vmYtYrDVv+xWhDCxMJm6K6RPctYdVrAIDeFOYh9UOqUsuOvNE0aXBF17
 E84pDMndCW4GP0QSP2n7Dp8Gd3F1tuIef8pj/aSrp/Jx4djiHqs6wYdJR0600CCTPRZWnKCaSSm
 LyLEYZnpQfuMLB8acpE7oBeVloK6ythiujbTY5CNSkusRW9Qj/UZMk9FKJhqQd2h+6kPju21TfZ
 XROdDzqKkjCZmgDRmumzWd1DNi2lx4ae++qTuyzUUz7NxguAnnEFu1Y5UCpyYcypIXutk2dOr9Z
 3OSKleO7gSRYVBQB/1J4Fno=
X-Received: by 2002:a05:6402:4246:10b0:6ae:1895:3b3e with SMTP id
 4fb4d7f45d1cf-6b41d5cfd2emr2354555a12.6.1792675421106; 
 Thu, 22 Oct 2026 06:23:41 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40313074esm1818061a12.27.2026.10.22.06.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:23:38 -0700 (PDT)
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
Subject: [PATCH v4 5/7] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Thu, 22 Oct 2026 16:22:57 +0300
Message-ID: <20261022132259.240717-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132259.240717-1-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

