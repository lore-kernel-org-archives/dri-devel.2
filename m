Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467ADFF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 16:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023910E3EB;
	Mon,  4 May 2026 16:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CvpwrU2Z";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B85010E3EB;
 Mon,  4 May 2026 16:53:34 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4904D9C;
 Mon,  4 May 2026 18:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777913611;
 bh=+EZl9qZ81AdPzkkEwOpCoiOGzDn6NE5XspISBAQ0FQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CvpwrU2ZVuvJEMaGn/PmoNDMHJ4B3SbUdj8uAZYFJFB4/dGDtzcjF75/LvVQ5YzAC
 RIfuJ0A5tkqa40FdmOa+pVb3ieNpgSDKRNch8yvbU7lZ/WZeC7JAT/BYdlOHosaoI3
 2uLpdybBMGCQTjbhn81cN5aCxRU9TN2Zq1AFa1Oo=
Date: Mon, 4 May 2026 19:53:32 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Alex Hung <alex.hung@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 11/20] drm/atomic-state-helper: Rename
 __drm_atomic_helper_crtc_state_reset()
Message-ID: <20260504165332.GN1344263@killaraus.ideasonboard.com>
References: <20260424-drm-mode-config-init-v3-0-8b68d9db0d8b@kernel.org>
 <20260424-drm-mode-config-init-v3-11-8b68d9db0d8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424-drm-mode-config-init-v3-11-8b68d9db0d8b@kernel.org>
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

On Fri, Apr 24, 2026 at 12:18:51PM +0200, Maxime Ripard wrote:
> __drm_atomic_helper_crtc_state_reset() is used to initialize a newly
> allocated drm_crtc_state, and is being typically called by the
> drm_crtc_funcs.reset implementation.
> 
> Since we want to consolidate DRM objects state allocation around the
> atomic_create_state callback that will only allocate and initialize a
> new drm_crtc_state instance, we will need to call
> __drm_atomic_helper_crtc_state_reset() from both the reset and
> atomic_create hooks.
> 
> To avoid any confusion, we can thus rename
> __drm_atomic_helper_crtc_state_reset() to
> __drm_atomic_helper_crtc_state_init().
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 10 +++++-----
>  drivers/gpu/drm/i915/display/intel_crtc.c |  2 +-
>  include/drm/drm_atomic_state_helper.h     |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 50fe4eec41a8..9cd8550cabb7 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -61,25 +61,25 @@
>   * For other drivers the building blocks are split out, see the documentation
>   * for these functions.
>   */
>  
>  /**
> - * __drm_atomic_helper_crtc_state_reset - reset the CRTC state
> + * __drm_atomic_helper_crtc_state_init - Initializes the CRTC state

"Initialize"

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>   * @crtc_state: atomic CRTC state, must not be NULL
>   * @crtc: CRTC object, must not be NULL
>   *
>   * Initializes the newly allocated @crtc_state with default
>   * values. This is useful for drivers that subclass the CRTC state.
>   */
>  void
> -__drm_atomic_helper_crtc_state_reset(struct drm_crtc_state *crtc_state,
> -				     struct drm_crtc *crtc)
> +__drm_atomic_helper_crtc_state_init(struct drm_crtc_state *crtc_state,
> +				    struct drm_crtc *crtc)
>  {
>  	crtc_state->crtc = crtc;
>  	crtc_state->background_color = DRM_ARGB64_PREP(0xffff, 0, 0, 0);
>  }
> -EXPORT_SYMBOL(__drm_atomic_helper_crtc_state_reset);
> +EXPORT_SYMBOL(__drm_atomic_helper_crtc_state_init);
>  
>  /**
>   * __drm_atomic_helper_crtc_reset - reset state on CRTC
>   * @crtc: drm CRTC
>   * @crtc_state: CRTC state to assign
> @@ -94,11 +94,11 @@ EXPORT_SYMBOL(__drm_atomic_helper_crtc_state_reset);
>  void
>  __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
>  			       struct drm_crtc_state *crtc_state)
>  {
>  	if (crtc_state)
> -		__drm_atomic_helper_crtc_state_reset(crtc_state, crtc);
> +		__drm_atomic_helper_crtc_state_init(crtc_state, crtc);
>  
>  	if (drm_dev_has_vblank(crtc->dev))
>  		drm_crtc_vblank_reset(crtc);
>  
>  	crtc->state = crtc_state;
> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
> index b8189cd5d864..a2ed4a76e061 100644
> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> @@ -179,11 +179,11 @@ struct intel_crtc_state *intel_crtc_state_alloc(struct intel_crtc *crtc)
>  void intel_crtc_state_reset(struct intel_crtc_state *crtc_state,
>  			    struct intel_crtc *crtc)
>  {
>  	memset(crtc_state, 0, sizeof(*crtc_state));
>  
> -	__drm_atomic_helper_crtc_state_reset(&crtc_state->uapi, &crtc->base);
> +	__drm_atomic_helper_crtc_state_init(&crtc_state->uapi, &crtc->base);
>  
>  	crtc_state->cpu_transcoder = INVALID_TRANSCODER;
>  	crtc_state->master_transcoder = INVALID_TRANSCODER;
>  	crtc_state->hsw_workaround_pipe = INVALID_PIPE;
>  	crtc_state->scaler_state.scaler_id = -1;
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index df371b2eef3e..e7fbbfdc5d69 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -38,11 +38,11 @@ struct drm_connector_state;
>  struct drm_private_obj;
>  struct drm_private_state;
>  struct drm_modeset_acquire_ctx;
>  struct drm_device;
>  
> -void __drm_atomic_helper_crtc_state_reset(struct drm_crtc_state *state,
> +void __drm_atomic_helper_crtc_state_init(struct drm_crtc_state *state,
>  					  struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *state);
>  void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,

-- 
Regards,

Laurent Pinchart
