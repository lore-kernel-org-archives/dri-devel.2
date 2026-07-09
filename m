Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB20AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337B610E063;
	Thu,  9 Jul 2026 11:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KErqG7Yh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F381910E063
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:49:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60115600C3;
 Thu,  9 Jul 2026 11:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B581F000E9;
 Thu,  9 Jul 2026 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597789;
 bh=JRWsN1cOaRFKbjPMmYa9IPfjPyISyWDka+JsJJ2JcJQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KErqG7Yhcg1WtLOO9LubZyhrOMokDlYgBtFXURmrGZOPZJm7N+YI5UVP7JzqtgrDE
 QiHaPL2r7SO48RJcL1VWmvMjRp/41xwnWcLiPEsYF7jjBIxOJOKeknvkiA+u2GpOO0
 wpztCFE1OzlRpRSkfgYmkaxx44JlImaerS1Va44GCmnJv3ELQhcBEsdJ0qviD5kWHd
 CfYHewfyDPHMPipNO7ZfujWRoar1Uc+b/j3b4JSIJ2OUpSPYp0mq3b+FRixnuGSyFV
 KHtLoL94+lvbUsRthUzFnCQm5DcO0NYBO374Z86hod3iy5fyPxwfU6OgRDm+aMoeX+
 4TA3GDca/fJgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] drm/mediatek: mtk_dp: Add support for eDP1.5
 IPs and MT8196 SoC
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709100617.42583-11-angelogioacchino.delregno@collabora.com>
References: <20260709100617.42583-1-angelogioacchino.delregno@collabora.com>
 <20260709100617.42583-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:49:48 +0000
Message-Id: <20260709114948.C6B581F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The patch introduces a forbidden sleeping function (`msleep`) insi=
de atomic commit paths.
- [High] `mtk_dp_bridge_atomic_disable()` incorrectly forces the encoder bi=
as power ON rather than OFF, likely due to a copy-paste error.
- [High] Conflicting register programming in `mtk_dp_encoder_reset` overwri=
tes PHY enable bits and potentially leaves the PHY in permanent reset.
- [High] Double unregister of the PHY platform device (`mtk_dp->phy_dev`) o=
n the error path.
- [High] `mtk_dp_setup_encoder` constructs an update mask using raw bit val=
ues instead of proper field masks, failing to clear bits in multi-bit field=
s.
--

--- Patch [10]: [PATCH v2 10/11] drm/mediatek: mtk_dp: Add support for eDP1=
.5 IPs and MT8196 SoC ---
commit a9e93bd64557c3ad0ae0387b6e0c8b87e41baeda
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dp: Add support for eDP1.5 IPs and MT8196 SoC

This patch adds support for MediaTek's Embedded DisplayPort (eDP) v1.5 IP
found in the MT8196 SoC and other variants. It introduces conditional
hardware initialization sequences, platform data switches for newer feature=
s,
and includes partial support paths for the DisplayPort 1.4 IP on the same S=
oC.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index fb216811c80c7..868d918a0b161 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -648,7 +669,18 @@ static void mtk_dp_setup_encoder(struct mtk_dp *mtk_=
dp)
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3364,
>  			   FIFO_READ_START_POINT_DP_ENC1_P0_VAL << 12,
>  			   FIFO_READ_START_POINT_DP_ENC1_P0_MASK);
> -	mtk_dp_write(mtk_dp, MTK_DP_ENC1_P0_3368, DP_ENC1_P0_3368_VAL);
> +
> +	mask =3D VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0 | VIDEO_STABLE_CNT_TH=
RD_DP_ENC1_P0;
> +	mask |=3D BS2BS_MODE_DP_ENC1_P0;
> +
> +	val =3D mask;
> +
> +	mask |=3D SDP_DP13_EN_DP_ENC1_P0;
> +
> +	if (mtk_dp->data->sdp_encoder1_enable)
> +		val |=3D SDP_DP13_EN_DP_ENC1_P0;
> +
> +	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3368, val, mask);

[Severity: High]
Does this code construct the update mask using single-bit values rather than
multi-bit field masks?

The previous code wrote directly to the register, but the update here seems
to use bit values (like BS2BS_MODE_DP_ENC1_P0) as the mask itself.=20
Since BS2BS_MODE_DP_ENC1_P0 is just one bit but the field might be larger,
will this leave uncleared bits in the multi-bit fields like
VIDEO_SRAM_FIFO_CNT_RESET_SEL_MASK and BS2BS_MODE_DP_ENC1_P0_MASK?

[ ... ]
> @@ -1116,6 +1148,72 @@ static void mtk_dp_hwirq_enable(struct mtk_dp *mtk=
_dp, bool enable)
>  			   IRQ_MASK_DP_TRANS_P0_MASK);
>  }
> =20
> +static void mtk_dp_encoder_force_bias_power_on(struct mtk_dp *mtk_dp)
> +{
> +	/* Force MCU to enable BIAS */
> +	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
> +			   ENC_PHY_PWR_OVERWRITE_EN, ENC_PHY_PWR_OVERWRITE_EN);
> +	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
> +			   FIELD_PREP_CONST(ENC_PHY_PWR_STATE_OVERWRITE_MASK,
> +					    ENC_PHY_BIAS_PWR_ON),
> +			   ENC_PHY_PWR_STATE_OVERWRITE_MASK);
> +
> +	/* Wait for the MCU to get LDO ready in PHYD */
> +	msleep(50);

[Severity: High]
Can this sleep in an atomic context?

This function is called by mtk_dp_set_lanes() during display enabling, and
by mtk_dp_bridge_atomic_disable(), both of which are executed in atomic
commit paths where sleeping functions are forbidden. Could this msleep(50)
cause kernel warnings or deadlocks during non-blocking commits?

> +
> +	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
> +			   0, ENC_PHY_PWR_OVERWRITE_EN);
> +}
[ ... ]
> +static void mtk_dp_encoder_reset(struct mtk_dp *mtk_dp)
> +{
>  	/* dp tx encoder reset all sw */
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
>  			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0,
>  			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
> =20
> +	if (mtk_dp->data->hwip_v1p4) {
> +		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004, 0,
> +				   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
> +		mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
> +				   ENC_PHY_STATE_RESET_ALL_MASK,
> +				   ENC_PHY_STATE_RESET_ALL_MASK);

[Severity: High]
Does this write to ENC_PHY_STATE_RESET_ALL_MASK permanently hold the PHY in
reset and overwrite unrelated fields?

Looking at the definition of ENC_PHY_STATE_RESET_ALL_MASK, it is
GENMASK(7, 0). Writing 1s to this entire mask overwrites the enable bits
DP_ENCODER_DVO_ON_W_1 and PHY_STATE_W_1_DP_ENC_P0_3 (bits 5 and 6) that were
just configured. Since the reset is never cleared, will the PHY remain stuck
in this reset state?

> +	}
[ ... ]
> @@ -2580,6 +2795,9 @@ static void mtk_dp_bridge_atomic_disable(struct drm=
_bridge *bridge,
>  	/* SDP path reset sw*/
>  	mtk_dp_sdp_path_reset(mtk_dp);
> =20
> +	if (mtk_dp->data->force_pwr_states)
> +		mtk_dp_encoder_force_bias_power_on(mtk_dp);
> +

[Severity: High]
Is mtk_dp_encoder_force_bias_power_on() the correct function to call during
the disable path?

This turns the encoder bias power ON during bridge disable. Given that
mtk_dp_power_disable() correctly calls mtk_dp_encoder_force_bias_power_off(=
),
should this be calling the power_off function instead to properly power down
the display path?

>  	/* Ensure the sink is muted */
>  	msleep(20);
>  }
[ ... ]
> @@ -2860,7 +3078,8 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_d=
p)
>  				     "Failed to add phy unregister devm action");
> =20
>  	/* PHY calibration data is in mtk_dp only for legacy devicetree */
> -	mtk_dp_get_calibration_data(mtk_dp);
> +	if (mtk_dp->data->efuse_fmt)
> +		mtk_dp_get_calibration_data(mtk_dp);
> =20
>  	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
>  	if (IS_ERR(mtk_dp->phy)) {

[Severity: High]
Could the error path for devm_phy_get cause a double free of the PHY device?

The patch registers a devm action earlier in this function:

    ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs,
                                   mtk_dp->phy_dev);

However, the existing error path for devm_phy_get manually unregisters the
device:

    if (IS_ERR(mtk_dp->phy)) {
        platform_device_unregister(mtk_dp->phy_dev);
        return dev_err_probe(...);
    }

Since returning an error will trigger the devres cleanup (and run
mtk_dp_unregister_pdevs), will this result in platform_device_unregister()
being called a second time on the same pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709100617.4258=
3-1-angelogioacchino.delregno@collabora.com?part=3D10
