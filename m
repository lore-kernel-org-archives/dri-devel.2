Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8871AC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 11:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E231210E349;
	Sat, 11 Jul 2026 11:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="y5of0RWZ";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6901210E342
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783770684; x=1784029884;
 bh=oO3iHLIEY4Dkd9hUk7F8uXv2G2zjKubo11n99IpYTn4=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=y5of0RWZcF83id1QiD72MHhseqvKDP9+SmIog8Z7eAJjFXvxqjK3APMu5a6entU5w
 zVifFHBLGFanDAXMOAFPUYet+eFwelcGeJSAnSq5YYftC9bn4sEuYsWsF20GE5jI8F
 UEU5s1WcAIKKUqAQRapuT8sf8Uhsbjv88ZH3yZoE7M4s30zCRyOOWl22ui0g/55hoL
 95O8DLsjG9e3MukBH357CiDNGyL3eSuMWQImAc8Fih2HC0SaiVQY3PphHVENZfWr4X
 LDQza6ESNi9eTzRK5em8jL00fTxqlxUW0NmEzMmgsnDlYmyp/z/I4vz0P78wQ6tD8H
 i074JNFQwElUQ==
X-Pm-Submission-Id: 4gy6VK14ZJz1DDLC
From: Esben Haabendal <esben@geanix.com>
Date: Sat, 11 Jul 2026 13:51:15 +0200
Subject: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with premature
 PLL locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
In-Reply-To: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783770676; l=3251;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=pH/nP0E0g44vrK+eBi+bD71JRmcKQtkCWV8Og7DM+O0=;
 b=rld/PWuwaIB3p5dCOKhYC03tMTkQCLfuHAfHEKYG4cLtKAUYaDXZXYXDzdFtGcIlMcDsIEl7h
 0B7bNG/hmjEDuBfA0mBSPku9PdiafBRHKOYt/YeC/+MsuJbU2AZ6oTL
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

Locking PLL requires the DSI HS clock to be running, which it might not be
in probe(), but should be in atomic_enable().

This resolves issues like this:

sn65dsi83 1-002c: failed to lock PLL, ret=-110
sn65dsi83 1-002c: Unexpected link status 0x01
sn65dsi83 1-002c: Unexpected link status 0x01
sn65dsi83 1-002c: reset the pipe

as seen with nwl-dsi bridge and others.

This is the same issue as addressed in the patch by Gary Bisson [1],
but changing the ti-sn65dsi83 driver instead, so we don't have to change
all other drivers that could potentially be used with this chip.

[1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 32e9eadd7452..e87bed3a6640 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -532,7 +532,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	bool test_pattern = sn65dsi83_test_pattern;
 	bool lvds_format_24bpp;
 	bool lvds_format_jeida;
-	unsigned int pval;
 	__le16 le16val;
 	u16 val;
 	int ret;
@@ -682,26 +681,12 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN,
 		     test_pattern ? REG_VID_CHA_TEST_PATTERN_EN : 0);
 
-	/* Enable PLL */
-	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
-	usleep_range(3000, 4000);
-	ret = regmap_read_poll_timeout(ctx->regmap, REG_RC_LVDS_PLL, pval,
-				       pval & REG_RC_LVDS_PLL_PLL_EN_STAT,
-				       1000, 100000);
-	if (ret) {
-		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
-		/* On failure, disable PLL again and exit. */
-		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		goto err_add_action;
-	}
-
 	/* Trigger reset after CSR register update. */
 	regmap_write(ctx->regmap, REG_RC_RESET, REG_RC_RESET_SOFT_RESET);
 
 	/* Wait for 10ms after soft reset as specified in datasheet */
 	usleep_range(10000, 12000);
 
-err_add_action:
 	devm_add_action(ctx->dev, sn65dsi83_release_resources, ctx);
 err_exit:
 	drm_bridge_exit(idx);
@@ -712,11 +697,24 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
 	unsigned int pval;
-	int idx;
+	int idx, ret;
 
 	if (!drm_bridge_enter(bridge, &idx))
 		return;
 
+	/* Enable PLL */
+	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);
+	usleep_range(3000, 4000);
+	ret = regmap_read_poll_timeout(ctx->regmap, REG_RC_LVDS_PLL, pval,
+				       pval & REG_RC_LVDS_PLL_PLL_EN_STAT,
+				       1000, 100000);
+	if (ret) {
+		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
+		/* On failure, disable PLL again and exit. */
+		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
+		return;
+	}
+
 	/* Clear all errors that got asserted during initialization. */
 	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
 	regmap_write(ctx->regmap, REG_IRQ_STAT, pval);

-- 
2.55.0

