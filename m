Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C676EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D12F10E455;
	Tue,  7 Jul 2026 15:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibq+mNhd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11ED210E455
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:56:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D619641A99;
 Tue,  7 Jul 2026 15:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68ED1F000E9;
 Tue,  7 Jul 2026 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783439784;
 bh=BR+iQpZJepEmz0MopDypdDGqAeRtQkbVo5FSmYXDYTw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ibq+mNhdF/OXAgu5Ou+Mm2q8Wgm5ue+pmOuErVVJcCjnib+lNS+R+K+c43Vpr1UO5
 pZN1S2YVFWxrbPHjed6P1ZLnLNayIpTahyWzkDoyRZjsAtNOrYiGxvYhX0TmkUQNnk
 t4WBT+Er/phINwAZsgdxxIGUcR89nVrJwxxvxEYqEkrAnWT8eZ43eYS2VpRmGVjww7
 G7rJvCws3rrOO8TDetOeKJLrs3y7CIG1MaeTdMipAAP13w5XG8rSgjv7fZ3az4OhNr
 rA2565nPjCA8dS1XXQUFJQZGW4qNZIoTQ05kXhCIFaWSmjyzOoG/kNOem+vTldwPRi
 6qiwYTTb+dTaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/12] phy: phy-mtk-dp: Support set_lanes in
 configure and properly cleanup
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 devicetree@vger.kernel.org, vkoul@kernel.org, olteanv@gmail.com,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260707154245.198361-7-angelogioacchino.delregno@collabora.com>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:56:23 +0000
Message-Id: <20260707155623.E68ED1F000E9@smtp.kernel.org>
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
- [Low] Inconsistent use of device pointers for error logging in `mtk_dp_ph=
y_power_off` and `mtk_dp_phy_reset`.
--

--- Patch [6]: [PATCH v3 06/12] phy: phy-mtk-dp: Support set_lanes in confi=
gure and properly cleanup ---
commit cab309557ac4fcb462c5b8978a8cd660acab1ec1
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

phy: phy-mtk-dp: Support set_lanes in configure and properly cleanup

This commit adds support for enabling a specifically requested number of
lanes in the .configure() callback. It also updates the power off and reset
callbacks to disable all lanes for proper hardware cleanup.

> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
[ ... ]
> @@ -263,31 +281,68 @@ static int mtk_dp_phy_power_on(struct phy *phy)
[ ... ]
>  static int mtk_dp_phy_power_off(struct phy *phy)
>  {
>  	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
>  	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
>  	const u8 *regs_dig =3D pdata->regs_dig_glb;
>  	const u8 *regs_ana =3D pdata->regs_ana_glb;
> -	int ret_cktx, ret_aux;
> +	int ret_cktx, ret_aux, ret;
> =20
>  	ret_cktx =3D regmap_set_bits(dp_phy->regmap,
>  				   pdata->off_ana_glb + regs_ana[DP_PHYA_GLB_FORCE_CTRL_1],
>  				   CKM_CKTX0_EN_FORCE_MODE);
> +	if (ret_cktx)
> +		dev_err(&phy->dev, "Could not disable CKTX0: %d\n", ret_cktx);
[ ... ]
> +	ret =3D mtk_dp_phy_disable_all_lanes(dp_phy);
> +	if (ret) {
> +		dev_err(dp_phy->dev, "Could not disable lanes for poweroff!\n");

[Severity: Low]
Should this use &phy->dev instead of dp_phy->dev for error logging?

The adjacent error handlers for CKTX and AUX in this same function log=20
errors using &phy->dev. Mixing device pointers might lead to inconsistent=20
device names in the kernel log.

> +		return ret;
>  	}
[ ... ]
> @@ -307,6 +363,11 @@ static int mtk_dp_phy_reset(struct phy *phy)
[ ... ]
>  	/* Setting bits means go out of reset */
>  	regmap_set_bits(dp_phy->regmap, pdata->off_dig_glb + reg_rst, DP_GLB_SW=
_RST_PHYD);
> =20
> +	/* Disable all lanes and continue reset even if this fails, but notify =
*/
> +	ret =3D mtk_dp_phy_disable_all_lanes(dp_phy);
> +	if (ret)
> +		dev_err(dp_phy->dev, "Could not disable lanes during reset!\n");

[Severity: Low]
Similarly here, would it be better to use &phy->dev for consistency with=20
the rest of the API implementation?

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707154245.1983=
61-1-angelogioacchino.delregno@collabora.com?part=3D6
