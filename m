Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC06C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7768010F1F7;
	Wed,  9 Sep 2026 17:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i44gsg9/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296FA10E563
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE68142A02;
 Wed,  9 Sep 2026 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547DD1F000FF;
 Wed,  9 Sep 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788974494;
 bh=YHUuBnyUaSwfKrnxOSInuWeO2hJJ9M/RR2BNd5uQGac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i44gsg9/CF45X9rmX877ONOtC+vD0OlhBiCJ8MZVu2gmvWgdMuHakp19E7u0nsUoQ
 kpJ+mjOAjC+/f/NaSxVQKLyyVz/t9yaeDELN4y3xTRvE1G9BSPd7xtEL1CJ7KCSuow
 SxLwthywqbe/CNpc08H/BUEnIIgmIcMHYzJXl1maI53aHpwgQ1/xifd46SnpO13akT
 SZpTPnVERYXbW6ZsZPl3h4CV3T4krcHXYg6byxNweWiMsATx3EadE+5CeMJG0zLWLz
 DezzdMiTWAAv5hp6G+961U4uxsnenEUEYTrd39yFYtRo2eTS9GE9Au1/AkuWmmS4AB
 xr3rPc3aru3gw==
Date: Wed, 9 Sep 2026 19:21:25 +0200
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
Subject: Re: [PATCH v3 08/12] phy: phy-mtk-dp: Add support for digital and
 analog calibration
Message-ID: <4keeuuv5flzhbyasse2mbljd2rog5yxgwlv5vobo3yvvdje3yb@42hey7suwm64>
References: <20260707154245.198361-1-angelogioacchino.delregno@collabora.com>
 <20260707154245.198361-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707154245.198361-9-angelogioacchino.delregno@collabora.com>
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

On Tue, Jul 07, 2026 at 05:42:41PM +0200, AngeloGioacchino Del Regno wrote:
> Add support for reading the calibration values from eFuse: if
> present, write those - otherwise, rely on the defaults from
> SoC-specific data.
> This also adds support for writing the calibration values for
> the analog part of the PHY.
> 
> Note that before this change, only default hardcoded calibration
> values were supported for the digital driving parameters.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/phy-mtk-dp.c | 303 +++++++++++++++++++++++++++---
>  1 file changed, 281 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
> index c87e9fa710a4..f59a415b401c 100644
> --- a/drivers/phy/mediatek/phy-mtk-dp.c
> +++ b/drivers/phy/mediatek/phy-mtk-dp.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> @@ -22,6 +23,19 @@
>  
>  #define MTK_DP_PHY_MAX_LANES		4
>  
> +/* DP_PHYA_GLB_BIAS_GEN_0 (PHYA - Analog) */
> +#define XTP_GLB_BIAS_INT_R_CTRL		GENMASK(20, 16)
> +
> +/* DP_PHYA_GLB_FORCE_CTRL_1 */
> +#define CKM_CKTX0_EN_FORCE_MODE		BIT(10)
> +
> +/* DP_PHYA_GLB_DPAUX_TX */
> +#define CKM_PT0_CKTX_IMPSEL		GENMASK(23, 20)
> +
> +/* DP_PHYA_LAN_LANE_TX_0 */
> +#define XTP_LN_TX_IMPSEL_PMOS		GENMASK(15, 12)
> +#define XTP_LN_TX_IMPSEL_NMOS		GENMASK(19, 16)
> +
>  /* DP_PHYA_GLB_FORCE_CTRL_1 */
>  #define CKM_CKTX0_EN_FORCE_MODE		BIT(10)
>  
> @@ -59,11 +73,29 @@
>  #define PHYD_DP_TX_FORCE_VOLT_SWING_VAL	GENMASK(2, 1)
>  #define PHYD_DP_TX_FORCE_PRE_EMPH_VAL	GENMASK(4, 3)
>  
> +/*
> + * DRIVING_PARAM_X (PHYD - Digital)
> + *
> + * Driving param registers are split in three sets, all containing settings
> + * for Voltage Swing and Pre-Emphasis for each lane's differential pair.
> + *
> + * All three sets share the same layout, but for different physical signals;
> + * In particular:
> + * [0-2]: LC TX CM (Minus / Negative Edge)
> + * [3-5]: LC TX C  (Logic State Change Point)
> + * [6-8]: LC TX CP (Plus / Positive Edge)
> + *
> + * And they contain values for:
> + * [0,3,6]: Swing 0 Pre[0-3]
> + * [1,4,7]: Swing 1 Pre[0-2] and Swing 2 Pre0
> + * [2,5,8]: Swing 2 Pre1 and Swing 3 Pre0
> + */
> +#define PHYD_DIG_NUM_DRV_PARA_REGS	9
>  #define XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT	BIT(4)
>  #define XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT	(BIT(10) | BIT(12))
>  #define XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT	GENMASK(20, 19)
>  #define XTP_LN_TX_LCTXC0_SW0_PRE3_DEFAULT	GENMASK(29, 29)
> -#define DRIVING_PARAM_3_DEFAULT	(XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_3_DEFAULT	(XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW0_PRE3_DEFAULT)
> @@ -72,21 +104,21 @@
>  #define XTP_LN_TX_LCTXC0_SW1_PRE1_DEFAULT	GENMASK(12, 9)
>  #define XTP_LN_TX_LCTXC0_SW1_PRE2_DEFAULT	(BIT(18) | BIT(21))
>  #define XTP_LN_TX_LCTXC0_SW2_PRE0_DEFAULT	GENMASK(29, 29)
> -#define DRIVING_PARAM_4_DEFAULT	(XTP_LN_TX_LCTXC0_SW1_PRE0_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_4_DEFAULT	(XTP_LN_TX_LCTXC0_SW1_PRE0_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW1_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW1_PRE2_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW2_PRE0_DEFAULT)
>  
>  #define XTP_LN_TX_LCTXC0_SW2_PRE1_DEFAULT	(BIT(3) | BIT(5))
>  #define XTP_LN_TX_LCTXC0_SW3_PRE0_DEFAULT	GENMASK(13, 12)
> -#define DRIVING_PARAM_5_DEFAULT	(XTP_LN_TX_LCTXC0_SW2_PRE1_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_5_DEFAULT	(XTP_LN_TX_LCTXC0_SW2_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXC0_SW3_PRE0_DEFAULT)
>  
>  #define XTP_LN_TX_LCTXCP1_SW0_PRE0_DEFAULT	0
>  #define XTP_LN_TX_LCTXCP1_SW0_PRE1_DEFAULT	GENMASK(10, 10)
>  #define XTP_LN_TX_LCTXCP1_SW0_PRE2_DEFAULT	GENMASK(19, 19)
>  #define XTP_LN_TX_LCTXCP1_SW0_PRE3_DEFAULT	GENMASK(28, 28)
> -#define DRIVING_PARAM_6_DEFAULT	(XTP_LN_TX_LCTXCP1_SW0_PRE0_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_6_DEFAULT	(XTP_LN_TX_LCTXCP1_SW0_PRE0_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW0_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW0_PRE2_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW0_PRE3_DEFAULT)
> @@ -95,22 +127,30 @@
>  #define XTP_LN_TX_LCTXCP1_SW1_PRE1_DEFAULT	GENMASK(10, 9)
>  #define XTP_LN_TX_LCTXCP1_SW1_PRE2_DEFAULT	GENMASK(19, 18)
>  #define XTP_LN_TX_LCTXCP1_SW2_PRE0_DEFAULT	0
> -#define DRIVING_PARAM_7_DEFAULT	(XTP_LN_TX_LCTXCP1_SW1_PRE0_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_7_DEFAULT	(XTP_LN_TX_LCTXCP1_SW1_PRE0_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW1_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW1_PRE2_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW2_PRE0_DEFAULT)
>  
>  #define XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT	GENMASK(3, 3)
>  #define XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT	0
> -#define DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
> +#define MT8195_DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
>  				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
>  
>  enum mtk_dp_phya_ana_glb_regidx {
> +	DP_PHYA_GLB_BIAS_GEN_0,
> +	DP_PHYA_GLB_BIAS_GEN_1,
> +	DP_PHYA_GLB_DPAUX_TX,
>  	DP_PHYA_GLB_FORCE_CTRL_0,
>  	DP_PHYA_GLB_FORCE_CTRL_1,
>  	DP_PHYA_GLOBAL_MAX
>  };
>  
> +enum mtk_dp_phya_ana_lane_regidx {
> +	DP_PHYA_LAN_LANE_TX_0,
> +	DP_PHYA_LAN_MAX
> +};
> +
>  enum mtk_dp_phyd_dig_lane_regidx {
>  	DP_PHYD_LAN_DRIVING_FORCE,
>  	DP_PHYD_LAN_DRIVING_PARAM_0,
> @@ -128,10 +168,17 @@ enum mtk_dp_phyd_dig_glb_regidx {
>  };
>  
>  static const u8 mt8195_phy_ana_glb_regs[DP_PHYA_GLOBAL_MAX] = {
> +	[DP_PHYA_GLB_BIAS_GEN_0] = 0x0,
> +	[DP_PHYA_GLB_BIAS_GEN_1] = 0x4,
> +	[DP_PHYA_GLB_DPAUX_TX] = 0x8,
>  	[DP_PHYA_GLB_FORCE_CTRL_0] = 0x30,
>  	[DP_PHYA_GLB_FORCE_CTRL_1] = 0x34,
>  };
>  
> +static const u8 mt8195_phy_ana_lane_regs[DP_PHYA_LAN_MAX] = {
> +	[DP_PHYA_LAN_LANE_TX_0] = 0x4,
> +};
> +
>  static const u8 mt8195_phy_dig_lane_regs[DP_PHYD_LAN_MAX] = {
>  	[DP_PHYD_LAN_DRIVING_FORCE] = 0x18,
>  	[DP_PHYD_LAN_DRIVING_PARAM_0] = 0x2c,
> @@ -146,49 +193,101 @@ static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] = {
>  	[DP_PHYD_TX_CTL_0] = 0x44,
>  };
>  
> +/**
> + * struct mtk_dp_phya_imp_sel - Per-Lane Impedance Selection
> + * @pmos: Impedance selection for P-Channel MOSFET
> + * @nmos: Impedance selection for N-Channel MOSFET
> + */
> +struct mtk_dp_phya_imp_sel {
> +	u8 pmos : 4;
> +	u8 nmos : 4;
> +};
> +
>  /**
>   * struct mtk_dp_phy_pdata - Platform data and defaults for MediaTek DP/eDP PHY
>   * @off_ana_glb:    Base offset for dptx_phyd_sifslv_ana_glb
> + * @off_ana_lane:   Base offsets for dptx_phyd_sifslv_ana_lan (for each lane)
>   * @off_dig_glb:    Base offset for dptx_phyd_sifslv_dig_glb
>   * @off_dig_lane:   Base offsets for dptx_phyd_sifslv_dig_lan (for each lane)
>   * @regs_ana_glb:   Register (layout) offsets for ana_glb
> + * @regs_ana_lane:  Register (layout) offsets for ana_lan
>   * @regs_dig_glb:   Register (layout) offsets for dig_glb
>   * @regs_dig_lane:  Register (layout) offsets for dig_lan
> + * @ana_bias_r:     Internal resistance "R" Selection Settings (global)
> + * @ana_cktx_imp:   TX Clock Impedance Selection Settings (global)
> + * @ana_lanes_imp:  TX Impedance Selection Settings (for all lanes)
> + * @driving_params: Voltage Swing and Pre-Emphasis settings (for all lanes)
>   */
>  struct mtk_dp_phy_pdata {
>  	/* Register offsets */
>  	u16 off_ana_glb;
> +	u16 off_ana_lane[MTK_DP_PHY_MAX_LANES];
>  	u16 off_dig_glb;
>  	u16 off_dig_lane[MTK_DP_PHY_MAX_LANES];
>  
>  	/* Register maps */
>  	const u8 *regs_ana_glb;
> +	const u8 *regs_ana_lane;
>  	const u8 *regs_dig_glb;
>  	const u8 *regs_dig_lane;
> +
> +	/* Calibration defaults */
> +	u8 ana_bias_r;
> +	u8 ana_cktx_imp;
> +	struct mtk_dp_phya_imp_sel ana_lanes_imp;
> +	u32 driving_params[PHYD_DIG_NUM_DRV_PARA_REGS];
>  };
>  
>  struct mtk_dp_phy {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	const struct mtk_dp_phy_pdata *pdata;
> +
> +	u8 ana_bias_r;
> +	u8 ana_cktx_imp;
> +	struct mtk_dp_phya_imp_sel ana_impsel[MTK_DP_PHY_MAX_LANES];
>  };
>  
> -static int mtk_dp_phy_init(struct phy *phy)
> +static int mtk_dp_phy_set_analog_calibration_params(struct mtk_dp_phy *dp_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
> +	const u8 *regs_ana_glb = pdata->regs_ana_glb;
> +	const u8 *regs_ana_lane = pdata->regs_ana_lane;
> +	int i, ret;
> +
> +	ret = regmap_update_bits(dp_phy->regmap,
> +				 pdata->off_ana_glb + regs_ana_glb[DP_PHYA_GLB_BIAS_GEN_0],
> +				 XTP_GLB_BIAS_INT_R_CTRL,
> +				 FIELD_PREP(XTP_GLB_BIAS_INT_R_CTRL, dp_phy->ana_bias_r));
> +	if (ret)
> +		return ret;

Same comment on error checks.

> +
> +	ret = regmap_update_bits(dp_phy->regmap,
> +				 pdata->off_ana_glb + regs_ana_glb[DP_PHYA_GLB_DPAUX_TX],
> +				 CKM_PT0_CKTX_IMPSEL,
> +				 FIELD_PREP(CKM_PT0_CKTX_IMPSEL, dp_phy->ana_cktx_imp));
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < MTK_DP_PHY_MAX_LANES; i++) {
> +		struct mtk_dp_phya_imp_sel *ana_imp = &dp_phy->ana_impsel[i];
> +		u32 val = FIELD_PREP(XTP_LN_TX_IMPSEL_PMOS, ana_imp->pmos) |
> +			  FIELD_PREP(XTP_LN_TX_IMPSEL_NMOS, ana_imp->nmos);
> +		u32 off_ana_lane = pdata->off_ana_lane[i];
> +
> +		ret = regmap_update_bits(dp_phy->regmap,
> +					 off_ana_lane + regs_ana_lane[DP_PHYA_LAN_LANE_TX_0],
> +					 XTP_LN_TX_IMPSEL_PMOS | XTP_LN_TX_IMPSEL_NMOS, val);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int mtk_dp_phy_set_digital_drv_params(struct mtk_dp_phy *dp_phy)
>  {
> -	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
>  	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
>  	const u32 reg = pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_PARAM_0];
> -	static const u32 driving_params[] = {
> -		DRIVING_PARAM_0_DEFAULT,
> -		DRIVING_PARAM_1_DEFAULT,
> -		DRIVING_PARAM_2_DEFAULT,
> -		DRIVING_PARAM_3_DEFAULT,
> -		DRIVING_PARAM_4_DEFAULT,
> -		DRIVING_PARAM_5_DEFAULT,
> -		DRIVING_PARAM_6_DEFAULT,
> -		DRIVING_PARAM_7_DEFAULT,
> -		DRIVING_PARAM_8_DEFAULT
> -	};
>  	int i, ret;
>  
>  	/*
> @@ -199,11 +298,31 @@ static int mtk_dp_phy_init(struct phy *phy)
>  	for (i = 0; i < MTK_DP_PHY_MAX_LANES; i++) {
>  		ret = regmap_bulk_write(dp_phy->regmap,
>  					pdata->off_dig_lane[i] + reg,
> -					driving_params,
> -					ARRAY_SIZE(driving_params));
> +					pdata->driving_params,
> +					ARRAY_SIZE(pdata->driving_params));
>  		if (ret)
>  			return ret;
>  	};
> +	return 0;
> +}
> +
> +static int mtk_dp_phy_init(struct phy *phy)
> +{
> +	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
> +	struct device *dev = &phy->dev;
> +	int ret;
> +
> +	ret = mtk_dp_phy_set_digital_drv_params(dp_phy);
> +	if (ret) {
> +		dev_err(dev, "Cannot set driving params\n");
> +		return ret;
> +	}
> +
> +	ret = mtk_dp_phy_set_analog_calibration_params(dp_phy);
> +	if (ret) {
> +		dev_err(dev, "Cannot set analog calibration\n");
> +		return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -422,6 +541,111 @@ static const struct phy_ops mtk_dp_phy_dev_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static void mtk_dp_phy_get_default_cal_data(struct mtk_dp_phy *dp_phy)
> +{
> +	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
> +	int i;
> +
> +	dp_phy->ana_bias_r = pdata->ana_bias_r;
> +	dp_phy->ana_cktx_imp = pdata->ana_cktx_imp;
> +
> +	/* Copy the default lane impedance settings to all lanes */
> +	for (i = 0; i < MTK_DP_PHY_MAX_LANES; i++)
> +		memcpy(&dp_phy->ana_impsel[i], &pdata->ana_lanes_imp,
> +		       sizeof(dp_phy->ana_impsel[0]));
> +
> +	return;
> +}
> +
> +static int mtk_dp_phy_get_one_cal_para(struct device *dev, const char *name, u8 max_val)
> +{
> +	u8 buf_byte;
> +	u16 buf;
> +	int ret;
> +
> +	/*
> +	 * All of the calibrations are always max 8 bits long, but some may
> +	 * be split between two different 8-bits cells: handle this corner
> +	 * case by retrying reading as u16.
> +	 */
> +	ret = nvmem_cell_read_u8(dev, name, &buf_byte);
> +	if (ret)
> +		ret = nvmem_cell_read_u16(dev, name, &buf);
> +	else
> +		buf = buf_byte;
> +
> +	if (ret) {
> +		dev_err(dev, "Cannot get calibration data for %s: %d\n", name, ret);

As Sashiko noted, this should be dev_err_probe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
