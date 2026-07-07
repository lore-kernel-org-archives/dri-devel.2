Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44665C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ED510ED92;
	Tue,  7 Jul 2026 14:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ofSHB/xG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 902F310ED92
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:31:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45A9841128;
 Tue,  7 Jul 2026 14:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC76D1F000E9;
 Tue,  7 Jul 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434708;
 bh=UTzP3gor4dFCMU5pkveJq/KGXMait3zUs+q1bohN9bY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ofSHB/xGOKCHFOR+9Wd78qQhTsbKDZDssxAZTBGlXnKgTzX7BhDOtaisof5ONulNX
 /JlnkC4IGWMQD28KfhNZbU5pHmeV6w4DlA+ca4F8Thd6Y5MtCcV7nk5wYSaeMCMql3
 a6feKMNV+X3r9L6vd55NwRN22N0IiwggUiJKnrjR/M2aZZYqg6ihkwokhwBjbZeFyM
 eOQfMLYunt4nKJIQvmYgKBK+jEjN5eAk3CxbuWwmKsqE7W3ENhS/eIGtrgMfHnq4rR
 NBCWTlPzecwBXEl03cK0LIPiKAR5zEQBlLDX/VZdyGMhc2ni2+XmJkYoeDezCaJa/X
 MhAklJLg8U7Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] phy: phy-mtk-dp: Allow probing with devicetree
 match
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260707141931.191172-4-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:31:47 +0000
Message-Id: <20260707143147.AC76D1F000E9@smtp.kernel.org>
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
- [High] PM Runtime on the parent device is enabled after the PHY device is=
 created, preventing PM runtime from propagating to the parent and causing =
unpowered hardware accesses.
- [Medium] The DP PHY driver fails to parse and apply the `nvmem-cells` cal=
ibration data specified in the new device tree binding.
- [Low] The variable `ret` is used but not declared in `mtk_dp_phy_probe()`=
, causing a build failure.
--

--- Patch [3]: [PATCH v2 03/12] phy: phy-mtk-dp: Allow probing with devicet=
ree match ---
commit e7cb0174c7cb05364cf12874f491ce4c799f2c61
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Allow probing with devicetree match

This commit adds a devicetree match to decouple the MediaTek DP PHY driver
from the DisplayPort IP driver. It implements a standalone probe path while
retaining a legacy probe function for backwards compatibility.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -160,43 +161,106 @@ static const struct phy_ops mtk_dp_phy_dev_ops =3D=
 {

[ ... ]

>  static int mtk_dp_phy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> +	struct phy_provider *provider;
>  	struct mtk_dp_phy *dp_phy;
> +	void __iomem *base;
>  	struct phy *phy;
> -	struct regmap *regs;
> -
> -	regs =3D *(struct regmap **)dev->platform_data;
> -	if (!regs)
> -		return dev_err_probe(dev, -EINVAL,
> -				     "No data passed, requires struct regmap**\n");
> =20
>  	dp_phy =3D devm_kzalloc(dev, sizeof(*dp_phy), GFP_KERNEL);
>  	if (!dp_phy)
>  		return -ENOMEM;
> =20
> -	dp_phy->regmap =3D regs;
> +	dp_phy->dev =3D dev;
> +
> +	/* If there's no devicetree, go for legacy pdev probe */
> +	if (!dev->of_node)
> +		return mtk_dp_phy_legacy_probe(pdev, dp_phy);

[Severity: Medium]
Does the new devicetree probe path need to parse and apply the nvmem-cells
calibration data?

It looks like the new DT bindings specify nvmem-cells for optimal EYE signal
pattern calibration, but the standalone probe path doesn't retrieve them,
which might leave the hardware running with sub-optimal defaults.

> +
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	dp_phy->regmap =3D devm_regmap_init_mmio(dev, base, &mtk_dp_phy_regmap_=
cfg);
> +	if (IS_ERR(dp_phy->regmap))
> +		return PTR_ERR(dp_phy->regmap);
> +
>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);

[Severity: High]
Will creating the PHY device before enabling PM runtime on the parent
prevent the PHY framework from propagating PM runtime to the child PHY
device?

In phy_create(), the framework checks pm_runtime_enabled(dev) on the parent
to decide whether to enable PM runtime on the newly created PHY device. Sin=
ce
devm_pm_runtime_enable(dev) is called later, this check evaluates to false.

Could this lead to phy_pm_runtime_get_sync() returning -ENOTSUPP and
bypassing hardware wake-ups, resulting in unpowered register accesses?

>  	if (IS_ERR(phy))
>  		return dev_err_probe(dev, PTR_ERR(phy),
>  				     "Failed to create DP PHY\n");
> =20
>  	phy_set_drvdata(phy, dp_phy);
> -	if (!dev->of_node)
> -		phy_create_lookup(phy, "dp", dev_name(dev));
> +
> +	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

[Severity: Low]
Is the variable ret missing a declaration here?

It appears int ret; is not declared in mtk_dp_phy_probe(), which will cause
a build failure when compiling the driver.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D3
