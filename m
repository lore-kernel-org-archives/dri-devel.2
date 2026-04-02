Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03191D3940E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C114710F1FA;
	Thu,  2 Apr 2026 10:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O6qm+l7J";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF66810F125;
 Thu,  2 Apr 2026 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775125473; x=1806661473;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NqYhA7jmk0d5au67MUS2lTtYwrOPwCOpfzkrM+zHIxU=;
 b=O6qm+l7JMvrpHhMi5V+F15cy3rhVMkyn5i4LSDUxfCLKhLAlU0Ize6/o
 VscdI5baNOWvcKBteUaK7agQNgQuJi1vvaZKsMkF2HFBGDK8/gJK8PbLI
 HiPSwdsL6EOzmg7JjbB0IC4fvtRjiixr51yDWDxZ4BpG3/z9K79IhFAhv
 OIurEXGcv1kMB21ft1Nn+JDw792jRXqHBbHhIEN2EocUlUMJNZJrUeM3e
 igAhFNyOj4ii+E2/scZaEBetomA8u4XQc21LU8JgLG/X5cUHeODKaiHwP
 cZdDeZhdTxVK3JSxmJIgsCxxbPCtETKcTecTIrHnzUHTUnFuyiReOwbos g==;
X-CSE-ConnectionGUID: SRPMAFO7R066eo8p49/55w==
X-CSE-MsgGUID: 4CVbCAqqRXWzstIoQGQeVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="101634176"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="101634176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:24:33 -0700
X-CSE-ConnectionGUID: tSd3ry+sSh29HKdZzBEO6A==
X-CSE-MsgGUID: PbIdi7/GQZqDSrzSGCMUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="250007495"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.61])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 03:24:31 -0700
Date: Thu, 2 Apr 2026 13:24:28 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 13/23] drm/i915/psr: Add helper to get Async Video timing
 support in PR active
Message-ID: <ac5D3IJnVfx6Xpdn@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
 <20260402080425.548702-14-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402080425.548702-14-ankit.k.nautiyal@intel.com>
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

On Thu, Apr 02, 2026 at 01:34:13PM +0530, Ankit Nautiyal wrote:
> Introduce a helper to check if Panel Replay has Async Video Timing support
> during PR Active state.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 8 ++++++++
>  drivers/gpu/drm/i915/display/intel_psr.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 2f1b48cd8efd..782e839b7396 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -4623,3 +4623,11 @@ bool intel_psr_use_trans_push(const struct intel_crtc_state *crtc_state)
>  
>  	return HAS_PSR_TRANS_PUSH_FRAME_CHANGE(display) && crtc_state->has_psr;
>  }
> +
> +bool intel_psr_pr_async_video_timing_supported(struct intel_dp *intel_dp)
> +{
> +	struct intel_connector *connector = intel_dp->attached_connector;
> +

I think we also need to confirm here that panel replay itself
is supported by the sink. Otherwise this bit will for sure be
zero and then we'll think that we need to transmit AS SDP
even for non-PR sinks.

> +	return !(connector->dp.panel_replay_caps.dpcd[INTEL_PR_DPCD_INDEX(DP_PANEL_REPLAY_CAP_CAPABILITY)] &
> +		 DP_PANEL_REPLAY_ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR);
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
> index 394b641840b3..29723e63888f 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.h
> +++ b/drivers/gpu/drm/i915/display/intel_psr.h
> @@ -86,5 +86,6 @@ void intel_psr_compute_config_late(struct intel_dp *intel_dp,
>  				   struct intel_crtc_state *crtc_state);
>  int intel_psr_min_guardband(struct intel_crtc_state *crtc_state);
>  bool intel_psr_use_trans_push(const struct intel_crtc_state *crtc_state);
> +bool intel_psr_pr_async_video_timing_supported(struct intel_dp *intel_dp);
>  
>  #endif /* __INTEL_PSR_H__ */
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
