Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4477C79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0585A10F1F9;
	Wed,  9 Sep 2026 17:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tj3NCkjs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2132110F1F9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:14:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EA2A60202;
 Wed,  9 Sep 2026 17:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA041F000FF;
 Wed,  9 Sep 2026 17:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974075;
 bh=6dv2vvcGbSpShMrWofXwfOBXiT7V+DJOWD8QO9nGBVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Tj3NCkjsGzfvDlibB9EJILNPTFhGXSWoQM16z/w2VW+JOQeWntoqTDaa9MFhPX01E
 ftRJH3TORePkbywM7bBIOObLe5V/SPUo5MZGN/Yyw/8QahyB79h9tA3FxgUgPhALOZ
 UlNI8YUTWEg0Q+GMUFgm/o63xnd2Qa+ceLIiOV6A/wn41+Q3q7cNUxFLHgsgOYOkWP
 VWC9fxQvQThPK1DkIipUnLyJgZTVdgXkgBhWkMetdi7AeUSS39N/narCUgDWf1aUmb
 nbnQ/F8nLhFhtXbE8aNvC3Ep7bsKmGpRxiQG+v7gXZmkqSaA5kafj9nzyFtcQGNtC/
 YYAkbuDNxMuOw==
Date: Wed, 9 Sep 2026 19:14:25 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, 
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 06/12] phy: phy-mtk-dp: Support set_lanes in configure
 and properly cleanup
Message-ID: <mdaumrppvlt5xoeewouxrdaibrgb6sw73byw3qzk47t4xdib24@msutldqcnkup>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-7-angelogioacchino.delregno@collabora.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Jul 07, 2026 at 05:42:39PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for enabling a specifically requested number of lanes
> in the .configure() callback and disable all lanes in power off
> and reset callbacks for proper hardware cleanup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/phy-mtk-dp.c | 75 ++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
> index f6b0e83d4833..2c8bc0b37486 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -10,6 +10,7 @@
>   *                     AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> @@ -50,6 +51,9 @@
>  #define DRIVING_PARAM_1_DEFAULT	0x0
>  #define DRIVING_PARAM_2_DEFAULT	0x0
>  
> +/* DP_PHYD_TX_CTL_0 */
> +#define PHYD_TX_LN_EN			GENMASK(7, 4)
> +
>  #define XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT	BIT(4)
>  #define XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT	(BIT(10) | BIT(12))
>  #define XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT	GENMASK(20, 19)
> @@ -113,6 +117,7 @@ enum mtk_dp_phyd_dig_glb_regidx {
>  	DP_PHYD_SW_RST,
>  	DP_PHYD_BIT_RATE,
>  	DP_PHYD_AUX_RX_CTL,
> +	DP_PHYD_TX_CTL_0,
>  	DP_PHYD_GLOBAL_MAX
>  };
>  
> @@ -131,6 +136,7 @@ static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] = {
>  	[DP_PHYD_SW_RST] = 0x38,
>  	[DP_PHYD_BIT_RATE] = 0x3c,
>  	[DP_PHYD_AUX_RX_CTL] = 0x40,
> +	[DP_PHYD_TX_CTL_0] = 0x44,
>  };
>  
>  /**
> @@ -200,6 +206,7 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
>  	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
>  	u32 val;
> +	int i;
>  
>  	if (opts->dp.set_rate) {
>  		const u32 reg_bit_rate = pdata->regs_dig_glb[DP_PHYD_BIT_RATE];
> @@ -226,6 +233,17 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
>  		regmap_write(dp_phy->regmap, pdata->off_dig_glb + reg_bit_rate, val);
>  	}
>  
> +	if (opts->dp.set_lanes) {
> +		const u32 reg_dig_tx_ctl = pdata->regs_dig_glb[DP_PHYD_TX_CTL_0];
> +
> +		val = 0;
> +		for (i = 0; i < opts->dp.lanes; i++)
> +			val |= FIELD_PREP(PHYD_TX_LN_EN, BIT(i));
> +
> +		regmap_update_bits(dp_phy->regmap, pdata->off_dig_glb + reg_dig_tx_ctl,
> +				   PHYD_TX_LN_EN, val);
> +	}
> +
>  	regmap_update_bits(dp_phy->regmap,
>  			   pdata->off_dig_glb + pdata->regs_dig_glb[DP_PHYD_PLL_CTL_1],
>  			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);
> @@ -263,31 +281,68 @@ static int mtk_dp_phy_power_on(struct phy *phy)
>  	return 0;
>  }
>  
> +static int mtk_dp_phy_disable_all_lanes(struct mtk_dp_phy *dp_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
> +	const u8 *regs = pdata->regs_dig_glb;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read(dp_phy->regmap, pdata->off_dig_glb + regs[DP_PHYD_TX_CTL_0], &val);
> +	if (ret)
> +		return ret;

Same comment as previous patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
