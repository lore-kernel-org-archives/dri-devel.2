Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CAEC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B6D10E257;
	Sun,  5 Jul 2026 21:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cplnf87w";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D3410E257
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 21:35:49 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F0B1BCA;
 Sun,  5 Jul 2026 23:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783287300;
 bh=1F4yyozr22c647s5CMUnLLK4oVdPq6kvADdvLYZTias=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cplnf87wJYtIoM7IXeir1u6P8fZ/66j64mbZeVkIdyYIgM+XRs8o6AnedwPjeCGor
 iAybtHuDIq0ql/nnc3T8HGAyJlOPohHqlg9hMXS/Gd1h6+wE8n62zzSPFKYDAOQJAk
 zTlgH29FmiwE6DFN9jcV5oul65BrbViBFFRJ3Gp0=
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
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/4] drm/bridge: display-connector: Support hardcoded EDID for
 VGA connectors
Date: Mon,  6 Jul 2026 00:35:41 +0300
Message-ID: <20260705213542.28987-4-laurent.pinchart+renesas@ideasonboard.com>
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

The DT binding for VGA connectors allow providing an EDID blob in the
device tree when the DDC signals are not connected. This is useful for
devices where the VGA connector is internal and a display is guaranteed
to always be connected.

Support this feature in the driver by parsing the EDID from DT if
available. If a DDC bus is also specified, return an error from the
probe function as DDC and hardcoded EDID are mutually exclusive.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 31 ++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb3412ec30a0..225a8e987d08 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -27,6 +27,8 @@ struct display_connector {
 	struct regulator	*supply;
 	struct gpio_desc	*ddc_en;
 
+	const struct drm_edid	*edid;
+
 	struct work_struct	hpd_work;
 };
 
@@ -48,6 +50,7 @@ static void display_connector_destroy(struct drm_bridge *bridge)
 	struct display_connector *conn = to_display_connector(bridge);
 
 	i2c_put_adapter(conn->bridge.ddc);
+	drm_edid_free(conn->edid);
 }
 
 static enum drm_connector_status display_connector_detect(struct drm_bridge *bridge)
@@ -64,6 +67,9 @@ static enum drm_connector_status display_connector_detect(struct drm_bridge *bri
 	if (conn->bridge.ddc && drm_probe_ddc(conn->bridge.ddc))
 		return connector_status_connected;
 
+	if (conn->edid)
+		return connector_status_connected;
+
 	switch (conn->bridge.type) {
 	case DRM_MODE_CONNECTOR_DVIA:
 	case DRM_MODE_CONNECTOR_DVID:
@@ -130,7 +136,10 @@ static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bri
 {
 	struct display_connector *conn = to_display_connector(bridge);
 
-	return drm_edid_read_ddc(connector, conn->bridge.ddc);
+	if (conn->bridge.ddc)
+		return drm_edid_read_ddc(connector, conn->bridge.ddc);
+	else
+		return drm_edid_dup(conn->edid);
 }
 
 /*
@@ -376,6 +385,24 @@ static int display_connector_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Retrieve the hardcoded EDID for VGA connectors. */
+	if (type == DRM_MODE_CONNECTOR_VGA) {
+		const void *edid;
+		int size;
+
+		edid = of_get_property(pdev->dev.of_node, "edid", &size);
+		if (edid) {
+			if (conn->bridge.ddc)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "DDC and EDID are mutually exclusive\n");
+
+			conn->edid = drm_edid_alloc(edid, size);
+			if (!conn->edid)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "failed to parse EDID\n");
+		}
+	}
+
 	/* Get the DP PWR for DP connector. */
 	if (type == DRM_MODE_CONNECTOR_DisplayPort) {
 		int ret;
@@ -412,7 +439,7 @@ static int display_connector_probe(struct platform_device *pdev)
 
 	conn->bridge.of_node = pdev->dev.of_node;
 
-	if (conn->bridge.ddc)
+	if (conn->bridge.ddc || conn->edid)
 		conn->bridge.ops |= DRM_BRIDGE_OP_EDID
 				 |  DRM_BRIDGE_OP_DETECT;
 	/* Detecting the monitor requires reading DPCD */
-- 
Regards,

Laurent Pinchart

