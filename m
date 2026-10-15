Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E895CC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23144112300;
	Thu, 15 Oct 2026 11:16:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619A81122D9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:35 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3DC47157F;
 Thu, 15 Oct 2026 13:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062871;
 bh=fdg8eV/QDnydJFYV748UJ0GYkCe4BYsEnmoO5CBavJs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Iwj9r/vKQaUpVYf0Dn0y4+c7ISakMtRKiVCGq1gvuEU6/zHEHG7nhcN8nlq4IGE6C
 gvgKO3MOjXan0Z2kRGEBCndLnIbB+XhwqPnQnEzYs4KG8zxNfkUUKD+/DtCydnEABy
 rjVgrKqrz1eqG59/fGIG7eCEzOvEfLgAEi66WV3A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:58 +0300
Subject: [PATCH v5 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-7-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
In-Reply-To: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=fdg8eV/QDnydJFYV748UJ0GYkCe4BYsEnmoO5CBavJs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYHH7U8w/F7jAXbT6GDiP5ya/i+WqIi7wKf/
 B87Io+SeXuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BwAKCRD6PaqMvJYe
 9R2lEACfytEUffqHntXsShVoibCaBEit2fn+1RVczBtgke2Dy6o3NASTjvs9jbCHmGxkVd4y+Vl
 snMZ5qlIJKn1dY8GSpm3n6qEdphwveKzfKuz+l89rtjdCSOZcDbKOe2mMJ5EldIaUaE5+ThFAHP
 qnm8WTzCtDXj+kR21ZEsreWQTKDQTR5IpJ8FqdhaVE9AiKjZVbC2b4bIwJS8Q++Bom2BE0VRkul
 k0i/zM90536YqYAWQ9b4/c2KMZOnEtc4QTRY7Ic8EMLOpjJgfuHJJsmtovId/RnVspz40oWKYhG
 jVpRFpuqJ4sXpm3GnfdVLHfQgKLXJA2JaxfsTLsJucgLnL1WymhyAHylQVsF60QcxSYlJsC7P8b
 7IqIor+tvSCu7TauYe5vLjx9OkiuHFHyXMF7R+USgIyR7hmaP4hkWZDiNg5WvonVxB8JhbTYRa5
 lX+kbS5f2Bmwdqv4Wg7euTMlNuPk9F5UFULHT5KVXWQHSiJcnkPQ4RI9MURItFhVxVD/TtP8MMl
 MpHfIBVvmbbx15R734t1Xlu35fQ1UH4ExyYhbjyEk2UtQ4wI6qiZnojU233RePw0aIWaycTzy0B
 kuX+YKEZRJEbMaLwkqvyK5JxUOKgwrxML4+svNHHOUcZhVaDhNB1CUgJhF9hUgq8RKEBV8lKeGO
 GdMtxRhvZ3Ue+5A==
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
index 19f328b6e798..fd82274643db 100644
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

