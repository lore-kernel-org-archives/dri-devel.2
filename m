Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6848BCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C155211A6CB;
	Fri,  5 Jun 2026 10:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fybr7cty";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5A811A6D5;
 Fri,  5 Jun 2026 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780653701; x=1812189701;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nZ7Au/VwIBZy82x4xmNDEhjV9bXHyA11cuGRW00rsp0=;
 b=Fybr7ctyIRyNzpW0IfpTrUiWgrDIBHb4IP8qEBB3QAPr21N9nqvUeJgx
 YlA8Y2pKXLOhhm1427XSQmxMm3CdwBqnKjSB07FvqFYJziPBhC8M45SxP
 HWK4wP+w+bwYfLV6cdY0X+qvDW/KahmEzKOpP8ht44XUqd4QeCGZhfVfA
 pPAOJKcEO8Jzl73daiKEX5y/a4BGvfYOle1ZECbZTMGHv71sihd9TchKk
 MTHOKcXTiwiH2VOZoOfmCpunUtDDGOpW+02cRy+9B72N0JLyWdpWWHWiI
 TeEguegZhAptzFZzcraOOJYjq+k44TI/VNURbLF1NTVJ8i3ZQzeuFt2/p Q==;
X-CSE-ConnectionGUID: MgwWViUyQBuXe21p3jDS8w==
X-CSE-MsgGUID: csGIig/nR+SNVIajj3LVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80522895"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="80522895"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 03:01:40 -0700
X-CSE-ConnectionGUID: v8r1eYEKQeWr6gaxsizX/g==
X-CSE-MsgGUID: A1S+/rvJRa2s2Lc628SYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="275042239"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.253])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 03:01:36 -0700
Date: Fri, 5 Jun 2026 13:01:32 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Patrik Jakobsson <pjakobsson@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/i915/display: Add quirk for interlane align
 bit on CH7511
Message-ID: <aiKefFDeom0AM04M@intel.com>
References: <20260605084641.50778-1-pjakobsson@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605084641.50778-1-pjakobsson@suse.de>
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

On Fri, Jun 05, 2026 at 10:46:40AM +0200, Patrik Jakobsson wrote:
> When disabling pattern training after successful link training the
> CH7511 bridge incorrectly clears the INTERLANE_ALIGN_DONE bit. This is
> interpreted as link failure when rechecking the link status and triggers
> an endless loop of retraining sequences.
> 
> This patch adds a quirk to pretend the bit is still set and no
> retraining is needed.
> 
> Fixes: 3b3be899fc81 ("drm/i915/dp: Recheck link state after modeset")

Closes: ?

> Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c     |  9 +++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.c | 17 +++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 85d3aa3b9894..5b269b1f18d7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5875,6 +5875,15 @@ intel_dp_needs_link_retrain(struct intel_dp *intel_dp)
>  	if (intel_dp->link.seq_train_failures)
>  		return true;
>  
> +	/*
> +	 * The CH7511 bridge incorrectly clears the INTERLANE_ALIGN_DONE bit
> +	 * when disabling training pattern.
> +	 */
> +	if (intel_has_dpcd_quirk(intel_dp, QUIRK_IGNORE_INTERLANE_ALIGN_BIT)) {
> +		link_status[DP_LANE_ALIGN_STATUS_UPDATED - DP_LANE0_1_STATUS] |=
> +			DP_INTERLANE_ALIGN_DONE;
> +	}
> +
>  	/* Retrain if link not ok */
>  	return !intel_dp_link_ok(intel_dp, link_status) &&
>  		!intel_psr_link_ok(intel_dp);
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 33245f44c0d5..2cec0a945528 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -100,6 +100,14 @@ static void quirk_disable_psr2(struct intel_display *display)
>  	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>  }
>  
> +static void quirk_ignore_interlane_align_bit(struct intel_dp *intel_dp)
> +{
> +	struct intel_display *display = to_intel_display(intel_dp);
> +
> +	intel_set_dpcd_quirk(intel_dp, QUIRK_IGNORE_INTERLANE_ALIGN_BIT);
> +	drm_info(display->drm, "Applying ignore interlane align bit quirk\n");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -286,6 +294,15 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
>  		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
>  		.hook = quirk_disable_edp_panel_replay,
>  	},
> +	/* Nodka TPC6000-C152 */
> +	{
> +		.device = 0x0f31,
> +		.subsystem_vendor = 0x8086,
> +		.subsystem_device = 0x0f31,
> +		.sink_oui = SINK_OUI(0x2b, 0x02, 0xf0),
> +		.sink_device_id = SINK_DEVICE_ID('C', 'H', '7', '5', '1', '1'),
> +		.hook = quirk_ignore_interlane_align_bit,
> +	},
>  };
>  
>  void intel_init_quirks(struct intel_display *display)
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52faf..7fcc3967f84f 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>  	QUIRK_EDP_LIMIT_RATE_HBR2,
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
> +	QUIRK_IGNORE_INTERLANE_ALIGN_BIT,
>  };
>  
>  void intel_init_quirks(struct intel_display *display);
> -- 
> 2.54.0

-- 
Ville Syrjälä
Intel
