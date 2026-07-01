Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54AAC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C966010EF89;
	Wed,  1 Jul 2026 12:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o1GXLvg8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4228310EF8B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:39:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1E2260138;
 Wed,  1 Jul 2026 12:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97BD1F000E9;
 Wed,  1 Jul 2026 12:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909547;
 bh=KQxD+BDucLd1j70ef6LoNzXEdO8IcXi/OcuAmbgGP9E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o1GXLvg8bWxPNq/IZqiGTy+27SX67f/viurF+m0Muguxdf3ovdcWTANQ4bHoZla1M
 3xwJuFiZu3mARxdLyFUWraZ4+680Z3GWbdO3vabKtAYmRm5wWQpF21VGzXAHrBFRsd
 54OypaoZ7k8xvIESxk3jC0u5JNRAIQYlG6Wcfft3D1HN1SM4QovS/IqafQxbjkIKYI
 foC8xTrkcy1Ianndzm2SpeJk8qyekPUPT7btsT3gIzNg0byhmyIC2M31H51qxczxti
 LI8EMdjYJnc+GXR88u7EF6cneNVVyVJ0FHZ4+Cz7AmAZZNarM7dlzEYQxz013pB0JK
 bRuz2a6mnmxXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] phy: phy-mtk-dp: Implement power_on and power_off
 PHY callbacks
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, vkoul@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, linux-phy@lists.infradead.org
In-Reply-To: <20260701122008.19509-6-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:39:06 +0000
Message-Id: <20260701123906.D97BD1F000E9@smtp.kernel.org>
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
- [High] The power_on and power_off callbacks use the digital register layo=
ut array to look up an analog register offset, causing register operations =
to modify the wrong hardware offset.
- [Medium] The error path in `mtk_dp_phy_power_on()` fails to unwind previo=
usly applied hardware state if a subsequent step fails, leaking power state.
--

commit db1c6c4d46cae7dc24770e2f52553b8292fbfbc9
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Implement power_on and power_off PHY callbacks

Add .power_on() and .power_off() callbacks to mtk_dp_phy_dev_ops
to be able to call those with phy_power_on() and phy_power_off()
API in the DisplayPort driver to be able to stop using all of
those hardcoded register writes in that external driver.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index ce33f6812bae6..586e727956332 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -200,6 +236,53 @@ static int mtk_dp_phy_configure(struct phy *phy, uni=
on phy_configure_opts *opts)
>  	return 0;
>  }
> =20
> +static int mtk_dp_phy_power_on(struct phy *phy)
> +{
> +	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs =3D pdata->regs_dig_glb;
> +	int ret;
> +
> +	/* Enable AUX Channel with RX De-Glitch and input clock detection */
> +	ret =3D regmap_write(dp_phy->regmap,
> +			   pdata->off_dig_glb + regs[DP_PHYD_AUX_RX_CTL],
> +			   PHYD_DIG_DPAUX_RX_EN |
> +			   PHYD_DIG_XTP_GLB_CKDET_EN |
> +			   PHYD_DIG_DPAUX_RX_DEGLITCH_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_clear_bits(dp_phy->regmap,
> +				pdata->off_ana_glb + regs[DP_PHYA_GLB_FORCE_CTRL_1],

[Severity: High]
Here regs points to the digital register array pdata->regs_dig_glb, but it =
is
being indexed with DP_PHYA_GLB_FORCE_CTRL_1, which is an analog register
enum. Does this result in reading the wrong offset (fetching the offset for
DP_PHYD_BIT_RATE instead of DP_PHYA_GLB_FORCE_CTRL_1) and corrupting the
bitrate configuration?

> +				CKM_CKTX0_EN_FORCE_MODE);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If regmap_clear_bits() fails here, the function returns the error without
unwinding the previous successful write to DP_PHYD_AUX_RX_CTL. Since the PHY
core will not call phy_power_off() if phy_power_on() returns an error, does
this leave the RX channel and clock detection permanently enabled?

> +
> +	return 0;
> +}
> +
> +static int mtk_dp_phy_power_off(struct phy *phy)
> +{
> +	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs =3D pdata->regs_dig_glb;
> +	int ret;
> +
> +	ret =3D regmap_set_bits(dp_phy->regmap,
> +				pdata->off_ana_glb + regs[DP_PHYA_GLB_FORCE_CTRL_1],

[Severity: High]
Similarly to mtk_dp_phy_power_on(), this uses the digital register array
regs indexed with the analog enum DP_PHYA_GLB_FORCE_CTRL_1. Should this use
pdata->regs_ana_glb instead to avoid writing to the wrong hardware offset?

> +				CKM_CKTX0_EN_FORCE_MODE);
> +	if (ret)
> +		return ret;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D5
