Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27128C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BFC10F1F8;
	Fri, 31 Jul 2026 09:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="q5WPjJql";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 5286010F1F8
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:48:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D837F22C8
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:48:11 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 A85053FA7A
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785491295; bh=Tbe0epZ1YCtadddKjDPRvFa7Hf5UutQlaU8egi2kCe0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q5WPjJqlMVq9zdNZRQQNXHza+8TOv6Kk874cyqjfRCiy/MH35BQlEjNdEF3E/wkN8
 gLOPRBVmF8PzMDNoY9Pvu9l/G0pg/6ZdeLT03dpPIBrD+PDHMYEDO1z49K1Xm61t+D
 v58cjGfPyE426iCb7sEe09JdByzWr509mTG7BWJI=
Date: Fri, 31 Jul 2026 10:48:08 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 40/60] drm/komeda: Convert to atomic_create_state
Message-ID: <amxvWLgYR7vVobkz@e142607>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-40-302d986fe5f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-40-302d986fe5f0@kernel.org>
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

On Thu, Jul 09, 2026 at 01:51:06PM +0200, Maxime Ripard wrote:
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
> ---
> Cc: liviu.dudau@arm.com

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 57a4a0c7d404..955dbef5d34d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -130,23 +130,21 @@ static void komeda_plane_destroy(struct drm_plane *plane)
>  	drm_plane_cleanup(plane);
>  
>  	kfree(to_kplane(plane));
>  }
>  
> -static void komeda_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *komeda_plane_create_state(struct drm_plane *plane)
>  {
>  	struct komeda_plane_state *state;
>  
> -	if (plane->state)
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -
> -	kfree(plane->state);
> -	plane->state = NULL;
> -
>  	state = kzalloc_obj(*state);
> -	if (state)
> -		__drm_atomic_helper_plane_reset(plane, &state->base);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_plane_state_init(&state->base, plane);
> +
> +	return &state->base;
>  }
>  
>  static struct drm_plane_state *
>  komeda_plane_atomic_duplicate_state(struct drm_plane *plane)
>  {
> @@ -186,11 +184,11 @@ komeda_plane_format_mod_supported(struct drm_plane *plane,
>  
>  static const struct drm_plane_funcs komeda_plane_funcs = {
>  	.update_plane		= drm_atomic_helper_update_plane,
>  	.disable_plane		= drm_atomic_helper_disable_plane,
>  	.destroy		= komeda_plane_destroy,
> -	.reset			= komeda_plane_reset,
> +	.atomic_create_state = komeda_plane_create_state,
>  	.atomic_duplicate_state	= komeda_plane_atomic_duplicate_state,
>  	.atomic_destroy_state	= komeda_plane_atomic_destroy_state,
>  	.format_mod_supported	= komeda_plane_format_mod_supported,
>  };
>  
> 
> -- 
> 2.54.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
