Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F2C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2582810F3DF;
	Fri, 28 Aug 2026 14:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bi6hHuRE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B16210F3DF
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:12:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA9E040167;
 Fri, 28 Aug 2026 14:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE9A1F000E9;
 Fri, 28 Aug 2026 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787926374;
 bh=aM8XEFJ0qJZcpu0Sj/0mV5jOXotIxwuMFgdJBSFfZxU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bi6hHuREj6ut9QnGiNpns5g233BYEFbLt820Lwad5fg0Jy0i/npLfrm29W3f+Ul3c
 9SyjkY7e3r8JZwcxx3M232iLVWUXckZ+diHlf5ocD0+qYQC4U0Tb3aBtPPSqvJuTBX
 kand2TtcuwEnvCjdIxGbHYvnecQsOO920tsjFDQHPebnoa90Ras4kjZWPO7o7zMuvV
 Dr8rIZKgfdzbGy6XvIK/LxEBCgTQ/w08csQEB4QngvhnUpBrTH8vopUgKC2aQNwQmG
 vNSbUSg1SeHYeUS/gaKPitt0WVoRdf3tvUmSnGqxpzcKfkWp1B3J3mPrrp/1SULGEG
 4NLUBjfgOXykg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: lee@kernel.org, conor+dt@kernel.org, olteanv@gmail.com, vkoul@kernel.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260828-jh7110-clean-send-v2-12-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134835eucas1p27736632121c17e11f554e295994a7d8d@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-12-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:12:53 +0000
Message-Id: <20260828141254.2BE9A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Kernel panic or division-by-zero exception due to division by zero=
 in clock rate recalculation if hardware registers are uninitialized or zer=
oed.
- [High] Multiplication of unsigned long values silently overflows on 32-bi=
t architectures before assignment to a 64-bit variable in VCO rate calculat=
ion.
--

commit 65afb8fac5b8b08e9749e00354df9fbca4121dd2
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers

This commit replaces the local RK3328 pre-PLL implementations for calculati=
ng
and setting rates with the generic shared Innosilicon helpers. It keeps the
RK3228 register-level code separate due to different register addresses but
shares the table lookup.

> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/=
rockchip/phy-rockchip-inno-hdmi.c
> index 1483907413faa..fae766607b0ea 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
[ ... ]
> @@ -870,39 +850,11 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(=
struct clk_hw *hw,
>  						   unsigned long parent_rate)
>  {
>  	struct inno_hdmi_phy *inno =3D to_inno_hdmi_phy(hw);
[ ... ]
> +	inno->pixclock =3D inno_hdmi_phy_pre_pll_recalc_rate(&inno->pre_pll,
> +							   parent_rate);

[Severity: High]
This is a pre-existing issue, but since we are switching to the shared help=
er
inno_hdmi_phy_pre_pll_recalc_rate(), can this code cause a division by zero?

If the bootloader has not initialized the PHY, the hardware registers may
contain their default 0 values. When the clock framework calls recalc_rate
during registration at boot, would the following logic in the helper result=
 in
a division by zero:

drivers/phy/phy-inno-hdmi.c:inno_hdmi_phy_pre_pll_recalc_rate() {
    ...
	nd =3D inno_read(pll, INNO_PRE_PLL_DIV_1) & INNO_PRE_PLL_PRE_DIV_MASK;
    ...
	if (inno_read(pll, INNO_PRE_PLL_CONTROL) & INNO_PCLK_VCO_DIV_5_MASK) {
		do_div(vco, nd * 5);
	} else {
		no_a =3D inno_read(pll, INNO_PCLK_DIV_AB) & INNO_PCLK_DIV_A_MASK;
		no_b =3D FIELD_GET(INNO_PCLK_DIV_B_MASK,
				 inno_read(pll, INNO_PCLK_DIV_AB)) + 2;
		no_d =3D inno_read(pll, INNO_PCLK_DIV_CD) & INNO_PCLK_DIV_D_MASK;

		do_div(vco, nd * (no_a =3D=3D 1 ? no_b : no_a) * no_d * 2);
	}
    ...
}

If nd, no_a, or no_d evaluate to 0, the denominator becomes 0, which could
lead to a kernel panic or exception on some architectures.

[Severity: High]
This isn't a bug introduced by this patch, but does the rate recalculation
silently overflow on 32-bit architectures?

Inside the same helper, the VCO rate is calculated as:

drivers/phy/phy-inno-hdmi.c:inno_hdmi_phy_pre_pll_recalc_rate() {
    ...
	vco =3D parent_rate * nf;

	if (!(inno_read(pll, INNO_PRE_PLL_DIV_2) &
	      INNO_PRE_PLL_FRAC_DIV_DISABLE)) {
		frac =3D inno_read(pll, INNO_PRE_PLL_FRAC_DIV_7_0) |
		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_15_8) << 8) |
		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_23_16) << 16);
		vco +=3D DIV_ROUND_CLOSEST(parent_rate * frac,
					 BIT(INNO_FRAC_DIV_WIDTH));
	}
    ...
}

The parent_rate is typically 24,000,000, while nf can be up to 757 and
frac up to ~14.6 million. Since parent_rate is an unsigned long and nf is a
u16, the multiplication is performed as 32-bit unsigned math on 32-bit
platforms (like RK3228 which uses ARM32).

Would parent_rate * nf and parent_rate * frac wrap around ULONG_MAX before
being assigned to the 64-bit vco variable or before the division in
DIV_ROUND_CLOSEST?

> =20
> -	inno->pixclock =3D DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
> -
> -	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
> -		__func__, inno->pixclock, vco);
> +	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
> =20
>  	return inno->pixclock;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D12
