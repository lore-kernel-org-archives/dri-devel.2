Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6510C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0639110ECDD;
	Tue, 11 Aug 2026 16:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GplRDTsn";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3718410ECDD
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:53:13 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso146315e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786467191; x=1787071991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AfxvT4uZaa70u4P8Ges3PKj2JAuHMRwLlHkL0ssM9PI=;
 b=GplRDTsnMGGF7c3UTHgjXsmT0RsgAYqcwdHnw2pDZ9SRwR/G6GQdW0PsyU3Rb+qCus
 V9uhGP+Y7wG2lB5qNjEuQTgJadnpKAp17j+cIcuoD8Fa5DGTZdAE4vSx0iUg4CEwfSWW
 M0yhtTHUsYnq+JKlSee+Vvij+TNK7auBr+7P7eUoLX/jMDa5zY5/ZBU1Yb+U/ffKWbLS
 Liq0NT0RmE7HU20gnsF2Afx55nAmTK2G8V2TbbbeKJ5xcelgtj+Knk2EuLYr5QLQOmyp
 7x8oF7WDVyh1+cAAOMoW2nu0hjPyAdocPDgTmPIiwvh1DyLUYTPcO0qrGbvLLxL8Z+Bf
 mOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467191; x=1787071991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AfxvT4uZaa70u4P8Ges3PKj2JAuHMRwLlHkL0ssM9PI=;
 b=EezcB+fT7KwWK0hmE2BYYYilpQoTi2bxIgFOepmiM9ljh4OAzEI1srfBlXU6gAP+U1
 4vI5NpHUZdSnOh2YTxQNb67uirvsP63zm4GGoYvGGmUVjQdXpii0NpUzq3d2kOlJP30I
 lUCEm8wH9NXNryduawdco1x8xWEHjlN7kzgs4dVYcZviSS6H4cfYz/m3kAw/oK+wU342
 fmRrwsgepxBpnVZ7+i4woliseWQdSAjPDJDdXMk/LDqFgrrNpqTPDRsH/+GB9DJ2srSx
 eqdzLRThIE/0kPtBlQS6S3CYO7NNwYaPgEFYUXD5MHaKMWa+y/bLgJymbPPF1NivnhNQ
 IpHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqz7iWsr94XFgucWPxYiVHb8v5dUAUPcH1Ez9yX0O3Cy+6G0nFZlDpj9IF90syq4w7vz9CngL23PDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjHrcBfGWX+UHxX0hYAuIEuhMbx2hR8P6RxF2Xne7gl+DhCtP0
 GeijwFvwF5OSEYolwJn6Gt0nqv33guBiJzdM4SHHI5I7Fmcpg93LOeJO
X-Gm-Gg: AR+sD10BQ1KBVURM8+JsUqNc5ChWd5CNmxgO0RWAdprmqp8uzZWlHgHO5XCigwchQzC
 mJStl3YSp2YQm6V4MV8H7R/4FDAA2QGcv8mB0SXDYpCjc0TBYjureT2XX2msRpoiABfmCcrX28+
 hcI/28+NMMuE7VnAYm4Ni5dQ4kasV+qtsR038zf4Tx+KhnPngjNpARbfn/bachapZMw3fB1np4N
 qajRERCfG+v70EDbvc5AvjvIMVnkrsFPXxotCh+c6kMtH3sGq6MRaBM6FFqYARDpzXptoT7c+yW
 iQTlwaj19TD8Wy9L7fQl2coF5PrsEeV2oL+p87MbiSGqqKmbO47ZyjNG/WFolQ/ZvGvj+cgSRCh
 g8xGt1uXJl1yDJqkHDMNkLOykDI94DzggarXtcg4AL4S8BaiPoPuHhvc4Jif6NhRx1+Axmq+RYM
 kvHFQfG4/4wJ7eqQT+EpwObMCVp6Y6CeRi3DWAx/zrZgVt9dagXTrhwAw5aTGuLn5vZtc88giFV
 SnbLC3UakyFv3J9MX82unUR
X-Received: by 2002:a05:600c:198b:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-4997842da36mr72204175e9.3.1786467191423; 
 Tue, 11 Aug 2026 09:53:11 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:434a:d6cf:4fd1:90b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4d2fsm4995655e9.1.2026.08.11.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:53:11 -0700 (PDT)
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
Subject: [PATCH v2 3/6] drm/panel: Use devm_mipi_dsi_attach in Novatek and
 Raydium panels
Date: Tue, 11 Aug 2026 18:53:04 +0200
Message-ID: <20260811165307.13950-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Novatek and Raydium panel
drivers and drop the corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

v2:
- break long description lines.
- add Signed-off-by tag
---
 drivers/gpu/drm/panel/panel-novatek-nt35510.c  | 4 +---
 drivers/gpu/drm/panel/panel-novatek-nt35532.c  | 8 +-------
 drivers/gpu/drm/panel/panel-novatek-nt35560.c  | 4 +---
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 8 +-------
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 4 +---
 drivers/gpu/drm/panel/panel-novatek-nt37700f.c | 8 +-------
 drivers/gpu/drm/panel/panel-novatek-nt37801.c  | 8 +-------
 drivers/gpu/drm/panel/panel-raydium-rm67191.c  | 8 +-------
 drivers/gpu/drm/panel/panel-raydium-rm67200.c  | 8 +-------
 drivers/gpu/drm/panel/panel-raydium-rm68200.c  | 4 +---
 drivers/gpu/drm/panel/panel-raydium-rm692e5.c  | 8 +-------
 11 files changed, 11 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 3189d89c7ca0..e75b6ac3df5c 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1175,7 +1175,7 @@ static int nt35510_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&nt->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
 		drm_panel_remove(&nt->panel);
 
@@ -1186,8 +1186,6 @@ static void nt35510_remove(struct mipi_dsi_device *dsi)
 {
 	struct nt35510 *nt = mipi_dsi_get_drvdata(dsi);
 	int ret;
-
-	mipi_dsi_detach(dsi);
 	/* Power off */
 	ret = nt35510_power_off(nt);
 	if (ret)
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35532.c b/drivers/gpu/drm/panel/panel-novatek-nt35532.c
index edea766a3c44..e0bba71e3ff8 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35532.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35532.c
@@ -754,7 +754,7 @@ static int nt35532_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -766,12 +766,6 @@ static int nt35532_probe(struct mipi_dsi_device *dsi)
 static void nt35532_remove(struct mipi_dsi_device *dsi)
 {
 	struct novatek_nt35532 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 6e5173f98a22..1f7d5d670923 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -435,7 +435,7 @@ static int nt35560_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&nt->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&nt->panel);
 		return ret;
@@ -447,8 +447,6 @@ static int nt35560_probe(struct mipi_dsi_device *dsi)
 static void nt35560_remove(struct mipi_dsi_device *dsi)
 {
 	struct nt35560 *nt = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&nt->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 464d9ce47d87..66f33cc42d30 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -458,7 +458,7 @@ static int nt36672a_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
+	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (err < 0) {
 		drm_panel_remove(&pinfo->base);
 		return err;
@@ -470,12 +470,6 @@ static int nt36672a_panel_probe(struct mipi_dsi_device *dsi)
 static void nt36672a_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct nt36672a_panel *pinfo = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
 	drm_panel_remove(&pinfo->base);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index c5e00eb55722..6309ea17e5bc 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -563,7 +563,7 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		goto err_dsi_attach;
@@ -579,8 +579,6 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 static void nt36672e_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct nt36672e_panel *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(ctx->dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
index c221dd498fed..0c9be8f4628c 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37700f.c
@@ -259,7 +259,7 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -271,12 +271,6 @@ static int nt37700f_tianma_probe(struct mipi_dsi_device *dsi)
 static void nt37700f_tianma_remove(struct mipi_dsi_device *dsi)
 {
 	struct nt37700f_tianma *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index 5e46c4c6d771..8430f70f0e28 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -283,7 +283,7 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	ctx->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -295,12 +295,6 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 static void novatek_nt37801_remove(struct mipi_dsi_device *dsi)
 {
 	struct novatek_nt37801 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 2af6aa47a551..9bd2d94b03d9 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -592,7 +592,7 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&panel->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&panel->panel);
 
@@ -602,12 +602,6 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 static void rad_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct rad_panel *rad = mipi_dsi_get_drvdata(dsi);
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret)
-		dev_err(dev, "Failed to detach from host (%d)\n", ret);
 
 	drm_panel_remove(&rad->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67200.c b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
index b2ba006c06f6..ff896e87fc51 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67200.c
@@ -422,7 +422,7 @@ static int raydium_rm67200_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -434,12 +434,6 @@ static int raydium_rm67200_probe(struct mipi_dsi_device *dsi)
 static void raydium_rm67200_remove(struct mipi_dsi_device *dsi)
 {
 	struct raydium_rm67200 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931903..e42936b4ae96 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -362,7 +362,7 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach() failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -375,8 +375,6 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 static void rm68200_remove(struct mipi_dsi_device *dsi)
 {
 	struct rm68200 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
index 8e9484768657..7cf284878178 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
@@ -331,7 +331,7 @@ static int rm692e5_probe(struct mipi_dsi_device *dsi)
 	ctx->dsc.bits_per_pixel = 8 << 4; /* 4 fractional bits */
 	ctx->dsc.block_pred_enable = true;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -344,12 +344,6 @@ static int rm692e5_probe(struct mipi_dsi_device *dsi)
 static void rm692e5_remove(struct mipi_dsi_device *dsi)
 {
 	struct rm692e5_panel *ctx = mipi_dsi_get_drvdata(dsi);
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

