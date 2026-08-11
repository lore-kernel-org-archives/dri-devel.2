Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27366C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9270910EBB5;
	Tue, 11 Aug 2026 16:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cnw5KZME";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB3510EBB5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:52:57 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so30808195e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786467176; x=1787071976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbWMuZ3vuPNpPfbdBgqF7KK3hjuhJJVz9w+yWNvt97c=;
 b=Cnw5KZMEwxAa80kxxSkTCfkR1sYzRz+E34PJDLKK8R3w+d0MO1EvsjVmYC9D0przWB
 QJChNl2QDuAfV1ZUIOClGZDIQU9+h3LW9D/z3hBVA+U/L58+B4SkLLS+nhq3LKP/UfJQ
 ugLjzjmjAWse70zaEZwr1cDIZQYVKfzmHKz4skK3lDUmDL9xY0flYLVBuOX5wl5g5spB
 w3edzZIsX+OSUTgmIvBTNm1M1TWo0Hx+nobcx0rnZnjAVtdXMXM1PVVzXGBjZOpBGSb+
 JMfc6ytMeFJSVx5qagvwFjBbjKazjnzRJNF11gruFIDFasxN8h9FB4bUOI26L2qp+gtp
 Ja9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467176; x=1787071976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbWMuZ3vuPNpPfbdBgqF7KK3hjuhJJVz9w+yWNvt97c=;
 b=lOdL5jIzpApJsTfNmpR3uM89PaB/qQ/jGto/rcjDIRi07Lo2UqYUvO1JG9NK5/S1NP
 nYMaFs2Q+ZYRwhYZpPv8M+ciLLNt9KnUx50atm6M7Gsybvvi3Nqy7/j+w4RS1zBNeL83
 6EmDGQD2jRmeAlTkDu8xrznEuHlLQZ/On0s48MGZpqGqcmRK2ilzEhEmFfClo562EuiX
 fnnWKAkiSAqnH1PJSL4VFkgUq/nmZ+lQfo9RN4pJxnKwlhTCLHn3qlQ87BvNUbTyqVv9
 EQmbbToh8adgDoaQvEN3D5ZaU6pzhkmS1Z2ArI3D/PQJL0FAjecu5Kjz7Kj6dSrO2VVU
 Q5YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpI/AMhGYpbYm/fVb5BKRF99CbEodEndsbuhnXsZxjeNCtWNFc4fBA+QIHi0VTyn57q8Dh351qSXOo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyscWumeJPgv4gJYpNcJ1Cb7UINPstPyjj508JoUQP0HfKc8q68
 vt1+V3w71Cpax2D4C87TrjxSlGlVbYa+OVGaS9+XLZwzQHVJXbmNymSi
X-Gm-Gg: AR+sD127aHRiK1t9nYQX7PLiPZqjhXA9h1bMeNc9WfZvoSJKMu2/WwglfAPZkcs7/KA
 KeT4qKKjF74QaF45XjkRuizDBYB5TB50HSuxDLZGp+ULLjCB3krensPwizN2A+7+cj/DQjzc0Ln
 PKSxizNIMsGi32+/UeE39rmTABYYfD3NxH7a+c6IWI/5Yhusuniz4BRJMEmfajZHHXM6gmFxLB6
 rLkdhJXK6owC4e6iVNLY8EDJaWlAJthAsnkqO5+ZGr5Bkfvz5Py+DjulFD3fQioGmrD/n6y5F+9
 F12ASfKSCSMOYxjHsZJoDDAjxMuf2YiGuThDyw8U3Es7Php1TyhAiyQWXBivG8ujRRaa/h9ixiS
 wfK80QolwuZ5tMa04VQ683igq/p+kjpTnn2Ug3k9VU4+4h7Nt5kHSafo2KiyqlkmkcVeNq472Wh
 aAGycyRYd3VN5GyPr9/YPgMRObbOKSekSuSVXQuA95DAAsHoxC3DblL8IY8bV5XQlgiCe2/2hNt
 8iYsu+0J32u8hjVeKCStbttYhkyCw==
X-Received: by 2002:a05:600c:198b:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-4997842da36mr72184405e9.3.1786467175943; 
 Tue, 11 Aug 2026 09:52:55 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:434a:d6cf:4fd1:90b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4d2fsm4977465e9.1.2026.08.11.09.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:52:55 -0700 (PDT)
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
Subject: [PATCH v2 2/6] drm/panel: Use devm_mipi_dsi_attach in Samsung panels
Date: Tue, 11 Aug 2026 18:52:50 +0200
Message-ID: <20260811165253.13735-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Samsung panel drivers and drop
the corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

v2:
- break long description lines.
- add Signed-off-by tag
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

