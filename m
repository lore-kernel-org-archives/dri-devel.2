Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01B606A327
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CYls7XT4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD7810E279;
	Fri, 30 Oct 2026 11:44:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E02E10E279;
 Fri, 30 Oct 2026 11:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793360665; x=1824896665;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=x8TvwLzSHqdTbx1HgAAtb/ADR1txxIEQrI2u8aFySlM=;
 b=CYls7XT4FtBzGSHj2wU9DbW89wIHZfPeVF5FqMgn8NqfUGEwU4Zd6hjC
 rIXf0ZfZg+ynXS1skX35Ithc2FfytK0utj0Xkp2n9wv/KNImj3GE9XNSE
 mxjSX8+FiAOZMUOOkXLKPHVOCxANiP1jGXJKNzmwKBiUilM3baluiKTN0
 9eXghTiBcmOjSZ/cwFv9XIIS8ylE9ygsFMlY5YBWfb+AXmSlL1N+/tMoF
 q0qKGTq0aeqNlmfAtQlYeLIoqcWiy3vDAH42vxvB8kWTPLVZ5TeSuGaRp
 mM80lQIXcIVLmOvg9dfUMOGN9ETy7py4tJQ6+NjkZeRTdFJzuCPETkB3t A==;
X-CSE-ConnectionGUID: wPJlFmIyQmCr1QolONuI2w==
X-CSE-MsgGUID: XqwjpKHXT/ivi0Z6SZhWnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2153576"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2153576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:44:25 -0700
X-CSE-ConnectionGUID: dUGh3GZZSfWnVLY/c5JscA==
X-CSE-MsgGUID: GtI3xy5jTpm+UPu/72vcvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5755803"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.58])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:44:20 -0700
Date: Fri, 30 Oct 2026 13:44:16 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drm/dp: Always use enhanced framing for DPCD r1.2+
Message-ID: <auSDEOoWZWcgbvzZ@intel.com>
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-2-dmitrymalovanyy@gmail.com>
 <auR8R7G5S8hv5R0e@intel.com>
 <59106a36510e33e851f76c877f41952b11a8c774@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59106a36510e33e851f76c877f41952b11a8c774@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 01:36:31PM +0200, Jani Nikula wrote:
> On Fri, 30 Oct 2026, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > On Thu, Oct 29, 2026 at 11:18:22AM +0100, Dmytro Malovanyi wrote:
> >> DP 1.2 section 2.2.1.1 says "An upstream device interoperating with a
> >> downstream device with DPCD Revision of 1.2 or higher must enable
> >> Enhanced Framing Mode". So for r1.2+ the DPCD revision is enough, the
> >> DP_ENHANCED_FRAME_CAP bit does not need to be checked.
> >> 
> >> Some sinks get this bit wrong. The Xiaomi Monitor A24i (P24FBA-RAGL)
> >> sets it in the base receiver caps, but clears it in the extended
> >> receiver caps at 0x2200, which are the ones we use:
> >> 
> >>   base:     12 0a c4 01 01 00 01 80 02 00 06 00 00 00 81
> >>   extended: 14 0a 44 00 01 00 01 80 02 02 06 00 00 00 81
> >> 
> >> Through a USB4 dock (CalDigit Element 5) the link trains without
> >> enhanced framing (0x202-0x204: 77 77 81), but the sink never syncs to
> >> the stream (SINK_STATUS 0x205: 00) and shows "No signal". Forcing RBR
> >> does not change it. Connected directly to the laptop the same sink
> >> syncs without enhanced framing, at RBR, HBR and HBR2.
> >> 
> >> Make drm_dp_enhanced_frame_cap() return true for DPCD r1.2+. This
> >> changes behaviour for every driver using the helper, but only for sinks
> >> which already violate the spec by not setting the bit.
> >> 
> >> Tested on i915 (Arrow Lake-U), with the dock the link now uses enhanced
> >> framing (0x101: 84) and the sink syncs (0x205: 03).
> >> 
> >> Fixes: a1d926527b79 ("drm/i915: implement EXTENDED_RECEIVER_CAPABILITY_FIELD_PRESENT")
> >> Cc: stable@vger.kernel.org
> >> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17719
> >> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> >> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
> >> ---
> >>  include/drm/display/drm_dp_helper.h | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> >> index 5b05a7fbe..4f20f60db 100644
> >> --- a/include/drm/display/drm_dp_helper.h
> >> +++ b/include/drm/display/drm_dp_helper.h
> >> @@ -160,6 +160,10 @@ drm_dp_max_lane_count(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> >>  static inline bool
> >>  drm_dp_enhanced_frame_cap(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> >>  {
> >> +	/* DP 1.2 2.2.1.1: enhanced framing is mandatory for DPCD r1.2+ */
> >
> > DP_ENHANCED_FRAME_CAP is also mandatory so I think this needs
> > a bit more detailed explanation.
> 
> Commit message not enough?

On its face the check looks completely redundant, so without further
justification someone is likely to just remove it.

> 
> I think the wording in the specs suggest that with DPCD r1.2+ you should
> just enable enhanced framing regardless of the cap.
> 
> BR,
> Jani.
> 
> >
> >> +	if (dpcd[DP_DPCD_REV] >= 0x12)
> >> +		return true;
> >> +
> >>  	return dpcd[DP_DPCD_REV] >= 0x11 &&
> >>  		(dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP);
> >>  }
> >> -- 
> >> 2.50.1 (Apple Git-155)
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel
