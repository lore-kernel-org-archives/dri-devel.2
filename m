Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8B4F53D6E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58B810E261;
	Mon, 16 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q8TCCGfb";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C6810E261
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 16:32:19 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id D7FDCB1A;
 Mon, 16 Mar 2026 17:31:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773678667;
 bh=VEWzjWkFJkvivdxzozBb+TjD4Z2NHTQj8mjnk16uEwg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q8TCCGfbSVarEprvUIY784Y6vJRSh26EoCv98Fy15dw78xwgxX4lMY76EHkJKEx4G
 Xwaf5H8gdPxcfNUot446XQVG7cR4Xtb5DHZU5lgDyeOmiCtLtygFRHGpskKS8WNWnD
 vJGfIRulunUJ533ll/eTI365rzUHoAhBqUDjnPzc=
Date: Mon, 16 Mar 2026 18:32:16 +0200
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
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] drm/mode-config: Create
 drm_mode_config_create_state()
Message-ID: <20260316163216.GM31604@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-8-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-8-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:07:00PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() can be used to create the initial state, but
> also to return to the initial state, when doing a suspend/resume cycle
> for example.
> 
> It also affects both the software and the hardware, and drivers can
> either choose to reset the hardware as well. Most will just create an

"either" requires an "or".

> empty state and the synchronisation between hardware and software states
> will effectively be done when the first commit is done.
> 
> That dual role can be harmful, since some objects do need to be
> initialized but also need to be preserved across a suspend/resume cycle.
> drm_private_obj are such objects for example.
> 
> Thus, let's create another helper for drivers to call to initialize
> their state when the driver is loaded, so we can make
> drm_mode_config_reset() only about handling suspend/resume and similar.

Does that mean that the state initialization at probe time from the
hardware state is planned to be handled by .atomic_create_state() ?

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c      | 12 +++++-
>  drivers/gpu/drm/drm_mode_config.c | 83 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_mode_config.h     |  1 +
>  3 files changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 92c6afc8f22c8307a59dc266aacdb8e03351409d..d1885f895cce78725419b6291f4dbe5563e3b240 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -58,12 +58,20 @@
>   * checking or doing the update, while object states are allocated while
>   * the state will be, or is active in the hardware.
>   *
>   * Their respective lifetimes are:
>   *
> - * - at reset time, the object reset implementation will allocate a new,
> - *   default, state and will store it in the object state pointer.
> + * - at driver initialization time, the driver will allocate an initial,
> + *   pristine, state and will store it using
> + *   drm_mode_config_create_state(). Historically, this was one of
> + *   drm_mode_config_reset() job, so one might still encounter it in a
> + *   driver.

Do you have plans to port drivers to the new API, to drop this last
sentence sooner than later ?

> + *
> + * - at reset time, for example during suspend/resume,
> + *   drm_mode_config_reset() will reset the software and hardware state
> + *   to a known default and will store it in the object state pointer.
> + *   Not all objects are affected by drm_mode_config_reset() though.

I have a bit of trouble understanding the design. How can
drm_mode_config_reset() decide which objects should have their state
reset (i.e. all objects but private objects in the current
implementation), shouldn't that be a driver decision ?

>   *
>   * - whenever a new update is needed:
>   *
>   *   + we allocate a new &struct drm_atomic_state using drm_atomic_state_alloc().
>   *
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 95759a4b5176ff17032a9a267ec9de6980be0abc..1a84ac063d381014eb8afd7116e1e8b7a8fc92ca 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -21,10 +21,11 @@
>   */
>  
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
>  
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_managed.h>
> @@ -278,10 +279,92 @@ void drm_mode_config_reset(struct drm_device *dev)
>  			drm_mode_config_connector_create_state(connector);
>  	drm_connector_list_iter_end(&conn_iter);
>  }
>  EXPORT_SYMBOL(drm_mode_config_reset);
>  
> +/**
> + * drm_mode_config_create_state - Allocates the initial state
> + * @dev: drm device
> + *
> + * This functions creates the initial state for all the objects. Drivers
> + * can use this in e.g. their driver load to initialize its software

I think you meant s/its/their/

> + * state.
> + *
> + * It has two main differences with drm_mode_config_reset(): the reset()
> + * hooks aren't called and thus the hardware will be left untouched, but
> + * also the @drm_private_obj structures will be initialized as opposed
> + * to drm_mode_config_reset() that skips them.
> + *
> + * Returns: 0 on success, negative error value on failure.
> + */
> +int drm_mode_config_create_state(struct drm_device *dev)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_colorop *colorop;
> +	struct drm_plane *plane;
> +	struct drm_connector *connector;
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_private_obj *privobj;
> +	int ret;
> +
> +	drm_for_each_privobj(privobj, dev) {
> +		struct drm_private_state *privobj_state;
> +
> +		if (privobj->state)
> +			continue;
> +
> +		if (!privobj->funcs->atomic_create_state)
> +			continue;
> +
> +		privobj_state = privobj->funcs->atomic_create_state(privobj);
> +		if (IS_ERR(privobj_state))
> +			return PTR_ERR(privobj_state);
> +
> +		privobj->state = privobj_state;

Either a helper function is missing, or you forgot to call it.

> +	}
> +
> +	drm_for_each_colorop(colorop, dev) {
> +		if (colorop->state)
> +			continue;
> +
> +		// TODO: Implement atomic_create_state for colorop.

Oops :-)

> +		drm_colorop_reset(colorop);
> +	}
> +
> +	drm_for_each_plane(plane, dev) {
> +		if (plane->state)
> +			continue;
> +
> +		ret = drm_mode_config_plane_create_state(plane);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		if (crtc->state)
> +			continue;
> +
> +		ret = drm_mode_config_crtc_create_state(crtc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	drm_connector_list_iter_begin(dev, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		if (connector->state)
> +			continue;
> +
> +		ret = drm_mode_config_connector_create_state(connector);
> +		if (ret)
> +			return ret;
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_mode_config_create_state);
> +
>  /*
>   * Global properties
>   */
>  static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
>  	{ DRM_PLANE_TYPE_OVERLAY, "Overlay" },
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 5e1dd0cfccde2d2bc00a09e98e4adc65833dad08..428ae75b7c4f193dfbd49c15a2f2ef32209a6cef 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -1000,9 +1000,10 @@ int __must_check drmm_mode_config_init(struct drm_device *dev);
>  static inline int drm_mode_config_init(struct drm_device *dev)
>  {
>  	return drmm_mode_config_init(dev);
>  }
>  
> +int drm_mode_config_create_state(struct drm_device *dev);
>  void drm_mode_config_reset(struct drm_device *dev);
>  void drm_mode_config_cleanup(struct drm_device *dev);
>  
>  #endif
> 

-- 
Regards,

Laurent Pinchart
