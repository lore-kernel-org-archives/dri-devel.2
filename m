Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE93CCCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B747510E9AE;
	Mon, 19 Oct 2026 10:29:05 +0000 (UTC)
Received: from mail-m81245.netease.com (mail-m81245.netease.com [47.88.81.245])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414EA10E9AE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:28:50 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 518d3dda8;
 Mon, 19 Oct 2026 18:28:46 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 4/6] phy: rockchip: Add support for Naneng eDP phy
Date: Mon, 19 Oct 2026 18:28:22 +0800
Message-Id: <20261019102824.3157044-5-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019102824.3157044-1-damon.ding@rock-chips.com>
References: <20261019102824.3157044-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa153b4e66603a8kunme348c01b2f6c43
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkoaVk9IHhpOSEpCTRoeHVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=AXhExzwBLZCjQG2BmqEzKsn9ALSLIPDe6XrcdQzzBZgMitn+EBRRVruEdNyzk6g/QXEEPjr0kToY4Pf6BC3uzvCCqcs9ug1ed36aBdxfTJND0omL7oq8xl1SrNB20TPvCj6sznD+B8BuMQj9QTf23Ge0mdkXPwj/k2zkhXzqHs8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=vk3PW4DcSf72F77XHoEWhmXqK5nS4XB94754EhO18YA=;
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

Add a driver for the Rockchip eDP transmitter PHY with NaNeng IP
block, as found on the RK3568 SoC.

The PHY registers live in the eDP PHY GRF, of which the PHY is a
child node, so accesses are performed through the parent syscon
regmap. The PHY supports 1/2/4 lanes at 1.62 Gbps and 2.7 Gbps,
optional spread spectrum clocking, as well as per-lane voltage swing
and pre-emphasis tuning, all exposed through the generic PHY
DisplayPort configuration interface.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v2:
- Apply the lane-dependent TX configurations in set_lanes() instead of
  set_rate(), and store the lane count for set_voltages(), since the
  Analogix DP core issues separate phy_configure() calls and the lane
  count is only valid in the set_lanes/set_voltages calls.(Sashiko)
- Initialize val to zero in rockchip_edp_phy_enabled() to avoid using
  an uninitialized variable when regmap_read() fails.(Sashiko)
---
 drivers/phy/rockchip/Kconfig                  |  10 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-naneng-edp.c    | 435 ++++++++++++++++++
 3 files changed, 446 insertions(+)
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-edp.c

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 14698571b607..202a6973e20b 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -74,6 +74,16 @@ config PHY_ROCKCHIP_NANENG_COMBO_PHY
 	  Enable this to support the Rockchip PCIe/USB3.0/SATA/QSGMII
 	  combo PHY with NaNeng IP block.
 
+config PHY_ROCKCHIP_NANENG_EDP
+	tristate "Rockchip Naneng eDP Transmitter PHY driver"
+	depends on ARCH_ROCKCHIP && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the Rockchip eDP Transmitter PHY with
+	  NaNeng IP block. The PHY, which is controlled through the eDP
+	  PHY GRF, provides 1/2/4 lanes running at 1.62/2.7 Gbps per lane
+	  for the eDP controller found on the RK3568 SoC.
+
 config PHY_ROCKCHIP_PCIE
 	tristate "Rockchip PCIe PHY Driver"
 	depends on (ARCH_ROCKCHIP && OF) || COMPILE_TEST
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index 117aaffd037d..260a10157461 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY)	+= phy-rockchip-naneng-combphy.o
+obj-$(CONFIG_PHY_ROCKCHIP_NANENG_EDP)	+= phy-rockchip-naneng-edp.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
 obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_DCPHY)	+= phy-rockchip-samsung-dcphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX)	+= phy-rockchip-samsung-hdptx.o
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-edp.c b/drivers/phy/rockchip/phy-rockchip-naneng-edp.c
new file mode 100644
index 000000000000..a407714f639a
--- /dev/null
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-edp.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026 Rockchip Electronics Co., Ltd.
+ *
+ * Author: Damon Ding <damon.ding@rock-chips.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/hw_bitfield.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define EDP_PHY_GRF_CON0		0x0000
+#define EDP_PHY_TX_IDLE_MASK		GENMASK(11, 8)
+#define EDP_PHY_TX_PD_MASK		GENMASK(7, 4)
+#define EDP_PHY_IDDQ_EN_MASK		BIT(1)
+#define EDP_PHY_PD_PLL_MASK		BIT(0)
+
+#define EDP_PHY_GRF_CON1		0x0004
+#define EDP_PHY_PLL_DIV_MASK		GENMASK(14, 0)
+
+#define EDP_PHY_GRF_CON2		0x0008
+#define EDP_PHY_TX_RTERM_MASK		GENMASK(10, 8)
+#define EDP_PHY_RATE_MASK		GENMASK(5, 4)
+#define EDP_PHY_REF_DIV_MASK		GENMASK(3, 0)
+
+#define EDP_PHY_GRF_CON3		0x000c
+#define EDP_PHY_TX3_EMP_MASK		GENMASK(15, 12)
+#define EDP_PHY_TX2_EMP_MASK		GENMASK(11, 8)
+#define EDP_PHY_TX1_EMP_MASK		GENMASK(7, 4)
+#define EDP_PHY_TX0_EMP_MASK		GENMASK(3, 0)
+
+#define EDP_PHY_GRF_CON4		0x0010
+#define EDP_PHY_TX3_AMP_MASK		GENMASK(14, 12)
+#define EDP_PHY_TX2_AMP_MASK		GENMASK(10, 8)
+#define EDP_PHY_TX1_AMP_MASK		GENMASK(6, 4)
+#define EDP_PHY_TX0_AMP_MASK		GENMASK(2, 0)
+
+#define EDP_PHY_GRF_CON5		0x0014
+#define EDP_PHY_TX_MODE_MASK		GENMASK(9, 8)
+#define EDP_PHY_TX3_AMP_SCALE_MASK	GENMASK(7, 6)
+#define EDP_PHY_TX2_AMP_SCALE_MASK	GENMASK(5, 4)
+#define EDP_PHY_TX1_AMP_SCALE_MASK	GENMASK(3, 2)
+#define EDP_PHY_TX0_AMP_SCALE_MASK	GENMASK(1, 0)
+
+#define EDP_PHY_GRF_CON6		0x0018
+#define EDP_PHY_SSC_DEPTH_MASK		GENMASK(15, 12)
+#define EDP_PHY_SSC_EN_MASK		BIT(11)
+#define EDP_PHY_SSC_CNT_MASK		GENMASK(9, 0)
+
+#define EDP_PHY_GRF_CON7		0x001c
+
+#define EDP_PHY_GRF_CON8		0x0020
+#define EDP_PHY_PLL_CTL_H_MASK		GENMASK(15, 0)
+
+#define EDP_PHY_GRF_CON9		0x0024
+#define EDP_PHY_TX_CTL_MASK		GENMASK(15, 0)
+
+#define EDP_PHY_GRF_CON10		0x0028
+#define EDP_PHY_AUX_RCV_PD_SEL_MASK	BIT(5)
+#define EDP_PHY_AUX_DRV_PD_SEL_MASK	BIT(4)
+#define EDP_PHY_AUX_IDLE_MASK		BIT(2)
+#define EDP_PHY_AUX_RCV_PD_MASK		BIT(1)
+#define EDP_PHY_AUX_DRV_PD_MASK		BIT(0)
+
+#define EDP_PHY_GRF_CON11		0x002c
+#define EDP_PHY_AUX_RCV_VCM_MASK	GENMASK(14, 12)
+#define EDP_PHY_AUX_MODE_MASK		GENMASK(11, 10)
+#define EDP_PHY_AUX_AMP_SCALE_MASK	GENMASK(9, 8)
+#define EDP_PHY_AUX_AMP_MASK		GENMASK(6, 4)
+#define EDP_PHY_AUX_RTERM_MASK		GENMASK(2, 0)
+
+#define EDP_PHY_GRF_STATUS0		0x0030
+#define PLL_RDY				BIT(0)
+
+#define EDP_PHY_GRF_STATUS1		0x0034
+
+struct rockchip_edp_phy {
+	struct regmap *grf;
+	struct device *dev;
+	struct clk *refclk;
+};
+
+static struct {
+	int amp;
+	int amp_scale;
+	int emp;
+} swing_pre_emph_table[4][4] = {
+	{ {0x1, 0x1, 0x0}, {0x2, 0x1, 0x4}, {0x3, 0x1, 0x8}, {0x4, 0x1, 0xd} },
+	{ {0x3, 0x1, 0x0}, {0x5, 0x1, 0x7}, {0x6, 0x1, 0x6}, { -1,  -1,  -1} },
+	{ {0x5, 0x1, 0x0}, {0x7, 0x1, 0x4}, { -1,  -1,  -1}, { -1,  -1,  -1} },
+	{ {0x7, 0x1, 0x0}, { -1,  -1,  -1}, { -1,  -1,  -1}, { -1,  -1,  -1} },
+};
+
+static void rockchip_edp_phy_set_voltage(struct rockchip_edp_phy *edpphy,
+					 struct phy_configure_opts_dp *dp,
+					 u8 lane)
+{
+	u32 amp, amp_scale, emp;
+
+	amp = swing_pre_emph_table[dp->voltage[lane]][dp->pre[lane]].amp;
+	amp_scale = swing_pre_emph_table[dp->voltage[lane]][dp->pre[lane]].amp_scale;
+	emp = swing_pre_emph_table[dp->voltage[lane]][dp->pre[lane]].emp;
+
+	switch (lane) {
+	case 0:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON3,
+			     FIELD_PREP_WM16(EDP_PHY_TX0_EMP_MASK, emp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON4,
+			     FIELD_PREP_WM16(EDP_PHY_TX0_AMP_MASK, amp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON5,
+			     FIELD_PREP_WM16(EDP_PHY_TX0_AMP_SCALE_MASK, amp_scale));
+		break;
+	case 1:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON3,
+			     FIELD_PREP_WM16(EDP_PHY_TX1_EMP_MASK, emp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON4,
+			     FIELD_PREP_WM16(EDP_PHY_TX1_AMP_MASK, amp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON5,
+			     FIELD_PREP_WM16(EDP_PHY_TX1_AMP_SCALE_MASK, amp_scale));
+		break;
+	case 2:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON3,
+			     FIELD_PREP_WM16(EDP_PHY_TX2_EMP_MASK, emp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON4,
+			     FIELD_PREP_WM16(EDP_PHY_TX2_AMP_MASK, amp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON5,
+			     FIELD_PREP_WM16(EDP_PHY_TX2_AMP_SCALE_MASK, amp_scale));
+		break;
+	case 3:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON3,
+			     FIELD_PREP_WM16(EDP_PHY_TX3_EMP_MASK, emp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON4,
+			     FIELD_PREP_WM16(EDP_PHY_TX3_AMP_MASK, amp));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON5,
+			     FIELD_PREP_WM16(EDP_PHY_TX3_AMP_SCALE_MASK, amp_scale));
+		break;
+	}
+}
+
+static int rockchip_edp_phy_set_voltages(struct rockchip_edp_phy *edpphy,
+					 struct phy_configure_opts_dp *dp)
+{
+	u8 lane;
+
+	for (lane = 0; lane < dp->lanes; lane++)
+		rockchip_edp_phy_set_voltage(edpphy, dp, lane);
+
+	return 0;
+}
+
+static int rockchip_edp_phy_set_rate(struct rockchip_edp_phy *edpphy,
+				     struct phy_configure_opts_dp *dp)
+{
+	u32 value;
+	int ret;
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
+		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, 0xf) |
+		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, 0xf));
+	usleep_range(100, 101);
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON5, FIELD_PREP_WM16(EDP_PHY_TX_MODE_MASK, 0x3));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0, FIELD_PREP_WM16(EDP_PHY_PD_PLL_MASK, 0x1));
+
+	switch (dp->link_rate) {
+	case 1620:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON1,
+			     FIELD_PREP_WM16(EDP_PHY_PLL_DIV_MASK, 0x4380));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON2,
+			     FIELD_PREP_WM16(EDP_PHY_TX_RTERM_MASK, 0x1) |
+			     FIELD_PREP_WM16(EDP_PHY_RATE_MASK, 0x1) |
+			     FIELD_PREP_WM16(EDP_PHY_REF_DIV_MASK, 0x0));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON8,
+			     FIELD_PREP_WM16(EDP_PHY_PLL_CTL_H_MASK, 0x0800));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON9,
+			     FIELD_PREP_WM16(EDP_PHY_TX_CTL_MASK, 0x0000));
+		break;
+	case 2700:
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON1,
+			     FIELD_PREP_WM16(EDP_PHY_PLL_DIV_MASK, 0x3840));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON2,
+			     FIELD_PREP_WM16(EDP_PHY_TX_RTERM_MASK, 0x1) |
+			     FIELD_PREP_WM16(EDP_PHY_RATE_MASK, 0x0) |
+			     FIELD_PREP_WM16(EDP_PHY_REF_DIV_MASK, 0x0));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON8,
+			     FIELD_PREP_WM16(EDP_PHY_PLL_CTL_H_MASK, 0x0800));
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON9,
+			     FIELD_PREP_WM16(EDP_PHY_TX_CTL_MASK, 0x0000));
+		break;
+	}
+
+	if (dp->ssc)
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON6,
+			     FIELD_PREP_WM16(EDP_PHY_SSC_DEPTH_MASK, 0x9) |
+			     FIELD_PREP_WM16(EDP_PHY_SSC_EN_MASK, 0x1) |
+			     FIELD_PREP_WM16(EDP_PHY_SSC_CNT_MASK, 0x17d));
+	else
+		regmap_write(edpphy->grf, EDP_PHY_GRF_CON6,
+			     FIELD_PREP_WM16(EDP_PHY_SSC_EN_MASK, 0x0));
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0, FIELD_PREP_WM16(EDP_PHY_PD_PLL_MASK, 0));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
+		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, ~GENMASK(dp->lanes - 1, 0)));
+	ret = regmap_read_poll_timeout(edpphy->grf, EDP_PHY_GRF_STATUS0,
+				       value, value & PLL_RDY, 100, 1000);
+	if (ret) {
+		dev_err(edpphy->dev, "Failed to wait for PHY PLL ready: %d\n", ret);
+		return ret;
+	}
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON5, FIELD_PREP_WM16(EDP_PHY_TX_MODE_MASK, 0x0));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
+		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, ~GENMASK(dp->lanes - 1, 0)));
+
+	return 0;
+}
+
+static int rockchip_edp_phy_verify_config(struct rockchip_edp_phy *edpphy,
+					  struct phy_configure_opts_dp *dp)
+{
+	int i;
+
+	/* If changing link rate was required, verify it's supported. */
+	if (dp->set_rate) {
+		switch (dp->link_rate) {
+		case 1620:
+		case 2700:
+			/* valid bit rate */
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (dp->set_lanes) {
+		/* Verify lane count. */
+		switch (dp->lanes) {
+		case 1:
+		case 2:
+		case 4:
+			/* valid lane count. */
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * If changing voltages is required, check swing and pre-emphasis
+	 * levels, per-lane.
+	 */
+	if (dp->set_voltages) {
+		/* Lane count verified previously. */
+		for (i = 0; i < dp->lanes; i++) {
+			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+				return -EINVAL;
+
+			/*
+			 * Sum of voltage swing and pre-emphasis levels cannot
+			 * exceed 3.
+			 */
+			if (dp->voltage[i] + dp->pre[i] > 3)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int rockchip_edp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
+{
+	struct rockchip_edp_phy *edpphy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = rockchip_edp_phy_verify_config(edpphy, &opts->dp);
+	if (ret) {
+		dev_err(edpphy->dev, "Invalid params for phy configure\n");
+		return ret;
+	}
+
+	if (opts->dp.set_rate) {
+		ret = rockchip_edp_phy_set_rate(edpphy, &opts->dp);
+		if (ret) {
+			dev_err(edpphy->dev, "Failed to set rate\n");
+			return ret;
+		}
+	}
+
+	if (opts->dp.set_voltages) {
+		ret = rockchip_edp_phy_set_voltages(edpphy, &opts->dp);
+		if (ret) {
+			dev_err(edpphy->dev, "Failed to set voltages\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static bool rockchip_edp_phy_enabled(struct rockchip_edp_phy *edpphy)
+{
+	u32 val;
+
+	regmap_read(edpphy->grf, EDP_PHY_GRF_STATUS0, &val);
+
+	return FIELD_GET(PLL_RDY, val);
+}
+
+static int rockchip_edp_phy_power_on(struct phy *phy)
+{
+	struct rockchip_edp_phy *edpphy = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(edpphy->refclk);
+	if (ret < 0) {
+		dev_err(edpphy->dev, "Failed to prepare_enable refclk [%d]\n", ret);
+		return ret;
+	}
+
+	if (rockchip_edp_phy_enabled(edpphy))
+		return 0;
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON10,
+		     FIELD_PREP_WM16(EDP_PHY_AUX_RCV_PD_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_DRV_PD_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_IDLE_MASK, 0x1));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
+		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, 0xf) |
+		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, 0xf) |
+		     FIELD_PREP_WM16(EDP_PHY_PD_PLL_MASK, 0x1));
+	usleep_range(100, 101);
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON11,
+		     FIELD_PREP_WM16(EDP_PHY_AUX_RCV_VCM_MASK, 0x4) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_MODE_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_AMP_SCALE_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_AMP_MASK, 0x3) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_RTERM_MASK, 0x1));
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON10,
+		     FIELD_PREP_WM16(EDP_PHY_AUX_RCV_PD_MASK, 0x0) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_DRV_PD_MASK, 0x0));
+	usleep_range(100, 101);
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON10, FIELD_PREP_WM16(EDP_PHY_AUX_IDLE_MASK, 0x0));
+	usleep_range(10000, 11000);
+
+	return 0;
+}
+
+static int rockchip_edp_phy_power_off(struct phy *phy)
+{
+	struct rockchip_edp_phy *edpphy = phy_get_drvdata(phy);
+
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0,
+		     FIELD_PREP_WM16(EDP_PHY_TX_IDLE_MASK, 0xf) |
+		     FIELD_PREP_WM16(EDP_PHY_TX_PD_MASK, 0xf));
+	usleep_range(100, 101);
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON5, FIELD_PREP_WM16(EDP_PHY_TX_MODE_MASK, 0x3));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON0, FIELD_PREP_WM16(EDP_PHY_PD_PLL_MASK, 0x1));
+	regmap_write(edpphy->grf, EDP_PHY_GRF_CON10,
+		     FIELD_PREP_WM16(EDP_PHY_AUX_RCV_PD_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_DRV_PD_MASK, 0x1) |
+		     FIELD_PREP_WM16(EDP_PHY_AUX_IDLE_MASK, 0x1));
+
+	clk_disable_unprepare(edpphy->refclk);
+
+	return 0;
+}
+
+static const struct phy_ops rockchip_edp_phy_ops = {
+	.power_on = rockchip_edp_phy_power_on,
+	.power_off = rockchip_edp_phy_power_off,
+	.configure = rockchip_edp_phy_configure,
+	.owner = THIS_MODULE,
+};
+
+static int rockchip_edp_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_edp_phy *edpphy;
+	struct phy *phy;
+	struct phy_provider *phy_provider;
+
+	edpphy = devm_kzalloc(dev, sizeof(*edpphy), GFP_KERNEL);
+	if (!edpphy)
+		return -ENOMEM;
+
+	edpphy->dev = dev;
+
+	edpphy->grf = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(edpphy->grf))
+		return dev_err_probe(dev, PTR_ERR(edpphy->grf), "Failed to get GRF syscon\n");
+
+	edpphy->refclk = devm_clk_get(dev, "refclk");
+	if (IS_ERR(edpphy->refclk))
+		return dev_err_probe(dev, PTR_ERR(edpphy->refclk), "Failed to get refclk\n");
+
+	phy = devm_phy_create(dev, NULL, &rockchip_edp_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy), "Failed to create PHY\n");
+
+	phy_set_drvdata(phy, edpphy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(dev, PTR_ERR(phy_provider),
+				     "Failed to register PHY provider\n");
+
+	return 0;
+}
+
+static const struct of_device_id rockchip_edp_phy_of_match[] = {
+	{ .compatible = "rockchip,rk3568-edp-phy", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rockchip_edp_phy_of_match);
+
+static struct platform_driver rockchip_edp_phy_driver = {
+	.driver = {
+		.name = "rockchip-edpphy-naneng",
+		.of_match_table	= of_match_ptr(rockchip_edp_phy_of_match),
+	},
+	.probe = rockchip_edp_phy_probe,
+};
+module_platform_driver(rockchip_edp_phy_driver);
+
+MODULE_AUTHOR("Damon Ding <damon.ding@rock-chips.com>");
+MODULE_DESCRIPTION("Rockchip Naneng eDP Transmitter PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

