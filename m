Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21581C79FBE
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 12:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347BC10F0E9;
	Wed,  9 Sep 2026 12:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FnVSmSoj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 244BF10ECEE;
 Wed,  9 Sep 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788956183; x=1820492183;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=y0AFMcKTGl7uv/p5BHEJJeildm+pyxOLf4CVF643gno=;
 b=FnVSmSojdfhOgzCdZe/kJEHNoeFMpsh4FhFqzZ42yqhRxjC3mjByxd15
 Yb4yclkzpUbPLto/8sBKwWHQ0v1XJEevOOhNotjPzWpl1nqpHXwPlzLBC
 GKEI/b233oNHVgRSE+YqMB6unGaYmQ1Esqk7pNf+kc8J+rDn4y96PhMfz
 yXq+Z77gglWOQXiAWAXhHM3FwzaSnbcsQmPRGRHu2Imi1IUUqEDAjnzll
 hFCM8oIdaxfK3XVmVQknStYEpnQ22cZsWTqykSAIer7Zi7eZLlMVU6bdR
 nQ8OL0UZp3JeLihg0FnwT2Fe9aaZ5ZL27ODcxRFKBeAJ/KxdVvG3rMssJ g==;
X-CSE-ConnectionGUID: CY4X3otXTiCepTB+6k+8sw==
X-CSE-MsgGUID: hIjtPmWgQtimCDfeT6LPIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89420159"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89420159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:16:22 -0700
X-CSE-ConnectionGUID: SqBcx/zaToSD5AD4+2lWdg==
X-CSE-MsgGUID: jP4tqTR2Rpy3s7bt60Pj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="265090508"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.20])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 05:16:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: tarund18303@gmail.com
Cc: rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, airlied@gmail.com, simona@ffwll.ch,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 tarun-tarun143 <tarund18303@gmail.com>
Subject: Re: [PATCH] drm/i915/dp_link_caps: Validate max link rate
In-Reply-To: <20260827022035.3442-1-tarund18303@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260827022035.3442-1-tarund18303@gmail.com>
Date: Wed, 09 Sep 2026 15:16:16 +0300
Message-ID: <0531dd3f6e5056128dc1208c31199373a9035175@intel.com>
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

On Thu, 27 Aug 2026, tarund18303@gmail.com wrote:
> From: tarun-tarun143 <tarund18303@gmail.com>
>
> Validate the maximum link rate against the source-supported rates
> before using the maximum link limits to calculate allowed
> configurations.
>
> This prevents an unsupported link rate from being accepted as a
> maximum link limit.

Are you seeing this issue being hit, or are you just going through TODO
comments and trying to come up with fixes?

BR,
Jani.

>
> Signed-off-by: tarun-tarun143 <tarund18303@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_link_caps.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c b/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
> index 7b6cc6055da8..0934488153bb 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
> @@ -710,7 +710,10 @@ static bool max_link_limits_valid(struct intel_dp_link_caps *link_caps,
>  	    !is_power_of_2(max_link_limits->lane_count))
>  		return false;
>  
> -	/* TODO: Validate max_link_limits->rate against the source supported rates. */
> +	if (intel_dp_rate_index(link_caps->dp->source_rates,
> +				link_caps->dp->num_source_rates,
> +				max_link_limits->rate) < 0)
> +		return false;
>  
>  	intel_dp_link_caps_get_forced_params(link_caps, &forced_params);
>  	allowed_configs = calc_allowed_config_filter(link_caps, link_caps->enabled_configs,
>
> base-commit: 73e3f0710014fe6d4ed98cfc02292f6121db7558

-- 
Jani Nikula, Intel
