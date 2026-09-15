Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160FC88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE91C10FBE3;
	Tue, 15 Sep 2026 14:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pD76e9x+";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7AE10FC1F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:59:54 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so2731493f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789484393; x=1790089193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBUilLABy+haqxmyNuDtxCS558jv0OslZcYLXXiBzgY=;
 b=pD76e9x+o5znSzZaZjd+zuhxTuHoLQ9zdJotdhgGbMIUu7UqSwnDnFRRjFTQKEv+xY
 yE5TPUyXavw3ZoHrIClO2xWHVY1BKInaB2bJF6/fQTtSQ74nzj0fwHwQbL5qWqgWBsbm
 ppHFafKXZZZiFw8O3v/l2wMqbP6xhBxjF4WeNGpRFQrootVdbNH3L32N1K+c7sh582UO
 aP5OH7n6zd1zcTkDW+YbkHZ8MSe/FwjK0S11vVjtvbYcb5phqm3uXCmAgyz6W9b+cRMw
 1Hhe0EGpxerorN4rEoVC6Ev4yRC+vhH220fy7VnpK1fbWi3VOYNV/lyBkcgGOfbUOB/l
 G+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484393; x=1790089193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBUilLABy+haqxmyNuDtxCS558jv0OslZcYLXXiBzgY=;
 b=FQU9x37KaoMf+nVwqHojatM+a4V0rxQp111MqsexoXqg8JeSs0KdPUtr1F9Y76Fvtr
 F0gOUPHVlouFz89zZmwWP970+pKHQhBdb7hfXGEkDSqv2VMeEcF30pgI0ZO3vxLPOtAV
 sa1p/QdSFQF3HhD98Wu5QYWcVeE+TvkKZbMsNbHkpUYMKrxKGb99PfciLGkCKA935JJB
 piNXvX0Y+FeMYB6KlUxOsQ3KkUwPjbomrJfh3gV8LGZZu2LHHVx3rZvdfT3wLC76kO5b
 ZiRIFoBgCTsXYyIO2fuJMXeMe/tqvg92ah3UCQ2jzUhUnaHG6QoUCN0rOuVprh2KYpJf
 OkCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3n1hdDFKmI3/0yUQlbbMRgll04LzFltco/+t1ShBtEm3VsLhxN7eB2a7w57CfuTfGvReamuG/bCQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgdZCj/8W6k88XjkvGU1KHHB9u9aVhrOknW87lqbXemIvi1l8x
 AHDJUxGWvJ4JaIBPGZH2Mml4Lg6FoNRl732FDiyffXZDy9filcO6/tsD
X-Gm-Gg: AYBFou20pZD0sQRe+nH7xOEETDE74sIgj8YhlMsb7lcYQKOzv7G0CbCR4IOYb8VDsef
 Wqilu4wEBldh6cmzONp9V8D9Y9x5kerBMXDUjeO56TITUiZv4LZT9Zhk0Q93elTQPBAl9N9gpW9
 wCky4TE+2jCFhk0jM+6fuLjIjxblZz5PxV2WvzV2VG4uLmMQ3tByCRlh3vOwKLtDe9tGuYMgNO9
 f7bFJaEKT/sY8cLGevHnkjEmSoBpe+wdwVa3QevD7dPv7ZLbt7NMGLoCt/eTDsZyNJVhsCgm00r
 MskqdvKc2bJKUkKWoK5Gm6VsBH1HsVeDUBZD2hYg0gKsSV8ZDSHMz/OpPHPWXoaWZKdUNZv6uYZ
 N8mAYfIf/I7UJQZ6To2HqrxkplLwppay/Zw7WooVf0r+/N+dwOrNPJzbUkcegKVMxppDppT/2m5
 42QTz2nhu+IQ9EWv5jDzVvP6ETSDCH9fislLBatCbmeUc1him7FNP/cC4TSfxexu1wVtuNajxXx
 ZDUri+qhzkI1GHp+ssoET9V5fLQxab89g==
X-Received: by 2002:a05:6000:4a17:b0:486:f282:e66b with SMTP id
 ffacd0b85a97d-48702aacdaemr18492748f8f.2.1789484392774; 
 Tue, 15 Sep 2026 07:59:52 -0700 (PDT)
Received: from osama.. ([156.223.70.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48707e00133sm5081128f8f.11.2026.09.15.07.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 07:59:52 -0700 (PDT)
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
Subject: [PATCH v5 1/4] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Date: Tue, 15 Sep 2026 16:59:28 +0200
Message-ID: <20260915145935.60397-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915145935.60397-1-osama.abdelkader@gmail.com>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
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

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    | 19 ++++-----------
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 23 ++----------------
 drivers/gpu/drm/panel/panel-boe-td4320.c      | 23 ++++--------------
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  | 24 ++++++-------------
 .../gpu/drm/panel/panel-boe-tv101wum-ll2.c    | 23 ++++--------------
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 24 ++-----------------
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

