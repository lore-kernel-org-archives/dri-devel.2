Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D61BC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905C310EC65;
	Tue, 11 Aug 2026 15:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULUn6EOc";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAC1510EC65
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:10:51 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2364686f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786461050; x=1787065850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kDdExMmbEPU0/QhO8P8dukEydRvYYmhOlmGEQGfLyW0=;
 b=ULUn6EOcARWRmlXe0cByMOaQ2Hx/jvuI2vssMT0LwYp49ZZx+O7QUqlSGHH9QCxyzH
 GoM0N+d3uP6K+SunUYS45QF1TYtQX2giKP0BksiVLXMmvaU8D6u2fh3GSNcOo2x+QgzV
 VAzRYRzFCN3uEmX5CzBlD5gRys8hsPrXygmUvCDbshc8W6lly6YCmsxm/DY/OCkSGlvI
 tv25dVsDun7MA0AR4Ij957xEUMLTz//LDOA4NLHnwyMIUIda0NBUq1HAoMLIGTxXuF7d
 fbGExPed3hA85PcJupN7r/zlforV6dFmNooVk72fP2LI37T26moJ+qQqa+U0f8oboHXj
 gkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461050; x=1787065850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kDdExMmbEPU0/QhO8P8dukEydRvYYmhOlmGEQGfLyW0=;
 b=mnSvj0Qd7MXYO+ERnke+3v0xx2Nv2loZ6StV+rhCRbFfdWPvYZHw8kpx6xBc+iQ4C8
 2vAW5IEtmpA6Df7icu9Z8pMiSNj2sABv7+Mdvy6GWo4c2t9GZi20v6LPEFTyfdZTtDgB
 p1hi32ld+Fjn0tSOZXdFpJQxgkbbiIL2/7a3+sSM7+mI/ozlitOBwRSDmg0pCggd3wll
 8em6/QUwgF/nOlihZhP7EXXd1lIu9+SVKLb9eDRHVAgpSzLjkJGha+m3n+OpH65/Sk46
 agVu046qth73tdC8wntVVncWb8VCszEdvuk6MaMpMttVbN2QBCSocAT2XYners7CwRuj
 PA2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RonKHC0rvLmVwuhgYFpMP9d9c+EqHN8DdpEqiqpwSJ1Afb/RvCqWzHFQ+tHu+M5NqB4wDwOqdQFS4s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywt3ZIV7NR8h0ck1eey1XT9ZI0M3y8UeY3K4SeSZjiciGumwdoE
 BTG0H6XTBwsSow3I2k1/vd569m8jo296q+TNQFDxWohWHhmV58dGhPtu
X-Gm-Gg: AR+sD13sMVGjMM0W5wrvXvyF8OzJcp5k+bkrK7gF3USgJVSkeWndiZg5kMFFr1j83Ui
 +A5Q2Ftd84lA7oKCdeNlAX53C60lLAEPVky1zqx1GTM+4KSXBaRhniUJpj80ASCha/UMNg0+KPc
 dXVsvqT2mRpYcCqBLIPDcbrLfykbDkN0kQvJH7mjUymT2TxO7U/YoPI+ptyS+8xlFgXL4B7gU75
 rbmzfEA8zsbQuDsu3sRmVw+XWbsZ7mwPfYddIm/NFO2DWAbpKoTt7F+PIiBL9IUxyrrJ0fdzPQD
 GznkPtJhuh0mW9f1gBnmDd27AVegoZQA43i7dV/OoQ7qYJKmqtrVPxZjrKkJ9c2huWhSA2OQAW9
 gqjHVMzAtBLzhV+wOca0MZpqcCr4Y+CFvltn8NNYJmDzK9+NdD/XvAJ8hQ0RXwrkE7t7xoEi9py
 kq85Dpm4UnRTbVGMXvKCQRs1gCpO00yHB+hlZqO/MNQy/dL+9v6It9ntGkwK7ri4pYO6aunbrgY
 vEzZL5hHK4mjIt8trNEjnVEHiN/XCUlS3o=
X-Received: by 2002:a05:600c:a45:b0:499:7a5e:4c3f with SMTP id
 5b1f17b1804b1-4997a5e4c60mr12527455e9.1.1786461049771; 
 Tue, 11 Aug 2026 08:10:49 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm54307265e9.2.2026.08.11.08.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:10:49 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
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
Subject: [PATCH 3/6] drm/panel: Use devm_mipi_dsi_attach in Novatek and
 Raydium panels
Date: Tue, 11 Aug 2026 17:09:47 +0200
Message-ID: <20260811151000.75038-4-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Novatek and Raydium panel drivers and drop the corresponding manual detach calls from remove paths.
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

