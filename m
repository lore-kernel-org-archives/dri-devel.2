Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3927DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9198310E69B;
	Thu,  9 Jul 2026 11:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jb7a5A+e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204F410E69D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:00:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C97DB437F5;
 Thu,  9 Jul 2026 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E531F00A3D;
 Thu,  9 Jul 2026 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783594824;
 bh=l3AJhtJf5IIFGGz4akr9/ySUdr3gXIyyR9Me8CXFqNw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jb7a5A+eAUlMxx40fbfYQY6riO00CyPDRaaWOKS9XnkbCqoFPTVedRnp3CMsXeV33
 u8nNJD9W3cWx0Me/juZWYQb1WUBR+6Lwrv/0tLpvFj26Mn5Yj83jb0v278Q62tgQMo
 nCIldeeCCbCmsyp0ScrNVikJLy8q+Sg46TnT0NY8MYs6JgfZB2Srml8VXrScCW4Tqs
 wQK9g0xNyOY1MZnVUPmmmLV+kV1gaoTN3cnwKlRrwX6xKZ7l24nQd/rZ7IDwcBgCZ7
 ryv0D+ClyLYQvUSkdBNRU46FjhkwC3n2vAMb4gt7TwRFJaa+ftmbYz7ShBhv7RJv55
 oN3nUYM2JzFmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] drm/mediatek: mtk_dp: Use PHY API for PHY
 power sequences
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260709103431.46616-7-angelogioacchino.delregno@collabora.com>
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:00:24 +0000
Message-Id: <20260709110024.69E531F00A3D@smtp.kernel.org>
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
- [High] Double unregistration of the `mtk_dp->phy_dev` platform device on =
the `devm_phy_get()` error path causes a use-after-free.
- [Medium] The newly added `phy_power_on()`/`phy_power_off()` calls are dea=
d code, and if reachable, they would violate the PHY API contract and leak =
reference counts.
--

--- Patch [6]: [PATCH v3 06/11] drm/mediatek: mtk_dp: Use PHY API for PHY p=
ower sequences ---
commit e6bfbadbdfc23b97fa303c95119a421df2604e0a
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Use PHY API for PHY power sequences

The PHY driver has gained support for .power_on() and .power_off()
callbacks: use the API provided phy_power_on(), phy_power_off()
functions instead of writing into PHY registers from this driver.

I noticed an issue in mtk_dp_register_phy() from patch 4 of this series:

drivers/gpu/drm/mediatek/mtk_dp.c:mtk_dp_register_phy() {
    ...
	ret =3D devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs, mtk_dp->phy=
_dev);
	if (ret)
		return dev_err_probe(dev, ret,
				     "Failed to add phy unregister devm action");
    ...
	mtk_dp->phy =3D devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
	if (IS_ERR(mtk_dp->phy)) {
		platform_device_unregister(mtk_dp->phy_dev);
		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy), "Failed to get phy\n");
	}
    ...
}

[Severity: High]
Does this explicit unregister conflict with the devm action registered earl=
ier?

If devm_phy_get() fails, platform_device_unregister() is called on
mtk_dp->phy_dev, and then an error is returned. Returning an error triggers
the devres cleanup, which executes the registered devm action and calls
platform_device_unregister() on the exact same pointer a second time, causi=
ng
a double-free and use-after-free.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 409d089550a90..b4cb1996a3314 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1414,20 +1416,35 @@ static void mtk_dp_power_enable(struct mtk_dp *mt=
k_dp)
>  			   SW_RST_B_PHYD, SW_RST_B_PHYD);
>  	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
>  			   DP_PWR_STATE_BANDGAP_TPLL, DP_PWR_STATE_MASK);
> -	regmap_write(mtk_dp->regs, DP_PHY_AUX_RX_CTL,
> -		     RG_DPAUX_RX_VALID_DEGLITCH_EN | RG_XTP_GLB_CKDET_EN |
> -		     RG_DPAUX_RX_EN);
> -	regmap_clear_bits(mtk_dp->regs, MTK_DP_0034, DA_CKM_CKTX0_EN_FORCE_EN);
> +
> +	if (mtk_dp->phy_dev) {

[Severity: Medium]
The commit message claims this patch replaces manual PHY register writes wi=
th
phy_power_on() and phy_power_off(). However, these API calls are placed in
the else branch of if (mtk_dp->phy_dev).

Because mtk_dp_register_phy() unconditionally registers the dummy platform
device unless it fails (which would abort the probe), mtk_dp->phy_dev is
always a valid pointer.

This makes the if-condition always true, so the new phy_power_on() and
phy_power_off() API calls are never reached, and the legacy manual writes
continue to execute. Are these new calls unreachable dead code?

Additionally, if this code were reachable (for example, for a future
DT-provided PHY), does phy_power_on() get called during eDP probe before
phy_init() is called, violating the PHY API contract?=20

And if phy_power_on() fails, the failure is warned but not propagated, leav=
ing
the PHY power count un-incremented. This could cause a subsequent
phy_power_off() to underflow the reference count.

> +		regmap_write(mtk_dp->regs, DP_PHY_AUX_RX_CTL,
> +			     RG_DPAUX_RX_VALID_DEGLITCH_EN | RG_XTP_GLB_CKDET_EN |
> +			     RG_DPAUX_RX_EN);
> +		regmap_clear_bits(mtk_dp->regs, MTK_DP_0034, DA_CKM_CKTX0_EN_FORCE_EN);
> +	} else {
> +		ret =3D phy_power_on(mtk_dp->phy);
> +		if (ret)
> +			dev_warn(mtk_dp->dev, "Could not power on PHY!\n");
> +	}
>  }
> =20
>  static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
>  {
> +	int ret;
> +
>  	mtk_dp_write(mtk_dp, MTK_DP_TOP_PWR_STATE, 0);
> =20
> -	regmap_set_bits(mtk_dp->regs, MTK_DP_0034, DA_CKM_CKTX0_EN_FORCE_EN);
> +	if (unlikely(mtk_dp->phy_dev)) {
> +		regmap_set_bits(mtk_dp->regs, MTK_DP_0034, DA_CKM_CKTX0_EN_FORCE_EN);
> =20
> -	/* Disable RX */
> -	regmap_write(mtk_dp->regs, DP_PHY_AUX_RX_CTL, 0);
> +		/* Disable RX */
> +		regmap_write(mtk_dp->regs, DP_PHY_AUX_RX_CTL, 0);
> +	} else {
> +		ret =3D phy_power_off(mtk_dp->phy);
> +		if (ret)
> +			dev_warn(mtk_dp->dev, "Could not power off PHY!\n");
> +	}
> =20
>  	mtk_dp_write(mtk_dp, MTK_DP_TOP_MEM_PD,
>  		     0x550 | FUSE_SEL | MEM_ISO_EN);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709103431.4661=
6-1-angelogioacchino.delregno@collabora.com?part=3D6
