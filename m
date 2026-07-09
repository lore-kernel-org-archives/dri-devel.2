Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC2EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B181110F562;
	Thu,  9 Jul 2026 11:54:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="geltOLLe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B11510F564
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:54:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42ACB419C9;
 Thu,  9 Jul 2026 11:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6951F00A3A;
 Thu,  9 Jul 2026 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783598040;
 bh=OnicRdWhQhC2JojH9qglPzEvljJxd6KKmT2XVb5Md+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=geltOLLeFlW0mh+emHaLfV2LuWPMF8ggZMGUJS8QVABnQ3PqFlg2QiRmWxxwOMiWf
 PjekfWY1Ra+FvJxbCTSyHRJIDevsDfpxqgY5sLBtGMqx/bEHAv+p+V6arElMVsqwH4
 OHPJAkeo+jGzUYWmsvOxk1UpSDyRs5Qj4yYT5AVLOMHTh6VUMUAp8sa13WSKI2O0Ug
 Z3KTdNzyK3slxShslDhaoiftLITnp0jXCiqsl4v4+ge3GX3rj9Wm63S8m+vM9UB5aJ
 gO498s5RB7zm5QiOvPPLTxaKhJfK4yGQK9dGcT7FchcRUKty9cQ5clGu60NvNkJbQZ
 VSKEU2sl/eGaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] drm/mediatek: mtk_dp: Use PHY API for PHY
 power sequences
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260709113148.49090-8-angelogioacchino.delregno@collabora.com>
References: <20260709113148.49090-1-angelogioacchino.delregno@collabora.com>
 <20260709113148.49090-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:53:59 +0000
Message-Id: <20260709115359.CB6951F00A3A@smtp.kernel.org>
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
- [High] The newly added `phy_power_on()` and `phy_power_off()` calls are u=
nreachable dead code, and if reached, would break the display because the P=
HY driver lacks the required callbacks.
- [High] Ignoring the return value of `phy_power_on()` leads to unbalanced =
`phy_power_off()` calls and PM/regulator underflows.
- [High] `phy_power_on()` is called before `phy_init()` in the eDP probe pa=
th, violating the PHY API contract.

Pre-existing issues:
- [High] The driver teardown leaves the hardware interrupt active after del=
eting its associated debounce timer, leading to a Use-After-Free and fatal =
bus errors.
--

--- Patch [7]: [PATCH v4 07/12] drm/mediatek: mtk_dp: Use PHY API for PHY p=
ower sequences ---
commit 4812fc369fed645130f58ff58a959cb198f9b227
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

drm/mediatek: mtk_dp: Use PHY API for PHY power sequences

This commit introduces phy_power_on() and phy_power_off() calls to replace
direct PHY register writes in the mediatek DP driver.

> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index b2e5fa0914bcb..383c8e66b5273 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c

[ ... ]

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

[Severity: High]
Can this else branch ever be reached?

Looking at mtk_dp_probe(), it unconditionally calls mtk_dp_register_phy()
which creates the mediatek-dp-phy platform device and assigns it to
mtk_dp->phy_dev. Because this pointer seems to always be valid, this
condition would always evaluate to true, skipping the new PHY API calls.

Additionally, if this dead code were reached, would the PHY API calls work?

In drivers/phy/mediatek/phy-mtk-dp.c, mtk_dp_phy_dev_ops does not appear to
implement the .power_on and .power_off callbacks.

> +		regmap_write(mtk_dp->regs, DP_PHY_AUX_RX_CTL,
> +			     RG_DPAUX_RX_VALID_DEGLITCH_EN | RG_XTP_GLB_CKDET_EN |
> +			     RG_DPAUX_RX_EN);
> +		regmap_clear_bits(mtk_dp->regs, MTK_DP_0034, DA_CKM_CKTX0_EN_FORCE_EN);
> +	} else {
> +		ret =3D phy_power_on(mtk_dp->phy);

[Severity: High]
Is it safe to call phy_power_on() before phy_init()?

The Linux PHY API requires phy_init() to be called before phy_power_on().

Currently, phy_init() is only called within mtk_dp_poweron() during the
DRM bridge attach phase. However, for eDP panels, mtk_dp_probe() directly
invokes mtk_dp_power_enable() well before the bridge attach phase occurs.

> +		if (ret)
> +			dev_warn(mtk_dp->dev, "Could not power on PHY!\n");

[Severity: High]
Does ignoring the return value of phy_power_on() cause unbalanced power
states?

If phy_power_on() fails due to a regulator error, the generic PHY framework
leaves the power count at zero.=20

Because the failure is only logged and not propagated, the driver proceeds.
During teardown, mtk_dp_power_disable() unconditionally calls phy_power_off=
(),
which could drop the power count below zero and cause regulator usecount
underflows.

> +	}
>  }
> =20
>  static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
>  {

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the driver teardown sequence leave
the hardware interrupt active after deleting its associated debounce timer?

In mtk_dp_remove(), the driver powers down the device via
pm_runtime_put_sync() and deletes the timer using timer_delete_sync().
However, it relies on devm_request_threaded_irq() for interrupt management
without explicitly calling devm_free_irq().

If a threaded IRQ fires in the window after timer_delete_sync(), the
threaded handler mtk_dp_hpd_event_thread() will run and call mod_timer().

This re-arms the deleted timer on memory that is about to be freed, which
might lead to a use-after-free. Additionally, accessing the DP MMIO
registers while the power domain is off could trigger fatal bus errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709113148.4909=
0-1-angelogioacchino.delregno@collabora.com?part=3D7
