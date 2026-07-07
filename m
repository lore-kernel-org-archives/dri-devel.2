Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83A4C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2F410EDF8;
	Tue,  7 Jul 2026 15:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="alIVbgP1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735F010EDF4
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:12:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AA414077F;
 Tue,  7 Jul 2026 15:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B651F000E9;
 Tue,  7 Jul 2026 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783437178;
 bh=pFESsl/Myrf0q00zqqHVKVZh3ngcFpXCDA4hYP5eXcU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=alIVbgP199rlwRfMpVmNtzUD/mzPpAY5T0Nj0PDCSQZ0twpNJL/MVkKmStXPkMj73
 CXeFIn7QaXDFPG7tpaE2KkZgPKonL64/PeyBQrj3P/1FG+S+T2pFE6ZI2JndlucsS0
 OCpAsyAeMrZjSQ8sNN4na4HRkK5dla4Fk8P8hhWN5X3rCez5DAMS24H+o319nAqC2O
 IjGFGT8GRBh0e8MxWJEqxPEYbh6m8EeKntIHN8LTApwSsawEUN7Bv8nkuTrGCnnPjn
 uUcVHDqxF881kWc9bRVyrtig681cbLndsA9nlU1KTeR/AGaXLsyJM6Cw6l4sFwrCY9
 8UEyQFUSJ3ENw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 07 Jul 2026 17:11:44 +0200
Subject: [PATCH v2 37/37] drm/bridge: Remove legacy bridge callback support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-drm-all-atomic-bridges-v2-37-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=19202; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3AKSm8ufkhd4T5csAazlDUqQAqzRqPcXmFILQZjXKtA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm+4gomHZX7w9/t7tyy4dampAmtvJqx9fd1PLe/uBO9n
 PHbDau3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiR1MZG46c+HY+rmDboZ3P
 H709u4M7TSEuccOWsDvrmT69dukIfBRTe/LM5QMJr9Y/M1Di7/0WrMXY8LHQ93jnzi1He0wt69x
 yudZEzg5sdU3yqRL/Y/bEecV7Mb33X2Yy/2COSpPc2Dw5fmUeAA==
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

All bridge drivers have been converted to the atomic variants of the
enable, disable, pre_enable, and post_disable callbacks.

Remove the deprecated legacy hooks from drm_bridge_funcs, the
drm_bridge_is_atomic() helper that was only needed to distinguish
between atomic and non-atomic bridges, and the legacy bridge test
cases.

Since all bridges are now atomic, unconditionally initialize the
private object state at attach time.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c            |  61 ++++++-------------
 drivers/gpu/drm/tests/drm_bridge_test.c | 104 --------------------------------
 include/drm/drm_bridge.h                | 103 -------------------------------
 3 files changed, 20 insertions(+), 248 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 6ead9b75ae3d..6fb443984dff 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -553,15 +553,10 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
 	.atomic_create_state = drm_bridge_atomic_create_priv_state,
 	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
 	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
 };
 
-static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
-{
-	return bridge->funcs->atomic_create_state != NULL;
-}
-
 /**
  * drm_bridge_attach - attach the bridge to an encoder's chain
  *
  * @encoder: DRM encoder
  * @bridge: bridge to attach
@@ -627,13 +622,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	if (drm_bridge_is_atomic(bridge))
-		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
-					    &drm_bridge_priv_state_funcs);
+	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+				    &drm_bridge_priv_state_funcs);
 
 	return 0;
 
 err_reset_bridge:
 	bridge->dev = NULL;
@@ -662,12 +656,11 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 		return;
 
 	if (WARN_ON(!bridge->dev))
 		return;
 
-	if (drm_bridge_is_atomic(bridge))
-		drm_atomic_private_obj_fini(&bridge->base);
+	drm_atomic_private_obj_fini(&bridge->base);
 
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
 	list_del(&bridge->chain_node);
@@ -688,13 +681,13 @@ void drm_bridge_detach(struct drm_bridge *bridge)
  *   operations. They are used by the legacy CRTC and the atomic modeset
  *   helpers to perform mode validation, fixup and setting, and enable and
  *   disable the bridge automatically.
  *
  *   The enable and disable operations are split in
- *   &drm_bridge_funcs.pre_enable, &drm_bridge_funcs.enable,
- *   &drm_bridge_funcs.disable and &drm_bridge_funcs.post_disable to provide
- *   finer-grained control.
+ *   &drm_bridge_funcs.atomic_pre_enable, &drm_bridge_funcs.atomic_enable,
+ *   &drm_bridge_funcs.atomic_disable and &drm_bridge_funcs.atomic_post_disable
+ *   to provide finer-grained control.
  *
  *   Bridge drivers may implement the legacy version of those operations, or
  *   the atomic version (prefixed with atomic\_), in which case they shall also
  *   implement the atomic state bookkeeping operations
  *   (&drm_bridge_funcs.atomic_duplicate_state,
@@ -831,14 +824,13 @@ EXPORT_SYMBOL(drm_bridge_chain_mode_set);
 /**
  * drm_atomic_bridge_chain_disable - disables all bridges in the encoder chain
  * @bridge: bridge control structure
  * @state: atomic state being committed
  *
- * Calls &drm_bridge_funcs.atomic_disable (falls back on
- * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
- * starting from the last bridge to the first. These are called before calling
- * &drm_encoder_helper_funcs.atomic_disable
+ * Calls &drm_bridge_funcs.atomic_disable op for all the bridges in the encoder
+ * chain, starting from the last bridge to the first. These are called before
+ * calling &drm_encoder_helper_funcs.atomic_disable
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 				     struct drm_atomic_commit *state)
@@ -850,15 +842,12 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
 		return;
 
 	encoder = bridge->encoder;
 	mutex_lock(&encoder->bridge_chain_mutex);
 	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
-		if (iter->funcs->atomic_disable) {
+		if (iter->funcs->atomic_disable)
 			iter->funcs->atomic_disable(iter, state);
-		} else if (iter->funcs->disable) {
-			iter->funcs->disable(iter);
-		}
 
 		if (iter == bridge)
 			break;
 	}
 	mutex_unlock(&encoder->bridge_chain_mutex);
@@ -868,24 +857,21 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
 static void drm_atomic_bridge_call_post_disable(struct drm_bridge *bridge,
 						struct drm_atomic_commit *state)
 {
 	if (state && bridge->funcs->atomic_post_disable)
 		bridge->funcs->atomic_post_disable(bridge, state);
-	else if (bridge->funcs->post_disable)
-		bridge->funcs->post_disable(bridge);
 }
 
 /**
  * drm_atomic_bridge_chain_post_disable - cleans up after disabling all bridges
  *					  in the encoder chain
  * @bridge: bridge control structure
  * @state: atomic state being committed
  *
- * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
- * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
- * starting from the first bridge to the last. These are called after completing
- * &drm_encoder_helper_funcs.atomic_disable
+ * Calls &drm_bridge_funcs.atomic_post_disable op for all the bridges in the
+ * encoder chain, starting from the first bridge to the last. These are called
+ * after completing &drm_encoder_helper_funcs.atomic_disable
  *
  * If a bridge sets @pre_enable_prev_first, then the @post_disable for that
  * bridge will be called before the previous one to reverse the @pre_enable
  * calling direction.
  *
@@ -965,24 +951,21 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
 static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
 					      struct drm_atomic_commit *state)
 {
 	if (state && bridge->funcs->atomic_pre_enable)
 		bridge->funcs->atomic_pre_enable(bridge, state);
-	else if (bridge->funcs->pre_enable)
-		bridge->funcs->pre_enable(bridge);
 }
 
 /**
  * drm_atomic_bridge_chain_pre_enable - prepares for enabling all bridges in
  *					the encoder chain
  * @bridge: bridge control structure
  * @state: atomic state being committed
  *
- * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
- * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
- * starting from the last bridge to the first. These are called before calling
- * &drm_encoder_helper_funcs.atomic_enable
+ * Calls &drm_bridge_funcs.atomic_pre_enable op for all the bridges in the
+ * encoder chain, starting from the last bridge to the first. These are called
+ * before calling &drm_encoder_helper_funcs.atomic_enable
  *
  * If a bridge sets @pre_enable_prev_first, then the pre_enable for the
  * prev bridge will be called before pre_enable of this bridge.
  *
  * Example:
@@ -1055,29 +1038,25 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_pre_enable);
 /**
  * drm_atomic_bridge_chain_enable - enables all bridges in the encoder chain
  * @first_bridge: bridge control structure
  * @state: atomic state being committed
  *
- * Calls &drm_bridge_funcs.atomic_enable (falls back on
- * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
- * starting from the first bridge to the last. These are called after completing
- * &drm_encoder_helper_funcs.atomic_enable
+ * Calls &drm_bridge_funcs.atomic_enable op for all the bridges in the encoder
+ * chain, starting from the first bridge to the last. These are called after
+ * completing &drm_encoder_helper_funcs.atomic_enable
  *
  * Note: the bridge passed should be the one closest to the encoder
  */
 void drm_atomic_bridge_chain_enable(struct drm_bridge *first_bridge,
 				    struct drm_atomic_commit *state)
 {
 	if (!first_bridge)
 		return;
 
 	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
-		if (bridge->funcs->atomic_enable) {
+		if (bridge->funcs->atomic_enable)
 			bridge->funcs->atomic_enable(bridge, state);
-		} else if (bridge->funcs->enable) {
-			bridge->funcs->enable(bridge);
-		}
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 
 static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 10a32620e962..bb4cf8bc6ea5 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -72,30 +72,10 @@ static void drm_test_bridge_priv_destroy(struct drm_bridge *bridge)
 	struct drm_bridge_init_priv *priv = (struct drm_bridge_init_priv *)bridge_priv->data;
 
 	priv->destroyed = true;
 }
 
-static void drm_test_bridge_enable(struct drm_bridge *bridge)
-{
-	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
-
-	priv->enable_count++;
-}
-
-static void drm_test_bridge_disable(struct drm_bridge *bridge)
-{
-	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
-
-	priv->disable_count++;
-}
-
-static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
-	.destroy		= drm_test_bridge_priv_destroy,
-	.enable			= drm_test_bridge_enable,
-	.disable		= drm_test_bridge_disable,
-};
-
 static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
 					  struct drm_atomic_commit *state)
 {
 	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
 
@@ -693,39 +673,12 @@ static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
 
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 }
 
-/*
- * Test that drm_bridge_get_current_state() returns NULL for a
- * non-atomic bridge.
- */
-static void drm_test_drm_bridge_get_current_state_legacy(struct kunit *test)
-{
-	struct drm_bridge_init_priv *priv;
-	struct drm_bridge *bridge;
-
-	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
-
-	/*
-	 * NOTE: Strictly speaking, we should take the bridge->base.lock
-	 * before calling that function. However, bridge->base is only
-	 * initialized if the bridge is atomic, while we explicitly
-	 * initialize one that isn't there.
-	 *
-	 * In order to avoid unnecessary warnings, let's skip the
-	 * locking. The function would return NULL in all cases anyway,
-	 * so we don't really have any concurrency to worry about.
-	 */
-	bridge = &priv->test_bridge->bridge;
-	KUNIT_EXPECT_NULL(test, drm_bridge_get_current_state(bridge));
-}
-
 static struct kunit_case drm_bridge_get_current_state_tests[] = {
 	KUNIT_CASE(drm_test_drm_bridge_get_current_state_atomic),
-	KUNIT_CASE(drm_test_drm_bridge_get_current_state_legacy),
 	{ }
 };
 
 
 static struct kunit_suite drm_bridge_get_current_state_test_suite = {
@@ -826,66 +779,10 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *
 
 	KUNIT_EXPECT_EQ(test, bridge_priv->enable_count, 0);
 	KUNIT_EXPECT_EQ(test, bridge_priv->disable_count, 0);
 }
 
-/*
- * Test that a non-atomic bridge is properly power-cycled when calling
- * drm_bridge_helper_reset_crtc().
- */
-static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
-{
-	struct drm_modeset_acquire_ctx ctx;
-	struct drm_bridge_init_priv *priv;
-	struct drm_display_mode *mode;
-	struct drm_bridge_priv *bridge_priv;
-	int ret;
-
-	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
-
-	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
-
-	drm_modeset_acquire_init(&ctx, 0);
-
-retry_commit:
-	ret = drm_kunit_helper_enable_crtc_connector(test,
-						     &priv->drm, priv->crtc,
-						     priv->connector,
-						     mode,
-						     &ctx);
-	if (ret == -EDEADLK) {
-		drm_modeset_backoff(&ctx);
-		goto retry_commit;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
-	bridge_priv = priv->test_bridge;
-	KUNIT_ASSERT_EQ(test, bridge_priv->enable_count, 1);
-	KUNIT_ASSERT_EQ(test, bridge_priv->disable_count, 0);
-
-	drm_modeset_acquire_init(&ctx, 0);
-
-retry_reset:
-	ret = drm_bridge_helper_reset_crtc(&bridge_priv->bridge, &ctx);
-	if (ret == -EDEADLK) {
-		drm_modeset_backoff(&ctx);
-		goto retry_reset;
-	}
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
-
-	KUNIT_EXPECT_EQ(test, bridge_priv->enable_count, 2);
-	KUNIT_EXPECT_EQ(test, bridge_priv->disable_count, 1);
-}
-
 /*
  * Test that a bridge using the drm_atomic_helper_bridge_get_hdmi_output_bus_fmts()
  * function for &drm_bridge_funcs.atomic_get_output_bus_fmts behaves as expected
  * for an HDMI connector bridge. Does so by creating an HDMI bridge connector
  * with RGB444, YCBCR444, and YCBCR420 (but not YCBCR422) as supported formats,
@@ -968,11 +865,10 @@ static void drm_test_drm_bridge_helper_hdmi_output_bus_fmts(struct kunit *test)
 }
 
 static struct kunit_case drm_bridge_helper_reset_crtc_tests[] = {
 	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic),
 	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic_disabled),
-	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_legacy),
 	KUNIT_CASE(drm_test_drm_bridge_helper_hdmi_output_bus_fmts),
 	{ }
 };
 
 static struct kunit_suite drm_bridge_helper_reset_crtc_test_suite = {
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 18f3db367dc1..123edad5fa65 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -171,56 +171,10 @@ struct drm_bridge_funcs {
 	 * operation should be rejected.
 	 */
 	bool (*mode_fixup)(struct drm_bridge *bridge,
 			   const struct drm_display_mode *mode,
 			   struct drm_display_mode *adjusted_mode);
-	/**
-	 * @disable:
-	 *
-	 * This callback should disable the bridge. It is called right before
-	 * the preceding element in the display pipe is disabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @disable vfunc. If the preceding element is a &drm_encoder
-	 * it's called right before the &drm_encoder_helper_funcs.disable,
-	 * &drm_encoder_helper_funcs.prepare or &drm_encoder_helper_funcs.dpms
-	 * hook.
-	 *
-	 * The bridge can assume that the display pipe (i.e. clocks and timing
-	 * signals) feeding it is still running when this callback is called.
-	 *
-	 * The @disable callback is optional.
-	 *
-	 * NOTE:
-	 *
-	 * This is deprecated, do not use!
-	 * New drivers shall use &drm_bridge_funcs.atomic_disable.
-	 */
-	void (*disable)(struct drm_bridge *bridge);
-
-	/**
-	 * @post_disable:
-	 *
-	 * This callback should disable the bridge. It is called right after the
-	 * preceding element in the display pipe is disabled. If the preceding
-	 * element is a bridge this means it's called after that bridge's
-	 * @post_disable function. If the preceding element is a &drm_encoder
-	 * it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
-	 * or &drm_encoder_helper_funcs.dpms hook.
-	 *
-	 * The bridge must assume that the display pipe (i.e. clocks and timing
-	 * signals) feeding it is no longer running when this callback is
-	 * called.
-	 *
-	 * The @post_disable callback is optional.
-	 *
-	 * NOTE:
-	 *
-	 * This is deprecated, do not use!
-	 * New drivers shall use &drm_bridge_funcs.atomic_post_disable.
-	 */
-	void (*post_disable)(struct drm_bridge *bridge);
 
 	/**
 	 * @mode_set:
 	 *
 	 * This callback should set the given mode on the bridge. It is called
@@ -247,59 +201,10 @@ struct drm_bridge_funcs {
 	 * &drm_bridge_funcs.atomic_enable operation.
 	 */
 	void (*mode_set)(struct drm_bridge *bridge,
 			 const struct drm_display_mode *mode,
 			 const struct drm_display_mode *adjusted_mode);
-	/**
-	 * @pre_enable:
-	 *
-	 * This callback should enable the bridge. It is called right before
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called before that
-	 * bridge's @pre_enable function. If the preceding element is a
-	 * &drm_encoder it's called right before the encoder's
-	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
-	 * &drm_encoder_helper_funcs.dpms hook.
-	 *
-	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
-	 * will not yet be running when this callback is called. The bridge must
-	 * not enable the display link feeding the next bridge in the chain (if
-	 * there is one) when this callback is called.
-	 *
-	 * The @pre_enable callback is optional.
-	 *
-	 * NOTE:
-	 *
-	 * This is deprecated, do not use!
-	 * New drivers shall use &drm_bridge_funcs.atomic_pre_enable.
-	 */
-	void (*pre_enable)(struct drm_bridge *bridge);
-
-	/**
-	 * @enable:
-	 *
-	 * This callback should enable the bridge. It is called right after
-	 * the preceding element in the display pipe is enabled. If the
-	 * preceding element is a bridge this means it's called after that
-	 * bridge's @enable function. If the preceding element is a
-	 * &drm_encoder it's called right after the encoder's
-	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
-	 * &drm_encoder_helper_funcs.dpms hook.
-	 *
-	 * The bridge can assume that the display pipe (i.e. clocks and timing
-	 * signals) feeding it is running when this callback is called. This
-	 * callback must enable the display link feeding the next bridge in the
-	 * chain if there is one.
-	 *
-	 * The @enable callback is optional.
-	 *
-	 * NOTE:
-	 *
-	 * This is deprecated, do not use!
-	 * New drivers shall use &drm_bridge_funcs.atomic_enable.
-	 */
-	void (*enable)(struct drm_bridge *bridge);
 
 	/**
 	 * @atomic_pre_enable:
 	 *
 	 * This callback should enable the bridge. It is called right before
@@ -1357,18 +1262,10 @@ static inline struct drm_bridge_state *
 drm_bridge_get_current_state(struct drm_bridge *bridge)
 {
 	if (!bridge)
 		return NULL;
 
-	/*
-	 * Only atomic bridges will have bridge->base initialized by
-	 * drm_atomic_private_obj_init(), so we need to make sure we're
-	 * working with one before we try to use the lock.
-	 */
-	if (!bridge->funcs || !bridge->funcs->atomic_create_state)
-		return NULL;
-
 	drm_modeset_lock_assert_held(&bridge->base.lock);
 
 	if (!bridge->base.state)
 		return NULL;
 

-- 
2.54.0

