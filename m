Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF55CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD5E10F4BD;
	Mon,  8 Jun 2026 14:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xmlhee0j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F89A10F4BD
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8772F601D8;
 Mon,  8 Jun 2026 14:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91411F00893;
 Mon,  8 Jun 2026 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929394;
 bh=D0Ye/uir+4tZ/d2TTeVmQs7rZz0C/Qm9bny+Hkyk/z8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Xmlhee0jyz3AWWlVRHwG98LIk0ZF8tgb6B43QRkJRHyH/0WZgszsO9SYsI7STXpbw
 PkEW2g8W5+9poTyJbudwqymKg0pt9jctrydZ+dzRzxRE1RYWziku9qZOwZIR3kBJHp
 EoFHN0bmOnvelwULp+7eIruoEWerlCoNjfvC1aQJCL3TYtUoNQb30rbEhueh0VVBav
 yGKFNAIQ3F2K09Y624XtRlt/D+unXndqAe1T6yVPgYDouBqI6p65z6nXiVfeYheKD/
 M7wyMxLi6rCgQ2YEsvUX8LA8G24HJBFoCuwrKSW61bBl+1mZsKNbA7lkJ3R7DlgW4n
 R60YuvfvC1euw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:45 +0200
Subject: [PATCH v2 03/78] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-3-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478; i=mripard@kernel.org;
 h=from:subject:message-id; bh=z+FuAY38spbKNO9MurTWx5XxO3IV5vOZMpbHOvB/h40=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql93KVr4vL1vCJ1NbmuI+lUM6/dLGCVK/Pm73W2Gd9
 2zKtrbejqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR68WMtRLcbxbMbWIL5uhQ
 PJYiVNI/4bjzqhkKX4PqZ8RnGaovelc6QU2V26mytWzStqQdHdv5GRvu2gt47/bbcrdtZWSi9sH
 lWZbm356nRc2o87TcVuOz/wsv8+kX3KKu3pd+Hor1OSI/2wEA
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

__drm_atomic_helper_bridge_reset() is used to initialize a
newly allocated drm_bridge_state, and is being typically called by the
drm_bridge_funcs.atomic_reset implementation.

Since we want to consolidate DRM objects state allocation around the
atomic_create_state callback that will only allocate and initialize a
new drm_bridge_state instance, we will need to call
__drm_atomic_helper_bridge_reset() from both the atomic_reset and
atomic_create_state hooks.

To avoid any confusion, we can thus rename
__drm_atomic_helper_bridge_reset() to
__drm_atomic_helper_bridge_state_init().

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c           | 8 ++++----
 include/drm/drm_atomic_state_helper.h               | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 46779b49545b..2e74dc33e085 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1927,11 +1927,11 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *bridge)
 
 	cdns_mhdp_state = kzalloc_obj(*cdns_mhdp_state);
 	if (!cdns_mhdp_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
+	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);
 
 	return &cdns_mhdp_state->base;
 }
 
 static u32 *cdns_mhdp_get_input_bus_fmts(struct drm_bridge *bridge,
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 07686e94aae0..73e76426da1f 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -884,27 +884,27 @@ void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
 
 /**
- * __drm_atomic_helper_bridge_reset() - Initialize a bridge state to its
+ * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
  * @bridge: the bridge this state refers to
  * @state: bridge state to initialize
  *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
-void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state)
 {
 	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
-EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
+EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 
 /**
  * drm_atomic_helper_bridge_reset() - Allocate and initialize a bridge state
  *				      to its default
  * @bridge: the bridge this state refers to
@@ -920,9 +920,9 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
 
 	bridge_state = kzalloc_obj(*bridge_state);
 	if (!bridge_state)
 		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
+	__drm_atomic_helper_bridge_state_init(bridge, bridge_state);
 	return bridge_state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index f4b6d8833bc2..6a715d8e1f4a 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -100,9 +100,9 @@ void __drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge,
 						struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_duplicate_state(struct drm_bridge *bridge);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state);
-void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
+void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
 				      struct drm_bridge_state *state);
 struct drm_bridge_state *
 drm_atomic_helper_bridge_reset(struct drm_bridge *bridge);

-- 
2.54.0

