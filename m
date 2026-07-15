Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE92C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5B310F03C;
	Wed, 15 Jul 2026 13:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="zA0J6HyX";
	dkim-atps=neutral
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE5610F03C
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1784121051; x=1784380251;
 bh=elEs6/r/QIGvt1rTdXTRifT6XlSg+OzMcAQsqVPf6ek=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=zA0J6HyXe+nF4sWhMD5uor/rb7+DpumqiDB3r0BDtpIo1xHNWvPVGP10d/C/J1WoL
 D+r8ZrG67zMVoX4UBbkeoMBwAjxpM9WAFIUX9CrOAtdaC5czD9MQN4sqaMYXggUEY4
 6+RG3W4BB72zL4jH8Hg+Mj4hgb1pKvEuU7OzGuys6yCQTFRyRA0mVytZNw6fVpU59I
 Pm5y6B14EojXFMhQQKo7Acp/ohlr0uBG7avDiBdqVTGvYM49Lr0VSYljgEAF7X9Xhu
 0n8g659f/obYWC1u9dw4e3rEdA5OR5AG5U0z2fpGwAwXRxwU1u0Qlp6CKDlCaq/MOj
 NlGF/2A5nWaPA==
X-Pm-Submission-Id: 4h0c4573PPz1DDL5
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 15:10:31 +0200
Subject: [PATCH v2 1/3] drm/bridge: ti-sn65dsi83: Fix problem with
 premature PLL locking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-ti-sn65dsi83-fixes-v2-1-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784121041; l=3546;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=IYOu9ByE0D3xpXZcX73ITGOqwyqENpPSB8q5qtN4R8c=;
 b=x5qV3xl8KnTmqhftnOukNeNC3aRoGFMiTHpo57aJRd6b81UH8RbcAgh6YMUFuo4bsaDIt7Pc4
 iCz5SC6kfVWD5rvZQJeWTlqhdM4Fb3xZ8aprr9grwq5Mto83x1pJmAz
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

Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..b4b220eee790 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -530,7 +530,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	bool test_pattern = sn65dsi83_test_pattern;
 	bool lvds_format_24bpp;
 	bool lvds_format_jeida;
-	unsigned int pval;
 	__le16 le16val;
 	u16 val;
 	int ret;
@@ -680,26 +679,12 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
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
@@ -710,11 +695,24 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
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
+		goto err_exit;
+	}
+
 	/* Clear all errors that got asserted during initialization. */
 	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
 	regmap_write(ctx->regmap, REG_IRQ_STAT, pval);
@@ -734,6 +732,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 		sn65dsi83_monitor_start(ctx);
 	}
 
+err_exit:
 	drm_bridge_exit(idx);
 }
 

-- 
2.55.0

