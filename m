Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61599C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F9910F4D8;
	Tue, 15 Sep 2026 15:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a9GGHzRa";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9917D10E097
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:47:04 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so1653273f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789487223; x=1790092023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uzCg6OBZUcUYAx3OaMdOACh0u4h8Pv6g2Vq3JQp8FD4=;
 b=a9GGHzRa3tP/MVtZbs+4MZdUyngAIslc5rj0kR5RnbASC2+NgZtD3txkK0iRsyhZIX
 SfUQMOMLSHbdlvNZKLukHbpq4vkmamsId4gltvjipyrx2fpXuSbguGSD7/NcOFJReo5J
 y8Uute8dIKOalHJvkCUdtMo56OOItndRc9KCfduAIfdZSsat0A8QiE1ZxN/44BGrXKwF
 flZ7GEQEuYIdZzE5KYXgMPtoq9YZdq4GScTK4u+TrIIrfD3COALxDRp4j7wDQOv6DvW7
 CUPv10o2CcShBAUXdbQK7+XQGAMeh44HdTKmCcVwZcNpYC9RBI4vzZ14U8ex/hC7X7Ny
 amzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487223; x=1790092023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uzCg6OBZUcUYAx3OaMdOACh0u4h8Pv6g2Vq3JQp8FD4=;
 b=CYZxCF73IctcTDatp+5IR5Om9656VjPxiZFrob4QC6KdLotrQZnX6FYWIlT0303PCa
 xzuo7kRbU4xMQpB6uwc/MxVBVcX6Dk1GPQHEysYOOK+1Dkd/N/AQCI+zTeo+RX1DlSJU
 WlrK9qhB8z1mDIthzQbE4Ye35szVWCmffquelvt9Y9W20MWe7nPokMR7YQZ5/aFttBbi
 55alQXyeFCuVoTn+g9p1fymbMvo1ripz8Rl3QNOfSY8S0uP9wVjm3sypl9UUERkxcU7r
 E0LM4R1lEFrjJP0CIGUltli0tA1JEof4ZUmX8vADDOmNxg8jSuHwelYhWmfpXAxkA2En
 1lfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVpIdil/c67Xg8IUJ6/9sfTTrI952Av1yDMf8vxAFxMLvw0EDbno28kO3WjFP4T+wmEMxmg8suCwM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mglnJyOmw6WU2ry3w4gGUcXUlQezyqutTKdCPbUYgp3HMa+7/a
 YUV6UuBPAJqqDpORdszDsQkk7Zwye+RXjCk+qzvYaUCAFU79Fse6zXmY
X-Gm-Gg: AYBFou28fUNUasLySaVgUAd1916uB4ThHiYovnIMbGqo+4iTdXdbKRoQvgfFWDxW2Z3
 gJ0SF138htOxRNsDNULKdrJPs7AzeiKzNLtWItRz+8ygYzTqqXIXXRaoT1izRiB7JgiqI4vAhCo
 lzhW/aPeLIPiZN1GpvysI8FybiyaDXzv+UgxulUadD5GqZPakkftxouxBTh2j7/MGTSXF3ZnlJ0
 qtJ+5k66TSHRV4pXZ3/K2ibG3N2kWIVvUoo/V2CrEcvY4fzRD2WhJpKVCbzoJgA+i3BdmLyrLUz
 KosfcpkC/CxowuPE3dnWxH63ay6Xyb7p/5n9tywpZX1FLU/fPgxpyH6qZJ5sFrEa7HO4JRGPRz9
 gn+CgYBtDCuCEb07feVV++T/6PEfQId/Owl/nAT3GymJIX8YHxcAChoPt1h+jTk5zNJ4iRKcx2s
 G43usAeEBoLWyK+wr4Io6ewEYGOKvwMRUW5Pifs+CDiQp9exRwg0OC01KKbJtzQXVNPJemwRl8I
 gFC4myksaXu1YuW26dA8pLhMVOPBiy/pTo=
X-Received: by 2002:a5d:6f17:0:b0:486:f980:2367 with SMTP id
 ffacd0b85a97d-48702b6f168mr9963505f8f.48.1789487222696; 
 Tue, 15 Sep 2026 08:47:02 -0700 (PDT)
Received: from osama.. ([156.223.70.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fc02sm34160468f8f.16.2026.09.15.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:47:02 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Linus Walleij <linusw@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Robert Chiras <robert.chiras@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v6 2/3] drm/panel: Use managed helpers in Novatek and Raydium
 panels
Date: Tue, 15 Sep 2026 17:46:39 +0200
Message-ID: <20260915154644.104460-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915154644.104460-1-osama.abdelkader@gmail.com>
References: <20260915154644.104460-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach and panel add helpers in Novatek and Raydium
panel drivers and drop the corresponding manual detach and panel remove
calls from remove paths.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v5:
- nt35510: keep mipi_dsi_attach()/mipi_dsi_detach() manual instead of
  devm_mipi_dsi_attach(), since nt35510_remove() also powers off the
  panel; deferring the detach to devm would run it after the power-off
  instead of before it, changing the teardown order. (Luca)
v4:
- use devm_drm_panel_add instead of drm_panel_add.

 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 13 ++++++----
 drivers/gpu/drm/panel/panel-novatek-nt35532.c | 23 ++++-------------
 drivers/gpu/drm/panel/panel-novatek-nt35560.c | 19 +++-----------
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 25 ++-----------------
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 21 ++++------------
 .../gpu/drm/panel/panel-novatek-nt37700f.c    | 23 ++++-------------
 drivers/gpu/drm/panel/panel-novatek-nt37801.c | 23 ++++-------------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c | 22 +++-------------
 drivers/gpu/drm/panel/panel-raydium-rm67200.c | 23 ++++-------------
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 16 +++---------
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 20 +++------------
 11 files changed, 49 insertions(+), 179 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 3189d89c7ca0..86d1a19afb7b 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1173,11 +1173,13 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 		nt->panel.backlight = bl;
 	}
 
-	drm_panel_add(&nt->panel);
+	ret = devm_drm_panel_add(dev, &nt->panel);
+	if (ret)
+		return ret;
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0)
-		drm_panel_remove(&nt->panel);
+		return ret;
 
 	return 0;
 }
@@ -1187,13 +1189,14 @@ static void nt35510_remove(struct mipi_dsi_device *dsi)
 	struct nt35510 *nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
 
-	mipi_dsi_detach(dsi);
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
 	/* Power off */
 	ret = nt35510_power_off(nt);
 	if (ret)
 		dev_err(&dsi->dev, "Failed to power off\n");
-
-	drm_panel_remove(&nt->panel);
 }
 
 /*
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35532.c b/drivers/gpu/drm/panel/panel-novatek-nt35532.c
index edea766a3c44..752144220514 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35532.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35532.c
@@ -752,29 +752,17 @@ static int nt35532_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void nt35532_remove(struct mipi_dsi_device *dsi)
-{
-	struct novatek_nt35532 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id nt35532_of_match[] = {
 	{ .compatible = "flipkart,rimob-panel-nt35532-cs", .data = &rimob_panel_desc },
 	{ /* sentinel */ }
@@ -783,7 +771,6 @@ MODULE_DEVICE_TABLE(of, nt35532_of_match);
 
 static struct mipi_dsi_driver nt35532_driver = {
 	.probe = nt35532_probe,
-	.remove = nt35532_remove,
 	.driver = {
 		.name = "panel-novatek-nt35532",
 		.of_match_table = nt35532_of_match,
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 6e5173f98a22..be42eb9ef423 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -433,23 +433,11 @@ static int nt35560_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(nt->panel.backlight),
 				     "failed to register backlight device\n");
 
-	drm_panel_add(&nt->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&nt->panel);
+	ret = devm_drm_panel_add(dev, &nt->panel);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static void nt35560_remove(struct mipi_dsi_device *dsi)
-{
-	struct nt35560 *nt = mipi_dsi_get_drvdata(dsi);
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&nt->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id nt35560_of_match[] = {
@@ -467,7 +455,6 @@ MODULE_DEVICE_TABLE(of, nt35560_of_match);
 
 static struct mipi_dsi_driver nt35560_driver = {
 	.probe = nt35560_probe,
-	.remove = nt35560_remove,
 	.driver = {
 		.name = "panel-novatek-nt35560",
 		.of_match_table = nt35560_of_match,
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 464d9ce47d87..da466cdd9354 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -428,9 +428,7 @@ static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&pinfo->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &pinfo->base);
 }
 
 static int nt36672a_panel_probe(struct mipi_dsi_device *dsi)
@@ -458,25 +456,7 @@ static int nt36672a_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	if (err < 0) {
-		drm_panel_remove(&pinfo->base);
-		return err;
-	}
-
-	return 0;
-}
-
-static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct nt36672a_panel *pinfo = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	drm_panel_remove(&pinfo->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id tianma_fhd_video_of_match[] = {
@@ -491,7 +471,6 @@ static struct mipi_dsi_driver nt36672a_panel_driver = {
 		.of_match_table = tianma_fhd_video_of_match,
 	},
 	.probe = nt36672a_panel_probe,
-	.remove = nt36672a_panel_remove,
 };
 module_mipi_dsi_driver(nt36672a_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index c5e00eb55722..85902338f10d 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -561,27 +561,17 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		goto err_dsi_attach;
+		return ret;
 	}
 
 	return 0;
-
-err_dsi_attach:
-	drm_panel_remove(&ctx->panel);
-	return ret;
-}
-
-static void nt36672e_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct nt36672e_panel *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(ctx->dsi);
-	drm_panel_remove(&ctx->panel);
 }
 
 static const struct of_device_id nt36672e_of_match[] = {
@@ -599,7 +589,6 @@ static struct mipi_dsi_driver nt36672e_panel_driver = {
 		.of_match_table = nt36672e_of_match,
 	},
 	.probe = nt36672e_panel_probe,
-	.remove = nt36672e_panel_remove,
 };
 module_mipi_dsi_driver(nt36672e_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
index c221dd498fed..c2d219e52f6a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
@@ -257,29 +257,17 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void nt37700f_tianma_remove(struct mipi_dsi_device *dsi)
-{
-	struct nt37700f_tianma *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id nt37700f_tianma_of_match[] = {
 	{ .compatible = "novatek,nt37700f" },
 	{ /* sentinel */ }
@@ -288,7 +276,6 @@ MODULE_DEVICE_TABLE(of, nt37700f_tianma_of_match);
 
 static struct mipi_dsi_driver nt37700f_tianma_driver = {
 	.probe = nt37700f_tianma_probe,
-	.remove = nt37700f_tianma_remove,
 	.driver = {
 		.name = "panel-novatek-nt37700f",
 		.of_match_table = nt37700f_tianma_of_match,
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index 5e46c4c6d771..4db560b66f4d 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -270,7 +270,9 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	/* This panel only supports DSC; unconditionally enable it */
 	dsi->dsc = &ctx->dsc;
@@ -283,27 +285,13 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	ctx->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void novatek_nt37801_remove(struct mipi_dsi_device *dsi)
-{
-	struct novatek_nt37801 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id novatek_nt37801_of_match[] = {
 	{ .compatible = "novatek,nt37801" },
 	{}
@@ -312,7 +300,6 @@ MODULE_DEVICE_TABLE(of, novatek_nt37801_of_match);
 
 static struct mipi_dsi_driver novatek_nt37801_driver = {
 	.probe = novatek_nt37801_probe,
-	.remove = novatek_nt37801_remove,
 	.driver = {
 		.name = "panel-novatek-nt37801",
 		.of_match_table = novatek_nt37801_of_match,
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 2af6aa47a551..62062ae0ebe3 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -590,26 +590,11 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 
 	dev_set_drvdata(dev, panel);
 
-	drm_panel_add(&panel->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		drm_panel_remove(&panel->panel);
-
-	return ret;
-}
-
-static void rad_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
+	ret = devm_drm_panel_add(dev, &panel->panel);
 	if (ret)
-		dev_err(dev, "Failed to detach from host (%d)\n", ret);
+		return ret;
 
-	drm_panel_remove(&rad->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id rad_of_match[] = {
@@ -624,7 +609,6 @@ static struct mipi_dsi_driver rad_panel_driver = {
 		.of_match_table = rad_of_match,
 	},
 	.probe = rad_panel_probe,
-	.remove = rad_panel_remove,
 };
 module_mipi_dsi_driver(rad_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67200.c b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
index b2ba006c06f6..e16f9ad6d193 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
@@ -420,29 +420,17 @@ static int raydium_rm67200_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
-	}
 
 	return ret;
 }
 
-static void raydium_rm67200_remove(struct mipi_dsi_device *dsi)
-{
-	struct raydium_rm67200 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct regulator_bulk_data w552793baa_regulators[] = {
 	{ .supply = "vdd", },		/*  2.8V */
 	{ .supply = "iovcc", },		/*  1.8V */
@@ -479,7 +467,6 @@ MODULE_DEVICE_TABLE(of, raydium_rm67200_of_match);
 
 static struct mipi_dsi_driver raydium_rm67200_driver = {
 	.probe = raydium_rm67200_probe,
-	.remove = raydium_rm67200_remove,
 	.driver = {
 		.name = "panel-raydium-rm67200",
 		.of_match_table = raydium_rm67200_of_match,
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931903..f235cb4ae071 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -360,26 +360,19 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach() failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void rm68200_remove(struct mipi_dsi_device *dsi)
-{
-	struct rm68200 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id raydium_rm68200_of_match[] = {
 	{ .compatible = "raydium,rm68200" },
 	{ }
@@ -388,7 +381,6 @@ MODULE_DEVICE_TABLE(of, raydium_rm68200_of_match);
 
 static struct mipi_dsi_driver raydium_rm68200_driver = {
 	.probe = rm68200_probe,
-	.remove = rm68200_remove,
 	.driver = {
 		.name = "panel-raydium-rm68200",
 		.of_match_table = raydium_rm68200_of_match,
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index 8e9484768657..4065cdf690f9 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -315,7 +315,9 @@ static int rm692e5_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	/* This panel only supports DSC; unconditionally enable it */
 	dsi->dsc = &ctx->dsc;
@@ -331,28 +333,15 @@ static int rm692e5_probe(struct mipi_dsi_device *dsi)
 	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	ctx->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void rm692e5_remove(struct mipi_dsi_device *dsi)
-{
-	struct rm692e5_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id rm692e5_of_match[] = {
 	{ .compatible = "fairphone,fp5-rm692e5-boe" },
 	{ }
@@ -361,7 +350,6 @@ MODULE_DEVICE_TABLE(of, rm692e5_of_match);
 
 static struct mipi_dsi_driver rm692e5_driver = {
 	.probe = rm692e5_probe,
-	.remove = rm692e5_remove,
 	.driver = {
 		.name = "panel-rm692e5-boe-amoled",
 		.of_match_table = rm692e5_of_match,
-- 
2.43.0

