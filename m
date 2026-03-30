Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891BB1061B15
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E925510E6CB;
	Mon, 30 Mar 2026 18:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iqKVzSvg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA63C10E30E;
 Mon, 30 Mar 2026 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774894908; x=1806430908;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=2P0i5UlL/b8LmIhZmFGU23rIfbawl8MQQbVfTOE5hTk=;
 b=iqKVzSvg29rRgVGfEmbgkrXyH4Ii9LV417ZAjI4SnLIxN2FuyscIop2Q
 wXLLKXQsxr+jpGv0FA4CjS1RRA6g6MIfYSbZFAc6fRaYpJgnAw7SahTeY
 yVTuS9lVLxBK2GxrA81kUqm8DtkLstY+k+7rBrg5nuxkqT9O7g8eUUuAT
 wqFoMnes2rcCBliApkQJyAfnhkZUaf1becVtR9Vkf1dBaCy/+qb8zPT+s
 ZSjmLIDYb2OiBaWJSUa/wENXf4hMgzXf7iROg9kHA7w1vkaGIVj/vecTg
 GSE6zgLa9J0/iSyAH6USkG0y31pitFp+1GWV1MSf7kjsLyLMfOi7eC+Cv w==;
X-CSE-ConnectionGUID: +IyKLqFwTmWPgQ8tslhsTw==
X-CSE-MsgGUID: D4orn90GS2qU3mn4G2WqAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79498888"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79498888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:21:47 -0700
X-CSE-ConnectionGUID: rzLoq1whR5q5DEs5iSFxOw==
X-CSE-MsgGUID: yAdHakBMQUGwFmW26vYJpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="219481557"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.155])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:21:45 -0700
Date: Mon, 30 Mar 2026 21:21:42 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 08/19] drm/i915/dp: Add a helper to decide if AS SDP can
 be used
Message-ID: <acq_Nix_LJQYmQHq@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
 <20260330040656.4116502-9-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330040656.4116502-9-ankit.k.nautiyal@intel.com>
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

On Mon, Mar 30, 2026 at 09:36:45AM +0530, Ankit Nautiyal wrote:
> Add a helper that determines whether AS SDP can be used for the
> current DP configuration. For now this is true only when the sink
> supports AS SDP and VRR is enabled, but more conditions may be added
> later.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 499850c2abcf..7ca3f9d583db 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3124,6 +3124,15 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
>  	vsc->content_type = DP_CONTENT_TYPE_NOT_DEFINED;
>  }
>  
> +static bool intel_dp_can_use_as_sdp(struct intel_dp *intel_dp,
> +				    struct intel_crtc_state *crtc_state)
> +{
> +	if (!intel_dp->as_sdp_supported)
> +		return false;
> +

Could have a FIXME here about fastset being borked with this. Didn't
read far enough in the series yet to see if you did anything about that.

Either way
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +	return crtc_state->vrr.enable;
> +}
> +
>  static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
>  				    struct intel_crtc_state *crtc_state)
>  {
> @@ -3131,7 +3140,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
>  	const struct drm_display_mode *adjusted_mode =
>  		&crtc_state->hw.adjusted_mode;
>  
> -	if (!crtc_state->vrr.enable || !intel_dp->as_sdp_supported)
> +	if (!intel_dp_can_use_as_sdp(intel_dp, crtc_state))
>  		return;
>  
>  	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
