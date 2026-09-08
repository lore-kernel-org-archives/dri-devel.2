Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA58C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9171D10E1A5;
	Tue,  8 Sep 2026 17:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="KGcdgBRC";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AEF10E1A5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Subject:To:From:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=HwAyhbQaFFlp0BFd/78gbqtvbPMzaIfRrBAF3Kv9kYk=; t=1788888250; x=1790097850; 
 b=KGcdgBRCz5igu/fBv/imae3anXO9O8dCpJ9DoictWmrgQPqyoAp4G8I4xXdZfITme358zTerVMW
 6TNmWUZ7Cll+/iW9y2xOEJAxm+54NXUrg7tpNQeUDqe+UjRqeawniImb7ztGXH2NbAWPl7eFfV9GI
 zDqOlzUeGzMzRE4otOmR8r2ws69U+nQeZBG3s0ONk12T52wn6ddJLJvfRIu1+lCIU4Jy9FHlu7lt9
 Hm/oMISkOQpP7dG4fpgJ02ELQlp0OvwO1FlB82Zrz4DBxHiKElwroptz1+8a1h5iC4vFLm4Y2aRRJ
 p0TbGYzK9+5hLKq+mt9BMtPpLa7VRgGH/s1w==;
From: Andreas Kemnade <andreas@kemnade.info>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, andreas@kemnade.info, kees@kernel.org,
 luca.ceresoli@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omap: dsi: print errors with device prefix
Date: Tue,  8 Sep 2026 19:22:13 +0200
Message-ID: <20260908172213.446608-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are two dsi controllers on OMAP4/5. If both are in use, messages
without device prefix have no indication which controller they are coming
from. That makes debugging harder.
Replace DSSERR/DBG macros with dev_-prefixed print functions where
the device is reliably accessible.
Also replace function names by %s ... __func__ constructs and remove
some debug outputs to satisfy checkpatch.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 303 +++++++++++++++---------------
 1 file changed, 149 insertions(+), 154 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index a57f5df5c8305..8e28879cec88b 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -339,7 +339,7 @@ static void dsi_handle_irq_errors(struct dsi_data *dsi, u32 irqstatus,
 	int i;
 
 	if (irqstatus & DSI_IRQ_ERROR_MASK) {
-		DSSERR("DSI error, irqstatus %x\n", irqstatus);
+		dev_err(dsi->dev, "DSI error, irqstatus %x\n", irqstatus);
 		print_irq_status(irqstatus);
 		spin_lock(&dsi->errors_lock);
 		dsi->errors |= irqstatus & DSI_IRQ_ERROR_MASK;
@@ -350,8 +350,8 @@ static void dsi_handle_irq_errors(struct dsi_data *dsi, u32 irqstatus,
 
 	for (i = 0; i < 4; ++i) {
 		if (vcstatus[i] & DSI_VC_IRQ_ERROR_MASK) {
-			DSSERR("DSI VC(%d) error, vc irqstatus %x\n",
-				       i, vcstatus[i]);
+			dev_err(dsi->dev, "DSI VC(%d) error, vc irqstatus %x\n",
+				i, vcstatus[i]);
 			print_irq_status_vc(i, vcstatus[i]);
 		} else if (debug_irq) {
 			print_irq_status_vc(i, vcstatus[i]);
@@ -359,7 +359,7 @@ static void dsi_handle_irq_errors(struct dsi_data *dsi, u32 irqstatus,
 	}
 
 	if (ciostatus & DSI_CIO_IRQ_ERROR_MASK) {
-		DSSERR("DSI CIO error, cio irqstatus %x\n", ciostatus);
+		dev_err(dsi->dev, "DSI CIO error, cio irqstatus %x\n", ciostatus);
 		print_irq_status_cio(ciostatus);
 	} else if (debug_irq) {
 		print_irq_status_cio(ciostatus);
@@ -695,8 +695,6 @@ static int dsi_runtime_get(struct dsi_data *dsi)
 {
 	int r;
 
-	DSSDBG("dsi_runtime_get\n");
-
 	r = pm_runtime_get_sync(dsi->dev);
 	if (WARN_ON(r < 0)) {
 		pm_runtime_put_noidle(dsi->dev);
@@ -709,8 +707,6 @@ static void dsi_runtime_put(struct dsi_data *dsi)
 {
 	int r;
 
-	DSSDBG("dsi_runtime_put\n");
-
 	r = pm_runtime_put_sync(dsi->dev);
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
@@ -752,13 +748,13 @@ static void _dsi_print_reset_status(struct dsi_data *dsi)
 
 static inline int dsi_if_enable(struct dsi_data *dsi, bool enable)
 {
-	DSSDBG("dsi_if_enable(%d)\n", enable);
+	dev_dbg(dsi->dev, "dsi_if_enable(%d)\n", enable);
 
 	enable = enable ? 1 : 0;
 	REG_FLD_MOD(dsi, DSI_CTRL, enable, 0, 0); /* IF_EN */
 
 	if (!wait_for_bit_change(dsi, DSI_CTRL, 0, enable)) {
-		DSSERR("Failed to set dsi_if_enable to %d\n", enable);
+		dev_err(dsi->dev, "Failed to set dsi_if_enable to %d\n", enable);
 		return -EIO;
 	}
 
@@ -833,7 +829,7 @@ static int dsi_set_lp_clk_divisor(struct dsi_data *dsi)
 
 	lp_clk = dsi_fclk / 2 / lp_clk_div;
 
-	DSSDBG("LP_CLK_DIV %u, LP_CLK %lu\n", lp_clk_div, lp_clk);
+	dev_dbg(dsi->dev, "LP_CLK_DIV %u, LP_CLK %lu\n", lp_clk_div, lp_clk);
 	dsi->current_lp_cinfo.lp_clk = lp_clk;
 	dsi->current_lp_cinfo.lp_clk_div = lp_clk_div;
 
@@ -881,8 +877,8 @@ static int dsi_pll_power(struct dsi_data *dsi, enum dsi_pll_power_state state)
 	/* PLL_PWR_STATUS */
 	while (FLD_GET(dsi_read_reg(dsi, DSI_CLK_CTRL), 29, 28) != state) {
 		if (++t > 1000) {
-			DSSERR("Failed to set DSI PLL power mode to %d\n",
-					state);
+			dev_err(dsi->dev, "Failed to set DSI PLL power mode to %d\n",
+				state);
 			return -ENODEV;
 		}
 		udelay(1);
@@ -908,7 +904,7 @@ static int dsi_pll_enable(struct dss_pll *pll)
 	struct dsi_data *dsi = container_of(pll, struct dsi_data, pll);
 	int r = 0;
 
-	DSSDBG("PLL init\n");
+	dev_dbg(dsi->dev, "PLL init\n");
 
 	r = dsi_runtime_get(dsi);
 	if (r)
@@ -927,7 +923,7 @@ static int dsi_pll_enable(struct dss_pll *pll)
 	dispc_pck_free_enable(dsi->dss->dispc, 1);
 
 	if (!wait_for_bit_change(dsi, DSI_PLL_STATUS, 0, 1)) {
-		DSSERR("PLL not coming out of reset.\n");
+		dev_err(dsi->dev, "PLL not coming out of reset.\n");
 		r = -ENODEV;
 		dispc_pck_free_enable(dsi->dss->dispc, 0);
 		goto err1;
@@ -942,7 +938,7 @@ static int dsi_pll_enable(struct dss_pll *pll)
 	if (r)
 		goto err1;
 
-	DSSDBG("PLL init done\n");
+	dev_dbg(dsi->dev, "PLL init done\n");
 
 	return 0;
 err1:
@@ -964,7 +960,7 @@ static void dsi_pll_disable(struct dss_pll *pll)
 	dsi_disable_scp_clk(dsi);
 	dsi_runtime_put(dsi);
 
-	DSSDBG("PLL disable done\n");
+	dev_dbg(dsi->dev, "PLL disable done\n");
 }
 
 static int dsi_dump_dsi_clocks(struct seq_file *s, void *p)
@@ -1228,7 +1224,7 @@ static int dsi_cio_power(struct dsi_data *dsi, enum dsi_cio_power_state state)
 	while (FLD_GET(dsi_read_reg(dsi, DSI_COMPLEXIO_CFG1),
 			26, 25) != state) {
 		if (++t > 1000) {
-			DSSERR("failed to set complexio power state to "
+			dev_err(dsi->dev, "failed to set complexio power state to "
 					"%d\n", state);
 			return -ENODEV;
 		}
@@ -1369,20 +1365,19 @@ static void dsi_cio_timings(struct dsi_data *dsi)
 	/* min tclk-prepare + tclk-zero = 300ns */
 	tclk_zero = ns2ddr(dsi, 260);
 
-	DSSDBG("ths_prepare %u (%uns), ths_prepare_ths_zero %u (%uns)\n",
+	dev_dbg(dsi->dev, "ths_prepare %u (%uns), ths_prepare_ths_zero %u (%uns)\n",
 		ths_prepare, ddr2ns(dsi, ths_prepare),
 		ths_prepare_ths_zero, ddr2ns(dsi, ths_prepare_ths_zero));
-	DSSDBG("ths_trail %u (%uns), ths_exit %u (%uns)\n",
-			ths_trail, ddr2ns(dsi, ths_trail),
-			ths_exit, ddr2ns(dsi, ths_exit));
-
-	DSSDBG("tlpx_half %u (%uns), tclk_trail %u (%uns), "
-			"tclk_zero %u (%uns)\n",
-			tlpx_half, ddr2ns(dsi, tlpx_half),
-			tclk_trail, ddr2ns(dsi, tclk_trail),
-			tclk_zero, ddr2ns(dsi, tclk_zero));
-	DSSDBG("tclk_prepare %u (%uns)\n",
-			tclk_prepare, ddr2ns(dsi, tclk_prepare));
+	dev_dbg(dsi->dev, "ths_trail %u (%uns), ths_exit %u (%uns)\n",
+		ths_trail, ddr2ns(dsi, ths_trail),
+		ths_exit, ddr2ns(dsi, ths_exit));
+
+	dev_dbg(dsi->dev, "tlpx_half %u (%uns), tclk_trail %u (%uns), tclk_zero %u (%uns)\n",
+		tlpx_half, ddr2ns(dsi, tlpx_half),
+		tclk_trail, ddr2ns(dsi, tclk_trail),
+		tclk_zero, ddr2ns(dsi, tclk_zero));
+	dev_dbg(dsi->dev, "tclk_prepare %u (%uns)\n",
+		tclk_prepare, ddr2ns(dsi, tclk_prepare));
 
 	/* program timings */
 
@@ -1448,8 +1443,8 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct dsi_data *dsi)
 				if (!in_use[i] || (l & (1 << offsets[i])))
 					continue;
 
-				DSSERR("CIO TXCLKESC%d domain not coming " \
-						"out of reset\n", i);
+				dev_err(dsi->dev,
+					"CIO TXCLKESC%d domain not coming out of reset\n", i);
 			}
 			return -EIO;
 		}
@@ -1554,7 +1549,7 @@ static int dsi_cio_init(struct dsi_data *dsi)
 	int r;
 	u32 l;
 
-	DSSDBG("DSI CIO init starts");
+	dev_dbg(dsi->dev, "DSI CIO init starts");
 
 	r = dsi_enable_pads(dsi, dsi_get_lane_mask(dsi));
 	if (r)
@@ -1568,7 +1563,7 @@ static int dsi_cio_init(struct dsi_data *dsi)
 	dsi_read_reg(dsi, DSI_DSIPHY_CFG5);
 
 	if (!wait_for_bit_change(dsi, DSI_DSIPHY_CFG5, 30, 1)) {
-		DSSERR("CIO SCP Clock domain not coming out of reset.\n");
+		dev_err(dsi->dev, "CIO SCP Clock domain not coming out of reset.\n");
 		r = -EIO;
 		goto err_scp_clk_dom;
 	}
@@ -1590,7 +1585,7 @@ static int dsi_cio_init(struct dsi_data *dsi)
 		goto err_cio_pwr;
 
 	if (!wait_for_bit_change(dsi, DSI_COMPLEXIO_CFG1, 29, 1)) {
-		DSSERR("CIO PWR clock domain not coming out of reset.\n");
+		dev_err(dsi->dev, "CIO PWR clock domain not coming out of reset.\n");
 		r = -ENODEV;
 		goto err_cio_pwr_dom;
 	}
@@ -1613,7 +1608,7 @@ static int dsi_cio_init(struct dsi_data *dsi)
 		    !(dsi->dsidev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS),
 		    13, 13);
 
-	DSSDBG("CIO init done\n");
+	dev_dbg(dsi->dev, "CIO init done\n");
 
 	return 0;
 
@@ -1656,7 +1651,7 @@ static void dsi_config_tx_fifo(struct dsi_data *dsi,
 		int size = dsi->vc[i].tx_fifo_size;
 
 		if (add + size > 4) {
-			DSSERR("Illegal FIFO configuration\n");
+			dev_err(dsi->dev, "Illegal FIFO configuration\n");
 			BUG();
 			return;
 		}
@@ -1688,7 +1683,7 @@ static void dsi_config_rx_fifo(struct dsi_data *dsi,
 		int size = dsi->vc[i].rx_fifo_size;
 
 		if (add + size > 4) {
-			DSSERR("Illegal FIFO configuration\n");
+			dev_err(dsi->dev, "Illegal FIFO configuration\n");
 			BUG();
 			return;
 		}
@@ -1711,7 +1706,7 @@ static int dsi_force_tx_stop_mode_io(struct dsi_data *dsi)
 	dsi_write_reg(dsi, DSI_TIMING1, r);
 
 	if (!wait_for_bit_change(dsi, DSI_TIMING1, 15, 0)) {
-		DSSERR("TX_STOP bit not going down\n");
+		dev_err(dsi->dev, "TX_STOP bit not going down\n");
 		return -EIO;
 	}
 
@@ -1756,7 +1751,7 @@ static int dsi_sync_vc_vp(struct dsi_data *dsi, int vc)
 	if (REG_GET(dsi, DSI_VC_TE(vc), bit, bit)) {
 		if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(10)) == 0) {
-			DSSERR("Failed to complete previous frame transfer\n");
+			dev_err(dsi->dev, "Failed to complete previous frame transfer\n");
 			r = -EIO;
 			goto err1;
 		}
@@ -1802,7 +1797,7 @@ static int dsi_sync_vc_l4(struct dsi_data *dsi, int vc)
 	if (REG_GET(dsi, DSI_VC_CTRL(vc), 5, 5)) {
 		if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(10)) == 0) {
-			DSSERR("Failed to complete previous l4 transfer\n");
+			dev_err(dsi->dev, "Failed to complete previous l4 transfer\n");
 			r = -EIO;
 			goto err1;
 		}
@@ -1841,15 +1836,15 @@ static int dsi_sync_vc(struct dsi_data *dsi, int vc)
 
 static int dsi_vc_enable(struct dsi_data *dsi, int vc, bool enable)
 {
-	DSSDBG("dsi_vc_enable vc %d, enable %d\n",
-			vc, enable);
+	dev_dbg(dsi->dev, "dsi_vc_enable vc %d, enable %d\n",
+		vc, enable);
 
 	enable = enable ? 1 : 0;
 
 	REG_FLD_MOD(dsi, DSI_VC_CTRL(vc), enable, 0, 0);
 
 	if (!wait_for_bit_change(dsi, DSI_VC_CTRL(vc), 0, enable)) {
-		DSSERR("Failed to set dsi_vc_enable to %d\n", enable);
+		dev_err(dsi->dev, "Failed to set VC_EN to %d\n", enable);
 		return -EIO;
 	}
 
@@ -1860,13 +1855,13 @@ static void dsi_vc_initial_config(struct dsi_data *dsi, int vc)
 {
 	u32 r;
 
-	DSSDBG("Initial config of VC %d", vc);
+	dev_dbg(dsi->dev, "Initial config of VC %d", vc);
 
 	r = dsi_read_reg(dsi, DSI_VC_CTRL(vc));
 
 	if (FLD_GET(r, 15, 15)) /* VC_BUSY */
-		DSSERR("VC(%d) busy when trying to configure it!\n",
-				vc);
+		dev_err(dsi->dev, "VC(%d) busy when trying to configure it!\n",
+			vc);
 
 	r = FLD_MOD(r, 0, 1, 1); /* SOURCE, 0 = L4 */
 	r = FLD_MOD(r, 0, 2, 2); /* BTA_SHORT_EN  */
@@ -1891,7 +1886,7 @@ static void dsi_vc_enable_hs(struct omap_dss_device *dssdev, int vc,
 {
 	struct dsi_data *dsi = to_dsi_data(dssdev);
 
-	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", vc, enable);
+	dev_dbg(dsi->dev, "%s(%d, %d)\n", __func__, vc, enable);
 
 	if (REG_GET(dsi, DSI_VC_CTRL(vc), 9, 9) == enable)
 		return;
@@ -1914,49 +1909,49 @@ static void dsi_vc_flush_long_data(struct dsi_data *dsi, int vc)
 	while (REG_GET(dsi, DSI_VC_CTRL(vc), 20, 20)) {
 		u32 val;
 		val = dsi_read_reg(dsi, DSI_VC_SHORT_PACKET_HEADER(vc));
-		DSSDBG("\t\tb1 %#02x b2 %#02x b3 %#02x b4 %#02x\n",
-				(val >> 0) & 0xff,
-				(val >> 8) & 0xff,
-				(val >> 16) & 0xff,
-				(val >> 24) & 0xff);
+		dev_dbg(dsi->dev, "\t\tb1 %#02x b2 %#02x b3 %#02x b4 %#02x\n",
+			(val >> 0) & 0xff,
+			(val >> 8) & 0xff,
+			(val >> 16) & 0xff,
+			(val >> 24) & 0xff);
 	}
 }
 
-static void dsi_show_rx_ack_with_err(u16 err)
+static void dsi_show_rx_ack_with_err(struct dsi_data *dsi, u16 err)
 {
-	DSSERR("\tACK with ERROR (%#x):\n", err);
+	dev_err(dsi->dev, "\tACK with ERROR (%#x):\n", err);
 	if (err & (1 << 0))
-		DSSERR("\t\tSoT Error\n");
+		dev_err(dsi->dev, "\t\tSoT Error\n");
 	if (err & (1 << 1))
-		DSSERR("\t\tSoT Sync Error\n");
+		dev_err(dsi->dev, "\t\tSoT Sync Error\n");
 	if (err & (1 << 2))
-		DSSERR("\t\tEoT Sync Error\n");
+		dev_err(dsi->dev, "\t\tEoT Sync Error\n");
 	if (err & (1 << 3))
-		DSSERR("\t\tEscape Mode Entry Command Error\n");
+		dev_err(dsi->dev, "\t\tEscape Mode Entry Command Error\n");
 	if (err & (1 << 4))
-		DSSERR("\t\tLP Transmit Sync Error\n");
+		dev_err(dsi->dev, "\t\tLP Transmit Sync Error\n");
 	if (err & (1 << 5))
-		DSSERR("\t\tHS Receive Timeout Error\n");
+		dev_err(dsi->dev, "\t\tHS Receive Timeout Error\n");
 	if (err & (1 << 6))
-		DSSERR("\t\tFalse Control Error\n");
+		dev_err(dsi->dev, "\t\tFalse Control Error\n");
 	if (err & (1 << 7))
-		DSSERR("\t\t(reserved7)\n");
+		dev_err(dsi->dev, "\t\t(reserved7)\n");
 	if (err & (1 << 8))
-		DSSERR("\t\tECC Error, single-bit (corrected)\n");
+		dev_err(dsi->dev, "\t\tECC Error, single-bit (corrected)\n");
 	if (err & (1 << 9))
-		DSSERR("\t\tECC Error, multi-bit (not corrected)\n");
+		dev_err(dsi->dev, "\t\tECC Error, multi-bit (not corrected)\n");
 	if (err & (1 << 10))
-		DSSERR("\t\tChecksum Error\n");
+		dev_err(dsi->dev, "\t\tChecksum Error\n");
 	if (err & (1 << 11))
-		DSSERR("\t\tData type not recognized\n");
+		dev_err(dsi->dev, "\t\tData type not recognized\n");
 	if (err & (1 << 12))
-		DSSERR("\t\tInvalid VC ID\n");
+		dev_err(dsi->dev, "\t\tInvalid VC ID\n");
 	if (err & (1 << 13))
-		DSSERR("\t\tInvalid Transmission Length\n");
+		dev_err(dsi->dev, "\t\tInvalid Transmission Length\n");
 	if (err & (1 << 14))
-		DSSERR("\t\t(reserved14)\n");
+		dev_err(dsi->dev, "\t\t(reserved14)\n");
 	if (err & (1 << 15))
-		DSSERR("\t\tDSI Protocol Violation\n");
+		dev_err(dsi->dev, "\t\tDSI Protocol Violation\n");
 }
 
 static u16 dsi_vc_flush_receive_data(struct dsi_data *dsi, int vc)
@@ -1966,23 +1961,23 @@ static u16 dsi_vc_flush_receive_data(struct dsi_data *dsi, int vc)
 		u32 val;
 		u8 dt;
 		val = dsi_read_reg(dsi, DSI_VC_SHORT_PACKET_HEADER(vc));
-		DSSERR("\trawval %#08x\n", val);
+		dev_err(dsi->dev, "\trawval %#08x\n", val);
 		dt = FLD_GET(val, 5, 0);
 		if (dt == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT) {
 			u16 err = FLD_GET(val, 23, 8);
-			dsi_show_rx_ack_with_err(err);
+			dsi_show_rx_ack_with_err(dsi, err);
 		} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE) {
-			DSSERR("\tDCS short response, 1 byte: %#x\n",
-					FLD_GET(val, 23, 8));
+			dev_err(dsi->dev, "\tDCS short response, 1 byte: %#x\n",
+				FLD_GET(val, 23, 8));
 		} else if (dt == MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE) {
-			DSSERR("\tDCS short response, 2 byte: %#x\n",
-					FLD_GET(val, 23, 8));
+			dev_err(dsi->dev, "\tDCS short response, 2 byte: %#x\n",
+				FLD_GET(val, 23, 8));
 		} else if (dt == MIPI_DSI_RX_DCS_LONG_READ_RESPONSE) {
-			DSSERR("\tDCS long response, len %d\n",
-					FLD_GET(val, 23, 8));
+			dev_err(dsi->dev, "\tDCS long response, len %d\n",
+				FLD_GET(val, 23, 8));
 			dsi_vc_flush_long_data(dsi, vc);
 		} else {
-			DSSERR("\tunknown datatype 0x%02x\n", dt);
+			dev_err(dsi->dev, "\tunknown datatype 0x%02x\n", dt);
 		}
 	}
 	return 0;
@@ -1991,13 +1986,13 @@ static u16 dsi_vc_flush_receive_data(struct dsi_data *dsi, int vc)
 static int dsi_vc_send_bta(struct dsi_data *dsi, int vc)
 {
 	if (dsi->debug_write || dsi->debug_read)
-		DSSDBG("dsi_vc_send_bta %d\n", vc);
+		dev_dbg(dsi->dev, "dsi_vc_send_bta %d\n", vc);
 
 	WARN_ON(!dsi_bus_is_locked(dsi));
 
 	/* RX_FIFO_NOT_EMPTY */
 	if (REG_GET(dsi, DSI_VC_CTRL(vc), 20, 20)) {
-		DSSERR("rx fifo not empty when sending BTA, dumping data:\n");
+		dev_err(dsi->dev, "rx fifo not empty when sending BTA, dumping data:\n");
 		dsi_vc_flush_receive_data(dsi, vc);
 	}
 
@@ -2032,14 +2027,14 @@ static int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int vc)
 
 	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(500)) == 0) {
-		DSSERR("Failed to receive BTA\n");
+		dev_err(dsi->dev, "Failed to receive BTA\n");
 		r = -EIO;
 		goto err2;
 	}
 
 	err = dsi_get_errors(dsi);
 	if (err) {
-		DSSERR("Error while sending BTA: %x\n", err);
+		dev_err(dsi->dev, "Error while sending BTA: %x\n", err);
 		r = -EIO;
 		goto err2;
 	}
@@ -2093,11 +2088,11 @@ static int dsi_vc_send_long(struct dsi_data *dsi, int vc,
 	u8 b1, b2, b3, b4;
 
 	if (dsi->debug_write)
-		DSSDBG("dsi_vc_send_long, %zu bytes\n", msg->tx_len);
+		dev_dbg(dsi->dev, "%s, %zu bytes\n", __func__, msg->tx_len);
 
 	/* len + header */
 	if (dsi->vc[vc].tx_fifo_size * 32 * 4 < msg->tx_len + 4) {
-		DSSERR("unable to send long packet: packet too long.\n");
+		dev_err(dsi->dev, "unable to send long packet: packet too long.\n");
 		return -EINVAL;
 	}
 
@@ -2106,7 +2101,7 @@ static int dsi_vc_send_long(struct dsi_data *dsi, int vc,
 	p = msg->tx_buf;
 	for (i = 0; i < msg->tx_len >> 2; i++) {
 		if (dsi->debug_write)
-			DSSDBG("\tsending full packet %d\n", i);
+			dev_dbg(dsi->dev, "\tsending full packet %d\n", i);
 
 		b1 = *p++;
 		b2 = *p++;
@@ -2121,7 +2116,7 @@ static int dsi_vc_send_long(struct dsi_data *dsi, int vc,
 		b1 = 0; b2 = 0; b3 = 0;
 
 		if (dsi->debug_write)
-			DSSDBG("\tsending remainder bytes %d\n", i);
+			dev_dbg(dsi->dev, "\tsending remainder bytes %d\n", i);
 
 		switch (i) {
 		case 3:
@@ -2158,11 +2153,11 @@ static int dsi_vc_send_short(struct dsi_data *dsi, int vc,
 	WARN_ON(!dsi_bus_is_locked(dsi));
 
 	if (dsi->debug_write)
-		DSSDBG("dsi_vc_send_short(vc%d, dt %#x, b1 %#x, b2 %#x)\n",
-		       vc, msg->type, pkt.header[1], pkt.header[2]);
+		dev_dbg(dsi->dev, "%s(vc%d, dt %#x, b1 %#x, b2 %#x)\n",
+			__func__, vc, msg->type, pkt.header[1], pkt.header[2]);
 
 	if (FLD_GET(dsi_read_reg(dsi, DSI_VC_CTRL(vc)), 16, 16)) {
-		DSSERR("ERROR FIFO FULL, aborting transfer\n");
+		dev_err(dsi->dev, "ERROR FIFO FULL, aborting transfer\n");
 		return -EINVAL;
 	}
 
@@ -2217,20 +2212,20 @@ static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
 	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
 		r = dsi_vc_send_bta_sync(dssdev, vc);
 		if (r) {
-			DSSERR("bta sync failed\n");
+			dev_err(dsi->dev, "bta sync failed\n");
 			return r;
 		}
 	} else {
 		err = dsi_get_errors(dsi);
 		if (err) {
-			DSSERR("Error while sending: %x\n", err);
+			dev_err(dsi->dev, "Error while sending: %x\n", err);
 			return -EIO;
 		}
 	}
 
 	/* RX_FIFO_NOT_EMPTY */
 	if (REG_GET(dsi, DSI_VC_CTRL(vc), 20, 20)) {
-		DSSERR("rx fifo not empty after write, dumping data:\n");
+		dev_err(dsi->dev, "rx fifo not empty after write, dumping data:\n");
 		dsi_vc_flush_receive_data(dsi, vc);
 		return -EIO;
 	}
@@ -2247,18 +2242,18 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 
 	/* RX_FIFO_NOT_EMPTY */
 	if (REG_GET(dsi, DSI_VC_CTRL(vc), 20, 20) == 0) {
-		DSSERR("RX fifo empty when trying to read.\n");
+		dev_err(dsi->dev, "RX fifo empty when trying to read.\n");
 		r = -EIO;
 		goto err;
 	}
 
 	val = dsi_read_reg(dsi, DSI_VC_SHORT_PACKET_HEADER(vc));
 	if (dsi->debug_read)
-		DSSDBG("\theader: %08x\n", val);
+		dev_dbg(dsi->dev, "\theader: %08x\n", val);
 	dt = FLD_GET(val, 5, 0);
 	if (dt == MIPI_DSI_RX_ACKNOWLEDGE_AND_ERROR_REPORT) {
 		u16 err = FLD_GET(val, 23, 8);
-		dsi_show_rx_ack_with_err(err);
+		dsi_show_rx_ack_with_err(dsi, err);
 		r = -EIO;
 		goto err;
 
@@ -2267,7 +2262,7 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 			MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_1BYTE)) {
 		u8 data = FLD_GET(val, 15, 8);
 		if (dsi->debug_read)
-			DSSDBG("\t%s short response, 1 byte: %02x\n",
+			dev_dbg(dsi->dev, "\t%s short response, 1 byte: %02x\n",
 				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
 				"DCS", data);
 
@@ -2284,7 +2279,7 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 			MIPI_DSI_RX_DCS_SHORT_READ_RESPONSE_2BYTE)) {
 		u16 data = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
-			DSSDBG("\t%s short response, 2 byte: %04x\n",
+			dev_dbg(dsi->dev, "\t%s short response, 2 byte: %04x\n",
 				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
 				"DCS", data);
 
@@ -2303,7 +2298,7 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 		int w;
 		int len = FLD_GET(val, 23, 8);
 		if (dsi->debug_read)
-			DSSDBG("\t%s long response, len %d\n",
+			dev_dbg(dsi->dev, "\t%s long response, len %d\n",
 				type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" :
 				"DCS", len);
 
@@ -2318,11 +2313,11 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 			val = dsi_read_reg(dsi,
 				DSI_VC_SHORT_PACKET_HEADER(vc));
 			if (dsi->debug_read)
-				DSSDBG("\t\t%02x %02x %02x %02x\n",
-						(val >> 0) & 0xff,
-						(val >> 8) & 0xff,
-						(val >> 16) & 0xff,
-						(val >> 24) & 0xff);
+				dev_dbg(dsi->dev, "\t\t%02x %02x %02x %02x\n",
+					(val >> 0) & 0xff,
+					(val >> 8) & 0xff,
+					(val >> 16) & 0xff,
+					(val >> 24) & 0xff);
 
 			for (b = 0; b < 4; ++b) {
 				if (w < len)
@@ -2334,13 +2329,13 @@ static int dsi_vc_read_rx_fifo(struct dsi_data *dsi, int vc, u8 *buf,
 
 		return len;
 	} else {
-		DSSERR("\tunknown datatype 0x%02x\n", dt);
+		dev_err(dsi->dev, "\tunknown datatype 0x%02x\n", dt);
 		r = -EIO;
 		goto err;
 	}
 
 err:
-	DSSERR("dsi_vc_read_rx_fifo(vc %d type %s) failed\n", vc,
+	dev_err(dsi->dev, "%s(vc %d type %s) failed\n", __func__, vc,
 		type == DSS_DSI_CONTENT_GENERIC ? "GENERIC" : "DCS");
 
 	return r;
@@ -2354,7 +2349,7 @@ static int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int vc,
 	int r;
 
 	if (dsi->debug_read)
-		DSSDBG("%s(vc %d, cmd %x)\n", __func__, vc, cmd);
+		dev_dbg(dsi->dev, "%s(vc %d, cmd %x)\n", __func__, vc, cmd);
 
 	r = dsi_vc_send_short(dsi, vc, msg);
 	if (r)
@@ -2376,7 +2371,7 @@ static int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int vc,
 
 	return 0;
 err:
-	DSSERR("%s(vc %d, cmd 0x%02x) failed\n", __func__,  vc, cmd);
+	dev_err(dsi->dev, "%s(vc %d, cmd 0x%02x) failed\n", __func__,  vc, cmd);
 	return r;
 }
 
@@ -2406,7 +2401,7 @@ static int dsi_vc_generic_read(struct omap_dss_device *dssdev, int vc,
 
 	return 0;
 err:
-	DSSERR("%s(vc %d, reqlen %zu) failed\n", __func__,  vc, msg->tx_len);
+	dev_err(dsi->dev, "%s(vc %d, reqlen %zu) failed\n", __func__,  vc, msg->tx_len);
 	return r;
 }
 
@@ -2431,10 +2426,10 @@ static void dsi_set_lp_rx_timeout(struct dsi_data *dsi, unsigned int ticks,
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
-	DSSDBG("LP_RX_TO %lu ticks (%#x%s%s) = %lu ns\n",
-			total_ticks,
-			ticks, x4 ? " x4" : "", x16 ? " x16" : "",
-			(total_ticks * 1000) / (fck / 1000 / 1000));
+	dev_dbg(dsi->dev, "LP_RX_TO %lu ticks (%#x%s%s) = %lu ns\n",
+		total_ticks,
+		ticks, x4 ? " x4" : "", x16 ? " x16" : "",
+		(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
 static void dsi_set_ta_timeout(struct dsi_data *dsi, unsigned int ticks,
@@ -2458,10 +2453,10 @@ static void dsi_set_ta_timeout(struct dsi_data *dsi, unsigned int ticks,
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x8 ? 8 : 1);
 
-	DSSDBG("TA_TO %lu ticks (%#x%s%s) = %lu ns\n",
-			total_ticks,
-			ticks, x8 ? " x8" : "", x16 ? " x16" : "",
-			(total_ticks * 1000) / (fck / 1000 / 1000));
+	dev_dbg(dsi->dev, "TA_TO %lu ticks (%#x%s%s) = %lu ns\n",
+		total_ticks,
+		ticks, x8 ? " x8" : "", x16 ? " x16" : "",
+		(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
 static void dsi_set_stop_state_counter(struct dsi_data *dsi, unsigned int ticks,
@@ -2485,10 +2480,10 @@ static void dsi_set_stop_state_counter(struct dsi_data *dsi, unsigned int ticks,
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
-	DSSDBG("STOP_STATE_COUNTER %lu ticks (%#x%s%s) = %lu ns\n",
-			total_ticks,
-			ticks, x4 ? " x4" : "", x16 ? " x16" : "",
-			(total_ticks * 1000) / (fck / 1000 / 1000));
+	dev_dbg(dsi->dev, "STOP_STATE_COUNTER %lu ticks (%#x%s%s) = %lu ns\n",
+		total_ticks,
+		ticks, x4 ? " x4" : "", x16 ? " x16" : "",
+		(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
 static void dsi_set_hs_tx_timeout(struct dsi_data *dsi, unsigned int ticks,
@@ -2512,10 +2507,10 @@ static void dsi_set_hs_tx_timeout(struct dsi_data *dsi, unsigned int ticks,
 
 	total_ticks = ticks * (x16 ? 16 : 1) * (x4 ? 4 : 1);
 
-	DSSDBG("HS_TX_TO %lu ticks (%#x%s%s) = %lu ns\n",
-			total_ticks,
-			ticks, x4 ? " x4" : "", x16 ? " x16" : "",
-			(total_ticks * 1000) / (fck / 1000 / 1000));
+	dev_dbg(dsi->dev, "HS_TX_TO %lu ticks (%#x%s%s) = %lu ns\n",
+		total_ticks,
+		ticks, x4 ? " x4" : "", x16 ? " x16" : "",
+		(total_ticks * 1000) / (fck / 1000 / 1000));
 }
 
 static void dsi_config_vp_num_line_buffers(struct dsi_data *dsi)
@@ -2735,11 +2730,11 @@ static void dsi_config_cmd_mode_interleaving(struct dsi_data *dsi)
 					lp_clk_div, dsi_fclk_hsdiv);
 	}
 
-	DSSDBG("DSI HS interleaving(TXBYTECLKHS) HSA %d, HFP %d, HBP %d, BLLP %d\n",
+	dev_dbg(dsi->dev, "DSI HS interleaving(TXBYTECLKHS) HSA %d, HFP %d, HBP %d, BLLP %d\n",
 		hsa_interleave_hs, hfp_interleave_hs, hbp_interleave_hs,
 		bl_interleave_hs);
 
-	DSSDBG("DSI LP interleaving(bytes) HSA %d, HFP %d, HBP %d, BLLP %d\n",
+	dev_dbg(dsi->dev, "DSI LP interleaving(bytes) HSA %d, HFP %d, HBP %d, BLLP %d\n",
 		hsa_interleave_lp, hfp_interleave_lp, hbp_interleave_lp,
 		bl_interleave_lp);
 
@@ -2875,9 +2870,9 @@ static void dsi_proto_timings(struct dsi_data *dsi)
 	r = FLD_MOD(r, ddr_clk_post, 7, 0);
 	dsi_write_reg(dsi, DSI_CLK_TIMING, r);
 
-	DSSDBG("ddr_clk_pre %u, ddr_clk_post %u\n",
-			ddr_clk_pre,
-			ddr_clk_post);
+	dev_dbg(dsi->dev, "ddr_clk_pre %u, ddr_clk_post %u\n",
+		ddr_clk_pre,
+		ddr_clk_post);
 
 	enter_hs_mode_lat = 1 + DIV_ROUND_UP(tlpx, 4) +
 		DIV_ROUND_UP(ths_prepare, 4) +
@@ -2889,8 +2884,8 @@ static void dsi_proto_timings(struct dsi_data *dsi)
 		FLD_VAL(exit_hs_mode_lat, 15, 0);
 	dsi_write_reg(dsi, DSI_VM_TIMING7, r);
 
-	DSSDBG("enter_hs_mode_lat %u, exit_hs_mode_lat %u\n",
-			enter_hs_mode_lat, exit_hs_mode_lat);
+	dev_dbg(dsi->dev, "enter_hs_mode_lat %u, exit_hs_mode_lat %u\n",
+		enter_hs_mode_lat, exit_hs_mode_lat);
 
 	 if (dsi->mode == OMAP_DSS_DSI_VIDEO_MODE) {
 		/* TODO: Implement a video mode check_timings function */
@@ -2916,9 +2911,9 @@ static void dsi_proto_timings(struct dsi_data *dsi)
 		tl = DIV_ROUND_UP(4, ndl) + (hsync_end ? hsa : 0) + t_he + hfp +
 			DIV_ROUND_UP(width_bytes + 6, ndl) + hbp;
 
-		DSSDBG("HBP: %d, HFP: %d, HSA: %d, TL: %d TXBYTECLKHS\n", hbp,
+		dev_dbg(dsi->dev, "HBP: %d, HFP: %d, HSA: %d, TL: %d TXBYTECLKHS\n", hbp,
 			hfp, hsync_end ? hsa : 0, tl);
-		DSSDBG("VBP: %d, VFP: %d, VSA: %d, VACT: %d lines\n", vbp, vfp,
+		dev_dbg(dsi->dev, "VBP: %d, VFP: %d, VSA: %d, VACT: %d lines\n", vbp, vfp,
 			vsa, vm->vactive);
 
 		r = dsi_read_reg(dsi, DSI_VM_TIMING1);
@@ -3114,7 +3109,7 @@ static void dsi_update_screen_dispc(struct dsi_data *dsi)
 	u16 w = dsi->vm.hactive;
 	u16 h = dsi->vm.vactive;
 
-	DSSDBG("dsi_update_screen_dispc(%dx%d)\n", w, h);
+	dev_dbg(dsi->dev, "%s(%dx%d)\n", __func__, w, h);
 
 	bytespp	= mipi_dsi_pixel_format_to_bpp(dsi->pix_fmt) / 8;
 	bytespl = w * bytespp;
@@ -3209,7 +3204,7 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 	 * on the HW is buggy, and would probably require resetting the whole
 	 * DSI */
 
-	DSSERR("Framedone not received for 250ms!\n");
+	dev_err(dsi->dev, "Framedone not received for 250ms!\n");
 
 	dsi_handle_framedone(dsi, -ETIMEDOUT);
 }
@@ -3225,7 +3220,7 @@ static void dsi_framedone_irq_callback(void *data)
 
 	cancel_delayed_work(&dsi->framedone_timeout_work);
 
-	DSSDBG("Framedone received!\n");
+	dev_dbg(dsi->dev, "Framedone received!\n");
 
 	dsi_handle_framedone(dsi, 0);
 }
@@ -3260,7 +3255,7 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 		goto err;
 	}
 
-	DSSDBG("dsi_update_channel: %d", vc);
+	dev_dbg(dsi->dev, "%s: %d", __func__, vc);
 
 	/*
 	 * Transition to LP here. If we don't send something here, the
@@ -3310,7 +3305,7 @@ static int dsi_configure_dispc_clocks(struct dsi_data *dsi)
 
 	r = dispc_calc_clock_rates(dsi->dss->dispc, fck, &dispc_cinfo);
 	if (r) {
-		DSSERR("Failed to calc dispc clocks\n");
+		dev_err(dsi->dev, "Failed to calc dispc clocks\n");
 		return r;
 	}
 
@@ -3332,7 +3327,7 @@ static int dsi_init_dispc(struct dsi_data *dsi)
 		r = dss_mgr_register_framedone_handler(&dsi->output,
 				dsi_framedone_irq_callback, dsi);
 		if (r) {
-			DSSERR("can't register FRAMEDONE handler\n");
+			dev_err(dsi->dev, "can't register FRAMEDONE handler\n");
 			goto err;
 		}
 
@@ -3384,7 +3379,7 @@ static int dsi_configure_dsi_clocks(struct dsi_data *dsi)
 
 	r = dss_pll_set_config(&dsi->pll, &cinfo);
 	if (r) {
-		DSSERR("Failed to set dsi clocks\n");
+		dev_err(dsi->dev, "Failed to set dsi clocks\n");
 		return r;
 	}
 
@@ -3437,7 +3432,7 @@ static int dsi_init_dsi(struct dsi_data *dsi)
 				  dsi->module_id == 0 ?
 				  DSS_CLK_SRC_PLL1_2 : DSS_CLK_SRC_PLL2_2);
 
-	DSSDBG("PLL OK\n");
+	dev_dbg(dsi->dev, "PLL OK\n");
 
 	if (!dsi->vdds_dsi_enabled) {
 		r = regulator_enable(dsi->vdds_dsi_reg);
@@ -3527,7 +3522,7 @@ static void dsi_enable(struct dsi_data *dsi)
 	dsi_runtime_put(dsi);
 err_get_dsi:
 	mutex_unlock(&dsi->lock);
-	DSSDBG("dsi_enable FAILED\n");
+	dev_dbg(dsi->dev, "%s FAILED\n", __func__);
 }
 
 static void dsi_disable(struct dsi_data *dsi)
@@ -4096,7 +4091,7 @@ static int dsi_set_config(struct omap_dss_device *dssdev,
 
 	r = __dsi_calc_config(dsi, mode, &ctx);
 	if (r) {
-		DSSERR("failed to find suitable DSI clock settings\n");
+		dev_err(dsi->dev, "failed to find suitable DSI clock settings\n");
 		goto err;
 	}
 
@@ -4256,7 +4251,7 @@ static int dsi_get_clocks(struct dsi_data *dsi)
 
 	clk = devm_clk_get(dsi->dev, "fck");
 	if (IS_ERR(clk)) {
-		DSSERR("can't get fck\n");
+		dev_err(dsi->dev, "can't get fck\n");
 		return PTR_ERR(clk);
 	}
 
@@ -4362,12 +4357,12 @@ static int omap_dsi_host_attach(struct mipi_dsi_host *host,
 	int r;
 
 	if (dsi->dsidev) {
-		DSSERR("dsi client already attached\n");
+		dev_err(dsi->dev, "dsi client already attached\n");
 		return -EBUSY;
 	}
 
 	if (mipi_dsi_pixel_format_to_bpp(client->format) < 0) {
-		DSSERR("invalid pixel format\n");
+		dev_err(dsi->dev, "invalid pixel format\n");
 		return -EINVAL;
 	}
 
@@ -4528,7 +4523,7 @@ static int dsi_init_pll_data(struct dss_device *dss, struct dsi_data *dsi)
 
 	clk = devm_clk_get(dsi->dev, "sys_clk");
 	if (IS_ERR(clk)) {
-		DSSERR("can't get sys_clk\n");
+		dev_err(dsi->dev, "can't get sys_clk\n");
 		return PTR_ERR(clk);
 	}
 
@@ -4936,21 +4931,21 @@ static int dsi_probe(struct platform_device *pdev)
 
 	dsi->irq = platform_get_irq(pdev, 0);
 	if (dsi->irq < 0) {
-		DSSERR("platform_get_irq failed\n");
+		dev_err(dsi->dev, "platform_get_irq failed\n");
 		return -ENODEV;
 	}
 
 	r = devm_request_irq(dev, dsi->irq, omap_dsi_irq_handler,
 			     IRQF_SHARED, dev_name(dev), dsi);
 	if (r < 0) {
-		DSSERR("request_irq failed\n");
+		dev_err(dsi->dev, "request_irq failed\n");
 		return r;
 	}
 
 	dsi->vdds_dsi_reg = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(dsi->vdds_dsi_reg)) {
 		if (PTR_ERR(dsi->vdds_dsi_reg) != -EPROBE_DEFER)
-			DSSERR("can't get DSI VDD regulator\n");
+			dev_err(dsi->dev, "can't get DSI VDD regulator\n");
 		return PTR_ERR(dsi->vdds_dsi_reg);
 	}
 
@@ -4965,7 +4960,7 @@ static int dsi_probe(struct platform_device *pdev)
 		d++;
 
 	if (d->address == 0) {
-		DSSERR("unsupported DSI module\n");
+		dev_err(dsi->dev, "unsupported DSI module\n");
 		return -ENODEV;
 	}
 
@@ -5015,7 +5010,7 @@ static int dsi_probe(struct platform_device *pdev)
 
 	r = dsi_probe_of(dsi);
 	if (r) {
-		DSSERR("Invalid DSI DT data\n");
+		dev_err(dsi->dev, "Invalid DSI DT data\n");
 		goto err_pm_disable;
 	}
 
-- 
2.47.3

