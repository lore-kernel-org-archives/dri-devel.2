Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D050C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7F910E2C7;
	Thu, 10 Sep 2026 12:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XQoNw8cb";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FC310F48D
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:00:04 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD6FAC48;
 Thu, 10 Sep 2026 13:58:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1789041506;
 bh=p15CaMlU+NJqumt6i2JWbq4u6OSoIhblZDwl0I3jh8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XQoNw8cbJ4QSoKxYYF9tSs1EnZxppmg6w4Ck6lgHRKdPqr06G2vsJ+E0BK26Q4jQ3
 APsHXbjs+JOp/544B2xDJJVQAuBOQai3ScJadhSWSlRZLbd4rMTHaKG4bCOxC0ABGY
 eRuHnKdTa29Hvog57F3hEsh0FOo2itL161jLEbA4=
Date: Thu, 10 Sep 2026 15:00:01 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, geert+renesas@glider.be,
 kieran.bingham+renesas@ideasonboard.com,
 linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com,
 tomi.valkeinen+renesas@ideasonboard.com
Subject: Re: [PATCH v4 35/41] drm/rcar-du: Convert to atomic_create_state
Message-ID: <20260910120001.GK1892234@killaraus.ideasonboard.com>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-35-a31b3fcfc989@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-35-a31b3fcfc989@kernel.org>
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

On Tue, Sep 08, 2026 at 04:47:06PM +0200, Maxime Ripard wrote:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> The conversion was done using the following Coccinelle semantic patch:
> 
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
> 
> struct drm_plane_funcs funcs = {
>   ...,
> - .reset = drm_atomic_helper_plane_reset,
> + .atomic_create_state = drm_atomic_helper_plane_create_state,
>   ...,
> };
> 
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .reset = reset_func,
>     ...,
> };
> 
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
> 
>  void reset_func(...)
>  {
>  	<+...
> (
>  	__drm_atomic_helper_plane_reset(...);
> |
> 	__drm_gem_reset_shadow_plane(...);
> )
>  	...+>
>  }
> 
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .atomic_destroy_state = destroy_func,
>     ...,
> };
> 
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>     coccinelle.new_name = old_name.replace("_reset", "_create_state")
> else:
>     coccinelle.new_name = old_name
> 
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
> -   .reset = reset_func,
> +   .atomic_create_state = new_name,
>     ...,
> };
> 
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	...
> (
> -	if (P->state) {
> - 		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -		P->funcs->atomic_destroy_state(P, P->state);
> |
> -		destroy_func(P, P->state);
> )
> - 		...+>
> - 	}
> |
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -	WARN_ON(P->state);
> )
>  	...
> (
> -	kfree(P->state);
> |
> -	kfree(container_func(P->state));
> |
>  	// kfree is optional
> )
> (
> -	P->state = NULL;
> |
>  	// plane->state clearing is optional
> )
>  	...
>  }
> 
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
> 
>  void mtk_plane_reset(struct drm_plane *P)
>  {
>  	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
>  		...
> -	}
>  	...
>  }
> 
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
> 
>  void nv50_wndw_reset(...)
>  {
>  	...
> -	if (WARN_ON(!(S = kzalloc_obj(*S))))
> +	S = kzalloc_obj(*S);
> +	if (WARN_ON(!S))
>  		return;
>  	...
>  }
> 
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	<...
>  	S = kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> |
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
>  }
> 
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	S = kzalloc_obj(*S);
> 	...
> (
>  	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (S == NULL) {
>  		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> |
> -	__drm_gem_reset_shadow_plane(P, PS);
> +	__drm_gem_shadow_plane_state_init(P, PS);
> )
> 	...
> }
> 
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	<+...
> -	return;
> +	return ERR_PTR(-EINVAL);
> 	...+>
> }
> 
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_atomic_helper_plane_state_init(PS, P);
> 	...
> +
> +	return PS;
> }
> 
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

An impressive semantic patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Cc: geert+renesas@glider.be
> Cc: kieran.bingham+renesas@ideasonboard.com
> Cc: laurent.pinchart+renesas@ideasonboard.com
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: magnus.damm@gmail.com
> Cc: tomi.valkeinen+renesas@ideasonboard.com
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c | 15 ++++++---------
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c   | 15 ++++++---------
>  2 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> index 8870766b9e54..da2dff9bb317 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
> @@ -710,28 +710,25 @@ static void rcar_du_plane_atomic_destroy_state(struct drm_plane *plane,
>  {
>  	__drm_atomic_helper_plane_destroy_state(state);
>  	kfree(to_rcar_plane_state(state));
>  }
>  
> -static void rcar_du_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *rcar_du_plane_create_state(struct drm_plane *plane)
>  {
>  	struct rcar_du_plane_state *state;
>  
> -	if (plane->state) {
> -		rcar_du_plane_atomic_destroy_state(plane, plane->state);
> -		plane->state = NULL;
> -	}
> -
>  	state = kzalloc_obj(*state);
>  	if (state == NULL)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	__drm_atomic_helper_plane_reset(plane, &state->state);
> +	__drm_atomic_helper_plane_state_init(&state->state, plane);
>  
>  	state->hwindex = -1;
>  	state->source = RCAR_DU_PLANE_MEMORY;
>  	state->colorkey = RCAR_DU_COLORKEY_NONE;
> +
> +	return &state->state;
>  }
>  
>  static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
>  					     struct drm_plane_state *state,
>  					     struct drm_property *property,
> @@ -765,11 +762,11 @@ static int rcar_du_plane_atomic_get_property(struct drm_plane *plane,
>  }
>  
>  static const struct drm_plane_funcs rcar_du_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.reset = rcar_du_plane_reset,
> +	.atomic_create_state = rcar_du_plane_create_state,
>  	.destroy = drm_plane_cleanup,
>  	.atomic_duplicate_state = rcar_du_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = rcar_du_plane_atomic_destroy_state,
>  	.atomic_set_property = rcar_du_plane_atomic_set_property,
>  	.atomic_get_property = rcar_du_plane_atomic_get_property,
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> index ae9f381b03c8..4293e792afdb 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -419,30 +419,27 @@ static void rcar_du_vsp_plane_atomic_destroy_state(struct drm_plane *plane,
>  {
>  	__drm_atomic_helper_plane_destroy_state(state);
>  	kfree(to_rcar_vsp_plane_state(state));
>  }
>  
> -static void rcar_du_vsp_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *rcar_du_vsp_plane_create_state(struct drm_plane *plane)
>  {
>  	struct rcar_du_vsp_plane_state *state;
>  
> -	if (plane->state) {
> -		rcar_du_vsp_plane_atomic_destroy_state(plane, plane->state);
> -		plane->state = NULL;
> -	}
> -
>  	state = kzalloc_obj(*state);
>  	if (state == NULL)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	__drm_atomic_helper_plane_reset(plane, &state->state);
> +	__drm_atomic_helper_plane_state_init(&state->state, plane);
> +
> +	return &state->state;
>  }
>  
>  static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> -	.reset = rcar_du_vsp_plane_reset,
> +	.atomic_create_state = rcar_du_vsp_plane_create_state,
>  	.destroy = drm_plane_cleanup,
>  	.atomic_duplicate_state = rcar_du_vsp_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = rcar_du_vsp_plane_atomic_destroy_state,
>  };
>  

-- 
Regards,

Laurent Pinchart
