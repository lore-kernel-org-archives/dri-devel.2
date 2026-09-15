Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6A0C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A4910F3C5;
	Tue, 15 Sep 2026 15:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="eqaBRkuR";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C141210EC77
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:44 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153243euoutp0103ca0772ec9abbd9579a7bb046e38453~ViF3Jkdnw0793907939euoutp01R;
 Tue, 15 Sep 2026 15:32:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260915153243euoutp0103ca0772ec9abbd9579a7bb046e38453~ViF3Jkdnw0793907939euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486363;
 bh=99blLARXT9E/aqURHCmtIMvspk4XHYn2UhnhM430U64=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=eqaBRkuRAhaGpi3qjogiBcsxyIWkkaa6WSDihpH3oBMoRK1PfV4h6apRMY6gS+/UN
 ccfNj/6MvXTAwG0idKjGrcItH3W+Sb9KkYtRs4fWOgLZCdroPoAcPVvhxPtaEBu67a
 suupLQLOwpwAsJWLFlNeymbJjQ0wh0dJVLV+eYUI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8~ViF20IE8f1392813928eucas1p1M;
 Tue, 15 Sep 2026 15:32:42 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153241eusmtip136721d290a695f65d862da5909921a00~ViF1NFQUt0441604416eusmtip1q;
 Tue, 15 Sep 2026 15:32:41 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 15 Sep 2026 17:32:24 +0200
Subject: [PATCH v4 16/20] phy: Add common Innosilicon HDMI PHY helpers
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-jh7110-clean-send-v4-16-f0e4fd6f2cc8@samsung.com>
In-Reply-To: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>,  Icenowy Zheng
 <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8
X-EPHeader: CA
X-CMS-RootMailID: 20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153242eucas1p1394a6a5e272f106b9cab2a0f709ddeb8@eucas1p1.samsung.com>
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

The Innosilicon HDMI PHY IP is used by several SoCs. They differ in
where the PHY register block sits in the register space and in which
pixel clocks they support, but the pre-PLL programming sequence and the
layout of its registers are the same.

Add a small library holding that shared part: the pre-PLL configuration
table format, a lookup, clk_ops determine_rate and recalc_rate helpers,
and the pre-PLL register programming. Callers pass a regmap, a register
offset for the PHY block, and their own pixel clock table.

No driver uses it yet; the users are converted separately.

Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/phy/Kconfig               |   8 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-inno-hdmi.c       | 298 ++++++++++++++++++++++++++++++++++++++
 include/linux/phy/inno-hdmi-phy.h |  85 +++++++++++
 4 files changed, 392 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 19f3b7d12b7d492d16000fa52483dc5002590d7a..0e973b3b02a30704d339db9f15d4695bcbec1c75 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -168,6 +168,14 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
+config PHY_INNO_HDMI
+	tristate
+	depends on GENERIC_PHY
+	select REGMAP
+	help
+	  Common helpers for the Innosilicon HDMI PHY, shared by the SoC
+	  drivers that instantiate it. Selected by those drivers.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/apple/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index d7aa516bcc49e7662c9c9db421833fe591dfbc05..e93c473dfc6d837ed6ba540f0b0204a0d68d25bf 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PHY_COMMON_PROPS)		+= phy-common-props.o
 obj-$(CONFIG_PHY_COMMON_PROPS_TEST)	+= phy-common-props-test.o
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
 obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
+obj-$(CONFIG_PHY_INNO_HDMI)		+= phy-inno-hdmi.o
 obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
 obj-$(CONFIG_PHY_CAN_TRANSCEIVER)	+= phy-can-transceiver.o
 obj-$(CONFIG_PHY_ECONET_PCIE)		+= phy-econet-pcie.o
diff --git a/drivers/phy/phy-inno-hdmi.c b/drivers/phy/phy-inno-hdmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..77e745a87d22b5f3776593e642af1f03305bb67e
--- /dev/null
+++ b/drivers/phy/phy-inno-hdmi.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Common helpers for the Innosilicon HDMI PHY.
+ *
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ *
+ * Author: Zheng Yang <zhengyang@rock-chips.com>
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Derived from drivers/phy/rockchip/phy-rockchip-inno-hdmi.c.
+ *
+ * The same PHY IP is used by several SoCs, which differ in where the PHY
+ * register block sits and in the pixel clock table they support, but share
+ * the pre-PLL programming sequence.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include <linux/phy/inno-hdmi-phy.h>
+
+#define INNO_PRE_PLL_CONTROL			0xa0
+#define INNO_PRE_PLL_POWER_DOWN			BIT(0)
+#define INNO_PCLK_VCO_DIV_5_MASK		BIT(1)
+#define INNO_PCLK_VCO_DIV_5(x)			FIELD_PREP(BIT(1), x)
+
+#define INNO_PRE_PLL_DIV_1			0xa1
+#define INNO_PRE_PLL_PRE_DIV_MASK		GENMASK(5, 0)
+#define INNO_PRE_PLL_PRE_DIV(x)			FIELD_PREP(GENMASK(5, 0), x)
+
+#define INNO_PRE_PLL_DIV_2			0xa2
+#define INNO_SPREAD_SPECTRUM_MOD_DISABLE	BIT(6)
+#define INNO_PRE_PLL_FRAC_DIV_DISABLE		FIELD_PREP(GENMASK(5, 4), 3)
+#define INNO_PRE_PLL_FB_DIV_11_8_MASK		GENMASK(3, 0)
+#define INNO_PRE_PLL_FB_DIV_11_8(x)		FIELD_PREP(GENMASK(3, 0), (x) >> 8)
+
+#define INNO_PRE_PLL_DIV_3			0xa3
+#define INNO_PRE_PLL_FB_DIV_7_0(x)		FIELD_PREP(GENMASK(7, 0), x)
+
+#define INNO_PRE_PLL_TMDSCLK_DIV		0xa4
+#define INNO_PRE_PLL_TMDSCLK_DIV_C(x)		FIELD_PREP(GENMASK(1, 0), x)
+#define INNO_PRE_PLL_TMDSCLK_DIV_B(x)		FIELD_PREP(GENMASK(3, 2), x)
+#define INNO_PRE_PLL_TMDSCLK_DIV_A(x)		FIELD_PREP(GENMASK(5, 4), x)
+
+#define INNO_PCLK_DIV_AB			0xa5
+#define INNO_PCLK_DIV_B_MASK			GENMASK(6, 5)
+#define INNO_PCLK_DIV_B(x)			FIELD_PREP(GENMASK(6, 5), x)
+#define INNO_PCLK_DIV_A_MASK			GENMASK(4, 0)
+#define INNO_PCLK_DIV_A(x)			FIELD_PREP(GENMASK(4, 0), x)
+
+#define INNO_PCLK_DIV_CD			0xa6
+#define INNO_PCLK_DIV_C(x)			FIELD_PREP(GENMASK(6, 5), x)
+#define INNO_PCLK_DIV_D_MASK			GENMASK(4, 0)
+#define INNO_PCLK_DIV_D(x)			FIELD_PREP(GENMASK(4, 0), x)
+
+#define INNO_PRE_PLL_LOCK_STATUS		0xa9
+#define INNO_PRE_PLL_LOCK			BIT(0)
+
+#define INNO_PRE_PLL_FRAC_DIV_23_16		0xd1
+#define INNO_PRE_PLL_FRAC_DIV_15_8		0xd2
+#define INNO_PRE_PLL_FRAC_DIV_7_0		0xd3
+#define INNO_PRE_PLL_FRAC_DIV(x)		FIELD_PREP(GENMASK(7, 0), x)
+
+#define INNO_FRAC_DIV_WIDTH			24
+
+static unsigned int inno_reg(const struct inno_hdmi_phy_pre_pll *pll,
+			     unsigned int reg)
+{
+	return (pll->offset + reg) * 4;
+}
+
+static void inno_write(const struct inno_hdmi_phy_pre_pll *pll,
+		       unsigned int reg, u8 val)
+{
+	regmap_write(pll->regmap, inno_reg(pll, reg), val);
+}
+
+static u8 inno_read(const struct inno_hdmi_phy_pre_pll *pll, unsigned int reg)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(pll->regmap, inno_reg(pll, reg), &val);
+	if (ret)
+		return 0;
+
+	return val;
+}
+
+static void inno_update_bits(const struct inno_hdmi_phy_pre_pll *pll,
+			     unsigned int reg, u8 mask, u8 val)
+{
+	regmap_update_bits(pll->regmap, inno_reg(pll, reg), mask, val);
+}
+
+/**
+ * inno_hdmi_phy_pre_pll_lookup - find the settings for a pixel clock
+ * @pll: pre-PLL instance
+ * @pixclock: requested pixel clock, in Hz
+ * @tmdsclock: requested TMDS clock, in Hz
+ *
+ * Return: the matching table entry, or an ERR_PTR if the PHY cannot generate
+ * the requested combination.
+ */
+const struct inno_hdmi_phy_pre_pll_config *
+inno_hdmi_phy_pre_pll_lookup(const struct inno_hdmi_phy_pre_pll *pll,
+			     unsigned long pixclock, unsigned long tmdsclock)
+{
+	const struct inno_hdmi_phy_pre_pll_config *cfg;
+
+	for (cfg = pll->table; cfg->pixclock != 0; cfg++)
+		if (cfg->pixclock == pixclock && cfg->tmdsclock == tmdsclock)
+			return cfg;
+
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_lookup);
+
+/**
+ * inno_hdmi_phy_pre_pll_determine_rate - clk_ops.determine_rate helper
+ * @pll: pre-PLL instance
+ * @req: rate request, updated with the rate the PHY would produce
+ *
+ * The PHY can only generate the pixel clocks described by its table, so a
+ * request that does not appear there is rejected rather than rounded.
+ *
+ * Return: 0 on success, -EINVAL if the rate is not supported.
+ */
+int inno_hdmi_phy_pre_pll_determine_rate(const struct inno_hdmi_phy_pre_pll *pll,
+					 struct clk_rate_request *req)
+{
+	const struct inno_hdmi_phy_pre_pll_config *cfg;
+	unsigned long rate = rounddown(req->rate, 1000);
+
+	for (cfg = pll->table; cfg->pixclock != 0; cfg++) {
+		if (cfg->pixclock == rate) {
+			req->rate = cfg->pixclock;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_determine_rate);
+
+/**
+ * inno_hdmi_phy_pre_pll_recalc_rate - clk_ops.recalc_rate helper
+ * @pll: pre-PLL instance
+ * @parent_rate: rate of the reference clock, in Hz
+ *
+ * Return: the pixel clock the pre-PLL is currently programmed for, in Hz.
+ */
+unsigned long
+inno_hdmi_phy_pre_pll_recalc_rate(const struct inno_hdmi_phy_pre_pll *pll,
+				  unsigned long parent_rate)
+{
+	u8 nd, no_a, no_b, no_d;
+	unsigned long frac, rate;
+	u64 vco, vco_rate;
+	u16 nf;
+
+	nd = inno_read(pll, INNO_PRE_PLL_DIV_1) & INNO_PRE_PLL_PRE_DIV_MASK;
+	nf = (inno_read(pll, INNO_PRE_PLL_DIV_2) &
+	      INNO_PRE_PLL_FB_DIV_11_8_MASK) << 8;
+	nf |= inno_read(pll, INNO_PRE_PLL_DIV_3);
+	vco = parent_rate * nf;
+
+	if (!(inno_read(pll, INNO_PRE_PLL_DIV_2) &
+	      INNO_PRE_PLL_FRAC_DIV_DISABLE)) {
+		frac = inno_read(pll, INNO_PRE_PLL_FRAC_DIV_7_0) |
+		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_15_8) << 8) |
+		       (inno_read(pll, INNO_PRE_PLL_FRAC_DIV_23_16) << 16);
+		vco += DIV_ROUND_CLOSEST(parent_rate * frac,
+					 BIT(INNO_FRAC_DIV_WIDTH));
+	}
+
+	vco_rate = vco;
+
+	if (inno_read(pll, INNO_PRE_PLL_CONTROL) & INNO_PCLK_VCO_DIV_5_MASK) {
+		do_div(vco, nd * 5);
+	} else {
+		no_a = inno_read(pll, INNO_PCLK_DIV_AB) & INNO_PCLK_DIV_A_MASK;
+		no_b = FIELD_GET(INNO_PCLK_DIV_B_MASK,
+				 inno_read(pll, INNO_PCLK_DIV_AB)) + 2;
+		no_d = inno_read(pll, INNO_PCLK_DIV_CD) & INNO_PCLK_DIV_D_MASK;
+
+		do_div(vco, nd * (no_a == 1 ? no_b : no_a) * no_d * 2);
+	}
+
+	rate = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
+
+	/* The VCO is only in spec between 1.4 and 3.2 GHz, so log it. */
+	dev_dbg(pll->dev, "%s rate %lu vco %llu\n", __func__, rate, vco_rate);
+
+	return rate;
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_recalc_rate);
+
+/**
+ * inno_hdmi_phy_pre_pll_configure - program the pre-PLL dividers
+ * @pll: pre-PLL instance
+ * @cfg: settings to program
+ *
+ * The caller is responsible for powering the pre-PLL down beforehand and back
+ * up afterwards, and for waiting for it to lock.
+ */
+void inno_hdmi_phy_pre_pll_configure(const struct inno_hdmi_phy_pre_pll *pll,
+				     const struct inno_hdmi_phy_pre_pll_config *cfg)
+{
+	u8 val;
+
+	inno_update_bits(pll, INNO_PRE_PLL_CONTROL, INNO_PCLK_VCO_DIV_5_MASK,
+			 INNO_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
+	inno_write(pll, INNO_PRE_PLL_DIV_1, INNO_PRE_PLL_PRE_DIV(cfg->prediv));
+
+	val = INNO_SPREAD_SPECTRUM_MOD_DISABLE;
+	if (!cfg->fracdiv)
+		val |= INNO_PRE_PLL_FRAC_DIV_DISABLE;
+
+	inno_write(pll, INNO_PRE_PLL_DIV_2,
+		   INNO_PRE_PLL_FB_DIV_11_8(cfg->fbdiv) | val);
+	inno_write(pll, INNO_PRE_PLL_DIV_3,
+		   INNO_PRE_PLL_FB_DIV_7_0(cfg->fbdiv));
+
+	inno_write(pll, INNO_PCLK_DIV_AB,
+		   INNO_PCLK_DIV_A(cfg->pclk_div_a) |
+		   INNO_PCLK_DIV_B(cfg->pclk_div_b));
+	inno_write(pll, INNO_PCLK_DIV_CD,
+		   INNO_PCLK_DIV_C(cfg->pclk_div_c) |
+		   INNO_PCLK_DIV_D(cfg->pclk_div_d));
+
+	inno_write(pll, INNO_PRE_PLL_TMDSCLK_DIV,
+		   INNO_PRE_PLL_TMDSCLK_DIV_A(cfg->tmds_div_a) |
+		   INNO_PRE_PLL_TMDSCLK_DIV_B(cfg->tmds_div_b) |
+		   INNO_PRE_PLL_TMDSCLK_DIV_C(cfg->tmds_div_c));
+
+	inno_write(pll, INNO_PRE_PLL_FRAC_DIV_7_0,
+		   INNO_PRE_PLL_FRAC_DIV(cfg->fracdiv));
+	inno_write(pll, INNO_PRE_PLL_FRAC_DIV_15_8,
+		   INNO_PRE_PLL_FRAC_DIV(cfg->fracdiv >> 8));
+	inno_write(pll, INNO_PRE_PLL_FRAC_DIV_23_16,
+		   INNO_PRE_PLL_FRAC_DIV(cfg->fracdiv >> 16));
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_configure);
+
+/**
+ * inno_hdmi_phy_pre_pll_power_down - power the pre-PLL down or up
+ * @pll: pre-PLL instance
+ * @power_down: true to power down, false to power up
+ */
+void inno_hdmi_phy_pre_pll_power_down(const struct inno_hdmi_phy_pre_pll *pll,
+				      bool power_down)
+{
+	inno_update_bits(pll, INNO_PRE_PLL_CONTROL, INNO_PRE_PLL_POWER_DOWN,
+			 power_down ? INNO_PRE_PLL_POWER_DOWN : 0);
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_power_down);
+
+/**
+ * inno_hdmi_phy_pre_pll_is_locked - report whether the pre-PLL has locked
+ * @pll: pre-PLL instance
+ */
+bool inno_hdmi_phy_pre_pll_is_locked(const struct inno_hdmi_phy_pre_pll *pll)
+{
+	return inno_read(pll, INNO_PRE_PLL_LOCK_STATUS) & INNO_PRE_PLL_LOCK;
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_is_locked);
+
+/**
+ * inno_hdmi_phy_pre_pll_wait_locked - wait for the pre-PLL to lock
+ * @pll: pre-PLL instance
+ * @timeout_us: how long to wait, in microseconds
+ *
+ * Return: 0 once locked, -ETIMEDOUT otherwise.
+ */
+int inno_hdmi_phy_pre_pll_wait_locked(const struct inno_hdmi_phy_pre_pll *pll,
+				      unsigned int timeout_us)
+{
+	unsigned int val;
+
+	return regmap_read_poll_timeout(pll->regmap,
+					inno_reg(pll, INNO_PRE_PLL_LOCK_STATUS),
+					val, val & INNO_PRE_PLL_LOCK,
+					1000, timeout_us);
+}
+EXPORT_SYMBOL_GPL(inno_hdmi_phy_pre_pll_wait_locked);
+
+MODULE_DESCRIPTION("Innosilicon HDMI PHY common helpers");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/phy/inno-hdmi-phy.h b/include/linux/phy/inno-hdmi-phy.h
new file mode 100644
index 0000000000000000000000000000000000000000..4f243d883ea94f385b167fffd602e70d3e1a3759
--- /dev/null
+++ b/include/linux/phy/inno-hdmi-phy.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Common helpers for the Innosilicon HDMI PHY.
+ *
+ * Copyright (c) 2017 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2025 Samsung Electronics Co., Ltd.
+ *
+ * Author: Zheng Yang <zhengyang@rock-chips.com>
+ * Author: Michal Wilczynski <m.wilczynski@samsung.com>
+ *
+ * Derived from drivers/phy/rockchip/phy-rockchip-inno-hdmi.c.
+ */
+
+#ifndef __PHY_INNO_HDMI_H__
+#define __PHY_INNO_HDMI_H__
+
+#include <linux/types.h>
+
+struct clk_rate_request;
+struct regmap;
+
+/**
+ * struct inno_hdmi_phy_pre_pll_config - pre-PLL settings for one pixel clock
+ * @pixclock: pixel clock this entry describes, in Hz
+ * @tmdsclock: TMDS clock this entry describes, in Hz
+ * @prediv: pre-PLL reference divider
+ * @fbdiv: pre-PLL feedback divider
+ * @tmds_div_a: TMDS clock divider A
+ * @tmds_div_b: TMDS clock divider B
+ * @tmds_div_c: TMDS clock divider C
+ * @pclk_div_a: pixel clock divider A
+ * @pclk_div_b: pixel clock divider B
+ * @pclk_div_c: pixel clock divider C
+ * @pclk_div_d: pixel clock divider D
+ * @vco_div_5_en: divide the VCO output by five
+ * @fracdiv: pre-PLL fractional divider, zero to use integer mode
+ */
+struct inno_hdmi_phy_pre_pll_config {
+	unsigned long pixclock;
+	unsigned long tmdsclock;
+	u8 prediv;
+	u16 fbdiv;
+	u8 tmds_div_a;
+	u8 tmds_div_b;
+	u8 tmds_div_c;
+	u8 pclk_div_a;
+	u8 pclk_div_b;
+	u8 pclk_div_c;
+	u8 pclk_div_d;
+	u8 vco_div_5_en;
+	u32 fracdiv;
+};
+
+/**
+ * struct inno_hdmi_phy_pre_pll - a pre-PLL instance
+ * @regmap: register map covering the PHY registers
+ * @offset: offset of the PHY register block, in units of the register index.
+ *	    Zero where the PHY block starts the register space, 0x100 on the
+ *	    StarFive JH7110 where it is preceded by the HDMI controller.
+ * @table: pixel clock table, terminated by an entry with a zero pixclock
+ */
+struct inno_hdmi_phy_pre_pll {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned int offset;
+	const struct inno_hdmi_phy_pre_pll_config *table;
+};
+
+const struct inno_hdmi_phy_pre_pll_config *
+inno_hdmi_phy_pre_pll_lookup(const struct inno_hdmi_phy_pre_pll *pll,
+			     unsigned long pixclock, unsigned long tmdsclock);
+int inno_hdmi_phy_pre_pll_determine_rate(const struct inno_hdmi_phy_pre_pll *pll,
+					 struct clk_rate_request *req);
+unsigned long
+inno_hdmi_phy_pre_pll_recalc_rate(const struct inno_hdmi_phy_pre_pll *pll,
+				  unsigned long parent_rate);
+void inno_hdmi_phy_pre_pll_configure(const struct inno_hdmi_phy_pre_pll *pll,
+				     const struct inno_hdmi_phy_pre_pll_config *cfg);
+void inno_hdmi_phy_pre_pll_power_down(const struct inno_hdmi_phy_pre_pll *pll,
+				      bool power_down);
+bool inno_hdmi_phy_pre_pll_is_locked(const struct inno_hdmi_phy_pre_pll *pll);
+int inno_hdmi_phy_pre_pll_wait_locked(const struct inno_hdmi_phy_pre_pll *pll,
+				      unsigned int timeout_us);
+
+#endif /* __PHY_INNO_HDMI_H__ */

-- 
2.34.1

