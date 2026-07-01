Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2BAC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC30810F01C;
	Wed,  1 Jul 2026 13:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h26Qf/2s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BFB10F00F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:01:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D017F601E0;
 Wed,  1 Jul 2026 13:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048FF1F000E9;
 Wed,  1 Jul 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782910907;
 bh=/6s17sWw2U7DvJbiMh+7Uzrpjv0Cj2ixXONGdYVjlyk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h26Qf/2sie84Kt2Lq5qJm2beqhQV7Hp6ljbhgPu42bsctKhi0fKNWeqFDRWIN0EnC
 xvBKg3sORBitLD0cnuto34hmpUD9SGOjcYzzdNm3utFwhvJOMwOiw8SUCZxelpmtb4
 70Jr8HaQTrtXVKCb+DkcLa10Dtt66vJVay0nxgo0N6RCdEGNtKKWyGN73uOA4Ccc+w
 2qMhK+R95t1Lp0/Ct4n+R/A458X/zYFDjg3MFPPncJlN0tXDKr8KSqVtbjZ1dMkmDY
 yTti4iFKWe/vcbmB7HUFWIktZRBGmHpbPAlQmDlNtU1zTIxDHFbVjAmatpPdaPFkXl
 STur2eZrh6CMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] phy: phy-mtk-dp: Add support for MT8196 eDP PHY
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: vkoul@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701122008.19509-13-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:01:46 +0000
Message-Id: <20260701130147.048FF1F000E9@smtp.kernel.org>
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
- [High] The MT8196 layout places DP_PHYD_LAN_DRIVING_FORCE at an offset th=
at is overwritten by a contiguous bulk write to the driving parameters.

Pre-existing issues:
- [High] Lane disabling logic incorrectly clears the wrong register bits, l=
eaving upper lanes powered on and corrupting adjacent lanes.
- [High] Analog register offsets are mistakenly fetched from the digital re=
gister array, causing writes to the wrong address.
- [High] Missing shift for analog calibration parameters passed to regmap_u=
pdate_bits() zeroes out hardware fields.
--

commit 25701726cdcf8525c87349866f69aa298517187f
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: phy: phy-mtk-dp: Add support for MT8196 eDP PHY

The MT8196 SoC features an updated PHY IP compared to the older ones, and
there is one that is specific to Embedded DisplayPort. This patch adds
support for the eDP PHY found in the MediaTek MT8196 SoC and all of its
variants.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index f067acef222f7..998ac34466678 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -178,6 +190,11 @@ static const u8 mt8195_phy_dig_lane_regs[DP_PHYD_LAN=
_MAX] =3D {
>  	[DP_PHYD_LAN_DRIVING_PARAM_0] =3D 0x2c,
>  };
> =20
> +static const u8 mt8196_phy_dig_lane_regs[DP_PHYD_LAN_MAX] =3D {
> +	[DP_PHYD_LAN_DRIVING_FORCE] =3D 0x30,
> +	[DP_PHYD_LAN_DRIVING_PARAM_0] =3D 0x2c,
> +};

[Severity: High]
Could this regression corrupt the driving force configuration?

In mtk_dp_phy_set_digital_drv_params(), there is a bulk write of 9 contiguo=
us
32-bit registers starting at DP_PHYD_LAN_DRIVING_PARAM_0:

    ret =3D regmap_bulk_write(dp_phy->regmap,
                            pdata->off_dig_lane[i] + reg,
                            pdata->driving_params,
                            ARRAY_SIZE(pdata->driving_params));

Since the bulk write starts at 0x2c, driving_params[1] will be written to 0=
x30,
which overlaps with DP_PHYD_LAN_DRIVING_FORCE.

> +
>  static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] =3D {

[ ... ]

> @@ -751,8 +784,39 @@ static const struct mtk_dp_phy_pdata mt8195_dp_phy_d=
ata =3D {
>  	},
>  };
> =20
> +static const struct mtk_dp_phy_pdata mt8196_edp_phy_data =3D {
> +	.off_ana_glb =3D 0x400,
> +	.off_ana_lane =3D (const u16[]) { 0x0, 0x100, 0x200, 0x300 },
> +	.off_dig_glb =3D 0x1400,
> +	.off_dig_lane =3D (const u16[]) { 0x1000, 0x1100, 0x1200, 0x1300 },
> +	.regs_ana_glb =3D mt8195_phy_ana_glb_regs,
> +	.regs_ana_lane =3D mt8195_phy_ana_lane_regs,
> +	.regs_dig_glb =3D mt8196_phy_dig_glb_regs,

[Severity: High]
This is a pre-existing issue, but do mtk_dp_phy_power_on() and
mtk_dp_phy_power_off() fetch analog register offsets using this digital reg=
ister
array?

Both functions use the analog enum DP_PHYA_GLB_FORCE_CTRL_1 to access the
digital array:

    const u8 *regs =3D pdata->regs_dig_glb;
    ...
    ret =3D regmap_set_bits(dp_phy->regmap,
                          pdata->off_ana_glb + regs[DP_PHYA_GLB_FORCE_CTRL_=
1],
                          CKM_CKTX0_EN_FORCE_MODE);

Accessing index 4 (DP_PHYA_GLB_FORCE_CTRL_1) of the digital array returns
DP_PHYD_AUX_RX_CTL (0x40) instead of the intended analog offset (0x34).

Does this overwrite incorrect memory mapped register offsets?

> +	.regs_dig_lane =3D mt8196_phy_dig_lane_regs,
> +	.mask_dig_tx_ln =3D PHYD_TX_LN_EN_V2,

[Severity: High]
This isn't a bug introduced by this patch, but does the lane disabling logi=
c in
mtk_dp_phy_disable_all_lanes() use this mask incorrectly?

It computes lane_num as a raw index and passes it to field_prep():

    ret =3D regmap_clear_bits(dp_phy->regmap,
                            pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0],
                            field_prep(pdata->mask_dig_tx_ln, lane_num));

Because field_prep() shifts the raw value, passing 3 instead of BIT(3) will
shift 0b11 into the mask, clearing bits 4 and 5 instead of bit 7 (or bits 0=
 and
1 instead of bit 3 for V2).

Should this be using BIT(lane_num) instead?

> +	.val_dig_bitrate =3D mt8196_edp_phy_dig_bitrate_val,
> +	.ana_bias_r =3D 15,
> +	.ana_cktx_imp =3D 8,

[Severity: High]
This isn't a bug introduced by this patch, but are these calibration parame=
ters
unconditionally cleared to zero in the hardware?

In mtk_dp_phy_set_analog_calibration_params(), these values are passed
directly to regmap_update_bits():

    ret =3D regmap_update_bits(dp_phy->regmap,
                             pdata->off_ana_glb + regs_ana_glb[DP_PHYA_GLB_=
BIAS_GEN_0],
                             XTP_GLB_BIAS_INT_R_CTRL, pdata->ana_bias_r);

Because regmap_update_bits() expects a pre-shifted value and applies a mask
(e.g., GENMASK(20, 16)), an unshifted raw value like 15 masked against the =
upper
bits yields 0.

Should a macro like FIELD_PREP() be used to properly shift these values into
place?

> +	.ana_lanes_imp =3D {
> +		.pmos =3D 8,
> +		.nmos =3D 8,
> +	},

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D12
