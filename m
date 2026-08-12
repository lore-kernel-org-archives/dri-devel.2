Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CBFC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B2910EFC0;
	Wed, 12 Aug 2026 13:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qu8+i7Ce";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31B8110EFC0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:04:43 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-476a130c138so720514f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539881; x=1787144681; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhYhgTImpqZaETttu1sB4XuGd8cNvc63SGXkmdEEGIs=;
 b=Qu8+i7Ce6ZST/+r6GsFFbd4VzRumgk25BB7NX/WDbTQSHXcHzJOa7huDfKFIQq0y0D
 ZvkHSpOC0P61YofcMYT0cz5umsDE0uVbuld6m1XgSXH6D8S2SmZRCQA9wU0xqx6HlEj3
 svYzJlUqlxYiqixU8FlFGkKN+q6fXjLuLATSE114AdRa96FiG3bTeoqTYG3VE0Nj0pB2
 b1kn2Ff0Vis6BtnCnxfbE3pH16RszRznX2mBUkuNkjyJL3mdIUEPfixNvwrBd3nPbasD
 kKDojNumZrxd9UEe98DZIUR4LWar4GSJZ6CcxfvJOM2t5sRBH6NJwmi1IQayaZugKZ36
 r4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539881; x=1787144681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vhYhgTImpqZaETttu1sB4XuGd8cNvc63SGXkmdEEGIs=;
 b=iq9rpedg4ufvzB0poW0j/e9vEHK3NkqHyL+nO5liD1qa8XzLdiJBAlGLo0pV1myGyg
 EroGBW/QD4Y+3ThSAdaEFqQ7dAO76b/HfubRt7SJmt3rvpqaVWXSVizB58piPLY+KoNY
 Lyi7RvF91hXQnV9Np41e5DoeqNxjj6rw32Mh6OzBTlsqV1lypr3Zf7LdE0vj9lYNABmk
 ItuSlxVDaglWEb93iM8kRNShJBQC4JX/+NMVo2G1G69uiIzGCiMxhDL46gje5rsBlrhp
 EWGjnRgwbhQ/sOjrv93+FRDvDGXtoioLjTLpah9HzvcGn3GFWzDKyFb3a2sKeV2RL44J
 aVnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7sVxxOg0JCs3RVISFZH3kxGoPEb/ZQVKvu8jutcamZCWpYTLrNUCVqAhmV1Q071ec2+mS5BjhALo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWxukFyo0FHCM7aAK0laxh1zglkw+H2cyPxykcUjRsrXGL1rlr
 7ZP+ULj8bz3EEXRr/OW8uMJzSIfXaekxtZt+Zj7cPqR6EQJtIWdcGHh/
X-Gm-Gg: AR+sD11H+Dsq4YKF6wZRfJ7r9sa/EMHFm9OuEK+q36g69nZ/FcIoOPbm0gPAuowDeKJ
 plTDntlEry6+j2PgvA1zsDR77QtCOFmyQtLOet0SlNw7b95nGG3wbszv4OYczGTIfNAt4OSPlt5
 4CiyUEPzJ3TT1xrlGOHDhQPP920ZmLmAKp5bWxj0cMoJuxRsw4S1+HgcsFEDrujKwlMSi5Slf/x
 BT9RQ6HqLbEHoMRORMA5MIjMtJPnPg3WpDCCwT0foIdgOXclvIWBm+e/KPdrxGFpXmGi5aIFPrA
 lIuFwbP/8m0yXszOxDqoophB61kZNmN5XC3mKsX1g2asvIX/oca4WxaC64y5qaNyh1wG75HpbTa
 /hitAS/GNV9+rJxEErdXGVv/Onir8yRjVgQWDwiA4I8Ut/VVoUaqaJH+RMP/d3o7GPAXtaQNDdW
 z+qcsgHuqf1uudVaTEVPBxwdx4TxC9sFuXJv1Y6gEFzpPbhVwZsWH5xctJuiEdvZILROGFytUHq
 rTDAgjsuc9wO//mYC2PL3oVHg==
X-Received: by 2002:a05:6000:480a:b0:47f:96e6:6e3 with SMTP id
 ffacd0b85a97d-48152c76ec6mr6704737f8f.23.1786539881322; 
 Wed, 12 Aug 2026 06:04:41 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eb2csm7040804f8f.30.2026.08.12.06.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:04:40 -0700 (PDT)
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
Subject: [PATCH v3 2/6] drm/panel: Use devm_mipi_dsi_attach in Samsung panels
Date: Wed, 12 Aug 2026 15:04:19 +0200
Message-ID: <20260812130429.16850-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812130429.16850-1-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Samsung panel drivers and drop
the corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

---
v3:
- Move the changelog after the `---`.

v2:
- break long description lines.
- add Signed-off-by tag

 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c            | 4 +---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c            | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c            | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c         | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c            | 4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c            | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c         | 4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c        | 3 +--
 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c            | 4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c    | 8 +-------
 drivers/gpu/drm/panel/panel-samsung-sofef00.c            | 8 +-------
 13 files changed, 13 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 54a65abf7e89..8b6d39636f50 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -209,7 +209,7 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&s6->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		drm_panel_remove(&s6->panel);
 
@@ -219,8 +219,6 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 static void s6d16d0_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6d16d0 *s6 = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&s6->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index 692020081524..1f070a99521a 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -438,7 +438,7 @@ static int s6d7aa0_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -451,12 +451,6 @@ static int s6d7aa0_probe(struct mipi_dsi_device *dsi)
 static void s6d7aa0_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6d7aa0 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
index f4d75eca3cdf..88e4d59941b4 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c
@@ -213,7 +213,7 @@ static int s6e3fa7_panel_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -226,12 +226,6 @@ static int s6e3fa7_panel_probe(struct mipi_dsi_device *dsi)
 static void s6e3fa7_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e3fa7_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
index e63080204af7..cba46e3915b8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
@@ -342,7 +342,7 @@ static int s6e3fc2x01_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -355,12 +355,6 @@ static int s6e3fc2x01_probe(struct mipi_dsi_device *dsi)
 static void s6e3fc2x01_remove(struct mipi_dsi_device *dsi)
 {
 	struct samsung_s6e3fc2x01 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index 1db0c63b1131..a1808124278b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -737,7 +737,7 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		goto remove_panel;
 
@@ -753,8 +753,6 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 static void s6e3ha2_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e3ha2 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 	backlight_device_unregister(ctx->bl_dev);
 }
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 550e9ef9bb71..22be3463357c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -299,7 +299,7 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 	priv->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	priv->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&priv->panel);
@@ -312,12 +312,6 @@ static int s6e3ha8_amb577px01_wqhd_probe(struct mipi_dsi_device *dsi)
 static void s6e3ha8_amb577px01_wqhd_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e3ha8 *priv = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&priv->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index e05199ce14ee..4b16ffe31b8f 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -477,7 +477,7 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		goto remove_panel;
 
@@ -493,8 +493,6 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 static void s6e63j0x03_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e63j0x03 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 
 	backlight_device_unregister(ctx->bl_dev);
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
index 2630975c111b..0edce6eedc0b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c
@@ -105,7 +105,7 @@ static int s6e63m0_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		s6e63m0_remove(dev);
 
@@ -114,7 +114,6 @@ static int s6e63m0_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void s6e63m0_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	mipi_dsi_detach(dsi);
 	s6e63m0_remove(&dsi->dev);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
index 77fee36dbb55..e9e621830fde 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
@@ -724,7 +724,7 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -737,12 +737,6 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
 static void s6e88a0_ams427ap24_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e88a0_ams427ap24 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index ca5cad41ff1d..43fd28cd1a53 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -196,7 +196,7 @@ static int s6e88a0_ams452ef01_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -209,12 +209,6 @@ static int s6e88a0_ams452ef01_probe(struct mipi_dsi_device *dsi)
 static void s6e88a0_ams452ef01_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e88a0_ams452ef01 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 1b5c500d4f4e..4902079edd27 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -1020,7 +1020,7 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		drm_panel_remove(&ctx->panel);
 
@@ -1030,8 +1030,6 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 static void s6e8aa0_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e8aa0 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
index 2fae0dc6c424..6c86cfaf92b2 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
@@ -258,7 +258,7 @@ static int s6e8fc0_m1906f9_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -270,12 +270,6 @@ static int s6e8fc0_m1906f9_probe(struct mipi_dsi_device *dsi)
 static void s6e8fc0_remove(struct mipi_dsi_device *dsi)
 {
 	struct s6e8fc0_ctx *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index f07d6533ed69..5cb05ba246b8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -252,7 +252,7 @@ static int sofef00_panel_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -265,12 +265,6 @@ static int sofef00_panel_probe(struct mipi_dsi_device *dsi)
 static void sofef00_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct sofef00_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
-- 
2.43.0

