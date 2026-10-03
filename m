Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F4ECA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 14:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D1510E0D7;
	Sat,  3 Oct 2026 14:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U5MZxtj0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A92010E0D7
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 14:25:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF2BF41357;
 Sat,  3 Oct 2026 14:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA811F0089C;
 Sat,  3 Oct 2026 14:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791037504;
 bh=OStxCh6fDcyrpKUJLDDLqh7HC7mBFGIT1dAR3GKdF4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U5MZxtj01Megkgki9VUtoR3nE6LqkCwnSZP+XxHAZUCJ715Cb+OmpmwLXpOaI/IR3
 F5OPyVar54h64ffr+Foyw0eU3K+eMntDcfoQjqNLDIzGvQcn2pahJBEvuOM/kY/yKN
 CPTLdcX7FzhFFrIUKcJBOV5EEsBx0lnbM9ouX15RWZOdvYo21sPP9bK5SXMRJGNgZ4
 xbr1p9ZLxHcWKICbUAkiUcA0nKsEAwVaP+wyjL/v51g9C+wf+holQn1aEiMRsW3rnl
 2/IIklB/6vYAJNs6AtkJi2AvsbBch8+csHi+40coRFeG2uomrGgDPTpw/mvh4SUT5b
 jOZGhdzze5clQ==
Date: Sat, 3 Oct 2026 16:25:01 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v5 19/21] phy: starfive: Add jh7110-inno-hdmi-phy driver
Message-ID: <asEQPf-oKbt_DSp3@parshuram>
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103245eucas1p1349d00810646fbf0149f1361534c23ac@eucas1p1.samsung.com>
 <20260929-jh7110-clean-send-v5-19-82b4d8e3c6c7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-jh7110-clean-send-v5-19-82b4d8e3c6c7@samsung.com>
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

On 29-09-26, 12:31, Michal Wilczynski wrote:
> Add the HDMI PHY driver for the StarFive JH7110.
> 
> This driver binds to the starfive,jh7110-inno-hdmi-phy node and
> gets its regmap from the parent. It has no dependencies on voutcrg, only
> on its reference oscillator (xin24m), which breaks the probe-time
> circular dependency.
> 
> This driver provides two main functions:
>  - Clock Provider: It registers clk_ops to provide the variable pixel
>    clock. The .set_rate operation configures the Pre-PLL registers
>    (0x1a0+) based on the requested rate.
> 
>  - PHY Provider: It registers phy_ops for the controller. The .power_on
>    op configures and enables the Post-PLL and other analog blocks (BIAS,
>    LDO, Serializer, etc.).
> 
> The clock ops reach registers in the window shared with the HDMI
> controller, and access to that window is gated by the controller's
> system clock, which only the sibling controller driver holds. The clock
> framework walks every registered clock regardless of which drivers have
> bound, so deliberately do not implement .is_prepared, which lets the
> framework fall back to the software prepare count, and return the cached
> rate from .recalc_rate whenever the clock is not prepared. Without this,
> clk_disable_unused() reads a PHY register with that clock gated and the
> resulting stalled bus transaction wedges the CPU hard enough that it
> stops responding to NMIs. It is reproducible by building the bridge
> driver as a module so that the controller has not bound by then.
> 
> The JH7110 instantiates the same Innosilicon IP as the Rockchip RK3328,
> with the PHY register block shifted by 0x100 because it sits behind the
> HDMI controller in the shared register space. The pre-PLL programming
> therefore comes from the common Innosilicon helpers; this driver adds
> the JH7110 pixel clock table, the post-PLL and the analog configuration.
> 
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/phy/starfive/Kconfig                |  20 +
>  drivers/phy/starfive/Makefile               |   1 +
>  drivers/phy/starfive/phy-jh7110-inno-hdmi.c | 582 ++++++++++++++++++++++++++++
>  3 files changed, 603 insertions(+)
> 
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> index d0cdd7cb4a13de22ff643c89a79d99cce57284d7..1da417ffbf224c13224e42a3ce322e3d0c272824 100644
> --- a/drivers/phy/starfive/Kconfig
> +++ b/drivers/phy/starfive/Kconfig
> @@ -25,6 +25,26 @@ config PHY_STARFIVE_JH7110_DPHY_TX
>  	  system. If M is selected, the module will be called
>  	  phy-jh7110-dphy-tx.ko.
>  
> +config PHY_STARFIVE_JH7110_INNO_HDMI
> +	tristate "Starfive JH7110 INNO HDMI PHY"
> +	select PHY_INNO_HDMI
> +	depends on COMMON_CLK
> +	select GENERIC_PHY
> +	help
> +	  This option enables the driver for the analog HDMI PHY (Physical
> +	  Layer) on the StarFive JH7110 SoC.
> +
> +	  This driver binds to a child node of the 'starfive,jh7110-hdmi-subsystem'
> +	  parent driver and gets its register map from that parent.
> +
> +	  It is responsible for two main functions:
> +	  1. PHY Provider: It provides standard PHY operations (.power_on,
> +	     .power_off) for the HDMI controller (bridge) driver. This
> +	     involves configuring the Post-PLL and analog TMDS blocks.
> +	  2. Clock Provider: It registers as a clock provider to supply the
> +	     variable pixel clock (hdmi_pclk) to the HDMI controller and
> +	     the VOUT subsystem, which it generates using the Pre-PLL.
> +
>  config PHY_STARFIVE_JH7110_PCIE
>  	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
>  	depends on HAS_IOMEM
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> index eedc4a6fec156320c99ac0a0da609083b6a6a695..e7b13f00880b500f933f21b6037384d5c6884e3e 100644
> --- a/drivers/phy/starfive/Makefile
> +++ b/drivers/phy/starfive/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_TX)	+= phy-jh7110-dphy-tx.o
> +obj-$(CONFIG_PHY_STARFIVE_JH7110_INNO_HDMI)	+= phy-jh7110-inno-hdmi.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
>  obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
> diff --git a/drivers/phy/starfive/phy-jh7110-inno-hdmi.c b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..cba6f3c3dae40bd982c062c8504438f51f3b30be
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
> + * Copyright (c) 2025 Samsung Electronics Co., Ltd.
> + *
> + * Author: Zheng Yang <zhengyang@rock-chips.com>
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + *
> + * The register layout and programming sequence derive from
> + * drivers/phy/rockchip/phy-rockchip-inno-hdmi.c; the JH7110 places the
> + * same Innosilicon PHY block at a 0x100 register offset.
> + *
> + * This driver handles the PHY portion of the StarFive Innosilicon HDMI IP,
> + * which is part of a monolithic HDMI block. It provides the variable pixel
> + * clock (from the Pre-PLL) and the PHY operations (for the Post-PLL/analog).
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/phy/inno-hdmi-phy.h>
> +#include <linux/phy/phy.h>
> +#include <linux/slab.h>
> +
> +/*
> + * StarFive (JH7110) Innosilicon HDMI PHY Register Definitions
> + */
> +
> +/* REG: 0x1aa */
> +#define STF_INNO_POST_PLL_DIV_1		0x1aa
> +#define STF_INNO_POST_PLL_POST_DIV_ENABLE	GENMASK(3, 2)
> +#define STF_INNO_POST_PLL_REFCLK_SEL_TMDS	BIT(1)
> +#define STF_INNO_POST_PLL_POWER_DOWN		BIT(0)
> +
> +/* REG: 0x1ab */
> +#define STF_INNO_POST_PLL_DIV_2		0x1ab
> +#define STF_INNO_POST_PLL_PRE_DIV(x)		FIELD_PREP(GENMASK(5, 0), x)
> +#define STF_INNO_POST_PLL_FB_DIV_8(x)		FIELD_PREP(BIT(7), (x) >> 8)
> +
> +/* REG: 0x1ac */
> +#define STF_INNO_POST_PLL_DIV_3		0x1ac
> +#define STF_INNO_POST_PLL_FB_DIV_7_0(x)	FIELD_PREP(GENMASK(7, 0), x)
> +
> +/* REG: 0x1ad */
> +#define STF_INNO_POST_PLL_DIV_4		0x1ad
> +#define STF_INNO_POST_PLL_POST_DIV_MASK	GENMASK(1, 0)
> +
> +/* REG: 0x1af */
> +#define STF_INNO_POST_PLL_LOCK_STATUS		0x1af
> +#define STF_INNO_POST_PLL_LOCK		BIT(0)
> +
> +/* REG: 0x1b0 */
> +#define STF_INNO_BIAS_CONTROL			0x1b0
> +#define STF_INNO_BIAS_ENABLE			BIT(2)
> +
> +/* REG: 0x1b2 */
> +#define STF_INNO_TMDS_CONTROL			0x1b2
> +#define STF_INNO_TMDS_CLK_DRIVER_EN		BIT(3)
> +#define STF_INNO_TMDS_D2_DRIVER_EN		BIT(2)
> +#define STF_INNO_TMDS_D1_DRIVER_EN		BIT(1)
> +#define STF_INNO_TMDS_D0_DRIVER_EN		BIT(0)
> +#define STF_INNO_TMDS_DRIVER_ENABLE		(STF_INNO_TMDS_CLK_DRIVER_EN | \
> +						 STF_INNO_TMDS_D2_DRIVER_EN | \
> +						 STF_INNO_TMDS_D1_DRIVER_EN | \
> +						 STF_INNO_TMDS_D0_DRIVER_EN)
> +
> +/* REG: 0x1b4 */
> +#define STF_INNO_LDO_CONTROL			0x1b4
> +#define STF_INNO_LDO_ENABLE			(BIT(2) | BIT(1) | BIT(0))
> +
> +/* REG: 0x1be */
> +#define STF_INNO_SERIALIER_CONTROL		0x1be
> +#define STF_INNO_SERIALIER_ENABLE		(BIT(6) | BIT(5) | BIT(4) | BIT(0))
> +
> +/* REG: 0x1cc */
> +#define STF_INNO_RX_CONTROL			0x1cc
> +#define STF_INNO_RX_ENABLE			(BIT(3) | BIT(2) | BIT(1) | BIT(0))
> +
> +/*
> + * These tables are copied from the monolithic driver.
> + * They match the Rockchip PHY driver tables.
> + */
> +
> +struct post_pll_config {
> +	unsigned long tmdsclock;
> +	u8 prediv;
> +	u16 fbdiv;
> +	u8 postdiv;
> +	u8 post_div_en;
> +};
> +
> +static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
> +	{ 25175000, 25175000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0xF55555 },

lower case hex values, here and everywhere else please

-- 
~Vinod
