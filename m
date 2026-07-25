Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82859C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 03:00:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C8B10E59A;
	Sat, 25 Jul 2026 03:00:17 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EC3210E59A
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:00:17 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wnScS-0000000034X-1DyX; Sat, 25 Jul 2026 03:00:08 +0000
Date: Sat, 25 Jul 2026 04:00:05 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
 Pin-yen Lin <treapking@chromium.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v6 09/13] drm/bridge: it6505: hold endpoint OF node reference
 while parsing it
Message-ID: <d5abbb920321da662a735c880378513ff825fe39.1784947240.git.daniel@makrotopia.org>
References: <cover.1784947240.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784947240.git.daniel@makrotopia.org>
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

it6505_parse_dt() drops the reference to each endpoint node right
after looking it up and then keeps reading its properties, racing
with the node being freed under CONFIG_OF_DYNAMIC. Put the node only
once parsing is done.

Fixes: 380d920b582d ("drm/bridge: add it6505 driver to read data-lanes and link-frequencies from dt")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: no changes

v5: new patch

 drivers/gpu/drm/bridge/ite-it6505.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f4ee5c81d3b8..0da8b40dd88a 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3366,7 +3366,6 @@ static void it6505_parse_dt(struct it6505 *it6505)
 	}
 
 	ep = of_graph_get_endpoint_by_regs(np, 1, 0);
-	of_node_put(ep);
 
 	if (ep) {
 		len = it6505_get_data_lanes_count(ep, 1, 4);
@@ -3379,13 +3378,13 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			*max_lane_count = MAX_LANE_COUNT;
 			dev_err(dev, "error data-lanes, use default");
 		}
+		of_node_put(ep);
 	} else {
 		*max_lane_count = MAX_LANE_COUNT;
 		dev_err(dev, "error endpoint, use default");
 	}
 
 	ep = of_graph_get_endpoint_by_regs(np, 0, 0);
-	of_node_put(ep);
 
 	if (ep) {
 		len = of_property_read_variable_u64_array(ep,
@@ -3405,6 +3404,7 @@ static void it6505_parse_dt(struct it6505 *it6505)
 			dev_err(dev, "error link frequencies, use default");
 			*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
 		}
+		of_node_put(ep);
 	} else {
 		dev_err(dev, "error endpoint, use default");
 		*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
-- 
2.55.0
