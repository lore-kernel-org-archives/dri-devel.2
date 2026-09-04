Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEBEC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC8410F97E;
	Fri,  4 Sep 2026 13:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Jm7zqKuz";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7062310F957
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:27:41 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260904132740euoutp01b6e723df8c5cca308bcd9d5a13ed38b5~SISiTl4Uc0553305533euoutp01e;
 Fri,  4 Sep 2026 13:27:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260904132740euoutp01b6e723df8c5cca308bcd9d5a13ed38b5~SISiTl4Uc0553305533euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788528460;
 bh=bMPoEXnM3OtMovZpLrn10CfssLu/WAJSWDMUdwze/Dc=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Jm7zqKuzxfGxmQ0Ro63KBOZU+6049t44TZxV5yNbfa9HQRkb73NH6cEzZ8aD68hdi
 Tm7DKpfNMKt53eQOxKYc6z2cYA8WCxfGDc5qGHra7FMTEtxjzavhkfrb4WW+45yRd5
 7poH/uWhs7lq3/KOiX/uh9yIXt3o5c9mya+uxgvs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4~SISh3KsQY1937919379eucas1p2V;
 Fri,  4 Sep 2026 13:27:39 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260904132737eusmtip17ccc9dc6d263bf30afc66c9b0a8643d3~SISgMdJrL2098120981eusmtip1J;
 Fri,  4 Sep 2026 13:27:37 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 04 Sep 2026 15:27:17 +0200
Subject: [PATCH v3 16/19] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jh7110-clean-send-v3-16-484f9ae72715@samsung.com>
In-Reply-To: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
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
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4
X-EPHeader: CA
X-CMS-RootMailID: 20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4@eucas1p2.samsung.com>
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

The RK3328 pre-PLL programming, its table lookup and its recalc_rate and
determine_rate implementations are the generic Innosilicon ones, so drop
the local copies and use the shared helpers instead.

The RK3228 pre-PLL sits at different register addresses, so it keeps its
own register level code and only shares the table lookup.

The now unused RK3328 pre-PLL register macros go with it, as does the
local pre-PLL config lookup wrapper; both call sites already have the
TMDS clock to hand and call inno_hdmi_phy_pre_pll_lookup() directly.

The RK3328 recalc_rate used to log the pre-PLL output as "vco". The
shared helper logs it too, and reports the actual VCO frequency
alongside the rate, which is the value with the 1.4-3.2 GHz constraint.

The register writes, their order and the values written are unchanged.
No functional change intended.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/phy/rockchip/Kconfig                  |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 165 ++++----------------------
 2 files changed, 26 insertions(+), 140 deletions(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 14698571b607590dc0e7a29f3b39eb9a5d4e3d25..9732c5be87717dc3ddbea1c60080952336a07af9 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -34,6 +34,7 @@ config PHY_ROCKCHIP_INNO_HDMI
 	depends on COMMON_CLK
 	depends on HAS_IOMEM
 	select GENERIC_PHY
+	select PHY_INNO_HDMI
 	help
 	  Enable this to support the Rockchip Innosilicon HDMI PHY.
 
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index c3d257a0f4a65b4c475ed7246568dd463b46ed86..17229d039132e90d46097d875531eb70385b6687 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/phy/inno-hdmi-phy.h>
 #include <linux/phy/phy.h>
 #include <linux/slab.h>
 
@@ -130,42 +131,17 @@
 #define RK3328_INT_VSS_AGND_ESD_DET			BIT(1)
 #define RK3328_INT_AGND_VSS_ESD_DET			BIT(0)
 /* REG: 0xa0 */
-#define RK3328_PCLK_VCO_DIV_5_MASK			BIT(1)
-#define RK3328_PCLK_VCO_DIV_5(x)			UPDATE(x, 1, 1)
 #define RK3328_PRE_PLL_POWER_DOWN			BIT(0)
 /* REG: 0xa1 */
-#define RK3328_PRE_PLL_PRE_DIV_MASK			GENMASK(5, 0)
-#define RK3328_PRE_PLL_PRE_DIV(x)			UPDATE(x, 5, 0)
 /* REG: 0xa2 */
 /* unset means center spread */
 #define RK3328_SPREAD_SPECTRUM_MOD_DOWN			BIT(7)
 #define RK3328_SPREAD_SPECTRUM_MOD_DISABLE		BIT(6)
-#define RK3328_PRE_PLL_FRAC_DIV_DISABLE			UPDATE(3, 5, 4)
-#define RK3328_PRE_PLL_FB_DIV_11_8_MASK			GENMASK(3, 0)
-#define RK3328_PRE_PLL_FB_DIV_11_8(x)			UPDATE((x) >> 8, 3, 0)
 /* REG: 0xa3 */
-#define RK3328_PRE_PLL_FB_DIV_7_0(x)			UPDATE(x, 7, 0)
 /* REG: 0xa4*/
-#define RK3328_PRE_PLL_TMDSCLK_DIV_C_MASK		GENMASK(1, 0)
-#define RK3328_PRE_PLL_TMDSCLK_DIV_C(x)			UPDATE(x, 1, 0)
-#define RK3328_PRE_PLL_TMDSCLK_DIV_B_MASK		GENMASK(3, 2)
-#define RK3328_PRE_PLL_TMDSCLK_DIV_B(x)			UPDATE(x, 3, 2)
-#define RK3328_PRE_PLL_TMDSCLK_DIV_A_MASK		GENMASK(5, 4)
-#define RK3328_PRE_PLL_TMDSCLK_DIV_A(x)			UPDATE(x, 5, 4)
 /* REG: 0xa5 */
-#define RK3328_PRE_PLL_PCLK_DIV_B_SHIFT			5
-#define RK3328_PRE_PLL_PCLK_DIV_B_MASK			GENMASK(6, 5)
-#define RK3328_PRE_PLL_PCLK_DIV_B(x)			UPDATE(x, 6, 5)
-#define RK3328_PRE_PLL_PCLK_DIV_A_MASK			GENMASK(4, 0)
-#define RK3328_PRE_PLL_PCLK_DIV_A(x)			UPDATE(x, 4, 0)
 /* REG: 0xa6 */
-#define RK3328_PRE_PLL_PCLK_DIV_C_SHIFT			5
-#define RK3328_PRE_PLL_PCLK_DIV_C_MASK			GENMASK(6, 5)
-#define RK3328_PRE_PLL_PCLK_DIV_C(x)			UPDATE(x, 6, 5)
-#define RK3328_PRE_PLL_PCLK_DIV_D_MASK			GENMASK(4, 0)
-#define RK3328_PRE_PLL_PCLK_DIV_D(x)			UPDATE(x, 4, 0)
 /* REG: 0xa9 */
-#define RK3328_PRE_PLL_LOCK_STATUS			BIT(0)
 /* REG: 0xaa */
 #define RK3328_POST_PLL_POST_DIV_ENABLE			GENMASK(3, 2)
 #define RK3328_POST_PLL_REFCLK_SEL_TMDS			BIT(1)
@@ -218,11 +194,8 @@
 #define RK3328_TMDS_TERM_RESIST_1000			BIT(1)
 #define RK3328_TMDS_TERM_RESIST_2000			BIT(0)
 /* REG: 0xd1 */
-#define RK3328_PRE_PLL_FRAC_DIV_23_16(x)		UPDATE((x) >> 16, 7, 0)
 /* REG: 0xd2 */
-#define RK3328_PRE_PLL_FRAC_DIV_15_8(x)			UPDATE((x) >> 8, 7, 0)
 /* REG: 0xd3 */
-#define RK3328_PRE_PLL_FRAC_DIV_7_0(x)			UPDATE(x, 7, 0)
 
 struct inno_hdmi_phy_drv_data;
 
@@ -240,6 +213,8 @@ struct inno_hdmi_phy {
 	const struct inno_hdmi_phy_drv_data *plat_data;
 	int chip_version;
 
+	struct inno_hdmi_phy_pre_pll pre_pll;
+
 	/* clk provider */
 	struct clk_hw hw;
 	struct clk *phyclk;
@@ -248,21 +223,6 @@ struct inno_hdmi_phy {
 	unsigned long opts_tmds_char_rate;
 };
 
-struct pre_pll_config {
-	unsigned long pixclock;
-	unsigned long tmdsclock;
-	u8 prediv;
-	u16 fbdiv;
-	u8 tmds_div_a;
-	u8 tmds_div_b;
-	u8 tmds_div_c;
-	u8 pclk_div_a;
-	u8 pclk_div_b;
-	u8 pclk_div_c;
-	u8 pclk_div_d;
-	u8 vco_div_5_en;
-	u32 fracdiv;
-};
 
 struct post_pll_config {
 	unsigned long tmdsclock;
@@ -291,7 +251,7 @@ struct inno_hdmi_phy_drv_data {
 	const struct phy_config		*phy_cfg_table;
 };
 
-static const struct pre_pll_config pre_pll_cfg_table[] = {
+static const struct inno_hdmi_phy_pre_pll_config pre_pll_cfg_table[] = {
 	{ 25175000,  25175000,  3,  125, 3, 1, 1,  1, 3, 3,  4, 0, 0xe00000},
 	{ 25175000,  31468750,  1,   41, 0, 3, 3,  1, 3, 3,  4, 0, 0xf5554f},
 	{ 27000000,  27000000,  1,   36, 0, 3, 3,  1, 2, 3,  4, 0,      0x0},
@@ -603,7 +563,7 @@ static irqreturn_t inno_hdmi_phy_rk3328_irq(int irq, void *dev_id)
 static int inno_hdmi_phy_validate(struct phy *phy, enum phy_mode mode,
 				  int submode, union phy_configure_opts *opts)
 {
-	const struct pre_pll_config *cfg = pre_pll_cfg_table;
+	const struct inno_hdmi_phy_pre_pll_config *cfg = pre_pll_cfg_table;
 	unsigned long tmdsclock;
 
 	if (!(mode == PHY_MODE_HDMI && submode == PHY_HDMI_MODE_TMDS))
@@ -717,23 +677,6 @@ static const struct phy_ops inno_hdmi_phy_ops = {
 	.validate = inno_hdmi_phy_validate,
 };
 
-static const
-struct pre_pll_config *inno_hdmi_phy_get_pre_pll_cfg(struct inno_hdmi_phy *inno,
-						     unsigned long rate)
-{
-	const struct pre_pll_config *cfg = pre_pll_cfg_table;
-	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
-
-	for (; cfg->pixclock != 0; cfg++)
-		if (cfg->pixclock == rate && cfg->tmdsclock == tmdsclock)
-			break;
-
-	if (cfg->pixclock == 0)
-		return ERR_PTR(-EINVAL);
-
-	return cfg;
-}
-
 static int inno_hdmi_phy_rk3228_clk_is_prepared(struct clk_hw *hw)
 {
 	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
@@ -797,7 +740,7 @@ unsigned long inno_hdmi_phy_rk3228_clk_recalc_rate(struct clk_hw *hw,
 static int inno_hdmi_phy_rk3228_clk_determine_rate(struct clk_hw *hw,
 						   struct clk_rate_request *req)
 {
-	const struct pre_pll_config *cfg = pre_pll_cfg_table;
+	const struct inno_hdmi_phy_pre_pll_config *cfg = pre_pll_cfg_table;
 
 	req->rate = (req->rate / 1000) * 1000;
 
@@ -818,7 +761,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
 	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
-	const struct pre_pll_config *cfg;
+	const struct inno_hdmi_phy_pre_pll_config *cfg;
 	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
 	u32 v;
 	int ret;
@@ -829,7 +772,7 @@ static int inno_hdmi_phy_rk3228_clk_set_rate(struct clk_hw *hw,
 	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
 		return 0;
 
-	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
+	cfg = inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, rate, tmdsclock);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
@@ -915,39 +858,11 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 						   unsigned long parent_rate)
 {
 	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
-	unsigned long frac;
-	u8 nd, no_a, no_b, no_d;
-	u64 vco;
-	u16 nf;
-
-	nd = inno_read(inno, 0xa1) & RK3328_PRE_PLL_PRE_DIV_MASK;
-	nf = ((inno_read(inno, 0xa2) & RK3328_PRE_PLL_FB_DIV_11_8_MASK) << 8);
-	nf |= inno_read(inno, 0xa3);
-	vco = parent_rate * nf;
-
-	if (!(inno_read(inno, 0xa2) & RK3328_PRE_PLL_FRAC_DIV_DISABLE)) {
-		frac = inno_read(inno, 0xd3) |
-		       (inno_read(inno, 0xd2) << 8) |
-		       (inno_read(inno, 0xd1) << 16);
-		vco += DIV_ROUND_CLOSEST(parent_rate * frac, (1 << 24));
-	}
-
-	if (inno_read(inno, 0xa0) & RK3328_PCLK_VCO_DIV_5_MASK) {
-		do_div(vco, nd * 5);
-	} else {
-		no_a = inno_read(inno, 0xa5) & RK3328_PRE_PLL_PCLK_DIV_A_MASK;
-		no_b = inno_read(inno, 0xa5) & RK3328_PRE_PLL_PCLK_DIV_B_MASK;
-		no_b >>= RK3328_PRE_PLL_PCLK_DIV_B_SHIFT;
-		no_b += 2;
-		no_d = inno_read(inno, 0xa6) & RK3328_PRE_PLL_PCLK_DIV_D_MASK;
-
-		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
-	}
 
-	inno->pixclock = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
+	inno->pixclock = inno_hdmi_phy_pre_pll_recalc_rate(&inno->pre_pll,
+							   parent_rate);
 
-	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
-		__func__, inno->pixclock, vco);
+	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
 
 	return inno->pixclock;
 }
@@ -955,20 +870,9 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 static int inno_hdmi_phy_rk3328_clk_determine_rate(struct clk_hw *hw,
 						   struct clk_rate_request *req)
 {
-	const struct pre_pll_config *cfg = pre_pll_cfg_table;
-
-	req->rate = (req->rate / 1000) * 1000;
-
-	for (; cfg->pixclock != 0; cfg++)
-		if (cfg->pixclock == req->rate)
-			break;
-
-	if (cfg->pixclock == 0)
-		return -EINVAL;
-
-	req->rate = cfg->pixclock;
+	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
 
-	return 0;
+	return inno_hdmi_phy_pre_pll_determine_rate(&inno->pre_pll, req);
 }
 
 static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
@@ -976,9 +880,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
 	struct inno_hdmi_phy *inno = to_inno_hdmi_phy(hw);
-	const struct pre_pll_config *cfg;
+	const struct inno_hdmi_phy_pre_pll_config *cfg;
 	unsigned long tmdsclock = inno_hdmi_phy_get_tmdsclk(inno, rate);
-	u32 val;
 	int ret;
 
 	dev_dbg(inno->dev, "%s rate %lu tmdsclk %lu\n",
@@ -987,39 +890,15 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 	if (inno->pixclock == rate && inno->tmdsclock == tmdsclock)
 		return 0;
 
-	cfg = inno_hdmi_phy_get_pre_pll_cfg(inno, rate);
+	cfg = inno_hdmi_phy_pre_pll_lookup(&inno->pre_pll, rate, tmdsclock);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN,
-			 RK3328_PRE_PLL_POWER_DOWN);
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, true);
+	inno_hdmi_phy_pre_pll_configure(&inno->pre_pll, cfg);
+	inno_hdmi_phy_pre_pll_power_down(&inno->pre_pll, false);
 
-	/* Configure pre-pll */
-	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
-			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
-	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
-
-	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
-	if (!cfg->fracdiv)
-		val |= RK3328_PRE_PLL_FRAC_DIV_DISABLE;
-	inno_write(inno, 0xa2, RK3328_PRE_PLL_FB_DIV_11_8(cfg->fbdiv) | val);
-	inno_write(inno, 0xa3, RK3328_PRE_PLL_FB_DIV_7_0(cfg->fbdiv));
-	inno_write(inno, 0xa5, RK3328_PRE_PLL_PCLK_DIV_A(cfg->pclk_div_a) |
-		   RK3328_PRE_PLL_PCLK_DIV_B(cfg->pclk_div_b));
-	inno_write(inno, 0xa6, RK3328_PRE_PLL_PCLK_DIV_C(cfg->pclk_div_c) |
-		   RK3328_PRE_PLL_PCLK_DIV_D(cfg->pclk_div_d));
-	inno_write(inno, 0xa4, RK3328_PRE_PLL_TMDSCLK_DIV_C(cfg->tmds_div_c) |
-		   RK3328_PRE_PLL_TMDSCLK_DIV_A(cfg->tmds_div_a) |
-		   RK3328_PRE_PLL_TMDSCLK_DIV_B(cfg->tmds_div_b));
-	inno_write(inno, 0xd3, RK3328_PRE_PLL_FRAC_DIV_7_0(cfg->fracdiv));
-	inno_write(inno, 0xd2, RK3328_PRE_PLL_FRAC_DIV_15_8(cfg->fracdiv));
-	inno_write(inno, 0xd1, RK3328_PRE_PLL_FRAC_DIV_23_16(cfg->fracdiv));
-
-	inno_update_bits(inno, 0xa0, RK3328_PRE_PLL_POWER_DOWN, 0);
-
-	/* Wait for Pre-PLL lock */
-	ret = inno_poll(inno, 0xa9, val, val & RK3328_PRE_PLL_LOCK_STATUS,
-			1000, 10000);
+	ret = inno_hdmi_phy_pre_pll_wait_locked(&inno->pre_pll, 10000);
 	if (ret) {
 		dev_err(inno->dev, "Pre-PLL locking failed\n");
 		return ret;
@@ -1418,6 +1297,12 @@ static int inno_hdmi_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(inno->regmap))
 		return PTR_ERR(inno->regmap);
 
+	/* The PHY block starts the register space on these SoCs. */
+	inno->pre_pll.dev = inno->dev;
+	inno->pre_pll.regmap = inno->regmap;
+	inno->pre_pll.offset = 0;
+	inno->pre_pll.table = pre_pll_cfg_table;
+
 	/* only the newer rk3328 hdmiphy has an interrupt */
 	inno->irq = platform_get_irq(pdev, 0);
 	if (inno->irq > 0) {

-- 
2.34.1

