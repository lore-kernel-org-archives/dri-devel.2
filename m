Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E20CC79F8C
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 13:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888CE10E3C5;
	Sun,  6 Sep 2026 13:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k+X8QwkZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9CA10E3BF
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 13:19:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D08FD43D74;
 Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5153C2BCFB;
 Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788700753;
 bh=W8YOe2fo/FY8tQcyn3AaXI/DbctGrOF/V/GQL7T1bdk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=k+X8QwkZryQyOeRWzOnqsd/DBItTFsgJ+Be16voLpsHXzY2zIc5dUlGwNth3YxAOh
 gpB1PJqvUJJRn2gpo7HRqBm1Kgm+t7A52JpE9LP+fy/GRol0G4IVYpe8NqDNaasW9W
 gdAlqq8KQRM8CiFgTDtYvGs6dYzluGdNdMN//Bk3n69XJ/VckrYywA5H/HciLoC1t5
 QZzKXzrltsQy6RQ/OhGyOYkIO7OLaDHYQwmjBtKjVqIkap1oRXaRvohl2hGjO11j1y
 7A/ymBda7TJRXWVJCZlSNIzFqC94KN25UdcZIcUIbZoPrQn/WW3+8ZhImZllOLpAEm
 3frOMODs7Cfuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3FC79F85;
 Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 06 Sep 2026 15:19:04 +0200
Subject: [PATCH 3/3] drm/panel: ebbg-ft8719: Split initialization into
 enable/disable fn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ebbg-ft8719-fixups-v1-3-4e846510cad1@ixit.cz>
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
To: Joel Selvaraj <jo@jsfamily.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=p73JyBK1o/C+mzNNbgxiVSAcxnHLj7kGgIMlHReDhbk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnWhQKcmvi4k32WSvJMa+9RTRNnsJ3444kkldI
 UU8+0T300KJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap1oUAAKCRBgAj/E00kg
 cmfJEADMw74MxiUc/eG+RdvFVRxScOnT/2Uk1muqQih/IgZrYeBDR02nIKGAIndxVVWLrz+HCCF
 RfC+ndb4uF/F5GIaerIr1X4jZaASuEz8tUVGpvJGJPJnd1Y5wxDDgf424BaVS2NaCF9ee1zqTe0
 2C8C2XoAJo2W3zwKM06HcbskeHWHW4ajhk2BohJ/BBi7ii6PZnu64QiPAql7VVly7RXbad1b5s8
 G1I2FMVuI2X7ELCeBg04M71JzuHMkKB7wbTKhVaUIwmek0Q/2jZkZ6v/9jrgVDGx9/z1yKTtWCo
 9uLfJwpjRBPmN/JFfAkg17KPxgem/RS+G5h3N0fXA/plDfY1ohkqnF81/pA6Rmr2GwIjV5pOfPy
 4uin18T+D4Io/XXNxVB8wVgwqqdvDnPl4JHdj1oP4b0UI137/GyuTi4LWyPfADKu+U5mD35vUNs
 Q/7KcDDROCXZpCZauMzP3uviiEuHTb90wnR9FE9qUc5Xp03A7WF0rtjbV8HVnZa4wpC1Q92WziZ
 kTmDBqFpeOshhnONb0K6cStqNlNBkHy4eY7RvbnzzkezoSACSCoxBtqapbIrtJ4qE3NQ2cCOtNn
 tct4OV2wVskppsD02f17dh6eoqRChjm/Im7b5E/vz1RxVVBAYqHz4aUxSftJQNgM3RaG0SidxDv
 KmcqYW9U8UROOwg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

Efficiently this already happens with prepare/unprepare calls.
Remove unnecessary login and just use enable/disable functions.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index 14982263a94f1..9965f46f1a316 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -49,40 +49,42 @@ static void ebbg_ft8719_reset(struct ebbg_ft8719 *ctx)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	usleep_range(4000, 5000);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	usleep_range(1000, 2000);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	usleep_range(15000, 16000);
 }
 
-static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
+static int ebbg_ft8719_enable(struct drm_panel *panel)
 {
+	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	mipi_dsi_msleep(&dsi_ctx, 90);
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
 	return dsi_ctx.accum_err;
 }
 
-static int ebbg_ft8719_off(struct ebbg_ft8719 *ctx)
+static int ebbg_ft8719_disable(struct drm_panel *panel)
 {
+	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
 	struct mipi_dsi_device *dsi = ctx->dsi;
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 	mipi_dsi_msleep(&dsi_ctx, 90);
 
 	return dsi_ctx.accum_err;
 }
@@ -93,30 +95,23 @@ static int ebbg_ft8719_prepare(struct drm_panel *panel)
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret < 0)
 		return ret;
 
 	ebbg_ft8719_reset(ctx);
 
-	ret = ebbg_ft8719_on(ctx);
-	if (ret < 0) {
-		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		return ret;
-	}
-
 	return 0;
 }
 
 static int ebbg_ft8719_unprepare(struct drm_panel *panel)
 {
 	struct ebbg_ft8719 *ctx = to_ebbg_ft8719(panel);
 
-	ebbg_ft8719_off(ctx);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 
 	return 0;
 }
 
 static const struct drm_display_mode ebbg_ft8719_mode = {
 	.clock = (1080 + 28 + 4 + 16) * (2246 + 120 + 4 + 12) * 60 / 1000,
@@ -148,16 +143,18 @@ static int ebbg_ft8719_get_modes(struct drm_panel *panel,
 	connector->display_info.height_mm = mode->height_mm;
 	drm_mode_probed_add(connector, mode);
 
 	return 1;
 }
 
 static const struct drm_panel_funcs ebbg_ft8719_panel_funcs = {
 	.prepare = ebbg_ft8719_prepare,
+	.enable = ebbg_ft8719_enable,
+	.disable = ebbg_ft8719_disable,
 	.unprepare = ebbg_ft8719_unprepare,
 	.get_modes = ebbg_ft8719_get_modes,
 };
 
 static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
 	struct ebbg_ft8719 *ctx;

-- 
2.55.0


