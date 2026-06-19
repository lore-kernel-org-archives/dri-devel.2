Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68885CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831B110F563;
	Fri, 19 Jun 2026 12:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UPCjNN0X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D838710F55E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B729B43834;
 Fri, 19 Jun 2026 12:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254041F00A3D;
 Fri, 19 Jun 2026 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871903;
 bh=WWJJszxVSV+PBRpot86EaczzBUI6/OcNPFOqvEm8zdQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UPCjNN0XxwWb5hgPI1PKR2ltX+xR9A2WXiBHWvWipQ5TPuaDjG0+67OAyt+56FaJa
 vnnD+fY2IM+Wpbod5Uh9OtndJ4W96kI6IAOMVBm4+rL3aC+Bi0VAj7SG4RIXemHa4Z
 uWlbNpQ6bQSLvlnKkcGrvBuYh8FP6G2+U2RrDHwjCQcmUAe+KtE9lsLsqZbVEdID1h
 C/DWbQBGmu32TFZbCY8TaMjApEY9M6f0lc1kLYwfCWOHzH57e2a0504uanB7Eo0nT4
 sCGkLDMA19l9Q4MeWJgTdlMFExzuGB1muJWioBznQs8zFeO3W1YSLsYZJaHTupxAs3
 JBcfJmycFS3Vw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:11 +0200
Subject: [PATCH v3 06/78] drm/bridge: Add new atomic_create_state callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-6-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4901; i=mripard@kernel.org;
 h=from:subject:message-id; bh=cVnRIUtx9GfIPKBw/F4ElktE7AKEqVRw/dxZwAj7cYY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJm8ulJp3GTfm5zOmeRYkiz329XM9Pfef2/KYjMIUB
 2vBI7UdU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCJ27xhrpXqPhfLnh5zv6edY
 oWzAsLw+oO5xi4LmMV77jTNu/l5W/16/M7RQyXmCikSu6XnHHymMDR+0vVQKj6d+PagSL9G48W6
 V+ceCtd4bYmbuv/v+Z7LY7kKD2hSFO0fLRflz9dX3vrdjAwA=
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
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  5 +++--
 drivers/gpu/drm/drm_bridge.c              |  8 ++++++--
 include/drm/drm_bridge.h                  | 19 ++++++++++++++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index f0688f2d83fe..9dfb9b6ba392 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -892,12 +892,13 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
  * @bridge: the bridge this state refers to
  *
  * @state is assumed to be zeroed.
  *
  * Initializes the bridge state to default values. This is meant to be called
- * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
- * the bridge state.
+ * by the bridge &drm_bridge_funcs.atomic_create_state or
+ * &drm_bridge_funcs.atomic_reset hook for bridges that subclass the bridge
+ * state.
  */
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge)
 {
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1daac8a7f4c9..776856e23592 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -540,11 +540,14 @@ static struct drm_private_state *
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
@@ -555,11 +558,12 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
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

