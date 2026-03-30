Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273641061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6061D10E28B;
	Mon, 30 Mar 2026 18:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RHbilb+j";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF7E10E28B;
 Mon, 30 Mar 2026 18:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774894768; x=1806430768;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=athuPDSh7ZDG5D7w6W9Cuq+MIohY85UXonbcz6TElBg=;
 b=RHbilb+jmYx8MJlmOCTsvITSnV0edEYKjPg9le7mc4S9bLcr2MTDb50S
 hnmIVEXQdYO9cqGS1VIpi+299bJxCIFH9izkfs9RQfsLbrAWfUWL6GzF3
 PTIXeFMjyDjwZ+o8QsPu6Mt36JpzKV8XRvRoM27jCfn5v3yGkQ1uiX/qJ
 vSabaumj9xbxSyZK7dhbVHX+JfWoV1mL0/DCyj4V7ZHyJGvyRxbT9zsau
 SlyrIZD6XI922kjDQ6mf6JSfWe+Han75+Sd/+am1DRn7gvA8pUs58sLvY
 sSCc7AY5OD/J9ojW4vxfukisU9ilSWqrtUj/6AIztwZ8oCvnDigcP3lKU A==;
X-CSE-ConnectionGUID: S7XxWoOKSueh1BobwaIX6w==
X-CSE-MsgGUID: 400cDPbJQyq0LGtW559ePA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79498628"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79498628"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:19:27 -0700
X-CSE-ConnectionGUID: BbBKv6KQR6OrkNmUY3B0kQ==
X-CSE-MsgGUID: hyeAMZ5oRbm7IDL0IHLLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="227742995"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.155])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:19:24 -0700
Date: Mon, 30 Mar 2026 21:19:22 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 04/19] drm/dp: Add DPCD for configuring AS SDP for PR + VRR
Message-ID: <acq-qi3C8B8rQ4o8@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
 <20260330040656.4116502-5-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330040656.4116502-5-ankit.k.nautiyal@intel.com>
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

On Mon, Mar 30, 2026 at 09:36:41AM +0530, Ankit Nautiyal wrote:
> Add additional DPCDs required to be configured to support VRR with Panel
> Replay. These DPCDs are specifically required for configuring Adaptive Sync
> SDP and are introduced in DP v2.1.
> 
> v2:
>  - Correct the shift for the bits. (Ville)
>  - Add DP_PR_ prefix for the PR-related fields.
> v3:
>  - Use macro values in their shifted form to match the convention (Ville)
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  include/drm/display/drm_dp.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 8d172863eba3..93a188113d36 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -775,6 +775,11 @@
>  # define DP_PANEL_REPLAY_SU_Y_GRANULARITY_EXTENDED_VAL_SEL_MASK  (0xf << 3)
>  # define DP_PANEL_REPLAY_SU_REGION_SCANLINE_CAPTURE		 (1 << 7)
>  
> +#define PANEL_REPLAY_CONFIG3				0x11a /* DP 2.1 */

I would still define a DP_PR_AS_SDP_SETUP_TIME_MASK here, to
make it clear which bits are part of this.

With that
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +# define DP_PR_AS_SDP_SETUP_TIME_T1			(0 << 6)
> +# define DP_PR_AS_SDP_SETUP_TIME_DYNAMIC		(1 << 6) /* DP 2.1 Table 2-227 */
> +# define DP_PR_AS_SDP_SETUP_TIME_T2			(2 << 6)
> +
>  #define DP_PAYLOAD_ALLOCATE_SET		    0x1c0
>  #define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT 0x1c1
>  #define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT 0x1c2
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
