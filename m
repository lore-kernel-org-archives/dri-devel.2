Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590FAFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5CE10E717;
	Mon, 27 Apr 2026 12:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XGZuSieS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF6210E717
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777292279; x=1808828279;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=u7HpqHCSYbzj/Rkw2TD3M00MU7cou/U1GZMle+xJRck=;
 b=XGZuSieSsd3T124sXqftM5h38mPFGYtgzp+tr+qJM9DMg0oDgEkjS0z2
 syjysOagvlfdQgMaPiNGOdaUhGsje0DATV4MzDQt5VKxoTpKl0LmwhDAc
 aVxWChJ5gPAPJZig7isNbutrm9AVeJqyzIrZc2lceRauevH7SvyaY/JL9
 Nu/K7T6pVmGgjCvZNxTWlDPCXBDIPDFlVWa5Ob3AHSxHBPFw11Gwv+9gw
 s9W8SJR5/XwZzepxcjORWUWb+uMsUbSl6zrm3dsyNod/4Yz70JrL1zr2n
 06q7zUiDEHfe8TZ9/TTrZog733/FHREB5pVnknJ+in0bSGqGoanVS90Xh Q==;
X-CSE-ConnectionGUID: pFya+MclQt62rBrmf/N3yw==
X-CSE-MsgGUID: HaMOJZjoRm2fFuL0ormZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78194629"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="78194629"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:17:58 -0700
X-CSE-ConnectionGUID: /jKsUAWyQyWhSaS0rrxodg==
X-CSE-MsgGUID: rMOeLR8fS2GZdkajpIsdig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="238609033"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:17:56 -0700
Date: Mon, 27 Apr 2026 15:17:53 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, pekka.paalanen@collabora.com, simona@ffwll.ch,
 tzimmermann@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/drm_blend: allow blend mode property without PREMULTI
Message-ID: <ae9T8e6NBaC3z0uH@intel.com>
References: <20260424143513.13004-1-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424143513.13004-1-leandro.ribeiro@collabora.com>
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

On Fri, Apr 24, 2026 at 11:35:13AM -0300, Leandro Ribeiro wrote:
> Some hardware only supports the COVERAGE blend mode and lacks PREMULTI
> support entirely. DRM currently requires that PREMULTI is present when
> creating a blend mode property, which prevents such drivers from being
> properly upstreamed.
> 
> Remove this restriction and allow drivers to create a blend mode
> property without PREMULTI, enabling support for hardware that
> implements only COVERAGE blend mode.
> 
> This does not introduce a regression, as no existing upstream drivers
> expose only COVERAGE. However, userspace that wants to support such kind
> of hardware in the future will have to check the supported blend modes
> instead of assuming PREMULTI is always supported.
> 
> If the driver does not support the blend mode property, userspace must
> assume that only PREMULTI is supported (as was the case before this
> patch).
> 
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> ---
>  drivers/gpu/drm/drm_blend.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 1f3af27d2418..e5015d0fb219 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -563,10 +563,10 @@ EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>  /**
>   * drm_plane_create_blend_mode_property - create a new blend mode property
>   * @plane: drm plane
> - * @supported_modes: bitmask of supported modes, must include
> - *		     BIT(DRM_MODE_BLEND_PREMULTI). Current DRM assumption is
> - *		     that alpha is premultiplied, and old userspace can break if
> - *		     the property defaults to anything else.
> + * @supported_modes: bitmask of supported modes. When
> + *		     BIT(DRM_MODE_BLEND_PREMULTI) is included, it will be used
> + *		     as the default. Otherwise, the default will fallback to one
> + *		     of the supported modes.
>   *
>   * This creates a new property describing the blend mode.
>   *
> @@ -586,6 +586,9 @@ EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>   *	pre-multiplied and will do so when blending them to the background color
>   *	values.
>   *
> + * Note: if the blend mode property is not present, userspace must assume that
> + * the driver supports only "Pre-multiplied".

IMO we shouldn't allow drivers to follow that rule anymore.
What we'd need is an assert that any plane that exposes
formats with alpha also exposes the blend mode property.
That would at least force the drivers to get fixed.

> + *
>   * RETURNS:
>   * Zero for success or -errno
>   */
> @@ -599,13 +602,13 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>  		{ DRM_MODE_BLEND_PREMULTI, "Pre-multiplied" },
>  		{ DRM_MODE_BLEND_COVERAGE, "Coverage" },
>  	};
> +	unsigned int default_mode;
>  	unsigned int valid_mode_mask = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>  				       BIT(DRM_MODE_BLEND_PREMULTI)   |
>  				       BIT(DRM_MODE_BLEND_COVERAGE);
>  	int i;
>  
> -	if (WARN_ON((supported_modes & ~valid_mode_mask) ||
> -		    ((supported_modes & BIT(DRM_MODE_BLEND_PREMULTI)) == 0)))
> +	if (WARN_ON((supported_modes & ~valid_mode_mask)))
>  		return -EINVAL;
>  
>  	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
> @@ -630,7 +633,14 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>  		}
>  	}
>  
> -	drm_object_attach_property(&plane->base, prop, DRM_MODE_BLEND_PREMULTI);
> +	if (supported_modes & BIT(DRM_MODE_BLEND_PREMULTI))
> +		default_mode = DRM_MODE_BLEND_PREMULTI;
> +	else if (supported_modes & BIT(DRM_MODE_BLEND_COVERAGE))
> +		default_mode = DRM_MODE_BLEND_COVERAGE;
> +	else
> +		default_mode = DRM_MODE_BLEND_PIXEL_NONE;
> +
> +	drm_object_attach_property(&plane->base, prop, default_mode);
>  	plane->blend_mode_property = prop;
>  
>  	return 0;
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
