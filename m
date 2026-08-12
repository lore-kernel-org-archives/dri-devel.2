Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BABAC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F85E10F00C;
	Wed, 12 Aug 2026 13:59:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jDRW8v4w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4AF910F000;
 Wed, 12 Aug 2026 13:59:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8407C60A85;
 Wed, 12 Aug 2026 13:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E224E1F000E9;
 Wed, 12 Aug 2026 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786543154;
 bh=xWlAAoX4z+1nRZaEJHotnpbuB6N/MbAZxicm0ud2Z5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jDRW8v4wNfw2FXPPeT+ZU6O3C8E6xTCUNgfwlSDixfiQYXPjjhDobnAdb4z0fcLPk
 IsajS56QCPX/IM4mket556BdoRD/XaPaFdh67VS6M6ViLBXxNFTEj+0fs50lIprOIx
 zW71nAZNN8di9CY+TeqJKAvAzaxjajCtUBLjW7hl+EV9BTF6wd2CO+Rl7EpUs3TNGt
 cIbE50jfKzEDNCEk2xm2OWcoC5x3El3Zocv9Fay7Ed1vN95T69+dr6ENbJVHGuE0tP
 fXmQHIQiu+hKYQAa9GoE97aU0zhrTBkSZr1iDVn8HzlGy0+4KMy/dyAheyoPOvcHjr
 wNdIrDF4AyqEw==
Date: Wed, 12 Aug 2026 15:59:05 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 5/5] phy: qualcomm: add MSM8974 HDMI PHY support
Message-ID: <3nhliv4mf7a7oaupsfsr6cg5nbiyyaftmeseqlgm2urhssayt2@bwc3oyhmmmcs>
References: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
 <20260513-fd-hdmi-phy-v9-5-ca98c72f1f9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513-fd-hdmi-phy-v9-5-ca98c72f1f9f@oss.qualcomm.com>
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

On Wed, May 13, 2026 at 09:14:08PM +0300, Dmitry Baryshkov wrote:
> Add support for HDMI PHY on Qualcomm MSM8974 / APQ8074 platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c | 282 +++++++++++++++++++++++++++++
>  1 file changed, 282 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
> index 720757f8f393..7d398060b3a3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
> +++ b/drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c
> @@ -6,10 +6,13 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
> +#include <linux/math64.h>
>  
>  #include "phy-qcom-hdmi-preqmp.h"
> +#include "phy-qcom-uniphy.h"
>  
>  #define REG_HDMI_8x74_ANA_CFG0					0x00000000
>  #define REG_HDMI_8x74_ANA_CFG1					0x00000004
> @@ -31,8 +34,282 @@
>  #define REG_HDMI_8x74_BIST_PATN3				0x00000048
>  #define REG_HDMI_8x74_STATUS					0x0000005c
>  
> +#define HDMI_8974_VCO_MAX_FREQ 1800000000UL
> +#define HDMI_8974_VCO_MIN_FREQ  600000000UL
> +
> +#define HDMI_8974_COMMON_DIV 5
> +
> +static inline void write16(u16 val, void __iomem *reg)

Same comment as previous patch. No 'inline' keyword in .c files.

> +{
> +	writel(val & 0xff, reg);
> +	writel(val >> 8, reg + 4);
> +}
> +
> +static inline void write24(u32 val, void __iomem *reg)
> +{
> +	writel(val & 0xff, reg);
> +	writel((val >> 8) & 0xff, reg + 4);
> +	writel(val >> 16, reg + 8);
> +}
> +
> +static inline u32 read24(void __iomem *reg)
> +{
> +	u32 val = readl(reg);
> +
> +	val |= readl(reg + 4) << 8;
> +	val |= readl(reg + 8) << 16;
> +
> +	return val;
> +}
> +
> +static void qcom_uniphy_setup(void __iomem *base, unsigned int ref_freq,
> +			      bool sdm_mode,
> +			      bool ref_freq_mult_2,
> +			      bool dither,
> +			      unsigned int refclk_div,
> +			      unsigned int vco_freq)

Nit: You can align these arguments better.

> +{
> +	unsigned int int_ref_freq = ref_freq * (ref_freq_mult_2 ? 2 : 1);
> +	unsigned int div_in_freq = vco_freq / refclk_div;
> +	unsigned int dc_offset = div_in_freq / int_ref_freq - 1;
> +	unsigned int sdm_freq_seed;
> +	unsigned int val;
> +	u64 tmp = div_in_freq % int_ref_freq;
> +
> +	tmp *= 0x10000;
> +	sdm_freq_seed = div_u64(tmp, int_ref_freq);
> +
> +	val = FIELD_PREP(UNIPHY_PLL_REFCLK_DBLR, ref_freq_mult_2) |
> +	      FIELD_PREP(UNIPHY_PLL_REFCLK_DIV, refclk_div - 1);
> +	writel(val, base + UNIPHY_PLL_REFCLK_CFG);
> +
> +	if (sdm_mode) {
> +		writel(0, base + UNIPHY_PLL_SDM_CFG0);
> +		writel(FIELD_PREP(UNIPHY_PLL_SDM_DITHER_EN, dither) | dc_offset,
> +		       base + UNIPHY_PLL_SDM_CFG1);
> +		write24(sdm_freq_seed, base + UNIPHY_PLL_SDM_CFG2);
> +	} else {
> +		writel(UNIPHY_PLL_SDM_BYP | dc_offset, base + UNIPHY_PLL_SDM_CFG0);
> +		writel(0, base + UNIPHY_PLL_SDM_CFG1);
> +		write24(0, base + UNIPHY_PLL_SDM_CFG2);
> +	}
> +
> +	write16(mult_frac(ref_freq, 5, 1000000), base + UNIPHY_PLL_CAL_CFG8);
> +	write16(vco_freq / 16, base + UNIPHY_PLL_CAL_CFG10);
> +}
> +
> +static unsigned long qcom_uniphy_recalc(void __iomem *base, unsigned long parent_rate)
> +{
> +	unsigned long rate;
> +	u32 refclk_cfg;
> +	u32 dc_offset;
> +	u64 fraq_n;
> +	u32 val;
> +
> +	refclk_cfg = readl(base + UNIPHY_PLL_REFCLK_CFG);
> +	if (refclk_cfg & UNIPHY_PLL_REFCLK_DBLR)
> +		parent_rate *= 2;
> +
> +	val = readl(base + UNIPHY_PLL_SDM_CFG0);
> +	if (FIELD_GET(UNIPHY_PLL_SDM_BYP, val)) {
> +		dc_offset = FIELD_GET(UNIPHY_PLL_SDM_BYP_DIV, val);
> +		fraq_n = 0;
> +	} else {
> +		dc_offset = FIELD_GET(UNIPHY_PLL_SDM_DC_OFFSET,
> +				      readl(base + UNIPHY_PLL_SDM_CFG1));
> +		fraq_n = read24(base + UNIPHY_PLL_SDM_CFG2);
> +	}
> +
> +	rate = (dc_offset + 1) * parent_rate;
> +	rate += div_u64(fraq_n * parent_rate, 0x10000);
> +
> +	rate *= FIELD_GET(UNIPHY_PLL_REFCLK_DIV, refclk_cfg) + 1;
> +
> +	return rate;
> +}
> +
> +static const unsigned int qcom_hdmi_8974_divs[] = {1, 2, 4, 6};
> +
> +static unsigned long qcom_hdmi_8974_pll_recalc_rate(struct clk_hw *hw,
> +						    unsigned long parent_rate)
> +{
> +	struct qcom_hdmi_preqmp_phy *hdmi_phy = hw_clk_to_phy(hw);
> +	u32 div_idx = readl(hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV1_CFG);
> +	unsigned long rate = qcom_uniphy_recalc(hdmi_phy->pll_reg, parent_rate);
> +
> +	return rate / HDMI_8974_COMMON_DIV / qcom_hdmi_8974_divs[div_idx & 0x3];
> +}
> +
> +static int qcom_hdmi_8974_pll_determine_rate(struct clk_hw *hw,
> +					     struct clk_rate_request *req)
> +{
> +	unsigned long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
> +	unsigned long max_freq = HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV;
> +
> +	req->rate = clamp(req->rate, min_freq / 6, max_freq);
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops qcom_hdmi_8974_pll_ops = {
> +	.recalc_rate = qcom_hdmi_8974_pll_recalc_rate,
> +	.determine_rate = qcom_hdmi_8974_pll_determine_rate,
> +};
> +
> +static int qcom_hdmi_msm8974_phy_find_div(unsigned long long pixclk)
> +{
> +	unsigned long long min_freq = HDMI_8974_VCO_MIN_FREQ / HDMI_8974_COMMON_DIV;
> +	int i;
> +
> +	if (pixclk > HDMI_8974_VCO_MAX_FREQ / HDMI_8974_COMMON_DIV)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(qcom_hdmi_8974_divs); i++) {
> +		if (pixclk >= min_freq / qcom_hdmi_8974_divs[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int qcom_hdmi_msm8974_phy_pll_set_rate(struct qcom_hdmi_preqmp_phy *hdmi_phy)
> +{
> +	unsigned long long pixclk = hdmi_phy->hdmi_opts.tmds_char_rate;
> +	unsigned long vco_rate;
> +	unsigned int div;
> +	int div_idx = 0;
> +
> +	div_idx = qcom_hdmi_msm8974_phy_find_div(pixclk);
> +	if (WARN_ON(div_idx < 0))
> +		return div_idx;
> +
> +	div = qcom_hdmi_8974_divs[div_idx];
> +	vco_rate = pixclk * HDMI_8974_COMMON_DIV * div;
> +
> +	writel(0x81, hdmi_phy->phy_reg + REG_HDMI_8x74_GLB_CFG);
> +
> +	writel(0x01, hdmi_phy->pll_reg + UNIPHY_PLL_GLB_CFG);
> +	writel(0x19, hdmi_phy->pll_reg + UNIPHY_PLL_VCOLPF_CFG);
> +	writel(0x0e, hdmi_phy->pll_reg + UNIPHY_PLL_LPFR_CFG);
> +	writel(0x20, hdmi_phy->pll_reg + UNIPHY_PLL_LPFC1_CFG);
> +	writel(0x0d, hdmi_phy->pll_reg + UNIPHY_PLL_LPFC2_CFG);
> +
> +	qcom_uniphy_setup(hdmi_phy->pll_reg, 19200000, true, true, true, 1, vco_rate);
> +
> +	writel(0x10, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG0);
> +	writel(0x1a, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG1);
> +	writel(0x05, hdmi_phy->pll_reg + UNIPHY_PLL_LKDET_CFG2);
> +
> +	writel(div_idx, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV1_CFG);
> +
> +	writel(0x00, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV2_CFG);
> +	writel(0x00, hdmi_phy->pll_reg + UNIPHY_PLL_POSTDIV3_CFG);
> +	writel(0x01, hdmi_phy->pll_reg + UNIPHY_PLL_CAL_CFG2);
> +
> +	writel(0x1f, hdmi_phy->phy_reg + REG_HDMI_8x74_PD_CTRL0);
> +	udelay(50);

You've added a lot of delays in-between register writes. Delay between register
writes makes me nervous because there is no guarantee that the previous write
before delay would've reached the hardware before the next write after delay. So
the delay might become irrelevant and can cause nasty timing issues if these
delays need to be honored.

So I'd double check and add a readl() before the delay to flush the previous
writes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
