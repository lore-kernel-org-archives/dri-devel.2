Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2931FC79F9F
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448F110E72F;
	Mon,  7 Sep 2026 09:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EMV5EcYe";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120A010E726
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:30:24 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20CBEE4E;
 Mon,  7 Sep 2026 11:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788773328;
 bh=FQ3q2y/5ev2CFm/FTXyadCkmNXPP67KDXrr1utQU+oo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EMV5EcYey64WIs0HoYqMZFpPapt/IesyUIFoXPBi6kTz9sOzj6mbzP8MbCcmBU/0w
 KvsJLy9pg8N/HTsdwlYWkEzAVExw2YxIceaMr5bvcQGNFuVXOdWPj09/pMCr60FVof
 dMg94aP4u77x0NprRwsIwVeKH6OFfbYXh3GPPydk=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 07 Sep 2026 12:29:42 +0300
Subject: [PATCH v6 3/6] drm/rcar-du: dsi: Support DSC in the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-rcar-du-dsc-v6-3-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
In-Reply-To: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=FQ3q2y/5ev2CFm/FTXyadCkmNXPP67KDXrr1utQU+oo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnoQn6H06LK43PCj2eotAVh1yQbcawjxAKMcih
 An5H2thP5yJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6EJwAKCRD6PaqMvJYe
 9fCpD/9efAxlpGf5fuIrbZnl/1gFs2xxmA37VpfRlHDNW5WHcMLHGFTjrqUlAv3dZm6CXuj82fY
 7VxtL3b/6bxHVji/w8DDeyU+DFD3/Ke6sfL3rkAqcDQUyBPBjEpGXrk+d1cRmeBGqdsTxVtOa0H
 YuSs6uKPC9mpPQyhYIXcWEB0DHJ13TV4wegB6c+pMFmXcJzGFltdn6r2AYEJ9Iy95BBOyOgCrF1
 BhVgEQWolLg2BjxCTcfvdphHIplrDBm9xJQuLVwNuyNmAZqjpzjRZRb+J2/7z/FKB+yTnNqv96r
 kYg8CaHz/R8xjlMw/A2j/tm7kH0ZO8BcoshzdxCvZ2ihPwlONyPA4z1jNdvAQgoOeKDfRCNSdT7
 oSCnnAUnVnnddACpYAivDN0Ei9OxvkbEPx5s4Vk84xIjUIhbOhNY461z7GTEDUZstGnd501O0hL
 g8hhUn2kUDqxswf/usQrmRY02YE3pwJcyssPE2tYlGEBFN9ZRmFc5Gnyy/H7MRf/c0Gh7tAF5Oc
 iZ0d6IifbYv5CXE9KtVjXk1reCBLQ/jQKA6oovZDLUxwqofmfDaV9g0wCUhcLvpnKNuBNj1KdVm
 OEgllVu9gA5vSjpG8upvjhf4P39nXUr3h+Ugl54S40ZeeABfOaDV9xMWMs8cBR0op7yblon6nN/
 +MB8MQD5n6cDLOA==
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

With DSC in the pipeline, between the DU and the DSI, the above call
path is broken as the crtc tries to call rcar_mipi_dsi_pclk_enable() on
the DSC.

To solve this problem, make sure we store the DSI bridge to the
rcdu->dsi[] array, instead of the first bridge in the DSI pipeline
(which can be DSC), by checking the bridge's bridge->type.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 17 +++++++++++++++--
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c   |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
index d8e7e9877ba8..3f98eae9b6ac 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -90,9 +90,22 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
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
+				     bridge : bridge->next_bridge;
+
 			rcdu->dsi[output - RCAR_DU_OUTPUT_DSI0] =
-				drm_bridge_get(bridge);
+				drm_bridge_get(dsi_bridge);
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 6e46d6d99f3c..af4edb207486 100644
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

