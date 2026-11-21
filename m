Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82807606A69E
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gvy5dWcK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687D7112CB8;
	Sat, 21 Nov 2026 01:20:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E3011241C;
 Sat, 21 Nov 2026 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795224016; x=1826760016;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Ii1ce+EVuo3ebqLemtfM+U4XAaRApcE17zTkbabx1kw=;
 b=Gvy5dWcKgQFwwrEUyHZt42vDXesM78jhnk0lR8AJGTkRmUJRa5apdqGM
 HI+8u7ZoYSl2nyuZonGU2cX5oBLoGBxPcwoZ/Cdpos/+UR5xngV+lDPLm
 Jk/Pqanb5Bp3EyhLVhU6A57eS9gnzyKkDl7fnb/66ya6oM15++iZMVkDe
 obbiu3Wro+h6qppxtEDDVBajU306sOufLLgeOr3ahKrTsOtwWOOG3X6W9
 WLsbuC7UhciH2pkAR69ZpK/PngwPNxgMiyvCz6bp5+QrL6CYVTZ6jC3QA
 4SflcY1L+iOPKmfmz+N0K6j++g/ddQLPjS4yeK9BVJaJ5MKzc15zvovQI A==;
X-CSE-ConnectionGUID: dn0xR7rFSWe3WWpHqXx2bA==
X-CSE-MsgGUID: i2rXLrW1SbWN0yVmcBDWNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4105311"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4105311"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:20:15 -0800
X-CSE-ConnectionGUID: E1h6HjnbS7SlAladRYZMRw==
X-CSE-MsgGUID: Rb8Pzy/2TZauObKBN6l5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10818206"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:20:12 -0800
Date: Sat, 21 Nov 2026 03:20:09 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v3 2/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP
 with TCON HDR support
Message-ID: <awDxyUlkUXE3Cv7Q@intel.com>
References: <20261121005409.17626-1-fighters390@qq.com>
 <tencent_B8BA9FC944C4CE33D89D83F78E255E124606@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B8BA9FC944C4CE33D89D83F78E255E124606@qq.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 08:54:07AM +0800, Yitian Shao wrote:
> intel_dp_add_properties() attaches HDR_OUTPUT_METADATA only when the
> encoder can send a gamut metadata DIP, so pre-ICL eDP panels on port A
> never expose it even when their EDID advertises HDR.
> 
> Those panels do not use a DIP at all: the metadata is programmed through
> the Intel AUX HDR interface, and the TCON capability is already known
> because intel_edp_backlight_setup() runs before intel_dp_add_properties().
> 
> Factor the whole decision into intel_dp_hdr_metadata_supported() and let
> it accept eDP panels whose TCON advertises PQ (ST2084) decoding through
> the Intel AUX HDR backlight interface.
> 
> Since no DIP is transmitted in that case, skip computing the infoframe
> when the encoder has no gamut metadata DIP, so that the computed state
> matches what is actually programmed.
> 
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c       | 31 +++++++++++++++++--
>  .../drm/i915/display/intel_dp_aux_backlight.c |  5 +++
>  .../drm/i915/display/intel_dp_aux_backlight.h |  3 ++
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 2736a78..eeead26 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -70,6 +70,7 @@
>  #include "intel_display_types.h"
>  #include "intel_dp.h"
>  #include "intel_dp_aux.h"
> +#include "intel_dp_aux_backlight.h"
>  #include "intel_dp_hdcp.h"
>  #include "intel_dp_link_training.h"
>  #include "intel_dp_mst.h"
> @@ -3085,9 +3086,17 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
>  					    const struct drm_connector_state *conn_state)
>  {
>  	struct intel_display *display = to_intel_display(intel_dp);
> +	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
>  	int ret;
>  	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
>  
> +	/*
> +	 * Without a gamut metadata DIP there is nothing to program here; on
> +	 * pre-ICL eDP the metadata goes through the AUX HDR interface instead.
> +	 */
> +	if (!intel_dp_has_gamut_metadata_dip(encoder))
> +		return;
> +
>  	if (!conn_state->hdr_output_metadata)
>  		return;
>  
> @@ -6685,6 +6694,24 @@ intel_dp_has_gamut_metadata_dip(struct intel_encoder *encoder)
>  	return false;
>  }
>  
> +static bool intel_dp_hdr_metadata_supported(struct intel_dp *intel_dp,
> +					     struct intel_connector *connector)
> +{
> +	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
> +
> +	/* LSPCON attaches the property itself in intel_dp_connector_register() */
> +	if (intel_bios_encoder_is_lspcon(encoder->devdata))
> +		return false;
> +
> +	if (intel_dp_has_gamut_metadata_dip(encoder))
> +		return true;
> +
> +	/* Pre-ICL eDP programs the metadata via the AUX HDR interface */
> +	return intel_dp_is_edp(intel_dp) &&
> +	       intel_dp_aux_is_hdr_backlight(connector) &&
> +	       connector->panel.backlight.edp.intel_cap.supports_2084_decode;

Had to double check that we init the backlight stuff before this,
and yes we do.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> +}
> +
>  static void
>  intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connector)
>  {
> @@ -6712,9 +6739,7 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
>  		intel_attach_dp_colorspace_property(&connector->base);
>  	}
>  
> -	/* LSPCON attaches the property itself in intel_dp_connector_register() */
> -	if (!intel_bios_encoder_is_lspcon(dp_to_dig_port(intel_dp)->base.devdata) &&
> -	    intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +	if (intel_dp_hdr_metadata_supported(intel_dp, connector))
>  		drm_connector_attach_hdr_output_metadata_property(&connector->base);
>  
>  	if (HAS_VRR(display))
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index eb05ef4..8c7fd99 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -630,6 +630,11 @@ static const struct intel_panel_bl_funcs intel_dp_hdr_bl_funcs = {
>  	.get = intel_dp_aux_hdr_get_backlight,
>  };
>  
> +bool intel_dp_aux_is_hdr_backlight(const struct intel_connector *connector)
> +{
> +	return connector->panel.backlight.funcs == &intel_dp_hdr_bl_funcs;
> +}
> +
>  static const struct intel_panel_bl_funcs intel_dp_vesa_bl_funcs = {
>  	.setup = intel_dp_aux_vesa_setup_backlight,
>  	.enable = intel_dp_aux_vesa_enable_backlight,
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
> index ed60c28..1fa1b93 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.h
> @@ -6,8 +6,11 @@
>  #ifndef __INTEL_DP_AUX_BACKLIGHT_H__
>  #define __INTEL_DP_AUX_BACKLIGHT_H__
>  
> +#include <linux/types.h>
> +
>  struct intel_connector;
>  
>  int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector);
> +bool intel_dp_aux_is_hdr_backlight(const struct intel_connector *connector);
>  
>  #endif /* __INTEL_DP_AUX_BACKLIGHT_H__ */
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
