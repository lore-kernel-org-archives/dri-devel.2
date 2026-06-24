Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38D1CDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544B110F13A;
	Thu, 25 Jun 2026 07:03:21 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC3A10EF60
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowAAngNPC6ztqXloHFQ--.931S2;
 Wed, 24 Jun 2026 22:37:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: ipu-v3: fail PRG channel setup when buffer fill times out
Date: Wed, 24 Jun 2026 22:37:52 +0800
Message-ID: <20260624143752.53943-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAngNPC6ztqXloHFQ--.931S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43XFykXrW8CFy8tw18Zrb_yoW8AFW3pF
 W5tw1Yqr9rta1fGFn3u3srXF43Aw17Wa13CFZ3J3Z8Zw15JrnIvF90yFyvgFyDXFnrJFy0
 qrsYva47GF45tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIfO7UUU
 UU=
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

ipu_prg_channel_configure() waits for both PRG double buffers to become
ready, but ignores readl_poll_timeout() failures. A timeout is therefore
reported as a successful configuration and chan->enabled is set even
though the hardware did not report ready buffers.

Propagate the timeout error. Before returning, put the channel back into
bypass mode and release the PRE allocated for this configuration so the
software state stays consistent with the failed setup.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/ipu-v3/ipu-prg.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index d38d3ba54..ff32f4ca5 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -327,10 +327,22 @@ int ipu_prg_channel_configure(struct ipuv3_channel *ipu_chan,
 	writel(val, prg->regs + IPU_PRG_REG_UPDATE);
 
 	/* wait for both double buffers to be filled */
-	readl_poll_timeout(prg->regs + IPU_PRG_STATUS, val,
-			   (val & IPU_PRG_STATUS_BUFFER0_READY(prg_chan)) &&
-			   (val & IPU_PRG_STATUS_BUFFER1_READY(prg_chan)),
-			   5, 1000);
+	ret = readl_poll_timeout(prg->regs + IPU_PRG_STATUS, val,
+				 (val & IPU_PRG_STATUS_BUFFER0_READY(prg_chan)) &&
+				 (val & IPU_PRG_STATUS_BUFFER1_READY(prg_chan)),
+				 5, 1000);
+	if (ret) {
+		val = readl(prg->regs + IPU_PRG_CTL);
+		val |= IPU_PRG_CTL_BYPASS(prg_chan);
+		writel(val, prg->regs + IPU_PRG_CTL);
+
+		val = IPU_PRG_REG_UPDATE_REG_UPDATE;
+		writel(val, prg->regs + IPU_PRG_REG_UPDATE);
+
+		pm_runtime_put(prg->dev);
+		ipu_prg_put_pre(prg, prg_chan);
+		return ret;
+	}
 
 	pm_runtime_put(prg->dev);
 
-- 
2.50.1 (Apple Git-155)

