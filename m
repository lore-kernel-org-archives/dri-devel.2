Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9565C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146EB10ECE9;
	Tue, 11 Aug 2026 16:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FlrdPO8W";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928F310ECE9
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:53:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so30099435e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786467207; x=1787072007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TumqbBnHVFtg/n3tj+8i/zqJnSlm+zAXDPXjqg6razk=;
 b=FlrdPO8WpUXI+osByjK0WKcMbQBBauQOU6J1/Xg5Vzm+140s28nVkannTWWqOC4ZM+
 hnKNAkWGjsXn6EcOQ9Rghzy9QDXgN3TPXGBvdEyC8hEcv3RAugvu8fHlCbIOpkRNfmUy
 97KauKPNN/DgyXOsyZqxdDHGK7swJwGh864JXhDpBYoTZnyZRaJ1nuBOPMfrYoZEfwwa
 FbFjMDciWaudH0tBdGVe01ULcP2fCkbByXu/f6CYpkQsA/bHTOQKcINywsuqvpW97CJG
 qi1kW/cPpAvHPkqbvp2dTjiMgYjAVUmbWUD8wUbO7aFP2+/80tmc0DILXOuZEwL4QR7z
 BZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467207; x=1787072007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TumqbBnHVFtg/n3tj+8i/zqJnSlm+zAXDPXjqg6razk=;
 b=ZZBD+VGJFXDUqMfycfE1s8dMq16n86br1t1sLf2tcHSsQY0eAu42gyNe9L+EWjiyen
 abs+0Zu8gjXZ+axNC/fuvkcPR8Pd4MYyeEqPoj9q5XHN6H+mbSfsNwUV95aZEY09XBzC
 UMEGKdMif/fR40cPnMxg1qZUO2IOhxLd3ZPmEVI4aPfJNuBT/tNT0Tan31IEDF9GPozF
 NDX0T3g2TTidhtRmq88nmDdKxyKnEWB4RrWswLJkx+EvdDTSj4xhu+O4gFWEKvhD5H2U
 NhMrJ2Esfc0+Lb96Agbc238zkQp4sUaPlmf+2H5ODIIALzHMNsIlQdrvFoyAso5/Id34
 uTng==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIEuedVPjSCcUOqTPB1OcWM8UqKkcjjpB8SpICNGo5+rxiZtML+qu3zA48UsPQvnOhmIwkhl8goYw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiqLcy7bXZ36nJ1Dh3f6Z3+MKZf8QrrMVtCEfDoY1EEvnGHk0D
 +8v3GnEkoGU2mlfmWs8dHs3/FtvlVP/V7XrtGAyZhkLjW0mWZPyrmeK5
X-Gm-Gg: AR+sD12eefwaHKEFZSeRNPB5SDma1oPWZoFQot8i9+LoLtTBFidiJ8INSF+aVRpyWGr
 t5sEPmCIvUzOOg3Z/OWQNjn7mDDKzf1k4mUEB6vrT8M69IOss7YaxNlcDJP/8TXnqES9Facsatc
 xTouhAWXSdMPRVQdgWpSaIWlN9n5NIKe8qrmqc2MGwIbc/WDPDOPYf9mA7hCaTYFzNYudyxb72t
 y2XARsMXXIcryyy/eEvJ6Cn+nH+yqpg3pzubFYr94uk44QINRoXJrGJ0WaGvamukFSW72QGsewz
 k42y/IkuZY9fkmA0+o9hshM39ZCWxxnlxLp/z4j7btGOLPSHLAalwouIUfmk9fSYSCmvDhNuCAl
 pYNQRov5EUK1513DSodNCfmUEQH4a2X6TQn1BgdJlCSmaspp9aKQnfhTU+mcqtvDgAUoYRNW0sW
 tLxe7Cbcd0lfL/ld0CihlUyhaXdXqW5zjOsPKEIKRHAEL3cyDgq77MpRRvPS6WDYNCAYNnrj9Kf
 IDGx+ZQh8c3X1cMqcaAjPaP
X-Received: by 2002:a05:600c:3553:b0:493:cc25:85cb with SMTP id
 5b1f17b1804b1-4997844ed1cmr64030145e9.8.1786467206592; 
 Tue, 11 Aug 2026 09:53:26 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:434a:d6cf:4fd1:90b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa5d04sm6371845e9.2.2026.08.11.09.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:53:26 -0700 (PDT)
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
Subject: [PATCH v2 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and
 Ilitek panels
Date: Tue, 11 Aug 2026 18:53:21 +0200
Message-ID: <20260811165323.14168-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers
and drop the corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

v2:
- break long description lines.
- add Signed-off-by tag
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

