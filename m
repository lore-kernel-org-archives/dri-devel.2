Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA223105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83CAA10EBB4;
	Fri, 13 Mar 2026 11:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SvWBysYi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCE010EBB0;
 Fri, 13 Mar 2026 11:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773402263; x=1804938263;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=snZK/LW/UFopEgYQk+i74CD/DiR+G13CKLM7tjPV838=;
 b=SvWBysYiJCPkeRDW9sBgGy3gpDOt0Q84uY/eKoRiz6kahaP4CLC2p/ne
 21Uj60TWaN6nig81w3A3s5jxzTBJW0RBn/7TZfEI2vamN+4mYC34TKgFg
 xEiPfYP1op9I4BBKETP0ianbAKTla8YxGRuGC9esEWm8cDDjNwFs/XoR6
 NwKmEQPBH29RAIW24GdsnRSmoXxfVEtmGNXMqpUkB4TSRTpyotIXWMo+8
 GLwd7Jz9+f0ZnMONM91UDiLVhTpVmOqJcw+LAFL9EMqzc3U2WNqQ/Y9Ig
 dRF0a9b/U3dQ5ATjgoINik5Hdl3ufP4nnz2ZFH/lxY2h64EoxlDLNEHmd w==;
X-CSE-ConnectionGUID: nCfLba2jSXOJ76QkQCy+vA==
X-CSE-MsgGUID: 5KJ4F8mIR42U6gh4oQCjGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78398677"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="78398677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 04:44:22 -0700
X-CSE-ConnectionGUID: xZFSMVYQRFm/PZb18nN7sg==
X-CSE-MsgGUID: 2kUVIx/ETy+Wnd+hp43bew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="259039077"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.21])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 04:44:19 -0700
Date: Fri, 13 Mar 2026 13:44:16 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 01/19] drm/dp: Rename and relocate AS SDP payload field
 masks
Message-ID: <abP4kOqkvfSh6j3G@intel.com>
References: <20260311113611.3393194-1-ankit.k.nautiyal@intel.com>
 <20260311113611.3393194-2-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311113611.3393194-2-ankit.k.nautiyal@intel.com>
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

On Wed, Mar 11, 2026 at 05:05:53PM +0530, Ankit Nautiyal wrote:
> The AS SDP payload field masks were misnamed and placed under the DPRX
> feature enumeration list. These are not DPRX capability bits, but are
> payload field masks for the Adaptive Sync SDP.
> 
> Relocate both masks next to the AS SDP definitions.
> Update users to the corrected names. No functional change.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>  include/drm/display/drm_dp.h            | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index fbb5e2f9c241..cd1539c3268c 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5295,8 +5295,8 @@ int intel_dp_as_sdp_unpack(struct drm_dp_as_sdp *as_sdp,
>  	if ((sdp->sdp_header.HB3 & 0x3F) != 9)
>  		return -EINVAL;
>  
> -	as_sdp->length = sdp->sdp_header.HB3 & DP_ADAPTIVE_SYNC_SDP_LENGTH;
> -	as_sdp->mode = sdp->db[0] & DP_ADAPTIVE_SYNC_SDP_OPERATION_MODE;
> +	as_sdp->length = sdp->sdp_header.HB3 & DP_AS_SDP_LENGTH_MASK;
> +	as_sdp->mode = sdp->db[0] & DP_AS_SDP_OPERATION_MODE_MASK;
>  	as_sdp->vtotal = (sdp->db[2] << 8) | sdp->db[1];
>  	as_sdp->target_rr = (u64)sdp->db[3] | ((u64)sdp->db[4] & 0x3);
>  	as_sdp->target_rr_divider = sdp->db[4] & 0x20 ? true : false;
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 8b15d3eeb716..4ea3b5b08a12 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -1204,8 +1204,6 @@
>  
>  #define DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1         0x2214 /* 2.0 E11 */
>  # define DP_ADAPTIVE_SYNC_SDP_SUPPORTED    (1 << 0)
> -# define DP_ADAPTIVE_SYNC_SDP_OPERATION_MODE		GENMASK(1, 0)
> -# define DP_ADAPTIVE_SYNC_SDP_LENGTH				GENMASK(5, 0)
>  # define DP_AS_SDP_FIRST_HALF_LINE_OR_3840_PIXEL_CYCLE_WINDOW_NOT_SUPPORTED (1 << 1)
>  # define DP_VSC_EXT_SDP_FRAMEWORK_VERSION_1_SUPPORTED  (1 << 4)
>  
> @@ -1870,4 +1868,7 @@ enum operation_mode {
>  	DP_AS_SDP_FAVT_TRR_REACHED = 0x03
>  };
>  
> +#define DP_AS_SDP_OPERATION_MODE_MASK	GENMASK(1, 0)
> +#define DP_AS_SDP_LENGTH_MASK		GENMASK(5, 0)

The way all the SDP stuff is organized in drm_dp.h very messy.
It's not at all clear which bytes each define/enum corresponds
to. Someone should try to clean it all up properly...

But at least this is better than what we have now, so
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +
>  #endif /* _DRM_DP_H_ */
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
