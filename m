Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB148C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4850810E14D;
	Tue, 29 Sep 2026 15:03:54 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F98510E14D
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 15:03:52 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowAAHcz1B07tqcJGvCQ--.14055S2;
 Tue, 29 Sep 2026 23:03:31 +0800 (CST)
Message-ID: <1b797958f15737a23e8aa03fbf70d63167fb29fe.camel@iscas.ac.cn>
Subject: Re: [PATCH v4 15/20] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Vinod Koul
 <vkoul@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Andrzej Hajda	 <andrzej.hajda@intel.com>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>, Philipp Zabel	 <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng	
 <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi	 <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>, Jerome
 Brunet	 <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>, Chaoyi Chen	
 <chaoyi.chen@rock-chips.com>, Joshua Peisach <jpeisach@ubuntu.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>
Date: Tue, 29 Sep 2026 23:03:29 +0800
In-Reply-To: <20260915-jh7110-clean-send-v4-15-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153241eucas1p292a3312a0ca8aed99cc416c0e01c3b66@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-15-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowAAHcz1B07tqcJGvCQ--.14055S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr17KFW3tFykKFyxWr13twb_yoW8XryUKo
 Wftr13Zw4FyryfurWkC3W7CF1a9wsFyrs7Zay5trWDCa4jvr4ag34UtrZ8ua4xXF1SkryD
 Aw18JryfAFWIya4fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYh7k0a2IF6w4kM7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
 1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0
 I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
 0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
 evJa73UjIFyTuYvjxU9SoXUUUUU
X-Originating-IP: [112.94.101.54]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-09-15=E4=BA=8C=E7=9A=84 17:32 +0200=EF=BC=8CMichal Wilczynsk=
i=E5=86=99=E9=81=93=EF=BC=9A
> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>=20
> This driver binds to the starfive,jh7110-inno-hdmi-controller node.
> It
> gets its register access, module and bus clocks from voutcrg, and
> consumes the pixel clock and the PHY from its hdmi_phy sibling.
>=20
> The driver calls the generic inno_hdmi_probe function, which picks up
> the regmap shared with the PHY from the parent device and registers a
> DRM bridge. The .enable hook is responsible for setting the PHY's
> pixel
> clock rate via clk_set_rate() and powering on the PHY via
> phy_power_on().
>=20
> The DC8200 has two panels, each exposing a DP and a DPI interface,
> and a
> mux in the video output system controller picks which of them drives
> the
> HDMI transmitter. It comes out of reset on panel 0 / DPI, which
> happens
> to be what the default wiring needs, so nothing has had to program it
> so
> far. Derive it from the port graph instead, taking the panel from the
> remote port number and the interface from the remote endpoint number,
> so
> that a board describing a different output is honoured.
>=20
> The generic driver holds the clock it looks up as the register access
> clock enabled for its lifetime, and derives the DDC divider from that
> clock's rate, so point it at the system clock. Naming the pixel clock
> there instead would keep the PHY pre-PLL powered from probe onwards
> and
> size the divider from the wrong rate.
>=20
> The PHY can only generate the discrete set of pixel clocks described
> by
> its pre-PLL table, so .mode_valid rejects any mode clk_round_rate()
> cannot satisfy. Without it such a mode would be advertised to
> userspace
> and the modeset would appear to succeed while the display stayed
> blank.
>=20
> .enable returns early when the rate is unsupported or the PHY fails
> to
> power on, so track whether the pixel clock was actually enabled and
> let
> .disable tear down only what was brought up, otherwise the clock
> refcount underflows.
>=20
> The clocks and the reset are torn down through devm rather than from
> .remove, so that they outlive the bridge that inno_hdmi_probe() adds
> with
> devm_drm_bridge_add(). Releasing them in .remove runs before devres
> unwinds and would leave the bridge registered with its clocks already
> gated.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

```
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

> ---
> =C2=A0drivers/gpu/drm/bridge/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
> =C2=A0drivers/gpu/drm/bridge/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 297
> ++++++++++++++++++++++++++++++
> =C2=A03 files changed, 309 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/Kconfig
> b/drivers/gpu/drm/bridge/Kconfig
> index
> 4a57d49b4c6d3ab4b965228835b372d191647197..75b1cf6727d5a32310dcf9fe573
> 4d95e14eea8fe 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -359,6 +359,17 @@ config DRM_SOLOMON_SSD2825
> =C2=A0	=C2=A0 Say M here if you want to support this hardware as a
> module.
> =C2=A0	=C2=A0 The module will be named "ssd2825".
> =C2=A0
> +config DRM_STARFIVE_JH7110_INNO_HDMI
> +	tristate "Starfive JH7110 Innosilicon HDMI bridge"
> +	depends on OF
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	select DRM_INNO_HDMI
> +	help
> +	=C2=A0 Enable support for the StarFive JH7110 specific
> implementation
> +	=C2=A0 of the Innosilicon HDMI controller.
> +	=C2=A0 This driver acts as a glue layer between the JH7110 HDMI
> subsystem
> +	=C2=A0 parent driver and the generic Innosilicon HDMI bridge
> driver.
> +
> =C2=A0config DRM_THINE_THC63LVD1024
> =C2=A0	tristate "Thine THC63LVD1024 LVDS decoder bridge"
> =C2=A0	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile
> b/drivers/gpu/drm/bridge/Makefile
> index
> 15cc821d85b7ea6f3cdc313f3e521b028de567d7..5d843f4ad7ed50b28cb75286c5e
> 22789d91a0836 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) +=3D sil-sii8620.o
> =C2=A0obj-$(CONFIG_DRM_SII902X) +=3D sii902x.o
> =C2=A0obj-$(CONFIG_DRM_SII9234) +=3D sii9234.o
> =C2=A0obj-$(CONFIG_DRM_SIMPLE_BRIDGE) +=3D simple-bridge.o
> +obj-$(CONFIG_DRM_STARFIVE_JH7110_INNO_HDMI) +=3D jh7110-inno-hdmi.o
> =C2=A0obj-$(CONFIG_DRM_SOLOMON_SSD2825) +=3D ssd2825.o
> =C2=A0obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) +=3D th1520-dw-hdmi.o
> =C2=A0obj-$(CONFIG_DRM_THINE_THC63LVD1024) +=3D thc63lvd1024.o
> diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..e9b91787330d7b65558868017bc
> 36ca8f4535998
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) StarFive Technology Co., Ltd.
> + * Copyright (c) 2025 Samsung Electronics Co., Ltd.
> + * Author: Michal Wilczynski <m.wilczynski@samsung.com>
> + *
> + * HDMI controller (bridge) driver for the StarFive JH7110 HDMI
> subsystem.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
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
> +/* u2_display_panel_mux feeds HDMI_Ctrl, see the block diagram in
> 5.1 */
> +#define VOUT_SYSCFG_8			0x8
> +#define VOUT_HDMI_PANEL_SEL		BIT(4)
> +
> +enum stf_hdmi_ctrl_clocks { CLK_SYS =3D 0, CLK_M, CLK_B, CLK_PCLK,
> CLK_CTRL_NUM };
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
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_display_mode *mode)
> +{
> +	struct stf_inno_hdmi_controller *ctrl =3D
> dev_get_drvdata(dev);
> +	unsigned long pixelclk =3D mode->clock * 1000;
> +	long rounded;
> +
> +	/*
> +	 * The PHY can only generate the discrete set of pixel
> clocks described
> +	 * by its pre-PLL table, and clk_round_rate() fails for
> anything else.
> +	 * Reject those modes here: without this the modeset would
> appear to
> +	 * succeed while the PHY never produces a signal.
> +	 */
> +	rounded =3D clk_round_rate(ctrl->clks[CLK_PCLK].clk,
> pixelclk);
> +	if (rounded !=3D pixelclk)
> +		return MODE_NOCLOCK;
> +
> +	return MODE_OK;
> +}
> +
> +static void inno_hdmi_starfive_enable(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_display_mode *mode)
> +{
> +	struct stf_inno_hdmi_controller *ctrl =3D
> dev_get_drvdata(dev);
> +	int ret;
> +
> +	/*
> +	 * 1. Set the pixel clock rate. This calls the PHY driver's
> .set_rate op.
> +	 */
> +	ret =3D clk_set_rate(ctrl->clks[CLK_PCLK].clk, mode->clock *
> 1000);
> +	if (ret) {
> +		dev_err(dev, "Failed to set pclk rate %d: %d\n",
> +			mode->clock * 1000, ret);
> +		return;
> +	}
> +
> +	/*
> +	 * 2. Enable the pixel clock. This calls the PHY driver's
> .prepare op.
> +	 */
> +	ret =3D clk_prepare_enable(ctrl->clks[CLK_PCLK].clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable pclk: %d\n", ret);
> +		return;
> +	}
> +
> +	/*
> +	 * 3. Power on the PHY. This calls the PHY driver's
> .power_on op,
> +	 * which configures the Post-PLL and analog blocks.
> +	 */
> +	ret =3D phy_power_on(ctrl->phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to power on PHY: %d\n", ret);
> +		clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +		return;
> +	}
> +
> +	ctrl->enabled =3D true;
> +}
> +
> +static void inno_hdmi_starfive_disable(struct device *dev)
> +{
> +	struct stf_inno_hdmi_controller *ctrl =3D
> dev_get_drvdata(dev);
> +
> +	/*
> +	 * .enable bails out early if the pixel clock rate is
> unsupported or
> +	 * the PHY fails to power on, leaving pclk and the PHY
> untouched.
> +	 * Only tear down what was actually brought up, otherwise
> the clock
> +	 * refcount underflows.
> +	 */
> +	if (!ctrl->enabled)
> +		return;
> +
> +	phy_power_off(ctrl->phy);
> +	clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
> +	ctrl->enabled =3D false;
> +}
> +
> +/*
> + * The DC8200 has two panels, each exposing a DP and a DPI
> interface, and a mux
> + * in dom_vout_syscon picks which of them drives the HDMI
> transmitter. Derive
> + * the mux setting from the port graph: the remote port number
> selects the
> + * DC8200 panel, and the remote endpoint number the interface on
> that panel
> + * (0 for DPI, 1 for DP). Both drive 8-bit RGB, the only format this
> driver
> + * currently produces.
> + */
> +static int stf_inno_hdmi_setup_mux(struct device *dev)
> +{
> +	struct of_endpoint endpoint;
> +	struct regmap *syscon;
> +	u32 mask, val;
> +	int ret;
> +
> +	syscon =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> +						 "starfive,vout-
> syscon");
> +	if (IS_ERR(syscon))
> +		return dev_err_probe(dev, PTR_ERR(syscon),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get vout syscon\n");
> +
> +	struct device_node *ep __free(device_node) =3D
> +		of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
> +	if (!ep)
> +		return dev_err_probe(dev, -ENODEV, "No input
> endpoint\n");
> +
> +	struct device_node *remote __free(device_node) =3D
> +		of_graph_get_remote_endpoint(ep);
> +	if (!remote)
> +		return dev_err_probe(dev, -ENODEV,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Input endpoint is not
> connected\n");
> +
> +	ret =3D of_graph_parse_endpoint(remote, &endpoint);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to parse the remote
> endpoint\n");
> +
> +	if (endpoint.port > 1 || endpoint.id > 1)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Unsupported DC8200 output
> %u/%u\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 endpoint.port, endpoint.id);
> +
> +	/* Data mapping: 8-bit RGB on whichever interface is in use.
> */
> +	mask =3D VOUT_HDMI_DPI_DP_SEL | VOUT_HDMI_DP_BIT_DEPTH |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VOUT_HDMI_DP_YUV_MODE | VOUT_HDMI_=
DPI_BIT_DEPTH;
> +	val =3D FIELD_PREP(VOUT_HDMI_DPI_DP_SEL, endpoint.id) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(VOUT_HDMI_DP_YUV_MODE,
> VOUT_HDMI_DP_YUV_MODE_RGB) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(VOUT_HDMI_DPI_BIT_DEPTH,
> VOUT_HDMI_DPI_BIT_DEPTH_8BIT);
> +
> +	ret =3D regmap_update_bits(syscon, VOUT_SYSCFG_4, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Which DC8200 panel drives the HDMI transmitter. */
> +	return regmap_update_bits(syscon, VOUT_SYSCFG_8,
> VOUT_HDMI_PANEL_SEL,
> +				=C2=A0 FIELD_PREP(VOUT_HDMI_PANEL_SEL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 endpoint.port));
> +}
> +
> +static void stf_inno_hdmi_clk_disable(void *data)
> +{
> +	struct stf_inno_hdmi_controller *ctrl =3D data;
> +
> +	clk_bulk_disable_unprepare(CLK_CTRL_NUM - 1, ctrl->clks);
> +}
> +
> +static void stf_inno_hdmi_rst_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
> +static int starfive_inno_hdmi_controller_probe(struct
> platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct stf_inno_hdmi_controller *ctrl;
> +	const struct inno_hdmi_plat_data *plat_data;
> +	struct inno_hdmi *inno;
> +	int ret;
> +
> +	ctrl =3D devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->dev =3D dev;
> +	platform_set_drvdata(pdev, ctrl);
> +
> +	ctrl->phy =3D devm_phy_get(dev, NULL);
> +	if (IS_ERR(ctrl->phy))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->phy),
> "Failed to get PHY\n");
> +
> +	ctrl->tx_rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(ctrl->tx_rst))
> +		return dev_err_probe(dev, PTR_ERR(ctrl->tx_rst),
> "failed to get tx reset\n");
> +
> +	/* Populate the clock names this controller *consumes* */
> +	ctrl->clks[CLK_SYS].id =3D "pclk";
> +	ctrl->clks[CLK_M].id =3D "mclk";
> +	ctrl->clks[CLK_B].id =3D "bclk";
> +	ctrl->clks[CLK_PCLK].id =3D "pixel"; /* Generated by the PHY
> */
> +
> +	ret =3D devm_clk_bulk_get(dev, CLK_CTRL_NUM, ctrl->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to get
> controller clocks\n");
> +
> +	/*
> +	 * Tear the clocks and the reset down through devm, so that
> they outlive
> +	 * everything registered after them. The bridge is added
> with
> +	 * devm_drm_bridge_add(), and unwinding in the wrong order
> would leave it
> +	 * registered while its clocks are already gated.
> +	 *
> +	 * The pixel clock is enabled on demand during modeset.
> +	 */
> +	ret =3D clk_bulk_prepare_enable(CLK_CTRL_NUM - 1, ctrl->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev,
> stf_inno_hdmi_clk_disable, ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D reset_control_deassert(ctrl->tx_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev,
> stf_inno_hdmi_rst_assert,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->tx_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D stf_inno_hdmi_setup_mux(dev);
> +	if (ret)
> +		return ret;
> +
> +	plat_data =3D of_device_get_match_data(dev);
> +
> +	/* Hand off to the generic library to create the bridge. */
> +	inno =3D inno_hdmi_probe(pdev, plat_data);
> +	if (IS_ERR(inno))
> +		return PTR_ERR(inno);
> +
> +	return 0;
> +}
> +
> +static const struct inno_hdmi_plat_ops stf_inno_hdmi_plat_ops =3D {
> +	.enable =3D inno_hdmi_starfive_enable,
> +	.disable =3D inno_hdmi_starfive_disable,
> +	.mode_valid =3D inno_hdmi_starfive_mode_valid,
> +};
> +
> +static const struct inno_hdmi_plat_data stf_inno_hdmi_plat_data =3D {
> +	.ops =3D &stf_inno_hdmi_plat_ops,
> +};
> +
> +static const struct of_device_id starfive_hdmi_controller_dt_ids[] =3D
> {
> +	{ .compatible =3D "starfive,jh7110-inno-hdmi-controller",
> +	=C2=A0 .data =3D &stf_inno_hdmi_plat_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, starfive_hdmi_controller_dt_ids);
> +
> +struct platform_driver starfive_inno_hdmi_controller_driver =3D {
> +	.probe =3D starfive_inno_hdmi_controller_probe,
> +	.driver =3D {
> +		.name =3D "starfive-inno-hdmi-controller",
> +		.of_match_table =3D starfive_hdmi_controller_dt_ids,
> +	},
> +};
> +module_platform_driver(starfive_inno_hdmi_controller_driver);
> +
> +MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
> +MODULE_DESCRIPTION("StarFive INNO HDMI Controller Driver");
> +MODULE_LICENSE("GPL");

