Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E99CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6F010E355;
	Sat, 30 May 2026 14:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AupyqGph";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D915D10E355
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEC6A4076D;
 Sat, 30 May 2026 14:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAEA1F00898;
 Sat, 30 May 2026 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149605;
 bh=DluBzgCs8mXvT0Xn5QB32A9r9aWWNOLoKeit24tlI5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AupyqGphJ3z2s965ocPYI+5llnDRIhCctfs9k0fGC9WdUoawPCe50g1gljDmo6utf
 A0j/QXcyCex1aBmeQrAFNRWIqmUAuWzqFmd6VSF3F/yGcQxegXpkLwaunv6tq52/6k
 7s6XTbAH2DLEaUsqWNUMk60qyRGOCzY89WSuu6tXuoZDZEgYpIxnKtyKeOyj/nkLR2
 VBAgmNGTF/e9neOEMQ0hoIWh+HeP2IZQ80KloyYxVzw8pvsDxRK86M3yLLL9JT73yS
 mBEcEtN0oOs36ANwf1s5rMbeZJiBUzYv6Qo98/9Atfm5Ykqf4Vo1CeN8teo/KdwhAT
 UnGKfjYuwgOkQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:09 +0200
Subject: [PATCH 04/76] drm/bridge: Add new atomic_create_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-4-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4765; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yBHRsQmZbj5xT1ZIhn/9h711gXV45q7dolDADfjLuQg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb83f+Gqz1ytcFeHp0OzPEvxUu2pdvTYrF4eyxJ+dR
 +bX7ZvXMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbCvJGx3kFpzt15qzXsYnaI
 HWbkd9ENWv4pMEv/+69dHxK5H3EEdy1YHCdRL+kU8bntj/suWc0VjA1vdBrfHkx2+Xzpi9KF9xe
 vJMlfcogx4ZfjnbCrqyXsPOemgN+ruZ4wtOilBUXyTuwwZAIA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c |  8 ++++++--
 include/drm/drm_bridge.h     | 33 +++++++++++----------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 687b36eea0c7..ef06c1aa509a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -498,11 +498,14 @@ static struct drm_private_state *
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
@@ -513,11 +516,12 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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
index 4ba3a5deef9a..a6c07d339afa 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -502,35 +502,24 @@ struct drm_bridge_funcs {
 			    struct drm_bridge_state *bridge_state,
 			    struct drm_crtc_state *crtc_state,
 			    struct drm_connector_state *conn_state);
 
 	/**
-	 * @atomic_reset:
+	 * @atomic_create_state:
 	 *
-	 * Reset the bridge to a predefined state (or retrieve its current
-	 * state) and return a &drm_bridge_state object matching this state.
-	 * This function is called at attach time.
-	 *
-	 * The atomic_reset hook is mandatory if the bridge implements any of
-	 * the atomic hooks, and should be left unassigned otherwise. For
-	 * bridges that don't subclass &drm_bridge_state, the
-	 * drm_atomic_helper_bridge_reset() helper function shall be used to
-	 * implement this hook.
-	 *
-	 * Note that the atomic_reset() semantics is not exactly matching the
-	 * reset() semantics found on other components (connector, plane, ...).
-	 *
-	 * 1. The reset operation happens when the bridge is attached, not when
-	 *    drm_mode_config_reset() is called
-	 * 2. It's meant to be used exclusively on bridges that have been
-	 *    converted to the ATOMIC API
+	 * Allocate a pristine, initialized, state for the bridge
+	 * object and return it. This callback must have no side
+	 * effects: in particular, the returned state must not be
+	 * assigned to the object's state pointer and it must not affect
+	 * the hardware state.
 	 *
 	 * RETURNS:
-	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
-	 * giving the reason of the failure otherwise.
+	 *
+	 * A new, pristine, bridge state instance or an error pointer
+	 * on failure.
 	 */
-	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);
+	struct drm_bridge_state *(*atomic_create_state)(struct drm_bridge *bridge);
 
 	/**
 	 * @detect:
 	 *
 	 * Check if anything is attached to the bridge output.
@@ -1369,11 +1358,11 @@ drm_bridge_get_current_state(struct drm_bridge *bridge)
 	/*
 	 * Only atomic bridges will have bridge->base initialized by
 	 * drm_atomic_private_obj_init(), so we need to make sure we're
 	 * working with one before we try to use the lock.
 	 */
-	if (!bridge->funcs || !bridge->funcs->atomic_reset)
+	if (!bridge->funcs || !bridge->funcs->atomic_create_state)
 		return NULL;
 
 	drm_modeset_lock_assert_held(&bridge->base.lock);
 
 	if (!bridge->base.state)

-- 
2.54.0

