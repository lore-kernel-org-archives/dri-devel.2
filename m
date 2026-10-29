Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58483606A326
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Hr3a2AqE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E82510E7AF;
	Thu, 29 Oct 2026 07:55:00 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4D110E7AF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:54:23 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075422euoutp02e1e5b9b054fef0aefbdcedd1417e5ad0~i8OO3TE7F1781617816euoutp02O;
 Thu, 29 Oct 2026 07:54:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261029075422euoutp02e1e5b9b054fef0aefbdcedd1417e5ad0~i8OO3TE7F1781617816euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260462;
 bh=k4cOqLovRmJqKagepyp8ZgRN6tZnFLUdOpoMyslsfxk=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Hr3a2AqEuloE6mkXTz/a0H3FLpbVWKUtW0xc8h5Eo6/kfE/Es1JqFF2ebnHXEy/WM
 4wE3rntszwhjM9MZ95AZy2x7LbgLxDPKsD7CvUDgD1OU+AC8F1wofZtp0AKvmmMoWb
 anRG95U4DPdBV0s4Gvg6phV1Lwpzy5U17T7UnHb0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029075422eucas1p29cc276f51f970ddf96a524716c7aaf37~i8OOg2Wkw1289212892eucas1p2L;
 Thu, 29 Oct 2026 07:54:22 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075420eusmtip1027071de37e7e274de335af581b99089~i8OMqiAX31410414104eusmtip15;
 Thu, 29 Oct 2026 07:54:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:50 +0100
Subject: [PATCH v6 16/18] drm/bridge: starfive: Add JH7110 HDMI controller
 driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-16-759594e43acf@samsung.com>
In-Reply-To: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13954;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=VfW6bgU60v/oKVecOSY+jw1vmiCFRcA0PtgSDEz7OBg=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t2zUsThbw6zudp7vv+3oqNnpiw/2fBigWGU170fN
 pLRrZGzO0pZGMQ4GGTFFFnObow2kvzH8LT8+ONfMHNYmUCGMHBxCsBEOOoY/srIhfP9LjybI/j/
 e0P11zXBB11UOv9eO5904n2w6hFlS1ZGhltTcn8/KXA7HxnX6tl3z8Nrw3NF/Rm/Zym8XfH65pb
 3LTwA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075422eucas1p29cc276f51f970ddf96a524716c7aaf37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075422eucas1p29cc276f51f970ddf96a524716c7aaf37
X-EPHeader: CA
X-CMS-RootMailID: 20261029075422eucas1p29cc276f51f970ddf96a524716c7aaf37
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075422eucas1p29cc276f51f970ddf96a524716c7aaf37@eucas1p2.samsung.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/Kconfig            |  11 ++
 drivers/gpu/drm/bridge/Makefile           |   1 +
 drivers/gpu/drm/bridge/jh7110-inno-hdmi.c | 296 ++++++++++++++++++++++++++++++
 3 files changed, 308 insertions(+)

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
index 0000000000000000000000000000000000000000..3ce0add73c40a75fcfeb3f542713f6f8eae513e9
--- /dev/null
+++ b/drivers/gpu/drm/bridge/jh7110-inno-hdmi.c
@@ -0,0 +1,296 @@
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
+static struct platform_driver starfive_inno_hdmi_controller_driver = {
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

