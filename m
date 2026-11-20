Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA9606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oG7JIY1B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B78112B53;
	Fri, 20 Nov 2026 16:10:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2503C10E16C;
 Fri, 20 Nov 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795191010; x=1826727010;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/4nZzDCmQZxoUOyX8zA2Wr0ex3XpKyr80j56l/B4zxE=;
 b=oG7JIY1BTh2cljiSbTYhLqAlrYFWN5hsFvxn618tyOpt8/ARsbtOVUru
 uD2XtlQWo7alcX2Xs9r/jCU+A7EjnW3be3zSgR4r2D0gpKTcVPdqgFJor
 j9Ce7+VgMnWooUeIsKaxEbgQs+synmKx/Tz7s6OJe1TRZZ7ESypEvm0IE
 4Yk+LX6jwcY2/jdYhMl7cw2P8SgBRpIkQPHyl7IUJmw75HOrQAIEBh+es
 x/J/5vmb1xtNuZlnfxrvSCsKCphmeT2hqvajGmceM2LfGSHMb7Q2RSCk8
 UNlZXuN/gBUQRz5Kf6ymFzF6u12mn0sg3Ara0O9jOHFJaW9Q6kg+te+R7 w==;
X-CSE-ConnectionGUID: UC3IaLfuSmSHEFirsvZoow==
X-CSE-MsgGUID: VDnC2hQwTSqlcjYk7H3nkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4064630"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4064630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 08:10:09 -0800
X-CSE-ConnectionGUID: lu37WXorTmOTPGCAL8j8bw==
X-CSE-MsgGUID: PvTnga3zRDqFFgLgpiSkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11061698"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 08:10:07 -0800
Date: Fri, 20 Nov 2026 18:10:04 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yitian Shao <fighters390@qq.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON
 supports HDR
Message-ID: <awBw3DlWwFrl16Vw@intel.com>
References: <tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com>
 <sashiko-outbox-224547@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-224547@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:15:06AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] drm/i915/dp: broken LSPCON HDR in
>   intel_dp_compute_hdr_metadata_infoframe_sdp()
> - [Medium] drm/i915/dp: unchecked union read of intel_cap in
>   intel_dp_add_properties()
> - [Medium] drm/i915/dp: fastset skips TCON HDR update when SDP
>   computation is bypassed
> --
> 
> commit ee42402ceca82543288507d878602e90d81ac27f
> Author: Yitian Shao <fighters390@qq.com>
> 
> drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP when TCON supports HDR
> 
> This commit attaches the HDR_OUTPUT_METADATA property on eDP connectors
> whose TCON supports PQ (ST2084) decoding via the Intel AUX HDR interface,
> and skips computing the HDR metadata infoframe SDP when the encoder does
> not support gamut metadata DIP.
> 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 47741957935ae..3faa5ddb4c60b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -3239,6 +3239,9 @@ intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_dp *intel_dp,
> >  	int ret;
> >  	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
> >  
> > +	if (!intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> > +		return;
> > +
> >  	if (!conn_state->hdr_output_metadata)
> >  		return;
> 
> [Severity: High]
> Does this break HDR metadata transmission on LSPCON outputs?
> 
> intel_dp_has_gamut_metadata_dip() unconditionally returns false when
> intel_bios_encoder_is_lspcon(encoder->devdata) is true, because LSPCON
> connectors defer attaching HDR_OUTPUT_METADATA until
> intel_dp_connector_register() probes intel_lspcon_detect_hdr_capability().
> LSPCON encoders still rely on intel_dp_compute_hdr_metadata_infoframe_sdp()
> to populate crtc_state->infoframes.drm.drm and enable
> HDMI_PACKET_TYPE_GAMUT_METADATA in crtc_state->infoframes.enable for
> lspcon_write_infoframe().  With this check, HDR metadata is never computed
> or sent on LSPCON ports, and the state checker will report an infoframe
> mismatch if VIDEO_DIP_ENABLE_GMP_HSW was already active.

Looks legit. I think the correct solution would be to drop
the LSPCON check from has_gamut_metadata_dip() since it's
clearly nonsense. But then intel_dp_add_properties()
will need to do the LSPCON check itself so that it doesn't
attache the HDR metadata to the LSPCON there.

And I think for good measure we also want to add a 
has_gamut_metadata_dip() check into
intel_lspcon_detect_hdr_capability(), just in case someone
has ever hooked up an on board LSPCON to a port that doesn't
support that DIP. This should be a separate patch though
since it's a separate pre-existing issue.

> 
> [Severity: Medium]
> When intel_dp_compute_hdr_metadata_infoframe_sdp() returns early on pre-ICL
> port A eDP panels, can a fastset skip programming the TCON HDR parameters?
> 
> When userspace toggles HDR_OUTPUT_METADATA,
> intel_digital_connector_atomic_check() sets crtc_state->mode_changed = true,
> and on platforms with gamut metadata DIP the resulting change in
> crtc_state->infoframes.enable causes intel_pipe_config_compare() to reject
> fastset and run a full modeset.  Returning early here leaves
> crtc_state->infoframes.enable unchanged, so commits without another pipe
> config change are downgraded to a fastset (update_pipe).  On the fastset
> path, intel_ddi_update_pipe_dp() calls intel_backlight_update(), which only
> calls __intel_backlight_enable() -> intel_dp_aux_hdr_enable_backlight()
> when !panel->backlight.enabled:

This looks correct as well. And I think it highlights that our HDR
metadata fastset support is already broken. Well, it kinda works
for changing the metadata (except when the backlight interface is
involved as is the case here), but not for switching between HDR
and SDR modes.

I say "kinda works" above because in general the whole .update_pipe()
thing is a half baked hack. There is no real consideration for any
differences in double buffering behaviour of DIPs (or a complete lack
of double buffering as is the case for many DIPs). .update_pipe() is
also called outside the vblank evasion critical section, so even
the double buffered DIPs (or anything else we do there) will probably
not sync up with the rest of the atomic commit on the CRTC.

So how to fix this specific AUX backlight problem... Maybe we need
a crtc_state->backlight_changed or something? This might in fact
also be relevant for the recently proposed LUMINANCE connector
property (which I've not had any time to actually consider).

> 
> drivers/gpu/drm/i915/display/intel_backlight.c:intel_backlight_update() {
>     ...
> 	mutex_lock(&display->backlight.lock);
> 	if (!panel->backlight.enabled)
> 		__intel_backlight_enable(crtc_state, conn_state);
> 
> 	mutex_unlock(&display->backlight.lock);
>     ...
> }
> 
> Because panel->backlight.enabled is already true on an active panel,
> INTEL_EDP_HDR_GETSET_CTRL_PARAMS is never updated in the TCON.
> 
> > @@ -7018,7 +7021,9 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *_connec
> >  		intel_attach_dp_colorspace_property(&connector->base);
> >  	}
> >  
> > -	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base))
> > +	if (intel_dp_has_gamut_metadata_dip(&dp_to_dig_port(intel_dp)->base) ||
> > +	    (intel_dp_is_edp(intel_dp) &&
> > +	     connector->panel.backlight.edp.intel_cap.supports_2084_decode))
> >  		drm_connector_attach_hdr_output_metadata_property(&connector->base);
> >  
> >  	if (HAS_VRR(display))
> 
> [Severity: Medium]
> Can reading connector->panel.backlight.edp.intel_cap.supports_2084_decode
> here access the wrong union member when the VESA eDP AUX backlight
> interface is selected?
> 
> In struct intel_panel, panel.backlight.edp is an untagged union between
> vesa and intel_cap:
> 
> drivers/gpu/drm/i915/display/intel_display_types.h:struct intel_panel {
>     ...
> 		union {
> 			struct {
> 				struct drm_edp_backlight_info info;
> 				bool luminance_control_support;
> 			} vesa;
> 			struct {
> 				bool sdr_uses_aux;
> 				bool supports_2084_decode;
>     ...
> }
> 
> supports_2084_decode sits at byte offset 1, overlapping
> vesa.info.pwm_freq_pre_divider in struct drm_edp_backlight_info.  If
> intel_edp_backlight_setup() selected the VESA AUX backlight path instead of
> the Intel HDR AUX path, drm_edp_backlight_init() populates vesa.info and a
> non-zero pwm_freq_pre_divider will falsely attach HDR_OUTPUT_METADATA (and
> trigger an out-of-range bool load under UBSan if the divider is >= 2).
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/tencent_083AD2514CBC235A9F55EE00BDF72D3B9209@qq.com?part=1

-- 
Ville Syrjälä
Intel
