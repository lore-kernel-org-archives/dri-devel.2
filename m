Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50411C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:10:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1DA10EC69;
	Tue, 11 Aug 2026 15:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BapOW1SO";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CA510EC69
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:10:57 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4956869750eso21874215e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786461056; x=1787065856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FqY4BGNrVrEdqqs5mL1dMpbRJH5xMB3zokQi0/ffwZ8=;
 b=BapOW1SOM5ecPNuOFhmKvtk9/7kNy7h16G6rnBxWKbBPwhAMcV6QpzXIDIDA/fy5yP
 OoaP1hRnICHJJ2fORiIMHNNtxIoe7/k6MDx4TsBbdSMxxOn4hN2oswyihCDRR2V91HWK
 U8h9p511rJJmx1oHGlbS+SG2+F6QfLvJHOlf42mmzSkd2b4Dn7lKbfwT7D5qg24P1JBJ
 MPV9qWEK0ZBAevwtpCHhZPdqt5N8N9TmyK4IkS9ZrU+afJHvrbdzcCzoV9JKiv2W9y8A
 D+s2Gmfjeg5jrxuMl7dfWoY+txkCeaSgVUxpQ20zW3fF1R2ln8HgZYMTnfIK1SBEEtf9
 WnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461056; x=1787065856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FqY4BGNrVrEdqqs5mL1dMpbRJH5xMB3zokQi0/ffwZ8=;
 b=CYE8JoMkdTl8v+PstXnxnztawFBqcqWytaqXEHX2dlPwc60x3NGsOC1TosOBxNjb5b
 K0ZOXcR3sn+F6p0288hlMynaMTsdDkEt5yIagyuA8iCuUx5ODUD1/noozer0gFgyGfpz
 6aorDPmK+bwhkX3JzHvHNWKM+q8iLajuHTyHy6Zr6RU7S8yFaZppKPIAOBTOCjL5orga
 WM6e6eyC0f4lCcvjB9ehreTEj67IwCqfQWuVwvQtzb9B6mhRvPXgiNaIFuMwHS4NvHNU
 Xk/PT9LX9tRbPCkZzt1U4RiFEAdzxSre0L+ukUDbNo/b1JzA/1LWCbyr+yYLlhsKb3oH
 I0SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMwSdHslHfWU+Q1kqaUTRl2KVOcb8Kh9AAkZ/8bQU7rmM3CAR+h3EOBbBp2hUSKIKjWK183mHItNI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxwn+i9Ir9+phMTHl+Wt102XXAHZ3C5PtHSUfhIqLVdyTFvRmSE
 EQRMnkDxpvAicLezj33P0p6cQJDNzJclkqWcdlycfnzibGeh6uvU1znwvNRp9JNf
X-Gm-Gg: AR+sD11LLU4cZKZElx+G4x4knXbzBepyId89wBxPi3JqrqzsBpx3KMKGamAwzLR+Ikj
 ghEiizxZGJsJNdzy6G2M7mj4rvDdh/7gS5e0Y7X0Q7UxYgm/bxog5sSqyxewD8I+rL6ojong9Ju
 QNV21vh4dqSCzw/pb69SXGqcikiCWrRyi2KA/tExExlUbmil6vB8FAdz8cyNBey//leHr9qYNTV
 AJMgPpDTvTRVdJ+d6ES1vHKvCGFo/Y5PfwSmb5g5/INR7EEpsfcRuK7i7p9/U2oK56XJbUPZt7Z
 3iHKl8+Dahv09ExMfVA5xin6M7fTDigINJjSU/Z7wi9Mubx5nq13BvSZOipSdt0QCvsdxbt91Q6
 ozfMJenv3xgwlPSWxuvr6yIuiMVRT1M7tpE9aQMKuTz+azFYVGRYrtvPQ6x4bzOUdEvR5Q6zVQX
 47Y7f2EhS//0gqng1tbqzzXdxgrassG4zHw+ZmqBtJRlZi/LoSv0g8M2F4uXkkqXTSa+2tmMYNp
 7gFoA/ClhhN9AVuvjkaUVrTWvvJ3Cpyo3w=
X-Received: by 2002:a05:600c:154c:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-49979b9e359mr30314355e9.0.1786461056011; 
 Tue, 11 Aug 2026 08:10:56 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm54307265e9.2.2026.08.11.08.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:10:55 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 5/6] drm/panel: Use devm_mipi_dsi_attach in display vendor
 panels
Date: Tue, 11 Aug 2026 17:09:49 +0200
Message-ID: <20260811151000.75038-6-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in JDI, Sharp, Sony, Visionox and Leadtek panel drivers and drop the corresponding manual detach calls from remove paths.
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c           | 8 +-------
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c         | 8 +-------
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c     | 8 +-------
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c     | 8 +-------
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c        | 7 +------
 drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c        | 8 +-------
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c          | 8 +-------
 drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c | 8 +-------
 drivers/gpu/drm/panel/panel-visionox-r66451.c          | 8 +-------
 drivers/gpu/drm/panel/panel-visionox-rm69299.c         | 4 +---
 10 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index cbe354b51bce..ce299160d3ab 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -202,7 +202,7 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
@@ -214,12 +214,6 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 static void jdi_fhd_r63452_remove(struct mipi_dsi_device *dsi)
 {
 	struct jdi_fhd_r63452 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 01bd748aecec..d9cba45eb729 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -380,7 +380,7 @@ static int jdi_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		jdi_panel_del(jdi);
 		return ret;
@@ -392,12 +392,6 @@ static int jdi_panel_probe(struct mipi_dsi_device *dsi)
 static void jdi_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct jdi_panel *jdi = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
 
 	jdi_panel_del(jdi);
 }
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 0856df5a6ee2..b660d7055810 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -585,7 +585,7 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -598,12 +598,6 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 static void ltk050h3146w_remove(struct mipi_dsi_device *dsi)
 {
 	struct ltk050h3146w *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index 7f19fd5b8060..6ec6f81877aa 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -651,7 +651,7 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -664,12 +664,6 @@ static int ltk500hd1829_probe(struct mipi_dsi_device *dsi)
 static void ltk500hd1829_remove(struct mipi_dsi_device *dsi)
 {
 	struct ltk500hd1829 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 989b030ea22d..11615551e8a6 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -244,7 +244,7 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		sharp_nt_panel_del(sharp_nt);
 		return ret;
@@ -256,11 +256,6 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 static void sharp_nt_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct sharp_nt_panel *sharp_nt = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	sharp_nt_panel_del(sharp_nt);
 }
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
index 0456f3d705e7..236d45121a44 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
@@ -235,7 +235,7 @@ static int sharp_ls060_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -248,12 +248,6 @@ static int sharp_ls060_probe(struct mipi_dsi_device *dsi)
 static void sharp_ls060_remove(struct mipi_dsi_device *dsi)
 {
 	struct sharp_ls060 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
index a14c86c60d19..08e4adf9e0f0 100644
--- a/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
+++ b/drivers/gpu/drm/panel/panel-sony-td4353-jdi.c
@@ -216,7 +216,7 @@ static int sony_td4353_jdi_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -229,12 +229,6 @@ static int sony_td4353_jdi_probe(struct mipi_dsi_device *dsi)
 static void sony_td4353_jdi_remove(struct mipi_dsi_device *dsi)
 {
 	struct sony_td4353_jdi *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
index 216a6ad8696e..5ce8b1cdf024 100644
--- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
+++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
@@ -474,7 +474,7 @@ static int truly_nt35521_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -487,12 +487,6 @@ static int truly_nt35521_probe(struct mipi_dsi_device *dsi)
 static void truly_nt35521_remove(struct mipi_dsi_device *dsi)
 {
 	struct truly_nt35521 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
index 690cccedd438..40bbc3ea6958 100644
--- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
+++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
@@ -306,7 +306,7 @@ static int visionox_r66451_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -318,12 +318,6 @@ static int visionox_r66451_probe(struct mipi_dsi_device *dsi)
 static void visionox_r66451_remove(struct mipi_dsi_device *dsi)
 {
 	struct visionox_r66451 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 50f8a84537ca..7a60b1d436df 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -388,7 +388,7 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "dsi attach failed ret = %d\n", ret);
 		goto err_dsi_attach;
@@ -404,8 +404,6 @@ static int visionox_rm69299_probe(struct mipi_dsi_device *dsi)
 static void visionox_rm69299_remove(struct mipi_dsi_device *dsi)
 {
 	struct visionox_rm69299 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(ctx->dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
-- 
2.43.0

