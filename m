Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A3BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE9810F3B3;
	Thu, 10 Sep 2026 09:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ENW7Fq2o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB9F10F3B3
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D764C4056F;
 Thu, 10 Sep 2026 09:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441001F000FF;
 Thu, 10 Sep 2026 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789032632;
 bh=jayYXqGma6vMHe6SCZAyaJDURj3XtLml7LBm53wVlS0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ENW7Fq2omFFVROv71erfPeZgs8Wh7lE8p+rPSbDxQbX3tGgtjzibJKM54HPtPwIoR
 jKnqXGKWD0otqUNhEXrPkjgsUbgr/3h9SzlVkfaL79P3qieygYglkHgtOIBk5JpR3F
 LQxw+3/Ee+Jn6SO/MQgg4ruVAHirI4r7qIR1LJdiQ5dafJ5EvXI1LmKKEsIyWLxAVe
 Khck0HkOaDyzPGmUUAs3BSmzFQVaKXiy4F7GRq60IIUCMj6llLl9qXRSL8D9rgTMNL
 2CJKR2QJWx1xHhFaAAu8hLSt8CtIHAZhAXjOZ68uord5zoup9VoB4FMSQ4NhesoqFc
 P2bI70aJ9CypA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] phy: phy-mtk-dp: Support set_lanes in
 configure and properly cleanup
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, neil.armstrong@linaro.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, vkoul@kernel.org,
 olteanv@gmail.com, linux-phy@lists.infradead.org
In-Reply-To: <20260910092038.48291-7-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
 <20260910092038.48291-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:30:31 +0000
Message-Id: <20260910093032.441001F000FF@smtp.kernel.org>
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
- [High] mtk_dp_phy_disable_all_lanes() ignores the return value of regmap_=
read() and unconditionally returns 0, leading to uninitialized memory use a=
nd dead code.
--

commit 96237b9548980d0963b925da5fbae9fec554beb6
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: phy: phy-mtk-dp: Support set_lanes in configure and properly clean=
up

This commit adds support for configuring a specific number of lanes
via the .configure() callback. It also introduces functionality to
disable all lanes during power-off and reset to ensure proper hardware
state cleanup.

> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy=
-mtk-dp.c
> index 4247506ceb996..276391d991aae 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c

[ ... ]

> @@ -254,12 +272,39 @@ static int mtk_dp_phy_power_on(struct phy *phy)
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
> +	/* Get mask of currently enabled lane */
> +	regmap_read(dp_phy->regmap, pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0]=
, &val);

[Severity: High]
Does this code handle the possibility of regmap_read() failing?

If regmap_read() returns an error (e.g., if the underlying bus or clock is =
in
an invalid state), it will not initialize val. In this scenario, the subseq=
uent
operations would use uninitialized stack memory, potentially leading to ran=
dom
lanes being disabled based on garbage data.

> +	val =3D FIELD_GET(PHYD_TX_LN_EN, val);
> +	if (val =3D=3D 0)
> +		return 0;
> +
> +	/* Disable all lanes (needs to be done one by one, from last to first) =
*/
> +	do {
> +		u32 lane_num =3D fls(val) - 1;
> +		val &=3D ~BIT(lane_num);
> +
> +		regmap_clear_bits(dp_phy->regmap,
> +				  pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0],
> +				  FIELD_PREP(PHYD_TX_LN_EN, BIT(lane_num)));
> +	} while (val);
> +
> +	return 0;

[Severity: High]
Should this function return the error state from the regmap operations?

It declares a ret variable but never uses it, and unconditionally returns 0.

> +}
> +
>  static int mtk_dp_phy_power_off(struct phy *phy)
>  {
>  	struct mtk_dp_phy *dp_phy =3D phy_get_drvdata(phy);
>  	const struct mtk_dp_phy_pdata *pdata =3D dp_phy->pdata;
>  	const u8 *regs_dig =3D pdata->regs_dig_glb;
>  	const u8 *regs_ana =3D pdata->regs_ana_glb;
> +	int ret;
> =20
>  	regmap_set_bits(dp_phy->regmap,
>  			pdata->off_ana_glb + regs_ana[DP_PHYA_GLB_FORCE_CTRL_1],
> @@ -269,6 +314,12 @@ static int mtk_dp_phy_power_off(struct phy *phy)
>  	regmap_write(dp_phy->regmap,
>  		     pdata->off_dig_glb + regs_dig[DP_PHYD_AUX_RX_CTL], 0);
> =20
> +	ret =3D mtk_dp_phy_disable_all_lanes(dp_phy);
> +	if (ret) {
> +		dev_err(dp_phy->dev, "Could not disable lanes for poweroff!\n");
> +		return ret;
> +	}

[Severity: High]
Since mtk_dp_phy_disable_all_lanes() unconditionally returns 0, this error
handling block appears to be dead code, preventing the driver from properly
detecting hardware state failures during cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910092038.4829=
1-1-angelogioacchino.delregno@collabora.com?part=3D6
