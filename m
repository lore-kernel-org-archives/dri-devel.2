Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72003105F78C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D785F10EBB9;
	Fri, 13 Mar 2026 11:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eerrObw7";
	dkim-atps=neutral
Received: from mgamail.intel.com (unknown [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51BE10EBB9;
 Fri, 13 Mar 2026 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773402755; x=1804938755;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nsSVLwekEg5ts65/VQP6i0HhmKjpYMLekMNHTWHgWfc=;
 b=eerrObw7Jwta4Su7Aq5bwC5sJYdnL/I0UWjnf1CmrRyjdAD+tZ+Pnt9K
 ljmJEiZq638EmkQnFZcLmN6me9sthQDv9fqD6Da6zNfHn3M4WrYddTOiS
 nFTZUpxUEaz1Kmawac2zn6UuiXo7CYLGRPoMup797S6RcfhxeS9zuTgSl
 PM51avs3jmCgyxgnJeJqGNHqZ7ixGQVUMjmw/7DuKrXufsaygaunZiAjV
 3w+6HF7t6R8DbfQm4kRGj3X/wl13gM4JDXGK7Z2BpGP8x2OKBTZjuitCu
 viLnNNo1Ic8YaXciAMja1H66Jfpu/KdbuaiZzLA2rJUFY8+I3KC4L3wkJ g==;
X-CSE-ConnectionGUID: FS6u1V5UR+uOpXusdv2gdw==
X-CSE-MsgGUID: 969NqvreS8+q2a8bQ9uPMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="78106706"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="78106706"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 04:52:25 -0700
X-CSE-ConnectionGUID: u/miGJT5RE+mLJ9OW0hcGg==
X-CSE-MsgGUID: 0xUlyZN3SMixC8yrdEIciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; d="scan'208";a="220402411"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.21])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 04:52:22 -0700
Date: Fri, 13 Mar 2026 13:52:19 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 04/19] drm/dp: Add DPCD for configuring AS SDP for PR + VRR
Message-ID: <abP6czXUF_LuCBSi@intel.com>
References: <20260311113611.3393194-1-ankit.k.nautiyal@intel.com>
 <20260311113611.3393194-5-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311113611.3393194-5-ankit.k.nautiyal@intel.com>
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

On Wed, Mar 11, 2026 at 05:05:56PM +0530, Ankit Nautiyal wrote:
> Add additional DPCDs required to be configured to support VRR with Panel
> Replay. These DPCDs are specifically required for configuring Adaptive Sync
> SDP and are introduced in DP v2.1.
> 
> v2:
>  - Correct the shift for the bits. (Ville)
>  - Add DP_PR_ prefix for the PR-related fields.
> 
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  include/drm/display/drm_dp.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/drm/display/drm_dp.h b/include/drm/display/drm_dp.h
> index 8d172863eba3..e6752a92d5dc 100644
> --- a/include/drm/display/drm_dp.h
> +++ b/include/drm/display/drm_dp.h
> @@ -775,6 +775,15 @@
>  # define DP_PANEL_REPLAY_SU_Y_GRANULARITY_EXTENDED_VAL_SEL_MASK  (0xf << 3)
>  # define DP_PANEL_REPLAY_SU_REGION_SCANLINE_CAPTURE		 (1 << 7)
>  
> +#define PANEL_REPLAY_CONFIG3				0x11a /* DP 2.1 */
> +# define DP_PR_AS_SDP_SETUP_TIME_SHIFT			6
> +# define DP_PR_AS_SDP_SETUP_TIME_MASK			(3 << DP_PR_AS_SDP_SETUP_TIME_SHIFT)
> +# define DP_PR_AS_SDP_SETUP_TIME_T1			0
> +# define DP_PR_AS_SDP_SETUP_TIME_DYNAMIC		1 /* DP 2.1 Table 2-227 */
> +# define DP_PR_AS_SDP_SETUP_TIME_T2			2

The usual rule in drm_dp.h seems to be to define the values
as already shifted.

> +# define DP_PR_AS_SDP_SETUP_TIME(t)			(((t) << DP_PR_AS_SDP_SETUP_TIME_SHIFT) & \
> +							 DP_PR_AS_SDP_SETUP_TIME_MASK)
> +
>  #define DP_PAYLOAD_ALLOCATE_SET		    0x1c0
>  #define DP_PAYLOAD_ALLOCATE_START_TIME_SLOT 0x1c1
>  #define DP_PAYLOAD_ALLOCATE_TIME_SLOT_COUNT 0x1c2
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
