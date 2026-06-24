Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E6DCDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3286E10F12F;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A928310EF73
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowADXYQUD7Ttq0YoHFQ--.42917S2;
 Wed, 24 Jun 2026 22:43:15 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Helge Deller <deller@gmx.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: via: return an error when DMA copy times out
Date: Wed, 24 Jun 2026 22:43:13 +0800
Message-ID: <20260624144313.79291-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXYQUD7Ttq0YoHFQ--.42917S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW3trW3Zr4kXr4xJr48tFb_yoW8WFW7pF
 98Ga4avFy3tr1vkw4UKF40gFy5CFyfJFWfGFWxC3s09w4ayr45ury5tFyjqrW5uF9akF4x
 XFyDt34rur4Y9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
 UUUUU==
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

viafb_dma_copy_out_sg() logs a VIA DMA timeout when the DONE bit is not
set after the completion wait and grace delay, but still returns success
to the caller.

Preserve the existing cleanup sequence and return -ETIMEDOUT when the DMA
engine did not report completion.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/video/fbdev/via/via-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index a8d4a3e2c..ff691f83e 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -234,6 +234,7 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct scatterlist *sg, int nsg)
 	dma_addr_t descr_handle;
 	unsigned long flags;
 	int i;
+	int ret = 0;
 	struct scatterlist *sgentry;
 	dma_addr_t nextdesc;
 
@@ -290,8 +291,10 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct scatterlist *sg, int nsg)
 	 */
 	wait_for_completion_timeout(&viafb_dma_completion, 1);
 	msleep(1);
-	if ((viafb_mmio_read(VDMA_CSR0)&VDMA_C_DONE) == 0)
+	if ((viafb_mmio_read(VDMA_CSR0) & VDMA_C_DONE) == 0) {
 		printk(KERN_ERR "VIA DMA timeout!\n");
+		ret = -ETIMEDOUT;
+	}
 	/*
 	 * Clean up and we're done.
 	 */
@@ -301,7 +304,7 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct scatterlist *sg, int nsg)
 	dma_free_coherent(&global_dev.pdev->dev,
 			nsg*sizeof(struct viafb_vx855_dma_descr), descrpages,
 			descr_handle);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(viafb_dma_copy_out_sg);
 #endif /* CONFIG_VIDEO_VIA_CAMERA */
-- 
2.50.1 (Apple Git-155)

