Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7C606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=QSlnCPcH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEB810EA00;
	Sun,  1 Nov 2026 11:58:19 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id C748B10E147
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=2uhe0ZTNhDovEz3zv7M2X1cfX3rzZq+Bt1
 zZDJMVZJk=; b=QSlnCPcH3sIe30XJPJ9mpC4EXORVN6xIEG6fT7G9UMc7RMX7wA
 qrFdOrt+TEwRppPRLY83C3BzCxmn22tEIj3Z/ZrceY+gHIEilBCXPSXSI29oSlFj
 cAm0uJCxRizCBBwXtrsscZU2bPsCNN9B5osXVxSdFmmmROGS86zqgS3gY=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.113])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDHS0ApA+ZqqSNvAA--.5005S5;
 Sat, 31 Oct 2026 23:03:09 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/msm/dsi: route the bonded command path through host
 ops
Date: Sat, 31 Oct 2026 23:03:03 +0800
Message-ID: <20261031150305.1107572-4-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDHS0ApA+ZqqSNvAA--.5005S5
X-Coremail-Antispam: 1UD129KBjvAXoW3tF18WF48ZFWUCry5uF13twb_yoW8XFyfCo
 WfX3yDXw1fK3Wqva4kt3WftFnF9F129r9xKrn8Gr4DCa1qqa4DJry3t3y3X3y3Xw1fGa1U
 X3s7twnrKrW7Cr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUO07k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
 x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
 I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY
 1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20x
 vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280
 aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
 Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
 6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxkIec
 xEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 vco2UUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARERB2rk8FY0gwAIsR
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

The manager called ten separate msm_dsi_host_bonded_* helpers to drive a
bonded command transaction, so the broadcast engine's shape leaked into
the manager and every helper needed a cross-file prototype.

Expose the transaction as two host ops instead: .bonded_cmd_xfer runs one
broadcast command against a peer host and .bonded_wait_video waits for
the video engine to go idle. The implementation moves into dsi_host.c
where the rest of the register-level code lives, and the ten helpers
become file-static there; only the two entry points stay in dsi.h. The
ops are only populated for the 6G v2.9 generation, which is the one
SM8750 reports.

The manager still picks the master by link id and the sequencing inside
the transaction is unchanged, so behaviour is identical.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/gpu/drm/msm/dsi/dsi.h         | 20 +++---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c     |  3 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h     |  8 +++
 drivers/gpu/drm/msm/dsi/dsi_host.c    | 90 +++++++++++++++++++++++----
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 64 ++++---------------
 5 files changed, 109 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 199ec77129..667d233f7b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -53,12 +53,15 @@ int msm_dsi_manager_connector_init(struct msm_dsi *msm_dsi,
 int msm_dsi_manager_cmd_xfer(int id, const struct mipi_dsi_msg *msg);
 int msm_dsi_manager_cmd_xfer_trigger(int id, u32 dma_base, u32 len);
 bool msm_dsi_manager_cmd_failed(void);
+void msm_dsi_manager_mark_cmd_failed(void);
 int msm_dsi_manager_register(struct msm_dsi *msm_dsi);
 void msm_dsi_manager_unregister(struct msm_dsi *msm_dsi);
 void msm_dsi_manager_tpg_enable(void);
 
 /* dsi host */
 struct msm_dsi_host;
+struct msm_dsi_host_cfg_ops;
+const struct msm_dsi_host_cfg_ops *msm_dsi_host_get_cfg_ops(struct mipi_dsi_host *host);
 int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 					const struct mipi_dsi_msg *msg);
 void msm_dsi_host_xfer_restore(struct mipi_dsi_host *host,
@@ -67,20 +70,11 @@ int msm_dsi_host_cmd_tx(struct mipi_dsi_host *host,
 					const struct mipi_dsi_msg *msg);
 int msm_dsi_host_cmd_rx(struct mipi_dsi_host *host,
 					const struct mipi_dsi_msg *msg);
+/* bonded command path; registered in struct msm_dsi_host_cfg_ops */
+int msm_dsi_host_bonded_cmd_xfer(struct mipi_dsi_host *host,
+				 struct mipi_dsi_host *peer,
+				 const struct mipi_dsi_msg *msg);
 void msm_dsi_host_bonded_wait_video(struct mipi_dsi_host *host);
-int msm_dsi_host_bonded_xfer_prepare(struct mipi_dsi_host *host);
-void msm_dsi_host_bonded_xfer_restore(struct mipi_dsi_host *host);
-int msm_dsi_host_bonded_cmd_build(struct mipi_dsi_host *host,
-				  const struct mipi_dsi_msg *msg,
-				  u32 *dma_base, u32 *len);
-void msm_dsi_host_bonded_cmd_init_trigger(struct mipi_dsi_host *host);
-void msm_dsi_host_bonded_cmd_stage(struct mipi_dsi_host *host,
-				   const struct mipi_dsi_msg *msg,
-				   u32 dma_base, u32 len, bool master);
-void msm_dsi_host_bonded_cmd_trigger(struct mipi_dsi_host *host);
-int msm_dsi_host_bonded_cmd_arm_master(struct mipi_dsi_host *host);
-int msm_dsi_host_bonded_cmd_wait_master(struct mipi_dsi_host *host, u32 len);
-int msm_dsi_host_bonded_cmd_poll_slave(struct mipi_dsi_host *host);
 void msm_dsi_host_cmd_xfer_config(struct mipi_dsi_host *host,
 				  bool broadcast, bool master);
 void msm_dsi_host_cmd_xfer_commit(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 640ebe8244..aa44d9fcba 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -320,6 +320,9 @@ static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_9_host_ops = {
 	.tx_buf_put = dsi_tx_buf_put_6g,
 	.dma_base_get = dsi_dma_base_get_6g,
 	.calc_clk_rate = dsi_calc_clk_rate_6g,
+	/* SM8750 is the bonded part on this generation; see sm8650_dsi_cfg. */
+	.bonded_cmd_xfer = msm_dsi_host_bonded_cmd_xfer,
+	.bonded_wait_video = msm_dsi_host_bonded_wait_video,
 };
 
 static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index c8813a738b..4ab015fb82 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -82,6 +82,14 @@ struct msm_dsi_host_cfg_ops {
 	void (*tx_buf_put)(struct msm_dsi_host *msm_host);
 	int (*dma_base_get)(struct msm_dsi_host *msm_host, uint64_t *iova);
 	int (*calc_clk_rate)(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
+	/*
+	 * Bonded command path. Only filled for controllers that implement the
+	 * broadcast protocol; dsi_manager.c reaches them through these two ops.
+	 */
+	int (*bonded_cmd_xfer)(struct mipi_dsi_host *host,
+			       struct mipi_dsi_host *peer,
+			       const struct mipi_dsi_msg *msg);
+	void (*bonded_wait_video)(struct mipi_dsi_host *host);
 };
 
 struct msm_dsi_cfg_handler {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a3e9882c22..5df0e775b1 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2345,6 +2345,12 @@ void msm_dsi_host_bonded_wait_video(struct mipi_dsi_host *host)
 	dsi_wait4video_eng_busy(to_msm_dsi_host(host));
 }
 
+const struct msm_dsi_host_cfg_ops *
+msm_dsi_host_get_cfg_ops(struct mipi_dsi_host *host)
+{
+	return to_msm_dsi_host(host)->cfg_hnd->ops;
+}
+
 static const struct msm_dsi_bonded_cfg *
 dsi_bonded_cfg(struct msm_dsi_host *msm_host)
 {
@@ -2415,7 +2421,7 @@ static int dsi_cmd_link_clk_set_rate(struct msm_dsi_host *msm_host)
 	return msm_host->cfg_hnd->ops->link_clk_set_rate(msm_host);
 }
 
-int msm_dsi_host_bonded_xfer_prepare(struct mipi_dsi_host *host)
+static int dsi_bonded_xfer_prepare(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
@@ -2454,7 +2460,7 @@ int msm_dsi_host_bonded_xfer_prepare(struct mipi_dsi_host *host)
 	return ret;
 }
 
-void msm_dsi_host_bonded_xfer_restore(struct mipi_dsi_host *host)
+static void dsi_bonded_xfer_restore(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
@@ -2474,8 +2480,8 @@ void msm_dsi_host_bonded_xfer_restore(struct mipi_dsi_host *host)
 	pm_runtime_put_sync(&msm_host->pdev->dev);
 }
 
-int msm_dsi_host_bonded_cmd_build(struct mipi_dsi_host *host,
-				  const struct mipi_dsi_msg *msg,
+static int dsi_bonded_cmd_build(struct mipi_dsi_host *host,
+				const struct mipi_dsi_msg *msg,
 				  u32 *dma_base, u32 *len)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
@@ -2514,7 +2520,7 @@ int msm_dsi_host_bonded_cmd_build(struct mipi_dsi_host *host,
 	return 0;
 }
 
-void msm_dsi_host_bonded_cmd_init_trigger(struct mipi_dsi_host *host)
+static void dsi_bonded_cmd_init_trigger(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	u32 schedule_line;
@@ -2549,8 +2555,8 @@ void msm_dsi_host_bonded_cmd_init_trigger(struct mipi_dsi_host *host)
 	dsi_write(msm_host, REG_DSI_DMA_SCHEDULE_CTRL, val);
 }
 
-void msm_dsi_host_bonded_cmd_stage(struct mipi_dsi_host *host,
-				   const struct mipi_dsi_msg *msg,
+static void dsi_bonded_cmd_stage(struct mipi_dsi_host *host,
+				 const struct mipi_dsi_msg *msg,
 				   u32 dma_base, u32 len, bool master)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
@@ -2589,14 +2595,14 @@ void msm_dsi_host_bonded_cmd_stage(struct mipi_dsi_host *host,
 	dsi_write(msm_host, REG_DSI_DMA_LEN, len & GENMASK(23, 0));
 }
 
-void msm_dsi_host_bonded_cmd_trigger(struct mipi_dsi_host *host)
+static void dsi_bonded_cmd_trigger(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
 	dsi_write(msm_host, REG_DSI_TRIG_DMA, 1);
 }
 
-int msm_dsi_host_bonded_cmd_arm_master(struct mipi_dsi_host *host)
+static int dsi_bonded_cmd_arm_master(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 
@@ -2609,7 +2615,7 @@ int msm_dsi_host_bonded_cmd_arm_master(struct mipi_dsi_host *host)
 		0 : -EIO;
 }
 
-int msm_dsi_host_bonded_cmd_wait_master(struct mipi_dsi_host *host, u32 len)
+static int dsi_bonded_cmd_wait_master(struct mipi_dsi_host *host, u32 len)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	unsigned long completed;
@@ -2640,7 +2646,7 @@ int msm_dsi_host_bonded_cmd_wait_master(struct mipi_dsi_host *host, u32 len)
 	return -ETIMEDOUT;
 }
 
-int msm_dsi_host_bonded_cmd_poll_slave(struct mipi_dsi_host *host)
+static int dsi_bonded_cmd_poll_slave(struct mipi_dsi_host *host)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	u32 timeout_us = dsi_bonded_cfg(msm_host)->poll_timeout_us;
@@ -2660,6 +2666,68 @@ int msm_dsi_host_bonded_cmd_poll_slave(struct mipi_dsi_host *host)
 	return -ETIMEDOUT;
 }
 
+int msm_dsi_host_bonded_cmd_xfer(struct mipi_dsi_host *host,
+				 struct mipi_dsi_host *peer,
+				 const struct mipi_dsi_msg *msg)
+{
+	struct msm_dsi_host *master_dsi = to_msm_dsi_host(host);
+	u32 dma_base, len;
+	int master_ret, peer_ret, ret;
+
+	if (!peer)
+		return -ENODEV;
+
+	if (msm_dsi_manager_cmd_failed())
+		return -EIO;
+
+	ret = dsi_bonded_xfer_prepare(host);
+	if (ret)
+		return ret;
+	ret = dsi_bonded_xfer_prepare(peer);
+	if (ret)
+		goto restore_master;
+
+	/* Per-generation: the video engine must be idle before staging. */
+	master_dsi->cfg_hnd->ops->bonded_wait_video(host);
+	to_msm_dsi_host(peer)->cfg_hnd->ops->bonded_wait_video(peer);
+	ret = dsi_bonded_cmd_build(host, msg, &dma_base, &len);
+	if (ret)
+		goto restore_pair;
+	dsi_bonded_cmd_init_trigger(host);
+	dsi_bonded_cmd_init_trigger(peer);
+	dsi_bonded_cmd_stage(host, msg, dma_base, len, true);
+	dsi_bonded_cmd_stage(peer, msg, dma_base, len, false);
+
+	/* Flush the packet and both descriptors before starting either engine. */
+	wmb();
+	dsi_bonded_cmd_trigger(peer);
+	master_ret = dsi_bonded_cmd_arm_master(host);
+	if (!master_ret) {
+		wmb(); /* Enable the completion interrupt before master kickoff. */
+		dsi_bonded_cmd_trigger(host);
+		master_ret = dsi_bonded_cmd_wait_master(host, len);
+	}
+	/* Resolve the peer even if the master's completion failed. */
+	peer_ret = dsi_bonded_cmd_poll_slave(peer);
+	ret = master_ret < 0 ? master_ret : peer_ret < 0 ? peer_ret : len;
+	if (ret < 0) {
+		/* Never reuse a packet buffer while either DMA engine is unresolved. */
+		msm_dsi_manager_mark_cmd_failed();
+		dev_err(&master_dsi->pdev->dev,
+			"bonded command DMA failed: master=%d peer=%d\n",
+			master_ret, peer_ret);
+		return ret;
+	}
+
+restore_pair:
+	dsi_bonded_xfer_restore(host);
+	dsi_bonded_xfer_restore(peer);
+	return ret;
+restore_master:
+	dsi_bonded_xfer_restore(host);
+	return ret;
+}
+
 int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 				const struct mipi_dsi_msg *msg)
 {
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 93d636220b..917e51a73f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -11,6 +11,7 @@
 
 #include "msm_kms.h"
 #include "dsi.h"
+#include "dsi_cfg.h"
 
 #define DSI_CLOCK_MASTER	DSI_0
 #define DSI_CLOCK_SLAVE		DSI_1
@@ -52,6 +53,11 @@ static bool dsi_mgr_uses_bonded_cmd(void)
 	return msm_dsim_glb.is_sm8750 && IS_BONDED_DSI();
 }
 
+void msm_dsi_manager_mark_cmd_failed(void)
+{
+	WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
+}
+
 bool msm_dsi_manager_cmd_failed(void)
 {
 	return dsi_mgr_uses_bonded_cmd() &&
@@ -601,9 +607,7 @@ static bool dsi_mgr_use_bonded_write(const struct mipi_dsi_msg *msg)
 static int dsi_mgr_bonded_cmd_xfer(const struct mipi_dsi_msg *msg)
 {
 	struct msm_dsi *master_dsi, *slave_dsi;
-	struct mipi_dsi_host *master, *slave;
-	u32 dma_base, len;
-	int master_ret, slave_ret, ret;
+	const struct msm_dsi_host_cfg_ops *ops;
 
 	if (msm_dsim_glb.master_dsi_link_id < 0 ||
 	    msm_dsim_glb.master_dsi_link_id >= DSI_MAX)
@@ -613,57 +617,13 @@ static int dsi_mgr_bonded_cmd_xfer(const struct mipi_dsi_msg *msg)
 	slave_dsi = dsi_mgr_get_other_dsi(msm_dsim_glb.master_dsi_link_id);
 	if (!master_dsi || !slave_dsi || !master_dsi->host || !slave_dsi->host)
 		return -ENODEV;
-	master = master_dsi->host;
-	slave = slave_dsi->host;
-
-	if (msm_dsi_manager_cmd_failed())
-		return -EIO;
-
-	ret = msm_dsi_host_bonded_xfer_prepare(master);
-	if (ret)
-		return ret;
-	ret = msm_dsi_host_bonded_xfer_prepare(slave);
-	if (ret)
-		goto restore_master;
 
-	msm_dsi_host_bonded_wait_video(master);
-	msm_dsi_host_bonded_wait_video(slave);
-	ret = msm_dsi_host_bonded_cmd_build(master, msg, &dma_base, &len);
-	if (ret)
-		goto restore_pair;
-	msm_dsi_host_bonded_cmd_init_trigger(master);
-	msm_dsi_host_bonded_cmd_init_trigger(slave);
-	msm_dsi_host_bonded_cmd_stage(master, msg, dma_base, len, true);
-	msm_dsi_host_bonded_cmd_stage(slave, msg, dma_base, len, false);
-
-	/* Flush the packet and both descriptors before starting either engine. */
-	wmb();
-	msm_dsi_host_bonded_cmd_trigger(slave);
-	master_ret = msm_dsi_host_bonded_cmd_arm_master(master);
-	if (!master_ret) {
-		wmb(); /* Enable the completion interrupt before master kickoff. */
-		msm_dsi_host_bonded_cmd_trigger(master);
-		master_ret = msm_dsi_host_bonded_cmd_wait_master(master, len);
-	}
-	/* Resolve the peer even if the master's completion failed. */
-	slave_ret = msm_dsi_host_bonded_cmd_poll_slave(slave);
-	ret = master_ret < 0 ? master_ret : slave_ret < 0 ? slave_ret : len;
-	if (ret < 0) {
-		/* Never reuse a packet buffer while either DMA engine is unresolved. */
-		WRITE_ONCE(msm_dsim_glb.bonded_cmd_failed, true);
-		dev_err(&master_dsi->pdev->dev,
-			"bonded command DMA failed: master=%d peer=%d\n",
-			master_ret, slave_ret);
-		return ret;
-	}
+	/* Which hosts run the broadcast engine is per-generation knowledge. */
+	ops = msm_dsi_host_get_cfg_ops(master_dsi->host);
+	if (!ops || !ops->bonded_cmd_xfer)
+		return -EOPNOTSUPP;
 
-restore_pair:
-	msm_dsi_host_bonded_xfer_restore(master);
-	msm_dsi_host_bonded_xfer_restore(slave);
-	return ret;
-restore_master:
-	msm_dsi_host_bonded_xfer_restore(master);
-	return ret;
+	return ops->bonded_cmd_xfer(master_dsi->host, slave_dsi->host, msg);
 }
 
 int msm_dsi_manager_cmd_xfer(int id, const struct mipi_dsi_msg *msg)
-- 
2.53.0

