Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1766C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2190A10E148;
	Sun,  9 Aug 2026 13:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QgVayx4w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A35E10E148
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:26:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11726600AB;
 Sun,  9 Aug 2026 13:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD991F000E9;
 Sun,  9 Aug 2026 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786281994;
 bh=W8v9Vft2nj3t9nJeFUwjD7z2Fj0Z3XZuJvbz7Qx8SDw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QgVayx4wE9G03Vok+nuOm7ehYh2Dv86uqDQQnWmZb6q6hrLbevF0dSjgnkxka4yhB
 pp12UzHA+oXk9sTVBOHqV2TcrY/TRkKukrNt50g8JCSeygeYXVJt1YdrMsON8RtOyx
 HshFuqDRaKukf5LURxPVSF/8LKa1+9ObBAPQ8fogwSi9xfIw8P1df9ZgvSK0LDtYq0
 h559qLI9EktjtS0djiA0YbZMNqfkTvx3rkoDFrW0ujXVI8LHz0X4drvqOI76R2p1BM
 nrFZo/nuCf2hnTq1o44pES64rwt3spolEGfU9P7FzBmNHyzOJbRG5IZVHuR/5K8vtu
 QFE+RlJQVkJDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/17] phy: spacemit: add Innosilicon DP TX PHY driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260809-k3-display-v2-5-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-5-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:26:33 +0000
Message-Id: <20260809132634.4BD991F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing driver-level lock between concurrent clock and PHY operati=
ons creates a race condition on PREPLL state.
- [Medium] Failure to handle `XMIT_EN` regmap write error leaks the `PREPLL=
` power state during `k3_inno_dp_phy_power_on`.
- [Medium] `k3_inno_dp_pxclk_set_rate` unconditionally powers up the PREPLL=
, undermining PHY power management.
--

--- Patch [5]: [PATCH v2 05/17] phy: spacemit: add Innosilicon DP TX PHY dr=
iver ---
commit 29f359dc5de12bf07a1c791d1b6d5ab3f658ed91
Author: Cody Kang <codykang.hk@gmail.com>

phy: spacemit: add Innosilicon DP TX PHY driver

Adds support for the Innosilicon DisplayPort transmit PHY integrated in the
SpacemiT K3 SoC. The PHY shares its MMIO window with its parent DP/eDP
controller and registers its pixel PLL as a clock provider.

> diff --git a/drivers/phy/spacemit/phy-k3-inno-dp.c b/drivers/phy/spacemit=
/phy-k3-inno-dp.c
> new file mode 100644
> index 0000000000000..42ebfc347b84b
> --- /dev/null
> +++ b/drivers/phy/spacemit/phy-k3-inno-dp.c

[ ... ]

> +static int k3_inno_dp_phy_power_on(struct phy *phy)
> +{
> +	struct k3_inno_dp_phy *p =3D phy_get_drvdata(phy);
> +	u32 lane_en;
> +	u32 val;
> +	int ret;
> +
> +	switch (p->lanes) {
> +	case 1:
> +		lane_en =3D 0x1;
> +		break;
> +	case 2:
> +		lane_en =3D 0x3;
> +		break;
> +	case 4:
> +	default:
> +		lane_en =3D 0xf;
> +		break;
> +	}
> +
> +	ret =3D regmap_write_bits(p->regmap, DPTX_ANA_MPLL, DPTX_ANA_MPLL_PD, 0=
);
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write_bits(p->regmap, DPTX_ANA_PREPLL,
> +				DPTX_ANA_PREPLL_PD, 0);

[Severity: High]
Is a driver-level lock needed to prevent races between the PHY and clock
frameworks?

The clock framework serializes clk_set_rate() (which calls
k3_inno_dp_program_prepll() below), and the PHY framework serializes
phy_power_on(), but they don't synchronize with each other.

A clock rate change can race with this PHY power-on, allowing the PHY to
clear the PD bit here while the clock framework is midway through
reprogramming the PLL dividers.

> +	if (ret)
> +		return ret;
> +	usleep_range(2000, 4000);
> +
> +	ret =3D regmap_write_bits(p->regmap, DPTX_PHY_CTRL,
> +				DPTX_PHY_CTRL_XMIT_EN,
> +				FIELD_PREP(DPTX_PHY_CTRL_XMIT_EN, lane_en));
> +	if (ret)
> +		return ret;

[Severity: Medium]
Does this skip the required DPTX_ANA_PREPLL_PD rollback?

If this regmap write fails, returning directly bypasses the err_power_down
cleanup label. This would leave the pixel PLL powered up indefinitely.

> +	usleep_range(2000, 4000);
> +
> +	ret =3D regmap_read_poll_timeout(p->regmap, DPTX_ANA_MPLL, val,
> +				       val & DPTX_ANA_MPLL_LOCKED,
> +				       2000, 10 * 1000);

[ ... ]

> +static void k3_inno_dp_program_prepll(struct k3_inno_dp_phy *p,
> +				      const struct k3_inno_dp_prepll_cfg *cfg)
> +{
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PD,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PD, 1));
> +	usleep_range(2000, 4000);
> +
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PREDIV,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PREDIV, cfg->prediv));

[ ... ]

> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL_CTRL,
> +		DPTX_ANA_PREPLL_PCLKDIV5_EN,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PCLKDIV5_EN, cfg->div5_en));
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL_CTRL,
> +		DPTX_ANA_PREPLL_PCLK_DIVAUX,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PCLK_DIVAUX, cfg->divp));
> +
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL,
> +		DPTX_ANA_PREPLL_PCLK_NORMAL,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PCLK_NORMAL, 1));
> +	usleep_range(2000, 4000);
> +
> +	regmap_write_bits(p->regmap, DPTX_ANA_PREPLL, DPTX_ANA_PREPLL_PD,
> +		FIELD_PREP(DPTX_ANA_PREPLL_PD, 0));

[Severity: Medium]
Does this unconditionally power up the PREPLL, even if the PHY is currently
turned off?

The clock framework can call set_rate() when the display pipeline is
disabled (for example, via assigned-clock-rates during boot). Since the
clock provider doesn't implement a .disable callback, this appears to force
the PLL to turn on and stay powered up until a subsequent phy_power_off()
cycle occurs.

> +	usleep_range(2000, 4000);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D5
