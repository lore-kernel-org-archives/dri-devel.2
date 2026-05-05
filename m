Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F8CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C576310E102;
	Tue,  5 May 2026 07:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bgdzggOc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55CC10E102
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777967852; x=1809503852;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=NCB3YHmAvYTnstuCXubY2SrRns6dsmu8xcOHwMldl+4=;
 b=bgdzggOczyT4Vohr1nkP+ZqN4+RWSAo3sLasvFTcmIUctw2RbMh7FC/V
 rZjPC0fTRrBlCjaleNPcv4s/JxXncf9jnswyRwgGTz9i8tKwOc3ydoAVq
 zvoo1q9RmsUTLz8XhxHJ1TQbUiq7Lvfs+Dw8jGGUDUF5MskkG3EPYgiw5
 ybjjDyI+fp6+CV0DwFxHUuFuLciAJZ/d9m9KXTYuhShrs0EVXFOVZg8+5
 gU9apR7eGTj3gfsUayGCbK1W+sU11sRma+QHlEPI9iWUN8ZXop4YjcbHB
 2uDnBwck+01dXt54GiP62sxLPYPF4wAVVRSE2GkrRZ+fTvrfu8vLFbEXL w==;
X-CSE-ConnectionGUID: 9qHdgRouT9efJ+RCb9neiw==
X-CSE-MsgGUID: JvuU+eSARbKKZz2hQ5tz9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="81394516"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="81394516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 00:57:32 -0700
X-CSE-ConnectionGUID: tAcso0lWSneBXzKqH2ziPw==
X-CSE-MsgGUID: knr+IUz/TYyhWvQH1gQd6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="235825491"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.55])
 by orviesa009-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:57:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniels@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm: ensure blend mode supported if alpha exposed
In-Reply-To: <20260504140630.68707-3-leandro.ribeiro@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260504140630.68707-1-leandro.ribeiro@collabora.com>
 <20260504140630.68707-3-leandro.ribeiro@collabora.com>
Date: Tue, 05 May 2026 10:57:26 +0300
Message-ID: <c150652e3382375deea18c6c2555d5271c9ab8c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, 04 May 2026, Leandro Ribeiro <leandro.ribeiro@collabora.com> wrote:
> Before "drm/drm_blend: allow blend mode property without PREMULTI",
> userspace would have to assume that only PREMULTI was supported by
> drivers that didn't expose the blend mode property. But now userspace
> shouldn't relly on that, as they can't count with drivers always
> supporting PREMULTI.
>
> Error out if a driver expose alpha property or pixel formats with alpha
> and does not expose the blend mode property. This way userspace don't
> have to guess. Drivers that hit such error must be fixed.
>
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> ---
>  drivers/gpu/drm/drm_crtc_internal.h |  1 +
>  drivers/gpu/drm/drm_drv.c           |  7 ++++-
>  drivers/gpu/drm/drm_mode_config.c   | 42 +++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index c09409229644..bdbb6b9b94ea 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -96,6 +96,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
>  int drm_modeset_register_all(struct drm_device *dev);
>  void drm_modeset_unregister_all(struct drm_device *dev);
>  void drm_mode_config_validate(struct drm_device *dev);
> +int drm_mode_config_enforce(struct drm_device *dev);
>  
>  /* drm_modes.c */
>  const char *drm_get_mode_status_name(enum drm_mode_status status);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..76766a370650 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1059,9 +1059,14 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	const struct drm_driver *driver = dev->driver;
>  	int ret;
>  
> -	if (!driver->load)
> +	if (!driver->load) {
>  		drm_mode_config_validate(dev);
>  
> +		ret = drm_mode_config_enforce(dev);

Reading the code, I'll have no idea what "enforce" means here. Reading
the function itself isn't helping either.

BR,
Jani.


> +		if (ret)
> +			return ret;
> +	}
> +
>  	WARN_ON(!dev->managed.final_kfree);
>  
>  	if (drm_dev_needs_global_mutex(dev))
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 66f7dc37b597..20fd26ecb957 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -738,3 +738,45 @@ void drm_mode_config_validate(struct drm_device *dev)
>  	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
>  	     num_primary, dev->mode_config.num_crtc);
>  }
> +
> +static int plane_require_blend_mode_for_alpha(struct drm_plane *plane)
> +{
> +	struct drm_device *dev = plane->dev;
> +	const struct drm_format_info *fmt;
> +	u32 i;
> +
> +	/* blend mode property supported, no need to check anything */
> +	if (plane->blend_mode_property)
> +		return 0;
> +
> +	if (plane->alpha_property) {
> +		drm_err(dev, "[PLANE:%d:%s] alpha property exposed but blend mode not setup",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < plane->format_count; i++) {
> +		fmt = drm_format_info(plane->format_types[i]);
> +		if (fmt->has_alpha) {
> +			drm_err(dev, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
> +			        plane->base.id, plane->name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int drm_mode_config_enforce(struct drm_device *dev)
> +{
> +	struct drm_plane *plane;
> +	int ret;
> +
> +	drm_for_each_plane(plane, dev) {
> +		ret = plane_require_blend_mode_for_alpha(plane);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
Jani Nikula, Intel
