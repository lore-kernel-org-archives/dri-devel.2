Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF01C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE5010EFC4;
	Wed, 12 Aug 2026 13:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2k/Fm4n";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4A110EFC4
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:04:55 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso413465f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539894; x=1787144694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Sjo2pf9/HRrEOX8Q8Nkk1IQP122bRFXP6EiLXN0F/g=;
 b=q2k/Fm4nq5cSOdg72UOj6RyY+Hu8npBAk4+dj0/u2ifBbYGuMieSx+tbICWI6BLpG2
 ZhNnvtvvqJLZ0bpGQL5/whdEFagIGcZm9br75wNftbOC1YH5S3qLXZwJPw9MEMu6Pvt+
 OJQa+yhBtHlgGLXwbTD26Hn5EB6NINb6ET+FvXwPRrPG4jedvTA7+4Xw+iHe64AMO1P3
 bzo2UhQfv0B1+g56cYRWK+oFzBDXCtCo0P1UvHcYlQU9pfOVA7xsJ0kwJvpsuUb2KrNl
 WxB+KipXeQmBycMKf75EuwjkebXC/gFpVcHxQMu7cltyrM5mf74Ul/ikybkt+TtJ2GqX
 9zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539894; x=1787144694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Sjo2pf9/HRrEOX8Q8Nkk1IQP122bRFXP6EiLXN0F/g=;
 b=cWQ8UgMuZZHgEqlH1e0InOJwVeLdtKVR2+GP7eeEmALhL5ALoC1ltr3ulyXTDGSOsW
 fU+Q7juvocCrgEhrbxQy3eeg0jRHMMANzvxK8OqA6SRVSlvNG4/N9sCxA/8AxJ0/dT71
 6MHfmZ/w6oGUZm+ApeLm2fONAELyto4YbbHUOUnNM2S2DLDqGP2nA0szNKv/CwqvYUSf
 zjzAtjt7MHIgIYGSort+aN8dLAHN4YZ3RaZwZiW5vUL0/RJksqDe/i1Epk+v4R1+RWbJ
 BAbeQgXOjYcXeMH6D2vF9wdFtr0a4eN5JSPK/0m9Mw71+QlrmxxpRirapAeKfzwsWeTx
 a/CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR6QWOoFaj3JkxxxAawV6qhoW7l+Fx5CpF47FBFkVIQbv9PH5S5S4+XOrKQXR+Y4kuM8O9ELjj5sE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxENigrfAwLbuLouYvVcICK+Gt3FJ11mULxiG3euBhi7NDtkKo1
 jHfEhlL7v3rmJA3FbJ3elSdAjpQKZYeFY/yueWAVSj5HNPVJWBl9CPF2
X-Gm-Gg: AR+sD11gnwOAMNKnzfRIWoE704kGhHxymgp4BFL0VPInn3PyTcPBuirxnvrWGiI6opf
 uCFS4hIuIyskdMa9fRHBEfdLXkUXg28EN8yT9jgWMkjVH6/mI+kDC+i1hRP6V0DY4BGQxEC1cn2
 li4h1jwOUef5kU99pXSW1XD6Kf656mgBph5hoQlmHqhyRpY+fesbPf9E4BbuVuahvBK23LNFlZs
 12FzRGT8pbskA8F/PVgPYYKEs5n0wkVnCYMaA3rMbjHBAlFpmeCdRqYZ8VSmUdVKzB3hN8Jx3/H
 +kDcb0wYl0MRM7Kz4V0TpjG81Urr+uNeAlEB4NE3WxpSaX8QgGv36QmYV+Ar6NCJyx7BJp31mpx
 S7Coj6zaZJ/BNRg1qDljUD9tO4BSCBOow3krz34klNC7XGBBy3kavmm4VHLitTikjrsHxYHSMLw
 xfY405gYilzeFfKBBU3CkHh72/21auVRFmpO7xzm9uEgPXfYMvXa4n0/RiedVoOj8MgKXlvsXh8
 wy8xESHr6xV+hcNHQqi0/GIqsLY+GhFalhV
X-Received: by 2002:a05:6000:470b:b0:481:5657:5299 with SMTP id
 ffacd0b85a97d-481565752a7mr3865987f8f.0.1786539893963; 
 Wed, 12 Aug 2026 06:04:53 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eb2csm7040804f8f.30.2026.08.12.06.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:04:53 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v3 5/6] drm/panel: Use devm_mipi_dsi_attach in display vendor
 panels
Date: Wed, 12 Aug 2026 15:04:22 +0200
Message-ID: <20260812130429.16850-5-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in JDI, Sharp, Sony, Visionox and
Leadtek panel drivers and drop the corresponding manual detach calls from
remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

---
v3:
- Move the changelog after the `---`.

v2:
- break long description lines.
- add Signed-off-by tag

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

