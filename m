Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E751606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZdH29Y/0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E154810E436;
	Tue, 27 Oct 2026 16:01:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35BE10E42C;
 Tue, 27 Oct 2026 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793116912; x=1824652912;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=cnKGQub8k6I5KbpY3IhTo61JJaGvGhoQaELSxpRDWkQ=;
 b=ZdH29Y/05QmM8IPZOXVij0/FtAxqnqY6uVg2WucCW69di3+kXMTa2Nbb
 F8oZSVe7crHhSnFBwL7UWtfnL7xa/ivdUQNfftncBxXCVyN3tiUURMVY4
 jIjxQc+cqBo5kF6cCIaR5U3yPYNiCk3F8lCRoY+seMSYaSFegOMuzBn1T
 bLzHcgGIUVWjMMDm9XYAcNLyXAYKOxi9RnYVkkJHMmubG2Ew+BLrlWFi+
 siF0c6HXF2erBmInGHC1s9TNW5eSMC1mwVkKavnQ0Kk6KqhbcJGw3KUKP
 +IczFuvJzLMxAztqEBX+1fMNx2UIa0pKiyHrn/M2I34rFaXFYL6fTGpbI Q==;
X-CSE-ConnectionGUID: 41XKq273TyOlArJBcudGSA==
X-CSE-MsgGUID: 1vA9GohcSCu4iy948y30eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1821140"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1821140"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 09:01:50 -0700
X-CSE-ConnectionGUID: a9rsPqPHQAS3LLJ+C67jpg==
X-CSE-MsgGUID: MTt3iYasReqK6Fb5N0Z01A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6340335"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.247])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 09:01:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: George Karagounis <taterraster@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mail@taterr.org
Subject: Re: [PATCH] drm/i915/dp: Remove redundant link capabilities reset
In-Reply-To: <20261025113200.25097-1-mail@taterr.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261025113200.25097-1-mail@taterr.org>
Date: Tue, 27 Oct 2026 18:01:44 +0200
Message-ID: <5d85c3ed4cf4b8b5e218cc2d1f49b8f44675e18d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026, George Karagounis <taterraster@gmail.com> wrote:
> intel_dp_link_caps_update(reset=true) is already called prior to intel_dp_reset_link_params(), making the explicit call to intel_dp_link_caps_reset() redundant. Remove it as requested by the existing TODO comment to clean up the link parameter reset flow.

Are you testing your changes or is this just using LLM to address TODO
comments in the code?

>
> Signed-off-by: George Karagounis <mail@taterr.org>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index d8c0d9381471..0e753824bc28 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3674,17 +3674,10 @@ void intel_dp_set_link_params(struct intel_dp *intel_dp,
>  
>  void intel_dp_reset_link_params(struct intel_dp *intel_dp)
>  {
> -	/*
> -	 * TODO: Remove the following reset of link capabilities, as
> -	 * this isn't needed after intel_dp_link_caps_update(reset=true)
> -	 * was called.
> -	 */
> -	intel_dp_link_caps_reset(intel_dp->link.caps);
> -	intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
> -
> -	intel_dp->link.mst_probed_lane_count = 0;
> -	intel_dp->link.mst_probed_rate = 0;
> -	intel_dp_link_training_reset(intel_dp->link.training);
> +       intel_dp_tunnel_uhbr_lanes_wa_apply(intel_dp);
> +       intel_dp->link.mst_probed_lane_count = 0;
> +       intel_dp->link.mst_probed_rate = 0;
> +       intel_dp_link_training_reset(intel_dp->link.training);

Please use checkpatch.

>  }
>  
>  /* Enable backlight PWM and backlight PP control. */

-- 
Jani Nikula, Intel
