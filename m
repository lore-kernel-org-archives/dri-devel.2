Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B46CD6E51
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6923F1120BC;
	Fri, 29 May 2026 15:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hAljyH7S";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAC41120B9;
 Fri, 29 May 2026 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780067820; x=1811603820;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=HedptQ/6CIwjp4YiEkdapvOi2Wo7J+jtmUPcqWAfNeo=;
 b=hAljyH7SS6gcYFpHXFPAgOu8ULYOEJYxK4154M7c/34TycN/kfm35yEj
 vaw1qI4j1OQ24dVY0IOgYKUQSWgno61LS0HL0I3udo7u7G+32pobJEJuO
 jai+mrWTLS1RYMXjcwDmgjHZCPGWl5dj/UuXXUSwnemB5w7oCwPhLcuSD
 IxiVQn8RneG7EUkqlqqUAebF18zbFuOS8bbP673g4K8VLS2INo08wvqB0
 d+5RCV/jPdnLtfU8lrsVQUiShnFzohNg/sI1IbEwKpMiQy8+nng11o2Da
 iCs1dFHz0Wp6rJC2sSyq7sPOSdIBzr4IIpKb79eyuj7qoCUQ7kyIFacSe A==;
X-CSE-ConnectionGUID: jL5M7Ch0TOCorgoPQ/s7Pg==
X-CSE-MsgGUID: JUoVW7r0RkiYyrhGZVf5VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81035499"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="81035499"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:17:00 -0700
X-CSE-ConnectionGUID: i6bFdGVTS82BuB4IRgzZTA==
X-CSE-MsgGUID: CaBophDrRayP69jpuH6lKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="273187289"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:16:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] drm/i915/edp: Check supported link rates DPCD read
In-Reply-To: <20260529145759.1640646-1-n.zhandarovich@fintech.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260529145759.1640646-1-n.zhandarovich@fintech.ru>
Date: Fri, 29 May 2026 18:16:54 +0300
Message-ID: <824c6ced1095635f86527709822c8af3ddff7c8c@intel.com>
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

On Fri, 29 May 2026, Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
> intel_edp_set_sink_rates() reads DP_SUPPORTED_LINK_RATES into a local
> stack array and then parses the array unconditionally. If the read
> fails, the array contents are not valid and may result in bogus sink
> link rates being used.
>
> Use drm_dp_dpcd_read_data() and clear the sink rate array on failure,
> so the existing parser falls back to the default sink rate handling.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 68f357cb7347 ("drm/i915/dp: generate and cache sink rate array for all DP, not just eDP 1.4")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
> v1 -> v2:
> - Use drm_dp_dpcd_read_data() instead of drm_dp_dpcd_read().
> - Avoid the goto by clearing sink_rates on read failure, as suggested by
>   Jani Nikula.
> - Adjust patch description.
>
>  drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 6ef2a0043cda..5c3e816b0135 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4678,10 +4678,17 @@ intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  
>  	if (intel_dp->edp_dpcd[0] >= DP_EDP_14) {
>  		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
> +		int ret;
>  		int i;
>  
> -		drm_dp_dpcd_read(&intel_dp->aux, DP_SUPPORTED_LINK_RATES,
> -				 sink_rates, sizeof(sink_rates));
> +		ret = drm_dp_dpcd_read_data(&intel_dp->aux,
> +					    DP_SUPPORTED_LINK_RATES,
> +					    sink_rates, sizeof(sink_rates));
> +		if (ret < 0) {
> +			drm_dbg_kms(display->drm,
> +				    "Unable to read eDP supported link rates, using default rates\n");
> +			memset(sink_rates, 0, sizeof(sink_rates));
> +		}
>  
>  		for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
>  			int rate;

-- 
Jani Nikula, Intel
