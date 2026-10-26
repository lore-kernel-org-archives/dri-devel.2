Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E79606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dE4IszWs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386CC10EBE4;
	Mon, 26 Oct 2026 07:23:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8233410EBDA;
 Mon, 26 Oct 2026 07:23:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E02BE601EF;
 Mon, 26 Oct 2026 07:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C941F01825;
 Mon, 26 Oct 2026 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792999423;
 bh=AMwVPp5HpDCoT/cxWMTSyPwhYjtLGnpByZsfc6YEMtc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=dE4IszWsH67rP3m2vIGTmAKpgC+sN9JT5qnC7gk/Tl7vbkhXsdad32fBVWxthswhu
 Cf5NkhypKBa5m2N24PbKeZRxdGyeVWvpDhb+9+71SIBXc+GHEj9V1c6FNnauncdGw3
 ocHY5KWJA4gftGY9Yr9f9UZI7AzYnXHUvFWuW7uwXH5XUqNJEN8f4NecK21Q2xIYyW
 CQ/rG2Ca2iWS5yiR95+No4cQA6vJxOegYq3K+CUr+qIMOUORlDLCmb8C9yqjAqf+ts
 fkKoWOc+pOgsUwnTs6z1k2AcMp5IorBF7u9yuN2gbB6BOhJX75GJ2ZHZg8vQaTgO4l
 n1G0hjNV5H8Nw==
Message-ID: <sashiko-outbox-184657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 19/20] drm/i915/alpm: Introduce has_alpm to decouple
 from pr/psr2/lobf
To: "Animesh Manna" <animesh.manna@intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261026054001.799894-20-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
 <20261026054001.799894-20-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 07:23:42 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915/alpm: ALPM left enabled on DP Panel Replay disable or !ha=
s_alpm
- [Medium] drm/i915/alpm: intel_psr_min_guardband() skips DP Panel Replay A=
LPM wake lines
--

commit 599e7704f4924a7a5dd73754cb1a7ffd13dae956
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: Introduce has_alpm to decouple from pr/psr2/lobf

This patch introduces crtc_state->has_alpm in intel_alpm_compute_config_lat=
e()
to decouple ALPM enablement from Panel Replay, PSR2, and LOBF so that DP 2.1
Panel Replay can operate with or without ALPM.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 65d06e8ebbe06..47263af0970cf 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
[ ... ]
> @@ -598,14 +599,34 @@ void intel_alpm_compute_config(struct intel_dp *int=
el_dp,
> =20
>  	crtc_state->alpm_state.aux_wake_possible =3D true;
>  	crtc_state->alpm_state.aux_less_possible =3D
> -		DISPLAY_VER(display) >=3D 20 &&
> -		(intel_dp_is_edp(intel_dp) ||
> -		 (intel_alpm_is_possible(intel_dp, crtc_state) &&
> -		  intel_alpm_aux_less_wake_supported(intel_dp)));
> +		DISPLAY_VER(display) >=3D 20 && intel_alpm_is_possible(intel_dp, crtc_=
state) &&
> +		(intel_dp_is_edp(intel_dp) || intel_alpm_aux_less_wake_supported(intel=
_dp));
> =20
>  	intel_alpm_lobf_compute_config(intel_dp, crtc_state);
>  }
> =20
> +/*
> + * Decide whether ALPM is enabled once PSR, Panel Replay and LOBF have b=
een
> + * finalized. eDP Panel Replay and PSR2 always use ALPM, for DP Panel Re=
play
> + * ALPM is optional and used only if the AUX-less wake time fits.
> + */
> +void intel_alpm_compute_config_late(struct intel_dp *intel_dp,
> +				    struct intel_crtc_state *crtc_state)
> +{
> +	int aux_less_wake_lines =3D crtc_state->alpm_state.aux_less_wake_lines;
> +
> +	intel_alpm_lobf_compute_config_late(intel_dp, crtc_state);
> +
> +	if (crtc_state->has_psr && crtc_state->has_panel_replay)
> +		crtc_state->has_alpm =3D intel_dp_is_edp(intel_dp) ||
> +			(crtc_state->alpm_state.aux_less_possible &&
> +			 intel_psr_wake_lines_fit_into_vblank(crtc_state, aux_less_wake_lines=
));

[Severity: Medium]
Can intel_psr_wake_lines_fit_into_vblank() fail to enable crtc_state->has_a=
lpm
on external DP Panel Replay because intel_psr_min_guardband() does not rese=
rve
aux_less_wake_lines for non-eDP outputs?

On DISPLAY_VER(display) >=3D 35, intel_vrr_always_use_vrr_tg() and
intel_vrr_use_optimized_guardband() are used, so before
intel_dp_compute_config_late() -> intel_alpm_compute_config_late() runs,
intel_crtc_compute_config() -> intel_vrr_compute_guardband() ->
intel_vrr_compute_optimized_guardband() computes crtc_state->vrr.guardband =
and
adjusts crtc_vblank_start:

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_compute_optimized_guardb=
and() {
	...
	if (intel_crtc_has_dp_encoder(crtc_state)) {
		guardband =3D max(guardband, intel_psr_min_guardband(crtc_state));
		guardband =3D max(guardband, intel_dp_sdp_min_guardband(crtc_state, true)=
);
		guardband =3D max(guardband, intel_alpm_lobf_min_guardband(crtc_state));
	}
	...
}

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_compute_guardband() {
	...
	if (intel_vrr_always_use_vrr_tg(display)) {
		adjusted_mode->crtc_vblank_start  =3D
			adjusted_mode->crtc_vtotal - crtc_state->vrr.guardband;
	...
}

However, intel_psr_min_guardband() in drivers/gpu/drm/i915/display/intel_ps=
r.c
currently skips non-eDP encoders:

drivers/gpu/drm/i915/display/intel_psr.c:intel_psr_min_guardband() {
	...
	if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
		return 0;

	if (crtc_state->has_panel_replay)
		wake_lines =3D crtc_state->alpm_state.aux_less_wake_lines;
	...
}

When crtc_state->has_lobf is false (for example, when !intel_dp->as_sdp_sup=
ported,
intel_dp->alpm.lobf_disable_debug is set, or intel_dp->alpm.sink_alpm_error=
 is
set), intel_alpm_lobf_min_guardband() also returns 0. That shrinks
crtc_state->vrr.guardband (and therefore intel_crtc_vblank_length(crtc_stat=
e))
to the prefill/SDP guardband, which can be smaller than aux_less_wake_lines
even when the mode's full vblank is large enough.

Should intel_psr_min_guardband() also reserve aux_less_wake_lines for exter=
nal
DP Panel Replay when crtc_state->alpm_state.aux_less_possible is true?

> +	else if (crtc_state->has_psr && crtc_state->has_sel_update)
> +		crtc_state->has_alpm =3D intel_dp_is_edp(intel_dp);
> +	else
> +		crtc_state->has_alpm =3D crtc_state->has_lobf;
> +}
[ ... ]
> @@ -767,8 +788,7 @@ static void lnl_alpm_configure(struct intel_dp *intel=
_dp,
>  	u32 alpm_ctl, alpm_ctl2;
>  	int lttpr_count;
> =20
> -	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_=
state) &&
> -					  !crtc_state->has_lobf))
> +	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
>  		return;
[ ... ]
> @@ -888,13 +908,12 @@ void intel_alpm_enable_sink(struct intel_dp *intel_=
dp,
>  {
>  	u8 val;
> =20
> -	if (!intel_psr_needs_alpm(intel_dp, crtc_state) && !crtc_state->has_lob=
f)
> +	if (!crtc_state->has_alpm)
>  		return;
> =20
>  	val =3D DP_ALPM_ENABLE | DP_ALPM_LOCK_ERROR_IRQ_HPD_ENABLE;
> =20
> -	if (crtc_state->has_panel_replay || (crtc_state->has_lobf &&
> -					     intel_alpm_aux_less_wake_supported(intel_dp)))
> +	if (intel_alpm_is_aux_less(intel_dp, crtc_state))
>  		val |=3D DP_ALPM_MODE_AUX_LESS;
> =20
>  	drm_dp_dpcd_write_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CONFIG, val);

[Severity: High]
With crtc_state->has_alpm now enabling ALPM in lnl_alpm_configure() and
intel_alpm_enable_sink() for non-eDP Panel Replay, can ALPM remain enabled =
on
both the source and sink when DP Panel Replay is later disabled or reconfig=
ured
to !crtc_state->has_alpm?

In drivers/gpu/drm/i915/display/intel_psr.c, intel_psr_disable_locked() sti=
ll
guards intel_alpm_disable() with intel_dp_is_edp() and only clears
DP_RECEIVER_ALPM_CONFIG when !intel_dp->psr.panel_replay_enabled:

drivers/gpu/drm/i915/display/intel_psr.c:intel_psr_disable_locked() {
	...
	if (intel_dp->psr.panel_replay_enabled && intel_dp_is_edp(intel_dp))
		intel_alpm_disable(intel_dp);

	/* Disable PSR on Sink */
	if (!intel_dp->psr.panel_replay_enabled) {
		drm_dp_dpcd_write_byte(&intel_dp->aux, DP_PSR_EN_CFG, 0);

		if (intel_dp->psr.sel_update_enabled)
			drm_dp_dpcd_write_byte(&intel_dp->aux,
					       DP_RECEIVER_ALPM_CONFIG, 0);
	}
}

When external DP Panel Replay (!intel_dp_is_edp(intel_dp)) with ALPM is
disabled without a full encoder disable (such as in
intel_psr_pre_plane_update() when all planes become inactive, during fastse=
ts,
or on a sink error in intel_psr_short_pulse()), intel_alpm_disable() is ski=
pped
and ALPM_CTL_ALPM_ENABLE stays set in ALPM_CTL. Subsequent re-enables in
intel_psr_post_plane_update() -> intel_psr_enable_locked() ->
intel_psr_enable_source() -> intel_alpm_configure() -> lnl_alpm_configure()
then rewrite ALPM_CTL, ALPM_CTL2, and PR_ALPM_CTL while ALPM is still enabl=
ed
in hardware.

Furthermore, because neither intel_psr_disable_locked() nor
intel_alpm_enable_sink() clears DP_RECEIVER_ALPM_CONFIG for Panel Replay wh=
en
transitioning to !crtc_state->has_alpm, won't DP_RECEIVER_ALPM_CONFIG remain
enabled on the sink (and ALPM_CTL remain enabled on the source across a
fastset) if a subsequent commit runs Panel Replay without ALPM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026054001.7998=
94-1-animesh.manna@intel.com?part=3D19
