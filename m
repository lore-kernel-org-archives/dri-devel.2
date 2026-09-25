Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A2C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99DE10F88F;
	Fri, 25 Sep 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsUbazKP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35E510F89B
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9484C44511;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51FC4C2BCFC;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790320101;
 bh=cN3OlMdPtMW9M/6XwvF6ok0FDaDGuXphGzxIpOzDFnk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WsUbazKPOd61rHvhdKj1+C4TbpwAV6d4jbzmwD+DR7n0pYwtUVsECUQMPSMdbZhqN
 EFLvvcVgDF6kT9UgfR6qw2+caFzJGIiBpN95G3Jl/1khwYdwo5lsQZ33FhZLmgZghN
 LT20Vf9pIDHU3k9dxCq9D3kWwnP6CAnQs6BbfKrSh+63jkdRrQIcUgQv29dxHV1Ul9
 /TZMm1udU3w9zttlwIOA7Lxk0RFOX5tBrmK28Zlx7kZRrjZZwF3JOm2nx0Zvt+mZTZ
 LVZDjSRDDMF/qx3FsNBVwFNbE5zdVEFHmqhNizqIzK9LmwVN3xD1777inHx7MKeOzc
 x2d+CHJYC2ArA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 36C7FC9830E;
 Fri, 25 Sep 2026 07:08:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 02:08:21 -0500
Subject: [PATCH v2 3/4] drm/panel: visionox-vtdr6130: Modularize panel config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-rp6-panel-v2-3-19c425e523de@gmail.com>
References: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
In-Reply-To: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790320100; l=5035;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=oRgQFG+Me9dofHYSw/NC9OmBO4cg+QFRt96qK9Xmzh0=;
 b=BSv/bLFo8oSvDcDHQa9j91sG03LuCGd824UrK8gCRTp9mDI3SBPycLwD7zP05SWo2VCu57tT3
 Zlb6ggdc7IOAMLqq486JROppBFel7RkhSdkJ8jDw5eA+cUtC3kXpSi2
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

The vtdr6130 is a DDIC, a common chip that is used by multiple panels.
Prepare the driver for more panels.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 91 +++++++++++++++++--------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index b66d6c7128c75..278f5acc2d661 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -19,11 +19,24 @@
 
 struct visionox_vtdr6130 {
 	struct drm_panel panel;
-	struct drm_dsc_config dsc;
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
 	enum drm_panel_orientation orientation;
+	struct visionox_vtdr6130_desc *desc;
+};
+
+struct visionox_vtdr6130_desc {
+	unsigned int bpc;
+	unsigned int lanes;
+	unsigned long mode_flags;
+	enum mipi_dsi_pixel_format format;
+
+	const struct drm_display_mode *modes;
+	unsigned int num_modes;
+	int (*init_sequence)(struct visionox_vtdr6130 *ctx);
+
+	struct drm_dsc_config dsc;
 };
 
 static const struct regulator_bulk_data visionox_vtdr6130_supplies[] = {
@@ -162,7 +175,7 @@ static int visionox_vtdr6130_prepare(struct drm_panel *panel)
 
 	visionox_vtdr6130_reset(ctx);
 
-	ret = visionox_vtdr6130_on(ctx);
+	ret = ctx->desc->init_sequence(ctx);
 	if (ret < 0) {
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 		regulator_bulk_disable(ARRAY_SIZE(visionox_vtdr6130_supplies),
@@ -187,26 +200,50 @@ static int visionox_vtdr6130_unprepare(struct drm_panel *panel)
 	return 0;
 }
 
-static const struct drm_display_mode visionox_vtdr6130_mode = {
-	.clock = (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
-	.hdisplay = 1080,
-	.hsync_start = 1080 + 20,
-	.hsync_end = 1080 + 20 + 2,
-	.htotal = 1080 + 20 + 2 + 20,
-	.vdisplay = 2400,
-	.vsync_start = 2400 + 20,
-	.vsync_end = 2400 + 20 + 2,
-	.vtotal = 2400 + 20 + 2 + 18,
-	.width_mm = 71,
-	.height_mm = 157,
+static const struct drm_display_mode visionox_vtdr6130_modes[] = {
+	{
+		.clock = (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
+		.hdisplay = 1080,
+		.hsync_start = 1080 + 20,
+		.hsync_end = 1080 + 20 + 2,
+		.htotal = 1080 + 20 + 2 + 20,
+		.vdisplay = 2400,
+		.vsync_start = 2400 + 20,
+		.vsync_end = 2400 + 20 + 2,
+		.vtotal = 2400 + 20 + 2 + 18,
+		.width_mm = 71,
+		.height_mm = 157,
+	},
+};
+
+static struct visionox_vtdr6130_desc visionox_vtdr6130_panel_desc = {
+	.modes = visionox_vtdr6130_modes,
+	.num_modes = ARRAY_SIZE(visionox_vtdr6130_modes),
+	.bpc = 8,
+	.lanes = 4,
+	.format = MIPI_DSI_FMT_RGB888,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
+		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.init_sequence = visionox_vtdr6130_on,
+	.dsc = {
+		.dsc_version_major = 0x1,
+		.dsc_version_minor = 0x2,
+		.slice_height = 40,
+		.slice_width = 540,
+		.slice_count = 2,
+		.bits_per_component = 8,
+		.bits_per_pixel = 8 << 4,
+		.block_pred_enable = true,
+	},
 };
 
 static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
 				       struct drm_connector *connector)
 {
+	struct visionox_vtdr6130 *ctx = to_visionox_vtdr6130(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev, &visionox_vtdr6130_mode);
+	mode = drm_mode_duplicate(connector->dev, ctx->desc->modes);
 	if (!mode)
 		return -ENOMEM;
 
@@ -284,23 +321,17 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
+	ctx->desc = (struct visionox_vtdr6130_desc *)of_device_get_match_data(dev);
+	if (!ctx->desc)
+		return -ENODEV;
+
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ctx->dsc.dsc_version_major = 0x1;
-	ctx->dsc.dsc_version_minor = 0x2;
-	ctx->dsc.slice_height = 40;
-	ctx->dsc.slice_width = 540;
-	ctx->dsc.slice_count = 2;
-	ctx->dsc.bits_per_component = 8;
-	ctx->dsc.bits_per_pixel = 8 << 4;
-	ctx->dsc.block_pred_enable = true;
-
-	dsi->dsc = &ctx->dsc;
-	dsi->lanes = 4;
-	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
-			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	dsi->dsc = &ctx->desc->dsc;
+	dsi->lanes = ctx->desc->lanes;
+	dsi->format = ctx->desc->format;
+	dsi->mode_flags = ctx->desc->mode_flags;
 	ctx->panel.prepare_prev_first = true;
 
 	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
@@ -322,7 +353,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id visionox_vtdr6130_of_match[] = {
-	{ .compatible = "visionox,vtdr6130" },
+	{ .compatible = "visionox,vtdr6130", .data = &visionox_vtdr6130_panel_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, visionox_vtdr6130_of_match);

-- 
2.54.0


