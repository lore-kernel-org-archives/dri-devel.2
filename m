Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191BDC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FE210E1D9;
	Fri,  4 Sep 2026 13:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JM3LE0kH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B1110E1D9
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:55:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C128B601F0;
 Fri,  4 Sep 2026 13:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052AD1F00A3D;
 Fri,  4 Sep 2026 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788530127;
 bh=+cG2WXfZtpJyh0eIqtNB3SnV0tjiddM7ZIcc0YJ1E8A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JM3LE0kHUNf6ym2x5h0/bwm3iZHEqIGx04VfJKAkpbceYLHC8md7aQEfevI0B9eHj
 ctMobEP6iYE9GnjIpbzwii7R90qIRMuf494znuN/DyrPSA/hDoTd8kAYzA8nZFBZXP
 aJrYE4P6TruEocagjMBxW4y/6TNIXifq4zvnvLVF3FNa7crpE4X0vlMhq62WR5LvCd
 QuUsJ1/EcoZ7AzGSodAWyBwl+EfZbQARR3gQrfNmYBSx+vzYhBXqf58wzyaopcK6we
 1LqVjhefNdf2FQ6PAnxEFzrX2nj3ReGNIsRy1okYSIwUypo9evkIoKP0ceXotSncaZ
 oPM9eBRVDTjiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/19] phy: Add common Innosilicon HDMI PHY helpers
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: olteanv@gmail.com, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 lee@kernel.org, neil.armstrong@linaro.org, linux-clk@vger.kernel.org,
 robh@kernel.org, mfd@lists.linux.dev, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-15-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132737eucas1p240d02860355b180ff9c5e8e4c6941ec0@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-15-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:55:26 +0000
Message-Id: <20260904135527.052AD1F00A3D@smtp.kernel.org>
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
- [High] Kernel panic from division by zero in clock rate recalculation if =
regmap_read fails or registers are uninitialized.
- [High] Severe 32-bit integer overflows in VCO clock calculations on 32-bi=
t architectures, leading to heavily truncated clock rates.
--

commit 3a039ecf7fc3d9336647b49a4ed8daf640a4fd42
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: Add common Innosilicon HDMI PHY helpers

This commit extracts shared Innosilicon HDMI PHY logic into a common
library. It provides pre-PLL configuration, lookup, and clock rate
recalculation helpers for SoC drivers that instantiate this IP.

> diff --git a/drivers/phy/phy-inno-hdmi.c b/drivers/phy/phy-inno-hdmi.c
> new file mode 100644
> index 0000000000000..77e745a87d22b
> --- /dev/null
> +++ b/drivers/phy/phy-inno-hdmi.c

[ ... ]

> +static u8 inno_read(const struct inno_hdmi_phy_pre_pll *pll, unsigned in=
t reg)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(pll->regmap, inno_reg(pll, reg), &val);
> +	if (ret)
> +		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does explicitly returning 0
on a regmap read failure set up a deterministic kernel panic downstream?

If the registers are uninitialized or the read fails, the returned 0 will
propagate to the division operations in inno_hdmi_phy_pre_pll_recalc_rate().

[ ... ]

> +unsigned long
> +inno_hdmi_phy_pre_pll_recalc_rate(const struct inno_hdmi_phy_pre_pll *pl=
l,
> +				  unsigned long parent_rate)
> +{
> +	u8 nd, no_a, no_b, no_d;
> +	unsigned long frac, rate;
> +	u64 vco, vco_rate;
> +	u16 nf;
> +
> +	nd =3D inno_read(pll, INNO_PRE_PLL_DIV_1) & INNO_PRE_PLL_PRE_DIV_MASK;
> +	nf =3D (inno_read(pll, INNO_PRE_PLL_DIV_2) &
> +	      INNO_PRE_PLL_FB_DIV_11_8_MASK) << 8;
> +	nf |=3D inno_read(pll, INNO_PRE_PLL_DIV_3);
> +	vco =3D parent_rate * nf;

[Severity: High]
This is a pre-existing issue, but on 32-bit architectures where
parent_rate is a 32-bit unsigned long, does this multiplication silently
overflow before being assigned to the 64-bit vco variable?

The nf variable can be up to 4095, which would severely truncate the
result if it exceeds the 32-bit limit. Should parent_rate be cast to
u64 here?

> +
> +	if (!(inno_read(pll, INNO_PRE_PLL_DIV_2) &
> +	      INNO_PRE_PLL_FRAC_DIV_DISABLE)) {
> +		frac =3D inno_read(pll, INNO_PRE_PLL_FRAC_DIV_7_0) |
> +		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_15_8) << 8) |
> +		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_23_16) << 16);
> +		vco +=3D DIV_ROUND_CLOSEST(parent_rate * frac,
> +					 BIT(INNO_FRAC_DIV_WIDTH));

[Severity: High]
This isn't a bug introduced by this patch, but does the parent_rate * frac
multiplication silently overflow 32-bit limits as well?

If this calculation is upgraded to 64-bit to avoid the overflow, would it
also require switching DIV_ROUND_CLOSEST to DIV_ROUND_CLOSEST_ULL to prevent
__udivdi3 link errors on 32-bit systems?

> +	}
> +
> +	vco_rate =3D vco;
> +
> +	if (inno_read(pll, INNO_PRE_PLL_CONTROL) & INNO_PCLK_VCO_DIV_5_MASK) {
> +		do_div(vco, nd * 5);

[Severity: High]
This is a pre-existing issue, but if nd evaluates to 0 from a failed read,
will this do_div() trigger a divide by zero exception during probe?

> +	} else {
> +		no_a =3D inno_read(pll, INNO_PCLK_DIV_AB) & INNO_PCLK_DIV_A_MASK;
> +		no_b =3D FIELD_GET(INNO_PCLK_DIV_B_MASK,
> +				 inno_read(pll, INNO_PCLK_DIV_AB)) + 2;
> +		no_d =3D inno_read(pll, INNO_PCLK_DIV_CD) & INNO_PCLK_DIV_D_MASK;
> +
> +		do_div(vco, nd * (no_a =3D=3D 1 ? no_b : no_a) * no_d * 2);

[Severity: High]
This is also a pre-existing issue, but similar to the above, if nd, no_a,
or no_d evaluate to 0 due to read failures, does this also cause a kernel
panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D15
