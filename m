Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D49EC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C050B10E0E6;
	Tue, 11 Aug 2026 15:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PyBePouL";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAF910EC65
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:10:48 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so33966825e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786461046; x=1787065846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rbhvOVyk4557fdZi9dUSvbpKOnRtueLxiCFpN/QbC9U=;
 b=PyBePouLNsqNtWLNNlpxxMzcgdOwfp9FM2J/jb/eCEFbKrNZd+gw6MkfktU74HdjVP
 97ekYOb7IQPRvpvuKD4avfd7y1nYur2/7KvkNZFo4EHKP86ngH9L8jwhd5pgYRfJ6h9m
 joEXY3yHYliodump5AISfXEL5+TB02WymoCYZq5FdRoM17TghJ8H4UAHaV6l2gHtR3x+
 NUnG+xKddQ8/VIUJ+eRavVX9vv0BwfoaKHEHpNxzQJVlaDHUIuyRME6LVNaCwCJJPk0W
 /dxNwoVacxw0xOdmOAtzDydCbNsUnD3V8BKzzVZctY1d/Joxhd8OhsO1BuQSFWxgHLTG
 978w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461046; x=1787065846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rbhvOVyk4557fdZi9dUSvbpKOnRtueLxiCFpN/QbC9U=;
 b=dUROyvA2PxPPDcUuS37XxwKsWexHQhgn+wuJiW0kYtv8+AscM6Y+kxMjUXP3S8zq3H
 yIYmaDuSfcwvtWYjbFXmrSQNtDPS3ua3vfqi/802wYQHW+zoNfIrA7ZtdthJsl70ae0c
 8tOeNT8GxdUf8CR6zCNrDGv4XCv8YQqBE+utlNXSTjYIPjF9x2uYcwV4F3FfybqxD9Ot
 QLNtUgGge9J9b+TiS+LoPbGBwgOBGPYg2F/YkOqnm/LQ+0nsxJcSM8IfDo5+5dCOxY7R
 qilBhIT08Cz7CJQDaQUOMscNkWg9mxDLXkNyDGyz594GDNN+kShuSfhd6cBWGqnZ9IEv
 S7fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpC+rK1TCDk0Fr+hrxIEE7iluH2NbGUxNDp9Qbqf/6ySaND+Sujz4yiblw+/FGA5yYttCl6CcZDEiI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgAoKw9nrR/RGFjpTpDTTlSTRu/qIHuObExCpaf8i0Prrobr47
 5q8PaELglx5u8S+Gp7Fpr9n+hcQoLcWQarYczKPKKMyRMG0234W7+u7t
X-Gm-Gg: AR+sD11nFKaLYKwDIunI9C6twquwdnZGUDU5ujepfGbure+oVhN99Zxkzqf3Qbh2YKe
 s/1e2Bfp8gnb3hhpgMgqRA+v0HmSDE10fH11hXSgHdgSQyomszPlSParP6p0oT9cT0NI8YzGewk
 8bFZj/gfwzAl+KYnDQOTRodKR7yO5yyNd+TVzwxTPTFVKcsmwPTc9u7O6KQ8X34GRiAT2h+uFi/
 i6PWEVeC17p2+uG60IbX9jSbENyAjHEXawpHxQOVn9KD1FBiFHZSy4IVzEgopsmA2YRBa4F9Zgi
 HPV1orj4XYnIAPl+QyjbfuuhHcct+4z8z6wEFhkD3CxUzdXj+iOAmw10a5NQ+86JD/85mFS9MDa
 uxkgMvXrgjkITymIyR9/IiH1PpfZBsydsQNEadvqPeFHT2FCG75TUZRIhs0d7IVuGgqvL8RO9gU
 q6ZJytr1vJh0b+nsgR6KLuuDrgwxriKVV/6gwrC1o10IO3Q0HXux6SNBxU5NVAYbILhJfQd3gZ8
 ue2i2gQRIS1ZO+Dyzlnm0L2
X-Received: by 2002:a05:600c:800f:b0:499:726c:50e with SMTP id
 5b1f17b1804b1-499784661f7mr74280315e9.14.1786461046442; 
 Tue, 11 Aug 2026 08:10:46 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm54307265e9.2.2026.08.11.08.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:10:46 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: [PATCH 2/6] drm/panel: Use devm_mipi_dsi_attach in Samsung panels
Date: Tue, 11 Aug 2026 17:09:46 +0200
Message-ID: <20260811151000.75038-3-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Samsung panel drivers and drop the corresponding manual detach calls from remove paths.
---
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

