Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1656FCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 18:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E5010E288;
	Fri, 22 May 2026 18:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VaoEA6Eg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A76D10E288
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779474282; x=1811010282;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ttG915SHcKi6dZnXm0ZZK6xbc8yqyrLEeSINwfytnAI=;
 b=VaoEA6EgQDcTDfwNZiGTXk0sdfI+nTxdWW7Nt4zsfYTYu5cPVaybSfi7
 /LQreJPaPGx9SH4EG/CmxDHdi4PD8iMMVKUbCMGhIBEHgyOFLyxkkV8M8
 Drvr3LD4gGZZzhcqFxePI7NPo9VyShi+gSpc1ihF56+StTcPCnaJI6Xf5
 qlDpdZQqjBGGSJrHL7WaAYev9Bb7l329M5jYRCLLVdlYhuxOR7fwX3tU6
 t9kOcILmvdXPyvgswv8zpdNwZS5ZO+1zCnQa/Tl95nO7C2qo5QgOP7GpF
 eV9wlpUVPLWCR07yFNpiVip5GzvqHs8AivSzXpFApA5jaq2rWgV+pSl8f g==;
X-CSE-ConnectionGUID: YySyUCm4QWySgOlFHSMd8g==
X-CSE-MsgGUID: hNPak6nMTlqcfF1OSQKO2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="67934940"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="67934940"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 11:24:42 -0700
X-CSE-ConnectionGUID: EB381szPTM6FueON0d7NNw==
X-CSE-MsgGUID: o+jqMJwmSQCUroU8ieIM9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="240148436"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by orviesa010-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 11:24:39 -0700
Date: Fri, 22 May 2026 21:24:35 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, tzimmermann@suse.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm: ensure blend mode supported if alpha exposed
Message-ID: <ahCfY3RXV2l-fZda@intel.com>
References: <20260518175429.80615-1-leandro.ribeiro@collabora.com>
 <20260518175429.80615-3-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518175429.80615-3-leandro.ribeiro@collabora.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Mon, May 18, 2026 at 02:54:29PM -0300, Leandro Ribeiro wrote:
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
>  drivers/gpu/drm/drm_crtc_internal.h |  2 +-
>  drivers/gpu/drm/drm_drv.c           |  7 ++++--
>  drivers/gpu/drm/drm_mode_config.c   | 37 +++++++++++++++++++++++++++--
>  3 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index c09409229644..2a4862202496 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -95,7 +95,7 @@ int drm_mode_setcrtc(struct drm_device *dev,
>  /* drm_mode_config.c */
>  int drm_modeset_register_all(struct drm_device *dev);
>  void drm_modeset_unregister_all(struct drm_device *dev);
> -void drm_mode_config_validate(struct drm_device *dev);
> +int drm_mode_config_validate(struct drm_device *dev);
>  
>  /* drm_modes.c */
>  const char *drm_get_mode_status_name(enum drm_mode_status status);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..def78046a963 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1059,8 +1059,11 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	const struct drm_driver *driver = dev->driver;
>  	int ret;
>  
> -	if (!driver->load)
> -		drm_mode_config_validate(dev);
> +	if (!driver->load) {
> +		ret = drm_mode_config_validate(dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	WARN_ON(!dev->managed.final_kfree);
>  
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 66f7dc37b597..18c6b5707532 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -674,16 +674,45 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
>  	     encoder->possible_crtcs, crtc_mask);
>  }
>  
> -void drm_mode_config_validate(struct drm_device *dev)
> +static int plane_alpha_require_blend_mode(struct drm_plane *plane)
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

Why this? I don't think the constant alpha property has anything
really to do with the per-pixel alpha stuff.

> +
> +	for (i = 0; i < plane->format_count; i++) {
> +		fmt = drm_format_info(plane->format_types[i]);
> +		if (fmt->has_alpha) {
> +			drm_err(dev, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not setup",
> +				plane->base.id, plane->name);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int drm_mode_config_validate(struct drm_device *dev)
>  {
>  	struct drm_encoder *encoder;
>  	struct drm_crtc *crtc;
>  	struct drm_plane *plane;
>  	u32 primary_with_crtc = 0, cursor_with_crtc = 0;
>  	unsigned int num_primary = 0;
> +	int ret = 0;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
> -		return;
> +		return ret;
>  
>  	drm_for_each_encoder(encoder, dev)
>  		fixup_encoder_possible_clones(encoder);
> @@ -732,9 +761,13 @@ void drm_mode_config_validate(struct drm_device *dev)
>  	drm_for_each_plane(plane, dev) {
>  		if (plane->type == DRM_PLANE_TYPE_PRIMARY)
>  			num_primary++;
> +
> +		ret |= plane_alpha_require_blend_mode(plane);
>  	}
>  
>  	WARN(num_primary != dev->mode_config.num_crtc,
>  	     "Must have as many primary planes as there are CRTCs, but have %u primary planes and %u CRTCs",
>  	     num_primary, dev->mode_config.num_crtc);
> +
> +	return ret;
>  }
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
