Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D147C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6013B10F39F;
	Fri, 28 Aug 2026 13:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="FhvsoSRQ";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAC610F39D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:39 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134838euoutp01ac1505290bfac5dbebfcdcf5eceb4ac3~P-D14nPV92677826778euoutp012;
 Fri, 28 Aug 2026 13:48:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260828134838euoutp01ac1505290bfac5dbebfcdcf5eceb4ac3~P-D14nPV92677826778euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924918;
 bh=0NThGzFDSTcDLvAf88D/ThMXkjsNRo7YGSpeIcvBpFQ=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=FhvsoSRQysY46O6tv3MXHV91r3qMtkQOvp4I8JO49Ywe5B3EBdsc5jeqUU8NtA62E
 dOHR95uo9zulxV+byQ06yuOI78jzpw9sVFt9/wBYy8Zfe6AmgjCQMYpuh2S2GAV07z
 sHRNPYUJ7iZCDwfGji78/cC/6r9Gbotk8Ce81ZEQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a~P-D1o668J1592715927eucas1p1Q;
 Fri, 28 Aug 2026 13:48:37 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134835eusmtip154a3678560df343ccb353d15f50ac603~P-DzrL3Ud2815728157eusmtip1G;
 Fri, 28 Aug 2026 13:48:35 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 28 Aug 2026 15:47:37 +0200
Subject: [PATCH v2 13/15] phy: starfive: Add jh7110-inno-hdmi-phy driver
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-jh7110-clean-send-v2-13-331680c8b9d1@samsung.com>
In-Reply-To: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,  Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,  Andy Yan
 <andyshrk@163.com>, Marek Szyprowski <m.szyprowski@samsung.com>,  Maud
 Spierings <maudspierings@gocontroll.com>,  Graham Markall
 <hello@big-grey.co.uk>,  Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a
X-EPHeader: CA
X-CMS-RootMailID: 20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134837eucas1p18f352f4ffb04ca5e55386ed3423f5d1a@eucas1p1.samsung.com>
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

Add the HDMI PHY driver for the StarFive JH7110.

This driver binds to the starfive,jh7110-inno-hdmi-phy node and
gets its regmap from the parent. It has no dependencies on voutcrg, only
on its refoclk (xin24m), which breaks the probe-time circular
dependency.

This driver provides two main functions:
 - Clock Provider: It registers clk_ops to provide the variable pixel
   clock (hdmi_pclk). The .set_rate operation configures the Pre-PLL
   registers (0x1a0+) based on the requested rate.

 - PHY Provider: It registers phy_ops for the controller. The .power_on
   op configures and enables the Post-PLL and other analog blocks (BIAS,
   LDO, Serializer, etc.).

The JH7110 instantiates the same Innosilicon IP as the Rockchip RK3328,
with the PHY register block shifted by 0x100 because it sits behind the
HDMI controller in the shared register space. The pre-PLL programming
therefore comes from the common Innosilicon helpers; this driver adds
the JH7110 pixel clock table, the post-PLL and the analog configuration.

Co-developed-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/phy/starfive/Kconfig                |  20 +
 drivers/phy/starfive/Makefile               |   1 +
 drivers/phy/starfive/phy-jh7110-inno-hdmi.c | 567 ++++++++++++++++++++++++++++
 3 files changed, 588 insertions(+)

diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
index d0cdd7cb4a13de22ff643c89a79d99cce57284d7..1da417ffbf224c13224e42a3ce322e3d0c272824 100644
--- a/drivers/phy/starfive/Kconfig
+++ b/drivers/phy/starfive/Kconfig
@@ -25,6 +25,26 @@ config PHY_STARFIVE_JH7110_DPHY_TX
 	  system. If M is selected, the module will be called
 	  phy-jh7110-dphy-tx.ko.
 
+config PHY_STARFIVE_JH7110_INNO_HDMI
+	tristate "Starfive JH7110 INNO HDMI PHY"
+	select PHY_INNO_HDMI
+	depends on COMMON_CLK
+	select GENERIC_PHY
+	help
+	  This option enables the driver for the analog HDMI PHY (Physical
+	  Layer) on the StarFive JH7110 SoC.
+
+	  This driver binds to a child node of the 'starfive,jh7110-hdmi-subsystem'
+	  parent driver and gets its register map from that parent.
+
+	  It is responsible for two main functions:
+	  1. PHY Provider: It provides standard PHY operations (.power_on,
+	     .power_off) for the HDMI controller (bridge) driver. This
+	     involves configuring the Post-PLL and analog TMDS blocks.
+	  2. Clock Provider: It registers as a clock provider to supply the
+	     variable pixel clock (hdmi_pclk) to the HDMI controller and
+	     the VOUT subsystem, which it generates using the Pre-PLL.
+
 config PHY_STARFIVE_JH7110_PCIE
 	tristate "Starfive JH7110 PCIE 2.0/USB 3.0 PHY support"
 	depends on HAS_IOMEM
diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
index eedc4a6fec156320c99ac0a0da609083b6a6a695..e7b13f00880b500f933f21b6037384d5c6884e3e 100644
--- a/drivers/phy/starfive/Makefile
+++ b/drivers/phy/starfive/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_RX)	+= phy-jh7110-dphy-rx.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_DPHY_TX)	+= phy-jh7110-dphy-tx.o
+obj-$(CONFIG_PHY_STARFIVE_JH7110_INNO_HDMI)	+= phy-jh7110-inno-hdmi.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_PCIE)		+= phy-jh7110-pcie.o
 obj-$(CONFIG_PHY_STARFIVE_JH7110_USB)		+= phy-jh7110-usb.o
diff --git a/drivers/phy/starfive/phy-jh7110-inno-hdmi.c b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..f4c4d76a38754d5edd4d80895481560c9650f3e7
--- /dev/null
+++ b/drivers/phy/starfive/phy-jh7110-inno-hdmi.c
@@ -0,0 +1,567 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ *
+ * Author: Zheng Yang <zhengyang@rock-chips.com>
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * The register layout and programming sequence derive from
+ * drivers/phy/rockchip/phy-rockchip-inno-hdmi.c; the JH7110 places the
+ * same Innosilicon PHY block at a 0x100 register offset.
+ *
+ * This driver handles the PHY portion of the StarFive Innosilicon HDMI IP,
+ * which is part of a monolithic HDMI block. It provides the variable pixel
+ * clock (from the Pre-PLL) and the PHY operations (for the Post-PLL/analog).
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/phy/inno-hdmi-phy.h>
+#include <linux/phy/phy.h>
+#include <linux/slab.h>
+
+/*
+ * StarFive (JH7110) Innosilicon HDMI PHY Register Definitions
+ */
+
+/* REG: 0x1aa */
+#define STF_INNO_POST_PLL_DIV_1		0x1aa
+#define STF_INNO_POST_PLL_POST_DIV_ENABLE	GENMASK(3, 2)
+#define STF_INNO_POST_PLL_REFCLK_SEL_TMDS	BIT(1)
+#define STF_INNO_POST_PLL_POWER_DOWN		BIT(0)
+
+/* REG: 0x1ab */
+#define STF_INNO_POST_PLL_DIV_2		0x1ab
+#define STF_INNO_POST_PLL_PRE_DIV(x)		FIELD_PREP(GENMASK(5, 0), x)
+#define STF_INNO_POST_PLL_FB_DIV_8(x)		FIELD_PREP(BIT(7), (x) >> 8)
+
+/* REG: 0x1ac */
+#define STF_INNO_POST_PLL_DIV_3		0x1ac
+#define STF_INNO_POST_PLL_FB_DIV_7_0(x)	FIELD_PREP(GENMASK(7, 0), x)
+
+/* REG: 0x1ad */
+#define STF_INNO_POST_PLL_DIV_4		0x1ad
+#define STF_INNO_POST_PLL_POST_DIV_MASK	GENMASK(1, 0)
+
+/* REG: 0x1af */
+#define STF_INNO_POST_PLL_LOCK_STATUS		0x1af
+#define STF_INNO_POST_PLL_LOCK		BIT(0)
+
+/* REG: 0x1b0 */
+#define STF_INNO_BIAS_CONTROL			0x1b0
+#define STF_INNO_BIAS_ENABLE			BIT(2)
+
+/* REG: 0x1b2 */
+#define STF_INNO_TMDS_CONTROL			0x1b2
+#define STF_INNO_TMDS_CLK_DRIVER_EN		BIT(3)
+#define STF_INNO_TMDS_D2_DRIVER_EN		BIT(2)
+#define STF_INNO_TMDS_D1_DRIVER_EN		BIT(1)
+#define STF_INNO_TMDS_D0_DRIVER_EN		BIT(0)
+#define STF_INNO_TMDS_DRIVER_ENABLE		(STF_INNO_TMDS_CLK_DRIVER_EN | \
+						 STF_INNO_TMDS_D2_DRIVER_EN | \
+						 STF_INNO_TMDS_D1_DRIVER_EN | \
+						 STF_INNO_TMDS_D0_DRIVER_EN)
+
+/* REG: 0x1b4 */
+#define STF_INNO_LDO_CONTROL			0x1b4
+#define STF_INNO_LDO_ENABLE			(BIT(2) | BIT(1) | BIT(0))
+
+/* REG: 0x1be */
+#define STF_INNO_SERIALIER_CONTROL		0x1be
+#define STF_INNO_SERIALIER_ENABLE		(BIT(6) | BIT(5) | BIT(4) | BIT(0))
+
+/* REG: 0x1cc */
+#define STF_INNO_RX_CONTROL			0x1cc
+#define STF_INNO_RX_ENABLE			(BIT(3) | BIT(2) | BIT(1) | BIT(0))
+
+/*
+ * These tables are copied from the monolithic driver.
+ * They match the Rockchip PHY driver tables.
+ */
+
+struct post_pll_config {
+	unsigned long tmdsclock;
+	u8 prediv;
+	u16 fbdiv;
+	u8 postdiv;
+	u8 post_div_en;
+};
+
+static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
+	{ 25175000, 25175000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0xF55555 },
+	{ 25200000, 25200000, 1, 100, 2, 3, 3, 12, 3, 3, 4, 0, 0 },
+	{ 27000000, 27000000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0 },
+	{ 27027000, 27027000, 1, 90, 3, 2, 2, 10, 3, 3, 4, 0, 0x170A3D },
+	{ 28320000, 28320000, 1, 28, 2, 1, 1, 3, 0, 3, 4, 0, 0x51EB85 },
+	{ 30240000, 30240000, 1, 30, 2, 1, 1, 3, 0, 3, 4, 0, 0x3D70A3 },
+	{ 31500000, 31500000, 1, 31, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 33750000, 33750000, 1, 33, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 36000000, 36000000, 1, 36, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 40000000, 40000000, 1, 80, 2, 2, 2, 12, 2, 2, 2, 0, 0 },
+	{ 46970000, 46970000, 1, 46, 2, 1, 1, 3, 0, 3, 4, 0, 0xF851EB },
+	{ 49500000, 49500000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 49000000, 49000000, 1, 49, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 50000000, 50000000, 1, 50, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 54000000, 54000000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 54054000, 54054000, 1, 54, 2, 1, 1, 3, 0, 3, 4, 0, 0x0DD2F1 },
+	{ 57284000, 57284000, 1, 57, 2, 1, 1, 3, 0, 3, 4, 0, 0x48B439 },
+	{ 58230000, 58230000, 1, 58, 2, 1, 1, 3, 0, 3, 4, 0, 0x3AE147 },
+	{ 59341000, 59341000, 1, 59, 2, 1, 1, 3, 0, 3, 4, 0, 0x574BC6 },
+	{ 59400000, 59400000, 1, 99, 3, 1, 1, 1, 3, 3, 4, 0, 0 },
+	{ 65000000, 65000000, 1, 130, 2, 2, 2, 12, 0, 2, 2, 0, 0 },
+	{ 68250000, 68250000, 1, 68, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
+	{ 71000000, 71000000, 1, 71, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 74176000, 74176000, 1, 98, 1, 2, 2, 1, 2, 3, 4, 0, 0xE6AE6B },
+	{ 74250000, 74250000, 1, 99, 1, 2, 2, 1, 2, 3, 4, 0, 0 },
+	{ 75000000, 75000000, 1, 75, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 78750000, 78750000, 1, 78, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 79500000, 79500000, 1, 79, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 83500000, 83500000, 2, 167, 2, 1, 1, 1, 0, 0, 6, 0, 0 },
+	{ 83500000, 104375000, 1, 104, 2, 1, 1, 1, 1, 0, 5, 0, 0x600000 },
+	{ 85500000, 85500000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 85750000, 85750000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 85800000, 85800000, 1, 85, 2, 1, 1, 3, 0, 3, 4, 0, 0xCCCCCC },
+	{ 88750000, 88750000, 1, 88, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 89910000, 89910000, 1, 89, 2, 1, 1, 3, 0, 3, 4, 0, 0xE8F5C1 },
+	{ 90000000, 90000000, 1, 90, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 101000000, 101000000, 1, 101, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 102250000, 102250000, 1, 102, 2, 1, 1, 3, 0, 3, 4, 0, 0x3FFFFF },
+	{ 106500000, 106500000, 1, 106, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 108000000, 108000000, 1, 90, 3, 0, 0, 5, 0, 2, 2, 0, 0 },
+	{ 119000000, 119000000, 1, 119, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 131481000, 131481000, 1, 131, 2, 1, 1, 3, 0, 3, 4, 0, 0x7B22D1 },
+	{ 135000000, 135000000, 1, 135, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 136750000, 136750000, 1, 136, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 147180000, 147180000, 1, 147, 2, 1, 1, 3, 0, 3, 4, 0, 0x2E147A },
+	{ 148352000, 148352000, 1, 98, 1, 1, 1, 1, 2, 2, 2, 0, 0xE6AE6B },
+	{ 148500000, 148500000, 1, 99, 1, 1, 1, 1, 2, 2, 2, 0, 0 },
+	{ 154000000, 154000000, 1, 154, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 156000000, 156000000, 1, 156, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 157000000, 157000000, 1, 157, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 162000000, 162000000, 1, 162, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 174250000, 174250000, 1, 145, 3, 0, 0, 5, 0, 2, 2, 0, 0x355555 },
+	{ 174500000, 174500000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 174570000, 174570000, 1, 174, 2, 1, 1, 3, 0, 3, 4, 0, 0x91EB84 },
+	{ 175500000, 175500000, 1, 175, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 185590000, 185590000, 1, 185, 2, 1, 1, 3, 0, 3, 4, 0, 0x970A3C },
+	{ 187000000, 187000000, 1, 187, 2, 1, 1, 3, 0, 3, 4, 0, 0 },
+	{ 241500000, 241500000, 1, 161, 1, 1, 1, 4, 0, 2, 2, 0, 0 },
+	{ 241700000, 241700000, 1, 241, 2, 1, 1, 3, 0, 3, 4, 0, 0xB33332 },
+	{ 262750000, 262750000, 1, 262, 2, 1, 1, 3, 0, 3, 4, 0, 0xCFFFFF },
+	{ 296500000, 296500000, 1, 296, 2, 1, 1, 3, 0, 3, 4, 0, 0x7FFFFF },
+	{ 296703000, 296703000, 1, 98, 0, 1, 1, 1, 0, 2, 2, 0, 0xE6AE6B },
+	{ 297000000, 297000000, 1, 99, 0, 1, 1, 1, 0, 2, 2, 0, 0 },
+	{ 594000000, 594000000, 1, 99, 0, 2, 0, 1, 0, 1, 1, 0, 0 },
+	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
+};
+
+static const struct post_pll_config post_pll_cfg_table[] = {
+	{ 25200000, 1, 80, 13, 3 },
+	{ 27000000, 1, 40, 11, 3 },
+	{ 27027000, 1, 40, 11, 3 },
+	{ 33750000, 1, 40, 11, 3 },
+	{ 49000000, 1, 20, 1, 3 },
+	{ 65000000, 1, 20, 1, 3 },
+	{ 74250000, 1, 20, 1, 3 },
+	{ 88750000, 1, 20, 1, 3 },
+	{ 108000000, 1, 20, 1, 3 },
+	{ 148500000, 1, 20, 1, 3 },
+	{ 162000000, 1, 20, 1, 3 },
+	{ 174250000, 1, 20, 1, 3 },
+	{ 187000000, 1, 20, 1, 3 },
+	{ 241700000, 1, 20, 1, 3 },
+	{ 297000000, 4, 20, 0, 0 },
+	{ 594000000, 4, 20, 0, 0 }, /* postpll_postdiv_en = 0 */
+	{ /* sentinel */ }
+};
+
+struct starfive_hdmi_phy {
+	struct device *dev;
+	struct regmap *regmap;
+	struct phy *phy;
+	struct clk *refoclk;
+
+	struct inno_hdmi_phy_pre_pll pre_pll;
+
+	struct clk_hw hw;
+	struct clk *phyclk;
+	unsigned long pixclock;
+	unsigned long tmdsclock;
+};
+
+static inline void inno_write(struct starfive_hdmi_phy *inno, u32 reg, u8 val)
+{
+	regmap_write(inno->regmap, reg * 4, val);
+}
+
+static inline u8 inno_read(struct starfive_hdmi_phy *inno, u32 reg)
+{
+	u32 val;
+
+	regmap_read(inno->regmap, reg * 4, &val);
+	return val;
+}
+
+static inline void inno_update_bits(struct starfive_hdmi_phy *inno, u16 reg,
+				    u8 mask, u8 val)
+{
+	regmap_update_bits(inno->regmap, reg * 4, mask, val);
+}
+
+#define inno_poll(inno, reg, val, cond, sleep_us, timeout_us) \
+	regmap_read_poll_timeout((inno)->regmap, (reg) * 4, val, cond, \
+				 sleep_us, timeout_us)
+
+static inline struct starfive_hdmi_phy *to_starfive_hdmi_phy(struct clk_hw *hw)
+{
+	return container_of(hw, struct starfive_hdmi_phy, hw);
+}
+
+static int starfive_hdmi_phy_clk_prepare(struct clk_hw *hw)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+	int ret;
+
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, false);
+
+	if (inno_hdmi_phy_pre_pll_is_locked(&inno->pre_pll))
+		return 0;
+
+	ret = inno_hdmi_phy_pre_pll_wait_locked(&inno->pre_pll, 100000);
+	if (ret) {
+		dev_err(inno->dev, "Timeout waiting for pre-PLL lock\n");
+		inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void starfive_hdmi_phy_clk_unprepare(struct clk_hw *hw)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
+	inno->pixclock = 0; /* Invalidate cached rate */
+}
+
+static int starfive_hdmi_phy_clk_is_prepared(struct clk_hw *hw)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+
+	if (!inno_hdmi_phy_pre_pll_is_powered(&inno->pre_pll))
+		return 0;
+
+	return inno_hdmi_phy_pre_pll_is_locked(&inno->pre_pll);
+}
+
+static unsigned long starfive_hdmi_phy_clk_recalc_rate(struct clk_hw *hw,
+						       unsigned long parent_rate)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+
+	if (!starfive_hdmi_phy_clk_is_prepared(hw))
+		return inno->pixclock;
+
+	inno->pixclock = inno_hdmi_phy_pre_pll_recalc_rate(&inno->pre_pll,
+							   parent_rate);
+
+	return inno->pixclock;
+}
+
+static int starfive_hdmi_phy_clk_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+
+	return inno_hdmi_phy_pre_pll_determine_rate(&inno->pre_pll, req);
+}
+
+static int starfive_hdmi_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	struct starfive_hdmi_phy *inno = to_starfive_hdmi_phy(hw);
+	const struct inno_hdmi_phy_pre_pll_config *cfg;
+
+	/*
+	 * The JH7110 only drives 8bpc, so the TMDS clock always matches the
+	 * pixel clock.
+	 */
+	cfg = inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, rate, rate);
+	if (IS_ERR(cfg))
+		return PTR_ERR(cfg);
+
+	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
+		__func__, rate, cfg->tmdsclock);
+
+	if (inno->pixclock == rate && inno->tmdsclock == cfg->tmdsclock)
+		return 0;
+
+	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
+			 STF_INNO_BIAS_ENABLE, STF_INNO_BIAS_ENABLE);
+	inno_write(inno, STF_INNO_RX_CONTROL, STF_INNO_RX_ENABLE);
+
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
+	inno_hdmi_phy_pre_pll_configure(&inno->pre_pll, cfg);
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, false);
+
+	inno->pixclock = rate;
+	inno->tmdsclock = cfg->tmdsclock;
+
+	return 0;
+}
+
+static const struct clk_ops starfive_hdmi_phy_clk_ops = {
+	.prepare = starfive_hdmi_phy_clk_prepare,
+	.unprepare = starfive_hdmi_phy_clk_unprepare,
+	.is_prepared = starfive_hdmi_phy_clk_is_prepared,
+	.recalc_rate = starfive_hdmi_phy_clk_recalc_rate,
+	.determine_rate = starfive_hdmi_phy_clk_determine_rate,
+	.set_rate = starfive_hdmi_phy_clk_set_rate,
+};
+
+static int starfive_hdmi_phy_power_on(struct phy *phy)
+{
+	struct starfive_hdmi_phy *inno = phy_get_drvdata(phy);
+	const struct post_pll_config *cfg = post_pll_cfg_table;
+	const struct inno_hdmi_phy_pre_pll_config *pre_cfg;
+	unsigned long tmdsclock;
+	u8 reg_1ad_value;
+	u8 reg_1aa_value;
+
+	u32 v;
+	int ret;
+
+	tmdsclock = clk_get_rate(inno->phyclk);
+	pre_cfg = inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, tmdsclock,
+					       tmdsclock);
+	if (IS_ERR(pre_cfg)) {
+		dev_err(inno->dev, "no pre-PLL config for current pixel clock\n");
+		return PTR_ERR(pre_cfg);
+	}
+	tmdsclock = pre_cfg->tmdsclock;
+	inno->tmdsclock = tmdsclock;
+
+	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
+			 STF_INNO_BIAS_ENABLE, STF_INNO_BIAS_ENABLE);
+	inno_write(inno, STF_INNO_RX_CONTROL, STF_INNO_RX_ENABLE);
+
+	/* Find Post-PLL config */
+	for (; cfg->tmdsclock != 0; cfg++)
+		if (tmdsclock <= cfg->tmdsclock)
+			break;
+
+	if (cfg->tmdsclock == 0) {
+		dev_err(inno->dev, "Failed to find Post-PLL config\n");
+		return -EINVAL;
+	}
+	dev_dbg(inno->dev, "Inno HDMI PHY Power On: pixclk %lu, tmdsclk %lu\n",
+		inno->pixclock, tmdsclock);
+
+	reg_1ad_value = cfg->post_div_en ? cfg->postdiv : 0x00;
+	reg_1aa_value = cfg->post_div_en ? 0x0e : 0x02;
+
+	/*
+	 * Pre-PLL is already prepared and running at inno->pixclock
+	 * via the clk_set_rate and prepare calls from the controller/bridge.
+	 * Now, configure and enable the Post-PLL and TMDS outputs.
+	 */
+
+	inno_write(inno, STF_INNO_POST_PLL_DIV_2,
+		   STF_INNO_POST_PLL_PRE_DIV(cfg->prediv));
+	inno_write(inno, STF_INNO_POST_PLL_DIV_3, cfg->fbdiv & 0xff);
+	inno_write(inno, STF_INNO_POST_PLL_DIV_4, reg_1ad_value);
+
+	/* Power up Post-PLL */
+	inno_write(inno, STF_INNO_POST_PLL_DIV_1, reg_1aa_value);
+
+	/* Wait for post PLL lock */
+	ret = inno_poll(inno, STF_INNO_POST_PLL_LOCK_STATUS, v,
+			v & STF_INNO_POST_PLL_LOCK, 1000, 100000);
+	if (ret) {
+		dev_err(inno->dev, "Post-PLL locking failed\n");
+		return ret;
+	}
+
+	inno_write(inno, STF_INNO_LDO_CONTROL, STF_INNO_LDO_ENABLE);
+	inno_write(inno, STF_INNO_SERIALIER_CONTROL,
+		   STF_INNO_SERIALIER_ENABLE);
+	inno_write(inno, STF_INNO_TMDS_CONTROL, 0x8f);
+
+	return 0;
+}
+
+static int starfive_hdmi_phy_power_off(struct phy *phy)
+{
+	struct starfive_hdmi_phy *inno = phy_get_drvdata(phy);
+
+	dev_dbg(inno->dev, "Inno HDMI PHY Power Off\n");
+
+	inno_write(inno, STF_INNO_TMDS_CONTROL, 0x00);
+	inno_write(inno, STF_INNO_SERIALIER_CONTROL, 0x00);
+	inno_write(inno, STF_INNO_LDO_CONTROL, 0x00);
+	inno_update_bits(inno, STF_INNO_BIAS_CONTROL,
+			 STF_INNO_BIAS_ENABLE, 0x00);
+	inno_write(inno, STF_INNO_RX_CONTROL, 0x00);
+
+	/* Power down Post-PLL */
+	inno_update_bits(inno, STF_INNO_POST_PLL_DIV_1,
+			 STF_INNO_POST_PLL_POWER_DOWN,
+			 STF_INNO_POST_PLL_POWER_DOWN);
+
+	inno->tmdsclock = 0;
+	inno->pixclock = 0;
+
+	return 0;
+}
+
+static const struct phy_ops starfive_hdmi_phy_ops = {
+	.owner = THIS_MODULE,
+	.power_on = starfive_hdmi_phy_power_on,
+	.power_off = starfive_hdmi_phy_power_off,
+};
+
+static int starfive_hdmi_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	struct starfive_hdmi_phy *inno;
+	struct phy_provider *phy_provider;
+	struct regmap *regmap;
+	struct clk_init_data init = {};
+	const char *refoclk_name;
+	int ret;
+
+	inno = devm_kzalloc(dev, sizeof(*inno), GFP_KERNEL);
+	if (!inno)
+		return -ENOMEM;
+
+	inno->dev = dev;
+
+	/* Get the regmap from the parent device */
+	regmap = dev_get_regmap(parent, NULL);
+	if (!regmap) {
+		dev_err(dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+	inno->regmap = regmap;
+
+	/*
+	 * The PHY block sits behind the HDMI controller in the shared register
+	 * space, so the common pre-PLL helpers need a 0x100 register offset.
+	 */
+	inno->pre_pll.regmap = regmap;
+	inno->pre_pll.offset = 0x100;
+	inno->pre_pll.table = pre_pll_cfg_table;
+
+	/* Get the input reference clock */
+	inno->refoclk = devm_clk_get(inno->dev, "refoclk");
+	if (IS_ERR(inno->refoclk)) {
+		ret = PTR_ERR(inno->refoclk);
+		dev_err(inno->dev, "failed to get oscillator-ref clock: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* We must prepare/enable refoclk here so .set_rate/.recalc_rate work */
+	ret = clk_prepare_enable(inno->refoclk);
+	if (ret) {
+		dev_err(dev, "Failed to enable refoclk: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, inno);
+
+	/* Initialize and register the clock provider */
+	refoclk_name = __clk_get_name(inno->refoclk);
+	init.parent_names = &refoclk_name;
+	init.num_parents = 1;
+	init.flags = 0;
+	init.name = "hdmi_pclk";
+	init.ops = &starfive_hdmi_phy_clk_ops;
+
+	of_property_read_string(dev->of_node, "clock-output-names", &init.name);
+
+	inno->hw.init = &init;
+	inno->phyclk = devm_clk_register(dev, &inno->hw);
+	if (IS_ERR(inno->phyclk)) {
+		ret = PTR_ERR(inno->phyclk);
+		dev_err(dev, "Failed to register clock provider: %d\n", ret);
+		goto err_disable_refoclk;
+	}
+
+	ret = of_clk_add_provider(dev->of_node, of_clk_src_simple_get, inno->phyclk);
+	if (ret) {
+		dev_err(dev, "Failed to add clock provider: %d\n", ret);
+		goto err_disable_refoclk;
+	}
+
+	ret = clk_set_rate(inno->phyclk, 297000000);
+	if (ret) {
+		dev_err(dev, "Failed to set default rate: %d\n", ret);
+		goto err_disable_refoclk;
+	}
+
+	/* Create and register the PHY provider */
+	inno->phy = devm_phy_create(inno->dev, NULL, &starfive_hdmi_phy_ops);
+	if (IS_ERR(inno->phy)) {
+		ret = PTR_ERR(inno->phy);
+		dev_err(inno->dev, "failed to create HDMI PHY: %d\n", ret);
+		goto err_del_clk_provider;
+	}
+
+	phy_set_drvdata(inno->phy, inno);
+
+	phy_provider = devm_of_phy_provider_register(inno->dev,
+						     of_phy_simple_xlate);
+	ret = PTR_ERR_OR_ZERO(phy_provider);
+	if (ret)
+		goto err_del_clk_provider;
+
+	return 0;
+
+err_del_clk_provider:
+	of_clk_del_provider(dev->of_node);
+err_disable_refoclk:
+	clk_disable_unprepare(inno->refoclk);
+	return ret;
+}
+
+static void starfive_hdmi_phy_remove(struct platform_device *pdev)
+{
+	struct starfive_hdmi_phy *inno = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	clk_disable_unprepare(inno->refoclk);
+}
+
+static const struct of_device_id starfive_hdmi_phy_of_match[] = {
+	{ .compatible = "starfive,jh7110-inno-hdmi-phy", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, starfive_hdmi_phy_of_match);
+
+static struct platform_driver starfive_hdmi_phy_driver = {
+	.probe = starfive_hdmi_phy_probe,
+	.remove = starfive_hdmi_phy_remove,
+	.driver = {
+		.name = "starfive-inno-hdmi-phy",
+		.of_match_table = starfive_hdmi_phy_of_match,
+	},
+};
+module_platform_driver(starfive_hdmi_phy_driver);
+
+MODULE_AUTHOR("Michal Wilczynski <m.wilczynski@samsung.com>");
+MODULE_DESCRIPTION("StarFive JH7110 Innosilicon HDMI PHY Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

