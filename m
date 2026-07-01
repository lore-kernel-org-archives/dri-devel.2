Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8BFC44500
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047D710F017;
	Wed,  1 Jul 2026 13:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lz1gDrWu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD78810F017
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7130140850;
 Wed,  1 Jul 2026 13:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9691F000E9;
 Wed,  1 Jul 2026 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782910944;
 bh=MwYg1YAoI39wRvoAcBgzLbmYQlvcrl66/3NbKVGwuEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lz1gDrWuY7UOVKIkxILFqALu51y6JTcV/9buRhmroPW4pGCAPcUE+f9aYm+YPm92q
 1GKDQQEG7H+O8j43TGoh9XBtaEawZII+CCPYw1gWCCpMALUfyCgObNrPmpxcQg2xpB
 YKPhQIbnByUWEmtlHLU3w8zkc1jSC5/JEh/WSXC3Kzsj6uDsjGPmC4/iKGv1E1j/yb
 YDx+P2Mbz2HuOQQHv1zgeeUqdtfMtHUCo7VaWDhkvwPzTB9SMtfIze9d8f9aATEq6P
 4ITVzYEud6ZUwVppjR15Ed0WMkGZLI613ljY8AYG78XUi9vCJXm2Wbh3HhkHOn7jZ9
 DhxWy/FXAOjNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] phy: phy-mtk-dp: Add bitrate register val
 definitions to SoC data
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org,
 conor+dt@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701122008.19509-11-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
 <20260701122008.19509-11-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:02:23 +0000
Message-Id: <20260701130223.CF9691F000E9@smtp.kernel.org>
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
- [High] mtk_dp_phy_disable_all_lanes loop executes undefined behavior when=
 val is 0, and incorrectly clears lane bits using the lane index instead of=
 a bitmask.
--

commit 25cdd51bd1ac4d69a49e77d93a6b1374ba46dd3c
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Support set_lanes in configure and properly cleanup

Add support for enabling a specifically requested number of lanes in the
configure callback, and disable all lanes in power off and reset
callbacks for proper hardware cleanup.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 586e727956332..a2cd22b9da066 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -261,6 +267,35 @@ static int mtk_dp_phy_power_on(struct phy *phy)
>  	return 0;
>  }
> =20
> +static int mtk_dp_phy_disable_all_lanes(struct mtk_dp_phy *dp_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
> +	const u8 *regs =3D pdata->regs_dig_glb;
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(dp_phy->regmap, pdata->off_dig_glb + regs[DP_PHYD_T=
X_CTL_0], &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Get mask of currently enabled lane */
> +	val =3D FIELD_GET(PHYD_TX_LN_EN, val);
> +
> +	/* Disable all lanes (needs to be done one by one, from last to first) =
*/
> +	do {
> +		u32 lane_num =3D fls(val) - 1;

[Severity: High]
If no lanes are currently enabled, val will be 0. Does this cause fls(0) - 1
to underflow, leading to undefined behavior when computing BIT(lane_num)?

> +		val &=3D ~BIT(lane_num);
> +
> +		ret =3D regmap_clear_bits(dp_phy->regmap,
> +					pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0],
> +					FIELD_PREP(PHYD_TX_LN_EN, lane_num));

[Severity: High]
Does this incorrectly clear bits using the lane index instead of a bitmask?

For example, if lane 3 is being disabled (lane_num =3D=3D 3), this passes 3=
 to
FIELD_PREP instead of BIT(3). This would clear lanes 0 and 1 (3 << 4) while
leaving lane 3 enabled. Should this use BIT(lane_num) instead?

> +		if (ret)
> +			return ret;
> +	} while (val);
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701122008.1950=
9-1-angelogioacchino.delregno@collabora.com?part=3D10
