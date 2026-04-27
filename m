Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B59EFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F1F10E738;
	Mon, 27 Apr 2026 12:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nkfr8++g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB6710E738;
 Mon, 27 Apr 2026 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777294656; x=1808830656;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cCiLphqh+GKqYvGtfm6RLDEsTl/4FzO4LwaMw/xLVo8=;
 b=Nkfr8++gFxNGjroZqbIykSdTLsYGALAfgC6wbXQYmrwqTH5lNnl1i+f9
 6Ie36Q7CRhM44h7mtM96dqg+tZoXUaBC/vTmc5GtD3cG18/aXZjf6TvoW
 nsn2SvZVhRHmcTBFJdzdGsrnwMiUmDxtebPOtHRzDsXcQ45PNX/tFdc1m
 nsvsYiGn9MXa7HNCLMEgeXB724n1DdD0B7ChZEp8FELWp6PFGRYc40HSO
 8kX1bd5NeYYtR6JpzKzPh1GaAwnOat3ekTbdfpiEwc6lZoj9jtcj1i29L
 ltcqQG+FjJOJYrqrpA43tpmMQDa9fYHPPZk04C3NN0YToqj+89bOImyae Q==;
X-CSE-ConnectionGUID: tdavpIuYRvuVoUanyJanHQ==
X-CSE-MsgGUID: nlJOe1r4RBOJnt41w2R+QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78238260"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="78238260"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:57:35 -0700
X-CSE-ConnectionGUID: XKze5CtiSIywP4L9TzjX3A==
X-CSE-MsgGUID: 0ZnIkWffR1if9COV3lAVYw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:57:34 -0700
Date: Mon, 27 Apr 2026 15:57:30 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH 6/7] drm/dp: Add a helper to get the SDP type as a
 string
Message-ID: <ae9dOtRS577Ow7uE@intel.com>
References: <20260424093424.3060805-1-ankit.k.nautiyal@intel.com>
 <20260424093424.3060805-7-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424093424.3060805-7-ankit.k.nautiyal@intel.com>
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

On Fri, Apr 24, 2026 at 03:04:23PM +0530, Ankit Nautiyal wrote:
> Introduce dp_sdp_type_get_name() to get the SDP type as a string.
> Use this to log the SDP type based on the sdp_type fields of the
> VSC and AS SDPs instead of the hardcoded strings.
> 
> While at it, rename "SDP : AS_SDP" to "SDP : Adaptive Sync"
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 36 ++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index e29958f8b0b6..102328d9022d 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3487,10 +3487,38 @@ static const char *dp_content_type_get_name(enum dp_content_type content_type)
>  	}
>  }
>  
> +static const char *dp_sdp_type_get_name(unsigned char type)

I dislike this "_get_" stuff in the name. It's redundant, and can be
confused with some refcounting related get/put. I really wish people
would stop using it...

But looks like all the other similar things here already use the "_get_"
naming, so I guess we should stick to a consistent style for now.

> +{
> +	switch (type) {
> +	case DP_SDP_AUDIO_TIMESTAMP:
> +		return "Audio Timestamp";

"Audio_TimeStamp" to match the spec.

> +	case DP_SDP_AUDIO_STREAM:
> +		return "Audio Stream";

"Audio_Stream"

> +	case DP_SDP_EXTENSION:
> +		return "Extension";
> +	case DP_SDP_AUDIO_COPYMANAGEMENT:
> +		return "Audio Copy Management";

"Audio_CopyManagement"

> +	case DP_SDP_ISRC:
> +		return "ISRC";
> +	case DP_SDP_VSC:
> +		return "VSC";
> +	case DP_SDP_PPS:
> +		return "PPS";
> +	case DP_SDP_VSC_EXT_VESA:
> +		return "VSC EXT VESA";
> +	case DP_SDP_VSC_EXT_CEA:
> +		return "VSC EXT CEA";

Looks like the spec does favor the acronym form for all of
those. So I guess that's what we want here as well. The ' '
should all be '_' to match the spec though.

> +	case DP_SDP_ADAPTIVE_SYNC:
> +		return "Adaptive Sync";

"Adaptive-Sync" seems to be the preferred form for this
in the spec.

> +	default:
> +		return "Unknown";
> +	}
> +}
> +
>  void drm_dp_vsc_sdp_log(struct drm_printer *p, const struct drm_dp_vsc_sdp *vsc)
>  {
> -	drm_printf(p, "DP SDP: VSC, revision %u, length %u\n",
> -		   vsc->revision, vsc->length);
> +	drm_printf(p, "DP SDP: %s, revision %u, length %u\n",
> +		   dp_sdp_type_get_name(vsc->sdp_type), vsc->revision, vsc->length);
>  	drm_printf(p, "    pixelformat: %s\n",
>  		   dp_pixelformat_get_name(vsc->pixelformat));
>  	drm_printf(p, "    colorimetry: %s\n",
> @@ -3505,8 +3533,8 @@ EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
>  
>  void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp)
>  {
> -	drm_printf(p, "DP SDP: AS_SDP, revision %u, length %u\n",
> -		   as_sdp->revision, as_sdp->length);
> +	drm_printf(p, "DP SDP: %s, revision %u, length %u\n",
> +		   dp_sdp_type_get_name(as_sdp->sdp_type), as_sdp->revision, as_sdp->length);
>  	drm_printf(p, "    vtotal: %d\n", as_sdp->vtotal);
>  	drm_printf(p, "    target_rr: %d\n", as_sdp->target_rr);
>  	drm_printf(p, "    duration_incr_ms: %d\n", as_sdp->duration_incr_ms);
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
