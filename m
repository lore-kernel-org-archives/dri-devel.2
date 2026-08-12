Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A52C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFB910F058;
	Wed, 12 Aug 2026 15:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TqtHcw0I";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1497010F058
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:10:05 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4956869750eso6581655e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786547403; x=1787152203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AQVNKUE+2hv/nyQaIYFaSOsEs/Rbw0Wp9MEMFm9oMXE=;
 b=TqtHcw0IEWdM8cDanGefoMQKhk8Mgim2ZxJnV+53zirQhAT/XMYdR1QKgSYnI/4Pkd
 eV8kfWmb4eA2W233Vgu54YZZkE+Wn9NkqWovjzEXb57+ky+TPufeX2OY6URIzSB6eEEo
 7t/SAxlit7VhwLFhWvwVrxl++E8fcndsvevKKpytLddd8EUr3rvugAthUp3XIsmovTx1
 BpAdgLVa6XoTiruF0NDoU+qxuWhD/gAwXMr6NnxjsncGFvMptJbpCzT+WaQrAocZBGjX
 EAuIz9Ie3BLhOZA1iDZAYI2E1fay2fPFEunFq9DXN302liqBjaZjKZXsuwj4No2k+01X
 wUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786547403; x=1787152203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AQVNKUE+2hv/nyQaIYFaSOsEs/Rbw0Wp9MEMFm9oMXE=;
 b=r8mY7HBtgv0Qdj9RToVoRcvGTQ/kNrWERQxVw1NH8cZ4gezwgCUnRp/9pcQsnyNgdk
 Hw4pOlPwH//eBXdjAghso+9ubfwErIJVSZkUEWK27urVa2S4YGGbfA1Rs+YyhW3pnrlO
 0U1gvWem66UHw+Vyp/U3HBYZS4gdkdOyx2G1stBpRDvEJqvupxtNPycoErCNR+jqrlN8
 TnIC/GT3fvLnNQol5QW9YUykZb1m1a9W5MVho/bI4z5TNV7yq/LvPwU81V8Ir5It2WuK
 pzZDWjVZsEFG6/OJdv7TF6uUzA8G2b2t91vGCw48v3+Wycda6Fki6Q/+B5Lhq6JfShqX
 jXVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpbgtZK4a4qTZJLz/Ol49w9G9Vt6BzwSbyWwoHWsVijvUgthmGTsVm5P/r06j6wEzQieIBe5G4OW+0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcZKNrGSXFcGeSLxWpfGi+OjNZUC7flsurqPUeQnvqHs+8ZZVv
 6oknxqX4NfO2JZ6FCjvJJ7CyG9aXDO2mymbuDxhF7GGePlHsN5JQfdgm
X-Gm-Gg: AR+sD11kRkG2W0l5kYdtdYcznb1OZazlbWhCMbzUtTQED4jbrJ4mlHphfiqjqWMDA2x
 rk1EgPi9t5dUlT0ayWXtRmqgHTYDrumqEAJn8vaUq/TiOfn3NrnIxFw3gLq1+6JdxF2KzdLr1hw
 M04kz8sm1S7FAy+gHKH1178ak4dT9mLnd3J5meHwTxa3W3LCerju3I9FM9HZikmUkqvB4t046k7
 U5pUxJPwE6tIBGnw5VnKGv7ae3iWtW4lHlx8oi1HpksTOan7HmiFz+okvaOh7icW8mGh8ncOJ0o
 NF1HHG+76eWSNJ3Axf25j2lAQb1rDz+0EKfJAc2ZA7vPzI2oSMJWJ3Aiqqtnu7VM5duZ7ZMURn5
 57eYAE043qsq7lk46PE3K6mU3bsgLEAuzUcGn4J463kqin03vmt1QL88osbQI50MJEOeg8BxhOn
 TyqRgv14bBoRTv2GBzX5FIiw2mcy3YBWl5Ys7PMXw31GQEbuhanNkwcYK6xUjheh7fpSB8Ud+Uq
 vXE071MWRVtyva7vSJBAxZgtw==
X-Received: by 2002:a05:600c:1d20:b0:499:7ce1:d8a2 with SMTP id
 5b1f17b1804b1-4997ce1da7amr58659875e9.8.1786547403228; 
 Wed, 12 Aug 2026 08:10:03 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c94f4c0sm48743035e9.8.2026.08.12.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:10:02 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v4 4/6] drm/panel: Use managed helpers in Himax and Ilitek
 panels
Date: Wed, 12 Aug 2026 17:09:59 +0200
Message-ID: <20260812151000.74799-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Use the managed MIPI DSI attach and panel add helpers in Himax and Ilitek
panel drivers and drop the corresponding manual detach and panel remove
calls from remove paths.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v4:
- use devm_drm_panel_add instead of drm_panel_add.

 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 24 ++---------------
 drivers/gpu/drm/panel/panel-himax-hx83112a.c  | 24 ++++-------------
 drivers/gpu/drm/panel/panel-himax-hx83112b.c  | 23 ++++------------
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 26 +++++--------------
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c  | 21 +++------------
 .../drm/panel/panel-ilitek-ili9806e-core.c    | 12 +--------
 .../drm/panel/panel-ilitek-ili9806e-core.h    |  1 -
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c | 16 +-----------
 .../gpu/drm/panel/panel-ilitek-ili9806e-spi.c |  6 -----
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 15 +++--------
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 24 ++---------------
 11 files changed, 30 insertions(+), 162 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6a0851ccf9bb..3ef052571ce0 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -1284,9 +1284,7 @@ static int hx83102_panel_add(struct hx83102 *ctx)
 	ctx->base.funcs = &hx83102_drm_funcs;
 	ctx->base.dev = &ctx->dsi->dev;
 
-	drm_panel_add(&ctx->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &ctx->base);
 }
 
 static int hx83102_probe(struct mipi_dsi_device *dsi)
@@ -1318,24 +1316,7 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		drm_panel_remove(&ctx->base);
-
-	return ret;
-}
-
-static void hx83102_remove(struct mipi_dsi_device *dsi)
-{
-	struct hx83102 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	if (ctx->base.dev)
-		drm_panel_remove(&ctx->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id hx83102_of_match[] = {
@@ -1369,7 +1350,6 @@ MODULE_DEVICE_TABLE(of, hx83102_of_match);
 
 static struct mipi_dsi_driver hx83102_driver = {
 	.probe	= hx83102_probe,
-	.remove = hx83102_remove,
 	.driver = {
 		.name = "panel-himax-hx83102",
 		.of_match_table = hx83102_of_match,
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112a.c b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
index 142cb1cc067a..36ebfad7a3e9 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
@@ -303,28 +303,15 @@ static int hx83112a_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-		drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
-}
-
-static void hx83112a_remove(struct mipi_dsi_device *dsi)
-{
-	struct hx83112a_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 
-	drm_panel_remove(&ctx->panel);
+	return 0;
 }
 
 static const struct of_device_id hx83112a_of_match[] = {
@@ -335,7 +322,6 @@ MODULE_DEVICE_TABLE(of, hx83112a_of_match);
 
 static struct mipi_dsi_driver hx83112a_driver = {
 	.probe = hx83112a_probe,
-	.remove = hx83112a_remove,
 	.driver = {
 		.name = "panel-himax-hx83112a",
 		.of_match_table = hx83112a_of_match,
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112b.c b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
index 41f21f8c1373..569ed2dec87c 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112b.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
@@ -386,29 +386,17 @@ static int hx83112b_probe(struct mipi_dsi_device *dsi)
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
 
-static void hx83112b_remove(struct mipi_dsi_device *dsi)
-{
-	struct hx83112b_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id hx83112b_of_match[] = {
 	{ .compatible = "djn,98-03057-6598b-i" },
 	{ /* sentinel */ }
@@ -417,7 +405,6 @@ MODULE_DEVICE_TABLE(of, hx83112b_of_match);
 
 static struct mipi_dsi_driver hx83112b_driver = {
 	.probe = hx83112b_probe,
-	.remove = hx83112b_remove,
 	.driver = {
 		.name = "panel-himax-hx83112b",
 		.of_match_table = hx83112b_of_match,
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 09124610fdc8..4180d4aadf5e 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -1023,14 +1023,13 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
-		drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
 		return ret;
-	}
+
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
 
 	dev_dbg(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
 		ctx->desc->mode->hdisplay, ctx->desc->mode->vdisplay,
@@ -1040,18 +1039,6 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void hx8394_remove(struct mipi_dsi_device *dsi)
-{
-	struct hx8394 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id hx8394_of_match[] = {
 	{ .compatible = "hannstar,hsd060bhw4", .data = &hsd060bhw4_desc },
 	{ .compatible = "huiling,hl055fhav028c", .data = &hl055fhav028c_desc },
@@ -1065,7 +1052,6 @@ MODULE_DEVICE_TABLE(of, hx8394_of_match);
 
 static struct mipi_dsi_driver hx8394_driver = {
 	.probe	= hx8394_probe,
-	.remove = hx8394_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = hx8394_of_match,
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 5610a225f77b..976305991b7f 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -305,31 +305,19 @@ static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(&dsi->dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct ili9805 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct ili9805_desc gpm1780a0_desc = {
 	.init = gpm1780a0_init,
 	.mode = &gpm1780a0_timing,
@@ -353,7 +341,6 @@ MODULE_DEVICE_TABLE(of, ili9805_of_match);
 
 static struct mipi_dsi_driver ili9805_dsi_driver = {
 	.probe		= ili9805_dsi_probe,
-	.remove		= ili9805_dsi_remove,
 	.driver = {
 		.name		= "ili9805-dsi",
 		.of_match_table	= ili9805_of_match,
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
index 53e25d1086db..81d48c402aec 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c
@@ -112,21 +112,11 @@ int ili9806e_probe(struct device *dev, void *transport,
 	if (set_prepare_prev_first)
 		ctx->panel.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->panel);
-
-	return 0;
+	return devm_drm_panel_add(dev, &ctx->panel);
 
 }
 EXPORT_SYMBOL_GPL(ili9806e_probe);
 
-void ili9806e_remove(struct device *dev)
-{
-	struct ili9806e *ctx = dev_get_drvdata(dev);
-
-	drm_panel_remove(&ctx->panel);
-}
-EXPORT_SYMBOL_GPL(ili9806e_remove);
-
 MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 MODULE_AUTHOR("Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>");
 MODULE_AUTHOR("Michael Walle <mwalle@kernel.org>");
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
index dddece62cf42..fded4b6793e7 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.h
@@ -10,6 +10,5 @@ int ili9806e_power_on(struct device *dev);
 int ili9806e_probe(struct device *dev, void *transport,
 		   const struct drm_panel_funcs *funcs,
 		   int connector_type);
-void ili9806e_remove(struct device *dev);
 
 #endif /* _PANEL_ILITEK_ILI9806E_CORE_H */
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index 0fb06c425545..89915d58f69d 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -141,20 +141,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-		ili9806e_remove(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void ili9806e_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	mipi_dsi_detach(dsi);
-	ili9806e_remove(&dsi->dev);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static void com35h3p70ulc_init(struct mipi_dsi_multi_context *ctx)
@@ -490,7 +477,6 @@ static struct mipi_dsi_driver ili9806e_dsi_driver = {
 		.of_match_table = ili9806e_dsi_of_match,
 	},
 	.probe = ili9806e_dsi_probe,
-	.remove = ili9806e_dsi_remove,
 };
 module_mipi_dsi_driver(ili9806e_dsi_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
index 9d10b0d28f52..187bcb084dd9 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
@@ -124,11 +124,6 @@ static int ili9806e_spi_probe(struct spi_device *spi)
 			      DRM_MODE_CONNECTOR_DPI);
 }
 
-static void ili9806e_spi_remove(struct spi_device *spi)
-{
-	ili9806e_remove(&spi->dev);
-}
-
 static void rk050hr345_ct106a_init(struct ili9806e_spi_panel *ctx)
 {
 	struct mipi_dbi *dbi = &ctx->dbi;
@@ -313,7 +308,6 @@ static struct spi_driver ili9806e_spi_driver = {
 		.of_match_table = ili9806e_spi_of_match,
 	},
 	.probe = ili9806e_spi_probe,
-	.remove = ili9806e_spi_remove,
 	.id_table = ili9806e_spi_ids,
 };
 module_spi_driver(ili9806e_spi_driver);
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 3abdd0870e83..aee114a40cfd 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2591,21 +2591,15 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	dsi->mode_flags = ctx->desc->mode_flags;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = ctx->desc->lanes;
 
-	return mipi_dsi_attach(dsi);
-}
-
-static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct ili9881c_desc lhr050h41_desc = {
@@ -2719,7 +2713,6 @@ MODULE_DEVICE_TABLE(of, ili9881c_of_match);
 
 static struct mipi_dsi_driver ili9881c_dsi_driver = {
 	.probe		= ili9881c_dsi_probe,
-	.remove		= ili9881c_dsi_remove,
 	.driver = {
 		.name		= "ili9881c-dsi",
 		.of_match_table	= ili9881c_of_match,
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 6d07fe901357..d4b383138488 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -809,9 +809,7 @@ static int ili9882t_add(struct ili9882t *ili)
 	ili->base.funcs = &ili9882t_funcs;
 	ili->base.dev = &ili->dsi->dev;
 
-	drm_panel_add(&ili->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &ili->base);
 }
 
 static int ili9882t_probe(struct mipi_dsi_device *dsi)
@@ -844,24 +842,7 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ili);
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		drm_panel_remove(&ili->base);
-
-	return ret;
-}
-
-static void ili9882t_remove(struct mipi_dsi_device *dsi)
-{
-	struct ili9882t *ili = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	if (ili->base.dev)
-		drm_panel_remove(&ili->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id ili9882t_of_match[] = {
@@ -881,7 +862,6 @@ static struct mipi_dsi_driver ili9882t_driver = {
 		.of_match_table = ili9882t_of_match,
 	},
 	.probe = ili9882t_probe,
-	.remove = ili9882t_remove,
 };
 module_mipi_dsi_driver(ili9882t_driver);
 
-- 
2.43.0

