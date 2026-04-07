Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37206FF510B
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C731210E45F;
	Tue,  7 Apr 2026 15:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IIAVt4q4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D2A10E45A;
 Tue,  7 Apr 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775576407; x=1807112407;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZyztVrSZVIDuGM6tCeW4pBfkg7uW5I8y8Jr1Gir/StA=;
 b=IIAVt4q4NSgc/fFNZSO/JorSnsK1iMBg8OkfQnCePmm7wS0bd4XMtFB8
 e8Gtn3ECI8N9bW5GuLVlCIL1ozMI7aWhhOZqBmLtqPIhqEd+IBEkgOiXB
 opamdxJTE1kVCnnWZWbn+mFbx6h3KGAobhb4L8nbYbGTVm+nQI2WYF45s
 78dCz1riZIssLR60JFYUth2OITHPgf9I5L2y8VyVFne0nijP5HxK0OQaM
 2LYKXylIHB1WVTZDxneKCrqMgllOoZUik2C5uFvRF/TSJ6+BAW+Kz3uwq
 STzMoACtwehDwsc7l8FfoV4fKBD0H+0BXacika78LnLRIVRDL0mD134Ia A==;
X-CSE-ConnectionGUID: b41hQIfiTASVjYae7/hI6g==
X-CSE-MsgGUID: xp1pyR4ATneVQzX2H5OT3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94124528"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="94124528"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:40:06 -0700
X-CSE-ConnectionGUID: hup2esy0SwaZbsQo1KdO4Q==
X-CSE-MsgGUID: LdWHBNcgTeia286xjSiOPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="228466823"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.211])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:40:03 -0700
Date: Tue, 7 Apr 2026 18:40:00 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 22/23] drm/i915/dp: Compute and include coasting vtotal
 for AS SDP
Message-ID: <adUMg7YSRZLy9_SF@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
 <20260402080425.548702-23-ankit.k.nautiyal@intel.com>
 <ac5Omw5rDxuGO-Bp@intel.com>
 <2ae5996e-1eec-4b33-9d4e-6a07aa805698@intel.com>
 <e08840f2-3fdd-45b7-b31b-0c95ff98ab29@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e08840f2-3fdd-45b7-b31b-0c95ff98ab29@intel.com>
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

On Tue, Apr 07, 2026 at 04:26:28PM +0530, Nautiyal, Ankit K wrote:
> 
> On 4/7/2026 4:24 PM, Nautiyal, Ankit K wrote:
> >
> > On 4/2/2026 4:40 PM, Ville Syrjälä wrote:
> >> On Thu, Apr 02, 2026 at 01:34:22PM +0530, Ankit Nautiyal wrote:
> >>> DP v2.1 allows the source to temporarily suspend Adaptive-Sync SDP
> >>> transmission while Panel Replay is active when the sink supports
> >>> asynchronous video timing.
> >>>
> >>> In such cases, the sink relies on the last transmitted AS SDP timing
> >>> information to maintain the refresh rate. To support this behavior,
> >>> compute and populate the coasting vtotal field in the AS SDP payload.
> >>>
> >>> Include coasting vtotal in AS SDP packing, unpacking, and comparison,
> >>> and set it during late AS SDP configuration for PR with Aux-less ALPM
> >>> when asynchronous video timing is supported.
> >>>
> >>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> >>> ---
> >>>   drivers/gpu/drm/i915/display/intel_display.c |  3 ++-
> >>>   drivers/gpu/drm/i915/display/intel_dp.c      | 19 +++++++++++++++++++
> >>>   2 files changed, 21 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c 
> >>> b/drivers/gpu/drm/i915/display/intel_display.c
> >>> index a0e7ef2574b2..747dd3112d66 100644
> >>> --- a/drivers/gpu/drm/i915/display/intel_display.c
> >>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> >>> @@ -4914,7 +4914,8 @@ intel_compare_dp_as_sdp(const struct 
> >>> drm_dp_as_sdp *a,
> >>>           a->duration_incr_ms == b->duration_incr_ms &&
> >>>           a->duration_decr_ms == b->duration_decr_ms &&
> >>>           a->target_rr_divider == b->target_rr_divider &&
> >>> -        a->mode == b->mode;
> >>> +        a->mode == b->mode &&
> >>> +        a->coasting_vtotal == b->coasting_vtotal;
> >>>   }
> >>>     static bool
> >>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c 
> >>> b/drivers/gpu/drm/i915/display/intel_dp.c
> >>> index 902c09e0780f..de6f88a5400d 100644
> >>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> >>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> >>> @@ -5123,6 +5123,9 @@ static ssize_t intel_dp_as_sdp_pack(const 
> >>> struct drm_dp_as_sdp *as_sdp,
> >>>       if (as_sdp->target_rr_divider)
> >>>           sdp->db[4] |= 0x20;
> >>>   +    sdp->db[7] = as_sdp->coasting_vtotal & 0xFF;
> >>> +    sdp->db[8] = (as_sdp->coasting_vtotal >> 8) & 0xFF;
> >>> +
> >>>       return length;
> >>>   }
> >>>   @@ -5306,6 +5309,7 @@ int intel_dp_as_sdp_unpack(struct 
> >>> drm_dp_as_sdp *as_sdp,
> >>>       as_sdp->vtotal = (sdp->db[2] << 8) | sdp->db[1];
> >>>       as_sdp->target_rr = ((sdp->db[4] & 0x3) << 8) | sdp->db[3];
> >>>       as_sdp->target_rr_divider = sdp->db[4] & 0x20 ? true : false;
> >>> +    as_sdp->coasting_vtotal = (sdp->db[8] << 8) | sdp->db[7];
> >>>         return 0;
> >>>   }
> >>> @@ -7383,6 +7387,21 @@ void 
> >>> intel_dp_as_sdp_compute_config_late(struct intel_dp *intel_dp,
> >>>       } else {
> >>>           as_sdp->mode = DP_AS_SDP_AVT_FIXED_VTOTAL;
> >>>       }
> >>> +
> >>> +    /*
> >>> +     * For Panel Replay with Async Video Timing support, the source 
> >>> can
> >>> +     * disable sending the AS SDP during PR Active state. In that 
> >>> case,
> >>> +     * the sink needs the coasting vtotal value to maintain the 
> >>> refresh
> >>> +     * rate.
> >>> +     *
> >>> +     * #TODO:
> >>> +     * If we ever advertise support for coasting at other refresh 
> >>> targets,
> >>> +     * this logic could be revisited. For now, use the minimum 
> >>> refresh rate
> >>> +     * as the only safe coasting value.
> >>> +     */
> >>> +    if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state) &&
> >>> +        intel_psr_pr_async_video_timing_supported(intel_dp))
> >>> +        as_sdp->coasting_vtotal = crtc_state->vrr.vmax;
> >> Seems reasonable.
> >>
> >> Is this always under our control or could the hardware overwrite
> >> this with the current vtotal at the time of PR entry? Assuming
> >> we can enter PR before the vtotal goes back to vmax on its own
> >> anyway.
> >
> >
> > What I understand from Bspec in this regard is:
> >
> > Do not write Adaptive Sync SDP Transmission Disable in PR Active State 
> > i.e. DB[2], instead use PR_ALPM_CTL[ AS SDP Transmission in Active 
> > Disable ] bit.
> >
> > HW will sample the PR_ALPM_CTL bit only when PR is active, and it will 
> > get reflected in AS SDP payload in an 'appropriate' time.
> >
> > HW will ignore this bit when PR is Inactive and always send AS SDP.
> >
> > So I think HW will not touch the coasting vtotal DBs.
> >
> > Driver should set appropriate coasting Vtotal and set the 
> > PR_ALPM_CTL[AS SDP Transmission in Active disable] bit.
> >
> > During PR active Driver will set the DB[2] bit in payload which will 
> > trigger the sink to use Coasting Vtotal.
> 
> 
> ..HW will set the DB[2] bit ... (facepalm)

OK. Might be good to note in the commit message that this fully
under driver control. I suppose it would be good to make that
statement (one way or the other) for any additions we do to the
AS SDP payload...

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> 
> >
> > (Unless we start writing : DPCD 00B1[0] ie. 
> > PANEL_REPLAY_CONFIG2[PANEL_REPLAY_SINK_REFRESH_RATE_UNLOCK_GRANTED], 
> > in which sink starts using its own logic).
> >
> >
> > Regards,
> >
> > Ankit
> >
> >
> >
> >>
> >>>   }
> >>>     static
> >>> -- 
> >>> 2.45.2

-- 
Ville Syrjälä
Intel
