Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAE606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=rU1B7S3f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71E210EA0D;
	Sun,  1 Nov 2026 12:00:45 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4CDB610E07E
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=YHf42dT4GUuGEkFrxXMEdkY9Ofr+uP3rQX
 VMmCvRrVM=; b=rU1B7S3fm56HwmhW44Z6C+QUmSP8v53TML5bV533kfyfn62aPn
 ouvy9sFkKrm/LpDv189XhbqiQYF3NvAG2TP7FtA/7qt/mW4A6rPNqgM31pqgr8eJ
 7N6zGlZWirqEzJ4syKT2nFJ/0byxVktz2M8uaDTo8DHQeebTv87ixzlxk=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.113])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDHS0ApA+ZqqSNvAA--.5005S4;
 Sat, 31 Oct 2026 23:03:06 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/msm/dsi: add per-SoC bonded command-path config
Date: Sat, 31 Oct 2026 23:03:02 +0800
Message-ID: <20261031150305.1107572-3-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDHS0ApA+ZqqSNvAA--.5005S4
X-Coremail-Antispam: 1UD129KBjvJXoW3AryUAry8WF48WrWfJFW5ZFb_yoWxKw1DpF
 WYqw15tr4kA3ZI9wsxtF1UC3WrAFnavayxJ3srGwnxAwnxtw1UXF4v9a43KFy7ta48Jr1a
 va1kAryUGF1kJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
 6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
 02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
 4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4
 AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07b2
 T5LUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARERB2rk8FY0gwAHse
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bonded command path carried its constants inline: the error-mask bits
in dsi_cmd_error_prepare()/dsi_cmd_error_cleanup(), the CMD_DMA_CTRL bits
staged before a broadcast and the peer poll budget. Those are controller
facts, so they belong in the existing per-SoC table next to the regulator
and bus-clock data rather than in the driver body.

Add struct msm_dsi_bonded_cfg and hang it off struct msm_dsi_config.
SM8750 reports DSI 6G v2.9, which selects the sm8650 cfg entry, so the
bonded data is attached there with values copied verbatim from the
current code. Use remains gated on the sm8750 compatible, so behaviour is
unchanged.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_host.c | 22 +++++++++++++++-------
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index da3fe68244..640ebe8244 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -4,6 +4,7 @@
  */
 
 #include "dsi_cfg.h"
+#include "dsi.xml.h"
 
 static const char * const dsi_v2_bus_clk_names[] = {
 	"core_mmss", "iface", "bus",
@@ -194,6 +195,24 @@ static const struct regulator_bulk_data sm8650_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 16600 },	/* 1.2 V */
 };
 
+/*
+ * Bonded command-path data. Values are copied verbatim from the vendor-derived
+ * in-tree code; the SM8750 compatible check in dsi_host.c/dsi_manager.c still
+ * gates every use until the master link moves into this table as well.
+ * TODO(doc): err_clear_bits/err_cleanup_bits touch bits that dsi.xml does not
+ * describe (see reports/b5-per-soc-cfg-design-20261027.md, RFC-SCOPE R1).
+ */
+static const struct msm_dsi_bonded_cfg sm8750_dsi_bonded_cfg = {
+	.master_link_id = DSI_0,
+	.cmd_dma_ctrl = DSI_CMD_DMA_CTRL_BROADCAST_EN |
+			DSI_CMD_DMA_CTRL_FROM_FRAME_BUFFER,
+	.err_clear_bits = 0x001f0200,
+	.err_cleanup_bits = 0x44440400,
+	.poll_timeout_us = 5000,	/* 500 polls, 10 us apart */
+	.needs_link_clk_bump = true,
+	.needs_sw_reset = true,
+};
+
 static const struct msm_dsi_config sm8650_dsi_cfg = {
 	.io_offset = DSI_6G_REG_SHIFT,
 	.regulator_data = sm8650_dsi_regulators,
@@ -203,6 +222,13 @@ static const struct msm_dsi_config sm8650_dsi_cfg = {
 	.io_start = {
 		{ 0xae94000, 0xae96000 },
 	},
+	/*
+	 * SM8750 reports DSI 6G v2.9, i.e. it selects this very table entry, so
+	 * the bonded data has to hang off it. Its use is still gated on the
+	 * "qcom,sm8750-dsi-ctrl" compatible, so an actual SM8650 keeps taking
+	 * the regular command path.
+	 */
+	.bonded = &sm8750_dsi_bonded_cfg,
 };
 
 static const struct msm_dsi_config kaanapali_dsi_cfg = {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index ccf0667960..c8813a738b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -41,6 +41,26 @@
 /* Maximum number of configurations matched against the same hw revision */
 #define VARIANTS_MAX			2
 
+/**
+ * struct msm_dsi_bonded_cfg - per-SoC data for the bonded command path
+ * @master_link_id: link that drives the broadcast; not the probe order
+ * @cmd_dma_ctrl: CMD_DMA_CTRL bits both engines need while staged
+ * @err_clear_bits: error-mask bits set before a command
+ * @err_cleanup_bits: side-effectful FIFO status bits written after a command
+ * @poll_timeout_us: the peer is polled, never completed through its IRQ
+ * @needs_link_clk_bump: command-time link clock vote for this generation
+ * @needs_sw_reset: this generation needs the stock controller reset sequence
+ */
+struct msm_dsi_bonded_cfg {
+	u8 master_link_id;
+	u32 cmd_dma_ctrl;
+	u32 err_clear_bits;
+	u32 err_cleanup_bits;
+	u32 poll_timeout_us;
+	bool needs_link_clk_bump;
+	bool needs_sw_reset;
+};
+
 struct msm_dsi_config {
 	u32 io_offset;
 	const struct regulator_bulk_data *regulator_data;
@@ -48,6 +68,8 @@ struct msm_dsi_config {
 	const char * const *bus_clk_names;
 	const int num_bus_clks;
 	const resource_size_t io_start[VARIANTS_MAX][DSI_MAX];
+	/* NULL when the SoC has no bonded command path */
+	const struct msm_dsi_bonded_cfg *bonded;
 };
 
 struct msm_dsi_host_cfg_ops {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 5405173a43..a3e9882c22 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2345,12 +2345,19 @@ void msm_dsi_host_bonded_wait_video(struct mipi_dsi_host *host)
 	dsi_wait4video_eng_busy(to_msm_dsi_host(host));
 }
 
+static const struct msm_dsi_bonded_cfg *
+dsi_bonded_cfg(struct msm_dsi_host *msm_host)
+{
+	return msm_host->cfg_hnd->cfg->bonded;
+}
+
 static void dsi_cmd_error_prepare(struct msm_dsi_host *msm_host)
 {
+	const struct msm_dsi_bonded_cfg *bonded = dsi_bonded_cfg(msm_host);
 	u32 val;
 
 	val = dsi_read(msm_host, REG_DSI_ERR_INT_MASK0);
-	val |= 0x001f0200;
+	val |= bonded->err_clear_bits;
 	dsi_write(msm_host, REG_DSI_ERR_INT_MASK0, val);
 	wmb(); /* Stock completes the error-mask write before stale clear. */
 
@@ -2360,13 +2367,14 @@ static void dsi_cmd_error_prepare(struct msm_dsi_host *msm_host)
 
 static void dsi_cmd_error_cleanup(struct msm_dsi_host *msm_host)
 {
+	const struct msm_dsi_bonded_cfg *bonded = dsi_bonded_cfg(msm_host);
 	u32 val;
 
 	/* Stock mask_error_intr(0x2, false) W1C-clears FIFO errors. */
 	val = dsi_read(msm_host, REG_DSI_FIFO_STATUS);
-	dsi_write(msm_host, REG_DSI_FIFO_STATUS, val | 0x44440400);
+	dsi_write(msm_host, REG_DSI_FIFO_STATUS, val | bonded->err_cleanup_bits);
 	val = dsi_read(msm_host, REG_DSI_ERR_INT_MASK0);
-	val &= ~0x001f0200;
+	val &= ~bonded->err_clear_bits;
 	dsi_write(msm_host, REG_DSI_ERR_INT_MASK0, val);
 	wmb(); /* Complete overflow unmask before stale-error clear. */
 
@@ -2553,8 +2561,7 @@ void msm_dsi_host_bonded_cmd_stage(struct mipi_dsi_host *host,
 	val &= ~(DSI_CMD_DMA_CTRL_BROADCAST_MASTER |
 		 DSI_CMD_DMA_CTRL_WC_SEL | DSI_CMD_DMA_CTRL_PACKET_TYPE |
 		 DSI_CMD_DMA_CTRL_LOW_POWER);
-	val |= DSI_CMD_DMA_CTRL_BROADCAST_EN |
-	       DSI_CMD_DMA_CTRL_FROM_FRAME_BUFFER;
+	val |= dsi_bonded_cfg(msm_host)->cmd_dma_ctrl;
 	if (master)
 		val |= DSI_CMD_DMA_CTRL_BROADCAST_MASTER;
 	if (msg->flags & MIPI_DSI_MSG_USE_LPM)
@@ -2636,10 +2643,11 @@ int msm_dsi_host_bonded_cmd_wait_master(struct mipi_dsi_host *host, u32 len)
 int msm_dsi_host_bonded_cmd_poll_slave(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
+	u32 timeout_us = dsi_bonded_cfg(msm_host)->poll_timeout_us;
 	u32 status = 0;
-	int i;
+	u32 elapsed;
 
-	for (i = 0; i < 500; i++) {
+	for (elapsed = 0; elapsed < timeout_us; elapsed += 10) {
 		status = dsi_read(msm_host, REG_DSI_INTR_CTRL);
 		if (status & DSI_IRQ_CMD_DMA_DONE) {
 			dsi_cmd_dma_intr_update(msm_host, false, true);
-- 
2.53.0

