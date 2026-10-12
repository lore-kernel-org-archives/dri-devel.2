Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F280ACA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AB410EC83;
	Mon, 12 Oct 2026 04:36:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2B110EC83;
 Mon, 12 Oct 2026 04:35:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04F9C432B3;
 Mon, 12 Oct 2026 04:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF591F0089D;
 Mon, 12 Oct 2026 04:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779758;
 bh=O6Ma69HBr8dHdSXn+B5vxbDSJZNZ98rD9Wn6vMaUPkE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BL5UsqkH0fel+k425msudc39IQ//Pe40n8G7DxjnzAJ0iCIh0Us1p7uVyN9unyt5O
 kSa+jLNvuJtEB8rv3HMjeCx20D4jhR4bRPCC/smdTbwLokFOUbrP+8J453ItyAft1d
 QQ7Mw4xktOIkxMi5/VkIcATA+qBEJ3pzwjH5PZV7WN56CrYMtTwx/jrCw2B1e9c0dN
 TV+32uqmul2TGYideiUfMIEBoKUNVGQ4RnFDie8XWWHxtnaZKVOSD9OctA/qQiPLpX
 T3dRY7jyJZzT+a82/zlpRWRHxiIPITNvShZAR2EqsB23aBQzwnZJvEyuFGlfak+3zZ
 50qx4ZzgyfHGQ==
Message-ID: <sashiko-outbox-167614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/56] drm/i915/ltphy: Calculate port clock for HDMI FRL
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-22-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-22-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:35:58 +0000
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
- [High] drm/i915/ltphy: Fragile FRL mode check misidentifies 300MHz/600MHz=
 TMDS as FRL
--

commit c8e5d35c7adb72d4a07659a9da4c78974ed1e816
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/ltphy: Calculate port clock for HDMI FRL

Define function to get the port clock after we read VDR0_CONFIG.
This helps us determine the port clock for HDMI FRL use case in LT
PHY.

> diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/dr=
m/i915/display/intel_lt_phy.c
> index 0e2ebd550bc5e..7ac0888cdf452 100644
> --- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
> @@ -2000,6 +2019,10 @@ intel_lt_phy_calc_port_clock(struct intel_display =
*display,
>  		rate =3D REG_FIELD_GET8(LT_PHY_VDR_RATE_ENCODING_MASK,
>  				      lt_state->config[0]);
>  		clk =3D intel_lt_phy_get_dp_clock(rate);
> +	} else if (mode =3D=3D MODE_HDMI_FRL) {
> +		rate =3D REG_FIELD_GET8(LT_PHY_VDR_RATE_ENCODING_MASK,
> +				      lt_state->config[0]);
> +		clk =3D intel_lt_phy_get_hdmi_frl_clock(rate);

[Severity: High]
Does returning valid FRL clocks from readout here expose an issue where 300=
MHz
and 600MHz TMDS modes are misidentified as FRL?

The driver relies on clock value guessing via intel_hdmi_is_frl(port_clock)
instead of checking protocol state (like crtc_state->frl.enable or
ltpll->config[0]) to distinguish FRL modes from TMDS.

Because 300MHz and 600MHz are both valid TMDS character rates and FRL link
rates, a TMDS mode running at exactly 300MHz or 600MHz (such as custom 4K or
1440p timings) will be misidentified as FRL.

This leads to incorrect PHY PLL state calculation and wrong port clock
programming in intel_lt_phy_program_port_clock_ctl():

	if (intel_lt_phy_is_hdmi(ltpll) && intel_hdmi_is_frl(port_clock))
		val |=3D XELPDP_DDI_CLOCK_SELECT_PREP(display, XELPDP_DDI_CLOCK_SELECT_DI=
V18CLK);
	else
		val |=3D XELPDP_DDI_CLOCK_SELECT_PREP(display, XELPDP_DDI_CLOCK_SELECT_MA=
XPCLK);

Programming DIV18CLK instead of MAXPCLK will cause display failure for these
TMDS modes.

>  	} else if (mode =3D=3D MODE_HDMI_20) {
>  		clk =3D intel_lt_phy_calc_hdmi_port_clock(display, lt_state);
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D21
