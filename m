Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD788C44500
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A3CC10EF8B;
	Wed,  1 Jul 2026 12:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kp1AG33T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 544AA10EF8D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:50:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A0BF43CD8;
 Wed,  1 Jul 2026 12:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27181F00A3A;
 Wed,  1 Jul 2026 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782910219;
 bh=ogQceqQ808YsZTT5xDvMfw/Hxp/6gRHLqBYleisECB4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kp1AG33TiMj1MOOaPTrHbySOB1SFehS0ILSJ7TceQ+aea/ThrhP+ELIB8SSAD7/dG
 yxiWNflGVKZWYwm4Mza9zuHdhXkhtU0q+Ky3GcmNfhHgIEEx8SH96dIxnKtPr2XJAx
 c735uhAP+PJ2ir/8CB5/FLIsd/fub+Q1Xm1OiFFQFiLimb13hBddXFN09jCFqXdbnt
 hAHFoXMfqcrtPo5ayIIeYQUvTQsa/ELKgdvk5t10Pw0j/gcBfIHvaJjItJL9Xkmm5X
 QcM9uwtwEYwIniG08wz32riltIH8AmYOo99vcYL/OrxG2cQiw1PP36fHZa7LdmvvSR
 xUQChCvVXRiHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] phy: phy-mtk-dp: Rewrite and document default
 driving param macros
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, conor+dt@kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260701122008.19509-10-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:50:15 +0000
Message-Id: <20260701125017.E27181F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The refactoring introduces incorrect integer values for two Displa=
yPort PHY driving parameters, silently altering the underlying hardware con=
figuration.
- [High] Integer underflow and undefined behavior in mtk_dp_phy_disable_all=
_lanes when no lanes are enabled.
- [High] Flawed PM runtime initialization, race condition, and unhandled er=
rors in probe.
- [Medium] Incorrect endianness conversion by pointer aliasing a u16 as a u=
8*.
--

commit 3ae397642076d659c70475bdbefbc3286e0e7c1f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: phy: phy-mtk-dp: Rewrite and document default driving param macros

This patch uses FIELD_PREP_CONST and adds definitions and macros to build
the default driving parameters for the PHY. It also adds comments explaining
what they are supposed to set in the PHY.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index d7024a1443358..1d73a622ef322 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> +/* MT8195: Logic State Change Point (LC TX C) */
> +#define MT8195_DRIVING_PARAM_3_DEFAULT	BUILD_DRIVING_PARAM_0( 16, 20, 24=
, 32)
> +#define MT8195_DRIVING_PARAM_4_DEFAULT	BUILD_DRIVING_PARAM_12(24, 30, 60=
, 32)

[Severity: High]
Does this unintentionally change the default for SW1_PRE2?

The conversion to macros incorrectly alters the sw1_pre2 value. The
original macro XTP_LN_TX_LCTXC0_SW1_PRE2_DEFAULT was (BIT(18) | BIT(21)),
which evaluates to 36 (0x24) when shifted. This macro now sets it to
60 (0x3c).

> +#define MT8195_DRIVING_PARAM_5_DEFAULT	BUILD_DRIVING_PARAM_23(8, 48)

[Severity: High]
Is there a similar issue with the default for SW2_PRE1?

The original value was 40 (0x28), but this is now passing 8 (0x08), which
drops BIT(5). These altered driving parameters can degrade signal integrity
and cause connection instability.

[ ... ]
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
> +
> +		ret =3D regmap_clear_bits(dp_phy->regmap,
> +					pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0],
> +					FIELD_PREP(PHYD_TX_LN_EN, lane_num));
> +		if (ret)
> +			return ret;
> +	} while (val);

[Severity: High]
Can this do-while loop execute with val initially at 0?

If the PHY is already fully disabled when this is called, val will be 0.
The loop blindly executes once, fls(0) returns 0, and lane_num underflows
to 0xffffffff.

Using ~BIT(0xffffffff) invokes undefined behavior, and passing 0xffffffff
to FIELD_PREP() extracts unpredictable bits, causing a spurious out-of-boun=
ds
register write when clearing the PHY control registers.

> +
> +	return 0;
> +}
[ ... ]
> +static int mtk_dp_phy_get_one_cal_para(struct device *dev, const char *n=
ame, u8 max_val)
> +{
> +	u16 buf =3D 0;
> +	int ret;
> +
> +	/*
> +	 * All of the calibrations are always max 8 bits long, but some may
> +	 * be split between two different 8-bits cells: handle this corner
> +	 * case by retrying reading as u16.
> +	 */
> +	ret =3D nvmem_cell_read_u8(dev, name, (u8 *)&buf);

[Severity: Medium]
Will this lead to an endianness violation on Big Endian platforms?

Casting a u16 buffer pointer to (u8 *) will cause the single byte to be
written into the most significant byte of buf instead of the least
significant byte on Big Endian architectures.

For instance, reading 0x0F would result in buf holding 0x0F00 (3840), which
would falsely trigger the subsequent if (buf > max_val) validation check.

> +	if (ret)
> +		ret =3D nvmem_cell_read_u16(dev, name, &buf);
[ ... ]
> +static int mtk_dp_phy_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	phy_set_drvdata(phy, dp_phy);
> +
> +	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);

[Severity: High]
Could registering the provider before enabling PM runtime cause a race cond=
ition?

Exposing the PHY to consumers here means a consumer could claim the PHY and
attempt to power it on before pm_runtime_enable() is called below. This
would return -EACCES and break the consumer initialization.

> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

[Severity: High]
Should the return value of pm_runtime_get_sync(dev) be checked?

Ignoring the return value means the probe silently succeeds even if the
hardware cannot be powered.

Additionally, this driver lacks a .remove callback. Since
pm_runtime_get_sync() increases the usage counter without it ever being
released, and pm_runtime_disable() is never called, unloading the module
permanently leaks the PM reference and breaks PM runtime for this device.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D9
