Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BF3CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7153910F4BF;
	Mon,  8 Jun 2026 14:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lyrRKgm0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C6810F4BF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71ED94345F;
 Mon,  8 Jun 2026 14:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09B11F00898;
 Mon,  8 Jun 2026 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929402;
 bh=ze30V438yLgiWi4bTpDQwPEuSQxjr9tx4vLEQamhqeY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lyrRKgm0GU2sDC9wewVgRUxWcVQy/+AOPEQdVZKipFvMNSBRZRl/E7pGBuGQQk7RP
 +caXiDDnTkbF1YNzBC9jlN4/o6VboZHW57fKEgNbapJkxs9NutnYS1tlTcaLlDuxWV
 dQLTQ60R35S6KSX62CAupAFm38vDd/mOIDHzt8mP2+u4rmErqlZWgkEzZvwXKgZA6D
 0F/3gXWWmzJdcTlgZfHWl1hwClJTujYP83cltqIyIkY2ArRwUgrbS6tqa5dgOY81C2
 3Si4RcDYUlP7xuB3wY82q3PFH8mfpcQmbAxTNZCwSvwyAdrORvFxONz6GLomI87zUA
 yZsnUmjTT1tVg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:48 +0200
Subject: [PATCH v2 06/78] drm/bridge: Add new atomic_create_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-6-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3818; i=mripard@kernel.org;
 h=from:subject:message-id; bh=YRPfkN0X4ljTIambFrCG0+juzaxJGfdPOsKu0er4qSw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql92/l/ZevR9z9Weu/ySlQ6/0VEKK4uJeauo5fnc5r
 vX/8Je5HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi/6Yz1unMYkvlvW33mnmZ
 gHaqze3aHuGnqyRCRXN/TctZdHCGSO+qik3/lXfM8ezvkntzL1BXirG+6kn//5ksn47mT5eoEwj
 fbS7OnWHx9UN5k+Q+t67N2/4dzPxl+6Dt/rXKo8vq+G4vn7cGAA==
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

Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
to drm_private_obj") introduced a new pattern for allocating drm object
states: atomic_create_state, a dedicated hook that allocates and
initializes a pristine state without any side effect.

The bridge atomic_reset callback is already fallible and in practice
only allocates and initializes state without touching hardware.
However, the reset name does not make this contract clear: callers
and implementers cannot tell from the name alone whether the hardware
will be affected or when the hook is safe to call.

Add an atomic_create_state callback to drm_bridge_funcs to make the
contract explicit: allocate a pristine state, initialize it, no side
effects. The core calls it when available, falling back to
atomic_reset otherwise.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c |  8 ++++++--
 include/drm/drm_bridge.h     | 19 ++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 9a185032a3bd..b4543a50bc6f 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -500,11 +500,14 @@ static struct drm_private_state *
 drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
 {
 	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
 	struct drm_bridge_state *state;
 
-	state = bridge->funcs->atomic_reset(bridge);
+	if (bridge->funcs->atomic_create_state)
+		state = bridge->funcs->atomic_create_state(bridge);
+	else
+		state = bridge->funcs->atomic_reset(bridge);
 	if (IS_ERR(state))
 		return ERR_CAST(state);
 
 	return &state->base;
 }
@@ -515,11 +518,12 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
-	return bridge->funcs->atomic_reset != NULL;
+	return (bridge->funcs->atomic_create_state ||
+		bridge->funcs->atomic_reset);
 }
 
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 00a95f927e34..70e574fbf034 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -528,10 +528,26 @@ struct drm_bridge_funcs {
 	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
 	 * giving the reason of the failure otherwise.
 	 */
 	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);
 
+	/**
+	 * @atomic_create_state:
+	 *
+	 * Allocate a pristine, initialized, state for the bridge
+	 * object and return it. This callback must have no side
+	 * effects: in particular, the returned state must not be
+	 * assigned to the object's state pointer and it must not affect
+	 * the hardware state.
+	 *
+	 * RETURNS:
+	 *
+	 * A new, pristine, bridge state instance or an error pointer
+	 * on failure.
+	 */
+	struct drm_bridge_state *(*atomic_create_state)(struct drm_bridge *bridge);
+
 	/**
 	 * @detect:
 	 *
 	 * Check if anything is attached to the bridge output.
 	 *
@@ -1373,11 +1389,12 @@ drm_bridge_get_current_state(struct drm_bridge *bridge)
 	/*
 	 * Only atomic bridges will have bridge->base initialized by
 	 * drm_atomic_private_obj_init(), so we need to make sure we're
 	 * working with one before we try to use the lock.
 	 */
-	if (!bridge->funcs || !bridge->funcs->atomic_reset)
+	if (!bridge->funcs ||
+	    !(bridge->funcs->atomic_reset || bridge->funcs->atomic_create_state))
 		return NULL;
 
 	drm_modeset_lock_assert_held(&bridge->base.lock);
 
 	if (!bridge->base.state)

-- 
2.54.0

