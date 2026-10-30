Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F35606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BC210E862;
	Fri, 30 Oct 2026 07:48:21 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A741C10E844
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:48:18 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
 by APP-05 (Coremail) with SMTP id zQCowABn0TusS+RqhTm6DA--.1494S4;
 Fri, 30 Oct 2026 15:47:59 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Date: Fri, 30 Oct 2026 15:47:50 +0800
Subject: [PATCH 2/3] drm/bridge: dw-mipi-dsi: add PHY write function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-th1520-dw-mipi-dsi-v1-2-753f34fd304f@iscas.ac.cn>
References: <20261030-th1520-dw-mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn>
In-Reply-To: <20261030-th1520-dw-mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Icneowy Zheng <uwu@icenowy.me>, Han Gao <gaohan@iscas.ac.cn>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.15.0
X-CM-TRANSID: zQCowABn0TusS+RqhTm6DA--.1494S4
X-Coremail-Antispam: 1UD129KBjvJXoW3uw1kXr1rtrWfXrWDKFyUZFb_yoWkGF1DpF
 W3A348tFWDtrnrZrWxGF1kJr15Z3Z0qas2vr47Ga4DZan7Aw1UKa4j9FnxWr1rKa97ZrW5
 Zw47JryUXr4Iv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
 kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
 IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
 KfnxnUUI43ZEXa7sRREfO5UUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dw_mipi_dsi_phy_write() function in the rockchip glue code only
accesses registers defined in the DSI host controller, and the same
process is also present in the kirin dw_drm_dsi driver (which isn't
converted to use the common dw-mipi-dsi code yet) and downstream DSI
driver for T-Head TH1520.

Move this function from dw-mipi-dsi-rockchip driver to the common
dw-mipi-dsi code, and change "test code" (which seems to be the name
used for addresses by DW DPHY) to "address" (which seems to be the name
used by the DW DSI host controller).

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c   | 21 ++++++
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 86 ++++++++++---------------
 include/drm/bridge/dw_mipi_dsi.h                |  3 +
 3 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 5dd475fcaacf8..87f210ba113ee 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -1104,6 +1104,27 @@ static const struct drm_bridge_funcs dw_mipi_dsi_bridge_funcs = {
 	.attach			= dw_mipi_dsi_bridge_attach,
 };
 
+void dw_mipi_dsi_phy_write(struct dw_mipi_dsi *dsi, u8 addr, u8 data)
+{
+	/*
+	 * With the falling edge on TESTCLK, the TESTDIN[7:0] signal content
+	 * is latched internally as the current address. Data is programmed
+	 * internally by rising edge on TESTCLK.
+	 */
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
+
+	dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_TESTEN | PHY_TESTDOUT(0) |
+					  PHY_TESTDIN(addr));
+
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLK | PHY_UNTESTCLR);
+
+	dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_UNTESTEN | PHY_TESTDOUT(0) |
+					  PHY_TESTDIN(data));
+
+	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
+}
+EXPORT_SYMBOL_GPL(dw_mipi_dsi_phy_write);
+
 #ifdef CONFIG_DEBUG_FS
 
 static int dw_mipi_dsi_debugfs_write(void *data, u64 val)
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 268d4993a04fd..469123620f302 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -379,28 +379,6 @@ static inline void dsi_write(struct dw_mipi_dsi_rockchip *dsi, u32 reg, u32 val)
 	writel(val, dsi->base + reg);
 }
 
-static void dw_mipi_dsi_phy_write(struct dw_mipi_dsi_rockchip *dsi,
-				  u8 test_code,
-				  u8 test_data)
-{
-	/*
-	 * With the falling edge on TESTCLK, the TESTDIN[7:0] signal content
-	 * is latched internally as the current test code. Test data is
-	 * programmed internally by rising edge on TESTCLK.
-	 */
-	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
-
-	dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_TESTEN | PHY_TESTDOUT(0) |
-					  PHY_TESTDIN(test_code));
-
-	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLK | PHY_UNTESTCLR);
-
-	dsi_write(dsi, DSI_PHY_TST_CTRL1, PHY_UNTESTEN | PHY_TESTDOUT(0) |
-					  PHY_TESTDIN(test_data));
-
-	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLK | PHY_UNTESTCLR);
-}
-
 /*
  * ns2bc - Nanoseconds to byte clock cycles
  */
@@ -420,6 +398,7 @@ static inline unsigned int ns2ui(struct dw_mipi_dsi_rockchip *dsi, int ns)
 static int dw_mipi_dsi_phy_init(void *priv_data)
 {
 	struct dw_mipi_dsi_rockchip *dsi = priv_data;
+	struct dw_mipi_dsi *dmd = dsi->dmd;
 	int ret, i, vco;
 
 	if (dsi->phy)
@@ -453,24 +432,24 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
-	dw_mipi_dsi_phy_write(dsi, PLL_BIAS_CUR_SEL_CAP_VCO_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, PLL_BIAS_CUR_SEL_CAP_VCO_CONTROL,
 			      BYPASS_VCO_RANGE |
 			      VCO_RANGE_CON_SEL(vco) |
 			      VCO_IN_CAP_CON_LOW |
 			      REF_BIAS_CUR_SEL);
 
-	dw_mipi_dsi_phy_write(dsi, PLL_CP_CONTROL_PLL_LOCK_BYPASS,
+	dw_mipi_dsi_phy_write(dmd, PLL_CP_CONTROL_PLL_LOCK_BYPASS,
 			      CP_CURRENT_SEL(dppa_map[i].icpctrl));
-	dw_mipi_dsi_phy_write(dsi, PLL_LPF_AND_CP_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, PLL_LPF_AND_CP_CONTROL,
 			      CP_PROGRAM_EN | LPF_PROGRAM_EN |
 			      LPF_RESISTORS_SEL(dppa_map[i].lpfctrl));
 
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_0,
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_0,
 			      HSFREQRANGE_SEL(dppa_map[i].hsfreqrange));
 
-	dw_mipi_dsi_phy_write(dsi, PLL_INPUT_DIVIDER_RATIO,
+	dw_mipi_dsi_phy_write(dmd, PLL_INPUT_DIVIDER_RATIO,
 			      INPUT_DIVIDER(dsi->input_div));
-	dw_mipi_dsi_phy_write(dsi, PLL_LOOP_DIVIDER_RATIO,
+	dw_mipi_dsi_phy_write(dmd, PLL_LOOP_DIVIDER_RATIO,
 			      LOOP_DIV_LOW_SEL(dsi->feedback_div) |
 			      LOW_PROGRAM_EN);
 	/*
@@ -479,53 +458,53 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 	 * and lab test results.
 	 * Only in this way can we get correct mipi phy pll frequency.
 	 */
-	dw_mipi_dsi_phy_write(dsi, PLL_INPUT_AND_LOOP_DIVIDER_RATIOS_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, PLL_INPUT_AND_LOOP_DIVIDER_RATIOS_CONTROL,
 			      PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
-	dw_mipi_dsi_phy_write(dsi, PLL_LOOP_DIVIDER_RATIO,
+	dw_mipi_dsi_phy_write(dmd, PLL_LOOP_DIVIDER_RATIO,
 			      LOOP_DIV_HIGH_SEL(dsi->feedback_div) |
 			      HIGH_PROGRAM_EN);
-	dw_mipi_dsi_phy_write(dsi, PLL_INPUT_AND_LOOP_DIVIDER_RATIOS_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, PLL_INPUT_AND_LOOP_DIVIDER_RATIOS_CONTROL,
 			      PLL_LOOP_DIV_EN | PLL_INPUT_DIV_EN);
 
-	dw_mipi_dsi_phy_write(dsi, AFE_BIAS_BANDGAP_ANALOG_PROGRAMMABILITY,
+	dw_mipi_dsi_phy_write(dmd, AFE_BIAS_BANDGAP_ANALOG_PROGRAMMABILITY,
 			      LOW_PROGRAM_EN | BIASEXTR_SEL(BIASEXTR_127_7));
-	dw_mipi_dsi_phy_write(dsi, AFE_BIAS_BANDGAP_ANALOG_PROGRAMMABILITY,
+	dw_mipi_dsi_phy_write(dmd, AFE_BIAS_BANDGAP_ANALOG_PROGRAMMABILITY,
 			      HIGH_PROGRAM_EN | BANDGAP_SEL(BANDGAP_96_10));
 
-	dw_mipi_dsi_phy_write(dsi, BANDGAP_AND_BIAS_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, BANDGAP_AND_BIAS_CONTROL,
 			      POWER_CONTROL | INTERNAL_REG_CURRENT |
 			      BIAS_BLOCK_ON | BANDGAP_ON);
 
-	dw_mipi_dsi_phy_write(dsi, TERMINATION_RESISTER_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, TERMINATION_RESISTER_CONTROL,
 			      TER_RESISTOR_LOW | TER_CAL_DONE |
 			      SETRD_MAX | TER_RESISTORS_ON);
-	dw_mipi_dsi_phy_write(dsi, TERMINATION_RESISTER_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, TERMINATION_RESISTER_CONTROL,
 			      TER_RESISTOR_HIGH | LEVEL_SHIFTERS_ON |
 			      SETRD_MAX | POWER_MANAGE |
 			      TER_RESISTORS_ON);
 
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_REQUEST_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_REQUEST_STATE_TIME_CONTROL,
 			      TLP_PROGRAM_EN | ns2bc(dsi, 500));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_PREPARE_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_PREPARE_STATE_TIME_CONTROL,
 			      THS_PRE_PROGRAM_EN | ns2ui(dsi, 40));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_HS_ZERO_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_HS_ZERO_STATE_TIME_CONTROL,
 			      THS_ZERO_PROGRAM_EN | ns2bc(dsi, 300));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_TRAIL_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_TRAIL_STATE_TIME_CONTROL,
 			      THS_PRE_PROGRAM_EN | ns2ui(dsi, 100));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_EXIT_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_EXIT_STATE_TIME_CONTROL,
 			      BIT(5) | ns2bc(dsi, 100));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_CLOCK_LANE_POST_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_CLOCK_LANE_POST_TIME_CONTROL,
 			      BIT(5) | (ns2bc(dsi, 60) + 7));
 
-	dw_mipi_dsi_phy_write(dsi, HS_TX_DATA_LANE_REQUEST_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_DATA_LANE_REQUEST_STATE_TIME_CONTROL,
 			      TLP_PROGRAM_EN | ns2bc(dsi, 500));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_DATA_LANE_PREPARE_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_DATA_LANE_PREPARE_STATE_TIME_CONTROL,
 			      THS_PRE_PROGRAM_EN | (ns2ui(dsi, 50) + 20));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_DATA_LANE_HS_ZERO_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_DATA_LANE_HS_ZERO_STATE_TIME_CONTROL,
 			      THS_ZERO_PROGRAM_EN | (ns2bc(dsi, 140) + 2));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_DATA_LANE_TRAIL_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_DATA_LANE_TRAIL_STATE_TIME_CONTROL,
 			      THS_PRE_PROGRAM_EN | (ns2ui(dsi, 60) + 8));
-	dw_mipi_dsi_phy_write(dsi, HS_TX_DATA_LANE_EXIT_STATE_TIME_CONTROL,
+	dw_mipi_dsi_phy_write(dmd, HS_TX_DATA_LANE_EXIT_STATE_TIME_CONTROL,
 			      BIT(5) | ns2bc(dsi, 100));
 
 	clk_disable_unprepare(dsi->phy_cfg_clk);
@@ -1224,6 +1203,7 @@ static int dw_mipi_dsi_dphy_configure(struct phy *phy, union phy_configure_opts
 static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
 {
 	struct dw_mipi_dsi_rockchip *dsi = phy_get_drvdata(phy);
+	struct dw_mipi_dsi *dmd = dsi->dmd;
 	int i, ret;
 
 	DRM_DEV_DEBUG(dsi->dev, "lanes %d - data_rate_mbps %u\n",
@@ -1273,15 +1253,15 @@ static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
 	 * Configure hsfreqrange according to frequency values
 	 * Set clock lane and hsfreqrange by lane0(test code 0x44)
 	 */
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_CLK, 0);
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_0,
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_CLK, 0);
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_0,
 			      HSFREQRANGE_SEL(dppa_map[i].hsfreqrange));
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_1, 0);
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_2, 0);
-	dw_mipi_dsi_phy_write(dsi, HS_RX_CONTROL_OF_LANE_3, 0);
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_1, 0);
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_2, 0);
+	dw_mipi_dsi_phy_write(dmd, HS_RX_CONTROL_OF_LANE_3, 0);
 
 	/* Normal operation */
-	dw_mipi_dsi_phy_write(dsi, 0x0, 0);
+	dw_mipi_dsi_phy_write(dmd, 0x0, 0);
 
 	clk_disable_unprepare(dsi->phy_cfg_clk);
 	clk_disable_unprepare(dsi->grf_clk);
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index 65d5e68065e3d..16fa3ffd434f1 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -85,4 +85,7 @@ void dw_mipi_dsi_unbind(struct dw_mipi_dsi *dsi);
 void dw_mipi_dsi_set_slave(struct dw_mipi_dsi *dsi, struct dw_mipi_dsi *slave);
 struct drm_bridge *dw_mipi_dsi_get_bridge(struct dw_mipi_dsi *dsi);
 
+/* PHY configuration */
+void dw_mipi_dsi_phy_write(struct dw_mipi_dsi *dsi, u8 addr, u8 data);
+
 #endif /* __DW_MIPI_DSI__ */

-- 
2.56.0

