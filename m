Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95653C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0A310E262;
	Sun,  5 Jul 2026 21:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KSUfAx9L";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0119710E247
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 21:35:47 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29DB2B8B;
 Sun,  5 Jul 2026 23:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783287299;
 bh=gdRkLQABCso7Pq+hx4ptN7VAvIimLCYikztKh8bbSfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KSUfAx9LwSMa2l5hnQUZLe8H4Td880SoqHfCZ427jjdLCtz5/oKodZ34b8oNIAvF+
 pp8NrqvP+VELSxxQNu1bM2p+tgsRQKIm2tWBn+QIuuYqkyroFos2HoEf3Vh7Mp2uWN
 pBPWDi6oDCE25/arzodjJ2PvlFMKgALJk6SSeR4w=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/4] drm/bridge: display-connector: Fix I2C adapter resource
 leak
Date: Mon,  6 Jul 2026 00:35:40 +0300
Message-ID: <20260705213542.28987-3-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
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

If the probe function returns an error after getting the I2C adapter for
DDC, the reference to the adapter is never released. Fix it by releasing
it in the bridge .destroy() handler.

There is no need to test the ddc pointer with !IS_ERR(), as
of_get_i2c_adapter_by_node() returns NULL on error.

Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index d1e74dd2e051..eb3412ec30a0 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -43,6 +43,13 @@ static int display_connector_attach(struct drm_bridge *bridge,
 	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
 }
 
+static void display_connector_destroy(struct drm_bridge *bridge)
+{
+	struct display_connector *conn = to_display_connector(bridge);
+
+	i2c_put_adapter(conn->bridge.ddc);
+}
+
 static enum drm_connector_status display_connector_detect(struct drm_bridge *bridge)
 {
 	struct display_connector *conn = to_display_connector(bridge);
@@ -208,6 +215,7 @@ static u32 *display_connector_get_input_bus_fmts(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.attach = display_connector_attach,
+	.destroy = display_connector_destroy,
 	.detect = display_connector_bridge_detect,
 	.hpd_enable = display_connector_hpd_enable,
 	.hpd_disable = display_connector_hpd_disable,
@@ -439,9 +447,6 @@ static void display_connector_remove(struct platform_device *pdev)
 		regulator_disable(conn->supply);
 
 	drm_bridge_remove(&conn->bridge);
-
-	if (!IS_ERR(conn->bridge.ddc))
-		i2c_put_adapter(conn->bridge.ddc);
 }
 
 static const struct of_device_id display_connector_match[] = {
-- 
Regards,

Laurent Pinchart

