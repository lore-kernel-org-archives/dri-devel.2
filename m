Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E1BC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F09510E6C9;
	Mon,  3 Aug 2026 14:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="SHb9iWuq";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2281410E6C9
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785768997; x=1786028197;
 bh=8q2edUY/F+R6eEwokl1w5l9rk95zvIg7QcBwF/3Dezw=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=SHb9iWuqU2MjmhvgQFxqubhoTBWeaBW73Bzm5hLzedq7fzNuAXrMGmXFOK7UE2bqi
 iAfJ8yZGPu1lZ9PwFd+fsR5BR+oQiPcRqFmPlZK2w+7NJfxQOpWw6xmT0ewBkVi9uH
 K2ZpN+0EQmcZ2ifp/PT1wLH1RVdizGdYfnc+XPHCqyVLp/O2+dB9gNdw9ZTKYG4Srj
 b7rK4CZnOUJhK5BodmawnPYZErJFu9L+Gk1AAS39LyP47/C7oBQ9londfZ74s3iZAG
 MKkPTwedXg4cGzVKgoUbjIibfswaNvfn55IYHrwC1YmkFoWe2Md0w/AUogvAyBXCYI
 wc8B0/5CE9A5Q==
X-Pm-Submission-Id: 4hDKWR29Bfz2Sd3H
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:56:19 +0200
Subject: [PATCH v2 1/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-nwl-dsi-fixes-v2-1-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
In-Reply-To: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785768991; l=2620;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=bElw+EC3BtkVujNhRAmFC3bBhwHEY6yVLOiO9cFKvzY=;
 b=tf10PB+CdHMCQittUe4/dypD0qXYyGWbETuSqWW3UIIV6Pf93oVO00lajlamdE7fC06Jmp/Bs
 p6IhUBmJ3ujAarryS04mLHPzJfs1fDz0Q2rugS5ImS74JU/a5LokM/7
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

When using DCSS with NWL, overriding the mode flags to enforce active high
sync is preventing the use of active low with downstream bridges, such as
ti-sn65dsi83, which will not see such mode flags set by the panel.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 3c9ae93c4f67..915e1bdc73c8 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -110,6 +110,8 @@ struct nwl_dsi {
 	int error;
 
 	struct nwl_dsi_transfer *xfer;
+
+	unsigned int endpoint;
 };
 
 static const struct regmap_config nwl_dsi_regmap_config = {
@@ -821,10 +823,13 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 
 	/* At least LCDIF + NWL needs active high sync */
-	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	if (dsi->endpoint == NWL_DSI_ENDPOINT_LCDIF) {
+		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
+		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	}
 
 	/*
 	 * Do a full modeset if crtc_state->active is changed to be true.
@@ -1088,13 +1093,12 @@ static int nwl_dsi_parse_dt(struct nwl_dsi *dsi)
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
@@ -1103,11 +1107,12 @@ static int nwl_dsi_select_input(struct nwl_dsi *dsi)
 				      "No valid input endpoint found\n");
 			return -EINVAL;
 		}
+		dsi->endpoint = NWL_DSI_ENDPOINT_DCSS;
 	}
 
 	DRM_DEV_INFO(dsi->dev, "Using %s as input source\n",
-		     (use_dcss) ? "DCSS" : "LCDIF");
-	ret = mux_control_try_select(dsi->mux, use_dcss);
+		     (dsi->endpoint == NWL_DSI_ENDPOINT_DCSS) ? "DCSS" : "LCDIF");
+	ret = mux_control_try_select(dsi->mux, dsi->endpoint == NWL_DSI_ENDPOINT_DCSS);
 	if (ret < 0)
 		DRM_DEV_ERROR(dsi->dev, "Failed to select input: %d\n", ret);
 

-- 
2.55.0

