Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769F606D83A
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNOMFHn/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68ED510E7BE;
	Sun,  8 Nov 2026 12:32:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E0C10E7CC
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:32:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 476A560D65;
 Sun,  8 Nov 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794141155;
 b=zsUIsf0u/uR0W6XFYTfWm7T6fplT22nQKXPr6O4CeLGmWgHEQLg3lUFVbiQdxLg6fu7v
 AMDfmU8y8jI6a9MJuUjiQVtFpVp92BpVnKgtcXgbsZSHWRsuohxvOF5AFonU46k3c8S1W
 KWyO7ynyGqvQSRshVqtIS6E5cGm3bgiXK5/1Z0IHMf5fpr5H/zMmDvnr9lzjKgEqGrwkx
 Ebt0poAKZKmge7nDmk694kM9cxR0FJ2Ii8unG1UvCj6G5QrYnCOEWEZiEX6XImxxe4ZqS
 YXLM2cKUsWRQq18sh58W9GupSym216MwdOZGU/Vj2k4jy+z3LNia/8h8VOotP9oDryA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794141155;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=w5UID8jE93mY3/EZejprDqOmjHmLVlXU2TvPBIGizMw=;
 b=eeO1Obqteh8KhwrVzxL930TBHMPoHteuRNTmJOwGDH4k7Y9SgXsHo6RnpCR7+TIGX4gP
 CfIJljZwALXCLlxS/7GlyKYbFvUhdGLCgTHpdPW1yoY64S5D+b018RofSQMi+l42q9fEb
 Kv97VKw6uv9jbj/HXMP8WsT6AmFcZzbjQB7BwCOdWMTMpfbaMuSygA2dnv7rfh8/37l/5
 UNgz4bsJXNR5eg/1yxqKN00Y7G7zZ+4vOyy11jnlDoNeWwd2jDG+oZNRaC7sRVhSglhmo
 x6vrGSdsuSiFQo/D3OyaQp7JIYJKdwF7ZEI3bxAGUeIYEUl2OLqc3sGMDLStyGkdcfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 186DA1F008A7;
 Sun,  8 Nov 2026 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141155;
 bh=w5UID8jE93mY3/EZejprDqOmjHmLVlXU2TvPBIGizMw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XNOMFHn/OPgpEGOOi67wR7JFvnm8JxctFhi4fTGNvUPknfq/vLFKHZg1dV4OfXCiz
 /Mvpxd8d94f5aNBg3wqpUZxzj2KtlwQ1aKE6DMw8ap58IRwmfLRUMrfcxMbT5Afv3A
 RYoFWsk4ATDvTTqWNhFNewnGjUW5YcGzdf38rq4gmVMJYpBXpnnqnCOwLiVeiMCrS5
 1qtbVXa97knUncmzmGfkc14R5qEuCdV2EMuhu2y2RjUDObifQBkNj0WqgLLnkMtE6P
 IWqaXO847wj5edIsZE9KN3Y8pJKvcwMwdNmsEW7vTu3lu9YiVUDoPmJ0WDzeICpui1
 rb0D/MDg0XNqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7250847F75;
 Sun,  8 Nov 2026 12:32:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 08 Nov 2026 12:32:26 +0000
Subject: [PATCH v3 05/10] drm/panel: s6e3ha8: Correct the polarity logic within
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-crosshatch-panel-v3-5-87dd4ec4f7cc@ixit.cz>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
In-Reply-To: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4424; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=NokjN5ULkdw4NFc4K/Dq0PixEvAXRh2ywbzWRwvyt5Q=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq8GvenMAGoeNyVWXHxavlU0yiZ9pthukc2PKuz
 8uVSpnUSUiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCavBr3gAKCRBgAj/E00kg
 cte3D/wJrN9gWksKhy5Sn3zkTyMsfH2TmRo+mBmHBw4L8K7cjUuX6yTKOJD1AdN/D1OzUStvXv2
 Tlv5D+EGbGnpDpNTLUEqQW0Il0zdc92stAHYDALifEr2EOO2hn5QnKnUZ1kH93B1E0suU4t/XPl
 kQEPR9tp7t0w86oZpF7kJjd4hyHUltC2pZhrb1B948t+nrC2uEl5Z1h9WehPttaxJ6W9y/XXqkg
 6iZ0L1W05QvYblRqTS+Wt1dJcoHXsytbioYUHlAecW7LdcT9ZrUtXXKirJKe7bR8syTw4tca1uT
 iY0AB/3G9CFr9qeqQ0PTLdAbgNXzQrAPzXV7hVTTsu0rRG331SpbNgA8DRb97fYJq43aFhCRsNk
 4y5dB4FvuJWfz98xFwlKifPaXLZ641U0Inms+oodnY1abKTIL8E573L3D9bI9PstlGY5npmqDEE
 HKaPfIlNCt93wmdPMPk9ZdBW2V3Yb/fDaua+cEvMKsQdTIbWMlYqDpj7MRwb0EiqjGTTP03lq1c
 /QHQAXvK4hm5nO2TBw3KPa1l+dLZpB3gb1kJTm9CRs87N2TaQq+r220tsBT+REHKLx4VZ47IK3B
 rFiZZSfVB+OqZE7vuKYTKsGyUlkb8iLT+DR5VkTOaC4f8xiADhJXUsYWvKRxbmzQPsRfUPNesU0
 vuREioBSpnMVYGg==
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	T_SPF_TEMPERROR,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

The reset was introduced with wrong polarity. Correct for the future
compatibles and keep current with reverted logic.

Old DTs keep GPIO_ACTIVE_HIGH and are fixed up via
gpiod_toggle_active_low() on the deprecated compatible.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index f5b3992d948bc..99290913de69a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -20,16 +20,17 @@
 #include "panel-samsung-dsi.h"
 
 struct s6e3ha8_desc {
 	const struct drm_panel_funcs *funcs;
 	const struct drm_display_mode *mode;
 	unsigned long mode_flags;
 	const struct regulator_bulk_data *supplies;
 	unsigned int num_supplies;
+	bool broken_reset_polarity;
 };
 
 struct s6e3ha8 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	const struct s6e3ha8_desc *desc;
 	struct drm_dsc_config dsc;
 	struct gpio_desc *reset_gpio;
@@ -62,22 +63,22 @@ static int s6e3ha8_unprepare(struct drm_panel *panel)
 {
 	struct s6e3ha8 *priv = to_s6e3ha8(panel);
 
 	return regulator_bulk_disable(priv->desc->num_supplies, priv->supplies);
 }
 
 static void s6e3ha8_amb577px01_wqhd_reset(struct s6e3ha8 *priv)
 {
-	gpiod_set_value_cansleep(priv->reset_gpio, 1);
-	usleep_range(5000, 6000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
 	usleep_range(5000, 6000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(priv->reset_gpio, 0);
+	usleep_range(5000, 6000);
 }
 
 static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
 {
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
@@ -243,16 +244,27 @@ static const struct drm_display_mode s6e3ha8_amb577px01_wqhd_mode = {
 static const struct drm_panel_funcs s6e3ha8_amb577px01_wqhd_panel_funcs = {
 	.prepare = s6e3ha8_amb577px01_wqhd_prepare,
 	.unprepare = s6e3ha8_unprepare,
 	.get_modes = s6e3ha8_get_modes,
 	.enable = s6e3ha8_amb577px01_wqhd_enable,
 	.disable = s6e3ha8_amb577px01_wqhd_disable,
 };
 
+static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc_legacy = {
+	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
+	.mode = &s6e3ha8_amb577px01_wqhd_mode,
+	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
+		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
+	.supplies = s6e3ha8_vddr_supplies,
+	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
+	.broken_reset_polarity = true,
+};
+
 static const struct s6e3ha8_desc s6e3ha8_amb577px01_wqhd_desc = {
 	.funcs = &s6e3ha8_amb577px01_wqhd_panel_funcs,
 	.mode = &s6e3ha8_amb577px01_wqhd_mode,
 	.mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
 		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
 		MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET,
 	.supplies = s6e3ha8_vddr_supplies,
 	.num_supplies = ARRAY_SIZE(s6e3ha8_vddr_supplies),
@@ -283,16 +295,19 @@ static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
 	priv->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(priv->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
+	if (priv->desc->broken_reset_polarity)
+		gpiod_toggle_active_low(priv->reset_gpio);
+
 	priv->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, priv);
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = priv->desc->mode_flags;
 
 	priv->panel.prepare_prev_first = true;
@@ -323,17 +338,17 @@ static int s6e3ha8_probe(struct mipi_dsi_device *dsi)
 
 	return 0;
 }
 
 static const struct of_device_id s6e3ha8_of_match[] = {
 	{
 		/* deprecated */
 		.compatible = "samsung,s6e3ha8",
-		.data = &s6e3ha8_amb577px01_wqhd_desc,
+		.data = &s6e3ha8_amb577px01_wqhd_desc_legacy,
 	}, {
 		.compatible = "samsung,s6e3ha8-amb577px01",
 		.data = &s6e3ha8_amb577px01_wqhd_desc,
 	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6e3ha8_of_match);
 

-- 
2.55.0


