Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBB4C5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE6110EC64;
	Tue, 11 Aug 2026 15:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+olbgau";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7468810EC64
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:10:29 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso35001545e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786461028; x=1787065828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+5cZFvCl/vAsUiXuIlHQJb7GfBLhg5GlqSTHb/6mrLQ=;
 b=M+olbgauNdOliS4cXsJqwYBnRJhltZHCCbGLZ3VaeUq9GNf8ymzn7vgIW22OTpQ4cp
 wXkj2787a7DUehXdYuutSvA081wH/+6ZcEZyTtqII4eKhjWZR9eMqBPnQydbAQNu2QHw
 0b0O7AKC0HKSN3waI51v6XdoteQTMBR2+5F9wblcijEL+OsIK/a/+FqTtC7ATIrXZg9o
 6uH8E35UCAJIw2nBAoJ1Ac2ra1JdsVefgl3KusLHsh0WApcu0YMIuQ+LwG3keNI8j8Wt
 d9zERV77pfjbvHFvAZ8jZrJKAG62rWKu3RpJLv0DfpqyyqnatMYtpJzteFwBTTVMdr7r
 KBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461028; x=1787065828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+5cZFvCl/vAsUiXuIlHQJb7GfBLhg5GlqSTHb/6mrLQ=;
 b=anbSdBp2fbHekcp9Hx717p94SjFBq8gCZk3lr1WFrT2an1x8cQK2mpyo4saHRR7bMA
 ckcoOi0cyKV3i+WXtUl71Co3pG33ghbF3P9777pMRS+ANUay4h2+cLvJrEs1sOsspFKz
 VEEK721Ppzlle1X2U/C2BFU2NnWok7BvFzVGo7C8nHqK2hWzSOj+aEvGh9SAWvxI1QOT
 2EnRVHVebsF0+rpJ5gwHnDsArMCQUpRAF4m25Cb17yf6qe7vdrf0l6t2oDzXzQoVdjWi
 6T3NNeh74EGOAYI1U2KkAYU+a2TDz4m96b3fBb0LN0seQGdFrKjhA9qabEQd0HsM5aPE
 WlIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp80e4F59mBm18mOG/FxUhE2sT8BVJkYh3yfku0jAYb4cz0HJlA9L3AFe+iiU48nINMfqJEZ2RAC98=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzn82Gxyg93361j5DZwfBNqdlUNFsD47bMVm6+e0CJXT5Tl1rJE
 BcszCX4EIJO6LeeSBdxAReQxF16E9bx3Wi+swK/yc8hSDBibj6vW/1Mx
X-Gm-Gg: AR+sD100ZkAd39ln6645uMmvjCV949bfATQq4iIr2bDr3tZg1MIYsslQDhO4iVeLm8c
 n5QBpqSpLQ5QqE7Z6v/zs5393aouBfvfhLZwO+0h6Z1iYyPu4D951ZNQNTNDdzFiXqrykx1zRW8
 rvo62YVw5fpK5tT4tnSJUHrPlLF4mhV3GA2U3cb6wX19/Y9EyBU80gE/nNwosIiwjFUT1hhrxQ8
 VcfEDKNSg8TO/MZOBc8KWE+IPc1Lk3awvjK4ewatR3kM5yhoOspEnvD2RCyTAzIduiobfZ0pvj7
 pqTy8b3ZFKB/WAMtJLwlIFaJapw+MehLBS72kVM5vKr0i5D3bNJ+6LNAK3dtrNfQ7wuKi6RZYkb
 O59s/YHzEYoshmUaMFX0R4vwhHGxMhFrCP7lqaODSS1Qfr9ZhxcyiNJMTc78laqUEWl7bhKlMeR
 9s+MNNx4BKqi4UhlmSDmpQX3RpSh5hN2eWWC7XMpDYSvEq0CJ3RJ4aap9OKUFxsq1oQbrQTjcdm
 uxwJ6P4LX0zTZU2motzyJU3
X-Received: by 2002:a05:600c:c163:b0:499:4892:d022 with SMTP id
 5b1f17b1804b1-4997843e95fmr79403415e9.8.1786461027590; 
 Tue, 11 Aug 2026 08:10:27 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:b0cf:778:ae86:13b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977e57785sm54307265e9.2.2026.08.11.08.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:10:27 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Date: Tue, 11 Aug 2026 17:09:45 +0200
Message-ID: <20260811151000.75038-2-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in BOE panel drivers and drop the corresponding manual detach calls from remove paths.
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

