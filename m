Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41B2C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328EC10F025;
	Wed, 12 Aug 2026 14:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iq9vQAXm";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5005710F025
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:22:06 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso8153625e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786544525; x=1787149325; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSBaDCiHXcH7od8kZUYH0XWJkxiBBbB5RxDxKzyH17s=;
 b=Iq9vQAXmXl0tY2BrGN0sej9DTBY7Y5zPchWpH5ine6K2o/3QavcXgkbKQtTjY3PgDB
 Olp1yIvyEyNO7wJOY8t6bwuMO182ktKszfyHWivGNsR051Xbh+CtyQKp2DUqcOhvz5NG
 nbYdMtxNPlV9SKWg+60ZcnHZBCKOIIXdDk0gmJypqoAx3x+EfpoegOmckPmFTpV//wbZ
 KSnaTKsItwPFQMIou345i0D0tI72EOFYX8cABZ9I8QSbryvSWEeYgBv6A1HTsSaYnTwB
 xfhNUCjCs7tXk981HaMlF3zo8qYR3vRSF5afAAwyLSIXKFZq+6Vmx+w3gcwYtpQQJrSA
 pTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786544525; x=1787149325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSBaDCiHXcH7od8kZUYH0XWJkxiBBbB5RxDxKzyH17s=;
 b=af/76+jTRCpnvCDhi6hC6C61ghfzW7JpuLI+aTgkVwqLQZXJ7/3QS44Qu+VmufA3WS
 5H/o5SPDqDr/JHFde4muDv9698fKwIwZYHDg8gSBHBLe4l8WTqaq37w1xzfolU0aXmvs
 kM9r1V7qDjsEJMcrcEvSIkZr4QM78AMRC26IkDSFi212PmznIkRjuh6ftnzRgNl8k8IM
 grM3Re4cMMr116w3DQ9kCwKJFZcDSWPPPlMMXTzA3oTy+qvWV1Smq26Boy7GT8V0GSbA
 SOWVggIgCVc9hnzNFqiqqDFBGMePBFrnad/ZWrHOP+QvqiwNtkPlXJZxI7sWeMimwzW3
 Z2fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RohyOxjZJ1AttTEcEhkEFsqjZFIbsit14dq9EJJ8+Uzn67k+x82t4IjLJVoK6fuBvCqjs7dqGgPWOI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3dyt2xQCDqcnh3l6792YXtqlUxI51Q/Xk7Bw2fofPxGoYn94H
 kLPMyV/fLUOjU0amtwjDm6jX19pkRh9L8MdymjRHDpjXSzNIRNAsJSt5
X-Gm-Gg: AR+sD12NxE01z/5SIPI51tPSREDy7ifOgwK+AXiTGlyZPfSKm0N8agrOnTHpwt1+k4B
 R+BhFsrOK7tuQkoyQOCmJPfaAk60rWUuEFXHCRqpMbMjtLlRn7CtN5Wfcnsf4Nf3pEmFS8RkLn3
 iycYOptVcJjxogiQ3lofSPZSoz27JzmTghYL/hLA5ZiLN5K1ZTEMgzgoHHZwLYo0LCdBNSF9Txs
 tddJZUbNc1y3/FolPgIyf8mzdPDQqkmOjeMRkh4Tr63tAXK8H0ih10NfD8Lz+y+IN341fb1Kjw2
 Essk2zKYU6zhf5LRrWLTeGZJqH2erPLVEzvlAo0e+IMATR8ylvaQw3VJEQL9TkW1+x2UShSf04n
 0lOdQjj/JJ1ZHp/HR2c5IjjnQ2DqjTOkUxT/S2sng4GO+joEUADsoDD/Iy2fvP8Nk+RT+IvWkER
 M5KWQFcj2XpRVsQMbw4+o7eWnvDEvUtSwX5+yJQRoohYDzuKFec78wBcTU2phRFM438xwkHpV/Z
 5Rr2CsrnrS4nmK1Kb50jX/Mac+m0pWXghMO
X-Received: by 2002:a05:600c:3f0c:b0:495:4d5c:903e with SMTP id
 5b1f17b1804b1-4997c10aebbmr85438685e9.7.1786544524351; 
 Wed, 12 Aug 2026 07:22:04 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c993d80sm55360995e9.12.2026.08.12.07.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:22:03 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v4 1/6] drm/panel: Use managed helpers in BOE panels
Date: Wed, 12 Aug 2026 16:21:54 +0200
Message-ID: <20260812142155.51941-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach and panel add helpers in BOE panel drivers
and drop the corresponding manual detach and panel remove calls from
remove paths.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v4:
- use devm_drm_panel_add instead of drm_panel_add.

 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c    | 19 ++++-----------
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 23 ++----------------
 drivers/gpu/drm/panel/panel-boe-td4320.c      | 23 ++++--------------
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c  | 24 ++++++-------------
 drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c    | 23 ++++--------------
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 24 ++-----------------
 6 files changed, 25 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a43e..e9519923c6d8 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -357,9 +357,11 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(boe->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&boe->panel);
+	ret = devm_drm_panel_add(dev, &boe->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
@@ -368,18 +370,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
-{
-	struct boe_bf060y8m_aj0 *boe = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&boe->panel);
-}
-
 static const struct of_device_id boe_bf060y8m_aj0_of_match[] = {
 	{ .compatible = "boe,bf060y8m-aj0" },
 	{ /* sentinel */ }
@@ -388,7 +378,6 @@ MODULE_DEVICE_TABLE(of, boe_bf060y8m_aj0_of_match);
 
 static struct mipi_dsi_driver boe_bf060y8m_aj0_driver = {
 	.probe = boe_bf060y8m_aj0_probe,
-	.remove = boe_bf060y8m_aj0_remove,
 	.driver = {
 		.name = "panel-sw43404-boe-fhd-amoled",
 		.of_match_table = boe_bf060y8m_aj0_of_match,
diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 4a8560b4b899..facf37bd1c14 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -851,9 +851,7 @@ static int panel_add(struct panel_info *pinfo)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&pinfo->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &pinfo->base);
 }
 
 static int panel_probe(struct mipi_dsi_device *dsi)
@@ -881,23 +879,7 @@ static int panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	if (err < 0)
-		drm_panel_remove(&pinfo->base);
-
-	return err;
-}
-
-static void panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	drm_panel_remove(&pinfo->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver panel_driver = {
@@ -906,7 +888,6 @@ static struct mipi_dsi_driver panel_driver = {
 		.of_match_table = panel_of_match,
 	},
 	.probe = panel_probe,
-	.remove = panel_remove,
 };
 module_mipi_dsi_driver(panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-boe-td4320.c b/drivers/gpu/drm/panel/panel-boe-td4320.c
index 23558a76dd72..73b762817e3e 100644
--- a/drivers/gpu/drm/panel/panel-boe-td4320.c
+++ b/drivers/gpu/drm/panel/panel-boe-td4320.c
@@ -202,29 +202,17 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void boe_td4320_remove(struct mipi_dsi_device *dsi)
-{
-	struct boe_td4320 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id boe_td4320_of_match[] = {
 	{ .compatible = "boe,td4320" },
 	{ /* sentinel */ }
@@ -233,7 +221,6 @@ MODULE_DEVICE_TABLE(of, boe_td4320_of_match);
 
 static struct mipi_dsi_driver boe_td4320_driver = {
 	.probe = boe_td4320_probe,
-	.remove = boe_td4320_remove,
 	.driver = {
 		.name = "panel-boe-td4320",
 		.of_match_table = boe_td4320_of_match,
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index a70a2e58f88c..c5f18e310b43 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -391,25 +391,16 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err_probe(&dsi->dev, ret,
-			      "Failed to attach panel to DSI host\n");
-		drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
-}
-
-static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct boe_th101mb31ig002 *ctx = mipi_dsi_get_drvdata(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (ret < 0)
+		return dev_err_probe(&dsi->dev, ret,
+				     "Failed to attach panel to DSI host\n");
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
+	return 0;
 }
 
 static const struct of_device_id boe_th101mb31ig002_of_match[] = {
@@ -431,7 +422,6 @@ static struct mipi_dsi_driver boe_th101mb31ig002_driver = {
 		.of_match_table = boe_th101mb31ig002_of_match,
 	},
 	.probe = boe_th101mb31ig002_dsi_probe,
-	.remove = boe_th101mb31ig002_dsi_remove,
 };
 module_mipi_dsi_driver(boe_th101mb31ig002_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
index 20b6e11a7d84..8a6c4d5c6320 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
@@ -198,29 +198,17 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void boe_tv101wum_ll2_remove(struct mipi_dsi_device *dsi)
-{
-	struct boe_tv101wum_ll2 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id boe_tv101wum_ll2_of_match[] = {
 	{ .compatible = "boe,tv101wum-ll2" },
 	{ /* sentinel */ }
@@ -229,7 +217,6 @@ MODULE_DEVICE_TABLE(of, boe_tv101wum_ll2_of_match);
 
 static struct mipi_dsi_driver boe_tv101wum_ll2_driver = {
 	.probe = boe_tv101wum_ll2_probe,
-	.remove = boe_tv101wum_ll2_remove,
 	.driver = {
 		.name = "panel-boe-tv101wum_ll2",
 		.of_match_table = boe_tv101wum_ll2_of_match,
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 150dff3ab6c3..cf9f15fae272 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1736,9 +1736,7 @@ static int boe_panel_add(struct boe_panel *boe)
 	boe->base.funcs = &boe_panel_funcs;
 	boe->base.dev = &boe->dsi->dev;
 
-	drm_panel_add(&boe->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &boe->base);
 }
 
 static int boe_panel_probe(struct mipi_dsi_device *dsi)
@@ -1765,24 +1763,7 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, boe);
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		drm_panel_remove(&boe->base);
-
-	return ret;
-}
-
-static void boe_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	if (boe->base.dev)
-		drm_panel_remove(&boe->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id boe_of_match[] = {
@@ -1820,7 +1801,6 @@ static struct mipi_dsi_driver boe_panel_driver = {
 		.of_match_table = boe_of_match,
 	},
 	.probe = boe_panel_probe,
-	.remove = boe_panel_remove,
 };
 module_mipi_dsi_driver(boe_panel_driver);
 
-- 
2.43.0

