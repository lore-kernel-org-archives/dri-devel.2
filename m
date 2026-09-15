Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9AEC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A132D10ED54;
	Tue, 15 Sep 2026 18:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wxchg31n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9239910F448;
 Tue, 15 Sep 2026 18:46:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7971600CB;
 Tue, 15 Sep 2026 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7391F00893;
 Tue, 15 Sep 2026 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789497969;
 bh=5y1oqCxNl814ubBr82ZnvMhK1yJDe2zxNrwVz10TM/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wxchg31nBcJoq96wVpjsQsM+bJE+A+7HFLDok91X5y7BrM4GeKg57aZeSvZBApymO
 I31HyB2bZRwqFzsLFR1R3aJRliDRUvKUQXIsIgnDN86pirElYm1fxb2KTKf00TOZew
 oCX8biPHC4Dh5FAdx4wYEtTUm+iOYTjRw4+3YIXeinn6FyO/Qy1/wPWf/c9YxkeeN/
 zjAMaMqgVrFNCVCMgzd5Z7M9eGllGeP0IgJItN/QGKRUMeIuQGtjRNbMBsAey4Zw0+
 LApegQWK6NV90VvIp4ekFNBz2vLontnJBUn5qdrVxvoQQ2wsQpINqBNRh7sYrHCXlP
 NK+XanGB0R96A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/18] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME
 bitfield for xe3lpd
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-8-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-8-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:46:08 +0000
Message-Id: <20260915184609.3F7391F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/i915/alpm: ALPM AUX-less wake time incorrectly restricted to=
 legacy 6-bit maximum on xe3lpd
--

commit fefc7fdf839fcf4154d50e19eac0f82242cca5ad
Author: Animesh Manna <animesh.manna@intel.com>
Subject: drm/i915/alpm: Modify AUX_LESS_WAKE_TIME bitfield for xe3lpd

This commit widens the ALPM_CTL_AUX_LESS_WAKE_TIME bitfield from 6 bits
to 8 bits for xe3lpd (display version 35) and later. It introduces new
register macros and updates lnl_alpm_configure() to program the wake time
using the appropriate macro based on the display version.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 924fa8dd4638f..dc025058a6266 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
> @@ -610,8 +610,12 @@ static void lnl_alpm_configure(struct intel_dp *inte=
l_dp,
>  	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
>  		alpm_ctl =3D ALPM_CTL_ALPM_ENABLE |
>  			ALPM_CTL_ALPM_AUX_LESS_ENABLE |
> -			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS |
> -			ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_less_wake_line=
s);
> +			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS;
> +
> +		if (DISPLAY_VER(display) < 35)
> +			alpm_ctl |=3D ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_=
less_wake_lines);
> +		else
> +			alpm_ctl |=3D ALPM_CTL_AUX_LESS_WAKE_TIME_XE3LPD(crtc_state->alpm_sta=
te.aux_less_wake_lines);

[Severity: Medium]
While this successfully programs the wider 8-bit wake time on xe3lpd hardwa=
re,
does _lnl_compute_aux_less_alpm_params() in the same file also need to be
updated to use this new mask?

Looking at _lnl_compute_aux_less_alpm_params(), the bounds check is still
hardcoded to the 6-bit legacy mask ALPM_CTL_AUX_LESS_WAKE_TIME_MASK on all
platforms:

	if (aux_less_wake_lines > ALPM_CTL_AUX_LESS_WAKE_TIME_MASK ||
	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MAS=
K)
		return false;

Will this restrict aux_less_wake_lines to a maximum of 63, causing validati=
on
to fail and aborting ALPM if the computed wake time is larger on xe3lpd?

Additionally, the safest params fallback is also restricted to the legacy m=
ask:

	if (display->params.psr_safest_params)
		aux_less_wake_lines =3D ALPM_CTL_AUX_LESS_WAKE_TIME_MASK;

Will this cap the safest params to 63 instead of 255 on xe3lpd?

> =20
>  		if (intel_dp->as_sdp_supported)
>  			intel_alpm_configure_pr_as_sdp(intel_dp, crtc_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D7
