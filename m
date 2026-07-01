Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C53C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610A010EF88;
	Wed,  1 Jul 2026 12:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pn0V4vIU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EA210EF8D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:48:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8DC76001D;
 Wed,  1 Jul 2026 12:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1241F000E9;
 Wed,  1 Jul 2026 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782910104;
 bh=1T7VWutfcoT1eQhz6SNDIKkUC3UgjAn1asmuahoNjEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pn0V4vIUspI+U3HIrzMrqv7noPwD0R7B9lbAF3BDEk5dqxLfi0SN7GAhF5EZZ9qSE
 9+q0eZv6/wWEShFlrZwpDWa1p/rNpGlpTmYL6ktyZi+fFHbs3Q9GuwaQ4ru4CpaxV2
 Zo9nOxBOFIy878dbJbW7qR2u65Co/i776XC8DWqaMPLJu8Dd5BptA6HRaMI/DFzlEP
 gAHnRQZClle6scG7/tv6de8nrdadHXv0CyhIWCJt/kqQOYqiD41WH1J86sM0+NtiNv
 vW27FBs+Q9oWQ8CH0kyHFchVcA9Tv8EtukhY7QqS7af4+q/VK9tEPfbRVYc9lVVMW7
 fgC7PIVqVhKmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] phy: phy-mtk-dp: Add support for digital and
 analog calibration
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, vkoul@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 robh@kernel.org
In-Reply-To: <20260701122008.19509-9-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:48:23 +0000
Message-Id: <20260701124824.2C1241F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Pointer casting a 16-bit variable to a `u8 *` in `nvmem_cell_read_=
u8()` causes incorrect value retrieval on big-endian architectures.
- [High] `mtk_dp_phy_set_analog_calibration_params()` clears hardware regis=
ters due to missing bitwise shifts and ignores eFuse calibration.
- [High] Legacy probe path fails to initialize analog calibration parameter=
s, breaking PHY transmission.
- [High] Driver probe fails unconditionally on platforms without NVMEM supp=
ort due to unhandled `-EOPNOTSUPP`.
- [High] Missing `pm_runtime_put_sync()`, `pm_runtime_disable()`, and `phy_=
remove_lookup()` in driver removal, with unchecked `pm_runtime_get_sync()`.
- [High] Incorrect indexing of digital register array using an analog enum =
causes writes to the wrong offsets during power off.
- [Medium] Spams `dev_err` on boot when expected eFuse calibration data is =
not present.
- [Medium] Incorrect field mask used when validating N-MOSFET impedance val=
ues.
- [Low] The field `efuse_cal_present` is set but never read.
--

commit d7c70553eca35e13b77a951e8cbb9167598a5701
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Add support for digital and analog calibration

This commit adds support for reading digital and analog calibration
values from eFuse for the MediaTek DP PHY. If calibration values are
present, they are used; otherwise, the driver falls back to SoC-specific
defaults. It also implements hardware writes for the analog calibration.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 17d871530ccaf..cdcae861012c7 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -257,21 +257,21 @@
> +static int mtk_dp_phy_set_analog_calibration_params(struct mtk_dp_phy *d=
p_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs_ana_glb =3D pdata->regs_ana_glb;
> +	const u8 *regs_ana_lane =3D pdata->regs_ana_lane;
> +	int i, ret;
> +
> +	ret =3D regmap_update_bits(dp_phy->regmap,
> +				 pdata->off_ana_glb + regs_ana_glb[DP_PHYA_GLB_BIAS_GEN_0],
> +				 XTP_GLB_BIAS_INT_R_CTRL, pdata->ana_bias_r);

[Severity: High]
Does this clear the hardware registers instead of applying the calibrated
values?

The regmap_update_bits() call uses the static pdata->ana_bias_r defaults
instead of the calibrated dp_phy->ana_bias_r. Additionally, passing unshift=
ed
values with the high-mask field XTP_GLB_BIAS_INT_R_CTRL results in a bitwise
AND that yields zero.

[ ... ]
> @@ -517,109 +517,109 @@
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
> +	if (ret)
> +		ret =3D nvmem_cell_read_u16(dev, name, &buf);

[Severity: High]
Can this pointer cast corrupt the read value on big-endian architectures?

Casting the 16-bit buf variable to (u8 *) will write to the most significant
byte on big-endian systems. This shifts the 8-bit value left by 8 bits, whi=
ch
will exceed max_val and cause an -ERANGE error.

> +
> +	if (ret) {
> +		dev_err(dev, "Cannot get calibration data for %s: %d\n", name, ret);
> +		return ret;
> +	};

[Severity: Medium]
Will this spam dev_err on boot when the eFuse calibration data is missing?

If the NVMEM cells are absent, this unconditionally prints an error before =
the
fallback logic can handle the -ENOENT return code.

[ ... ]
> +static int mtk_dp_phy_get_calibration_data(struct mtk_dp_phy *dp_phy)
> +{
> +	char mtk_dp_cal_lane_imp_name[] =3D "impedance-laneXM";
> +	struct device *dev =3D dp_phy->dev;
> +	int i, ret;
[ ... ]
> +	/* Get impedance params for each lane */
> +	for (i =3D 0; i < MTK_DP_PHY_MAX_LANES; i++) {
> +		/* P-MOSFET first */
[ ... ]
> +		/* ...and then N-MOSFET too */
> +		snprintf(mtk_dp_cal_lane_imp_name, ARRAY_SIZE(mtk_dp_cal_lane_imp_name=
),
> +			 "impedance-lane%dn", i);
> +		ret =3D mtk_dp_phy_get_one_cal_para(dev, mtk_dp_cal_lane_imp_name,
> +						  FIELD_MAX(XTP_LN_TX_IMPSEL_PMOS));

[Severity: Medium]
Is this using the wrong mask for the N-MOSFET impedance values?

It passes FIELD_MAX(XTP_LN_TX_IMPSEL_PMOS) instead of NMOS. While they both
share a 4-bit width currently, this might cause semantic errors if the bit
widths change.

> +		if (ret < 0)
> +			goto end;
> +		dp_phy->ana_impsel[i].nmos =3D ret;
> +	}
> +end:
> +	if (ret < 0) {
> +		/*
> +		 * If any of the calibration values is missing, or if there
> +		 * is no calibration at all in the eFuses, copy the default
> +		 * one entirely (as partial values shall not be mixed!)
> +		 */
> +		if (ret =3D=3D -ENOENT) {
> +			dev_info(dev, "Using calibration default values\n");
> +			mtk_dp_phy_get_default_cal_data(dp_phy);
> +			return 0;
> +		}
> +		return ret;
> +	};

[Severity: High]
Will the driver probe fail unconditionally on platforms without NVMEM suppo=
rt?

If NVMEM is disabled, nvmem_cell_read_u8() returns -EOPNOTSUPP. The strict
check for -ENOENT means the default fallback is skipped and the driver probe
aborts.

> +	dp_phy->efuse_cal_present =3D true;

[Severity: Low]
Is this flag actually used anywhere?

The efuse_cal_present field is populated here but does not seem to be
evaluated anywhere else in the code.

> +
> +	return 0;
> +}
[ ... ]
> @@ -437,6 +661,7 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)
>  	struct mtk_dp_phy *dp_phy;
>  	void __iomem *base;
>  	struct phy *phy;
> +	int ret;
> =20
>  	dp_phy =3D devm_kzalloc(dev, sizeof(*dp_phy), GFP_KERNEL);
>  	if (!dp_phy)
> @@ -458,6 +683,10 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
> =20
>  	dp_phy->pdata =3D device_get_match_data(dev);
> =20
> +	ret =3D mtk_dp_phy_get_calibration_data(dp_phy);
> +	if (ret)
> +		return ret;
> +

[Severity: High]
Does the legacy probe path also need to initialize the analog calibration
parameters?

If mtk_dp_phy_legacy_probe() bypasses calibration data loading,
dp_phy->ana_impsel is left entirely zeroed. These uninitialized zeroes will
then be written directly to the PHY registers, which breaks transmission on
legacy platforms.

[Severity: High]
Does the driver properly clean up runtime PM resources during removal?

The probe function acquires PM resources without verifying the result:

pm_runtime_enable(dev);
pm_runtime_get_sync(dev);

But there appears to be no corresponding .remove callback providing
pm_runtime_put_sync(), pm_runtime_disable(), or phy_remove_lookup().

[Severity: High]
Does mtk_dp_phy_power_off() access the wrong offset by indexing a digital
register array with an analog enum?

Looking at mtk_dp_phy_power_off() in phy-mtk-dp.c:

static int mtk_dp_phy_power_off(struct phy *phy)
{
        ...
        const u8 *regs =3D pdata->regs_dig_glb;
        ...
        ret =3D regmap_set_bits(dp_phy->regmap,
                        pdata->off_ana_glb + regs[DP_PHYA_GLB_FORCE_CTRL_1],

Using DP_PHYA_GLB_FORCE_CTRL_1 (which is an analog enum) to index regs
(which points to regs_dig_glb) writes to the wrong offsets during power off.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D8
