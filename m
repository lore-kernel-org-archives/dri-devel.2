Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A8ECD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0202010E650;
	Mon, 22 Jun 2026 11:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="svZmPgn3";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5885D10E650
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:43:17 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2996E9CE;
 Mon, 22 Jun 2026 13:42:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782128558;
 bh=Gx7TtQ5UvUA9nxaNdlzKE0t2e8rRF5hkg6LS+F9ToRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=svZmPgn3S4TgaZcOU0nQjwCB1RT2OkNynM6s31kUsWFzaF+VStlHB42gBD0bs1DsB
 eh01V/3MnzxKd+t7f7o2SBPyVqLzQL0JcmrE/tKLJtvOP/yHqIEwz00JeMZpZ49fd4
 qkQH1YW0KqZj85gZv7WNDXwJR5FfsHiEy3ZPiY2Y=
Date: Mon, 22 Jun 2026 14:43:14 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 37/37] drm/bridge: Remove legacy bridge callback support
Message-ID: <20260622114314.GG3872967@killaraus.ideasonboard.com>
References: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
 <20260617-drm-all-atomic-bridges-v1-37-b63e6316166b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-drm-all-atomic-bridges-v1-37-b63e6316166b@kernel.org>
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

Hi Maxime,

Thank you for the patch.

On Wed, Jun 17, 2026 at 12:15:02PM +0200, Maxime Ripard wrote:
> All bridge drivers have been converted to the atomic variants of the
> enable, disable, pre_enable, and post_disable callbacks.
> 
> Remove the deprecated legacy hooks from drm_bridge_funcs, the
> drm_bridge_is_atomic() helper that was only needed to distinguish
> between atomic and non-atomic bridges, and the legacy bridge test
> cases.
> 
> Since all bridges are now atomic, unconditionally initialize the
> private object state at attach time.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c            |  27 ++-------
>  drivers/gpu/drm/tests/drm_bridge_test.c | 104 --------------------------------
>  include/drm/drm_bridge.h                | 103 -------------------------------
>  3 files changed, 5 insertions(+), 229 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 0cd93f966998..01101c900a39 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -513,15 +513,10 @@ static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
>  	.atomic_create_state = drm_bridge_atomic_create_priv_state,
>  	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
>  	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
>  };
>  
> -static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
> -{
> -	return bridge->funcs->atomic_create_state != NULL;
> -}
> -
>  /**
>   * drm_bridge_attach - attach the bridge to an encoder's chain
>   *
>   * @encoder: DRM encoder
>   * @bridge: bridge to attach
> @@ -587,13 +582,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>  		ret = bridge->funcs->attach(bridge, encoder, flags);
>  		if (ret < 0)
>  			goto err_reset_bridge;
>  	}
>  
> -	if (drm_bridge_is_atomic(bridge))
> -		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> -					    &drm_bridge_priv_state_funcs);
> +	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
> +				    &drm_bridge_priv_state_funcs);
>  
>  	return 0;
>  
>  err_reset_bridge:
>  	bridge->dev = NULL;
> @@ -622,12 +616,11 @@ void drm_bridge_detach(struct drm_bridge *bridge)
>  		return;
>  
>  	if (WARN_ON(!bridge->dev))
>  		return;
>  
> -	if (drm_bridge_is_atomic(bridge))
> -		drm_atomic_private_obj_fini(&bridge->base);
> +	drm_atomic_private_obj_fini(&bridge->base);
>  
>  	if (bridge->funcs->detach)
>  		bridge->funcs->detach(bridge);
>  
>  	list_del(&bridge->chain_node);
> @@ -810,15 +803,12 @@ void drm_atomic_bridge_chain_disable(struct drm_bridge *bridge,
>  		return;
>  
>  	encoder = bridge->encoder;
>  	mutex_lock(&encoder->bridge_chain_mutex);
>  	list_for_each_entry_reverse(iter, &encoder->bridge_chain, chain_node) {
> -		if (iter->funcs->atomic_disable) {
> +		if (iter->funcs->atomic_disable)
>  			iter->funcs->atomic_disable(iter, state);
> -		} else if (iter->funcs->disable) {
> -			iter->funcs->disable(iter);
> -		}
>  
>  		if (iter == bridge)
>  			break;
>  	}
>  	mutex_unlock(&encoder->bridge_chain_mutex);
> @@ -828,12 +818,10 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_disable);
>  static void drm_atomic_bridge_call_post_disable(struct drm_bridge *bridge,
>  						struct drm_atomic_commit *state)
>  {
>  	if (state && bridge->funcs->atomic_post_disable)
>  		bridge->funcs->atomic_post_disable(bridge, state);
> -	else if (bridge->funcs->post_disable)
> -		bridge->funcs->post_disable(bridge);
>  }
>  
>  /**
>   * drm_atomic_bridge_chain_post_disable - cleans up after disabling all bridges
>   *					  in the encoder chain
> @@ -925,12 +913,10 @@ EXPORT_SYMBOL(drm_atomic_bridge_chain_post_disable);
>  static void drm_atomic_bridge_call_pre_enable(struct drm_bridge *bridge,
>  					      struct drm_atomic_commit *state)
>  {
>  	if (state && bridge->funcs->atomic_pre_enable)
>  		bridge->funcs->atomic_pre_enable(bridge, state);
> -	else if (bridge->funcs->pre_enable)
> -		bridge->funcs->pre_enable(bridge);
>  }
>  
>  /**
>   * drm_atomic_bridge_chain_pre_enable - prepares for enabling all bridges in
>   *					the encoder chain
> @@ -1029,15 +1015,12 @@ void drm_atomic_bridge_chain_enable(struct drm_bridge *first_bridge,

There's a mention of the .disable() callback in the documentation of
this function:

 * Calls &drm_bridge_funcs.atomic_disable (falls back on
 * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,

Same for the three other functions in the same family. With that
removed,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  {
>  	if (!first_bridge)
>  		return;
>  
>  	drm_for_each_bridge_in_chain_from(first_bridge, bridge)
> -		if (bridge->funcs->atomic_enable) {
> +		if (bridge->funcs->atomic_enable)
>  			bridge->funcs->atomic_enable(bridge, state);
> -		} else if (bridge->funcs->enable) {
> -			bridge->funcs->enable(bridge);
> -		}
>  }
>  EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
>  
>  static int drm_atomic_bridge_check(struct drm_bridge *bridge,
>  				   struct drm_crtc_state *crtc_state,
> diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
> index 3f0269e52432..99428fc03f29 100644
> --- a/drivers/gpu/drm/tests/drm_bridge_test.c
> +++ b/drivers/gpu/drm/tests/drm_bridge_test.c
> @@ -48,30 +48,10 @@ static void drm_test_bridge_priv_destroy(struct drm_bridge *bridge)
>  	struct drm_bridge_init_priv *priv = (struct drm_bridge_init_priv *)bridge_priv->data;
>  
>  	priv->destroyed = true;
>  }
>  
> -static void drm_test_bridge_enable(struct drm_bridge *bridge)
> -{
> -	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
> -
> -	priv->enable_count++;
> -}
> -
> -static void drm_test_bridge_disable(struct drm_bridge *bridge)
> -{
> -	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
> -
> -	priv->disable_count++;
> -}
> -
> -static const struct drm_bridge_funcs drm_test_bridge_legacy_funcs = {
> -	.destroy		= drm_test_bridge_priv_destroy,
> -	.enable			= drm_test_bridge_enable,
> -	.disable		= drm_test_bridge_disable,
> -};
> -
>  static void drm_test_bridge_atomic_enable(struct drm_bridge *bridge,
>  					  struct drm_atomic_commit *state)
>  {
>  	struct drm_bridge_priv *priv = bridge_to_priv(bridge);
>  
> @@ -234,39 +214,12 @@ static void drm_test_drm_bridge_get_current_state_atomic(struct kunit *test)
>  
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
>  }
>  
> -/*
> - * Test that drm_bridge_get_current_state() returns NULL for a
> - * non-atomic bridge.
> - */
> -static void drm_test_drm_bridge_get_current_state_legacy(struct kunit *test)
> -{
> -	struct drm_bridge_init_priv *priv;
> -	struct drm_bridge *bridge;
> -
> -	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> -
> -	/*
> -	 * NOTE: Strictly speaking, we should take the bridge->base.lock
> -	 * before calling that function. However, bridge->base is only
> -	 * initialized if the bridge is atomic, while we explicitly
> -	 * initialize one that isn't there.
> -	 *
> -	 * In order to avoid unnecessary warnings, let's skip the
> -	 * locking. The function would return NULL in all cases anyway,
> -	 * so we don't really have any concurrency to worry about.
> -	 */
> -	bridge = &priv->test_bridge->bridge;
> -	KUNIT_EXPECT_NULL(test, drm_bridge_get_current_state(bridge));
> -}
> -
>  static struct kunit_case drm_bridge_get_current_state_tests[] = {
>  	KUNIT_CASE(drm_test_drm_bridge_get_current_state_atomic),
> -	KUNIT_CASE(drm_test_drm_bridge_get_current_state_legacy),
>  	{ }
>  };
>  
>  
>  static struct kunit_suite drm_bridge_get_current_state_test_suite = {
> @@ -367,70 +320,13 @@ static void drm_test_drm_bridge_helper_reset_crtc_atomic_disabled(struct kunit *
>  
>  	KUNIT_EXPECT_EQ(test, bridge_priv->enable_count, 0);
>  	KUNIT_EXPECT_EQ(test, bridge_priv->disable_count, 0);
>  }
>  
> -/*
> - * Test that a non-atomic bridge is properly power-cycled when calling
> - * drm_bridge_helper_reset_crtc().
> - */
> -static void drm_test_drm_bridge_helper_reset_crtc_legacy(struct kunit *test)
> -{
> -	struct drm_modeset_acquire_ctx ctx;
> -	struct drm_bridge_init_priv *priv;
> -	struct drm_display_mode *mode;
> -	struct drm_bridge_priv *bridge_priv;
> -	int ret;
> -
> -	priv = drm_test_bridge_init(test, &drm_test_bridge_legacy_funcs);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> -
> -	mode = drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
> -
> -	drm_modeset_acquire_init(&ctx, 0);
> -
> -retry_commit:
> -	ret = drm_kunit_helper_enable_crtc_connector(test,
> -						     &priv->drm, priv->crtc,
> -						     priv->connector,
> -						     mode,
> -						     &ctx);
> -	if (ret == -EDEADLK) {
> -		drm_modeset_backoff(&ctx);
> -		goto retry_commit;
> -	}
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> -
> -	bridge_priv = priv->test_bridge;
> -	KUNIT_ASSERT_EQ(test, bridge_priv->enable_count, 1);
> -	KUNIT_ASSERT_EQ(test, bridge_priv->disable_count, 0);
> -
> -	drm_modeset_acquire_init(&ctx, 0);
> -
> -retry_reset:
> -	ret = drm_bridge_helper_reset_crtc(&bridge_priv->bridge, &ctx);
> -	if (ret == -EDEADLK) {
> -		drm_modeset_backoff(&ctx);
> -		goto retry_reset;
> -	}
> -	KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> -
> -	KUNIT_EXPECT_EQ(test, bridge_priv->enable_count, 2);
> -	KUNIT_EXPECT_EQ(test, bridge_priv->disable_count, 1);
> -}
> -
>  static struct kunit_case drm_bridge_helper_reset_crtc_tests[] = {
>  	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic),
>  	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_atomic_disabled),
> -	KUNIT_CASE(drm_test_drm_bridge_helper_reset_crtc_legacy),
>  	{ }
>  };
>  
>  static struct kunit_suite drm_bridge_helper_reset_crtc_test_suite = {
>  	.name = "drm_test_bridge_helper_reset_crtc",
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 18f3db367dc1..123edad5fa65 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -171,56 +171,10 @@ struct drm_bridge_funcs {
>  	 * operation should be rejected.
>  	 */
>  	bool (*mode_fixup)(struct drm_bridge *bridge,
>  			   const struct drm_display_mode *mode,
>  			   struct drm_display_mode *adjusted_mode);
> -	/**
> -	 * @disable:
> -	 *
> -	 * This callback should disable the bridge. It is called right before
> -	 * the preceding element in the display pipe is disabled. If the
> -	 * preceding element is a bridge this means it's called before that
> -	 * bridge's @disable vfunc. If the preceding element is a &drm_encoder
> -	 * it's called right before the &drm_encoder_helper_funcs.disable,
> -	 * &drm_encoder_helper_funcs.prepare or &drm_encoder_helper_funcs.dpms
> -	 * hook.
> -	 *
> -	 * The bridge can assume that the display pipe (i.e. clocks and timing
> -	 * signals) feeding it is still running when this callback is called.
> -	 *
> -	 * The @disable callback is optional.
> -	 *
> -	 * NOTE:
> -	 *
> -	 * This is deprecated, do not use!
> -	 * New drivers shall use &drm_bridge_funcs.atomic_disable.
> -	 */
> -	void (*disable)(struct drm_bridge *bridge);
> -
> -	/**
> -	 * @post_disable:
> -	 *
> -	 * This callback should disable the bridge. It is called right after the
> -	 * preceding element in the display pipe is disabled. If the preceding
> -	 * element is a bridge this means it's called after that bridge's
> -	 * @post_disable function. If the preceding element is a &drm_encoder
> -	 * it's called right after the encoder's
> -	 * &drm_encoder_helper_funcs.disable, &drm_encoder_helper_funcs.prepare
> -	 * or &drm_encoder_helper_funcs.dpms hook.
> -	 *
> -	 * The bridge must assume that the display pipe (i.e. clocks and timing
> -	 * signals) feeding it is no longer running when this callback is
> -	 * called.
> -	 *
> -	 * The @post_disable callback is optional.
> -	 *
> -	 * NOTE:
> -	 *
> -	 * This is deprecated, do not use!
> -	 * New drivers shall use &drm_bridge_funcs.atomic_post_disable.
> -	 */
> -	void (*post_disable)(struct drm_bridge *bridge);
>  
>  	/**
>  	 * @mode_set:
>  	 *
>  	 * This callback should set the given mode on the bridge. It is called
> @@ -247,59 +201,10 @@ struct drm_bridge_funcs {
>  	 * &drm_bridge_funcs.atomic_enable operation.
>  	 */
>  	void (*mode_set)(struct drm_bridge *bridge,
>  			 const struct drm_display_mode *mode,
>  			 const struct drm_display_mode *adjusted_mode);
> -	/**
> -	 * @pre_enable:
> -	 *
> -	 * This callback should enable the bridge. It is called right before
> -	 * the preceding element in the display pipe is enabled. If the
> -	 * preceding element is a bridge this means it's called before that
> -	 * bridge's @pre_enable function. If the preceding element is a
> -	 * &drm_encoder it's called right before the encoder's
> -	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
> -	 * &drm_encoder_helper_funcs.dpms hook.
> -	 *
> -	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
> -	 * will not yet be running when this callback is called. The bridge must
> -	 * not enable the display link feeding the next bridge in the chain (if
> -	 * there is one) when this callback is called.
> -	 *
> -	 * The @pre_enable callback is optional.
> -	 *
> -	 * NOTE:
> -	 *
> -	 * This is deprecated, do not use!
> -	 * New drivers shall use &drm_bridge_funcs.atomic_pre_enable.
> -	 */
> -	void (*pre_enable)(struct drm_bridge *bridge);
> -
> -	/**
> -	 * @enable:
> -	 *
> -	 * This callback should enable the bridge. It is called right after
> -	 * the preceding element in the display pipe is enabled. If the
> -	 * preceding element is a bridge this means it's called after that
> -	 * bridge's @enable function. If the preceding element is a
> -	 * &drm_encoder it's called right after the encoder's
> -	 * &drm_encoder_helper_funcs.enable, &drm_encoder_helper_funcs.commit or
> -	 * &drm_encoder_helper_funcs.dpms hook.
> -	 *
> -	 * The bridge can assume that the display pipe (i.e. clocks and timing
> -	 * signals) feeding it is running when this callback is called. This
> -	 * callback must enable the display link feeding the next bridge in the
> -	 * chain if there is one.
> -	 *
> -	 * The @enable callback is optional.
> -	 *
> -	 * NOTE:
> -	 *
> -	 * This is deprecated, do not use!
> -	 * New drivers shall use &drm_bridge_funcs.atomic_enable.
> -	 */
> -	void (*enable)(struct drm_bridge *bridge);
>  
>  	/**
>  	 * @atomic_pre_enable:
>  	 *
>  	 * This callback should enable the bridge. It is called right before
> @@ -1357,18 +1262,10 @@ static inline struct drm_bridge_state *
>  drm_bridge_get_current_state(struct drm_bridge *bridge)
>  {
>  	if (!bridge)
>  		return NULL;
>  
> -	/*
> -	 * Only atomic bridges will have bridge->base initialized by
> -	 * drm_atomic_private_obj_init(), so we need to make sure we're
> -	 * working with one before we try to use the lock.
> -	 */
> -	if (!bridge->funcs || !bridge->funcs->atomic_create_state)
> -		return NULL;
> -
>  	drm_modeset_lock_assert_held(&bridge->base.lock);
>  
>  	if (!bridge->base.state)
>  		return NULL;
>  

-- 
Regards,

Laurent Pinchart
