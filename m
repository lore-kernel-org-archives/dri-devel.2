Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4882C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 03:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC2810E425;
	Mon,  7 Sep 2026 03:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XTf4ceYG";
	dkim-atps=neutral
Received: from mail-m10195.netease.com (mail-m10195.netease.com
 [154.81.10.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18B610E425
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 03:51:57 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4cc106c1d;
 Mon, 7 Sep 2026 11:51:52 +0800 (GMT+08:00)
Message-ID: <15741677-7f2c-4190-b77f-a496643593c6@rock-chips.com>
Date: Mon, 7 Sep 2026 11:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/19] drm/bridge: starfive: Add JH7110 HDMI controller
 driver
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Lee Jones <lee@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Andy Yan <andyshrk@163.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132735eucas1p2c898afe4a4c6e957a7b9eedff321a6dc@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260904-jh7110-clean-send-v3-14-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa079fe6d2b03a7kunm1578719f367f00
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSU0aVk9NTk4fHh4dQkkdSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQkxVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=XTf4ceYGuRf+Bea49mCirc4h09mur540oJnaxi7YtW22DeczQ/QS9Pu2+imyL5HE9X0Sni7hMr7LW88iqEnQBZBnrHflPfgVXhYoN2NjnhgPdp75SSK0Ru0ZydU9SF4zB8+2HhQErRYytmTazOix9GaPiCEcRV8gY1n+6Unb/d0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=sNftk6dAOj9MP5wzHtcUwGMPv4F8HHzi/b6fKcXGrKA=;
 h=date:mime-version:subject:message-id:from;
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

Hello Michal,

On 9/4/2026 9:27 PM, Michal Wilczynski wrote:
> Add the HDMI controller (bridge) driver for the StarFive JH7110.
> 
> This driver binds to the starfive,jh7110-inno-hdmi-controller node.
> It gets its shared regmap from its parent and its register access,
> module and bus clocks from voutcrg. It consumes the pixel clock and the
> PHY from its hdmi_phy sibling.
> 
> The driver calls the generic inno_hdmi_probe function and passes the
> shared regmap to it, registering as a DRM bridge. The .enable hook is
> responsible for setting the PHY's pixel clock rate via clk_set_rate()
> and powering on the PHY via phy_power_on().
> 
> The DC8200 has two panels, each exposing a DP and a DPI interface, and a
> mux in the video output system controller picks which of them drives the
> HDMI transmitter. Program that mux from the port graph rather than
> relying on whatever the bootloader left behind, taking the panel from the
> remote port number and the interface from the remote endpoint number.
> 
> The generic driver holds the clock it looks up as the register access
> clock enabled for its lifetime, and derives the DDC divider from that
> clock's rate, so point it at the system clock. Naming the pixel clock
> there instead would keep the PHY pre-PLL powered from probe onwards and
> size the divider from the wrong rate.
> 
> The PHY can only generate the discrete set of pixel clocks described by
> its pre-PLL table, so .mode_valid rejects any mode clk_round_rate()
> cannot satisfy. Without it such a mode would be advertised to userspace
> and the modeset would appear to succeed while the display stayed blank.
> 
> .enable returns early when the rate is unsupported or the PHY fails to
> power on, so track whether the pixel clock was actually enabled and let
> .disable tear down only what was brought up, otherwise the clock
> refcount underflows.
> 
> The clocks and the reset are torn down through devm rather than from
> .remove, so that they outlive the bridge that inno_hdmi_probe() adds with
> devm_drm_bridge_add(). Releasing them in .remove runs before devres
> unwinds and would leave the bridge registered with its clocks already
> gated.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig            |  11 ++
>  drivers/gpu/drm/bridge/Makefile           |   1 +
>  drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 318 ++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 4a57d49b4c6d3ab4b965228835b372d191647197..75b1cf6727d5a32310dcf9fe5734d95e14eea8fe 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -359,6 +359,17 @@ config DRM_SOLOMON_SSD2825
>  	  Say M here if you want to support this hardware as a module.
>  	  The module will be named "ssd2825".
>  
> +config DRM_STARFIVE_JH7110_INNO_HDMI
> +	tristate "Starfive JH7110 Innosilicon HDMI bridge"
> +	depends on OF
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	select DRM_INNO_HDMI
> +	help
> +	  Enable support for the StarFive JH7110 specific implementation
> +	  of the Innosilicon HDMI controller.
> +	  This driver acts as a glue layer between the JH7110 HDMI subsystem
> +	  parent driver and the generic Innosilicon HDMI bridge driver.
> +
>  config DRM_THINE_THC63LVD1024
>  	tristate "Thine THC63LVD1024 LVDS decoder bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 15cc821d85b7ea6f3cdc313f3e521b028de567d7..5d843f4ad7ed50b28cb75286c5e22789d91a0836 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
>  obj-$(CONFIG_DRM_SII902X) += sii902x.o
>  obj-$(CONFIG_DRM_SII9234) += sii9234.o
>  obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
> +obj-$(CONFIG_DRM_STARFIVE_JH7110_INNO_HDMI) += jh7110-inno-hdmi.o
>  obj-$(CONFIG_DRM_SOLOMON_SSD2825) += ssd2825.o
>  obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
>  obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
> diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b0bf6abaa55fb452a90021586faf5f220c150968
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) StarFive Technology Co., Ltd.
> + * Copyright (c) 2025 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + *
> + * HDMI controller (bridge) driver for the StarFive JH7110 HDMI subsystem.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <drm/bridge/inno_hdmi.h>
> +#include <drm/drm_modes.h>
> +
> +/* dom_vout_syscon: HDMI pixel data mapping */
> +#define VOUT_SYSCFG_4			0x4
> +#define VOUT_HDMI_DP_BIT_DEPTH		BIT(25)
> +#define VOUT_HDMI_DP_YUV_MODE		GENMASK(27, 26)
> +#define VOUT_HDMI_DP_YUV_MODE_RGB	3
> +#define VOUT_HDMI_DPI_BIT_DEPTH		GENMASK(29, 28)
> +#define VOUT_HDMI_DPI_BIT_DEPTH_8BIT	0
> +#define VOUT_HDMI_DPI_DP_SEL		BIT(30)
> +
> +/* u2_display_panel_mux feeds HDMI_Ctrl, see the block diagram in 5.1 */
> +#define VOUT_SYSCFG_8			0x8
> +#define VOUT_HDMI_PANEL_SEL		BIT(4)
> +
> +enum stf_hdmi_ctrl_clocks { CLK_SYS = 0, CLK_M, CLK_B, CLK_PCLK, CLK_CTRL_NUM };
> +
> +struct stf_inno_hdmi_controller {
> +	struct device *dev;
> +	struct clk_bulk_data clks[CLK_CTRL_NUM];
> +	struct reset_control *tx_rst;
> +	struct phy *phy;
> +	bool enabled;
> +};
> +
> +static enum drm_mode_status
> +inno_hdmi_starfive_mode_valid(struct device *dev,
> +			      const struct drm_display_mode *mode)
> +{
> +	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
> +	unsigned long pixelclk = mode->clock * 1000;
> +	long rounded;
> +
> +	/*
> +	 * The PHY can only generate the discrete set of pixel clocks described
> +	 * by its pre-PLL table, and clk_round_rate() fails for anything else.
> +	 * Reject those modes here: without this the modeset would appear to
> +	 * succeed while the PHY never produces a signal.
> +	 */
> +	rounded = clk_round_rate(ctrl->clks[CLK_PCLK].clk, pixelclk);
> +	if (rounded < 0 || rounded != pixelclk)
> +		return MODE_NOCLOCK;
> +

Using "if (rounded != pixelclk)" would be ok.

> +	return MODE_OK;
> +}
> +
> +static void inno_hdmi_starfive_enable(struct device *dev,
> +				      struct drm_display_mode *mode)
> +{
> +	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/*
> +	 * 1. Set the pixel clock rate. This calls the PHY driver's .set_rate op.
> +	 */
> +	ret = clk_set_rate(ctrl->clks[CLK_PCLK].clk, mode->clock * 1000);
> +	if (ret) {
> +		dev_err(dev, "Failed to set pclk rate %d: %d\n",
> +			mode->clock * 1000, ret);
> +		return;
> +	}
> +
> +	/*
> +	 * 2. Enable the pixel clock. This calls the PHY driver's .prepare op.
> +	 */
> +	ret = clk_prepare_enable(ctrl->clks[CLK_PCLK].clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable pclk: %d\n", ret);
> +		return;
> +	}
> +
> +	/*
> +	 * 3. Power on the PHY. This calls the PHY driver's .power_on op,
> +	 * which configures the Post-PLL and analog blocks.
> +	 */
> +	ret = phy_power_on(ctrl->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on PHY: %d\n", ret);
> +		clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +		return;
> +	}
> +
> +	ctrl->enabled = true;
> +}
> +
> +static void inno_hdmi_starfive_disable(struct device *dev)
> +{
> +	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
> +
> +	/*
> +	 * .enable bails out early if the pixel clock rate is unsupported or
> +	 * the PHY fails to power on, leaving pclk and the PHY untouched.
> +	 * Only tear down what was actually brought up, otherwise the clock
> +	 * refcount underflows.
> +	 */
> +	if (!ctrl->enabled)
> +		return;
> +
> +	phy_power_off(ctrl->phy);
> +	clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +	ctrl->enabled = false;
> +}
> +
> +/*
> + * The DC8200 has two panels, each exposing a DP and a DPI interface, and a mux
> + * in dom_vout_syscon picks which of them drives the HDMI transmitter. Derive
> + * the mux setting from the port graph: the remote port number selects the
> + * DC8200 panel, and the remote endpoint number the interface on that panel
> + * (0 for DPI, 1 for DP). Both drive 8-bit RGB, the only format this driver
> + * currently produces.
> + */
> +static int stf_inno_hdmi_setup_mux(struct device *dev)
> +{
> +	struct device_node *ep, *remote;

Using "struct device_node *ep __free(device_node)" can help you simplify
the processing of resource release.

> +	struct of_endpoint endpoint;
> +	struct regmap *syscon;
> +	u32 mask, val;
> +	int ret;
> +
> +	syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						 "starfive,vout-syscon");
> +	if (IS_ERR(syscon))
> +		return dev_err_probe(dev, PTR_ERR(syscon),
> +				     "Failed to get vout syscon\n");
> +
> +	ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
> +	if (!ep)
> +		return dev_err_probe(dev, -ENODEV, "No input endpoint\n");
> +
> +	remote = of_graph_get_remote_endpoint(ep);
> +	of_node_put(ep);
> +	if (!remote)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Input endpoint is not connected\n");
> +
> +	ret = of_graph_parse_endpoint(remote, &endpoint);
> +	of_node_put(remote);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to parse the remote endpoint\n");
> +
> +	if (endpoint.port > 1 || endpoint.id > 1)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unsupported DC8200 output %u/%u\n",
> +				     endpoint.port, endpoint.id);
> +
> +	/* Data mapping: 8-bit RGB on whichever interface is in use. */
> +	mask = VOUT_HDMI_DPI_DP_SEL | VOUT_HDMI_DP_BIT_DEPTH |
> +	       VOUT_HDMI_DP_YUV_MODE | VOUT_HDMI_DPI_BIT_DEPTH;
> +	val = FIELD_PREP(VOUT_HDMI_DPI_DP_SEL, endpoint.id) |
> +	      FIELD_PREP(VOUT_HDMI_DP_YUV_MODE, VOUT_HDMI_DP_YUV_MODE_RGB) |
> +	      FIELD_PREP(VOUT_HDMI_DPI_BIT_DEPTH, VOUT_HDMI_DPI_BIT_DEPTH_8BIT);
> +
> +	ret = regmap_update_bits(syscon, VOUT_SYSCFG_4, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Which DC8200 panel drives the HDMI transmitter. */
> +	return regmap_update_bits(syscon, VOUT_SYSCFG_8, VOUT_HDMI_PANEL_SEL,
> +				  FIELD_PREP(VOUT_HDMI_PANEL_SEL,
> +					     endpoint.port));
> +}
> +
> +static void stf_inno_hdmi_clk_disable(void *data)
> +{
> +	struct stf_inno_hdmi_controller *ctrl = data;
> +
> +	clk_bulk_disable_unprepare(CLK_CTRL_NUM - 1, ctrl->clks);
> +}
> +
> +static void stf_inno_hdmi_rst_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int starfive_inno_hdmi_controller_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *parent = dev->parent;
> +	struct stf_inno_hdmi_controller *ctrl;
> +	const struct inno_hdmi_plat_data *plat_data;
> +	struct regmap *regmap;
> +	struct inno_hdmi *inno;
> +	int ret;
> +
> +	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->dev = dev;
> +	platform_set_drvdata(pdev, ctrl);
> +
> +	/* Get the shared regmap from the parent */
> +	regmap = dev_get_regmap(parent, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ctrl->phy = devm_phy_get(dev, NULL);
> +	if (IS_ERR(ctrl->phy))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->phy), "Failed to get PHY\n");
> +
> +	ctrl->tx_rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(ctrl->tx_rst))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->tx_rst), "failed to get tx reset\n");
> +
> +	/* Populate the clock names this controller *consumes* */
> +	ctrl->clks[CLK_SYS].id = "pclk";
> +	ctrl->clks[CLK_M].id = "mclk";
> +	ctrl->clks[CLK_B].id = "bclk";
> +	ctrl->clks[CLK_PCLK].id = "pixel"; /* Generated by the PHY */
> +
> +	ret = devm_clk_bulk_get(dev, CLK_CTRL_NUM, ctrl->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to get controller clocks\n");
> +
> +	/*
> +	 * Tear the clocks and the reset down through devm, so that they outlive
> +	 * everything registered after them. The bridge is added with
> +	 * devm_drm_bridge_add(), and unwinding in the wrong order would leave it
> +	 * registered while its clocks are already gated.
> +	 *
> +	 * The pixel clock is enabled on demand during modeset.
> +	 */
> +	ret = clk_bulk_prepare_enable(CLK_CTRL_NUM - 1, ctrl->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, stf_inno_hdmi_clk_disable, ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(ctrl->tx_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, stf_inno_hdmi_rst_assert,
> +				       ctrl->tx_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = stf_inno_hdmi_setup_mux(dev);
> +	if (ret)
> +		return ret;
> +
> +	plat_data = of_device_get_match_data(dev);
> +
> +	/* Hand off to the generic library to create the bridge. */
> +	inno = inno_hdmi_probe(pdev, plat_data);
> +	if (IS_ERR(inno))
> +		return PTR_ERR(inno);
> +
> +	return 0;
> +}
> +
> +/*
> + * This table is now only used for the generic .mode_valid check.
> + * The real validation happens in the PHY driver's .round_rate.
> + */
> +static struct inno_hdmi_phy_config stf_hdmi_phy_configs[] = {
> +	{ 297000000, 0x00, 0x00 },
> +	{ ~0UL, 0x00, 0x00 }, /* Sentinel */
> +};
> +
> +static const struct inno_hdmi_plat_ops stf_inno_hdmi_plat_ops = {
> +	.enable = inno_hdmi_starfive_enable,
> +	.disable = inno_hdmi_starfive_disable,
> +	.mode_valid = inno_hdmi_starfive_mode_valid,
> +};
> +
> +static const struct inno_hdmi_plat_data stf_inno_hdmi_plat_data = {
> +	.ops = &stf_inno_hdmi_plat_ops,
> +	.phy_configs = stf_hdmi_phy_configs,
> +	.default_phy_config = &stf_hdmi_phy_configs[0],
> +};
> +
> +static const struct of_device_id starfive_hdmi_controller_dt_ids[] = {
> +	{ .compatible = "starfive,jh7110-inno-hdmi-controller",
> +	  .data = &stf_inno_hdmi_plat_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, starfive_hdmi_controller_dt_ids);
> +
> +struct platform_driver starfive_inno_hdmi_controller_driver = {
> +	.probe = starfive_inno_hdmi_controller_probe,
> +	.driver = {
> +		.name = "starfive-inno-hdmi-controller",
> +		.of_match_table = starfive_hdmi_controller_dt_ids,
> +	},
> +};
> +module_platform_driver(starfive_inno_hdmi_controller_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("StarFive INNO HDMI Controller Driver");
> +MODULE_LICENSE("GPL");
> 

-- 
Best, 
Chaoyi
