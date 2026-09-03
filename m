Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AA6C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 08:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5509510F47A;
	Thu,  3 Sep 2026 08:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="MhKqhME4";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F68B10F47A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 08:54:28 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260903085426euoutp0126e2eeae739fc11060973a0b7ba3555e~Rw6sV3hs02164721647euoutp017;
 Thu,  3 Sep 2026 08:54:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260903085426euoutp0126e2eeae739fc11060973a0b7ba3555e~Rw6sV3hs02164721647euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788425666;
 bh=LOkYxz3Oezfh1yuw0xzCd8pYE55TvVzXagNAQsIRoy0=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=MhKqhME4b5F32bicau4K2jzSEq3wIsEIb5MwjlwFt3U8gckjylOcOhsyGgtydmFMn
 7hKX6KuKGngVtIGY6WXos3x5vtepLkZ+Z5fK7JQEblrXSVYB+mE5Rp2qQF0SCP9BMn
 rvX+W9Dv3cPgLWA2YwkMBcJCeOAZ3E1uT5NkqwEk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260903085426eucas1p1713eec26146a98505e28a101e05d802a~Rw6sH43dC2977729777eucas1p1q;
 Thu,  3 Sep 2026 08:54:26 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260903085424eusmtip2c180ef4b2dc77c593da322a763d8ace6~Rw6qbbnE42884428844eusmtip28;
 Thu,  3 Sep 2026 08:54:24 +0000 (GMT)
Message-ID: <0a2524af-b6fa-4570-b959-b4bdabee5ad7@samsung.com>
Date: Thu, 3 Sep 2026 10:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss
 <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Hal
 Feng <hal.feng@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney@redhat.com>, Conor Dooley <conor@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dominique
 Belhachemi <db@domibel.de>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, Icenowy
 Zheng <uwu@icenowy.me>, Andy Yan <andyshrk@163.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Maud Spierings <maudspierings@gocontroll.com>,
 Graham Markall <hello@big-grey.co.uk>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <cddc47a2-81de-4978-9009-bdefeda2d3b5@kwiboo.se>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260903085426eucas1p1713eec26146a98505e28a101e05d802a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134835eucas1p27736632121c17e11f554e295994a7d8d
X-EPHeader: CA
X-CMS-RootMailID: 20260828134835eucas1p27736632121c17e11f554e295994a7d8d
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134835eucas1p27736632121c17e11f554e295994a7d8d@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-12-331680c8b9d1@samsung.com>
 <cddc47a2-81de-4978-9009-bdefeda2d3b5@kwiboo.se>
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



On 9/1/26 20:14, Jonas Karlman wrote:
> Hi Michal,
> 
> On 8/28/2026 3:47 PM, Michal Wilczynski wrote:
>> The RK3328 pre-PLL programming, its table lookup and its recalc_rate and
>> determine_rate implementations are the generic Innosilicon ones, so drop
>> the local copies and use the shared helpers instead.
> 
> RK3528 and RK3538/RK3539 also seems to use the generic Innosilicon ones,
> so we should hopefully also be able to use the helpers for those SoCs.

Good to know, I've left them alone for now since I don't have the board
to test it, but it should be fairly easy to convert them as well.

> 
>>
>> The RK3228 pre-PLL sits at different register addresses, so it keeps its
>> own register level code and only shares the table lookup.
>>
>> The register writes, their order and the values written are unchanged.
>> No functional change intended.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/phy/rockchip/Kconfig                  |   1 +
>>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 127 +++++---------------------
>>  2 files changed, 25 insertions(+), 103 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
>> index 14698571b607590dc0e7a29f3b39eb9a5d4e3d25..9732c5be87717dc3ddbea1c60080952336a07af9 100644
>> --- a/drivers/phy/rockchip/Kconfig
>> +++ b/drivers/phy/rockchip/Kconfig
>> @@ -34,6 +34,7 @@ config PHY_ROCKCHIP_INNO_HDMI
>>  	depends on COMMON_CLK
>>  	depends on HAS_IOMEM
>>  	select GENERIC_PHY
>> +	select PHY_INNO_HDMI
>>  	help
>>  	  Enable this to support the Rockchip Innosilicon HDMI PHY.
>>  
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> index 1483907413faa5ce1dc8614db05e6e929410404d..fae766607b0ea120b3adb36001387062f39a5c00 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regmap.h>
>> +#include <linux/phy/inno-hdmi-phy.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/slab.h>
>>  
>> @@ -240,6 +241,8 @@ struct inno_hdmi_phy {
>>  	const struct inno_hdmi_phy_drv_data *plat_data;
>>  	int chip_version;
>>  
>> +	struct inno_hdmi_phy_pre_pll pre_pll;
>> +
>>  	/* clk provider */
>>  	struct clk_hw hw;
>>  	struct clk *phyclk;
>> @@ -247,21 +250,6 @@ struct inno_hdmi_phy {
>>  	unsigned long tmdsclock;
>>  };
>>  
>> -struct pre_pll_config {
>> -	unsigned long pixclock;
>> -	unsigned long tmdsclock;
>> -	u8 prediv;
>> -	u16 fbdiv;
>> -	u8 tmds_div_a;
>> -	u8 tmds_div_b;
>> -	u8 tmds_div_c;
>> -	u8 pclk_div_a;
>> -	u8 pclk_div_b;
>> -	u8 pclk_div_c;
>> -	u8 pclk_div_d;
>> -	u8 vco_div_5_en;
>> -	u32 fracdiv;
>> -};
>>  
>>  struct post_pll_config {
>>  	unsigned long tmdsclock;
>> @@ -290,7 +278,7 @@ struct inno_hdmi_phy_drv_data {
>>  	const struct phy_config		*phy_cfg_table;
>>  };
>>  
>> -static const struct pre_pll_config pre_pll_cfg_table[] = {
>> +static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
>>  	{ 25175000,  25175000,  3,  125, 3, 1, 1,  1, 3, 3,  4, 0, 0xe00000},
>>  	{ 25175000,  31468750,  1,   41, 0, 3, 3,  1, 3, 3,  4, 0, 0xf5554f},
>>  	{ 27000000,  27000000,  1,   36, 0, 3, 3,  1, 2, 3,  4, 0,      0x0},
>> @@ -673,20 +661,12 @@ static const struct phy_ops inno_hdmi_phy_ops = {
>>  };
>>  
>>  static const
>> -struct pre_pll_config *inno_hdmi_phy_get_pre_pll_cfg(struct inno_hdmi_phy *inno,
>> -						     unsigned long rate)
>> +struct inno_hdmi_phy_pre_pll_config *inno_hdmi_phy_get_pre_pll_cfg(struct inno_hdmi_phy *inno,
>> +								   unsigned long rate)
>>  {
>> -	const struct pre_pll_config *cfg = pre_pll_cfg_table;
>>  	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
>>  
>> -	for (; cfg->pixclock != 0; cfg++)
>> -		if (cfg->pixclock == rate && cfg->tmdsclock == tmdsclock)
>> -			break;
>> -
>> -	if (cfg->pixclock == 0)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	return cfg;
>> +	return inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, rate, tmdsclock);
> 
> Please fully remove the local inno_hdmi_phy_get_pre_pll_cfg() helper and
> call inno_hdmi_phy_pre_pll_lookup() in its place.

will do in v3

> 
>>  }
>>  
>>  static int inno_hdmi_phy_rk3228_clk_is_prepared(struct clk_hw *hw)
>> @@ -752,7 +732,7 @@ unsigned long inno_hdmi_phy_rk3228_clk_recalc_rate(struct clk_hw *hw,
>>  static int inno_hdmi_phy_rk3228_clk_determine_rate(struct clk_hw *hw,
>>  						   struct clk_rate_request *req)
>>  {
>> -	const struct pre_pll_config *cfg = pre_pll_cfg_table;
>> +	const struct inno_hdmi_phy_pre_pll_config *cfg = pre_pll_cfg_table;
>>  
>>  	req->rate = (req->rate / 1000) * 1000;
>>  
>> @@ -773,7 +753,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
>>  					     unsigned long parent_rate)
>>  {
>>  	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
>> -	const struct pre_pll_config *cfg;
>> +	const struct inno_hdmi_phy_pre_pll_config *cfg;
>>  	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
>>  	u32 v;
>>  	int ret;
>> @@ -870,39 +850,11 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
>>  						   unsigned long parent_rate)
>>  {
>>  	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
>> -	unsigned long frac;
>> -	u8 nd, no_a, no_b, no_d;
>> -	u64 vco;
>> -	u16 nf;
>> -
>> -	nd = inno_read(inno, 0xa1) & RK3328_PRE_PLL_PRE_DIV_MASK;
>> -	nf = ((inno_read(inno, 0xa2) & RK3328_PRE_PLL_FB_DIV_11_8_MASK) << 8);
>> -	nf |= inno_read(inno, 0xa3);
>> -	vco = parent_rate * nf;
>> -
>> -	if (!(inno_read(inno, 0xa2) & RK3328_PRE_PLL_FRAC_DIV_DISABLE)) {
>> -		frac = inno_read(inno, 0xd3) |
>> -		       (inno_read(inno, 0xd2) << 8) |
>> -		       (inno_read(inno, 0xd1) << 16);
>> -		vco += DIV_ROUND_CLOSEST(parent_rate * frac, (1 << 24));
>> -	}
>>  
>> -	if (inno_read(inno, 0xa0) & RK3328_PCLK_VCO_DIV_5_MASK) {
>> -		do_div(vco, nd * 5);
>> -	} else {
>> -		no_a = inno_read(inno, 0xa5) & RK3328_PRE_PLL_PCLK_DIV_A_MASK;
>> -		no_b = inno_read(inno, 0xa5) & RK3328_PRE_PLL_PCLK_DIV_B_MASK;
>> -		no_b >>= RK3328_PRE_PLL_PCLK_DIV_B_SHIFT;
>> -		no_b += 2;
>> -		no_d = inno_read(inno, 0xa6) & RK3328_PRE_PLL_PCLK_DIV_D_MASK;
>> -
>> -		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
>> -	}
>> +	inno->pixclock = inno_hdmi_phy_pre_pll_recalc_rate(&inno->pre_pll,
>> +							   parent_rate);
>>  
>> -	inno->pixclock = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
>> -
>> -	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
>> -		__func__, inno->pixclock, vco);
>> +	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
> 
> VCO should be between 1.4-3.2 GHz, we now loose this debug information.
> This is a change that probably should be noted in the commit message.

I think I can restore this debug info in the helper for v3

> 
>>  
>>  	return inno->pixclock;
>>  }
>> @@ -910,20 +862,9 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
>>  static int inno_hdmi_phy_rk3328_clk_determine_rate(struct clk_hw *hw,
>>  						   struct clk_rate_request *req)
>>  {
>> -	const struct pre_pll_config *cfg = pre_pll_cfg_table;
>> -
>> -	req->rate = (req->rate / 1000) * 1000;
>> -
>> -	for (; cfg->pixclock != 0; cfg++)
>> -		if (cfg->pixclock == req->rate)
>> -			break;
>> -
>> -	if (cfg->pixclock == 0)
>> -		return -EINVAL;
>> -
>> -	req->rate = cfg->pixclock;
>> +	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
>>  
>> -	return 0;
>> +	return inno_hdmi_phy_pre_pll_determine_rate(&inno->pre_pll, req);
>>  }
>>  
>>  static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
>> @@ -931,9 +872,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
>>  					     unsigned long parent_rate)
>>  {
>>  	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
>> -	const struct pre_pll_config *cfg;
>> +	const struct inno_hdmi_phy_pre_pll_config *cfg;
>>  	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
>> -	u32 val;
>>  	int ret;
>>  
>>  	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
>> @@ -946,35 +886,11 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
>>  	if (IS_ERR(cfg))
>>  		return PTR_ERR(cfg);
>>  
>> -	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN,
>> -			 RK3328_PRE_PLL_POWER_DOWN);
>> -
>> -	/* Configure pre-pll */
>> -	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
>> -			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
>> -	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
>> -
>> -	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
>> -	if (!cfg->fracdiv)
>> -		val |= RK3328_PRE_PLL_FRAC_DIV_DISABLE;
>> -	inno_write(inno, 0xa2, RK3328_PRE_PLL_FB_DIV_11_8(cfg->fbdiv) | val);
>> -	inno_write(inno, 0xa3, RK3328_PRE_PLL_FB_DIV_7_0(cfg->fbdiv));
>> -	inno_write(inno, 0xa5, RK3328_PRE_PLL_PCLK_DIV_A(cfg->pclk_div_a) |
>> -		   RK3328_PRE_PLL_PCLK_DIV_B(cfg->pclk_div_b));
>> -	inno_write(inno, 0xa6, RK3328_PRE_PLL_PCLK_DIV_C(cfg->pclk_div_c) |
>> -		   RK3328_PRE_PLL_PCLK_DIV_D(cfg->pclk_div_d));
>> -	inno_write(inno, 0xa4, RK3328_PRE_PLL_TMDSCLK_DIV_C(cfg->tmds_div_c) |
>> -		   RK3328_PRE_PLL_TMDSCLK_DIV_A(cfg->tmds_div_a) |
>> -		   RK3328_PRE_PLL_TMDSCLK_DIV_B(cfg->tmds_div_b));
>> -	inno_write(inno, 0xd3, RK3328_PRE_PLL_FRAC_DIV_7_0(cfg->fracdiv));
>> -	inno_write(inno, 0xd2, RK3328_PRE_PLL_FRAC_DIV_15_8(cfg->fracdiv));
>> -	inno_write(inno, 0xd1, RK3328_PRE_PLL_FRAC_DIV_23_16(cfg->fracdiv));
>> +	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
>> +	inno_hdmi_phy_pre_pll_configure(&inno->pre_pll, cfg);
>> +	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, false);
>>  
>> -	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN, 0);
> 
> This should likely also remove all now unused RK3328 pre_pll related
> macros.

will do for v3.

Thank you for your review, as mentioned before I don't have rockchip
hardware so a Tested-by tag for after v3 is sent would be very welcome.

> 
> Regards,
> Jonas
> 
>> -
>> -	/* Wait for Pre-PLL lock */
>> -	ret = inno_poll(inno, 0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
>> -			1000, 10000);
>> +	ret = inno_hdmi_phy_pre_pll_wait_locked(&inno->pre_pll, 10000);
>>  	if (ret) {
>>  		dev_err(inno->dev, "Pre-PLL locking failed\n");
>>  		return ret;
>> @@ -1373,6 +1289,11 @@ static int inno_hdmi_phy_probe(struct platform_device *pdev)
>>  	if (IS_ERR(inno->regmap))
>>  		return PTR_ERR(inno->regmap);
>>  
>> +	/* The PHY block starts the register space on these SoCs. */
>> +	inno->pre_pll.regmap = inno->regmap;
>> +	inno->pre_pll.offset = 0;
>> +	inno->pre_pll.table = pre_pll_cfg_table;
>> +
>>  	/* only the newer rk3328 hdmiphy has an interrupt */
>>  	inno->irq = platform_get_irq(pdev, 0);
>>  	if (inno->irq > 0) {
>>
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
