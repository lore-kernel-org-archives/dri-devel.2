Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FAAC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C22BD10F8FD;
	Fri, 10 Jul 2026 13:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="de4Ouaaw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFC010F8FD;
 Fri, 10 Jul 2026 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783691773; x=1815227773;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1zDQP5MqeICwEWXqZNgbmF3qVwqgkJvVmMymABthOZk=;
 b=de4OuaawLANIUPuzhUg/vhpI5ou+jBB1VPZlwXeLG/+DvjNMlVcz8PIh
 uyjdv/hUwFlEcEwEv2kz07gGZ35F2QbXhbFMs4NFouK1KPQVFVFLjOcc1
 6oaGMeO57b7sqAbcIMaInXA7ouZv3l0YwpCIFmSf86mkyt45dh71ggoQA
 AqrEYookLj/r6Cx9Fn0hr5JxZPNQKZ43oxez9Z6b9OyVPlRlcw9zfuVq3
 TcwWa/Yg2MFRQshlhRPEeJxtbM+++BF2suDTcwOphVjDgW0hOWve61MvN
 7irXoq2GgNwrG26toLy65ap0KpjjnCsArSpEJABbxiizCXs7lG4L/yLxN A==;
X-CSE-ConnectionGUID: mshMHfIeSQKybOIHis232g==
X-CSE-MsgGUID: fPGFcxKaSRSyT8I71fCRoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84170381"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="84170381"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 06:56:09 -0700
X-CSE-ConnectionGUID: C6roA56YRmiSdgI3S9XyMg==
X-CSE-MsgGUID: REZWLaOCQ+6LwLxRPCpnEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="253157307"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 06:56:05 -0700
Date: Fri, 10 Jul 2026 16:56:02 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "LIOU, Mei Fan" <mei.fan.liou@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Arun R Murthy <arun.r.murthy@intel.com>
Subject: Re: [PATCH] drm/i915: skip eDP hw probe when connector forced off
 via cmdline
Message-ID: <alD58t0ihoGmzbj7@intel.com>
References: <20260707085704.14519-1-mei.fan.liou@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707085704.14519-1-mei.fan.liou@intel.com>
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

On Tue, Jul 07, 2026 at 04:57:04PM +0800, LIOU, Mei Fan wrote:
> When eDP connector is forced off (video=eDP-1:d),
> intel_edp_init_connector() ignores the force flag and still probes
> the AUX channel for DPCD and EDID.
> 
> video=eDP-1:d sets connector->force = DRM_FORCE_OFF via
> drm_connector_get_cmdline_mode() inside drm_connector_init_with_ddc(),
> which logs 'forcing eDP-1 connector off'. However,
> intel_edp_init_connector() is called immediately after and ignores
> the force flag, so AUX/PPS probing still occurs.
> 
> Fix this by checking connector->base.force == DRM_FORCE_OFF in
> intel_edp_init_connector() after the intel_dp_is_edp() check, before
> any AUX/DPCD probing is attempted. When the connector is forced off,
> log an informational message and goto out_vdd_off to properly clean
> up PPS state and skip all remaining hardware probing.
> 
> Suggested-by: Arun R Murthy <arun.r.murthy@intel.com>
> Signed-off-by: LIOU, Mei Fan <mei.fan.liou@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 3569e61e7fee..fa61b299f83e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -7057,6 +7057,17 @@ static bool intel_edp_init_connector(struct intel_dp *intel_dp,
>  
>  	intel_alpm_init(intel_dp);
>  
> +	/*
> +	 * If the connector has been forced off via the kernel cmdline
> +	 * (e.g. video=eDP-1:d), skip DPCD/AUX probing.
> +	 */
> +	if (connector->base.force == DRM_FORCE_OFF) {
> +		drm_info(display->drm,
> +			 "[ENCODER:%d:%s] eDP disabled via cmdline, skipping eDP init\n",
> +			 encoder->base.base.id, encoder->base.name);
> +		goto out_vdd_off;
> +	}

This doesn't looks sane if the eDP panel is actually there. We need to
turn it off gracefully.

> +
>  	/* Cache DPCD and EDID for edp. */
>  	has_dpcd = intel_edp_init_dpcd(intel_dp, connector);
>  
> -- 
> 2.52.0

-- 
Ville Syrjälä
Intel
