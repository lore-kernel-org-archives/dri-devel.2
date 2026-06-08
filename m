Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6490CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D56310F516;
	Mon,  8 Jun 2026 14:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oMof+qmC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC91C10F516
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FB35601E1;
 Mon,  8 Jun 2026 14:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABF1F00898;
 Mon,  8 Jun 2026 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929596;
 bh=BOiNuUpkr10EUbgEKuuTHuCKGx3Av/+5aL4La/JzY1g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oMof+qmCd0v4APNI6Wg4SXynj0wvqI8vA0mFeoxJ9O+KtoC/vs2LJYhTWOsWtqg1V
 10mqETjqLAodff7h5e4/4h5FSZ0yT1yMf5XQ6qewk8kfkRvRh8RZ48E0m6ywTo1ylK
 bSinX/1m63y3UH+1fESuXslrD+MA9HC3eHqJhMMToZiEVRDK9XCwb9DS32TVy+i1h7
 2gp+WG33ZKj7LlnSrGc2KYolIM5t0Q+dDUEOKoUJ7wgI8sPUK7GvdPeqBVHwZyrFzJ
 HLGMIpYHM2Vv26m5FkJ/ILekUt5I1bzuOm0zoDrGK/NEL3JHoBx7om/rbl+KGCx4EP
 C5SH7K3q0ORrQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:37:00 +0200
Subject: [PATCH v2 78/78] drm/bridge: Remove atomic_reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-78-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=mripard@kernel.org;
 h=from:subject:message-id; bh=4sBWxf129ftIMToWTtpvXAL0exhTlFuCWj6iUBuShTU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql9PrtQVrmL4JenB3q731OXB6jdiLfU+uf1u6P5jt6
 +VprGxTOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEFqxkrJU3erVDn23GcpZD
 rFqXRMxub+nfVPSJuZXzsMvZ6787oh4c279gxZa+rPqZzPNXrhEKXsrY0PXn9rLj3ptCLO1uy54
 Uzlj1IJrn6z/vux08glYPEgQefo1O2+p3xUU6+HV3c4m4tGUWAA==
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

There are no remaining users of the atomic_reset hook. Remove it
from the core.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c |  8 ++------
 include/drm/drm_bridge.h     | 30 +-----------------------------
 2 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index b4543a50bc6f..0cd93f966998 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -500,14 +500,11 @@ static struct drm_private_state *
 drm_bridge_atomic_create_priv_state(struct drm_private_obj *obj)
 {
 	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
 	struct drm_bridge_state *state;
 
-	if (bridge->funcs->atomic_create_state)
-		state = bridge->funcs->atomic_create_state(bridge);
-	else
-		state = bridge->funcs->atomic_reset(bridge);
+	state = bridge->funcs->atomic_create_state(bridge);
 	if (IS_ERR(state))
 		return ERR_CAST(state);
 
 	return &state->base;
 }
@@ -518,12 +515,11 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
 static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
 {
-	return (bridge->funcs->atomic_create_state ||
-		bridge->funcs->atomic_reset);
+	return bridge->funcs->atomic_create_state != NULL;
 }
 
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 70e574fbf034..18f3db367dc1 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -501,37 +501,10 @@ struct drm_bridge_funcs {
 	int (*atomic_check)(struct drm_bridge *bridge,
 			    struct drm_bridge_state *bridge_state,
 			    struct drm_crtc_state *crtc_state,
 			    struct drm_connector_state *conn_state);
 
-	/**
-	 * @atomic_reset:
-	 *
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
-	 *
-	 * RETURNS:
-	 * A valid drm_bridge_state object in case of success, an ERR_PTR()
-	 * giving the reason of the failure otherwise.
-	 */
-	struct drm_bridge_state *(*atomic_reset)(struct drm_bridge *bridge);
-
 	/**
 	 * @atomic_create_state:
 	 *
 	 * Allocate a pristine, initialized, state for the bridge
 	 * object and return it. This callback must have no side
@@ -1389,12 +1362,11 @@ drm_bridge_get_current_state(struct drm_bridge *bridge)
 	/*
 	 * Only atomic bridges will have bridge->base initialized by
 	 * drm_atomic_private_obj_init(), so we need to make sure we're
 	 * working with one before we try to use the lock.
 	 */
-	if (!bridge->funcs ||
-	    !(bridge->funcs->atomic_reset || bridge->funcs->atomic_create_state))
+	if (!bridge->funcs || !bridge->funcs->atomic_create_state)
 		return NULL;
 
 	drm_modeset_lock_assert_held(&bridge->base.lock);
 
 	if (!bridge->base.state)

-- 
2.54.0

