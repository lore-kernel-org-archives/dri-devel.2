Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E04FF6E9B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6F110E692;
	Tue, 17 Mar 2026 23:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SUEny50W";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43C310E68A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 23:19:38 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4CA00DF3;
 Wed, 18 Mar 2026 00:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773789505;
 bh=X7rmBsT/VLu4cXnU/1jFT5MXtJ/cKZy9Of0fz7nPLBw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SUEny50Wyw5/zZdrkDoyfpzv3I7P7Tz0bWwxfeDJN4LsMtl/W56c3GR0sEFAABm0X
 zddo7SYB/JLHfdwi6blfonUrbutHPOoZDWF7+11nUgR86L8dOOOGWYEFh93gubKF3j
 vIy66h9mC9DnjZTFUbabMmH7W8cmLMcTzeED6x4M=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 4/4] drm: rcar-du: Don't leak device_link to CMM
Date: Wed, 18 Mar 2026 01:19:30 +0200
Message-ID: <20260317231930.595719-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
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

The DU driver creates device_link instances between the DU and CMMs, but
never deletes them. Fix it by introducing a rcar_du_cmm structure to
group the CMM device and device_link, and deleting the links at cleanup
time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.c    | 16 +++++-----
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h |  8 ++++-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c | 29 ++++++++++++-------
 4 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
index 28a5aa5a14d8..7c36c30a75b6 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -513,13 +513,13 @@ static void rcar_du_cmm_setup(struct drm_crtc *crtc)
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_cmm_config cmm_config = {};
 
-	if (!rcrtc->cmm)
+	if (!rcrtc->cmm->dev)
 		return;
 
 	if (drm_lut)
 		cmm_config.lut.table = (struct drm_color_lut *)drm_lut->data;
 
-	rcar_cmm_setup(rcrtc->cmm, &cmm_config);
+	rcar_cmm_setup(rcrtc->cmm->dev, &cmm_config);
 }
 
 /* -----------------------------------------------------------------------------
@@ -667,8 +667,8 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
 		rcar_du_vsp_disable(rcrtc);
 
-	if (rcrtc->cmm)
-		rcar_cmm_disable(rcrtc->cmm);
+	if (rcrtc->cmm->dev)
+		rcar_cmm_disable(rcrtc->cmm->dev);
 
 	/*
 	 * Select switch sync mode. This stops display operation and configures
@@ -726,8 +726,8 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
 	struct rcar_du_device *rcdu = rcrtc->dev;
 
-	if (rcrtc->cmm)
-		rcar_cmm_enable(rcrtc->cmm);
+	if (rcrtc->cmm->dev)
+		rcar_cmm_enable(rcrtc->cmm->dev);
 	rcar_du_crtc_get(rcrtc);
 
 	/*
@@ -1300,8 +1300,8 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 		return ret;
 
 	/* CMM might be disabled for this CRTC. */
-	if (rcdu->cmms[swindex]) {
-		rcrtc->cmm = rcdu->cmms[swindex];
+	if (rcdu->cmms[swindex].dev) {
+		rcrtc->cmm = &rcdu->cmms[swindex];
 		rgrp->cmms_mask |= BIT(hwindex % 2);
 
 		drm_mode_crtc_set_gamma_size(crtc, CM2_LUT_SIZE);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
index 07a40b305be8..8857926e109a 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
@@ -19,6 +19,7 @@
 
 #include <media/vsp1.h>
 
+struct rcar_du_cmm;
 struct rcar_du_group;
 struct rcar_du_vsp;
 
@@ -65,7 +66,7 @@ struct rcar_du_crtc {
 	unsigned int vblank_count;
 
 	struct rcar_du_group *group;
-	struct device *cmm;
+	struct rcar_du_cmm *cmm;
 	struct rcar_du_vsp *vsp;
 	unsigned int vsp_pipe;
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
index 9e160dede4e6..de9c6617a2d4 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
@@ -22,6 +22,7 @@
 
 struct clk;
 struct device;
+struct device_link;
 struct drm_bridge;
 struct drm_property;
 struct rcar_du_device;
@@ -88,6 +89,11 @@ struct rcar_du_device_info {
 	unsigned int lvds_clk_mask;
 };
 
+struct rcar_du_cmm {
+	struct device *dev;
+	struct device_link *link;
+};
+
 #define RCAR_DU_MAX_CRTCS		4
 #define RCAR_DU_MAX_GROUPS		DIV_ROUND_UP(RCAR_DU_MAX_CRTCS, 2)
 #define RCAR_DU_MAX_VSPS		4
@@ -106,7 +112,7 @@ struct rcar_du_device {
 	unsigned int num_crtcs;
 
 	struct rcar_du_group groups[RCAR_DU_MAX_GROUPS];
-	struct device *cmms[RCAR_DU_MAX_CRTCS];
+	struct rcar_du_cmm cmms[RCAR_DU_MAX_CRTCS];
 	struct rcar_du_vsp vsps[RCAR_DU_MAX_VSPS];
 	struct drm_bridge *lvds[RCAR_DU_MAX_LVDS];
 	struct drm_bridge *dsi[RCAR_DU_MAX_DSI];
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
index 9a53b5a86c82..b2d0e4651e35 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
@@ -769,23 +769,23 @@ static int rcar_du_cmm_init(struct rcar_du_device *rcdu)
 	}
 
 	for (i = 0; i < cells; ++i) {
-		struct device_node *cmm __free(device_node) = NULL;
+		struct device_node *cmm_node __free(device_node) = NULL;
+		struct rcar_du_cmm *cmm = &rcdu->cmms[i];
 		struct platform_device *pdev;
-		struct device_link *link;
 		int ret;
 
-		cmm = of_parse_phandle(np, "renesas,cmms", i);
-		if (!cmm) {
+		cmm_node = of_parse_phandle(np, "renesas,cmms", i);
+		if (!cmm_node) {
 			dev_err(rcdu->dev,
 				"Failed to parse 'renesas,cmms' property\n");
 			return -EINVAL;
 		}
 
-		if (!of_device_is_available(cmm))
+		if (!of_device_is_available(cmm_node))
 			/* It's fine to have a phandle to a non-enabled CMM. */
 			continue;
 
-		pdev = of_find_device_by_node(cmm);
+		pdev = of_find_device_by_node(cmm_node);
 		if (!pdev) {
 			dev_err(rcdu->dev, "No device found for CMM%u\n", i);
 			return -EINVAL;
@@ -801,14 +801,15 @@ static int rcar_du_cmm_init(struct rcar_du_device *rcdu)
 			return ret == -ENODEV ? 0 : ret;
 		}
 
-		rcdu->cmms[i] = &pdev->dev;
+		cmm->dev = &pdev->dev;
 
 		/*
 		 * Enforce suspend/resume ordering by making the CMM a provider
 		 * of the DU: CMM is suspended after and resumed before the DU.
 		 */
-		link = device_link_add(rcdu->dev, &pdev->dev, DL_FLAG_STATELESS);
-		if (!link) {
+		cmm->link = device_link_add(rcdu->dev, cmm->dev,
+					    DL_FLAG_STATELESS);
+		if (!cmm->link) {
 			dev_err(rcdu->dev,
 				"Failed to create device link to CMM%u\n", i);
 			return -EINVAL;
@@ -823,8 +824,14 @@ static void rcar_du_modeset_cleanup(struct drm_device *dev, void *res)
 	struct rcar_du_device *rcdu = to_rcar_du_device(dev);
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(rcdu->cmms); ++i)
-		put_device(rcdu->cmms[i]);
+	for (i = 0; i < ARRAY_SIZE(rcdu->cmms); ++i) {
+		struct rcar_du_cmm *cmm = &rcdu->cmms[i];
+
+		if (cmm->link)
+			device_link_del(cmm->link);
+
+		put_device(cmm->dev);
+	}
 }
 
 int rcar_du_modeset_init(struct rcar_du_device *rcdu)
-- 
Regards,

Laurent Pinchart

