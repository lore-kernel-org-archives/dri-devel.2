Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D05FC5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D352F10E6E1;
	Mon, 24 Aug 2026 10:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="V7gEXOgw";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 02A4D10E6E1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A456B176C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:04 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 3D3673F85F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787568548; bh=rDg7RkVh2qzfMVSRwibvuaXkuMboEyP9EyRBOakT1C4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V7gEXOgw518GF6UzbqcxOnjkhHDbbJ9V1TIt1p6pQnHWY3CiYtQlalSnqxgHq+vdg
 50GCb/dYUbJsPCUbVCXO//5OGLDJNeKaEEeIE8fQrd+5x6q12a3YmsOa2u2mVSLClC
 ckonttFGDD7yO5QxNAMLIsPZmcmP3B0Qazurp10c=
Date: Mon, 24 Aug 2026 11:49:00 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 46/70] drm/malidp: Convert to atomic_create_state
Message-ID: <aowhnABVC_DZ2n4R@e142607>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-46-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-46-fb793475c05a@kernel.org>
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

On Fri, Aug 21, 2026 at 04:39:22PM +0200, Maxime Ripard wrote:
> The malidp crtc implementation provides a custom reset hook. However,
> this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
> 
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_crtc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index ebe8e1078777..157ff148efe7 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -474,21 +474,21 @@ static void malidp_crtc_destroy_state(struct drm_crtc *crtc,
>  	}
>  
>  	kfree(mali_state);
>  }
>  
> -static void malidp_crtc_reset(struct drm_crtc *crtc)
> +static struct drm_crtc_state *malidp_crtc_create_state(struct drm_crtc *crtc)
>  {
> -	struct malidp_crtc_state *state = kzalloc_obj(*state);
> +	struct malidp_crtc_state *state;
>  
> -	if (crtc->state)
> -		malidp_crtc_destroy_state(crtc, crtc->state);
> +	state = kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (state)
> -		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> -	else
> -		__drm_atomic_helper_crtc_reset(crtc, NULL);
> +	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
> +
> +	return &state->base;
>  }
>  
>  static int malidp_crtc_enable_vblank(struct drm_crtc *crtc)
>  {
>  	struct malidp_drm *malidp = crtc_to_malidp_device(crtc);
> @@ -509,11 +509,11 @@ static void malidp_crtc_disable_vblank(struct drm_crtc *crtc)
>  }
>  
>  static const struct drm_crtc_funcs malidp_crtc_funcs = {
>  	.set_config = drm_atomic_helper_set_config,
>  	.page_flip = drm_atomic_helper_page_flip,
> -	.reset = malidp_crtc_reset,
> +	.atomic_create_state = malidp_crtc_create_state,
>  	.atomic_duplicate_state = malidp_crtc_duplicate_state,
>  	.atomic_destroy_state = malidp_crtc_destroy_state,
>  	.enable_vblank = malidp_crtc_enable_vblank,
>  	.disable_vblank = malidp_crtc_disable_vblank,
>  };
> 
> -- 
> 2.55.0
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
