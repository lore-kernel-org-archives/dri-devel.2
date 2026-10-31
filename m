Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B773606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=sf7gg3g1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604DD10EA08;
	Sun,  1 Nov 2026 11:58:25 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 979AD10E1C1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding; bh=tzc7ugbFEzSFOuams8SMQo+EvzOblbu1h7
 8RTzijqGc=; b=sf7gg3g1uEtE9ijQ624wh9GdzekKcDfrujt3me6CKa6FZmX58M
 1PVkyak+TD5d1b5qI0zb7DTsfQiSlYc3WW/a9aBIvQ+iVe8QXJ/4fTs3hYWvRbBf
 SLDlhaVqogph7VkiUT/nrLJheEo5LsUjzF9GUxUmiuh1Jsokvjz9OUat8=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.177.113])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDHS0ApA+ZqqSNvAA--.5005S7;
 Sat, 31 Oct 2026 23:03:10 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/msm/dsi: name the FIFO error bits of the bonded
 command path
Date: Sat, 31 Oct 2026 23:03:05 +0800
Message-ID: <20261031150305.1107572-6-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDHS0ApA+ZqqSNvAA--.5005S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy5Wr4DKw1rCr1kCrWfXwb_yoW5Kry7pw
 45Jwn8JFykAF12vryxta90gr4Yqas5KFWxGFy7K398u3Z3Jw1jg3yI9an0g34DJa4fA34S
 gFsrKrykAr40yrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
 jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
 8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
 87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
 kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm
 72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2
 xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
 5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
 WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
 1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
 v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
 vjxUyJDGDUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARERB2rk8FY0gwAKsT
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

The per-SoC bonded config carries the controller FIFO error group as two
magic numbers: 0x001f0200 in ERR_INT_MASK0 and 0x44440400 in FIFO_STATUS.
They are documented - FIFO_STATUS bitfields carry public names in dsi.xml
(the command DMA FIFO underflow at bit 10 and the DLN0..DLN3 HS FIFO
overflows at bits 18/22/26/30, whose OR is exactly 0x44440400), while
ERR_INT_MASK0 has no field definitions in dsi.xml, so its side is spelled
out from the bit layout: GENMASK(20, 16) | BIT(9) = 0x001f0200. The
grouping is not guessed: the vendor driver's mask_error_intr() masks
exactly these bits as one FIFO error group.

Name both groups (DSI_ERR_INT_MASK0_FIFO_ERRORS,
DSI_FIFO_STATUS_FIFO_ERRORS), switch the sm8750 table to them and drop
the TODO(doc) note now that the provenance lives in the macro comments.

No functional change: both macro groups expand to the previous literals.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index aa44d9fcba..05d9e1a191 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -199,15 +199,37 @@ static const struct regulator_bulk_data sm8650_dsi_regulators[] = {
  * Bonded command-path data. Values are copied verbatim from the vendor-derived
  * in-tree code; the SM8750 compatible check in dsi_host.c/dsi_manager.c still
  * gates every use until the master link moves into this table as well.
- * TODO(doc): err_clear_bits/err_cleanup_bits touch bits that dsi.xml does not
- * describe (see reports/b5-per-soc-cfg-design-20261027.md, RFC-SCOPE R1).
  */
+
+/*
+ * FIFO error bits of ERR_INT_MASK0. dsi.xml does not describe the layout of
+ * this register, so the mask bits are spelled out: bits 20:16 mask the high
+ * speed FIFO overflow group (bits 16:19 are the DLN0..DLN3 overflows, bit 20
+ * is part of the group but carries no public name) and bit 9 is the command
+ * DMA FIFO underflow. The grouping is not guessed: the vendor driver's
+ * mask_error_intr() masks exactly these bits as one FIFO error group.
+ */
+#define DSI_ERR_INT_MASK0_FIFO_OVERFLOW		GENMASK(20, 16)
+#define DSI_ERR_INT_MASK0_CMD_DMA_FIFO_UNDERFLOW	BIT(9)
+#define DSI_ERR_INT_MASK0_FIFO_ERRORS \
+	(DSI_ERR_INT_MASK0_FIFO_OVERFLOW | DSI_ERR_INT_MASK0_CMD_DMA_FIFO_UNDERFLOW)
+
+/*
+ * Matching sticky FIFO_STATUS bits, write-1-to-clear. These carry public names
+ * in dsi.xml: CMD_DMA_FIFO_UNDERFLOW at bit 10 and the DLN0..DLN3 HS FIFO
+ * overflows at bits 18/22/26/30.
+ */
+#define DSI_FIFO_STATUS_FIFO_ERRORS \
+	(DSI_FIFO_STATUS_CMD_DMA_FIFO_UNDERFLOW | \
+	 DSI_FIFO_STATUS_DLN0_HS_FIFO_OVERFLOW | DSI_FIFO_STATUS_DLN1_HS_FIFO_OVERFLOW | \
+	 DSI_FIFO_STATUS_DLN2_HS_FIFO_OVERFLOW | DSI_FIFO_STATUS_DLN3_HS_FIFO_OVERFLOW)
+
 static const struct msm_dsi_bonded_cfg sm8750_dsi_bonded_cfg = {
 	.master_link_id = DSI_0,
 	.cmd_dma_ctrl = DSI_CMD_DMA_CTRL_BROADCAST_EN |
 			DSI_CMD_DMA_CTRL_FROM_FRAME_BUFFER,
-	.err_clear_bits = 0x001f0200,
-	.err_cleanup_bits = 0x44440400,
+	.err_clear_bits = DSI_ERR_INT_MASK0_FIFO_ERRORS,
+	.err_cleanup_bits = DSI_FIFO_STATUS_FIFO_ERRORS,
 	.poll_timeout_us = 5000,	/* 500 polls, 10 us apart */
 	.needs_link_clk_bump = true,
 	.needs_sw_reset = true,
-- 
2.53.0

