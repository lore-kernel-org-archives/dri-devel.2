Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D70CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D651D10E1F3;
	Mon,  1 Jun 2026 10:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YN7LAJIQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F1810E17F;
 Mon,  1 Jun 2026 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780311277; x=1811847277;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=vl8pAI1oik1lLhgRq6fMHBXq4BU0JIxGE8qnAnuXtKQ=;
 b=YN7LAJIQJ3cKt4udrHZDZyj2/et0xs1DtLG5Aam5TNE1uilRvV8uv9Ac
 KRByOqchXwmX92RGvenz6pOqNUoauB+7762+/VTTnqFjWeHGXz6DliPIZ
 NUKEoPjdT3rR1Hcfex6FScKvFT3n85or2IWq7ceSQ3OVj7RC2RxcITzhs
 SLVW/MPj0yx+KJikGZlRHb/UMAz0w04Ei5c7OstINrIfPOXAg5QuzeAzA
 KgtMklHnCWGMmElFLfrQB0g53qxWAW5dukfUXn1ple7vq8SYbALvcgjh9
 t18yb1oaMRRGH2WqEdGV7S+962zfI0rmFKrRkC/X7qpHOdiP9FRrGtyqV A==;
X-CSE-ConnectionGUID: JPJCI2xJTvKUeKIB7ZwzgQ==
X-CSE-MsgGUID: FijYYzvqQ1efGpQLVoFspw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81251485"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="81251485"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 03:54:36 -0700
X-CSE-ConnectionGUID: LYPia3kJRLujVbnAOjaOig==
X-CSE-MsgGUID: DCBerR4HSZ2qVSztYFNrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="242496604"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.121])
 by orviesa006-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:54:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jens Glathe via B4 Relay
 <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jens Glathe
 <jens.glathe@oldschoolsolutions.biz>
Subject: Re: [PATCH] drm/msm/dp: add EDID re-read retry in
 msm_dp_panel_get_modes()
In-Reply-To: <20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz>
Date: Mon, 01 Jun 2026 13:54:29 +0300
Message-ID: <9e20789b198624172bd87649370de52e26c79a70@intel.com>
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

On Sun, 31 May 2026, Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org> wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>
> drm_edid_read_ddc() can return a structurally valid EDID from which
> drm_edid_connector_add_modes() still returns zero modes. This triggers
> the error:

What are the EDID contents in that case?

Where does it originate from? A valid but "not what you wanted" EDID
doesn't show up from thin air.

Perhaps it's the hub/adapter replying with some placeholder EDID instead
of the actual sink EDID. Maybe it's the timing and/or ordering.

Feels like root causing would be in order before adding hacks like this
that are notoriously difficult to remove in the future, and will easily
block future progress.


BR,
Jani.


>
>   [drm:msm_dp_bridge_get_modes [msm]] *ERROR* failed to get DP sink
>    modes, rc=0
>
> even though the link is ready. Since the EDID is only read once, this
> error persists and the display comes up with 640x480 resolution.
>
> Add a retry of drm_edid_read_ddc() inside get_modes() when the initial
> read produces no usable modes. The bad EDID is freed before retrying
> and container_of ensures access to the DDC channel. This directly
> addresses the observed "valid but empty/garbage" EDID case on
> flaky DP plugs and adapters.
>
> I tested this on a few of my "flaky" type-c to HDMI adapters and hubs,
> getting no "retry failed" messages and the desired resolution. Without
> the patch most plugs would result in 640x480 external display.
>
> Fixes: [5bea90ad9743d2] "drm/msm/dp: switch to struct drm_edid"
>
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> ---
>  drivers/gpu/drm/msm/dp/dp_panel.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index 6bb021820d7c5..4f27c8129b0ef 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -327,11 +327,39 @@ u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
>  int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
>  	struct drm_connector *connector)
>  {
> +	int modes;
> +	int retry;
> +	struct msm_dp_panel_private *panel;
> +
>  	if (!msm_dp_panel) {
>  		DRM_ERROR("invalid input\n");
>  		return -EINVAL;
>  	}
>  
> +	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
> +
> +	if (msm_dp_panel->drm_edid) {
> +		modes = drm_edid_connector_add_modes(connector);
> +		if (modes > 0)
> +			return modes;
> +
> +		drm_edid_free(msm_dp_panel->drm_edid);
> +		msm_dp_panel->drm_edid = NULL;
> +	}
> +
> +	for (retry = 0; retry < 5; retry++) {
> +		usleep_range(20000, 25000);
> +		msm_dp_panel->drm_edid =
> +			drm_edid_read_ddc(connector, &panel->aux->ddc);
> +		if (msm_dp_panel->drm_edid)
> +			break;
> +
> +		drm_dbg_dp(connector->dev,
> +			   "get_modes re-read attempt %d/5 failed\n",
> +			   retry + 1);
> +	}
> +
> +	drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
>  	if (msm_dp_panel->drm_edid)
>  		return drm_edid_connector_add_modes(connector);
>  
>
> ---
> base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
> change-id: 20260531-drm_plug_flaky_edid-cc7743f6f909
>
> Best regards,

-- 
Jani Nikula, Intel
