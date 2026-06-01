Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03528CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682D01131C7;
	Mon,  1 Jun 2026 10:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ViGaO25U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96AA1131A7;
 Mon,  1 Jun 2026 10:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780311467; x=1811847467;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=SENj6mQt3J3p63B2Cfwtu91pY2xE/PRwC/9bAfUJe94=;
 b=ViGaO25U2/FdYG3o1ry3Ehas6TFuYDYp2Cie8A9xRBkOhunnFRrCgsZ9
 8oCI4wBP/EOAbcSNQhgQmmUvlZPcecgA/A6Bl9rrkeiEwS6PXV1rMBkIh
 puzWTvNOGS7klXUua/KpBOk+5wIBonk0FpzZeoWwd9yqi4RhduBw20/gy
 hpqRYmjnFK6bE3iyhzXSqBZrlAyXj7m800EVIaqh0XMe6PDA1NBW0u3NK
 ZKkKqypt1PD/4Bi4k+UP+73ymRF8Hs5bbBtcpE8YYtA4M0gaw+jI6z38X
 6KJG7q4+VBU3W3YFwK5JM3BxEXe4Vpr2YkXVf7vT0xpUziXyUKnYMo4si g==;
X-CSE-ConnectionGUID: bFVFmYGvSJ+UjB+E9J9XtQ==
X-CSE-MsgGUID: BUvFbaGXQ062VqyUju0/Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91376561"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="91376561"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 03:57:47 -0700
X-CSE-ConnectionGUID: gezfP2+aT/WzG+HhXomp7g==
X-CSE-MsgGUID: QUrIEYc3Svyh39Wbd/WxmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="247510567"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.121])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 03:57:42 -0700
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
Date: Mon, 01 Jun 2026 13:57:39 +0300
Message-ID: <d50293fab9e6292220b1817a8e85bbd89743b708@intel.com>
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

Did you actually bisect to this commit? It's a bit of a surprise.

Side note, the Fixes: trailer has a strict format. Please look at git
logs for what it should be like.

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
