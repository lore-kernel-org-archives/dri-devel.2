Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CB5606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FPfAn8H+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A911F10E92D;
	Fri, 20 Nov 2026 14:52:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC7A112B1E;
 Fri, 20 Nov 2026 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795186324; x=1826722324;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4aUNRpzpUHOA2WBVt36u5TkQHUkL0JD3fODzWcLuJHw=;
 b=FPfAn8H+GmcKC9cwyoWSgc7sTisij7R9wRzHYnsgft8OZb5HOzfG42C2
 h5c+XoNvX6YedNdWdZwNAFvITZbbRqiWCLjCY8bZ6pVfCh0wGa75PQDuz
 dj8OBMXkrgLCEc8YRvAgsGFWW36h+st2rTrNGPhlSAGcgIFvcGYsNCceU
 V3+hBT+vc0C14UltvSCKsiID6elPK8b96QsWyG9eV9OloqpnQ0Gskh/7d
 LhXtX0ex7kn/zmrZ0r2/LE18Mf1FYCh1HJxhZ9LG3v2qz460T5Mlw9eYG
 RvRprs8fyJc2B5LTyHlNNNPOdFuCVF8w3JwXMrmOuuAEJ3pWysR+W/aM4 Q==;
X-CSE-ConnectionGUID: c9DzG4fVRyiBq6dAmKGpVA==
X-CSE-MsgGUID: bNTX6+r0SB6USrXra4UlcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3911894"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3911894"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 06:52:03 -0800
X-CSE-ConnectionGUID: HkIk7VwwRvydOg+i154uHw==
X-CSE-MsgGUID: sF8VrcJrT0qDeruswAtGkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="10530563"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 06:52:01 -0800
Date: Fri, 20 Nov 2026 16:51:57 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON
 supports HDR
Message-ID: <awBejWRhQ7VQSL45@intel.com>
References: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
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

On Fri, Nov 20, 2026 at 01:50:48PM +0800, Yitian Shao wrote:
> intel_dp_has_gamut_metadata_dip() returns false for port A on pre-ICL
> platforms. intel_dp_add_properties() uses that helper to decide whether
> to attach the HDR_OUTPUT_METADATA connector property, so eDP panels on
> those platforms never expose it even when the panel advertises HDR in
> its EDID.
> 
> On such panels the HDR metadata is not sent as a gamut metadata SDP, but
> programmed through the Intel AUX HDR interface instead. The TCON is
> already probed during intel_edp_backlight_setup(), which runs before
> intel_dp_add_properties(), so the capability is known at that point.
> 
> Attach the property when the panel's TCON advertises PQ (ST2084) decode
> support, so that userspace can enable HDR on these panels.
> 
> Since no SDP is transmitted in that case, also bail out early from
> intel_dp_compute_hdr_metadata_infoframe_sdp() when the encoder cannot
> send gamut metadata. Otherwise the computed infoframe state would be
> inconsistent with what is actually programmed, and the state checker
> would complain.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/10415
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
> Reviewer notes, not part of the commit message:
> 
> Tested on a CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP panel that
> advertises BT2020 + ST2084 in its EDID. With this change the connector gains
> the HDR_OUTPUT_METADATA property, GNOME 50 exposes the HDR switch, and the
> panel enters PQ/BT2020 mode (the DP Colorspace property switches to
> BT2020_RGB). The Intel TCON HDR backlight interface was already in use before
> this change, so the hardware path existed and only the property was missing.
> 
> Two things I am not sure about:
> 
> 1. intel_dp_aux_write_content_luminance() also returns early when
>    !intel_dp_has_gamut_metadata_dip(), which is exactly the PORT_A case where
>    the AUX path is used. max_cll/max_fall therefore never reach the TCON. In
>    my testing Mutter sends all-zero mastering metadata anyway, so I could not
>    tell whether this shows up in practice. Should this check be relaxed too,
>    or is it intentional?

My reading of the "spec" is that we should do the content luminance
write. On the platforms where the SDP is used, I believe the SDP
should actually take precedence over the DPCD based information.

> 
> 2. panel->backlight.edp.intel_cap shares a union with the VESA backlight
>    info, so supports_2084_decode would read unrelated bits if the VESA
>    interface had been selected instead of the Intel one. Would you prefer an
>    explicit "Intel HDR backlight is in use" check here?

Yeah, we probably want that. Maybe a small helper function that does all
the checks we need, so as to not clog up the if-statement too much.

> 
>  drivers/gpu/drm/i915/display/intel_dp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index afd4169..49142f4 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -3088,6 +3088,9 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
>  	int ret;
>  	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
>  
> +	if (!intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +		return;
> +
>  	if (!conn_state->hdr_output_metadata)
>  		return;
>  
> @@ -6715,7 +6718,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
>  		intel_attach_dp_colorspace_property(&connector->base);
>  	}
>  
> -	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> +	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base) ||
> +	    (intel_dp_is_edp(intel_dp) &&
> +	     connector->panel.backlight.edp.intel_cap.supports_2084_decode))
>  		drm_connector_attach_hdr_output_metadata_property(&connector->base);
>  
>  	if (HAS_VRR(display))
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
