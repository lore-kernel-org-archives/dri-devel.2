Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD541CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A10E10E411;
	Mon, 15 Jun 2026 13:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kHDjkhBR";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E3410E3F7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 13:12:34 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94B9A1E1B;
 Mon, 15 Jun 2026 15:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781529120;
 bh=5ctjG7NGK6UPrJitqiaBGctFX5TJpTY/5yZ0RISE+JY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kHDjkhBRDqtzg2lkXhTvQYMjGTsVOe/OxooCxIYSXxuXUOL/7ZnEooYvmJDKpHDYt
 X8g46yiZkN7z2hdL39scrXpDquhE7KSZg4JmYo0sKL3pcprr0jxIl1v2PFug+V2NAd
 VlKC5qa2Jo9uBRGfOpbwhcZsmsVTAz7gZVC7Hbus=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 15 Jun 2026 16:11:57 +0300
Subject: [PATCH v5 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-rcar-du-dsc-v5-4-aed1a28610e4@ideasonboard.com>
References: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=5ctjG7NGK6UPrJitqiaBGctFX5TJpTY/5yZ0RISE+JY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqL/o3tQ/9aXDqXtaD+SMx/77W38ZbjPcrQ2nPL
 o6cQFU4vV2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCai/6NwAKCRD6PaqMvJYe
 9UmlEACrUo7pcZd85rmn/izjcVIEgGgKFikKupX6Xd343uFge2hH0noKV/6VturknzCeceO2YRQ
 cZJ6/zkad2nWejpNdjI2DN6fa8JFr8FbkAHikV4iKQXLQbnnpnxMGT10ZHmpKFcfpXXq3di3gbs
 IT901Xrt87oMQG5mEPXkPrzAfKsytf9mZnaNiJjY3HsoRS3fb6YvHUyPYdf9WAqy8W8S5O3qbXS
 RhPBcPwV9TkraZN/0g8am8HRFnF8kfU2P7J02BOSM9QGRWUWy9aY72PsNDpIeW2YixCDTs7vSsi
 IUMeNAGq4sOF9WTMJy3Jlbaeynu/cPaZcZd8kCNd3SoecSwhdB3ftOT0PKjAfPZD2lrn+y35sJN
 I5mMcnC/S27Qm6CnjbV5zSlajOrDrCdS733buu35/wZ6A/TBixOVJjeGE3DNBu8JkyO5dCGpn1M
 /bRFh6e1haGO+KjVXugXzbI3UD4bcefxPj1UGcuUeyGNZw9rD98H0w6Mc8UtZ1VfPxe4jyhcdEB
 XSxtuFwdHKNsY3OiMr2XfSN37jAXplsraaU+twt/3unkk8j9eSxbKg+0KMKSxMZsyy+SFWAQyZn
 iadzdxCj2Od3IYezHyusZALQRJDNMeXWEIdwzBRepEqohimWKw5X+7DyIUP9e9uFFHqVT9U+qhA
 h+NhtaCddLFsd8g==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
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

Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
crtc, when enabling the crtc.

With DSC (added in upcoming patch) in the pipeline, between the DU and
the DSI, the above call path is broken as the crtc tries to call
rcar_mipi_dsi_pclk_enable() on the DSC.

To solve this problem, make sure we store the DSI bridge to the
rcdu->dsi[] array, instead of the first bridge in the DSI pipeline
(which can be DCS), by checking the bridge's bridge->type.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 18 ++++++++++++++++--
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
index db2088529b48..ac85838ab3b8 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -89,9 +89,23 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 				drm_bridge_get(bridge);
 
 		if (output == RCAR_DU_OUTPUT_DSI0 ||
-		    output == RCAR_DU_OUTPUT_DSI1)
+		    output == RCAR_DU_OUTPUT_DSI1) {
+			struct drm_bridge *dsi_bridge;
+
+			/*
+			 * When we have a DSC block between the DU and the DSI,
+			 * the "bridge" points to the DSC. Detect the DSC by looking
+			 * at the bridge type, and skip the DSC if the bridge is not
+			 * the DSI bridge.
+			 */
+
+			dsi_bridge = bridge->type == DRM_MODE_CONNECTOR_DSI ?
+						     bridge :
+						     bridge->next_bridge;
+
 			rcdu->dsi[output - RCAR_DU_OUTPUT_DSI0] =
-				drm_bridge_get(bridge);
+				drm_bridge_get(dsi_bridge);
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index aaafee1c060b..f429f03a380c 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -957,6 +957,7 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 
 	/* Initialize the DRM bridge. */
 	dsi->bridge.of_node = dsi->dev->of_node;
+	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
 	drm_bridge_add(&dsi->bridge);
 
 	return 0;

-- 
2.43.0

