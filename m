Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FCBC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC62F10ED76;
	Thu,  6 Aug 2026 13:17:36 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B544810ECC1
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:17:32 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5A76720210F;
 Thu, 06 Aug 2026 15:17:27 +0200 (CEST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wrxyR-000664-0h;
 Thu, 06 Aug 2026 15:17:27 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Yi Zhang <zhanyi@qti.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 6/7] drm/bridge: lt9211: use devm_drm_bridge_add and drop
 lt9211_remove
Date: Thu,  6 Aug 2026 15:17:14 +0200
Message-ID: <20260806131715.508557-7-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806131715.508557-1-p.zabel@pengutronix.de>
References: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
 <20260806131715.508557-1-p.zabel@pengutronix.de>
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

Use devm_drm_bridge_add() and remove the need to call
drm_bridge_remove() manually. Drop the empty lt9211_remove().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 14afffcb2e4a..c82f7ee7134c 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -1456,24 +1456,12 @@ static int lt9211_probe(struct i2c_client *client)
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
-	dev_set_drvdata(dev, ctx);
-	i2c_set_clientdata(client, ctx);
-
 	ctx->bridge.of_node = dev->of_node;
-	drm_bridge_add(&ctx->bridge);
-
-	ret = lt9211_host_attach(ctx);
+	ret = devm_drm_bridge_add(dev, &ctx->bridge);
 	if (ret)
-		drm_bridge_remove(&ctx->bridge);
+		return ret;
 
-	return ret;
-}
-
-static void lt9211_remove(struct i2c_client *client)
-{
-	struct lt9211 *ctx = i2c_get_clientdata(client);
-
-	drm_bridge_remove(&ctx->bridge);
+	return lt9211_host_attach(ctx);
 }
 
 static const struct i2c_device_id lt9211_id[] = {
@@ -1492,7 +1480,6 @@ MODULE_DEVICE_TABLE(of, lt9211_match_table);
 
 static struct i2c_driver lt9211_driver = {
 	.probe = lt9211_probe,
-	.remove = lt9211_remove,
 	.id_table = lt9211_id,
 	.driver = {
 		.name = "lt9211",
-- 
2.47.3

