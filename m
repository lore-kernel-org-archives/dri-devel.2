Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD8DC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C97510E348;
	Tue, 11 Aug 2026 16:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eH7iGPli";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E7B10E348
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 16:51:00 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-495590dde14so150615e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786467059; x=1787071859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K2+JE1x+X5o7mEQxwM8IWJDe+MFPE9zYYrpiHBojfUM=;
 b=eH7iGPliLCTQgTmVxYjcG4ixrLTFLqgSF4LaMVrKtsL0juptBURPwQrr2DjI3N9Pza
 3L54A83QNwHIAiSkQ9Va0LLjPQtLk+itJW5/iwKnmrl+dJ+Kqu2kK0EXJuq2GOAkmn4v
 v5tfuPcl3zHItHEw4R5aWn3fkNO7YLIerCyM0ilA4C8W04mp8NAL91QIrGXxWojMCn0M
 CJqSK101gCdXbil6l0xiLEtyCfOLw051ZPkr5/2+vJUQXWorqNP+NrGk/TDYWpOU1gnk
 uN8BP+xjUHLE/mU1yiemhrkeKZFsUyXpY/Fqt8/YYSythRG7AZCp5ws808bcfl/OTbwY
 ubrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467059; x=1787071859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2+JE1x+X5o7mEQxwM8IWJDe+MFPE9zYYrpiHBojfUM=;
 b=ecSjLY1sAWRi8WMr2fAqqJSwJA7849m05X59F3WHpQcl8avEObXBdL7BwSpekIGmLU
 e1GM/lmh3PlU5fEakj/ThmD5FIJH9bPeEGFkYiKkLMuROOur18bqRoU7vqbjnn/qtYES
 HlYSeLT8TMQPR8dtlqdEB06FH3f0AJsbk0ZCRe+ErWDCqjzyKLzO+05XkIInG7aFaWcU
 ahSJELVRxA3eCZS2rZ7xxL4MrI8c8+y12nz1cfh91k6DhcpZGRql/tiJmAy40StS2z7X
 AWVjKQOCl+Cu+WpeH3HBhPTLfOCNu3g1ZtgF3a9hzb2bN78wxbnFJxaQY4cGYY4FGOXf
 SVMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo6qoo1cTNg5EqdTuOe6zPLTnQTXbGzXwu6H6EhtDDll72JYb/3XoN105R/VetmOWd3Cxv5vW2k1Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzACImU23yK0GlomcsR+VYWGK1bW8e54AG8GXAzle0JCz+EhG0R
 swetss2uK0aF0qsJQ2qHaEiJrHWdh+pCbME8XLL1ktqwnXEhrNYId6mh
X-Gm-Gg: AR+sD13guAsu9jxa2VPm9SBzrGveSf8OjQHb701Ns9weqih4cYkOpZ0gGkuyJ12hoQ7
 cuIIo1qQAdMPm3kyq/BBH2dxvJkFpcRqn6AYiqYBqwC6D/9Edb1213PcMO3TR4IUMtkiUOCBqDG
 fC5w3NVOdVZGME3H3vNxgqdOTYiEtLJoTxJIaLPBQ7A5qzvEG+updmPlIC0qtM2G1m+2h3JOEqz
 H26snAmU9ZhHVxY4Cp1ApCeMpfpRDj1XhNYflnrzgMiInrCDOH85rlFX8t4pBgRqbvRCs3d9LcG
 9AUgNOJ7Lg+Hx7B/YifFXm1RORwMwXUaVhFBx+ReOiJTglOn4fqajiBfTEqtPBXTQkV0UMUwvud
 TR2Kai9RN3cte45RRoF0kC8NrAuU2MdCsV/qHdj9IBkS3MSeCYAxuWMkTHm0iOCpR9wCpkNm/Px
 pOKOeYOXYHi+m2TITK3K4QOtuJ7QR7csA6QNYulcUfEmmg8OP59ccB8YgZhrMXYRRngkKUmKSUe
 FFHOYskevhsr4wvSIwvtPfARw==
X-Received: by 2002:a05:600c:a08c:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4997a5bc30fmr26660125e9.3.1786467058477; 
 Tue, 11 Aug 2026 09:50:58 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:434a:d6cf:4fd1:90b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aab4ea6sm11425975e9.10.2026.08.11.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:50:58 -0700 (PDT)
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
Subject: [PATCH v2 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Date: Tue, 11 Aug 2026 18:50:35 +0200
Message-ID: <20260811165037.12437-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

v2:
- break long description lines.
- add Signed-off-by tag
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c       | 8 +-------
 drivers/gpu/drm/panel/panel-boe-himax8279d.c         | 8 +-------
 drivers/gpu/drm/panel/panel-boe-td4320.c             | 8 +-------
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 4 +---
 drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c       | 8 +-------
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c       | 7 +------
 6 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a43e..6a74523a6614 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -359,7 +359,7 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&boe->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
@@ -371,12 +371,6 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_bf060y8m_aj0 *boe = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&boe->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 4a8560b4b899..ffcb63f65b75 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -881,7 +881,7 @@ static int panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
+	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (err < 0)
 		drm_panel_remove(&pinfo->base);
 
@@ -891,12 +891,6 @@ static int panel_probe(struct mipi_dsi_device *dsi)
 static void panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct panel_info *pinfo = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
 	drm_panel_remove(&pinfo->base);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-td4320.c b/drivers/gpu/drm/panel/panel-boe-td4320.c
index 23558a76dd72..704d5a9c13e7 100644
--- a/drivers/gpu/drm/panel/panel-boe-td4320.c
+++ b/drivers/gpu/drm/panel/panel-boe-td4320.c
@@ -204,7 +204,7 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -216,12 +216,6 @@ static int boe_td4320_probe(struct mipi_dsi_device *dsi)
 static void boe_td4320_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_td4320 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index a70a2e58f88c..94cc675973e6 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -393,7 +393,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(&dsi->dev, ret,
 			      "Failed to attach panel to DSI host\n");
@@ -407,8 +407,6 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 static void boe_th101mb31ig002_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_th101mb31ig002 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
index 20b6e11a7d84..2ab7764d4094 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
@@ -200,7 +200,7 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -212,12 +212,6 @@ static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
 static void boe_tv101wum_ll2_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_tv101wum_ll2 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 150dff3ab6c3..7d2672578dd8 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1765,7 +1765,7 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, boe);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&boe->base);
 
@@ -1775,11 +1775,6 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 static void boe_panel_remove(struct mipi_dsi_device *dsi)
 {
 	struct boe_panel *boe = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	if (boe->base.dev)
 		drm_panel_remove(&boe->base);
-- 
2.43.0

