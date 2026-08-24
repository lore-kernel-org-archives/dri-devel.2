Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC9CC5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2086410E556;
	Mon, 24 Aug 2026 10:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="eshuSVpg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7BA2B10E556
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:48:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36D88176C
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:48:27 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C4D583F85F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787568511; bh=pUNjPgaWkz54e0lhzeLfMsVNOk9xkn84xXdKnKWIm44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eshuSVpgNu5nTMvtVL36ZyxnF9h1p0T+Fgn2Zh8a4H8od2AYziuH/JIFZjgntXY/Q
 vXBOKTPBNXdy0LWyAbVqMyemGjVKdgBtkBNr8lhfyUScEqO5ZrRk2HDXfU+yKWxFTS
 vT4DrTijtj+JFZ4WlpDgint6z5+jzzCqf36OxE+0=
Date: Mon, 24 Aug 2026 11:48:24 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 45/70] drm/komeda: Convert to atomic_create_state
Message-ID: <aowheLXc3XrH9wFX@e142607>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-45-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-45-fb793475c05a@kernel.org>
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

On Fri, Aug 21, 2026 at 04:39:21PM +0200, Maxime Ripard wrote:
> The komeda crtc implementation provides a custom reset hook. However,
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
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index e8cb782a6f8e..e1165b6d8bfd 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -491,23 +491,21 @@ static const struct drm_crtc_helper_funcs komeda_crtc_helper_funcs = {
>  	.atomic_disable	= komeda_crtc_atomic_disable,
>  	.mode_valid	= komeda_crtc_mode_valid,
>  	.mode_fixup	= komeda_crtc_mode_fixup,
>  };
>  
> -static void komeda_crtc_reset(struct drm_crtc *crtc)
> +static struct drm_crtc_state *komeda_crtc_create_state(struct drm_crtc *crtc)
>  {
>  	struct komeda_crtc_state *state;
>  
> -	if (crtc->state)
> -		__drm_atomic_helper_crtc_destroy_state(crtc->state);
> -
> -	kfree(to_kcrtc_st(crtc->state));
> -	crtc->state = NULL;
> -
>  	state = kzalloc_obj(*state);
> -	if (state)
> -		__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
> +
> +	return &state->base;
>  }
>  
>  static struct drm_crtc_state *
>  komeda_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
>  {
> @@ -553,11 +551,11 @@ static void komeda_crtc_vblank_disable(struct drm_crtc *crtc)
>  
>  static const struct drm_crtc_funcs komeda_crtc_funcs = {
>  	.destroy		= drm_crtc_cleanup,
>  	.set_config		= drm_atomic_helper_set_config,
>  	.page_flip		= drm_atomic_helper_page_flip,
> -	.reset			= komeda_crtc_reset,
> +	.atomic_create_state = komeda_crtc_create_state,
>  	.atomic_duplicate_state	= komeda_crtc_atomic_duplicate_state,
>  	.atomic_destroy_state	= komeda_crtc_atomic_destroy_state,
>  	.enable_vblank		= komeda_crtc_vblank_enable,
>  	.disable_vblank		= komeda_crtc_vblank_disable,
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
