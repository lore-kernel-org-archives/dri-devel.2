Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329D6CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7792110E479;
	Mon, 12 Oct 2026 04:40:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B6F10E479;
 Mon, 12 Oct 2026 04:40:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34BB540D90;
 Mon, 12 Oct 2026 04:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF3B1F0089B;
 Mon, 12 Oct 2026 04:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780001;
 bh=xCOw4GIKX9S+oZEdVaXtpLPePEHIQhVHXa9ztMHrO6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rovg/7l2in+Z4YWEwizuz+km40KRHkyLebmNtFWAN9v6lq1c6q0OtOLSva7UbnKNH
 2JNjADgae2NpvTDLRJcH4QfT5u3GshI1uZf+C3UjzB1UqCShQc606Csy/5N4EkNTEU
 5jmAi8468SPzxqX6wGttT6T9M5H6WvpNZbPEEDDuTcB0WNG+Nw5MLVTO6lVuKPAiVf
 2THQebo5iFFRJLKxHlGiLwURp0vYQc+z/gUVX14h/W3A+30qUwuV9RT+WGHsrFGS40
 3VgaLKdNDSJvl402KWO972I/X0E5lRHFAUC18qhQZdWwqnKwin/waOGJOlQ/4DLhOq
 tc9ZBKf6EnNlA==
Message-ID: <sashiko-outbox-167618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/56] drm/i915/ltphy: Add safegaurd when calculation
 HDMI FRL state
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-21-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-21-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:40:00 +0000
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
- [Medium] drm/i915/ltphy: Valid TMDS modes with FRL-like clocks get miside=
ntified as FRL
--

commit 24fcf65234b436b2c1d8a2379615e06c2dcf0888
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/ltphy: Add safegaurd when calculation HDMI FRL state

This commit adds a safeguard in intel_lt_phy_pll_calc_state() to skip the
HDMI TMDS dynamic PLL calculation when an HDMI FRL mode is in use. It
determines this by checking if the port clock matches an FRL rate.

> drm/i915/ltphy: Add safegaurd when calculation HDMI FRL state

This isn't a bug, but there is a typo (safegaurd) in the subject line.

> diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/dr=
m/i915/display/intel_lt_phy.c
> index 61bad87eefec2..0e2ebd550bc5e 100644
> --- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
> @@ -2042,7 +2042,8 @@ intel_lt_phy_pll_calc_state(struct intel_crtc_state=
 *crtc_state,
>  		}
>  	}
> =20
> -	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI)) {
> +	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI) &&
> +	    !intel_hdmi_is_frl(crtc_state->port_clock)) {

[Severity: Medium]
Does this logic mistakenly prevent the TMDS dynamic calculation for 300MHz
and 600MHz TMDS modes?

Looking at intel_hdmi_is_frl(), it only checks if the numeric clock rate
matches one of the FRL rates:

drivers/gpu/drm/i915/display/intel_hdmi.c:intel_hdmi_is_frl() {
	static const u32 rates[] =3D { 300000, 600000, 800000, 1000000, 1200000 };
	...
	for (i =3D 0; i < ARRAY_SIZE(rates); i++)
		if (intel_dpll_clock_matches(clock, rates[i]))
			return true;

	return false;
}

Since 300MHz and 600MHz can also be valid TMDS pixel clocks, a TMDS mode
with exactly these clock rates would cause intel_hdmi_is_frl() to return
true.

This would block the fallback intel_lt_phy_calculate_hdmi_state()
calculation for those valid TMDS modes.

Should this check verify the protocol state instead, for example by checking
if crtc_state->frl.enable is true?

>  		hw_state->ltpll.lane_count =3D crtc_state->lane_count;
>  		return intel_lt_phy_calculate_hdmi_state(&hw_state->ltpll,
>  							 crtc_state->port_clock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D20
