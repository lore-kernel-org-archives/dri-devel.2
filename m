Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA8F33806
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9801F10E33E;
	Tue, 17 Mar 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AxNuCHOX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3726410E33E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773730830; x=1805266830;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=b5PhsqhAXOYswCLGJkKFJNFv2TuhUjxWSaUU9dG1HCg=;
 b=AxNuCHOXB7KddmAzti9Z9VlfR21141DlaclF83ccw+J9RPXLIBAdR/5t
 Jdopu03MlxK6RwJtEh0LEsAfPhfEh2X6xl/d00h/SAaFgu+Q9CEwSs91w
 CRBhk9ArxIK6W9jbRwNOifJdbHUAbpstORSep1XaO9HE/3MUSetx7HEyK
 ho6Vy5h8qCVy2hYEbRQGW/WcAT7juYEPOzTZnJ0ZvTvGwnznH8lG1RISg
 XmO7BVsSlVzq9LT0v3pFaJgruCOPRmS8/YAiwsWtJtdE5/mtRtrGaFuef
 usiRzfUWWi37sQjd3TKPRrqWLKA3MfY8aEspGCBllLDornD92CvAqzTt8 g==;
X-CSE-ConnectionGUID: KJ3nP1q6TwuiKPcltSwXzw==
X-CSE-MsgGUID: fw865ViqQfueT/iPD+Q25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="92137547"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="92137547"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 00:00:29 -0700
X-CSE-ConnectionGUID: w5y3+OfLQm+TgvgjYCUF7w==
X-CSE-MsgGUID: X23hVS9aTdqQ1h2r+5VgEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221198127"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.99])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 00:00:27 -0700
Date: Tue, 17 Mar 2026 09:00:24 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Austin Hu <austin.hu@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robin.clark@oss.qualcomm.com
Subject: Re: [PATCH] drm/atomic: clear the state of plane which is unused.
Message-ID: <abj79EU0bMEkcSD3@intel.com>
References: <20260316225507.392191-1-austin.hu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316225507.392191-1-austin.hu@intel.com>
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

On Mon, Mar 16, 2026 at 03:55:07PM -0700, Austin Hu wrote:
> Some libdrm user mode apps (including compositor) disable unused
> plane with its previously binded CRTC or frame buffer object, but
> may not reset its properties like src/dst coordinates, so that some
> values of the unused plane state would be sticky. And even with
> some Display Engine IP like Intel, a plane disabled from user mode
> in current frame may be linked with another plane (e.g. to DMA Y or
> UV semi-planar buffer) in KMD driver, so that its sticky UAPI
> settings mismatch with the ones programmed to registers.
> 
> So clear the unused plane state during each atomic commit, to make
> sure each plane state is up to date. This change might be
> unnecessary if user mode already clears plane property, but keep it
> just in case.

The kernel isn't allowed to magically change the value of
properties set by userspace, apart from a few special cases.

No idea what you're actually trying to fix here, but sounds
like your userspace might be broken and needs to be fixed.

> 
> Signed-off-by: Austin Hu <austin.hu@intel.com>
> ---
>  drivers/gpu/drm/drm_atomic.c | 62 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index dd9f27cfe991..0ce57e540a86 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -690,6 +690,59 @@ plane_switching_crtc(const struct drm_plane_state *old_plane_state,
>  	return true;
>  }
>  
> +/**
> + * drm_atomic_plane_state_reset - reset plane state
> + * @plane: plane to reset
> + * @plane_state: plane state to reset
> + *
> + * This function resets the plane state to its default values, after
> + * the plane is disabled or when the plane state is no longer valid.
> + */
> +static int drm_atomic_plane_state_reset(struct drm_plane *plane,
> +				      struct drm_plane_state *plane_state)
> +{
> +	int ret;
> +
> +	ret = drm_atomic_set_crtc_for_plane(plane_state, NULL);
> +	if (ret != 0)
> +		return ret;
> +
> +	drm_atomic_set_fb_for_plane(plane_state, NULL);
> +
> +	plane_state->crtc_x = 0;
> +	plane_state->crtc_y = 0;
> +	plane_state->crtc_w = 0;
> +	plane_state->crtc_h = 0;
> +	plane_state->src_x = 0;
> +	plane_state->src_y = 0;
> +	plane_state->src_w = 0;
> +	plane_state->src_h = 0;
> +
> +	plane_state->alpha = 0;
> +	plane_state->pixel_blend_mode = 0;
> +	plane_state->rotation = 0;
> +	plane_state->zpos = 0;
> +	plane_state->color_encoding = 0;
> +	plane_state->color_range = 0;
> +
> +	drm_atomic_set_colorop_for_plane(plane_state, NULL);
> +
> +	bool replaced = false;
> +
> +	ret = drm_property_replace_blob_from_id(
> +		plane->dev, &plane_state->fb_damage_clips, 0, -1, -1,
> +		sizeof(struct drm_mode_rect), &replaced);
> +	if (ret)
> +		return ret;
> +
> +	plane_state->scaling_filter = 0;
> +	plane_state->hotspot_x = 0;
> +	plane_state->hotspot_y = 0;
> +	plane_state->visible = false;
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_atomic_plane_check - check plane state
>   * @old_plane_state: old plane state to check
> @@ -701,7 +754,7 @@ plane_switching_crtc(const struct drm_plane_state *old_plane_state,
>   * Zero on success, error code on failure
>   */
>  static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
> -				  const struct drm_plane_state *new_plane_state)
> +				  struct drm_plane_state *new_plane_state)
>  {
>  	struct drm_plane *plane = new_plane_state->plane;
>  	struct drm_crtc *crtc = new_plane_state->crtc;
> @@ -721,9 +774,12 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>  		return -EINVAL;
>  	}
>  
> -	/* if disabled, we don't care about the rest of the state: */
> +	/*
> +	 * if disabled, we don't care about the rest of the state:
> +	 * but clear the plane state.
> +	 */
>  	if (!crtc)
> -		return 0;
> +		return drm_atomic_plane_state_reset(plane, new_plane_state);
>  
>  	/* Check whether this plane is usable on this CRTC */
>  	if (!(plane->possible_crtcs & drm_crtc_mask(crtc))) {
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
