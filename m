Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF1DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B0F10EF7F;
	Wed,  1 Jul 2026 12:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZnbgQ2v3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091DB10EF7F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:35:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39F8E6001D;
 Wed,  1 Jul 2026 12:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5DA1F000E9;
 Wed,  1 Jul 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909336;
 bh=CJQNdIVi/Q1P74CPDcCp+i08uA+8nWhJngkcnx8r1s0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZnbgQ2v3lT+qQ8RE3rnxpKNplm6LDhKyyS0bOdfJ+wSgvN5VUNh87jjG6K5p7xsdt
 HPrwlv5Y8eitA7X/0pP0E4qmwzxVEDHIdfNPKqleIheBfLaZPDR4W6ly5CI1MkNh8o
 Uo4BDxO6fj4Iaeo63Ih3bUBKCj8tBiCztQ0XbNFr1ow6Vg/jX+nRdU1pb9pQvZprPP
 dUmbvuhhGU/LJPHxMgUUWf6TIjyynKljYeyA+z6u3GnXqlPae37KyD4ug8bRZXI2qo
 t6I9K6ADE/fOwkCrTuy6yEJ4nZy7yBhafyMlMnsu6eNstwJ3Fcc1pSP9Y4XA0W4/6O
 57C6/LrFWlwdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] phy: phy-mtk-dp: Support set_lanes in configure
 and properly cleanup
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, linux-phy@lists.infradead.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com, vkoul@kernel.org
In-Reply-To: <20260701122008.19509-7-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:35:35 +0000
Message-Id: <20260701123536.6C5DA1F000E9@smtp.kernel.org>
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
- [High] Unconditional do-while loop in `mtk_dp_phy_disable_all_lanes` caus=
es an out-of-bounds bitwise shift and undefined behavior when no lanes are =
initially enabled.
- [High] `mtk_dp_phy_disable_all_lanes` passes a bit index instead of a bit=
mask to `FIELD_PREP`, failing to disable the correct lanes.
--

commit 25cdd51bd1ac4d69a49e77d93a6b1374ba46dd3c
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Support set_lanes in configure and properly cleanup

Add support for enabling a specifically requested number of lanes
in the .configure() callback and disable all lanes in power off
and reset callbacks for proper hardware cleanup.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 586e727956332..a2cd22b9da066 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -261,6 +267,35 @@ static int mtk_dp_phy_power_on(struct phy *phy)
>  	return 0;
>  }
> =20
> +static int mtk_dp_phy_disable_all_lanes(struct mtk_dp_phy *dp_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs =3D pdata->regs_dig_glb;
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(dp_phy->regmap, pdata->off_dig_glb + regs[DP_PHYD_T=
X_CTL_0], &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Get mask of currently enabled lane */
> +	val =3D FIELD_GET(PHYD_TX_LN_EN, val);
> +
> +	/* Disable all lanes (needs to be done one by one, from last to first) =
*/
> +	do {
> +		u32 lane_num =3D fls(val) - 1;
> +		val &=3D ~BIT(lane_num);
                 ^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this cause undefined behavior if val is initially 0?

If the PHY register reports 0 enabled lanes (which can happen after a
hardware reset or during initial boot), val will be 0. Since this is an
unconditional do-while loop, fls(0) will return 0, leading to lane_num
evaluating to UINT_MAX.

The subsequent BIT(lane_num) attempt would result in an out-of-bounds
bitwise shift. Could this be changed to a while loop, or check if val is 0
before entering the loop?

> +
> +		ret =3D regmap_clear_bits(dp_phy->regmap,
> +					pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0],
> +					FIELD_PREP(PHYD_TX_LN_EN, lane_num));
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this clear the correct lanes in the register?

It looks like the bit index lane_num is passed directly to FIELD_PREP here
instead of the bitmask BIT(lane_num), which was correctly used in
mtk_dp_phy_configure().

If lane_num is 3, FIELD_PREP(GENMASK(7, 4), 3) will generate 0x30, which
clears lanes 0 and 1 instead of 0x80 (which would clear lane 3). This seems
like it might repeatedly attempt to clear the wrong lanes and leave higher
lanes enabled.

> +		if (ret)
> +			return ret;
> +	} while (val);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D6
