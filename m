Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300F7CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 17:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013C310E7BD;
	Mon,  4 May 2026 17:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JzbQ7tJZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29E810E7B3;
 Mon,  4 May 2026 17:29:01 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 090C98F;
 Mon,  4 May 2026 19:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777915738;
 bh=rivBCjMAfflXwt1qFSOeJbPBfqzxRqu5f/V7lLMrAdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JzbQ7tJZxf25NmYoqnYYam36yrgF5W1S0esLviwPX3bd/5Mc0bFy+PH/bRQ4stv3S
 FBdYYCtlb6xIQKkVEDz1oVs7DUsA4p5Kd6S8crYGwbHzx8bQXSE0xvoX3ShNrz9HWC
 l1Y5cDT3YyIXLT/QrM/SKMW47xH1ATHdciNqvkps=
Date: Mon, 4 May 2026 20:28:58 +0300
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
Subject: Re: [PATCH v3 12/20] drm/crtc: Add new atomic_create_state callback
Message-ID: <20260504172858.GO1344263@killaraus.ideasonboard.com>
References: <20260424-drm-mode-config-init-v3-0-8b68d9db0d8b@kernel.org>
 <20260424-drm-mode-config-init-v3-12-8b68d9db0d8b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424-drm-mode-config-init-v3-12-8b68d9db0d8b@kernel.org>
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

On Fri, Apr 24, 2026 at 12:18:52PM +0200, Maxime Ripard wrote:
> Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> to drm_private_obj") introduced a new pattern for allocating drm object
> states.
> 
> Instead of relying on the reset() callback, it created a new
> atomic_create_state hook. This is helpful because reset is a bit
> overloaded: it's used to create the initial software state, reset it,
> but also reset the hardware.
> 
> It can also be used either at probe time, to create the initial state
> and possibly reset the hardware to an expected default, but also during
> suspend/resume.
> 
> Both these cases come with different expectations too: during the
> initialization, we want to initialize all states, but during
> suspend/resume, drm_private_states for example are expected to be kept
> around.
> 
> reset() also isn't fallible, which makes it harder to handle
> initialization errors properly. This is only really relevant for some
> drivers though, since all the helpers for reset only create a new
> state, and don't touch the hardware at all.
> 
> It was thus decided to create a new hook that would allocate and
> initialize a pristine state without any side effect:
> atomic_create_state to untangle a bit some of it, and to separate the
> initialization with the actual reset one might need during a
> suspend/resume.
> 
> Continue the transition to the new pattern with CRTCs.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 47 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c         | 21 +++++++++++++-
>  include/drm/drm_atomic_state_helper.h     |  4 +++
>  include/drm/drm_crtc.h                    | 16 +++++++++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 9cd8550cabb7..b7da134c8c50 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -103,10 +103,32 @@ __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
>  
>  	crtc->state = crtc_state;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_crtc_reset);
>  
> +/**
> + * __drm_atomic_helper_crtc_create_state - initializes crtc state

"Initialize a CRTC state"

The name of the function is misleading ("*_create_*" while you state it
performs initialization).

> + * @crtc: crtc object
> + * @state: new state to initialize
> + *
> + * Initializes the newly allocated @state, usually required when
> + * initializing the drivers.
> + *
> + * @state is assumed to be zeroed.
> + *
> + * This is useful for drivers that subclass @drm_crtc_state.
> + */
> +void __drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc,
> +					   struct drm_crtc_state *state)
> +{
> +	__drm_atomic_helper_crtc_state_init(state, crtc);
> +
> +	if (drm_dev_has_vblank(crtc->dev))
> +		drm_crtc_vblank_reset(crtc);

This is confusing to me (at least before reading the rest of the
series), and itn't mentioned in the function documentation or in the
commit message.

Furthermore, __drm_atomic_helper_crtc_create_state() is later used in
tidss_crtc_create_state(), which is the
drm_crtc_funcs.atomic_create_state() implementation of the tidss driver.
The atomic_create_state documentation states that "This callback must
have no side effect", and drm_crtc_vblank_reset() has side effects.

> +}
> +EXPORT_SYMBOL(__drm_atomic_helper_crtc_create_state);
> +
>  /**
>   * drm_atomic_helper_crtc_reset - default &drm_crtc_funcs.reset hook for CRTCs
>   * @crtc: drm CRTC
>   *
>   * Resets the atomic state for @crtc by freeing the state pointer (which might
> @@ -122,10 +144,35 @@ void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc)
>  
>  	__drm_atomic_helper_crtc_reset(crtc, crtc_state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_crtc_reset);
>  
> +/**
> + * drm_atomic_helper_crtc_create_state - default &drm_crtc_funcs.atomic_create_state hook for crtcs

Same comment as in patch 10/20.

> + * @crtc: crtc object
> + *
> + * Initializes a pristine @drm_crtc_state.

"Allocate and initialize ..."

> + *
> + * This is useful for drivers that don't subclass @drm_crtc_state.
> + *
> + * RETURNS:
> + * Pointer to new crtc state, or ERR_PTR on failure.
> + */
> +struct drm_crtc_state *drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc)
> +{
> +	struct drm_crtc_state *state;
> +
> +	state = kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_crtc_create_state(crtc, state);
> +
> +	return state;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_crtc_create_state);
> +
>  /**
>   * __drm_atomic_helper_crtc_duplicate_state - copy atomic CRTC state
>   * @crtc: CRTC object
>   * @state: atomic CRTC state
>   *
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 10b7815cbe48..182d9a8104e7 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -196,10 +196,26 @@ static int drm_mode_config_plane_create_state(struct drm_plane *plane)
>  	plane->state = plane_state;
>  
>  	return 0;
>  }
>  
> +static int drm_mode_config_crtc_create_state(struct drm_crtc *crtc)
> +{
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!crtc->funcs->atomic_create_state)
> +		return 0;
> +
> +	crtc_state = crtc->funcs->atomic_create_state(crtc);
> +	if (IS_ERR(crtc_state))
> +		return PTR_ERR(crtc_state);
> +
> +	crtc->state = crtc_state;
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_mode_config_reset - call ->reset callbacks
>   * @dev: drm device
>   *
>   * This functions calls all the crtc's, encoder's and connector's ->reset
> @@ -227,13 +243,16 @@ void drm_mode_config_reset(struct drm_device *dev)
>  			plane->funcs->reset(plane);
>  		else if (plane->funcs->atomic_create_state)
>  			drm_mode_config_plane_create_state(plane);
>  	}
>  
> -	drm_for_each_crtc(crtc, dev)
> +	drm_for_each_crtc(crtc, dev) {
>  		if (crtc->funcs->reset)
>  			crtc->funcs->reset(crtc);
> +		else if (crtc->funcs->atomic_create_state)
> +			drm_mode_config_crtc_create_state(crtc);
> +	}
>  
>  	drm_for_each_encoder(encoder, dev)
>  		if (encoder->funcs && encoder->funcs->reset)
>  			encoder->funcs->reset(encoder);
>  
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index e7fbbfdc5d69..129762b99de6 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -43,10 +43,14 @@ struct drm_device;
>  void __drm_atomic_helper_crtc_state_init(struct drm_crtc_state *state,
>  					  struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *state);
>  void drm_atomic_helper_crtc_reset(struct drm_crtc *crtc);
> +void __drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc,
> +					   struct drm_crtc_state *state);
> +struct drm_crtc_state *
> +drm_atomic_helper_crtc_create_state(struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc,
>  					      struct drm_crtc_state *state);
>  struct drm_crtc_state *
>  drm_atomic_helper_crtc_duplicate_state(struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_destroy_state(struct drm_crtc_state *state);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 312fc1e745d2..41ea6eadf36f 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -636,10 +636,26 @@ struct drm_crtc_funcs {
>  	 * 0 on success or a negative error code on failure.
>  	 */
>  	int (*set_property)(struct drm_crtc *crtc,
>  			    struct drm_property *property, uint64_t val);
>  
> +	/**
> +	 * @atomic_create_state:
> +	 *
> +	 * Allocates a pristine, initialized, state for the CRTC object

s/Allocates/Allocate/

> +	 * and returns it. This callback must have no side effects: in
> +	 * particular, the returned state must not be assigned to the
> +	 * object's state pointer and it must not affect the hardware
> +	 * state.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * A new, pristine, CRTC state instance or an error pointer
> +	 * on failure.
> +	 */
> +	struct drm_crtc_state *(*atomic_create_state)(struct drm_crtc *crtc);
> +
>  	/**
>  	 * @atomic_duplicate_state:
>  	 *
>  	 * Duplicate the current atomic state for this CRTC and return it.
>  	 * The core and helpers guarantee that any atomic state duplicated with

-- 
Regards,

Laurent Pinchart
