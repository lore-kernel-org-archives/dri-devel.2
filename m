Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB95CDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A1310EDC3;
	Wed, 24 Jun 2026 07:47:57 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3BF10E73C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowAAntQickTpqQFPYFA--.16384S2;
 Tue, 23 Jun 2026 22:01:01 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Jayesh Choudhary <j-choudhary@ti.com>, Kees Cook <kees@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/bridge: cdns-dsi: stop pre-enable after PHY wait
 failures
Date: Tue, 23 Jun 2026 22:01:00 +0800
Message-ID: <20260623140100.67140-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAntQickTpqQFPYFA--.16384S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryxWw18AF45ZF18AF13Arb_yoW7JF1rpF
 Wjg34UKr4vqFn7WaykGr4UJr45Aw4vkayfArZ7Cw1Svw1vgF1DZFyDtrWUZFnYgFykJFW3
 AFykJa4UWr1ktF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
 1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
 BIdaVFxhVjvjDU0xZFpf9x0pRc6p9UUUUU=
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

cdns_dsi_hs_init() ignored PHY API failures and converted the PLL-lock
wait into a WARN_ON_ONCE(). The bridge pre-enable path also only logged
a lane-ready timeout and then continued programming video registers and
enabling the interface.

Return errors from the PHY initialization helper, unwind the PHY when
initialization fails, and stop bridge pre-enable when either the PLL or
lane-ready wait fails. The bridge hook is still void, so this is
intended as an RFC patch for maintainer review of the failure policy.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 67 +++++++++++++++++--
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cf90d4468..86f31eb46 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -631,13 +631,14 @@ static void cdns_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	pm_runtime_put(dsi->base.dev);
 }
 
-static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
+static int cdns_dsi_hs_init(struct cdns_dsi *dsi)
 {
 	struct cdns_dsi_output *output = &dsi->output;
 	u32 status;
+	int ret;
 
 	if (dsi->phy_initialized)
-		return;
+		return 0;
 	/*
 	 * Power all internal DPHY blocks down and maintain their reset line
 	 * asserted before changing the DPHY config.
@@ -646,22 +647,45 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 	       DPHY_CMN_PDN | DPHY_PLL_PDN,
 	       dsi->regs + MCTL_DPHY_CFG0);
 
-	phy_init(dsi->dphy);
-	phy_set_mode(dsi->dphy, PHY_MODE_MIPI_DPHY);
-	phy_configure(dsi->dphy, &output->phy_opts);
-	phy_power_on(dsi->dphy);
+	ret = phy_init(dsi->dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_set_mode(dsi->dphy, PHY_MODE_MIPI_DPHY);
+	if (ret)
+		goto err_phy_exit;
+
+	ret = phy_configure(dsi->dphy, &output->phy_opts);
+	if (ret)
+		goto err_phy_exit;
+
+	ret = phy_power_on(dsi->dphy);
+	if (ret)
+		goto err_phy_exit;
 
 	/* Activate the PLL and wait until it's locked. */
 	writel(PLL_LOCKED, dsi->regs + MCTL_MAIN_STS_CLR);
 	writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN,
 	       dsi->regs + MCTL_DPHY_CFG0);
-	WARN_ON_ONCE(readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
-					status & PLL_LOCKED, 100, 100));
+	ret = readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
+				 status & PLL_LOCKED, 100, 100);
+	if (ret)
+		goto err_phy_power_off;
+
 	/* De-assert data and clock reset lines. */
 	writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN |
 	       DPHY_D_RSTB(output->dev->lanes) | DPHY_C_RSTB,
 	       dsi->regs + MCTL_DPHY_CFG0);
 	dsi->phy_initialized = true;
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(dsi->dphy);
+err_phy_exit:
+	phy_exit(dsi->dphy);
+
+	return ret;
 }
 
 static void cdns_dsi_init_link(struct cdns_dsi *dsi)
@@ -716,7 +740,7 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
 	u32 tmp, reg_wakeup, div, status;
-	int nlanes;
+	int nlanes, ret;
 
 	/*
 	 * The cdns-dsi controller needs to be enabled before it's DPI source
@@ -753,7 +777,12 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	nlanes = output->dev->lanes;
 
 	cdns_dsi_init_link(dsi);
-	cdns_dsi_hs_init(dsi);
+	ret = cdns_dsi_hs_init(dsi);
+	if (ret) {
+		dev_err(dsi->base.dev, "failed to initialize DSI PHY: %d\n",
+			ret);
+		goto err_disable;
+	}
 
 	/*
 	 * Now that the DSI Link and DSI Phy are initialized,
@@ -763,10 +792,13 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	for (int i = 0; i < nlanes; i++)
 		tmp |= DATA_LANE_RDY(i);
 
-	if (readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
-			       (tmp == (status & tmp)), 100, 500000))
+	ret = readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
+				 (tmp == (status & tmp)), 100, 500000);
+	if (ret) {
 		dev_err(dsi->base.dev,
 			"Timed Out: DSI-DPhy Clock and Data Lanes not ready.\n");
+		goto err_disable;
+	}
 
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
@@ -886,6 +918,19 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	tmp = readl(dsi->regs + MCTL_MAIN_EN) | IF_EN(input->id);
 	writel(tmp, dsi->regs + MCTL_MAIN_EN);
+
+	return;
+
+err_disable:
+	if (dsi->phy_initialized) {
+		dsi->phy_initialized = false;
+		phy_power_off(dsi->dphy);
+		phy_exit(dsi->dphy);
+	}
+	dsi->link_initialized = false;
+	if (dsi->platform_ops && dsi->platform_ops->disable)
+		dsi->platform_ops->disable(dsi);
+	pm_runtime_put(dsi->base.dev);
 }
 
 static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
-- 
2.50.1 (Apple Git-155)

