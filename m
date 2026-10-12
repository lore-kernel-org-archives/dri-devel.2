Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D198CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAC110EC93;
	Mon, 12 Oct 2026 04:49:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D4510EC90;
 Mon, 12 Oct 2026 04:49:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7674D601FA;
 Mon, 12 Oct 2026 04:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A941F0089B;
 Mon, 12 Oct 2026 04:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780551;
 bh=vFVXv4EAx3qtBO5OXzdVsqH6wZHdiVJkF47oxGPevwI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G4L6WzLM1LXLZoC2W8LAng2K0e+2BpG8IE4usCpcl2/o90mv69VzlQHf0LjTwGCeB
 xZuoy50J/AluAtqyVePUoYClxPz9qy6ZS0NinNHdiQ2oIPFMCo91C9DcKLlU5AG/+s
 alyII0z+H30IkAGb6JFFkJWkE8XGaBTfsxWQ+1A3ZQA8ilBh5LjXa1cbR1OeewmaCH
 694AZ69gP8Id5WLn6ZnKOo6DkXRf2tgAJRvZnB6pZtpenxrhFnjmw2/r9kEa36ZSkW
 KJAEiFTQKXDO+qY5+oiEfaQB4ROucc0OgLkLMZXPees7uFR/MDgvPslbG9dvzhs+ea
 oYuJkfKjzp7ZQ==
Message-ID: <sashiko-outbox-167629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/56] drm/i915/hdmi: Introduce
 intel_hdmi_frl_level() for per-lane TxFFE
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-18-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-18-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:49:10 +0000
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
- [Medium] drm/i915/ddi: flawed TMDS/FRL identification via port_clock in i=
ntel_ddi_level
- [Medium] drm/i915: intel_ddi_level misidentifies 300/600MHz TMDS modes as=
 FRL
--

commit 0e9b38d21314c92fdb8c138db211c81ea24f573c
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/hdmi: Introduce intel_hdmi_frl_level() for per-lane TxFFE

This commit introduces a per-lane TxFFE level tracking for HDMI FRL and
exposes intel_hdmi_frl_level() to retrieve the buffer translation index.
It modifies intel_ddi_level() to use this new function for FRL modes
while preserving the existing behavior for TMDS.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index 1e08ffe19447f..53e889c0d0223 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
[ ... ]
> @@ -1518,11 +1518,15 @@ int intel_ddi_level(struct intel_encoder *encoder,
>  	if (drm_WARN_ON_ONCE(display->drm, !trans))
>  		return 0;
> =20
> -	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
> -		level =3D intel_ddi_hdmi_level(encoder, trans);
> -	else
> +	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI)) {
> +		if (intel_hdmi_is_frl(crtc_state->port_clock))
> +			level =3D intel_hdmi_frl_level(encoder, lane);

[Severity: Medium]
Does this incorrectly misidentify 300MHz and 600MHz TMDS modes as FRL modes?

Because intel_hdmi_is_frl() checks if the clock exactly matches one of the
FRL rates (e.g., 300000 kHz or 600000 kHz), it will return true if a custom
display mode has a TMDS character clock of exactly 300 MHz or 600 MHz. There
is no check in hdmi_port_tmds_clock_valid() preventing TMDS clocks from
exactly matching FRL rates.

If that happens, this branch will call intel_hdmi_frl_level() (returning
index 1) instead of the correct VBT-defined TMDS level via
intel_ddi_hdmi_level(). On older PHYs like C10 where FRL is unsupported,
returning index 1 applies a random DP preset with pre-emphasis instead of
the correct default HDMI level.

Could this check use the more reliable crtc_state->frl.enable flag instead?

A check forward through the series to commit ede50d511c51 confirms this log=
ic
is not fixed.

> +		else
> +			level =3D intel_ddi_hdmi_level(encoder, trans);
> +	} else {
>  		level =3D intel_ddi_dp_level(enc_to_intel_dp(encoder), crtc_state,
>  					   lane);
> +	}
> =20
>  	if (drm_WARN_ON_ONCE(display->drm, level >=3D n_entries))
>  		level =3D n_entries - 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D17
