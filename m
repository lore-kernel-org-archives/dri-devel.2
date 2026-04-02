Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A8D3940E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A603010F1B9;
	Thu,  2 Apr 2026 10:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VKfFCLZT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01F510F15E;
 Thu,  2 Apr 2026 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775125858; x=1806661858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+slqjDXgcPW+Sz5VulUCLT/9DZ79Wc/Ci+9yY+GPnIE=;
 b=VKfFCLZTbxCOFsfyNaH+UD3+HLQougDPT1U/xQznaSVkirFw0tWpXyR8
 Y3EzwkU5YP4J+3fpmJZoVKCT7ZlDxKqaQzlahjQXrkeMU7y1iAK08TQi5
 fthAd336NXo8iIE0rxnFF0uCgmVZchtuCfUU50A5x/3oShwCsXTJTC8qj
 W0mwiYeB748U0IKwA8BoplapKnbDgkROwF2aqG420Cuir1Tl6OVazy8ek
 9g4WZTu0PKRaIJoRHzyGz4NlhcsgzIJWGKwk/d5CiI7Obc7hKwrbtQXbP
 2J4GOdLTsrFKc+QvjzAKI6X3sPXiodvlK+dhd2ishfdVq3EkhvPbNAzsR w==;
X-CSE-ConnectionGUID: U48/sYAzQYyFEn0c1L5PuQ==
X-CSE-MsgGUID: clsH0Jg0SvOY7SJC5H7HeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76065263"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="76065263"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:30:58 -0700
X-CSE-ConnectionGUID: S8/qH5foTi+b000YN+2ucw==
X-CSE-MsgGUID: JXcJpI2tSMqYUYyNM8g2Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="225934367"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.61])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:30:55 -0700
Date: Thu, 2 Apr 2026 13:30:52 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 18/23] drm/i915/psr: Program Panel Replay CONFIG3 using
 AS SDP transmission time
Message-ID: <ac5FXKB36ylJy-Ea@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
 <20260402080425.548702-19-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402080425.548702-19-ankit.k.nautiyal@intel.com>
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

On Thu, Apr 02, 2026 at 01:34:18PM +0530, Ankit Nautiyal wrote:
> Panel Replay requires the AS SDP transmission time to be written into
> PANEL_REPLAY_CONFIG3. This field was previously not programmed.
> 
> Use the AS SDP transmission-time helper to populate CONFIG3.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 3fe7691c8b77..a9032b7ff814 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -783,6 +783,7 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
>  				      const struct intel_crtc_state *crtc_state)
>  {
>  	u8 panel_replay_config[2];
> +	u8 panel_replay_config_3;
>  
>  	panel_replay_config[0] = DP_PANEL_REPLAY_ENABLE |
>  				 DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
> @@ -790,7 +791,6 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
>  				 DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
>  				 DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
>  	panel_replay_config[1] = DP_PANEL_REPLAY_CRC_VERIFICATION;
> -
>  	if (crtc_state->has_sel_update)
>  		panel_replay_config[0] |= DP_PANEL_REPLAY_SU_ENABLE;
>  
> @@ -803,6 +803,9 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
>  
>  	drm_dp_dpcd_write(&intel_dp->aux, PANEL_REPLAY_CONFIG,
>  			  panel_replay_config, sizeof(panel_replay_config));
> +
> +	panel_replay_config_3 = intel_dp_as_sdp_transmission_time();
> +	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG3, panel_replay_config_3);
>  }
>  
>  static void _psr_enable_sink(struct intel_dp *intel_dp,
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
