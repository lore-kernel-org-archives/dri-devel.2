Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4470C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041C310EDA2;
	Tue,  7 Jul 2026 14:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e141pv7+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB2D10EDA4
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:33:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C3A7600C3;
 Tue,  7 Jul 2026 14:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5D1F000E9;
 Tue,  7 Jul 2026 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434791;
 bh=WvPCsvkPIm1Ji0A+edy/KwqEoKpNNG0SeqzntHfLNVI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e141pv7+1m+MaVssYdSEuSStETnCZPwJt9BfNpor7Z492sCVJeY6YiHFBlNjUNuJL
 Tdk0/JWJfQoH1gUfQ3m9MWZ8OxARamkmxvg4/y7A1+E+iVU/hD+Ts8qc2sVRJAj7Je
 tr2yAoERDXd+aAbsu6+ssLW0z2S7mtfigLqOnIWCiISf/fYqmT1zU8EDuxYdjPfbOF
 ag2Rv0zEOHMlW6DWKHamfI1vdM4WBqgeEYIvi71FNr8oPDylNjoD/PLnDhvAxWdYFM
 q80i7z4rDjmAJj07yVStsfgdxBTws8HSim7dFrZX6sUkq0MhNKK6p8eaHxO7ZlSkpB
 +6HJF764mrt7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] phy: phy-mtk-dp: Implement power_on and
 power_off PHY callbacks
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260707141931.191172-6-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:33:10 +0000
Message-Id: <20260707143310.E1D5D1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] mtk_dp_phy_power_off() aborts early on regmap_set_bits failure, =
leaving the RX channel perpetually enabled.
- [Medium] Missing check for device_get_match_data() returning NULL in mtk_=
dp_phy_probe, leading to a crash in PHY operations.
- [Low] Undeclared variable 'ret' in mtk_dp_phy_probe() causes a strict bui=
ld failure.

Pre-existing issues:
- [High] Dereferencing dev->platform_data without checking for NULL in mtk_=
dp_phy_legacy_probe leads to a kernel panic.
--

--- Patch [5]: [PATCH v2 05/12] phy: phy-mtk-dp: Implement power_on and pow=
er_off PHY callbacks ---
commit db273838783f1ea341d7728660183966ad3c4d16
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Implement power_on and power_off PHY callbacks

This commit adds .power_on() and .power_off() callbacks to the DisplayPort
PHY operations. These additions allow the DisplayPort driver to use the
phy_power_on() and phy_power_off() APIs instead of hardcoded register write=
s.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 915f148325c49..0c3f06791613a 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -200,6 +225,59 @@ static int mtk_dp_phy_configure(struct phy *phy, uni=
on phy_configure_opts *opts)
>  	return 0;
>  }
> =20
> +static int mtk_dp_phy_power_on(struct phy *phy)
> +{

[ ... ]

> +static int mtk_dp_phy_power_off(struct phy *phy)
> +{
> +	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs_dig =3D pdata->regs_dig_glb;
> +	const u8 *regs_ana =3D pdata->regs_ana_glb;
> +	int ret;
> +
> +	ret =3D regmap_set_bits(dp_phy->regmap,
> +			      pdata->off_ana_glb + regs_ana[DP_PHYA_GLB_FORCE_CTRL_1],
> +			      CKM_CKTX0_EN_FORCE_MODE);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If regmap_set_bits() fails and returns early, could this leave the hardware
RX channel powered on indefinitely?=20

Teardown steps usually proceed on a best-effort basis to ensure subsequent
hardware disable operations are executed.

> +
> +	/* Disable RX */
> +	ret =3D regmap_write(dp_phy->regmap,
> +			   pdata->off_dig_glb + regs_dig[DP_PHYD_AUX_RX_CTL], 0);

[ ... ]

> @@ -319,8 +399,10 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
>  }

[Severity: Low]
Does this code cause a build failure?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
    ret =3D devm_pm_runtime_enable(dev);
    if (ret)
        return ret;
    ...
}

It appears the variable 'ret' is used but not declared.

[Severity: Medium]
Does this code need a NULL check for the return value of
device_get_match_data()?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
    dp_phy->pdata =3D device_get_match_data(dev);

    phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
    ...
}

If the device is bound manually via sysfs and the compatible string doesn't
match, device_get_match_data() could return NULL, which might crash the
kernel in subsequent operations like mtk_dp_phy_power_on().

[Severity: High]
This is a pre-existing issue, but does dereferencing dev->platform_data
without checking for NULL in mtk_dp_phy_legacy_probe() lead to a crash?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_legacy_probe() {
    ...
    dp_phy->regmap =3D *(struct regmap **)dev->platform_data;
    if (!dp_phy->regmap)
        return dev_err_probe(dev, -EINVAL, "No platform data available\n");
    ...
}

If pdev->dev.platform_data is NULL, the blind pointer dereference happens
before the sanity check is reached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D5
