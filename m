Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFD6C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DDB10EC66;
	Tue, 11 Aug 2026 15:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="djeVr9pc";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2AD10EC66
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:10:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so28623495e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786461053; x=1787065853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEbHzsuEkNRECnH40rELRH3/NmWH1R+swCCqJeMq5nU=;
 b=djeVr9pc6ZtCt7YogPE5IR96aB7ut3W+y/g68uECVDkZnv9Ni8T9bKATup+8577+H7
 OrMPsdRU2Bf1Pr8cklY6RfrOtqEYc9c2ZFBXMQBQXB43bsBxXRqAh3tPYZQYw8PfWQx6
 2rf3i+/6A5uyNPVJqQnP1+KtJbwzMZRlIhOOmVzS1UDrggg6S8gQFSK/jO2W0TpZ2Y2h
 quqVMje7P+QfnE2HBZnV9olB9wA/N19sV3uiWMenr/rTtkrQ2qsPS/qGM9DrXQJuvFVO
 IQt9sqPRrOAX76VwvQYHCKqFuT7w7pxOpsNsu5M7drf3j0TPoKdV8U1vBu/KMBQ1I5xH
 AJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461053; x=1787065853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UEbHzsuEkNRECnH40rELRH3/NmWH1R+swCCqJeMq5nU=;
 b=SMYCj2FK+LXBI4jTR3KIAi3W/uP+jk/GL9dnW9cU3DlGHm5kqVsJoaNxtRStZGMFUb
 c2YAFl27vhg3M0+6f98GXE0Yx+td1uITDfuIaRBQLcYHnnD/dry1CWC30Db6V7PZFce2
 LTMeWCUvajnSkDMJR+EcK3v4ni72EWvbADDwn4E6+xzkriqjtel4qIBR+37al6hePlZY
 iLV2lRlUDhsDMCR6x57o2CgJVXgFQA7tcmve6jDWEHqX4otVV+4ZVoDcu4jMnshtOkoV
 wxQ76ZF6UqsKBB8ztHWn+zIuoIsBKHO+xbgXPrOhkAE5LebnbomtAjMFcpSCW6oq2qk5
 ZbwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RphV/6zy0gHIp1RK/xZEt+oWj4svetJLsp+4IYDvzZhYZojPdeIbONCk3MGhD8OYMz0uq5bZ8xAAgA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzv+SEvE2cAnfE3XjsFV7qz0O3ojKvt2vBKshrFEMOTLe4cRlsA
 KC6Sq2gdxUBs/+scSTXfw9jmzh9Vv2y4YMzhwt00wu5xvrn2pnqxGLC3
X-Gm-Gg: AR+sD11vrf8MspjcfY7LFII/p6MvakKweH5QJUYEueY0xMc8G+t8yFK3ZmsjwqRweHU
 R5Ucxw2qnXeLiR4ISvK79fSaUMTD7uJI2agC0BO21kn5wSm7UftSCGqePOSo6A7D/Q3AxX6WMAg
 iJEXLgahCljZfvqaMyLEVehdlXck7FPNRrs/htOefrSdRnMhR4bY3FWNIPUQYfGrNynwzRG4jPD
 YiUYx5a00QsQ0XjvGOwVNGim3z+yfliNkOffgBisJqxpsgAN6GRqaf04knfjhAM+maLiaknMVF+
 /26N5sCteX9zMAKpegyC0t8YmnbHd990+qtwxj/h8gwcjC205+t0iJ0GunJ3YRRIjhRjPyLMptC
 cIJ1yD23+zwoJcu6syy7DhnUC5ck+20STqanH69VTyzKK5fKHPSffKbW5TXltiQEXfEHMIH0q4y
 ajQV+Q8SbL9Z3X73QXGDNA1TqIOj0XP58g/2zUYhNba4TbJhTXGQf74LnwNBPBj5ZKmsoPGkiy0
 lnA2LGBo37HO9pn/SoDwcW+
X-Received: by 2002:a05:600c:6306:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-4997843ccbcmr75715785e9.7.1786461053005; 
 Tue, 11 Aug 2026 08:10:53 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm54307265e9.2.2026.08.11.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:10:52 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: [PATCH 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and Ilitek
 panels
Date: Tue, 11 Aug 2026 17:09:48 +0200
Message-ID: <20260811151000.75038-5-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811151000.75038-1-osama.abdelkader@gmail.com>
References: <20260811151000.75038-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers and drop the corresponding manual detach calls from remove paths.
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c       | 7 +------
 drivers/gpu/drm/panel/panel-himax-hx83112a.c      | 8 +-------
 drivers/gpu/drm/panel/panel-himax-hx83112b.c      | 8 +-------
 drivers/gpu/drm/panel/panel-himax-hx8394.c        | 8 +-------
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c      | 9 +--------
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c | 3 +--
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c     | 4 +---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c     | 7 +------
 8 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6a0851ccf9bb..4a28541891a6 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -1318,7 +1318,7 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&ctx->base);
 
@@ -1328,11 +1328,6 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 static void hx83102_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83102 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	if (ctx->base.dev)
 		drm_panel_remove(&ctx->base);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112a.c b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
index 142cb1cc067a..bcd665b7ff88 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
@@ -305,7 +305,7 @@ static int hx83112a_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 		drm_panel_remove(&ctx->panel);
@@ -318,12 +318,6 @@ static int hx83112a_probe(struct mipi_dsi_device *dsi)
 static void hx83112a_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83112a_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112b.c b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
index 41f21f8c1373..1ea5a9dc3ac5 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112b.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
@@ -388,7 +388,7 @@ static int hx83112b_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -400,12 +400,6 @@ static int hx83112b_probe(struct mipi_dsi_device *dsi)
 static void hx83112b_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83112b_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 09124610fdc8..7fc7063862c0 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -1025,7 +1025,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
 		drm_panel_remove(&ctx->panel);
@@ -1043,12 +1043,6 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 static void hx8394_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx8394 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 5610a225f77b..aadb13eb41e0 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -307,7 +307,7 @@ static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(&dsi->dev, "mipi_dsi_attach failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -320,13 +320,6 @@ static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
 static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9805 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index 0fb06c425545..a03a1b4411ad 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -141,7 +141,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 		ili9806e_remove(dev);
@@ -153,7 +153,6 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9806e_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	mipi_dsi_detach(dsi);
 	ili9806e_remove(&dsi->dev);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 3abdd0870e83..ca7037a4242c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2597,14 +2597,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = ctx->desc->lanes;
 
-	return mipi_dsi_attach(dsi);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 6d07fe901357..896de9460aa8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -844,7 +844,7 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ili);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&ili->base);
 
@@ -854,11 +854,6 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 static void ili9882t_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9882t *ili = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	if (ili->base.dev)
 		drm_panel_remove(&ili->base);
-- 
2.43.0

