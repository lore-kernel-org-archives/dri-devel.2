Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F67CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279DC10E9C5;
	Tue, 29 Sep 2026 10:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="rEowA+GO";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4A10EE1B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:32:40 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260929103239euoutp01634eac477ee950d6fa7e6a385c72b7f7~ZxB3jNEKp2203422034euoutp01A;
 Tue, 29 Sep 2026 10:32:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260929103239euoutp01634eac477ee950d6fa7e6a385c72b7f7~ZxB3jNEKp2203422034euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790677959;
 bh=xwy7xZt7XiFv4YtvaqukPCyvwRR3Lsa/WDYXyo4bZHg=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=rEowA+GOVHvYJr81sxs7GVADVGlCLZQ69SV5vDlZSgq8Lk8Sr0A4edo4cJ9H1bo9D
 4o7zETe2rTXd4LsL290mGAw4PloEXUHxSTXQZGoSedTE6nVAUK3vyFKuyxnC4M4i/F
 az34hqLKXbOYYKELeVKHTI87UIPfBFo9lsKBnK0o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260929103239eucas1p1247f818ec4a8480b353ecf6209486753~ZxB3N6XbB1238312383eucas1p1A;
 Tue, 29 Sep 2026 10:32:39 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260929103237eusmtip1be0f20089ac4017ff3fe9f31a52e66cc~ZxB1iZWO20258202582eusmtip1-;
 Tue, 29 Sep 2026 10:32:37 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 29 Sep 2026 12:31:13 +0200
Subject: [PATCH v5 16/21] drm/bridge: starfive: Add JH7110 HDMI controller
 driver
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-jh7110-clean-send-v5-16-82b4d8e3c6c7@samsung.com>
In-Reply-To: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,  Robert Foss
 <rfoss@kernel.org>,  Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Andy Yan
 <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,  Emil
 Renner Berthing <kernel@esmil.dk>,  Hal Feng <hal.feng@starfivetech.com>, 
 Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260929103239eucas1p1247f818ec4a8480b353ecf6209486753
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260929103239eucas1p1247f818ec4a8480b353ecf6209486753
X-EPHeader: CA
X-CMS-RootMailID: 20260929103239eucas1p1247f818ec4a8480b353ecf6209486753
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103239eucas1p1247f818ec4a8480b353ecf6209486753@eucas1p1.samsung.com>
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

Add the HDMI controller (bridge) driver for the StarFive JH7110.

This driver binds to the starfive,jh7110-inno-hdmi-controller node. It
gets its register access, module and bus clocks from voutcrg, and
consumes the pixel clock and the PHY from its hdmi_phy sibling.

The driver calls the generic inno_hdmi_probe function, which picks up
the regmap shared with the PHY from the parent device and registers a
DRM bridge. The .enable hook is responsible for setting the PHY's pixel
clock rate via clk_set_rate() and powering on the PHY via
phy_power_on().

The DC8200 has two panels, each exposing a DP and a DPI interface, and a
mux in the video output system controller picks which of them drives the
HDMI transmitter. It comes out of reset on panel 0 / DPI, which happens
to be what the default wiring needs, so nothing has had to program it so
far. Derive it from the port graph instead, taking the panel from the
remote port number and the interface from the remote endpoint number, so
that a board describing a different output is honoured.

The generic driver holds the clock it looks up as the register access
clock enabled for its lifetime, and derives the DDC divider from that
clock's rate, so point it at the system clock. Naming the pixel clock
there instead would keep the PHY pre-PLL powered from probe onwards and
size the divider from the wrong rate.

The PHY can only generate the discrete set of pixel clocks described by
its pre-PLL table, so .mode_valid rejects any mode clk_round_rate()
cannot satisfy. Without it such a mode would be advertised to userspace
and the modeset would appear to succeed while the display stayed blank.

.enable returns early when the rate is unsupported or the PHY fails to
power on, so track whether the pixel clock was actually enabled and let
.disable tear down only what was brought up, otherwise the clock
refcount underflows.

The clocks and the reset are torn down through devm rather than from
.remove, so that they outlive the bridge that inno_hdmi_probe() adds with
devm_drm_bridge_add(). Releasing them in .remove runs before devres
unwinds and would leave the bridge registered with its clocks already
gated.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/Kconfig            |  11 ++
 drivers/gpu/drm/bridge/Makefile           |   1 +
 drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 298 ++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 4a57d49b4c6d3ab4b965228835b372d191647197..75b1cf6727d5a32310dcf9fe5734d95e14eea8fe 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -359,6 +359,17 @@ config DRM_SOLOMON_SSD2825
 	  Say M here if you want to support this hardware as a module.
 	  The module will be named "ssd2825".
 
+config DRM_STARFIVE_JH7110_INNO_HDMI
+	tristate "Starfive JH7110 Innosilicon HDMI bridge"
+	depends on OF
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	select DRM_INNO_HDMI
+	help
+	  Enable support for the StarFive JH7110 specific implementation
+	  of the Innosilicon HDMI controller.
+	  This driver acts as a glue layer between the JH7110 HDMI subsystem
+	  parent driver and the generic Innosilicon HDMI bridge driver.
+
 config DRM_THINE_THC63LVD1024
 	tristate "Thine THC63LVD1024 LVDS decoder bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7ea6f3cdc313f3e521b028de567d7..5d843f4ad7ed50b28cb75286c5e22789d91a0836 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
 obj-$(CONFIG_DRM_SII9234) += sii9234.o
 obj-$(CONFIG_DRM_SIMPLE_BRIDGE) += simple-bridge.o
+obj-$(CONFIG_DRM_STARFIVE_JH7110_INNO_HDMI) += jh7110-inno-hdmi.o
 obj-$(CONFIG_DRM_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_DRM_THEAD_TH1520_DW_HDMI) += th1520-dw-hdmi.o
 obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
diff --git a/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..fc57e1671bc799d6cd0e07b32412d8933fa19689
--- /dev/null
+++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) StarFive Technology Co., Ltd.
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * HDMI controller (bridge) driver for the StarFive JH7110 HDMI subsystem.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <drm/bridge/inno_hdmi.h>
+#include <drm/drm_modes.h>
+
+/* dom_vout_syscon: HDMI pixel data mapping */
+#define VOUT_SYSCFG_4			0x4
+#define VOUT_HDMI_DP_BIT_DEPTH		BIT(25)
+#define VOUT_HDMI_DP_YUV_MODE		GENMASK(27, 26)
+#define VOUT_HDMI_DP_YUV_MODE_RGB	3
+#define VOUT_HDMI_DPI_BIT_DEPTH		GENMASK(29, 28)
+#define VOUT_HDMI_DPI_BIT_DEPTH_8BIT	0
+#define VOUT_HDMI_DPI_DP_SEL		BIT(30)
+
+/* u2_display_panel_mux feeds HDMI_Ctrl, see the block diagram in 5.1 */
+#define VOUT_SYSCFG_8			0x8
+#define VOUT_HDMI_PANEL_SEL		BIT(4)
+
+enum stf_hdmi_ctrl_clocks { CLK_SYS = 0, CLK_M, CLK_B, CLK_PCLK, CLK_CTRL_NUM };
+
+struct stf_inno_hdmi_controller {
+	struct device *dev;
+	struct clk_bulk_data clks[CLK_CTRL_NUM];
+	struct reset_control *tx_rst;
+	struct phy *phy;
+	bool enabled;
+};
+
+static enum drm_mode_status
+inno_hdmi_starfive_mode_valid(struct device *dev,
+			      const struct drm_display_mode *mode)
+{
+	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
+	unsigned long pixelclk = mode->clock * 1000;
+	long rounded;
+
+	/*
+	 * The PHY can only generate the discrete set of pixel clocks described
+	 * by its pre-PLL table, and clk_round_rate() fails for anything else.
+	 * Reject those modes here: without this the modeset would appear to
+	 * succeed while the PHY never produces a signal.
+	 */
+	rounded = clk_round_rate(ctrl->clks[CLK_PCLK].clk, pixelclk);
+	if (rounded != pixelclk)
+		return MODE_NOCLOCK;
+
+	return MODE_OK;
+}
+
+static void inno_hdmi_starfive_enable(struct device *dev,
+				      struct drm_display_mode *mode)
+{
+	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * 1. Set the pixel clock rate. This calls the PHY driver's .set_rate op.
+	 */
+	ret = clk_set_rate(ctrl->clks[CLK_PCLK].clk, mode->clock * 1000);
+	if (ret) {
+		dev_err(dev, "Failed to set pclk rate %d: %d\n",
+			mode->clock * 1000, ret);
+		return;
+	}
+
+	/*
+	 * 2. Enable the pixel clock. This calls the PHY driver's .prepare op.
+	 */
+	ret = clk_prepare_enable(ctrl->clks[CLK_PCLK].clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable pclk: %d\n", ret);
+		return;
+	}
+
+	/*
+	 * 3. Power on the PHY. This calls the PHY driver's .power_on op,
+	 * which configures the Post-PLL and analog blocks.
+	 */
+	ret = phy_power_on(ctrl->phy);
+	if (ret) {
+		dev_err(dev, "Failed to power on PHY: %d\n", ret);
+		clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
+		return;
+	}
+
+	ctrl->enabled = true;
+}
+
+static void inno_hdmi_starfive_disable(struct device *dev)
+{
+	struct stf_inno_hdmi_controller *ctrl = dev_get_drvdata(dev);
+
+	/*
+	 * .enable bails out early if the pixel clock rate is unsupported or
+	 * the PHY fails to power on, leaving pclk and the PHY untouched.
+	 * Only tear down what was actually brought up, otherwise the clock
+	 * refcount underflows.
+	 */
+	if (!ctrl->enabled)
+		return;
+
+	phy_power_off(ctrl->phy);
+	clk_disable_unprepare(ctrl->clks[CLK_PCLK].clk);
+	ctrl->enabled = false;
+}
+
+/*
+ * The DC8200 has two panels, each exposing a DP and a DPI interface, and a mux
+ * in dom_vout_syscon picks which of them drives the HDMI transmitter. Derive
+ * the mux setting from the port graph: the remote port number selects the
+ * DC8200 panel, and the remote endpoint number the interface on that panel
+ * (0 for DPI, 1 for DP). Both drive 8-bit RGB, the only format this driver
+ * currently produces.
+ */
+static int stf_inno_hdmi_setup_mux(struct device *dev)
+{
+	struct of_endpoint endpoint;
+	struct regmap *syscon;
+	u32 mask, val;
+	int ret;
+
+	syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
+						 "starfive,vout-syscon");
+	if (IS_ERR(syscon))
+		return dev_err_probe(dev, PTR_ERR(syscon),
+				     "Failed to get vout syscon\n");
+
+	struct device_node *ep __free(device_node) =
+		of_graph_get_endpoint_by_regs(dev->of_node, 0, -1);
+	if (!ep)
+		return dev_err_probe(dev, -ENODEV, "No input endpoint\n");
+
+	struct device_node *remote __free(device_node) =
+		of_graph_get_remote_endpoint(ep);
+	if (!remote)
+		return dev_err_probe(dev, -ENODEV,
+				     "Input endpoint is not connected\n");
+
+	ret = of_graph_parse_endpoint(remote, &endpoint);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to parse the remote endpoint\n");
+
+	if (endpoint.port > 1 || endpoint.id > 1)
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported DC8200 output %u/%u\n",
+				     endpoint.port, endpoint.id);
+
+	/* Data mapping: 8-bit RGB on whichever interface is in use. */
+	mask = VOUT_HDMI_DPI_DP_SEL | VOUT_HDMI_DP_BIT_DEPTH |
+	       VOUT_HDMI_DP_YUV_MODE | VOUT_HDMI_DPI_BIT_DEPTH;
+	val = FIELD_PREP(VOUT_HDMI_DPI_DP_SEL, endpoint.id) |
+	      FIELD_PREP(VOUT_HDMI_DP_YUV_MODE, VOUT_HDMI_DP_YUV_MODE_RGB) |
+	      FIELD_PREP(VOUT_HDMI_DPI_BIT_DEPTH, VOUT_HDMI_DPI_BIT_DEPTH_8BIT);
+
+	ret = regmap_update_bits(syscon, VOUT_SYSCFG_4, mask, val);
+	if (ret)
+		return ret;
+
+	/* Which DC8200 panel drives the HDMI transmitter. */
+	return regmap_update_bits(syscon, VOUT_SYSCFG_8, VOUT_HDMI_PANEL_SEL,
+				  FIELD_PREP(VOUT_HDMI_PANEL_SEL,
+					     endpoint.port));
+}
+
+static void stf_inno_hdmi_clk_disable(void *data)
+{
+	struct stf_inno_hdmi_controller *ctrl = data;
+
+	clk_bulk_disable_unprepare(CLK_CTRL_NUM - 1, ctrl->clks);
+}
+
+static void stf_inno_hdmi_rst_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static int starfive_inno_hdmi_controller_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stf_inno_hdmi_controller *ctrl;
+	const struct inno_hdmi_plat_data *plat_data;
+	struct inno_hdmi *inno;
+	int ret;
+
+	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->dev = dev;
+	platform_set_drvdata(pdev, ctrl);
+
+	ctrl->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(ctrl->phy))
+		return dev_err_probe(dev, PTR_ERR(ctrl->phy), "Failed to get PHY\n");
+
+	ctrl->tx_rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(ctrl->tx_rst))
+		return dev_err_probe(dev, PTR_ERR(ctrl->tx_rst), "failed to get tx reset\n");
+
+	/* Populate the clock names this controller *consumes* */
+	ctrl->clks[CLK_SYS].id = "pclk";
+	ctrl->clks[CLK_M].id = "mclk";
+	ctrl->clks[CLK_B].id = "bclk";
+	ctrl->clks[CLK_PCLK].id = "pixel"; /* Generated by the PHY */
+
+	ret = devm_clk_bulk_get(dev, CLK_CTRL_NUM, ctrl->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to get controller clocks\n");
+
+	/*
+	 * Tear the clocks and the reset down through devm, so that they outlive
+	 * everything registered after them. The bridge is added with
+	 * devm_drm_bridge_add(), and unwinding in the wrong order would leave it
+	 * registered while its clocks are already gated.
+	 *
+	 * The pixel clock is enabled on demand during modeset.
+	 */
+	ret = clk_bulk_prepare_enable(CLK_CTRL_NUM - 1, ctrl->clks);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, stf_inno_hdmi_clk_disable, ctrl);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(ctrl->tx_rst);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, stf_inno_hdmi_rst_assert,
+				       ctrl->tx_rst);
+	if (ret)
+		return ret;
+
+	ret = stf_inno_hdmi_setup_mux(dev);
+	if (ret)
+		return ret;
+
+	plat_data = of_device_get_match_data(dev);
+
+	/* Hand off to the generic library to create the bridge. */
+	inno = inno_hdmi_probe(pdev, plat_data);
+	if (IS_ERR(inno))
+		return PTR_ERR(inno);
+
+	return 0;
+}
+
+static const struct inno_hdmi_plat_ops stf_inno_hdmi_plat_ops = {
+	.enable = inno_hdmi_starfive_enable,
+	.disable = inno_hdmi_starfive_disable,
+	.mode_valid = inno_hdmi_starfive_mode_valid,
+};
+
+static const struct inno_hdmi_plat_data stf_inno_hdmi_plat_data = {
+	.ops = &stf_inno_hdmi_plat_ops,
+	.reg_clk_source_tmds = true,
+};
+
+static const struct of_device_id starfive_hdmi_controller_dt_ids[] = {
+	{ .compatible = "starfive,jh7110-inno-hdmi-controller",
+	  .data = &stf_inno_hdmi_plat_data },
+	{}
+};
+MODULE_DEVICE_TABLE(of, starfive_hdmi_controller_dt_ids);
+
+struct platform_driver starfive_inno_hdmi_controller_driver = {
+	.probe = starfive_inno_hdmi_controller_probe,
+	.driver = {
+		.name = "starfive-inno-hdmi-controller",
+		.of_match_table = starfive_hdmi_controller_dt_ids,
+	},
+};
+module_platform_driver(starfive_inno_hdmi_controller_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("StarFive INNO HDMI Controller Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

