Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97116C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA3E10EF84;
	Wed,  1 Jul 2026 12:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Td8ZAtgs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A0F10EF84
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:36:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1680C40BF7;
 Wed,  1 Jul 2026 12:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A71F000E9;
 Wed,  1 Jul 2026 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782909406;
 bh=C1+20SB3grYbbLQ4hKEaqQJTlwwxHdQUc0LGvzYz11k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Td8ZAtgsLCmlbpLm4pVtiur9FeHkTmvl0ANVtHBBG/129J6sK/ABeK/Fm/mH8k9I/
 Pza0aYQHde7eB0Ag07QB5T2+lqrW407pQ5J/MNzhkpgHI6v3iBXSS3vg4iiOkr5ooP
 c78i6KjwPpwwuB+06zGgPPYTA/7UaQMj9ra9U15ABVk9Uza2WVGdZu6HhZFBZFNThj
 CFU9csh7UgNo0Y7xfHU1wEwZiKMNU6ANy8Y93NCScS23LkSynW62DPFJpX1vh6tZte
 sJ1Wtd7uY/62EGDPIGhmHSP8ICJbWqWZbpm2PGFx/znEZ/4Qf4scHIs+fJ57IOJC5+
 CMcCJA5y4Yp/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] phy: phy-mtk-dp: Migrate register offsets to SoC
 specific pdata
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 conor+dt@kernel.org, vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, devicetree@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260701122008.19509-5-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:36:45 +0000
Message-Id: <20260701123645.717A71F000E9@smtp.kernel.org>
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
- [High] Missing NULL pointer check for `device_get_match_data()` return va=
lue leads to kernel panic.
- [Low] Build failure due to invalid initialization of an array field with =
a compound literal.

Pre-existing issues:
- [High] Missing driver `.remove` callback leads to unbalanced runtime PM u=
sage counter and resource leak.
- [High] Dangling `phy_lookup` entry in the global list causes a Use-After-=
Free upon driver unbind.
- [High] Unconditional dereference of `dev->platform_data` before validatin=
g it for NULL.
--

commit 2a851e9d237369ac4340bdce02183defb68c9865
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata

This patch migrates the hardcoded register offsets in the MediaTek DP PHY d=
river
to SoC-specific platform data. It assigns this platform data for both Devic=
eTree
and platform probing. It also loops through lanes to clean up the writing of
driving parameters.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 98e05fe05ce3b..ce33f6812bae6 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -161,11 +225,18 @@ static const struct phy_ops mtk_dp_phy_dev_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data;
> +
>  static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct =
mtk_dp_phy *dp_phy)
>  {
>  	struct device *dev =3D &pdev->dev;
>  	struct phy *phy;
> =20
> +	/*
> +	 * If legacy platform driver probe, assume this is MT8195 or compatible
> +	 * with a devicetree that was not migrated to the new, proper bindings.
> +	 */
> +	dp_phy->pdata =3D &mt8195_dp_phy_data;
>  	dp_phy->regmap =3D *(struct regmap **)dev->platform_data;

[Severity: High]
This is a pre-existing issue, but does this code unconditionally dereference
dev->platform_data before checking if it is NULL?

If the platform device is probed through the legacy path without an of_node=
 and
without platform_data provided (which can happen by manually binding an
arbitrary compatible device via sysfs), could this lead to a kernel panic?

>  	if (!dp_phy->regmap)
>  		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
[ ... ]
> @@ -214,6 +285,8 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(dp_phy->regmap))
>  		return PTR_ERR(dp_phy->regmap);
> =20
> +	dp_phy->pdata =3D device_get_match_data(dev);
> +

[Severity: High]
Can device_get_match_data() return NULL here?

If a user with privileges to write to sysfs binds the device manually using
/sys/bus/platform/drivers/.../bind, or the device is instantiated via platf=
orm
name matching while having an of_node, device_get_match_data() will return
NULL.

Could this lead to a NULL pointer dereference resulting in a kernel panic w=
hen
dp_phy->pdata is accessed later?

>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
>  	if (IS_ERR(phy))
>  		return dev_err_probe(dev, PTR_ERR(phy),
[ ... ]
> @@ -231,8 +304,15 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data =3D {
> +	.off_dig_glb =3D 0x1000,
> +	.off_dig_lane =3D (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },

[Severity: Low]
Will this fail to compile under standard C compilers?

The off_dig_lane field is declared as an array
u16 off_dig_lane[MTK_DP_PHY_MAX_LANES], but it is being initialized using a
pointer from a compound literal cast (const u16[]) { ... }.

Assigning an explicitly cast compound literal to an array field is
syntactically invalid and could prevent the driver from building.

> +	.regs_dig_glb =3D mt8195_phy_dig_glb_regs,
> +	.regs_dig_lane =3D mt8195_phy_dig_lane_regs,
> +};

[Severity: High]
This is a pre-existing issue, but does the mtk_dp_phy_driver missing a .rem=
ove
callback lead to unbalanced runtime PM usage?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
    pm_runtime_enable(dev);
    pm_runtime_get_sync(dev);

    return 0;
}

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_driver {
    .probe =3D mtk_dp_phy_probe,
    .driver =3D {
        .name =3D "mediatek-dp-phy",
        .of_match_table =3D mtk_dp_phy_of_match,
    },
};

Without a .remove implementation to handle unbinding the driver, could the
device remain permanently powered on and fail to cleanly suspend or unbind?

[Severity: High]
This is also a pre-existing issue, but is the phy_lookup entry left danglin=
g in
the global list when the driver is unbound?

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_legacy_probe() {
    ...
    phy_create_lookup(phy, "dp", dev_name(dev));
    ...
}

Because there is no .remove callback, phy_remove_lookup() is never called.

Could a subsequent phy_get() call traversing the list access the freed
pointer, resulting in a Use-After-Free since devres automatically frees the
struct phy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D4
