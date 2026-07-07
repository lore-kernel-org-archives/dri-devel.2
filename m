Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE7C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0C3310EE3A;
	Tue,  7 Jul 2026 15:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IaZLIMt2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C435E10EE3A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2901660018;
 Tue,  7 Jul 2026 15:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F32C1F000E9;
 Tue,  7 Jul 2026 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439790;
 bh=iToRQzCJGSGpsmCohncrGDPeqAQ4KQkL7v0RF5YxGpc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IaZLIMt27zZmthz7SceG/bsBUBl2NU85M5H05xIwvwE/3exbnUeU6wgPsSKwhxC4U
 IWsc6o5i4DrxhbK3IFAbAv1TMRk5RLzKiMZki92zmIn5UjJ6An1nP0UW32jYtwiPI/
 x2UpG9qGVqELU09Ls7o9a0mBA9yacVOoIL152zDbgXNpxcaWvYV9YZ/SkkryBcj6Cb
 DK+fAOyg6ntexhCETwFocpfu9+3Rv//n09kf7f9BqxbQBvVDsuI9zix7gArYo85Zt4
 iiw3M84Kb4Lsv+AB31GxegOoT9NC/S6oXobi401KOFttM584/qlWadxKBaxxTe/IoB
 EoEL0RFOw8uYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/12] phy: phy-mtk-dp: Migrate register offsets to
 SoC specific pdata
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org, robh@kernel.org, devicetree@vger.kernel.org,
 vkoul@kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260707154245.198361-5-angelogioacchino.delregno@collabora.com>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:56:29 +0000
Message-Id: <20260707155630.4F32C1F000E9@smtp.kernel.org>
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
- [High] Register accesses are performed in `mtk_dp_phy_configure()` while =
the device's PM runtime state is suspended, risking system hangs.
- [Medium] Missing validation of `device_get_match_data()` return value can=
 lead to a NULL pointer dereference.
- [Low] Invalid compound literal initialization for the 'off_dig_lane' arra=
y member causes a compilation error.

Pre-existing issues:
- [High] The legacy probe path unconditionally dereferences `dev->platform_=
data` before validating that it is not NULL.
--

--- Patch [4]: [PATCH v3 04/12] phy: phy-mtk-dp: Migrate register offsets t=
o SoC specific pdata ---
commit c49d221e57bf6a9816b6ce4e691a20564bc66896
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata

In preparation for adding support for newer SoCs and for adding
more capabilities to this driver in an efficient manner, migrate
all of the hardcoded register offsets to SoC specific pdata and
assign that for both DT and platform probing.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index d241004e28286..20974650d9409 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -111,9 +173,12 @@ static int mtk_dp_phy_init(struct phy *phy)
>  static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opt=
s *opts)
>  {
>  	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
>  	u32 val;
> =20
>  	if (opts->dp.set_rate) {
> +		const u32 reg_bit_rate =3D pdata->regs_dig_glb[DP_PHYD_BIT_RATE];
> +

[ ... ]

> -		regmap_write(dp_phy->regmap, MTK_DP_PHY_DIG_BIT_RATE, val);
> +		regmap_write(dp_phy->regmap, pdata->off_dig_glb + reg_bit_rate, val);
>  	}
> =20
> -	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_PLL_CTL_1,
> +	regmap_update_bits(dp_phy->regmap,
> +			   pdata->off_dig_glb + pdata->regs_dig_glb[DP_PHYD_PLL_CTL_1],
>  			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);

[Severity: High]
Since phy_configure() is not wrapped by phy_pm_runtime_get_sync() in the
PHY core, and the consumer driver may not call phy_power_on() before this
point, the PHY PM runtime usage counter might remain 0 during
mtk_dp_phy_configure().

If the PHY power domain is turned off, will these unclocked regmap_write()
and regmap_update_bits() calls cause the system to hang?

Should there be PM runtime protection around these register accesses?

> =20
>  	return 0;
>  }

[ ... ]

> @@ -170,12 +241,19 @@ static void mtk_dp_phy_legacy_remove_lookup(void *d=
ata)
>  	phy_remove_lookup(phy, "dp", dev_name(dp_phy->dev));
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data;
> +
>  static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct =
mtk_dp_phy *dp_phy)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct phy *phy;
>  	int ret;
> =20
> +	/*
> +	 * If legacy platform driver probe, assume this is MT8195 or compatible
> +	 * with a devicetree that was not migrated to the new, proper bindings.
> +	 */
> +	dp_phy->pdata =3D &mt8195_dp_phy_data;
>  	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;

[Severity: High]
This is a pre-existing issue, but dev->platform_data is unconditionally
dereferenced here before it is checked for NULL.

If this legacy probe path is triggered without platform_data provided (for
example, via the sysfs new_device interface), won't this cause an immediate
NULL pointer dereference?

>  	if (!dp_phy->regmap)
>  		return dev_err_probe(dev, -EINVAL, "No platform data available\n");

[ ... ]

> @@ -235,6 +313,8 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		return ret;
> =20
> +	dp_phy->pdata =3D device_get_match_data(dev);
> +

[Severity: Medium]
If a user binds the mediatek-dp-phy driver via sysfs to a platform device
that doesn't match the driver's compatible strings, device_get_match_data()
will return NULL.

Does this need a NULL check before storing it in dp_phy->pdata?

Without validation, subsequent PHY operations like mtk_dp_phy_init() will
dereference the NULL pointer and crash.

>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
>  	if (IS_ERR(phy))
>  		return dev_err_probe(dev, PTR_ERR(phy),

[ ... ]

> @@ -249,8 +329,15 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data =3D {
> +	.off_dig_glb =3D 0x1000,
> +	.off_dig_lane =3D (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },

[Severity: Low]
Is this compound literal initialization valid for an array struct member?

Compiling this with GCC or Clang may throw an invalid initializer error
because C99 requires array members to be initialized directly with
brace-enclosed lists rather than compound literal expressions.

> +	.regs_dig_glb =3D mt8195_phy_dig_glb_regs,
> +	.regs_dig_lane =3D mt8195_phy_dig_lane_regs,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707154245.1983=
61-1-angelogioacchino.delregno@collabora.com?part=3D4
