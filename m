Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BBFFF886A
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A405F10E740;
	Mon, 27 Apr 2026 12:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gmaFKU3B";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C8010E73E;
 Mon, 27 Apr 2026 12:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777294745; x=1808830745;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Zr7y7uwvzYrjbrd/p96g8XOZA5grpDuASglNPpG0HMw=;
 b=gmaFKU3Btdu+Dz/BeKKvjYR2apaKKd4zGINXQ8J47PdCIkre7zwHVedg
 PD33F0CdFCGJ3nS6esDsd/QQp1PVY771qx09hx6pswE7k9vRcHDcDc64s
 Of3ULDliz7zDZ6Exhy9TCqioJwf4EovKT3B9W7uSKZx8rgbocfS0Xf4TJ
 KzainoOLswVerVvxaUt8VrFyA0bk15ew3sjzEPncIy9wpdQzFx4Sw0GPT
 2L5nvI5BeFJYsEPZ1f0pMqwyeRkJBSzdnY/HKwI3P0NGKQV4Q0H7T7FaH
 M8kkAi1GZclo8CUa3bwswBisN+wjIkoqYjp8/oFnJQ16bHI0nEg1mZskt g==;
X-CSE-ConnectionGUID: bqNwscMpQuyT1422E5KsBg==
X-CSE-MsgGUID: ymZMGeqSSNWRSmATmQaUYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88777783"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="88777783"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:59:04 -0700
X-CSE-ConnectionGUID: +EmezF5nSnu88kqkYxI5cw==
X-CSE-MsgGUID: RK40oJA/Qe6bW5sCFy1Shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="232753056"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.116])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 05:59:02 -0700
Date: Mon, 27 Apr 2026 15:58:59 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [RESEND PATCH 7/7] drm/dp: Add target_rr_divider field in AS SDP
 logging
Message-ID: <ae9dk1xLGfCF-ZH3@intel.com>
References: <20260424093424.3060805-1-ankit.k.nautiyal@intel.com>
 <20260424093424.3060805-8-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424093424.3060805-8-ankit.k.nautiyal@intel.com>
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

On Fri, Apr 24, 2026 at 03:04:24PM +0530, Ankit Nautiyal wrote:
> The field target_rr_divider is missing from the AS SDP logging.
> Add it and print the divider value (1.001 or 1.000) as per the DP 2.1 spec.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 102328d9022d..c8421099a3ac 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3537,6 +3537,8 @@ void drm_dp_as_sdp_log(struct drm_printer *p, const struct drm_dp_as_sdp *as_sdp
>  		   dp_sdp_type_get_name(as_sdp->sdp_type), as_sdp->revision, as_sdp->length);
>  	drm_printf(p, "    vtotal: %d\n", as_sdp->vtotal);
>  	drm_printf(p, "    target_rr: %d\n", as_sdp->target_rr);
> +	drm_printf(p, "    target_rr_divider: %s\n",
> +		   as_sdp->target_rr_divider ? "1.001" : "1.000");
>  	drm_printf(p, "    duration_incr_ms: %d\n", as_sdp->duration_incr_ms);
>  	drm_printf(p, "    duration_decr_ms: %d\n", as_sdp->duration_decr_ms);
>  	drm_printf(p, "    operation_mode: %d\n", as_sdp->mode);
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
