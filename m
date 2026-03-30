Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FAA1061B1A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FD310E6FC;
	Mon, 30 Mar 2026 18:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZheuUBU7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4600B10E681;
 Mon, 30 Mar 2026 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774896272; x=1806432272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=s2k2KDdOHbpajJSKWNzaaHncrxcYkhCkHfd+HYIT8xk=;
 b=ZheuUBU7YxKNjdcRQRvBGWZhReac83hwjkRmKVNQov6lNzGvhg/pW5Zb
 nL42s6eY+bmQg9Zf0MRUFeIzUzbIrVnHt7++dbwb4XHsApv2pvDB0bBoM
 MCYckm3H5xCIHOkI+97o+BtQPguTPa6tIRASYZu6NaPv9bfHUbTC0SzwU
 BwtzCp7FjPOPNW2q0LsQQDoRZFzZhNpYVBTTX65IhGQDS96rV9l0M4uUp
 q0kfXrG6329iXFt0JmOHHSs+U99TQ0SZBByJZ+I380+vmp0fx77xB++73
 RXw9eiKAHzCOG9RrOnN1YHSUxHUxSeZMfTlNDrDQkBWHJUDMTkvNxUqSF A==;
X-CSE-ConnectionGUID: D4ib3xIpT5y+FHdeuD1qkQ==
X-CSE-MsgGUID: TPuLV6RKTB2VppGPslYg2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93481130"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="93481130"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:44:31 -0700
X-CSE-ConnectionGUID: 2j7HGIV+TGeNbwBN4hPvIA==
X-CSE-MsgGUID: O9ws8MdoTSOH7e9PSPtsJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="230599356"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.155])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 11:44:30 -0700
Date: Mon, 30 Mar 2026 21:44:26 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 13/19] drm/i915/psr: Write the PR config DPCDs in burst
 mode
Message-ID: <acrEiglyKjnRZA0Q@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
 <20260330040656.4116502-14-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330040656.4116502-14-ankit.k.nautiyal@intel.com>
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

On Mon, Mar 30, 2026 at 09:36:50AM +0530, Ankit Nautiyal wrote:
> Replace the consecutive single-byte writes to PANEL_REPLAY_CONFIG and
> CONFIG2 with one drm_dp_dpcd_write() burst starting at PANEL_REPLAY_CONFIG,
> reducing AUX transactions.
> 
> v2: Drop extra conditions, and optimize variables. (Ville)
> 
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_psr.c | 29 ++++++++++++++----------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 2f1b48cd8efd..ca054135ca30 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -782,27 +782,32 @@ static bool psr2_su_region_et_valid(struct intel_connector *connector, bool pane
>  static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
>  				      const struct intel_crtc_state *crtc_state)
>  {
> -	u8 val = DP_PANEL_REPLAY_ENABLE |
> -		DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
> -		DP_PANEL_REPLAY_UNRECOVERABLE_ERROR_EN |
> -		DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
> -		DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
> -	u8 panel_replay_config2 = DP_PANEL_REPLAY_CRC_VERIFICATION;
> +	struct intel_display *display = to_intel_display(intel_dp);
> +	u8 panel_replay_config[2];
> +	int ret;
> +
> +	panel_replay_config[0] = DP_PANEL_REPLAY_ENABLE |
> +				 DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
> +				 DP_PANEL_REPLAY_UNRECOVERABLE_ERROR_EN |
> +				 DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
> +				 DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
> +	panel_replay_config[1] = DP_PANEL_REPLAY_CRC_VERIFICATION;
>  
>  	if (crtc_state->has_sel_update)
> -		val |= DP_PANEL_REPLAY_SU_ENABLE;
> +		panel_replay_config[0] |= DP_PANEL_REPLAY_SU_ENABLE;
>  
>  	if (crtc_state->enable_psr2_su_region_et)
> -		val |= DP_PANEL_REPLAY_ENABLE_SU_REGION_ET;
> +		panel_replay_config[0] |= DP_PANEL_REPLAY_ENABLE_SU_REGION_ET;
>  
>  	if (crtc_state->req_psr2_sdp_prior_scanline)
> -		panel_replay_config2 |=
> +		panel_replay_config[1] |=
>  			DP_PANEL_REPLAY_SU_REGION_SCANLINE_CAPTURE;
>  
> -	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG, val);
> +	ret = drm_dp_dpcd_write(&intel_dp->aux, PANEL_REPLAY_CONFIG,
> +				panel_replay_config, sizeof(panel_replay_config));
>  
> -	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG2,
> -			   panel_replay_config2);
> +	if (ret != sizeof(panel_replay_config))
> +		drm_dbg_kms(display->drm, "Failed to write Panel Replay Configs\n");

Looks like we don't actually check for errors on any of the
other DPCD accesses here. So I'd probably drop it here as well.

Either way
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  }
>  
>  static void _psr_enable_sink(struct intel_dp *intel_dp,
> -- 
> 2.45.2

-- 
Ville Syrjälä
Intel
