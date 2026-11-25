Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984E606A332
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lDSFWNhn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F5C810E1C1;
	Wed, 25 Nov 2026 18:13:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D7B10E1C1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:13:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0E7542E23;
 Wed, 25 Nov 2026 18:13:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795630381;
 b=NJsYqyQBSKJcLK68++4KJ4mYRBvGl3ewUkutijZ/xJVaKQI0yAJ2RMMguESzvvQIC/oV
 UeDu3EkQM3UyVhfg8G7Wax0q3IOfw/422/MxYyhNuIvhkFKYJoqBZwbO8h+5A6aNLyYbK
 v/QLXfSS6rM2ogClhwKE5xRWjVlVMK0vr0i3eS/AXTMaXTE/BjzoQBfxQ94mg+F9nITJM
 GenODoE8lAkAeYNrgAEANxUJF2YEaLVosdU+48W11KGt0CEaGlnrzO8dIZqu1e2CF/ZMG
 Q+Mi+RWqf1EFNgrfQEfoeeYgGsXjgSDAiIiRi8hj9NPAaGu4qmXgW7AgE4S15M4U6jQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795630381;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=X/DoHGbWC5JSvDDvY7gbXLwxKuA8YwkqE+dRdtUx7ek=;
 b=QjIJ5D3v0hH3iwwN9/6YxXnzNXiuF9lBM9bd1kp4o5mO1jG0OuyhO3dre+2LW3iTNlNF
 U5tyOhzkDwxZ9h89LNCKBMf0OjlXke264EGWM9Qacecgg92uHEHeV0UQEKssT5j5YnDmn
 NEGS8A8V7M0kAS32g6BqMLxGvh+A7jctTrPs5nvlDooOFP6aW2Mvnj+mO7e33jwCXY9/0
 SkuZ/s8FG0KKOJ7bCu23KuLKE6U8gwo6GwfG141g9U89+I0qhyphAkwOBzlisGREbgnf2
 hBGeBx11JRgsgpU8AldokDUQ3wRH5GS4QhtQeBGONeCL68Qn7KR+0SjNUZ6Sc1JExqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4F3011F000D2;
 Wed, 25 Nov 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630381;
 bh=X/DoHGbWC5JSvDDvY7gbXLwxKuA8YwkqE+dRdtUx7ek=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=lDSFWNhnfje7Ve5GBuER66d/nb2Vydjnf8NWD6vndQdwCJFXgw0Sb/Fnk0o/1E+49
 WVNt7i3DzKiK1lpZlvHbrBexyG0s69AVHaCZXv6GlhiXQPn4D3LLg+B2rMfvAlaDbQ
 c+qjzE1uTpMpTCHSEqM62ZsZq0elYOo/nyZiWQ/fkC2Vrn0dm9l05/IQDoTZivkYvD
 PYx7qB2tvwX75jCGAyrEhN5wtttzl7Eh86rYvvYN6+2yVk3nWmOLTtMyXRpvhuoq40
 36Kj3efZMO7ZMSk5O5K2Fp2YXyQqsUh3ZNZ6LNVFD6Gn+4fbJuK9yRLG4F6gDRqnDe
 UimAJHyRDTgdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CEFF64CFAC;
 Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 19:12:48 +0100
Subject: [PATCH v4 4/9] drm/panel: s6e3ha8: Prepare for supporting multiple
 panels
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-crosshatch-panel-v4-4-120adc58e737@ixit.cz>
References: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
In-Reply-To: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10585; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=vxv5cIvIJf2nydvOShwWwnNh6DF9O7yQfzANpYBQVv8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrByUebu9sXBcqa88aYl+IyEbeF9HkNkAy+Rjru
 Hw3Ir8rh9OJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawclHgAKCRBgAj/E00kg
 cnjPEACpZjcd4FzfZwZJaBnKct39b0FYFtzgJi6KGHtCruG4lA7kpOBH9YgrvssHcMbZSu+Whqv
 A67bPOaDxT5zZ4d2Mh7tNiPD3ZegZxeCwgTaR6jq5XEaGrQvaaT6O1J8Ry0IfoCgos75YlspdA5
 U1QNEnj1/lNV84L1rpfjACSFG+fzUSgnJTIjecG34zrEZTWBaagjT0LvyZ0qYdTqMw9gGfeNNGR
 B4SsSV5BVyrBp3dZdi0lTO/k193lVoA/Ntxpnk13i8TlnAGbze9PbjBJgNXVq0UK5pGSu5sPVIy
 r11kUFTBGGaOt26G4S8O55Bd+tMX/5i/2cpLHB37cbgV9YSPA+Nt57aFyiEMZB3nha4q+rQM+nM
 YEjJ43d1luqFehFnfikNdlaRRXsNcvICk6DwkLatYa50svGOP54cb6y/m7rL2gt3y+DnDX9Q+hV
 6tBBEKTKZAFiVpl2ig5r0V/JmFJOKm6cQXwYKsCslCByGa+Dn1APSXKXYci9cWUPn+QAgVD9u46
 LzGzhJ5zcoKP5Bz5b7lqof4ehTFXr/52vkw1RHI0lz+tOoAHfwAQWOnlQeIetRCwwy2sslu96w1
 61TtRXFZ/cjdn5Y54ZmJm6IEtK+SSqLaXx8+imQ9HkqY6c++EEX7R2rJTk98N+Zn1nhXC3JgThs
 zJih3n/VCSceLpQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

The S6E3HA8 DDIC drives more panels than the Galaxy S9 (AMB577PX01)
one currently supported. Move the display mode, DSI mode flags,
regulator supplies and panel functions into a per-compatible descriptor
passed as OF match data, and rename the panel-specific symbols
accordingly.

No functional change.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 118 ++++++++++++++++----------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 45b1c522b0ccf..f5b3992d948bc 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -3,49 +3,73 @@
 // Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree:
 //	Copyright (c) 2013, The Linux Foundation. All rights reserved.
 // Copyright (c) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/display/drm_dsc.h>
 #include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 
 #include "panel-samsung-dsi.h"
 
+struct s6e3ha8_desc {
+	const struct drm_panel_funcs *funcs;
+	const struct drm_display_mode *mode;
+	unsigned long mode_flags;
+	const struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
+};
+
 struct s6e3ha8 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
+	const struct s6e3ha8_desc *desc;
 	struct drm_dsc_config dsc;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
 };
 
-static const struct regulator_bulk_data s6e3ha8_supplies[] = {
+static const struct regulator_bulk_data s6e3ha8_vddr_supplies[] = {
 	{ .supply = "vdd3" },
 	{ .supply = "vci" },
 	{ .supply = "vddr" },
 };
 
-static inline
-struct s6e3ha8 *to_s6e3ha8_amb577px01_wqhd(struct drm_panel *panel)
+static inline struct s6e3ha8 *to_s6e3ha8(struct drm_panel *panel)
 {
 	return container_of(panel, struct s6e3ha8, panel);
 }
 
 #define s6e3ha8_afc_off(ctx) \
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xe2, 0x00, 0x00)
 
+static int s6e3ha8_get_modes(struct drm_panel *panel,
+			     struct drm_connector *connector)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8(panel);
+
+	return drm_connector_helper_get_modes_fixed(connector, priv->desc->mode);
+}
+
+static int s6e3ha8_unprepare(struct drm_panel *panel)
+{
+	struct s6e3ha8 *priv = to_s6e3ha8(panel);
+
+	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
+}
+
 static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
 {
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	usleep_range(5000, 6000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
 	usleep_range(5000, 6000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	usleep_range(5000, 6000);
@@ -130,32 +154,32 @@ static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x03); /* Gamma, LTPS(AID) update */
 	samsung_dsi_test_key_off_lvl2(&ctx);
 
 	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	return ctx.accum_err;
 }
 
-static int s6e3ha8_enable(struct drm_panel *panel)
+static int s6e3ha8_amb577px01_wqhd_enable(struct drm_panel *panel)
 {
-	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct s6e3ha8 *priv = to_s6e3ha8(panel);
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
 	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_dcs_set_display_on_multi(&ctx);
 	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	return ctx.accum_err;
 }
 
-static int s6e3ha8_disable(struct drm_panel *panel)
+static int s6e3ha8_amb577px01_wqhd_disable(struct drm_panel *panel)
 {
-	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct s6e3ha8 *priv = to_s6e3ha8(panel);
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
 	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
 	samsung_dsi_test_key_off_lvl1(&ctx);
 	mipi_dsi_msleep(&ctx, 20);
 
@@ -165,23 +189,23 @@ static int s6e3ha8_disable(struct drm_panel *panel)
 
 	mipi_dsi_msleep(&ctx, 160);
 
 	return ctx.accum_err;
 }
 
 static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
 {
-	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
+	struct s6e3ha8 *priv = to_s6e3ha8(panel);
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 	struct drm_dsc_picture_parameter_set pps;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
+	ret = regulator_bulk_enable(priv->desc->num_supplies, priv->supplies);
 	if (ret < 0)
 		return ret;
 	mipi_dsi_msleep(&ctx, 120);
 	s6e3ha8_amb577px01_wqhd_reset(priv);
 
 	ret = s6e3ha8_amb577px01_wqhd_on(priv);
 	if (ret < 0) {
 		gpiod_set_value_cansleep(priv->reset_gpio, 1);
@@ -193,88 +217,88 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
 	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
 	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	mipi_dsi_msleep(&ctx, 28);
 
 	return ctx.accum_err;
 err:
-	regulator_bulk_disable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
+	regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
 	return ret;
 }
 
-static int s6e3ha8_amb577px01_wqhd_unprepare(struct drm_panel *panel)
-{
-	struct s6e3ha8 *priv = to_s6e3ha8_amb577px01_wqhd(panel);
-
-	return regulator_bulk_disable(ARRAY_SIZE(s6e3ha8_supplies), priv->supplies);
-}
-
 static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
 	.clock = (1440 + 116 + 44 + 120) * (2960 + 120 + 80 + 124) * 60 / 1000,
 	.hdisplay = 1440,
 	.hsync_start = 1440 + 116,
 	.hsync_end = 1440 + 116 + 44,
 	.htotal = 1440 + 116 + 44 + 120,
 	.vdisplay = 2960,
 	.vsync_start = 2960 + 120,
 	.vsync_end = 2960 + 120 + 80,
 	.vtotal = 2960 + 120 + 80 + 124,
 	.width_mm = 64,
 	.height_mm = 132,
 };
 
-static int s6e3ha8_amb577px01_wqhd_get_modes(struct drm_panel *panel,
-					     struct drm_connector *connector)
-{
-	return drm_connector_helper_get_modes_fixed(connector, &s6e3ha8_amb577px01_wqhd_mode);
-}
-
 static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
 	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
-	.unprepare = s6e3ha8_amb577px01_wqhd_unprepare,
-	.get_modes = s6e3ha8_amb577px01_wqhd_get_modes,
-	.enable = s6e3ha8_enable,
-	.disable = s6e3ha8_disable,
+	.unprepare = s6e3ha8_unprepare,
+	.get_modes = s6e3ha8_get_modes,
+	.enable = s6e3ha8_amb577px01_wqhd_enable,
+	.disable = s6e3ha8_amb577px01_wqhd_disable,
+};
+
+static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc = {
+	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
+	.mode = &s6e3ha8_amb577px01_wqhd_mode,
+	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
+		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
+	.supplies = s6e3ha8_vddr_supplies,
+	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
 };
 
-static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
+static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
+	const struct s6e3ha8_desc *desc;
 	struct s6e3ha8 *priv;
 	int ret;
 
-	priv = devm_drm_panel_alloc(dev, struct s6e3ha8, panel,
-				    &s6e3ha8_amb577px01_wqhd_panel_funcs,
+	desc = device_get_match_data(dev);
+	if (!desc)
+		return -ENODEV;
+
+	priv = devm_drm_panel_alloc(dev, struct s6e3ha8, panel, desc->funcs,
 				    DRM_MODE_CONNECTOR_DSI);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(s6e3ha8_supplies),
-				      s6e3ha8_supplies,
-				      &priv->supplies);
+	priv->desc = desc;
+
+	ret = devm_regulator_bulk_get_const(dev, desc->num_supplies,
+					    desc->supplies, &priv->supplies);
 	if (ret < 0) {
 		dev_err(dev, "failed to get regulators: %d\n", ret);
 		return ret;
 	}
 
 	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
 	priv->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, priv);
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
-		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = priv->desc->mode_flags;
 
 	priv->panel.prepare_prev_first = true;
 
 	ret = devm_drm_panel_add(dev, &priv->panel);
 	if (ret)
 		return ret;
 
 	/* This panel only supports DSC; unconditionally enable it */
@@ -295,27 +319,33 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
 	}
 
 	return 0;
 }
 
-static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
-	{ .compatible = "samsung,s6e3ha8" }, /* deprecated */
-	{ .compatible = "samsung,s6e3ha8-amb577px01" },
+static const struct of_device_id s6e3ha8_of_match[] = {
+	{
+		/* deprecated */
+		.compatible = "samsung,s6e3ha8",
+		.data = &s6e3ha8_amb577px01_wqhd_desc,
+	}, {
+		.compatible = "samsung,s6e3ha8-amb577px01",
+		.data = &s6e3ha8_amb577px01_wqhd_desc,
+	},
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
+MODULE_DEVICE_TABLE(of, s6e3ha8_of_match);
 
-static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
-	.probe = s6e3ha8_amb577px01_wqhd_probe,
+static struct mipi_dsi_driver s6e3ha8_driver = {
+	.probe = s6e3ha8_probe,
 	.driver = {
 		.name = "panel-s6e3ha8",
-		.of_match_table = s6e3ha8_amb577px01_wqhd_of_match,
+		.of_match_table = s6e3ha8_of_match,
 	},
 };
-module_mipi_dsi_driver(s6e3ha8_amb577px01_wqhd_driver);
+module_mipi_dsi_driver(s6e3ha8_driver);
 
 MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
 MODULE_DESCRIPTION("DRM driver for S6E3HA8 panel");
 MODULE_LICENSE("GPL");

-- 
2.55.0


