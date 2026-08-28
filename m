Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4AFC61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30ABB10F3BC;
	Fri, 28 Aug 2026 14:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TgRrw7sm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD04610F3C4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:00:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 226AF601FD;
 Fri, 28 Aug 2026 14:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9041F000E9;
 Fri, 28 Aug 2026 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925641;
 bh=OvxnZAWG3b8w/seBJ0Ni5Ij4tkuL7ZNnRXZC6ihz13s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TgRrw7smWdBQTJMoHOjjLVI0xIh+MuWd9lEvCIwKs444d+M70Hx+kTXpluHR/DI1v
 e1p7KX36dPLHBS8fBkbU6Bo7P3AR7wswVKtKwH8zK1nAcUomnAfSHS6aHau5566vy+
 aEFvVAkXNFXVgsMtR98NmGw/Vu5j18nmXgteU4pgVC5IVLHF2l210ily207NhqVKFF
 Kku+ALO2i2LvzdIq5FG4f9Nkcr20wzGY8B21TsHX5GZgWkklSr0PZHHWcSrCST0h71
 xkcItlkO1e7hMmYjj23izMAsJm46uWvayu6TOqHI8rnfL6gZZVuk12lVglmjWlhdz/
 Rhhzfs+QWPQQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] phy: Add common Innosilicon HDMI PHY helpers
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: mfd@lists.linux.dev, lee@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 olteanv@gmail.com, robh@kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260828-jh7110-clean-send-v2-11-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134833eucas1p2b3a442d07d7d86d0f82379bc4ecbe62a@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-11-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:00:40 +0000
Message-Id: <20260828140041.3B9041F000E9@smtp.kernel.org>
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
- [High] Possible use of uninitialized stack memory in `inno_read()` if `re=
gmap_read()` fails.
- [High] Kernel panic from division by zero in clock rate recalculation if =
PHY registers are uninitialized.
--

commit 5b3daa1c79370030c365a1cbd710f38d30ab2630
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: Add common Innosilicon HDMI PHY helpers

The Innosilicon HDMI PHY IP is used by several SoCs. They differ in
where the PHY register block sits in the register space and in which
pixel clocks they support, but the pre-PLL programming sequence and the
layout of its registers are the same.

Add a small library holding that shared part: the pre-PLL configuration
table format, a lookup, clk_ops determine_rate and recalc_rate helpers,
and the pre-PLL register programming. Callers pass a regmap, a register
offset for the PHY block, and their own pixel clock table.

> diff --git a/drivers/phy/phy-inno-hdmi.c b/drivers/phy/phy-inno-hdmi.c
> new file mode 100644
> index 0000000000000..deb2b73a86f5d
> --- /dev/null
> +++ b/drivers/phy/phy-inno-hdmi.c
[ ... ]
> +static u8 inno_read(const struct inno_hdmi_phy_pre_pll *pll, unsigned in=
t reg)
> +{
> +	unsigned int val;
> +
> +	regmap_read(pll->regmap, inno_reg(pll, reg), &val);
> +
> +	return val;
> +}

[Severity: High]
This isn't a bug introduced by this patch, as it was inherited from
drivers/phy/rockchip/phy-rockchip-inno-hdmi.c, but is it possible for
regmap_read() to fail here?

If regmap_read() returns an error code, it leaves the stack variable val
uninitialized, which is then returned to the caller.

Could we check the return value of regmap_read() to avoid leaking
uninitialized memory?

[ ... ]
> +unsigned long
> +inno_hdmi_phy_pre_pll_recalc_rate(const struct inno_hdmi_phy_pre_pll *pl=
l,
> +				  unsigned long parent_rate)
> +{
> +	u8 nd, no_a, no_b, no_d;
> +	unsigned long frac;
> +	u64 vco;
> +	u16 nf;
> +
> +	nd =3D inno_read(pll, INNO_PRE_PLL_DIV_1) & INNO_PRE_PLL_PRE_DIV_MASK;
[ ... ]
> +	if (inno_read(pll, INNO_PRE_PLL_CONTROL) & INNO_PCLK_VCO_DIV_5_MASK) {
> +		do_div(vco, nd * 5);

[Severity: High]
This is also a pre-existing issue from the original driver, but if the PHY
registers are uninitialized (containing default 0s) or if inno_read() fails
and returns an uninitialized 0, the nd variable will be 0.

Doesn't passing a 0 divisor to do_div() cause a divide-by-zero exception
leading to a kernel panic?

> +	} else {
> +		no_a =3D inno_read(pll, INNO_PCLK_DIV_AB) & INNO_PCLK_DIV_A_MASK;
> +		no_b =3D FIELD_GET(INNO_PCLK_DIV_B_MASK,
> +				 inno_read(pll, INNO_PCLK_DIV_AB)) + 2;
> +		no_d =3D inno_read(pll, INNO_PCLK_DIV_CD) & INNO_PCLK_DIV_D_MASK;
> +
> +		do_div(vco, nd * (no_a =3D=3D 1 ? no_b : no_a) * no_d * 2);

[Severity: High]
Similarly, if nd, no_a, or no_d evaluate to 0 due to register read failures
or uninitialized hardware, can this do_div() call also trigger a division by
zero panic during boot when the common clock framework calls recalc_rate()?

> +	}
> +
> +	return DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D11
