Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE4C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E88E10EFB5;
	Wed, 12 Aug 2026 13:04:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mWyq5EvN";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EA5910EFB5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:04:39 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so515336f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539878; x=1787144678; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iwslSfG+p8iUF3XFQu9lDnLhoLT7aq27LjQL7Nhl58U=;
 b=mWyq5EvNj5bFkc6up5p0Jsbw7Kdd6C3Hk41hg3AlNarL1AElq3q/Cp3t76kqZtfqg9
 ovvqV30KrMXEcZEHvSylqkJFwYW2Wd3NGIxZsBA6Zi6ijmus3O9T4HhU1Pkexkckfc93
 Rtzp2W/sP4aRXqE3YA+KfJGLq4DZNZU1UFebgMgbSnp5yWUp0Bq6l2iJodf3E52o/YU5
 9tF8GXCZyFASytYHWNedfEBG2pCEclkGYB20Qp/dHWqkjbPa+/RFrwGAl1LoolSN3H1H
 wWjygs+6nbfTgSJfeJwjQABvvEs059RQQR12hi5vu7jDL3EYZt7b56LEZtEKEaZlDkVo
 eAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539878; x=1787144678;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iwslSfG+p8iUF3XFQu9lDnLhoLT7aq27LjQL7Nhl58U=;
 b=UovCh+ZK1jANIeBLt37TE5G0hladV6mdHfksYtWW2C3zvMnkQ5eusQTPQgLkEDqxO1
 TlWbhBnDD9mgj9EKzqg7CQTP+NM7OOi78TZhzRkzMwAR2NdCJKwreIafVcIBAUHWR/C8
 0M4tkNb1LAw6xPK7SHGIa6jDDYEpdT26h+utoMEWy0jxGdBFlgwWIHMEvqkjm1N2ERC8
 Roizpahm0o3VGS1gErTy+41kk6OG2MTZNTPow0X6OYj429jVOyCrDhuiJsZhe+ZlTimh
 r4M7gHWlL0qGdmDZFqkhTzfQEo0s7TWhTA8UiUy8LPRBfzvkiGOTJgHRl/9lh2v+UYe3
 RskQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVeT17VJpldhS1+fNTiduRT4+2QQdURgYjt0tjpwUM16uUhKn/Q7iUliTxMso0w/hYYc/0zMWufh0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPX1Neuybs2zZNpCqljJVVg1HhclezfMOgun3orNwbyaQgZANT
 T7WDbYBgn/Jvr7ppN15NIWSv0y2PTIL2kVWLsaty7UrcXqicRYAavjST
X-Gm-Gg: AR+sD13l7Hd/4JsnmMkV4m/vrnZWiBYx//uLHvbyzugjr78RXn16gvxgClJiCU1Et6s
 HC3EwHnaNAl5HUp1lrtQVWAwJdZPv9VoBqD9tRa+ikVDYEJ+dGtWRAFVi9U+XZLeRYkl7OAr4yA
 HOdfl182Kl6k/ma2bWYZwHzSnLgInbQ4EaB2Hzffs91IB2cTAf9+BYZ+NcKYZJUHVwqwG2vWBzD
 9y9WSs7VbTRSL4/mu2g9U0Qo2aJiaMA7bzQ9129mO3z89BZwzs4AsYYl8s1uh/1TxYAaMXfoDJ9
 BPtO/F+L/KDhMT9bWYeZefI76dC3FnHduJZCLRmN5ePwE/cWTM9yyvnzl5fpNHkirGk57VEO7jp
 n/vtuGNxXPg9FR5BpjkPj2mKDhy0e3TaAuBWXulMDIhX/yCbd1IUnqSVw0N5+MND0WNPmRYrBmN
 jmQEoJh8lWBoOCTOls+8+0h1OlrMrV+B3sh7zIMRsXqPmH4SJIGtBerlMOFTi4xKYoCICEysLPa
 KudxlH52jjwDSdl7JtONsYc8T0=
X-Received: by 2002:a5d:64e4:0:b0:47f:f908:ba7b with SMTP id
 ffacd0b85a97d-481528ec696mr6980548f8f.23.1786539877808; 
 Wed, 12 Aug 2026 06:04:37 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eb2csm7040804f8f.30.2026.08.12.06.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:04:37 -0700 (PDT)
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
Subject: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
Date: Wed, 12 Aug 2026 15:04:18 +0200
Message-ID: <20260812130429.16850-1-osama.abdelkader@gmail.com>
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

---
v3:
- Move the changelog after the `---`.

v2:
- break long description lines.
- add Signed-off-by tag

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

