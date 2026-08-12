Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415BAC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C97E10F073;
	Wed, 12 Aug 2026 15:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y+W1DOs5";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0736F10F06E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:25:42 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495590dde14so13931765e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786548340; x=1787153140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wfTH8vbaXGIf/GnQTUx9ai499PuDRzTf4vsluIY8QD0=;
 b=Y+W1DOs5CsLB1sIQBkGFPxpBSHoCNeWU/jWfrErsX37m2jfrZZ3zIYRR6AUXIx3O+k
 uzwoDsd/Lh2lYZQcJxzsFDXNKJvi/3j5mD1Wl9V3c5H96ozE38GSbRZZqLnfzi1Ykzl1
 1IKThOz9UacYaZEjNR3m6Gftpo2egMPlX9VmJW8RFmKQyjzE4Kn+ZdQ4ZgzYph1OXCLb
 TIv1Gk22FhGWIhkjl1fB0DTJZJY5JkM4niCWPXpGGgjJl7MrB6nQWvmDKd8n9y6QgTQ9
 6yCgMfkGvqQ+HiPEOO94yx0UKzB3L3G9t8ipTocnu7REY5fpDuF/+yEzfQ1hxB74Dlu6
 NTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786548340; x=1787153140;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wfTH8vbaXGIf/GnQTUx9ai499PuDRzTf4vsluIY8QD0=;
 b=UWhk8uXBDmWJou4BmymM4HQPAl1DHAj+bZ/clz/b8I0/pe8NWNOHr9rGlsSUL01egA
 U6uoNIz1ixu5RwS1E4/ub737JfQPQF+JzHP/WGLtAFXE5F8EawHaOJ1ydtZ9j7JJmBgg
 XrKWIskL+jZ/Sq3tdSHjlbfMbXLAYjSkK+mthiY9eVinK8kaDc6XPzhHKymImt0VquWs
 iYgDxvL0M4TKUsYtdBBH5KnU9tS4eWXkMH3Nx+/zjydHEl9YzR1hbs6UrSdxfUnzxo9d
 9I0Em/6OPqGeX74UCJFIhDVkNnxO+Iz2VfFKvC2ohM/FAiMhclQ6Ni3PBDNHnfylhoxP
 TQvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RppmwdCq1Yo9mQS/iIaot0wPUw2wpilyzeEe3ikx1NOFt24vlW38UZes8JyqSyGxrmWvic/bALjGrs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBDgrLm/X/ij0ypo7d1pvCcnsdApolCGYzJIVfvwVldPm9zo6y
 vZGW695E++pKFNvp+zjwDXteMu6oxU+PrMGftPwmRW3IrBhncPlFTXSV
X-Gm-Gg: AR+sD11mKXT+BoIfVubMLxk9YninZ3CcML1Bii2+zbapGk0NKFxZqcvjgZYoobvNKY7
 sLlAwIygvlkOIsWtsmyoRp6i2TjMI58Kuasrubn9efzIsUbVblAWh3wdK/UPkgLqQuyGo7LlUAV
 6FBucWT1He4LhDtUczxgYWY8SSdDuhazwOGNn5cXw0iFEif+XeCdgX4LVnUelsRDJuJxoxpBN0J
 u3/S38d4fRtEoDi2hwFZhfWkHqUZfIDNtkcDJSBl5mRP2kfBuEJInfo7t3a9/Zs5y+cBGzVK32U
 i0W5TEDLaqhJaTE1GcadUi6nLcUw9ykbM+GbaSQVdFCALNArww9rm3EUdWx9XfdLeVbRjdrCS5y
 /nJIejtTkh6LUjbr1Qk13eUMZpwBUCGBmd2x/cqp5mVkmTEjF3UK/EHCKyQtZGmNE2qqy+ZUbXC
 5nEvEpDaigTCae3mR+c8RuFqBkljQKgKij/f3fqXWux/hdnyiiHqF3G5w0oXbppefmVsKDw7wrK
 WKcmoMJymn6LiDEh40T3h6h0g==
X-Received: by 2002:a05:600c:1d0c:b0:495:7a5a:d96c with SMTP id
 5b1f17b1804b1-4997c163b3fmr74381825e9.18.1786548340020; 
 Wed, 12 Aug 2026 08:25:40 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e882d8sm91268885e9.4.2026.08.12.08.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:25:39 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v4 5/6] drm/panel: Use managed helpers in display vendor panels
Date: Wed, 12 Aug 2026 17:25:33 +0200
Message-ID: <20260812152535.82238-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach and panel add helpers in display vendor
panel drivers and drop the corresponding manual detach and panel remove
calls from remove paths.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v4:
- use devm_drm_panel_add instead of drm_panel_add.

 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  | 19 +++--------
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    | 32 ++-----------------
 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 20 +++---------
 .../drm/panel/panel-leadtek-ltk500hd1829.c    | 20 +++---------
 .../gpu/drm/panel/panel-sharp-ls043t1le01.c   | 31 ++----------------
 .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   | 20 +++---------
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 20 +++---------
 .../panel/panel-sony-tulip-truly-nt35521.c    | 20 +++---------
 drivers/gpu/drm/panel/panel-visionox-r66451.c | 23 +++----------
 .../gpu/drm/panel/panel-visionox-rm69299.c    | 21 +++---------
 10 files changed, 38 insertions(+), 188 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index cbe354b51bce..caf18d309849 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -200,9 +200,11 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
@@ -211,18 +213,6 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void jdi_fhd_r63452_remove(struct mipi_dsi_device *dsi)
-{
-	struct jdi_fhd_r63452 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id jdi_fhd_r63452_of_match[] = {
 	{ .compatible = "jdi,fhd-r63452" },
 	{ /* sentinel */ }
@@ -231,7 +221,6 @@ MODULE_DEVICE_TABLE(of, jdi_fhd_r63452_of_match);
 
 static struct mipi_dsi_driver jdi_fhd_r63452_driver = {
 	.probe = jdi_fhd_r63452_probe,
-	.remove = jdi_fhd_r63452_remove,
 	.driver = {
 		.name = "panel-jdi-fhd-r63452",
 		.of_match_table = jdi_fhd_r63452_of_match,
diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 01bd748aecec..e91b41743bec 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -345,15 +345,7 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 		return dev_err_probe(dev, PTR_ERR(jdi->backlight),
 				     "failed to register backlight %d\n", ret);
 
-	drm_panel_add(&jdi->base);
-
-	return 0;
-}
-
-static void jdi_panel_del(struct jdi_panel *jdi)
-{
-	if (jdi->base.dev)
-		drm_panel_remove(&jdi->base);
+	return devm_drm_panel_add(dev, &jdi->base);
 }
 
 static int jdi_panel_probe(struct mipi_dsi_device *dsi)
@@ -380,26 +372,7 @@ static int jdi_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		jdi_panel_del(jdi);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void jdi_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
-
-	jdi_panel_del(jdi);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver jdi_panel_driver = {
@@ -408,7 +381,6 @@ static struct mipi_dsi_driver jdi_panel_driver = {
 		.of_match_table = jdi_of_match,
 	},
 	.probe = jdi_panel_probe,
-	.remove = jdi_panel_remove,
 };
 module_mipi_dsi_driver(jdi_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 0856df5a6ee2..8a02e92061f5 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -583,30 +583,19 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void ltk050h3146w_remove(struct mipi_dsi_device *dsi)
-{
-	struct ltk050h3146w *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id ltk050h3146w_of_match[] = {
 	{
 		.compatible = "leadtek,ltk050h3146w",
@@ -630,7 +619,6 @@ static struct mipi_dsi_driver ltk050h3146w_driver = {
 		.of_match_table = ltk050h3146w_of_match,
 	},
 	.probe	= ltk050h3146w_probe,
-	.remove = ltk050h3146w_remove,
 };
 module_mipi_dsi_driver(ltk050h3146w_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index 7f19fd5b8060..ff35b62a327e 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -649,30 +649,19 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
-{
-	struct ltk500hd1829 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id ltk500hd1829_of_match[] = {
 	{
 		.compatible = "leadtek,ltk101b4029w",
@@ -692,7 +681,6 @@ static struct mipi_dsi_driver ltk500hd1829_driver = {
 		.of_match_table = ltk500hd1829_of_match,
 	},
 	.probe = ltk500hd1829_probe,
-	.remove = ltk500hd1829_remove,
 };
 module_mipi_dsi_driver(ltk500hd1829_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 989b030ea22d..5077893dab7c 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -205,15 +205,7 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&sharp_nt->base);
-
-	return 0;
-}
-
-static void sharp_nt_panel_del(struct sharp_nt_panel *sharp_nt)
-{
-	if (sharp_nt->base.dev)
-		drm_panel_remove(&sharp_nt->base);
+	return devm_drm_panel_add(dev, &sharp_nt->base);
 }
 
 static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
@@ -244,25 +236,7 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		sharp_nt_panel_del(sharp_nt);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	sharp_nt_panel_del(sharp_nt);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id sharp_nt_of_match[] = {
@@ -277,7 +251,6 @@ static struct mipi_dsi_driver sharp_nt_panel_driver = {
 		.of_match_table = sharp_nt_of_match,
 	},
 	.probe = sharp_nt_panel_probe,
-	.remove = sharp_nt_panel_remove,
 };
 module_mipi_dsi_driver(sharp_nt_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
index 0456f3d705e7..e59d9d32b1e0 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
@@ -233,30 +233,19 @@ static int sharp_ls060_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
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
 
-static void sharp_ls060_remove(struct mipi_dsi_device *dsi)
-{
-	struct sharp_ls060 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id sharp_ls060t1sx01_of_match[] = {
 	{ .compatible = "sharp,ls060t1sx01" },
 	{ /* sentinel */ }
@@ -265,7 +254,6 @@ MODULE_DEVICE_TABLE(of, sharp_ls060t1sx01_of_match);
 
 static struct mipi_dsi_driver sharp_ls060_driver = {
 	.probe = sharp_ls060_probe,
-	.remove = sharp_ls060_remove,
 	.driver = {
 		.name = "panel-sharp-ls060t1sx01",
 		.of_match_table = sharp_ls060t1sx01_of_match,
diff --git a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
index a14c86c60d19..285f0d033efd 100644
--- a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
+++ b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
@@ -214,30 +214,19 @@ static int sony_td4353_jdi_probe(struct mipi_dsi_device *dsi)
 
 	ctx->panel.prepare_prev_first = true;
 
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
 
-static void sony_td4353_jdi_remove(struct mipi_dsi_device *dsi)
-{
-	struct sony_td4353_jdi *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id sony_td4353_jdi_of_match[] = {
 	{ .compatible = "sony,td4353-jdi-tama", .data = (void *)TYPE_TAMA_60HZ },
 	{ /* sentinel */ }
@@ -246,7 +235,6 @@ MODULE_DEVICE_TABLE(of, sony_td4353_jdi_of_match);
 
 static struct mipi_dsi_driver sony_td4353_jdi_driver = {
 	.probe = sony_td4353_jdi_probe,
-	.remove = sony_td4353_jdi_remove,
 	.driver = {
 		.name = "panel-sony-td4353-jdi",
 		.of_match_table = sony_td4353_jdi_of_match,
diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
index 216a6ad8696e..0ebd9836364e 100644
--- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
+++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
@@ -472,30 +472,19 @@ static int truly_nt35521_probe(struct mipi_dsi_device *dsi)
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
 
-static void truly_nt35521_remove(struct mipi_dsi_device *dsi)
-{
-	struct truly_nt35521 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id truly_nt35521_of_match[] = {
 	{ .compatible = "sony,tulip-truly-nt35521" },
 	{ /* sentinel */ }
@@ -504,7 +493,6 @@ MODULE_DEVICE_TABLE(of, truly_nt35521_of_match);
 
 static struct mipi_dsi_driver truly_nt35521_driver = {
 	.probe = truly_nt35521_probe,
-	.remove = truly_nt35521_remove,
 	.driver = {
 		.name = "panel-truly-nt35521",
 		.of_match_table = truly_nt35521_of_match,
diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
index 690cccedd438..1efb139bb711 100644
--- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
+++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
@@ -304,29 +304,17 @@ static int visionox_r66451_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				"Failed to create backlight\n");
 
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
 
-static void visionox_r66451_remove(struct mipi_dsi_device *dsi)
-{
-	struct visionox_r66451 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id visionox_r66451_of_match[] = {
 	{.compatible = "visionox,r66451"},
 	{ /*sentinel*/ }
@@ -335,7 +323,6 @@ MODULE_DEVICE_TABLE(of, visionox_r66451_of_match);
 
 static struct mipi_dsi_driver visionox_r66451_driver = {
 	.probe = visionox_r66451_probe,
-	.remove = visionox_r66451_remove,
 	.driver = {
 		.name = "panel-visionox-r66451",
 		.of_match_table = visionox_r66451_of_match,
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 50f8a84537ca..4309e04c35c4 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -382,31 +382,21 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "dsi attach failed ret = %d\n", ret);
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
-static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
-{
-	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(ctx->dsi);
-	drm_panel_remove(&ctx->panel);
 }
 
 const struct visionox_rm69299_panel_desc visionox_rm69299_1080p_display_desc = {
@@ -438,7 +428,6 @@ static struct mipi_dsi_driver visionox_rm69299_driver = {
 		.of_match_table = visionox_rm69299_of_match,
 	},
 	.probe = visionox_rm69299_probe,
-	.remove = visionox_rm69299_remove,
 };
 module_mipi_dsi_driver(visionox_rm69299_driver);
 
-- 
2.43.0

