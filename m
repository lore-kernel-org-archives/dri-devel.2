Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DB6C5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 517E710F038;
	Wed, 12 Aug 2026 14:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q4buL87U";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4673510F038
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:44:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49978908b35so7913255e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786545870; x=1787150670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fqsCN6MHHQjQgZFfqVdeIcPU5Rw7KALn7qpNmc13cZY=;
 b=q4buL87UbZHw/Xf3NiTPRC1PwvfsLJsI9VnqGqNTIi/lO+kf3qfUKF6BcMVrU4MTFu
 Xh5sZYlX1sMgA8fpsHQTHjMi2w8SK9uvqrQcCUT0IX4DR0KZkUG3nBTOPLzRoCUBf0Yk
 U1QrBWl/YCiNxh1BggAUgYqTGC0agOYVNcETuOyLUgrwbNgp1WldgqVobkrs8ewqytNB
 PzTYiQ3GekD/8WAlSNQ3+G+PEAFXPFH62CLOWRekWoWY1WEXFSmMmO5d+JpyTtHk93oZ
 ZYgSa2gVVGkcr6tzAUB/kOpvTC4CBBouj2wt11knljABV/vEWu6zRJdZqvN0cFHjl8BJ
 4MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786545870; x=1787150670;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fqsCN6MHHQjQgZFfqVdeIcPU5Rw7KALn7qpNmc13cZY=;
 b=Gp5ul9jH3TFKvnrEps/ZuPwkBALHqJuCZxPLOOTcpFULNDv1HAzNev+oXrj8TC7FBb
 C0ECiDFI/A8ngpJxITZu4MFcge4U3kI4hLPyWeqTE6pS0/3zG7Tj9EW+glnBiaPN9Vh7
 1qIJcc5oFllWEgJBmN7d6R750+ugIjpSAr9Yd7c6AivfHf8vRTzYhKzGwJECQalMPQY2
 MAPrzrcg4QtH1uP3u+wosW6v63oHRkzE8cBU1bmoCKfQwIvyFrRvgsWy4L6p9T31QbC7
 BwpHVLXtKlz+HcHW1xitI5fFqVy5i3q//pR3lEtXpaTaFl7vvmYux9y7wQoRKgmAvt/0
 ObEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1S3JM9geSnc77w8sreeq9rBcJkKLlNdABAed0VZZePQlux0fbthIJigPBnQadEEK5m1cH0uldFGU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzelQtyrx6qPO8nwa/aGU8nu5OdtnwodDxWzeGS8O2w5oVV7Cvr
 bd/yogaTgkQTZnxJnkrU963L6OgO0SGJUaYSsRy+UogsqyX1ibbdjFJ2
X-Gm-Gg: AR+sD106MBe0WyvqVlEvrOqR6+FE0rPZRT+uD1i1DzkhCYSoYvF8CG3z4ezRZToZLyB
 9ko0Usk8zfsYsDEICLXoYKOVDSR6Txiu5LRDUrPIxGp7Tt2+PHcFkaGl2zvE58/cPcwvYBUrVaj
 hFVq6U4cjZUOayvIPc7JhdUFuyBCEKzxHCKKHIbTSAqwUhfvy5X/x2us7D1WxSY3wjM2QtKhhrQ
 OlXEgwb4gtRUAgIhKtqb8GHzwve6ZPGK+KEJK/hNk9UWLx1/eXZhrf8V5LxVnEWCwkO4klx3z2w
 yq13y30xMae+RZCoRnOpTt1byNjZMbFyGGPuiymoEQ6cIiXLmfms5zoc+QyTxMMVvTXTBj3e2iA
 N3CXo6dC7RxvrGuRPq1k9HQzNzBBAVshzeJeq2RyeUCfPYHQTrADVI4DrStxJVhyyKHmYXAU2PD
 h5tsfWdpbQg88XE7ZIrH3CjhNkAyWFaIfL5p+Hbn+6kyuO2LaxCAumNHc38fiFfHcIPVB2ayr5a
 NwYvSUYsonQDg5x2Ec23Y75wt/QsWkHi+P0
X-Received: by 2002:a7b:c7ca:0:b0:495:4e89:3f30 with SMTP id
 5b1f17b1804b1-4997c13c8ccmr60248645e9.15.1786545869329; 
 Wed, 12 Aug 2026 07:44:29 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaaecabsm81851085e9.5.2026.08.12.07.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:44:28 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Artur Weber <aweber.kernel@gmail.com>,
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Yedaya Katsman <yedaya.ka@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v4 2/6] drm/panel: Use managed helpers in Samsung panels
Date: Wed, 12 Aug 2026 16:44:21 +0200
Message-ID: <20260812144426.62074-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Use the managed MIPI DSI attach and panel add helpers in Samsung panel
drivers and drop the corresponding manual detach and panel remove calls
from remove paths. Also, switch to devm_backlight_device_register in
s6e3ha2 and s6e63j0x03.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v4:
- use devm_drm_panel_add instead of drm_panel_add.
- switch to devm_backlight_device_register in s6e3ha2 and s6e63j0x03.

 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 19 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c  | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c | 30 ++++--------------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c  | 31 ++++---------------
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c | 13 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c |  6 ----
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c | 12 +------
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.h |  1 -
 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c  | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c  | 20 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c | 19 +++---------
 drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c | 23 +++-----------
 drivers/gpu/drm/panel/panel-samsung-sofef00.c | 20 +++---------
 16 files changed, 55 insertions(+), 239 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 54a65abf7e89..cdede494e32f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -207,21 +207,11 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_add(&s6->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		drm_panel_remove(&s6->panel);
-
-	return ret;
-}
-
-static void s6d16d0_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6d16d0 *s6 = mipi_dsi_get_drvdata(dsi);
+	ret = devm_drm_panel_add(dev, &s6->panel);
+	if (ret)
+		return ret;
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&s6->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id s6d16d0_of_match[] = {
@@ -232,7 +222,6 @@ MODULE_DEVICE_TABLE(of, s6d16d0_of_match);
 
 static struct mipi_dsi_driver s6d16d0_driver = {
 	.probe = s6d16d0_probe,
-	.remove = s6d16d0_remove,
 	.driver = {
 		.name = "panel-samsung-s6d16d0",
 		.of_match_table = s6d16d0_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index 692020081524..5a4cfb21e2fd 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -436,30 +436,19 @@ static int s6d7aa0_probe(struct mipi_dsi_device *dsi)
 					     "Failed to create backlight\n");
 	}
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6d7aa0_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6d7aa0 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id s6d7aa0_of_match[] = {
 	{
 		.compatible = "samsung,lsl080al02",
@@ -479,7 +468,6 @@ MODULE_DEVICE_TABLE(of, s6d7aa0_of_match);
 
 static struct mipi_dsi_driver s6d7aa0_driver = {
 	.probe = s6d7aa0_probe,
-	.remove = s6d7aa0_remove,
 	.driver = {
 		.name = "panel-samsung-s6d7aa0",
 		.of_match_table = s6d7aa0_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
index f4d75eca3cdf..9cd92d7a823b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
@@ -211,30 +211,19 @@ static int s6e3fa7_panel_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6e3fa7_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e3fa7_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id s6e3fa7_panel_of_match[] = {
 	{ .compatible = "samsung,s6e3fa7-ams559nk06" },
 	{ /* sentinel */ }
@@ -243,7 +232,6 @@ MODULE_DEVICE_TABLE(of, s6e3fa7_panel_of_match);
 
 static struct mipi_dsi_driver s6e3fa7_panel_driver = {
 	.probe = s6e3fa7_panel_probe,
-	.remove = s6e3fa7_panel_remove,
 	.driver = {
 		.name = "panel-samsung-s6e3fa7",
 		.of_match_table = s6e3fa7_panel_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
index e63080204af7..8dfe654f36ec 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
@@ -340,30 +340,19 @@ static int s6e3fc2x01_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6e3fc2x01_remove(struct mipi_dsi_device *dsi)
-{
-	struct samsung_s6e3fc2x01 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id s6e3fc2x01_of_match[] = {
 	{ .compatible = "samsung,s6e3fc2x01-ams641rw", .data = &ams641rw_mode },
 	{ /* sentinel */ }
@@ -372,7 +361,6 @@ MODULE_DEVICE_TABLE(of, s6e3fc2x01_of_match);
 
 static struct mipi_dsi_driver s6e3fc2x01_driver = {
 	.probe = s6e3fc2x01_probe,
-	.remove = s6e3fc2x01_remove,
 	.driver = {
 		.name = "panel-samsung-s6e3fc2x01",
 		.of_match_table = s6e3fc2x01_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index 1db0c63b1131..cede897ff69d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -722,8 +722,8 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->enable_gpio);
 	}
 
-	ctx->bl_dev = backlight_device_register("s6e3ha2", dev, ctx,
-						&s6e3ha2_bl_ops, NULL);
+	ctx->bl_dev = devm_backlight_device_register(dev, "s6e3ha2", dev, ctx,
+						     &s6e3ha2_bl_ops, NULL);
 	if (IS_ERR(ctx->bl_dev)) {
 		dev_err(dev, "failed to register backlight device\n");
 		return PTR_ERR(ctx->bl_dev);
@@ -735,28 +735,11 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		goto remove_panel;
-
-	return ret;
-
-remove_panel:
-	drm_panel_remove(&ctx->panel);
-	backlight_device_unregister(ctx->bl_dev);
-
-	return ret;
-}
-
-static void s6e3ha2_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e3ha2 *ctx = mipi_dsi_get_drvdata(dsi);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-	backlight_device_unregister(ctx->bl_dev);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id s6e3ha2_of_match[] = {
@@ -768,7 +751,6 @@ MODULE_DEVICE_TABLE(of, s6e3ha2_of_match);
 
 static struct mipi_dsi_driver s6e3ha2_driver = {
 	.probe = s6e3ha2_probe,
-	.remove = s6e3ha2_remove,
 	.driver = {
 		.name = "panel-samsung-s6e3ha2",
 		.of_match_table = s6e3ha2_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 550e9ef9bb71..c09ff71b9c39 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -283,7 +283,9 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 
 	priv->panel.prepare_prev_first = true;
 
-	drm_panel_add(&priv->panel);
+	ret = devm_drm_panel_add(dev, &priv->panel);
+	if (ret)
+		return ret;
 
 	/* This panel only supports DSC; unconditionally enable it */
 	dsi->dsc = &priv->dsc;
@@ -299,28 +301,15 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 	priv->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	priv->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&priv->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6e3ha8_amb577px01_wqhd_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e3ha8 *priv = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&priv->panel);
-}
-
 static const struct of_device_id s6e3ha8_amb577px01_wqhd_of_match[] = {
 	{ .compatible = "samsung,s6e3ha8" },
 	{ /* sentinel */ }
@@ -329,7 +318,6 @@ MODULE_DEVICE_TABLE(of, s6e3ha8_amb577px01_wqhd_of_match);
 
 static struct mipi_dsi_driver s6e3ha8_amb577px01_wqhd_driver = {
 	.probe = s6e3ha8_amb577px01_wqhd_probe,
-	.remove = s6e3ha8_amb577px01_wqhd_remove,
 	.driver = {
 		.name = "panel-s6e3ha8",
 		.of_match_table = s6e3ha8_amb577px01_wqhd_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index e05199ce14ee..1f825d995686 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -465,8 +465,8 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	ctx->bl_dev = backlight_device_register("s6e63j0x03", dev, ctx,
-						&s6e63j0x03_bl_ops, NULL);
+	ctx->bl_dev = devm_backlight_device_register(dev, "s6e63j0x03", dev, ctx,
+						     &s6e63j0x03_bl_ops, NULL);
 	if (IS_ERR(ctx->bl_dev))
 		return dev_err_probe(dev, PTR_ERR(ctx->bl_dev),
 				     "failed to register backlight device\n");
@@ -475,29 +475,11 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 	ctx->bl_dev->props.brightness = DEFAULT_BRIGHTNESS;
 	ctx->bl_dev->props.power = BACKLIGHT_POWER_OFF;
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		goto remove_panel;
-
-	return ret;
-
-remove_panel:
-	drm_panel_remove(&ctx->panel);
-	backlight_device_unregister(ctx->bl_dev);
-
-	return ret;
-}
-
-static void s6e63j0x03_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e63j0x03 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	backlight_device_unregister(ctx->bl_dev);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id s6e63j0x03_of_match[] = {
@@ -508,7 +490,6 @@ MODULE_DEVICE_TABLE(of, s6e63j0x03_of_match);
 
 static struct mipi_dsi_driver s6e63j0x03_driver = {
 	.probe = s6e63j0x03_probe,
-	.remove = s6e63j0x03_remove,
 	.driver = {
 		.name = "panel_samsung_s6e63j0x03",
 		.of_match_table = s6e63j0x03_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
index 2630975c111b..c3842449c895 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
@@ -105,17 +105,7 @@ static int s6e63m0_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		s6e63m0_remove(dev);
-
-	return ret;
-}
-
-static void s6e63m0_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	mipi_dsi_detach(dsi);
-	s6e63m0_remove(&dsi->dev);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id s6e63m0_dsi_of_match[] = {
@@ -126,7 +116,6 @@ MODULE_DEVICE_TABLE(of, s6e63m0_dsi_of_match);
 
 static struct mipi_dsi_driver s6e63m0_dsi_driver = {
 	.probe			= s6e63m0_dsi_probe,
-	.remove			= s6e63m0_dsi_remove,
 	.driver			= {
 		.name		= "panel-samsung-s6e63m0",
 		.of_match_table = s6e63m0_dsi_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
index d99afcc672ca..c8bec2b1e7c1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-spi.c
@@ -62,11 +62,6 @@ static int s6e63m0_spi_probe(struct spi_device *spi)
 			     s6e63m0_spi_dcs_write, false);
 }
 
-static void s6e63m0_spi_remove(struct spi_device *spi)
-{
-	s6e63m0_remove(&spi->dev);
-}
-
 static const struct of_device_id s6e63m0_spi_of_match[] = {
 	{ .compatible = "samsung,s6e63m0" },
 	{ /* sentinel */ }
@@ -75,7 +70,6 @@ MODULE_DEVICE_TABLE(of, s6e63m0_spi_of_match);
 
 static struct spi_driver s6e63m0_spi_driver = {
 	.probe			= s6e63m0_spi_probe,
-	.remove			= s6e63m0_spi_remove,
 	.driver			= {
 		.name		= "panel-samsung-s6e63m0",
 		.of_match_table = s6e63m0_spi_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index 997115b1e541..1990a7c23219 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -720,20 +720,10 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 	if (ret < 0)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
-
-	return 0;
+	return devm_drm_panel_add(dev, &ctx->panel);
 }
 EXPORT_SYMBOL_GPL(s6e63m0_probe);
 
-void s6e63m0_remove(struct device *dev)
-{
-	struct s6e63m0 *ctx = dev_get_drvdata(dev);
-
-	drm_panel_remove(&ctx->panel);
-}
-EXPORT_SYMBOL_GPL(s6e63m0_remove);
-
 MODULE_AUTHOR("Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>");
 MODULE_DESCRIPTION("s6e63m0 LCD Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
index c926eca1c817..7dae6772899c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.h
@@ -35,6 +35,5 @@ int s6e63m0_probe(struct device *dev, void *trsp,
 				   const u8 *data,
 				   size_t len),
 		  bool dsi_mode);
-void s6e63m0_remove(struct device *dev);
 
 #endif /* _PANEL_SAMSUNG_S6E63M0_H */
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
index 77fee36dbb55..b48a2f9578e7 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
@@ -722,30 +722,19 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6e88a0_ams427ap24_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e88a0_ams427ap24 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id s6e88a0_ams427ap24_of_match[] = {
 	{ .compatible = "samsung,s6e88a0-ams427ap24" },
 	{ /* sentinel */ },
@@ -754,7 +743,6 @@ MODULE_DEVICE_TABLE(of, s6e88a0_ams427ap24_of_match);
 
 static struct mipi_dsi_driver s6e88a0_ams427ap24_driver = {
 	.probe = s6e88a0_ams427ap24_probe,
-	.remove = s6e88a0_ams427ap24_remove,
 	.driver = {
 		.name = "panel-s6e88a0-ams427ap24",
 		.of_match_table = s6e88a0_ams427ap24_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index ca5cad41ff1d..bbb86ea86d5e 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -194,30 +194,19 @@ static int s6e88a0_ams452ef01_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void s6e88a0_ams452ef01_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e88a0_ams452ef01 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id s6e88a0_ams452ef01_of_match[] = {
 	{ .compatible = "samsung,s6e88a0-ams452ef01" },
 	{ /* sentinel */ },
@@ -226,7 +215,6 @@ MODULE_DEVICE_TABLE(of, s6e88a0_ams452ef01_of_match);
 
 static struct mipi_dsi_driver s6e88a0_ams452ef01_driver = {
 	.probe = s6e88a0_ams452ef01_probe,
-	.remove = s6e88a0_ams452ef01_remove,
 	.driver = {
 		.name = "panel-s6e88a0-ams452ef01",
 		.of_match_table = s6e88a0_ams452ef01_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 1b5c500d4f4e..8f160ca0a94e 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -1018,21 +1018,11 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		drm_panel_remove(&ctx->panel);
-
-	return ret;
-}
-
-static void s6e8aa0_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e8aa0 *ctx = mipi_dsi_get_drvdata(dsi);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id s6e8aa0_of_match[] = {
@@ -1043,7 +1033,6 @@ MODULE_DEVICE_TABLE(of, s6e8aa0_of_match);
 
 static struct mipi_dsi_driver s6e8aa0_driver = {
 	.probe = s6e8aa0_probe,
-	.remove = s6e8aa0_remove,
 	.driver = {
 		.name = "panel-samsung-s6e8aa0",
 		.of_match_table = s6e8aa0_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
index 2fae0dc6c424..0e797a2ec14f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
@@ -256,29 +256,17 @@ static int s6e8fc0_m1906f9_probe(struct mipi_dsi_device *dsi)
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
 
-static void s6e8fc0_remove(struct mipi_dsi_device *dsi)
-{
-	struct s6e8fc0_ctx *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id samsung_s6e8fc0_of_match[] = {
 	{ .compatible = "samsung,s6e8fc0-m1906f9" },
 	{ /* sentinel */ }
@@ -287,7 +275,6 @@ MODULE_DEVICE_TABLE(of, samsung_s6e8fc0_of_match);
 
 static struct mipi_dsi_driver s6e8fc0_driver = {
 	.probe = s6e8fc0_m1906f9_probe,
-	.remove = s6e8fc0_remove,
 	.driver = {
 		.name = "panel-samsung-s6e8fc0-m1906f9",
 		.of_match_table = samsung_s6e8fc0_of_match,
diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index f07d6533ed69..da02955f5f42 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -250,30 +250,19 @@ static int sofef00_panel_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void sofef00_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct sofef00_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id sofef00_panel_of_match[] = {
 	{ .compatible = "samsung,sofef00" }, /* legacy */
 	{ .compatible = "samsung,sofef00-ams628nw01" },
@@ -283,7 +272,6 @@ MODULE_DEVICE_TABLE(of, sofef00_panel_of_match);
 
 static struct mipi_dsi_driver sofef00_panel_driver = {
 	.probe = sofef00_panel_probe,
-	.remove = sofef00_panel_remove,
 	.driver = {
 		.name = "panel-samsung-sofef00",
 		.of_match_table = sofef00_panel_of_match,
-- 
2.43.0

