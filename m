Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE0C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A065410E844;
	Mon, 31 Aug 2026 13:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="N34wkR1S";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AF510E83A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1788182882; x=1788442082;
 bh=dCIzJ7auFLsAAuxTb9FPaGJ0CJxz0+3pHeAEI1munHQ=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=N34wkR1S6ysVvrC1PZSiYeyCvlzweQUPwhARHLy2fsVDesUPBtr8FJ8qioRL4N6oX
 SxtVPQ1F0Hp7qljqtwFQPri5sortF2qsBUrSeGzKYgMaC9ywaWDQJyGkScCe2v8igO
 6Kf47xrPQN00OYIMan+ZXjhlnnls+O88hlEwTIXALmwgafx2E0eHq2pDM5aA5s5RYo
 8xZj2DNZUCf7S7iG2JGT/E4KzzHbqxL2n32cGdftH+FKY0s1XVFD/qx0di+T5AQtDW
 hSlX1NIW0i79mqj0FZnjfpyb9+tPKMndwqfPKGnXd+p+esd0vt80D3dPHIyRBgUjzs
 L4Vzc+dxlZfag==
X-Pm-Submission-Id: 4hYVDH1zmLz2Scht
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 15:27:43 +0200
Subject: [PATCH v4 1/4] drm/bridge: nwl-dsi: Cleanup endpoint mux control
 selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nwl-dsi-fixes-v4-1-6a2a1cb23910@geanix.com>
References: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
In-Reply-To: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788182874; l=2014;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Cm0XJSNXpJMzO5ie7uX5yADJaQR/hPQbPioD/AbZ2rs=;
 b=RGSYE/R38haixbJ8KT9D+ANay1cfgJXSJswzBtm/VZvOnZfYxvgmID3+XocY7QeO9hF/mUIRq
 cc+mUBmAsIgBE4eTsS9qpwmKtUQfoXAG1ASaH8TMqQ344Q9nh+PnjNl
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

Using the endpoint define values makes it more clear that the argument to
mux_control_try_select() must be valid state integers, and not something
that looks like a boolean.

The endpoint value is kept, as it will be used in a following patch that
changes behavior slightly based on which endpoint is selected.

Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 09992529f3d8..80e26a947ae6 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -110,6 +110,8 @@ struct nwl_dsi {
 	int error;
 
 	struct nwl_dsi_transfer *xfer;
+
+	unsigned int endpoint;
 };
 
 static const struct regmap_config nwl_dsi_regmap_config = {
@@ -1088,13 +1090,12 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
 static int nwl_dsi_select_input(struct nwl_dsi *dsi)
 {
 	struct device_node *remote;
-	u32 use_dcss = 1;
 	int ret;
 
 	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
 					  NWL_DSI_ENDPOINT_LCDIF);
 	if (remote) {
-		use_dcss = 0;
+		dsi->endpoint = NWL_DSI_ENDPOINT_LCDIF;
 	} else {
 		remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
 						  NWL_DSI_ENDPOINT_DCSS);
@@ -1103,11 +1104,12 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
 				      "No valid input endpoint found\n");
 			return -EINVAL;
 		}
+		dsi->endpoint = NWL_DSI_ENDPOINT_DCSS;
 	}
 
 	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
-		     (use_dcss) ? "DCSS" : "LCDIF");
-	ret = mux_control_try_select(dsi->mux, use_dcss);
+		     (dsi->endpoint == NWL_DSI_ENDPOINT_DCSS) ? "DCSS" : "LCDIF");
+	ret = mux_control_try_select(dsi->mux, dsi->endpoint);
 	if (ret < 0)
 		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
 

-- 
2.55.0

