Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BE606D836
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TDSa2HG7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D081124BD;
	Thu,  5 Nov 2026 14:06:31 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B085E10E41F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:06:11 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so1025147f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887570; x=1794492370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wWQWFAQ/YeW0U3f8X8JNgjR9sIicTFidkftaJdNSKFk=;
 b=TDSa2HG7YbXXUEEKTJU1YSqkRGT23sPZc5XrexE+ADz8hxlJVkPei9GRYS2i+jTkm9
 CSLplSL3oaZKhXmtziIDrdkeoIryNuq7ghfvJ03uH2+CTnEVfYW39Eo4jd09YFpIOt7l
 iHSOqYL2uuFXJmQ7GDkKAZ0Zv6uoUuFJXwlQq7J/EMqJqEf28yiuLmbhEm6qMixb16lO
 F6U7BIK79VNvjCOd35UJ6WViWManOEtW2jzXhSZ9BT1b/MTispj1n5JXHPH9HgxuxYjS
 D2EfSqdRx0MxaSI3H7AJ4ne9uP9Bu5Dc5xTiEgoLJ4K4RPWApMCt0x8p4VOS3jeRH2Ss
 +USQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887570; x=1794492370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wWQWFAQ/YeW0U3f8X8JNgjR9sIicTFidkftaJdNSKFk=;
 b=kque6FG7yH0CrNl1QbOHjlkGZS/BjxiPjzyImUFXyEEKbzWsG3s/uOftbZHn6Bwkyr
 OLG3NXDcJm8eTA2bgW8JoCNTwDQPbXHQhmjUYKk6t4F4Anxm17t/SNXuwGtQce0fZUrZ
 gPczzvpVbR/qABB6U4zC6NVuCQ1WmxauElejeTRQWy3bF/BtSpUp5SMHttXucLbrQmwN
 nqNItLKlnMKZs8E4m7JzPRc6hcGcimNjB7+0vvGzh6kVu/Z1Sqa925mDFL+tPbi/DFLF
 lNeMnkUkWfWJCZqCypOHM/CYpmOxMmm2A0duL8DmO8mkMXpJUR/JcQhxI2bA6MkJPGuX
 MN3w==
X-Gm-Message-State: APuU4Z9oQE+j1VUrXqizkmL682xHppYfu+qSDfXgZrKA82sx0gMxsYDH
 mCO8lWcjTZNomLGyPRUcEiB4HIrz9u3llMxBkDdb0YAPcSkjB3nh3Xs0
X-Gm-Gg: AYBFou3Q7I21sxhPbEwerTuCoB34IIueRuWBP4kacCvNBf+G8puhHsnzEHxpRtTQ5CV
 W6iQkiJQP0/wgstsqmTiMSkMdIXruE6VAnIOWxkTCWifAsAJSn2Wn/F37kSmHbzRx4UoigajLuq
 8EyHWwsqFInHm73YHEQVxaDJCrZWT7dJEUa0NzclgCE3tpoxmTqOK8ILSbIkXZIesQWglckTiHQ
 +Bu2kikx7AXw6SQ9PAagqQ/QGlDSCiRybaRH3kBvEf2sLgsMnk3AAsOxlkoCAPlZPJpNcYYJeeE
 qu1C9mjJdCqCEe4VdU6+RsYeahcYscCMJy3lip87n4ssaqYjgUhCRP9BLNMJukwFrsyecpAk1/E
 WrHAE1xsVtH0IRK0Wnr0CqZajISAwcVzNmoa/MmLj005R0CGReTd/4lDo6GIXXbMq31gcL2iSLG
 Vs/m6pq9qj1HcUoxL0e9E/mpNpZTqKSshdLMOhqpNyTUR7pFyThVOg16CUHZ8SUR1W2J2aa7zDV
 5JhkU5xB5LffdcdR/Jhbs/YOEy1gm7W+wpFUX76LP8c2cghrgvJm4/i0xItJZ/zN5bPZjSrbF/M
 c9WLGDIEVb2wTyHkBGCVWjs4Ni1EOCAFhyAo1nJ9pmHGfEmg4DfzyiDb8/YRGjoIxVAOpuI=
X-Received: by 2002:a05:6000:2c03:b0:48d:f034:7fcd with SMTP id
 ffacd0b85a97d-48e6e4fca93mr39774284f8f.51.1793887569888; 
 Thu, 05 Nov 2026 06:06:09 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:06:08 -0800 (PST)
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
Subject: [PATCH v6 08/10] drm/tegra: rgb: Parameterize configuration based on
 bus flags
Date: Thu,  5 Nov 2026 16:05:08 +0200
Message-ID: <20261105140510.165165-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105140510.165165-1-clamor95@gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
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
index 7dea0cac61233..d8f41d1ca350e 100644
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
 		value &= ~BIT(PIN_LVS);
 
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

