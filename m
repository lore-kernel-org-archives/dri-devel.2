Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F9210ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F37110ECE4;
	Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="G/hbaY5V";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3401410E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:31 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 349B71E31;
 Fri, 27 Mar 2026 11:21:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606871;
 bh=eaeDuhTwVtvOUYbWOU6Pi8XJP6K+PPcBl3PTwjkGBnM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G/hbaY5VUiOWhtpB0qCz0Kwh7M3oL3se9SeJ0fh+/cSAgl6FzQY5T3BeMua54Gyl1
 2yx0sPZRY/dJ6ehXLl/9D833jiXOesH0rMngTmhcGFowFvomRsU9UaR2CjGFpsmaXx
 w4wbM6rBjpRRE4eFdAUgX0pD2rdA6HSaBwgDt330=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:55 +0200
Subject: [PATCH v2 07/12] drm/bridge: tc358762: Update comment about the
 number of lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-7-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eaeDuhTwVtvOUYbWOU6Pi8XJP6K+PPcBl3PTwjkGBnM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpc06X2gdz9/il55MrCCRPBxBbZ+p9fQSZqP
 5RqZ3j4CuWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaXAAKCRD6PaqMvJYe
 9b7iEACbL2OHaGmQIj/peIL2x07AktnKO8Obzf7Q4y/F1ds3ofrzreYbaSBSrOFHl7TYik2/WDS
 1GRLfKsckKrKOs1fhDgNPkP84/4x5FbMqPOrsMZz9SyQK4+Ac3HobldG5ctOld/AfJoLbY1CREA
 o/r94jYP5n+NhnjeOm0qbJa4PJnvwH208kEwfHR0oLYTS31niYFC492g256gAX8QGmMyg1cb7bF
 PaW/XXdPuBTcssVHirP8MSD/7uSehCI8zBUoUq84gqGOg+XrExjlah8aX0fhMLDNLoeW0jhAPf2
 75JBBaoa6zHKQR8daQWOV7kXgdXZ2Wzbrsv2CO/ipnFJ2BeYZNvUT6YbP0JuJOjUAcvLajQ9k3r
 KLJpuF+poIbL+jF1EvspN0Zu56XFHQpqYH3wF7H5gT/8VJOfMEOsrnaD9L09MPCj5e4/RtXbfKH
 XfCPjzYE2IOuGozDPAS9aBOssmrh4qgY/yr51Y8ceVQBGgIDkHSF7Pzv2uGLczeUdo2A7V3gSof
 BrruEE6nhY3Ypw9LrxbVn6t79QsbPqrJpu5GVfOCE6TBIGwdRd7bqdBgXyjKUSfrc8ARJ25zDov
 pCumLfE2StVwuEh+kR9pQjoq+VXOYeyj2GyqizDmESZ3gM+iowRnI4Fo0Jq8AtMf5K2HF/tQrwR
 lQUMam5cfliL5Yw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Update comment about the number of lanes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index cc1c5ff42cbd..9fb921b3fa0d 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -305,7 +305,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->dev = dev;
 	ctx->pre_enabled = false;
 
-	/* TODO: Find out how to get dual-lane mode working */
+	/*
+	 * When using DSI clk for pixel clock (only mode supported in the driver),
+	 * the pclk is derived directly from the DSI byteclk via simple divider,
+	 * which is either 2 or 3.
+	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
+	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
+	 * of 1.5.
+	 */
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |

-- 
2.43.0

