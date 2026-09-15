Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C44FC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 19:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C1910F2D2;
	Tue, 15 Sep 2026 19:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H0F7ldmF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B715B10F0F1;
 Tue, 15 Sep 2026 19:01:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7401141AC7;
 Tue, 15 Sep 2026 19:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3CD1F008A2;
 Tue, 15 Sep 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498883;
 bh=v5pLn2oEPZJcgTdr0ANzaVbRrVxGHytBTWgkq+8kfas=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H0F7ldmF2fjcVVipnucbLocuAG/oGO4mwX3KWaAOB0DudL5qrSnHZTa6vLzDbadlc
 ARjP/fbQOz8m0lxRG9aRuvWRSfhNF9Lvkawa33b9vjcdTngJ7H3E/YLjS1ZzN/7fNn
 ZdALHUORgkWgj59R8CSjYH6tufSBz6hvvABDdG9XTl71i5o/lzbbPJiIkuo+tFW+m2
 eehUwbwu6WhK2nDdlLibR4BdfTr+seLHeG2/GTeCxNSaU0oQeXA4hcCcEx00VoIwam
 uqgDGpIBJHC04Mogr+YFFaB33ocN4NT0TbfVqv5hxl8WXI3E4knv2+6koqGwe6mEPF
 n0Z9xZzF2euZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/18] drm/i915/alpm: Introduce has_alpm to decouple
 from pr/psr2/lobf
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-16-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-16-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 19:01:22 +0000
Message-Id: <20260915190122.CD3CD1F008A2@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/i915/alpm: Unconditional overwrite of has_alpm breaks Panel Re=
play without ALPM
- [High] drm/i915/alpm: Retained eDP check in intel_psr_needs_alpm_aux_less=
 prevents AS SDP for external DP
- [High] drm/i915/alpm: has_alpm state leak when PSR/PR features are downgr=
aded late
- [Medium] drm/i915/alpm: Early return in intel_alpm_port_configure prevent=
s clearing stale ALPM state
- [Medium] drm/i915/alpm: Missing has_alpm check causes incorrect PR_ALPM_C=
TL programming
--

commit 4dcfef3fd89e0ed18372dabec785892c009d57eb
Author: Animesh Manna <animesh.manna@intel.com>
Subject: drm/i915/alpm: Introduce has_alpm to decouple from pr/psr2/lobf

This commit introduces a single crtc_state->has_alpm flag to track ALPM
enablement, decoupling it from implicit feature tracking like eDP Panel
Replay, PSR2, or LOBF. It updates various ALPM configuration and port
paths to use this new flag as the single source of truth.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 29a93a252fe9b..236341aa3c8d8 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c

[ ... ]

> @@ -719,7 +720,7 @@ void intel_alpm_pr_as_sdp_update(const struct intel_c=
rtc_state *crtc_state)
>  		intel_dp =3D enc_to_intel_dp(encoder);
> =20
>  		if (!intel_dp->as_sdp_supported ||
> -		    !intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
> +		    !intel_alpm_is_aux_less(intel_dp, crtc_state))
>  			continue;
> =20
>  		mutex_lock(&intel_dp->alpm.lock);

[Severity: Medium]
Does this missing check for crtc_state->has_alpm cause incorrect
PR_ALPM_CTL programming?

The intel_alpm_is_aux_less() function evaluates to true for Panel Replay
regardless of the actual has_alpm state. Without an explicit check verifying
that ALPM is actually active, if Panel Replay is explicitly falling back to
a "without ALPM" configuration, this loop will incorrectly write AS SDP
parameters to the ALPM controller, which contradicts the fallback state.

[ ... ]

> @@ -792,10 +792,10 @@ void intel_alpm_port_configure(struct intel_dp *int=
el_dp,
>  	enum port port =3D dp_to_dig_port(intel_dp)->base.port;
>  	u32 alpm_ctl_val =3D 0, lfps_ctl_val =3D 0;
> =20
> -	if (DISPLAY_VER(display) < 20)
> +	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
>  		return;

[Severity: Medium]
Will this early return prevent clearing stale ALPM state in the hardware?

Previously, this function would proceed and write the zeroed alpm_ctl_val
and lfps_ctl_val to the hardware when ALPM was disabled. By returning
early when crtc_state->has_alpm is false, any transition from an
ALPM-enabled mode to an ALPM-disabled mode will skip the clearing writes.
This leaves the hardware with an active ALPM configuration while the driver
state considers it disabled.

> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i=
915/display/intel_psr.c
> index 872e253db1786..1f14dbe57512f 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -1648,6 +1648,8 @@ static bool intel_sel_update_config_valid(struct in=
tel_crtc_state *crtc_state,
>  	crtc_state->enable_psr2_su_region_et =3D psr2_su_region_et_valid(connec=
tor,
>  								       crtc_state->has_panel_replay);
> =20
> +	crtc_state->has_alpm =3D intel_alpm_is_possible(intel_dp);
> +

[Severity: High]
Does this unconditional assignment overwrite the validated has_alpm state?

The Panel Replay configuration path sets has_alpm based on whether ALPM
timing actually fits into the vblank period. When Panel Replay is validated
but ALPM timing fails, has_alpm is correctly set to false to allow Panel
Replay without ALPM.

This line in intel_sel_update_config_valid() unconditionally overwrites
that calculated state with a simple capability check, forcing it back to
true. This destroys the fallback state, causing the late compute config
to evaluate ALPM wake lines again, fail, and fully disable Panel Replay
on external DP.

[ ... ]

> @@ -4555,16 +4569,6 @@ void intel_psr_connector_debugfs_add(struct intel_=
connector *connector)
>  				    connector, &i915_psr_status_fops);
>  }
> =20
> -bool intel_psr_needs_alpm(struct intel_dp *intel_dp, const struct intel_=
crtc_state *crtc_state)
> -{
> -	/*
> -	 * eDP Panel Replay uses always ALPM
> -	 * PSR2 uses ALPM but PSR1 doesn't
> -	 */
> -	return intel_dp_is_edp(intel_dp) && (crtc_state->has_sel_update ||
> -					     crtc_state->has_panel_replay);
> -}
> -
>  bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
>  				   const struct intel_crtc_state *crtc_state)
>  {

[Severity: High]
Does retaining the eDP-only check in intel_psr_needs_alpm_aux_less()
prevent AS SDP configuration for external DP Panel Replay?

While intel_alpm_is_aux_less() was updated to support external DP,
intel_psr_needs_alpm_aux_less() still restricts true return values to
eDP only. Any external DP configuration enabling Panel Replay will fail
this check when evaluated by intel_dp_pr_with_as_sdp_enabled() in the
link training paths.

This leads to silently missing the DP_FIXED_VTOTAL_AS_SDP_EN_IN_PR_ACTIVE
configuration during link training, causing a mismatch between source
programming and the sink DPCD configuration.

> @@ -4578,15 +4582,17 @@ void intel_psr_compute_config_late(struct intel_d=
p *intel_dp,
>  	int vblank =3D intel_crtc_vblank_length(crtc_state);
>  	int wake_lines;
> =20
> -	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state))
> -		wake_lines =3D crtc_state->alpm_state.aux_less_wake_lines;
> -	else if (intel_psr_needs_alpm(intel_dp, crtc_state))
> -		wake_lines =3D DISPLAY_VER(display) < 20 ?
> -			     psr2_block_count_lines(crtc_state->alpm_state.io_wake_lines,
> -						    crtc_state->alpm_state.fast_wake_lines) :
> -			     crtc_state->alpm_state.io_wake_lines;
> -	else
> +	if (crtc_state->has_alpm) {
> +		if (crtc_state->has_panel_replay)
> +			wake_lines =3D crtc_state->alpm_state.aux_less_wake_lines;
> +		else
> +			wake_lines =3D DISPLAY_VER(display) < 20 ?
> +				     psr2_block_count_lines(crtc_state->alpm_state.io_wake_lines,
> +							    crtc_state->alpm_state.fast_wake_lines) :
> +				     crtc_state->alpm_state.io_wake_lines;
> +	} else {
>  		wake_lines =3D 0;
> +	}
> =20
>  	/*
>  	 * Disable the PSR features if wake lines exceed the available vblank.

[Severity: High]
Can has_alpm leak as true if PSR or Panel Replay features are disabled
late in this function?

When falling back to PSR1 or fully disabling PSR due to vblank timing limits
or hardware workarounds later in intel_psr_compute_config_late():

    if (crtc_state->has_panel_replay) {
            crtc_state->has_panel_replay =3D false;
            crtc_state->has_psr =3D false;
    }
    crtc_state->has_sel_update =3D false;

The corresponding feature flags are cleared, but has_alpm is left as true.
Since ALPM programming paths (like intel_alpm_port_configure) now rely
directly on has_alpm, this leaked state can cause unintended ALPM hardware
programming on unsupported modes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D15
