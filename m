Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02499CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B57710E1DB;
	Mon, 15 Jun 2026 06:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AKDHoq6O";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7395910E1DB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:28:54 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD5411817;
 Mon, 15 Jun 2026 08:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781504901;
 bh=O0cSt0B8VYohkq/tFixkIxCsP6ZQUeJK4m3N0yZ0pgk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AKDHoq6OFcq7JkzIUavyWFcX1H8y9Ankr2NZHUjsWP5MaBvKIHfxcUnPClZhny+TP
 W5KiuNv6x8QRvAw1h33prpBzQ8Eg+7PWnI+Q2vcmO+TsVmlk6CjmYdXwElYtzC/lOi
 Qe81cd6hwh3EZyN2X7FqrU7n2Iwe35AWDKd3aS74=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 15 Jun 2026 09:28:09 +0300
Subject: [PATCH v4 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-rcar-du-dsc-v4-4-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=O0cSt0B8VYohkq/tFixkIxCsP6ZQUeJK4m3N0yZ0pgk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqL5uc/vWkMAF5M863C9QDT0F0/PlIYLM0BAc9Z
 DPBzufDht6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCai+bnAAKCRD6PaqMvJYe
 9d+ZD/0YLZ13uEiwhZGXqvCIc8xoe8OovZMxBJi52aSP1M2t+gQ/hJR3UREvUUseyEdXFtmjEfx
 XtxxRzDM7aqvC+YonYC1AMUJzoQF2vejJWrbU3kGqea71+F1IUL5B4Mwuab+p75f2LSackdUPWV
 qnEaGxFKOW0dywG9TKQ3J9jvjQxHp4MV0pNgJl1Twejaq8w1DUFWkaEkLMpGk8FV+Z5FQeaq0mt
 GG/NF/jP5TVmwEoENzwnCS8A70q/gW4W+YldroQSyeo3OjuZGkb5macxBJeKLsJf8S5qq5zs67B
 1z8iZaIN4CyA+WHUs8zzwP0iBACjcp+JrB8ya6xn/7Wqsrw/L4HhlSGCljwjdA03+FDq43aaQYq
 Rfuzi1G3eSu6XD1xSiQzMPy/YpVIBU9STCozcrFYRXLgriLZha+cIco/Ku0KuwHDZ82l+BjjakX
 mIIMp2LLcrU5pzZdLOWxc6e7QwiV+vX8a7MTQF9tVHDlOlKxg0iKz8AcR9zvef8PmKkuJoUwCAY
 MLajh4GZgR1xP6o28klxmNxDp5mO/ODmlUyMv4APi+P/vzxz1kP/2poo9y7q9x9t3UscULJbIB5
 I4MFNzE+nXoH1CrGeWYPRcSF/pJiI9w0lcMRiXKok/+aUxUFQg73Sp0JcpWp3ZxzLVhlP8tvm6h
 ktUspCw/j/7lEjg==
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

To solve this problem, add checks to rcar_du_crtc_atomic_enable() and
rcar_du_crtc_atomic_disable() to detect the DSC via the bridge type, and
skip the DCS bridge when needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 18 ++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
index 6c07c406f725..f14fd89f9104 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -754,6 +754,15 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
 		struct drm_bridge *bridge = rcdu->dsi[rcrtc->index];
 
+		/*
+		 * When we have a DSC block between the DU and the DSI,
+		 * the "bridge" points to the DSC. Detect the DSC by looking
+		 * at the bridge type, and skip the DSC if the bridge is not
+		 * the DSI bridge.
+		 */
+		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
+			bridge = bridge->next_bridge;
+
 		rcar_mipi_dsi_pclk_enable(bridge, state);
 	}
 
@@ -796,6 +805,15 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
 	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
 		struct drm_bridge *bridge = rcdu->dsi[rcrtc->index];
 
+		/*
+		 * When we have a DSC block between the DU and the DSI,
+		 * the "bridge" points to the DSC. Detect the DSC by looking
+		 * at the bridge type, and skip the DSC if the bridge is not
+		 * the DSI bridge.
+		 */
+		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
+			bridge = bridge->next_bridge;
+
 		/*
 		 * Disable the DSI clock output, see
 		 * rcar_du_crtc_atomic_enable().
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

