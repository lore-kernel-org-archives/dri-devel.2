Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84E0C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1471C10EDA6;
	Tue,  7 Jul 2026 14:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N/WqgxbW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074ED10EDA6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4F7943AFC;
 Tue,  7 Jul 2026 14:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278E61F000E9;
 Tue,  7 Jul 2026 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434896;
 bh=Suf8JZ6PIfFOLXhYIo/erubsBs3DC5+ejnPnfderUAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N/WqgxbWQcuTdvSwta08qJWHkMAMyu1YFOw+EKY2z830bV/xFvMt0yWilbwVVNylH
 Cw3v3h6LGok4cn7ZmHnnwQXsee4mr9yd5E4vH0Ee1ocPTLtxqCwc0QWi17YJgT9424
 y0srJaGogX9BbG/yrw4dYGmAxIplYm92p5/Kr+0L62uiYpPgp73FV3WrhLpsqxMrmk
 kXxhgjUTKsnO6EnJzsdH7d/4kzg8NQX20C/NMp3jZs9JBseK4GmaXm6XXSsXKMimv3
 SNyF1kjjH6jgvL/KPupPDMmsBajvYLgfcBI893PRYBe1ym3NRQXqXEm3I/udtZBipZ
 SukPnb+oduD7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] phy: phy-mtk-dp: Migrate register offsets to
 SoC specific pdata
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: neil.armstrong@linaro.org, linux-phy@lists.infradead.org, vkoul@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260707141931.191172-5-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
 <20260707141931.191172-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:34:55 +0000
Message-Id: <20260707143456.278E61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] PHY driving parameters are bulk written to the wrong starting regi=
ster offset, corrupting hardware state.
- [High] Missing NULL check on the result of `device_get_match_data()` lead=
s to a NULL pointer dereference.
- [Low] The array `off_dig_lane` in `mt8195_dp_phy_data` is initialized usi=
ng a compound literal, causing a compilation error.
- [Low] The variable `ret` is used without being declared in `mtk_dp_phy_pr=
obe`, causing a build failure.
- [Low] Missing `#include <linux/pm_runtime.h>` for `devm_pm_runtime_enable=
`.

Pre-existing issues:
- [High] Dereferencing `dev->platform_data` before verifying it is not `NUL=
L` causes a kernel panic.
--

--- Patch [4]: [PATCH v2 04/12] phy: phy-mtk-dp: Migrate register offsets t=
o SoC specific pdata ---
commit b50fb23a21796e73379a3d3b300932c7ffb998c8
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: phy: phy-mtk-dp: Migrate register offsets to SoC specific pdata

This commit migrates the hardcoded register offsets in the MediaTek DP PHY
driver to SoC-specific platform data. It also refactors the driving
parameter initialization to loop through all lanes instead of hardcoding
each lane.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index b042ab67ebaf3..915f148325c49 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -94,15 +143,21 @@ static int mtk_dp_phy_init(struct phy *phy)
>  		DRIVING_PARAM_7_DEFAULT,
>  		DRIVING_PARAM_8_DEFAULT
>  	};
> -
> -	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE0_DRIVING_PARAM_3,
> -			  driving_params, ARRAY_SIZE(driving_params));

[ ... ]

> +	int i, ret;
> +
> +	/*
> +	 * Assume that all lanes need the same driving parameters: this
> +	 * will bulk write from DRIVING_PARAM_0 to DRIVING_PARAM_8 on
> +	 * all lanes (a grand total of [9 * num_lanes] 32-bit writes)
> +	 */
> +	for (i =3D 0; i < MTK_DP_PHY_MAX_LANES; i++) {
> +		ret =3D regmap_bulk_write(dp_phy->regmap,
> +					pdata->off_dig_lane[i] + reg,
> +					driving_params,
> +					ARRAY_SIZE(driving_params));

[Severity: High]
Does this bulk write start at the correct register offset?

The loop writes the driving_params array starting at the base offset for
DP_PHYD_LAN_DRIVING_PARAM_0. However, the driving_params array only contain=
s 6
elements (defaults for PARAM_3 through PARAM_8).

Will this incorrectly write parameters 3-8 into the registers for 0-5, leav=
ing
registers 6-8 uninitialized and corrupting the hardware PHY configuration?

> +		if (ret)
> +			return ret;
> +	};
> =20
>  	return 0;
>  }

[ ... ]

> @@ -169,12 +233,19 @@ static void mtk_dp_phy_legacy_remove_lookup(void *d=
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
This is a pre-existing issue, but can dev->platform_data be NULL here?

The code directly dereferences dev->platform_data to assign dp_phy->regmap
before checking if it is NULL on the next line. If a device is probed witho=
ut
devicetree and platform data is missing, will this trigger a kernel panic?

>  	if (!dp_phy->regmap)
>  		return dev_err_probe(dev, -EINVAL, "No platform data available\n");

[ ... ]

> @@ -227,6 +298,8 @@ static int mtk_dp_phy_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(dp_phy->regmap))
>  		return PTR_ERR(dp_phy->regmap);
> =20
> +	dp_phy->pdata =3D device_get_match_data(dev);

[Severity: High]
Could device_get_match_data() return NULL here?

If the driver is manually bound via sysfs without a matching OF compatible
(but the device has an of_node), device_get_match_data() will return NULL.

Since dp_phy->pdata is later unconditionally dereferenced in functions like
mtk_dp_phy_init() to look up register offsets, will this lead to a NULL poi=
nter
dereference?

> +
>  	phy =3D devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);

[ ... ]

[Severity: Low]
Is the variable ret declared in the scope of mtk_dp_phy_probe?

It was noted that ret might be assigned the result of devm_pm_runtime_enabl=
e()
and evaluated:

ret =3D devm_pm_runtime_enable(dev);
if (ret)
    return ret;

But it appears it might not be declared within the local scope, which could
cause a compilation error.

[Severity: Low]
Should <linux/pm_runtime.h> be included in this file?

If devm_pm_runtime_enable() is used, it relies on the Power Management
API. Relying on implicit transitive inclusion for Power Management APIs can=
 be
fragile and may cause a build failure.

> @@ -245,8 +318,15 @@ static int mtk_dp_phy_probe(struct platform_device *=
pdev)
>  	return 0;
>  }
> =20
> +static const struct mtk_dp_phy_pdata mt8195_dp_phy_data =3D {
> +	.off_dig_glb =3D 0x1000,
> +	.off_dig_lane =3D (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },

[Severity: Low]
Will this array initialization compile correctly?

In standard C, an array member inside a struct should be initialized using a
brace-enclosed list. Using a compound literal cast like (const u16[]) decays
to a pointer, which may cause a compilation error for an array type initial=
izer.

> +	.regs_dig_glb =3D mt8195_phy_dig_glb_regs,
> +	.regs_dig_lane =3D mt8195_phy_dig_lane_regs,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141931.1911=
72-1-angelogioacchino.delregno@collabora.com?part=3D4
