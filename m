Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7872CCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25E610F4BE;
	Mon,  8 Jun 2026 14:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="POEDmPT4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2328F10F4BE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B6D3435BD;
 Mon,  8 Jun 2026 14:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABCC1F00898;
 Mon,  8 Jun 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929396;
 bh=caI+80TmQdjy4i5pUYZLwMtv4cPa77qi0GN0l8eqtIQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=POEDmPT4VE6gh2Zc/ts9UgyEy0CROiEjkAgfnBPNqBpgsfu/uCqhzyBKYyL6DCxie
 V1/rfP7FpMXP9/4BGqKPvZ/6mArWBrWtKDoveT4e31c8tEdVJNwG2jCcwyYxrwYgg7
 QtNitM0KsaJxmWyHkjy9EnoEns+glvsNRsRJ00dpgd30jdleGOKK16ohyCyewW+Zy6
 2JJPl/NpF1i2WmpAkT60UO4KjX2FFbDW80TKWI3OiFvCabVb1bQiuYuhMerpI3uTuo
 dUMImsO7PFqFHqsRlkg/nrQ2i7FVHIqyJngx/9rSsK0U3Pe2WpdTGB72nKfmcxMl74
 fNKaUIfyXo+Xg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:46 +0200
Subject: [PATCH v2 04/78] drm/atomic-state-helper: Reorder
 __drm_atomic_helper_bridge_state_init() arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-4-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3949; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Iq5liTxTw7ITQqXnJAVRablmYpTj6Ju5NGvdI6nT900=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql922b/jR1fBfP7Hd9nTbjw3WgSxcBxvK+814OqZuO
 JfddVa6YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzktAdjwz4FtnsbHzxW5AvO
 ZvH77TbF/85M34+hblwtV3sshLx5VXt+zp54Sve9oXiYUMP+bcwdjNUsn6VsFZf859H79u6zkfl
 Jxky25L6J7FbnEhKPXgg5fNh/rtbRyM0FeacvKBZ5qi5TWA0A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The convention for state init helpers is to pass the state pointer
as the first argument and the object pointer second.

__drm_atomic_helper_bridge_state_init() has them in the opposite
order. Swap the arguments to follow the convention, and update the
cdns-mhdp8546 caller.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
 include/drm/drm_atomic_state_helper.h               | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 2e74dc33e085..b9574289c247 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
 
 	return &cdns_mhdp_state->base;
 }
 
 static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 73e76426da1f..8f04eae7a754 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -886,19 +886,19 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
 
 /**
  * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
- * @bridge: the bridge this state refers to
  * @state: bridge state to initialize
+ * @bridge: the bridge this state refers to
  *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
-void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
-				      struct drm_bridge_state *state)
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
+					   struct drm_bridge *bridge)
 {
 	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
@@ -920,9 +920,9 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
 
 	bridge_state = kzalloc_obj(*bridge_state);
 	if (!bridge_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_state_init(bridge, bridge_state);
+	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
 	return bridge_state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 6a715d8e1f4a..cbc760598b9e 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
 						struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
-void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
-				      struct drm_bridge_state *state);
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
+					   struct drm_bridge *bridge);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

