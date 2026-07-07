Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7421BC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE7110E49F;
	Tue,  7 Jul 2026 16:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N27ifRur";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B7C10E49F
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:05:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E514A43B63;
 Tue,  7 Jul 2026 16:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4759F1F000E9;
 Tue,  7 Jul 2026 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440307;
 bh=Yk477um1jH80e2Sz/rztfnvHOzSQ3sa8se5sclGoQO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N27ifRur+LVxsYEgdJukVVfAeuFJKBOIhjFEmFTn1j8Z6758ckNJPn9My/oPTfdy1
 Fw6Jey/VmGqn953p95DNjxCnSS4GEQMdtYMI0fcvIsBF7XmlAUvh/HXfEuo2WVyQDT
 AoJcS8d0zgFd2SBnD5vvGzm2BnoJW/qiBqk2na8zG6J4yC628cI+8MSjPrShid3f/y
 c+dRRMb8Hx1nXfAH26jTwf5LCv3o+gOwsf2SZ6pubUSMA3eAWR9bXXFftpfAxf2yyi
 kynIBHHpCqRgvfMJ6bNS7A0Qk9SiQFJ58OHjCsMq4V0LNQUyXs5e3oDLi+q8Prb2rE
 zGTSYTE1J1b6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/12] phy: phy-mtk-dp: Add support for MT8196 eDP PHY
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, olteanv@gmail.com,
 vkoul@kernel.org
In-Reply-To: <20260707154245.198361-13-angelogioacchino.delregno@collabora.com>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:05:06 +0000
Message-Id: <20260707160507.4759F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing NULL check for the result of `device_get_match_data(dev)` =
before dereferencing it.
--

--- Patch [12]: [PATCH v3 12/12] phy: phy-mtk-dp: Add support for MT8196 eD=
P PHY ---
commit 171cadff965a41b7aba8d81fbb60622f2a8e1a97
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Add support for MT8196 eDP PHY

The MT8196 SoC features an updated PHY IP compared to the older
ones, and there is one that is specific to Embedded DisplayPort.
This commit adds support for the eDP PHY found in the MediaTek MT8196 SoC
and all of its variants.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index f5aadc5fdc42c..5decc29c77cb3 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -805,8 +838,39 @@ static const struct mtk_dp_phy_pdata mt8195_dp_phy_d=
ata =3D {
>  	},
>  };
> =20
> +static const struct mtk_dp_phy_pdata mt8196_edp_phy_data =3D {
> +	.off_ana_glb =3D 0x400,

[ ... ]

> +	.driving_params =3D (const u32[]) {
> +		[0] =3D 0,
> +		[1] =3D 0,
> +		[2] =3D 0,
> +		[3] =3D MT8196_DRIVING_PARAM_3_DEFAULT,
> +		[4] =3D MT8196_DRIVING_PARAM_4_DEFAULT,
> +		[5] =3D MT8196_DRIVING_PARAM_5_DEFAULT,
> +		[6] =3D MT8196_DRIVING_PARAM_6_DEFAULT,
> +		[7] =3D MT8196_DRIVING_PARAM_7_DEFAULT,
> +		[8] =3D MT8196_DRIVING_PARAM_8_DEFAULT
> +	},
> +};
> +
>  static const struct of_device_id mtk_dp_phy_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt8195-dp-phy", .data =3D &mt8195_dp_phy_da=
ta },
> +	{ .compatible =3D "mediatek,mt8196-edp-phy", .data =3D &mt8196_edp_phy_=
data },
>  	{ /* sentinel */ }
>  };

[Severity: High]
If the driver is forcefully bound to a device via the sysfs bind interface,
and the device has an of_node but its compatible string does not match any
entry in the driver's of_match_table, device_get_match_data(dev) will return
NULL.

This NULL pointer is stored in dp_phy->pdata:

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_probe() {
    ...
	dp_phy->pdata =3D device_get_match_data(dev);

	if (IS_REACHABLE(CONFIG_NVMEM)) {
		ret =3D mtk_dp_phy_get_calibration_data(dp_phy);
    ...
}

And is unconditionally dereferenced here:

drivers/phy/mediatek/phy-mtk-dp.c:mtk_dp_phy_get_default_cal_data() {
    ...
	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
	int i;

	dp_phy->ana_bias_r =3D pdata->ana_bias_r;
    ...
}

Should device_get_match_data() be checked for NULL before continuing in
mtk_dp_phy_probe() to prevent a potential kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707154245.1983=
61-1-angelogioacchino.delregno@collabora.com?part=3D12
