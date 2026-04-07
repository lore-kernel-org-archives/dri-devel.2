Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44085FF5105
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C36DB10E445;
	Tue,  7 Apr 2026 15:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d8YOfU95";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 354AF10E090;
 Tue,  7 Apr 2026 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775574911; x=1807110911;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TuWBaUGnmYqU6g3hHdanF2NLWp3e4IMrWgPrkQWbH8k=;
 b=d8YOfU95SJBUi02CA9Fb7LcPSFijIXlstRF97CXECKHv1a+HjR0bw5kg
 mT12SLOoFf2q/Z1Icpa6BFSRE8IIWGs/7SA7XkZ3iAQQcp8nYAjRIDHJ0
 KDbcjIhH3LDjC0cBYO0cqFc/4qkx+Bnctw6iwp6iwr9B+cZ3mynmUxkan
 xDYZhSa836StzL+6qXRTErf3Ux2ZSQi84ik/IcMkVOVHsAJ2TX9XtnXMl
 oc8TsmFG0mO0vqJygYDhjPiuq//4uEEtUZQ2SQiN1ScaFxOeu5KnvSlOX
 SGkVP64ww9OsoS+nGWuIAHTUVC/4kwEnUW0ISiaF2FsXtHgWAMOUrizFN A==;
X-CSE-ConnectionGUID: i0s31VPyRdCTaw+xcAVNxA==
X-CSE-MsgGUID: SyuT3CSsQ9eI2veNP9C8TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80134278"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="80134278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:15:10 -0700
X-CSE-ConnectionGUID: 8YaJb2c6TI+5pDmdgTFNYw==
X-CSE-MsgGUID: Kr9TZo0RRxWvO/1b3SEYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="232231904"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.211])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 08:15:08 -0700
Date: Tue, 7 Apr 2026 18:15:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 14/23] drm/i915/dp: Add member to intel_dp to store AS
 SDP v2 support
Message-ID: <adUfeb_AEk3W2_6w@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
 <20260402080425.548702-15-ankit.k.nautiyal@intel.com>
 <ac5NPL2yG1aH12DF@intel.com> <ac5mAUhmxqn-_J0W@intel.com>
 <e84ddfe2-181e-4b74-8681-0b33545da61f@intel.com>
 <791d95e9-8547-4f30-bcac-a2b0562d63b3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <791d95e9-8547-4f30-bcac-a2b0562d63b3@intel.com>
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

On Tue, Apr 07, 2026 at 07:05:51PM +0530, Nautiyal, Ankit K wrote:
> 
> On 4/7/2026 1:50 PM, Nautiyal, Ankit K wrote:
> >
> > On 4/2/2026 6:20 PM, Ville Syrjälä wrote:
> >> On Thu, Apr 02, 2026 at 02:04:28PM +0300, Ville Syrjälä wrote:
> >>> On Thu, Apr 02, 2026 at 01:34:14PM +0530, Ankit Nautiyal wrote:
> >>>> DP v2.1 SCR advertises support for FAVT payload fields parsing in DPCD
> >>>> 0x2214 Bit 2. This indicates the support for Adaptive-Sync SDP 
> >>>> version 2
> >>>> (AS SDP v2), which allows the source to set the version in HB2[4:0] 
> >>>> and the
> >>>> payload length in HB3[5:0] of the AS SDP header.
> >>>>
> >>>> DP v2.1 SCR also introduces ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR 
> >>>> in the
> >>>> Panel Replay Capability DPCD 0x00b1 (Bit 3). When this bit is set, 
> >>>> the sink
> >>>> does not support asynchronous video timing while in a Panel Replay 
> >>>> Active
> >>>> state and the source is required to keep transmitting Adaptive-Sync
> >>>> SDPs. The spec mandates that such sinks shall support AS SDP v2.
> >>>>
> >>>> Infer AS SDP v2 support from these capabilities and store it in
> >>>> struct intel_dp for use by subsequent feature enablement changes.
> >>> Hmm. After some more reading I think we might actually want to consult
> >>> the DisplayID for this. The presence of the new adaptive sync block
> >>> there might be a good indication for AS SDP v2 support. While the
> >>> DisplayID 2.1 spec itself doesn't say that AS SDP v2 must be supported
> >>> when the block is present, the DP 2.1 spec does at least say the 
> >>> converse.
> >>> Ie. adaptive sync capable DP 2.1 sink must have the DisplayID block. 
> >>> And
> >>> DP 2.1 seems to be all about the AS SDP v2 and not AS SDP v1 (that's 
> >>> a DP
> >>> 2.0 thing really).
> >> Hmm. But the EDID comes from the display, and we could have a PCON
> >> in between that doesn't understand AS SDP v2. Sigh. What a mess.
> >
> >
> > hmm yeah. Is it alright to have a #TODO something like:
> >
> > /*
> > * TODO: Check the Adaptive-Sync DisplayID 2.1 block once DisplayID 
> > parsing
> > * is available. This may help detect AS SDP v2 support for native DP 2.1
> > * sinks that do not expose FAVT or PR-based capability bits.
> > *
> > * In the presence of PCONs, check PCON support from DPCD and sink 
> > support from Display ID.
> > */
> >
> 
> Going throught the eDP spec, it seems for eDP,  if AS SDP is supported 
> it implicitly means AS SDP v2.
> 
>  From eDP spec 2.0

eDP 2.0 does not seem relevant for us. But IIRC eDP v1.5 also implies
AS SDP v2 support. And that we can actually check if necessary.

Though I suppose the only real concern is branch devices. Maybe we
should use the FAVT check only for those. For everything else it
should be sufficient to have either the DisplayID adaptive sync 
block or PR ALPM support.

> 
> Section 2.8 Adaptive-Sync
> 
> "eDP may optionally support the Adaptive-Sync operation to maintain 
> video timing
> synchronization between Source and Sink devices (see DP Standard, 
> “Adaptive-Sync Operation
> for VESA AdaptiveSync”). If supported, the Adaptive-Sync SDP version 
> shall be v2 or higher
> (HB2[4:0] = 02h or higher, and HB3[5:0] = 09h or higher)."
> 
> Also, the FAVT Payload fields parsing support is not used for eDP and 
> will always read 0.
> 
> This however doesn't mean that FAVT is not supported, the support is 
> implicit.
> 
> Section 8.7.1 Video Timing Synchronization while in a PR Active State
> with ALPM Enabled
> 
> ...Source-to-Sink device timing synchronization during a PR Active state 
> that uses the Adaptive-Sync SDP may be enabled in
> Adaptive-Sync (FAVT or AVT mode) operation (DPCD 00107h[7] = 1) –or– when
> DPCD 00107h[7] = 0..
> 
> 
> So, I will update the logic for eDP here.
> 
> Regards,
> 
> Ankit
> 
> 
> 
> >
> > Regards,
> >
> > Ankit
> >
> >>> I think there was a patch posted very recently on dri-devel, adding the
> >>> adaptive sync DisplayID block parsing. Or at least some DisplayID block
> >>> related to this.
> >>>
> >>> The intel_psr_pr_async_video_timing_supported() check I think we want
> >>> to keep regardless, because you could have a sink with PR but no
> >>> adaptive sync. But the FAVT check could perhaps be dropped if we add
> >>> the DisplayID check.
> >>>
> >>>> v2: Include parsing ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR bit to
> >>>>      determine AS SDP v2 support. (Ville)
> >>>> v3: Use helper to determine asynch video timing support.
> >>>>
> >>>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> >>>> ---
> >>>>   .../drm/i915/display/intel_display_types.h    |  1 +
> >>>>   drivers/gpu/drm/i915/display/intel_dp.c       | 33 
> >>>> +++++++++++++++++++
> >>>>   2 files changed, 34 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h 
> >>>> b/drivers/gpu/drm/i915/display/intel_display_types.h
> >>>> index e2496db1642a..efc609eef4f5 100644
> >>>> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> >>>> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> >>>> @@ -1870,6 +1870,7 @@ struct intel_dp {
> >>>>       /* connector directly attached - won't be use for modeset in 
> >>>> mst world */
> >>>>       struct intel_connector *attached_connector;
> >>>>       bool as_sdp_supported;
> >>>> +    bool as_sdp_v2_supported;
> >>>>         struct drm_dp_tunnel *tunnel;
> >>>>       bool tunnel_suspended:1;
> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c 
> >>>> b/drivers/gpu/drm/i915/display/intel_dp.c
> >>>> index cec0f3d03c2f..9fd768447f28 100644
> >>>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> >>>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> >>>> @@ -6306,6 +6306,36 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
> >>>>                              false);
> >>>>   }
> >>>>   +static bool
> >>>> +intel_dp_sink_supports_as_sdp_v2(struct intel_dp *intel_dp)
> >>>> +{
> >>>> +    u8 rx_features;
> >>>> +
> >>>> +    /*
> >>>> +     * The DP spec does not explicitly provide the AS SDP v2 
> >>>> capability.
> >>>> +     * So based on the DP v2.1 SCR, we infer it from the following 
> >>>> bits:
> >>>> +     *
> >>>> +     * DP_AS_SDP_FAVT_PAYLOAD_FIELDS_PARSING_SUPPORTED indicates 
> >>>> support for
> >>>> +     * FAVT, which is explicitly defined to use AS SDP v2.
> >>>> +     *
> >>>> +     * DP_ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR indicates that 
> >>>> the sink
> >>>> +     * does not support asynchronous video timing while in PR Active,
> >>>> +     * requiring the source to keep transmitting Adaptive-Sync 
> >>>> SDPs. The
> >>>> +     * spec mandates that such sinks shall support AS SDP v2.
> >>>> +     */
> >>>> +    if (drm_dp_dpcd_read_byte(&intel_dp->aux,
> >>>> +                  DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1,
> >>>> +                  &rx_features) == 1) {
> >>>> +        if (rx_features & 
> >>>> DP_AS_SDP_FAVT_PAYLOAD_FIELDS_PARSING_SUPPORTED)
> >>>> +            return true;
> >>>> +    }
> >>>> +
> >>>> +    if (!intel_psr_pr_async_video_timing_supported(intel_dp))
> >>>> +        return true;
> >>>> +
> >>>> +    return false;
> >>>> +}
> >>>> +
> >>>>   static void
> >>>>   intel_dp_detect_sdp_caps(struct intel_dp *intel_dp)
> >>>>   {
> >>>> @@ -6313,6 +6343,9 @@ intel_dp_detect_sdp_caps(struct intel_dp 
> >>>> *intel_dp)
> >>>>         intel_dp->as_sdp_supported = HAS_AS_SDP(display) &&
> >>>>           drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
> >>>> +
> >>>> +    intel_dp->as_sdp_v2_supported = intel_dp->as_sdp_supported &&
> >>>> + intel_dp_sink_supports_as_sdp_v2(intel_dp);
> >>>>   }
> >>>>     static bool intel_dp_needs_dpcd_probe(struct intel_dp 
> >>>> *intel_dp, bool force_on_external)
> >>>> -- 
> >>>> 2.45.2
> >>> -- 
> >>> Ville Syrjälä
> >>> Intel

-- 
Ville Syrjälä
Intel
