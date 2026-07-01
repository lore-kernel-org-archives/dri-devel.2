Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E22CC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E8B10EF78;
	Wed,  1 Jul 2026 12:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fHwzDOgx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F71810EF78
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:30:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E875413B8;
 Wed,  1 Jul 2026 12:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65211F000E9;
 Wed,  1 Jul 2026 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909004;
 bh=p/Ltph7WWF2KDaFV2op4D3gJpqRALqGdOM9Gv3W8WeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fHwzDOgxbOKw/V1SMc/+aZnecLypCRVbcTaY3+V03yNMZd90Zk6V7xzEXVo5YIpdV
 y4FfwpeCKFvhFz8+HreE8DMw+CF+fVr9MJB6mqYvVYG0tgIxiVu0ca24S+9LY5hF+x
 1rXYXogTKejG8oVVzugfhAyFz087KSrhGKBWLJRyrk5OPxfiBMGshRADyeIdEVmLlF
 2c59A7XUigU7yYeAm/FTGgCf2fMLQxePzMvMpqovSwckqH+4iMgprZprNNR3GoiYhb
 8N1eErELMv9vr2RVGIbEVmhXM2WkITzhYibFQRum6LxvzRMF3op862J2K9eYcdEjjq
 njzk20pc1Zdgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] phy: phy-mtk-dp: Allow probing with devicetree match
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, vkoul@kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, robh@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701122008.19509-4-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:30:03 +0000
Message-Id: <20260701123003.B65211F000E9@smtp.kernel.org>
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
- [High] The return value of `pm_runtime_get_sync()` is ignored, which can =
lead to hardware register accesses on an unpowered device.
- [Medium] Missing `.remove` callback leaves PM runtime enabled and usage c=
ounter unbalanced on driver unbind.

Pre-existing issues:
- [High] Missing `phy_remove_lookup()` causes a memory leak and a dangling =
pointer in the global PHY lookup list.
- [High] Unconditional dereference of `dev->platform_data` before validatin=
g it.
--

commit e3a3844cc6f977665174375e23735f789c04a772
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Allow probing with devicetree match

This commit introduces a devicetree match table to decouple the DP PHY driv=
er
from the DP IP driver. It adds an OF PHY provider and MMIO regmap registrat=
ion
for the devicetree case, while maintaining a legacy probe path for older
devicetrees without a separate PHY node.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index bf7b3a95e72d2..98e05fe05ce3b 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -160,43 +161,92 @@ static const struct phy_ops mtk_dp_phy_dev_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct =
mtk_dp_phy *dp_phy)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct phy *phy;
> +
> +	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;

[Severity: High]
This is a pre-existing issue, but does this code unconditionally dereference
dev->platform_data before verifying it is not NULL?

If the platform device is instantiated without platform data, would this
dereference cause a kernel panic before the subsequent check for
!dp_phy->regmap can execute?

> +	if (!dp_phy->regmap)
> +		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
> +
> +	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
> +	if (IS_ERR(phy))
> +		return dev_err_probe(dev, PTR_ERR(phy),
> +				     "Failed to create DP PHY\n");
> +
> +	phy_set_drvdata(phy, dp_phy);
> +	phy_create_lookup(phy, "dp", dev_name(dev));

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the lookup
entry and create a dangling pointer?

phy_create_lookup() dynamically allocates a phy_lookup structure and links =
it
into the global phys list. Since there is no driver .remove callback calling
phy_remove_lookup(), when the driver unbinds, the devres-managed phy is fre=
ed
while still in the global list, which could cause a use-after-free when oth=
er
drivers call phy_find().

> +
> +	return 0;
> +}
> +

[ ... ]

>  static int mtk_dp_phy_probe(struct platform_device *pdev)
>  {

[ ... ]

> +	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

[Severity: High]
Is it safe to ignore the return value of pm_runtime_get_sync() here?

If the generic power domain or clock fails to enable, pm_runtime_get_sync()
will return a negative error code. Without checking this, the PHY provider =
is
registered even if the hardware is off, which could lead to a synchronous
external abort when attempting to write to the MMIO registers later.

> =20
>  	return 0;
>  }
> =20
> +static const struct of_device_id mtk_dp_phy_of_match[] =3D {
> +	{ .compatible =3D "mediatek,mt8195-dp-phy" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_dp_phy_of_match);
> +
>  static struct platform_driver mtk_dp_phy_driver =3D {
>  	.probe =3D mtk_dp_phy_probe,
>  	.driver =3D {
>  		.name =3D "mediatek-dp-phy",
> +		.of_match_table =3D mtk_dp_phy_of_match,
>  	},
>  };

[Severity: Medium]
Does this driver need a .remove callback to clean up the PM runtime state?

Since pm_runtime_enable() and pm_runtime_get_sync() are called in probe
without devm_ handlers or registered teardown actions, unbinding the driver
appears to leak the usage counter and leave PM runtime permanently enabled.

>  module_platform_driver(mtk_dp_phy_driver);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D3
