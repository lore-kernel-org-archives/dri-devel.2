Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AEAC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD6310E6A2;
	Thu,  9 Jul 2026 10:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IC+rvB6p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB0010E6A2
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 10:51:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DCD2407DB;
 Thu,  9 Jul 2026 10:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140E81F00A3A;
 Thu,  9 Jul 2026 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594291;
 bh=6AV/Bv9CWVyZqKThlG/GXC41B3XIuc7Yvx0wx4dEtok=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IC+rvB6pfNQknxBlYcsASU3fzinOarBApXf9KLccSSyIzR8JdUZkYZKnx/drcdh08
 qrIubAFnIMuk14AeNERlDryW+YhDUSUXmqE7BD+1DjwXkju1WUrfmVhw9Z3FI2xVAC
 6VclaFwGVOkgGDvbN3AKIwaGjv/+ySg9MvfG2ilEIU+iea5Xa9w2QkPypIUELyNBwO
 Etni97gCjAyHFFVxNJ1MIZvi2LvAK5z5RnnaKhMDPm/vOJbykrlmsRg91IW/j7R6Kp
 Dyf+Ya9yHOyOFnYMLmS2YNzYZM2jTbrk2fQP+PmkaLPR6GiqjWZhyIigD+2ZLRdg/5
 3F7I5UYV5kaew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/11] drm/mediatek: mtk_dp: Add support for eDP1.5
 IPs and MT8196 SoC
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709103431.46616-11-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:51:30 +0000
Message-Id: <20260709105131.140E81F00A3A@smtp.kernel.org>
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

New issues:
- [High] PHY bias power is incorrectly forced ON instead of OFF during the =
bridge atomic disable sequence.
- [High] Zero-width reset pulse and failure to clear PHY reset state for th=
e eDP 1.5 IP.
- [Medium] Uninitialized calibration data is unconditionally flushed to PHY=
 registers when MT8196 uses the legacy PHY configuration.

Pre-existing issues:
- [High] Double free / use-after-free of the PHY platform device on probe e=
rror path.
- [High] Use-after-free in debounce timer teardown due to failure to disabl=
e threaded IRQ.
--

--- Patch [10]: [PATCH v3 10/11] drm/mediatek: mtk_dp: Add support for eDP1=
.5 IPs and MT8196 SoC ---
commit f310ca07bbff89c8e8b27b5c8d3a9c8cfc72e839
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: drm/mediatek: mtk_dp: Add support for eDP1.5 IPs and MT8196 SoC

This commit adds support for MediaTek's Embedded DisplayPort (eDP) v1.5 IP,=
=20
found in the MT8196 SoC. It introduces conditional register writes based on=
=20
platform data booleans to handle SDP encoders, PSR support, and power state=
=20
forcing differences between IP revisions. It also partially prepares for DP=
=20
1.4 IP support on the same SoC.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index fb216811c80c7..868d918a0b161 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
[ ... ]
> @@ -1210,24 +1315,87 @@ static void mtk_dp_initialize_aux_settings(struct=
 mtk_dp *mtk_dp)
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
> +	}
> +
>  	/* Wait for sw reset to complete */
>  	usleep_range(1000, 5000);
> -	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
> -			   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
> +
> +	if (!mtk_dp->data->hwip_v1p4)
> +		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
> +				   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
> +}

[Severity: High]
For the eDP 1.5 IP (hwip_v1p4), does asserting
DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0 to 1 and immediately deasserting it to=
 0
create a zero-width pulse that the hardware might ignore?

Furthermore, ENC_PHY_STATE_RESET_ALL_MASK is asserted but never explicitly
cleared after the delay. Will this leave the PHY permanently in reset unless
the register is self-clearing?

[ ... ]
> @@ -1359,8 +1550,10 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk=
_dp,
>  		}
>  	};
> =20
> -	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE, DP_PWR_STATE_BANDGAP,
> -			   DP_PWR_STATE_MASK);
> +	/* Set power state requests only if power states are not forced */
> +	if (!mtk_dp->data->force_pwr_states)
> +		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE, DP_PWR_STATE_BANDGAP,
> +				   DP_PWR_STATE_MASK);
> =20
>  	ret =3D phy_configure(mtk_dp->phy, &phy_opts);
>  	if (ret)
> @@ -1373,6 +1566,11 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk=
_dp,
>  	if (mtk_dp->phy_dev)
>  		mtk_dp_set_calibration_data(mtk_dp);

[Severity: Medium]
If MT8196 is used with a device tree lacking the separate phys node, it will
fall back to the legacy architecture and create mtk_dp->phy_dev.

Since mt8196_edp_data does not provide an efuse_fmt,
mtk_dp_get_calibration_data() is skipped, leaving the cal_data array zeroed.

Later in mtk_dp_phy_configure(), the code unconditionally calls
mtk_dp_set_calibration_data() if mtk_dp->phy_dev exists.

Will this flush uninitialized or zeroed cal_data directly into the PHY
registers and misconfigure the hardware?

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
Is it intentional to force the PHY bias power ON during the bridge disable
sequence?

The disable path usually turns hardware off to save power (as done in
mtk_dp_power_disable() which calls mtk_dp_encoder_force_bias_power_off()).

Does this cause a power leak or keep the PHY in an incorrect state during
teardown?

>  	/* Ensure the sink is muted */
>  	msleep(20);
>  }
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
>  		platform_device_unregister(mtk_dp->phy_dev);
>  		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy), "Failed to get phy\n");
>  	}

[Severity: High]
This is a pre-existing issue, but if devm_phy_get() fails here, the explicit
error handling path calls platform_device_unregister(mtk_dp->phy_dev) before
returning.

Since mtk_dp_unregister_pdevs was registered as a devm action just prior to
this, returning an error will trigger the devres core to unwind the stack a=
nd
call platform_device_unregister() a second time on the same device pointer.

Can this cause a double-free or use-after-free crash?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issu=
e in
mtk_dp_remove() regarding the debounce timer teardown.

The HPD interrupt is registered during probe using devm_request_threaded_ir=
q(),
meaning its lifetime spans until after mtk_dp_remove() returns.

Inside mtk_dp_remove(), the code calls timer_delete_sync(&mtk_dp->debounce_=
timer)
but does not disable the IRQ:

static void mtk_dp_remove(struct platform_device *pdev)
{
    ...
    if (mtk_dp->data->bridge_type !=3D DRM_MODE_CONNECTOR_eDP)
        timer_delete_sync(&mtk_dp->debounce_timer);
    ...
}

Because the IRQ is still active, an incoming hardware interrupt can immedia=
tely
fire the mtk_dp_hpd_event_thread() handler, which can re-arm the timer using
mod_timer(). Once the mtk_dp object is subsequently freed by devres, the ti=
mer
expires and accesses freed memory.

Could this lead to a use-after-free on driver unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D10
