Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0911C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0216E10E393;
	Wed,  1 Jul 2026 12:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kv2csqmE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFA310E393
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:49:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BF696001D;
 Wed,  1 Jul 2026 12:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953791F000E9;
 Wed,  1 Jul 2026 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782910175;
 bh=v3UgTfSxwXblzsiR2gHqjASTi3JdJQyKR9vyVzveb/4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kv2csqmEoVUHDDv3UiqHvXgnVh1j9XywRdUunm0vj3xd5PoS4NLSEB/tHsFSNby7r
 t0ESCSHc7ZJ/KaIZVm8qlcD/iWdR44/ivDxy/LHsL6ws2AVbSRq15FPdyxOJkcUNYj
 +/Hslr72fBxIrUa7JIJRnS+l20/ySl5YUnk9kNg3S3JfgBTVshNl6DGt0LrJOD3yA2
 IVNDYnDotI6H4OLka1H754eX8duRdMARUWIcI1udiTlGx1C69aeb04TibDbXfYoCCr
 HhAqvomsBPE0yOa0wycCIdTsgTs4TavYD8W9L2+/ApmngZXVMgWP5mLHlPQoTXLEqa
 XhWEfb7hWscRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] phy: phy-mtk-dp: Support setting volt swing and
 preemphasis values
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, devicetree@vger.kernel.org, robh@kernel.org,
 vkoul@kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, conor+dt@kernel.org
In-Reply-To: <20260701122008.19509-8-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:49:33 +0000
Message-Id: <20260701124934.953791F000E9@smtp.kernel.org>
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

New issues:
- [High] The newly added PHYD_DP_TX_FORCE_VOLT_SWING_EN bit is never set or=
 cleared, causing the hardware to likely ignore the configured voltage swin=
g and pre-emphasis values.
- [High] Undefined behavior in `mtk_dp_phy_disable_all_lanes` when no lanes=
 are currently enabled.

Pre-existing issues:
- [High] Missing `.remove` callback leads to Use-After-Free and unbalanced =
PM runtime states on module unload.
--

commit 3443073c225a00d56dcccbe80409c8537773ab64
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Support setting volt swing and preemphasis values

Add support for honoring the set_voltages request to set the voltage swing
and preemphasis values in the .configure() callback. It also updates the
.reset() callback to clean up the newly configured values.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index a2cd22b9da066..17d871530ccaf 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -235,6 +242,28 @@ static int mtk_dp_phy_configure(struct phy *phy, uni=
on phy_configure_opts *opts)
>  				   PHYD_TX_LN_EN, val);
>  	}
> =20
> +	if (opts->dp.set_voltages) {
> +		const u32 reg_drv_force =3D pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_F=
ORCE];
> +
> +		if (opts->dp.lanes > 4) {
> +			dev_err(&phy->dev, "Wrong lanes config %u\n", opts->dp.lanes);
> +			return -EINVAL;
> +		}
> +
> +		for (i =3D 0; i < opts->dp.lanes; i++) {
> +			const u32 off_dig_lane =3D pdata->off_dig_lane[i];
> +			u32 val;
> +
> +			val =3D FIELD_PREP(PHYD_DP_TX_FORCE_VOLT_SWING_VAL, opts->dp.voltage[=
i]);
> +			val |=3D FIELD_PREP(PHYD_DP_TX_FORCE_PRE_EMPH_VAL, opts->dp.pre[i]);
> +
> +			regmap_update_bits(dp_phy->regmap, off_dig_lane + reg_drv_force,
> +					   PHYD_DP_TX_FORCE_VOLT_SWING_VAL |
> +					   PHYD_DP_TX_FORCE_PRE_EMPH_VAL,
> +					   val);

[Severity: High]
Does this override hardware configuration actually take effect?

Since PHYD_DP_TX_FORCE_VOLT_SWING_EN is not included in the update mask or
set in the value here, the hardware force enable bit remains unset. Will
the hardware ignore these override values without the enable bit being
asserted?

> +		}
> +	}
> +
>  	regmap_update_bits(dp_phy->regmap,
[ ... ]
> @@ -345,6 +375,15 @@ static int mtk_dp_phy_reset(struct phy *phy)
>  	if (ret)
>  		dev_err(dp_phy->dev, "Could not disable lanes during reset!\n");
> =20

[Severity: High]
Is it possible for the loop in mtk_dp_phy_disable_all_lanes() to execute
with val initially set to 0?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_disable_all_lanes() {
    ...
    /* Get mask of currently enabled lane */
    val =3D FIELD_GET(PHYD_TX_LN_EN, val);

    /* Disable all lanes (needs to be done one by one, from last to first) =
*/
    do {
        u32 lane_num =3D fls(val) - 1;
        val &=3D ~BIT(lane_num);
    ...
}

If no lanes are currently enabled, fls(0) - 1 evaluates to -1, which can
cause undefined behavior when shifting ~BIT(-1). Should this be a
while (val) loop instead of do { ... } while (val)?

> +	/* Reset Voltage Swing and Preemphasis values */
> +	for (i =3D 0; i < MTK_DP_PHY_MAX_LANES; i++) {
> +		const u32 off_dig_lane =3D pdata->off_dig_lane[i];
> +
> +		regmap_clear_bits(dp_phy->regmap, off_dig_lane + reg_drv_force,
> +				   PHYD_DP_TX_FORCE_VOLT_SWING_VAL |
> +				   PHYD_DP_TX_FORCE_PRE_EMPH_VAL);

[Severity: High]
Does this correctly clear the override state?

Similar to the configuration above, this clears the swing and pre-emphasis
values but leaves the PHYD_DP_TX_FORCE_VOLT_SWING_EN bit untouched. If
the force mode was enabled elsewhere, could it remain active after reset?

> +	}
> +
>  	return 0;
>  }


[Severity: High]
This is a pre-existing issue, but I noticed the platform driver lacks a
.remove callback:

static struct platform_driver mtk_dp_phy_driver =3D {
	.probe =3D mtk_dp_phy_probe,
	.driver =3D { ... },
};

During probe, pm_runtime_enable() and pm_runtime_get_sync() are called, and
a phy_lookup structure is dynamically allocated via phy_create_lookup().

Because there is no .remove callback, unloading the module leaves PM runtime
unbalanced and leaks the phy_lookup struct, which remains on the global phys
list while pointing to a devres-freed phy device. Could this lead to a
use-after-free on subsequent lookups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D7
