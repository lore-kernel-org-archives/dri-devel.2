Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12CFCD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175DE10E33E;
	Sat, 30 May 2026 14:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+7P/vrD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C57010E33E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F091B445AB;
 Sat, 30 May 2026 13:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5A11F00898;
 Sat, 30 May 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149599;
 bh=OENn7iWTVNZX+vJThd6jWisn+zZ0epNL+7LtxEf/0xU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=F+7P/vrDRgUBLner5njGaYmjlm6+x4pRmOFTzW9Kouf+kdNoo1Dws5458y1rC03Yt
 Xkrv0yGVotT6HUKs2E4cFFKSQLZp/cwR3EpsgNatSZDDwZ/AUk2WJxSEYFmS/5vh6L
 mPseuoE1/EaiQFfJAXL6zB6wFZjH4/smdbPIKju8Ht0nW4gpbemnSeq6jrsgzjrohP
 +QBqoNuIYqkDw1mMzwYtaErTY/gb1F3Rh6tUHyd6DKtd5xqESnj5H8fF5ki+YxsHsD
 Lk0T+1QP4Qv0qgf4jt19ssY+oFY3v4v2Xq8VQ5FOw+PBmhLmpvCqAixgDPm1gP5N/g
 kuTARR6LLFduA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:07 +0200
Subject: [PATCH 02/76] drm/atomic-state-helper: Reorder
 __drm_atomic_helper_bridge_state_init() arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-2-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3803; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Uee6yQl+konK92ZTg3HaXBLtx467eh5V9tkQo+9DW2Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb832qf8uSPcIndHz5J10nG02t0vf5doriQlrThoWb
 ZQw2RrRMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyPZ6xYdVLkWMfQiZvEVdt
 e3knt+N9hlDaQb2TU7W/c8g2Xs5sn/9d+iXDydXfXne8Xiz0NUWVkbE+8+/V9FCzQ2Grj0pZbz6
 3719W7abs+/tfCDJ/XD33nOb/Y8nyG4Suyv7c0n/u2PTr/3ynAgA=
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
 include/drm/drm_atomic_state_helper.h               | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 4e3015d10a97..063f073034c1 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
 		return NULL;
 
-	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_state_init(&cdns_mhdp_state->base, bridge);
 
 	return &cdns_mhdp_state->base;
 }
 
 static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index c38e514f336f..8f04eae7a754 100644
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
 
-	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
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

