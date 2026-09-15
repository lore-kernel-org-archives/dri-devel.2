Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B87C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380BE10F0EC;
	Tue, 15 Sep 2026 18:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PjaNEID8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4068A10EC8A;
 Tue, 15 Sep 2026 18:55:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5448D602C2;
 Tue, 15 Sep 2026 18:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D69E1F00893;
 Tue, 15 Sep 2026 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498551;
 bh=GOGfWr/zqnuUp0aaWod35kDSLDrI+impl0Kuz2pt1NU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PjaNEID8olaOBH+kPn/uMMJ8oytc2WAV/cgjCsRGh/ukzp4IAMuA3gzkXv6J6Ajin
 ANdHcbR4/+yWfqHxj/Ebd5lk6kB1VnDsEzQkuC/EQHH5B3uBgQycsFAkBR+wuiVv07
 Lv96reFTkjbcSdOm0mPNg6Q43aVl6cJStzRKwKuwm/Tpw8rD+wC+seRj/MbnZD5731
 1ed04jAMaPlHsOKXYQGfP5PUQuNU7y5yt3lxSh06BS++R+NG6nR6XPtxcfqgxidQPK
 +Cm0vhmn2d30n3V5WN/oE0UlKA3XLPWJHq0LuGAUBlGMrETTdABiU3kxRViwS5jcKT
 9NLtDqlPi0udg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/18] drm/i915/alpm: Compute and program switch to
 active latency
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-17-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-17-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:55:49 +0000
Message-Id: <20260915185550.2D69E1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915/alpm: ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY bounds check mis=
sing
- [High] drm/i915/alpm: switch_to_active math error inflates latency 32x
--

commit 6e4638c7fe4ea7d79d2000aac2b17f2fc3edc381
Author: Animesh Manna <animesh.manna@intel.com>
Subject: drm/i915/alpm: Compute and program switch to active latency

This commit programs the ALPM switch to active latency into ALPM_CTL2. For
UHBR link rates, the latency is derived from the link symbol clock and
converted to scanlines, while for non-UHBR rates it is set to zero.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 236341aa3c8d8..84777c8d31bb4 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
[ ... ]
> @@ -301,6 +301,31 @@ static int get_establishment_period(struct intel_dp =
*intel_dp,
>  	return establishment_period;
>  }
> =20
> +static int get_switch_to_active(const struct intel_crtc_state *crtc_stat=
e)
> +{
> +	int port_clock =3D crtc_state->port_clock;
> +	int switch_to_active;
> +
> +	if (intel_dp_is_uhbr(crtc_state)) {
> +		/* symbol_clock (fLink) in MHz */
> +		int symbol_clock =3D port_clock / intel_dp_link_symbol_size(port_clock=
) / 100;
> +
> +		/*
> +		 * tSwitch to Active =3D 32 * (ML_PHY_LOCK Length + 3 + 64) / fLink
> +		 *
> +		 * The "+ 3" term is the trailing zero padding after the
> +		 * POST_LT_SCRAMBLER_RESET, the "+ 64" term represents the MTP
> +		 * time slots. The result is in microseconds.
> +		 */
> +		switch_to_active =3D get_dp_link_symbol_size(crtc_state) *
> +				   (ML_PHY_LOCK_LEN_UHBR + 3 + 64) / symbol_clock;

[Severity: High]
Does this logic incorrectly substitute the symbol rate for the bit rate,
inflating the latency by 32x?

In the DP spec formula, fLink is the link rate in Mbps, and multiplying the
symbol count by 32 correctly calculates bits divided by bit-rate. However,
symbol_clock is calculated here as port_clock / 32, meaning the denominator=
 is
32x smaller than intended.

This math error calculates a latency of ~47.4us instead of 1.48us, causing
excessively long ALPM wake sequences. Additionally, standard integer divisi=
on
here drops fractional microseconds, so if corrected, the wait time might be
shorter than the physical hardware minimum on high-clock displays.

> +	} else {
> +		switch_to_active =3D 0;
> +	}
> +
> +	return switch_to_active;
> +}
> +
[ ... ]
> @@ -360,7 +385,8 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *in=
tel_dp,
>  	crtc_state->alpm_state.aux_less_wake_lines =3D aux_less_wake_lines;
>  	crtc_state->alpm_state.silence_period_sym_clocks =3D silence_period;
>  	crtc_state->alpm_state.lfps_half_cycle_num_of_syms =3D lfps_half_cycle;
> -
> +	crtc_state->alpm_state.switch_to_active =3D intel_usecs_to_scanlines(&c=
rtc_state->hw.adjusted_mode,
> +									   get_switch_to_active(crtc_state));

[Severity: High]
Can the computed scanline count overflow the 5-bit register field it is
later written to?

Unlike the other parameters configured in _lnl_compute_aux_less_alpm_params=
(),
there is no bounds check here against the maximum allowed value before
assigning it to switch_to_active.

With the 32x inflation bug above, on high-refresh-rate displays (like 4K @
360Hz), ~47us translates to > 31 scanlines.

>  	return true;
>  }
> =20
[ ... ]
> @@ -772,6 +798,7 @@ static void lnl_alpm_configure(struct intel_dp *intel=
_dp,
>  	lttpr_count =3D drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
> =20
>  	alpm_ctl2 =3D ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
> +	alpm_ctl2 |=3D ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY(crtc_state->alpm_stat=
e.switch_to_active);

[Severity: High]
Does this silently mask and truncate the unbounded scanline count?

ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY uses REG_FIELD_PREP with a 5-bit mask.
Any value > 31 is silently truncated. For example, 32 scanlines truncates
to 0, completely removing the required wake latency. This causes the hardwa=
re
to exit ALPM before the PHY has locked, leading to link training failures or
display corruption.

> =20
>  	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
>  	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D16
