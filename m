Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB49CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB2B10E7B0;
	Wed, 10 Jun 2026 07:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="BuNSqgCZ";
	dkim-atps=neutral
X-Greylist: delayed 62934 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 03:04:23 UTC
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03AA310E6B3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1781060642;
 bh=pPmroeQDHsA9ug2HnLTa8g6lPR2P7s9mi76pG8L8oJI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=BuNSqgCZlJmnGmMVd/iPKDirBsV/5/yYjnlkefASCAi6aMqzs/z/bcIcKmsQZigQD
 Oma6S1YRLOeZUU8cMhU9ouyZMCreH0ySQ65XEzJ/n6P84VspTI36PMDGbshBBYzcbw
 3LkNp0z4Bc/jbviZTM/Vg+xVdylj8pwN5wt6gfFI=
X-QQ-mid: esmtpgz13t1781060624tc1abae19
X-QQ-Originating-IP: cLg5X++iDCAXLdBCZBxzRSN4dV8URO0z6d3AWbklGOE=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 10 Jun 2026 11:03:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2952194183593288770
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, ZhaoJinming <zhaojinming@uniontech.com>,
 stable@vger.kernel.org
Subject: [PATCH v4 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Wed, 10 Jun 2026 11:03:22 +0800
Message-Id: <20260610030322.2802744-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610030322.2802744-1-zhaojinming@uniontech.com>
References: <20260609094756.8DDFD1F00893@smtp.kernel.org>
 <20260610030322.2802744-1-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N7V5dvLk9gGfNKwaqmR804LFZSjywXn/11FfW7YtIkRsck2p2GyRkBHO
 WuA0sPIcwR9KbL04RkBSCFOUz2uA1pc1F2KVRN82piJsoDkgQdy2QzSRCe12UVcFTPnuAOF
 h41ba8t2XHLCCoyvUt3EzjcQpVSgKwgT5yuEgDQucmBTk2wXd2/Z38TgHQ0yz3NbfpZiE5M
 5u1pQI26lnRsyBlJ3VAA/swO0KnYwdKRCiJP4fF6lboxEcE+QE6BhIfuqF1hfSxt1X25mr2
 x+i0yPJLZVDwny5lLpxdzoW29blMqpdYemGqyDn0zuQ8bAFylHYpsY4Aik4MyuHJT//lfad
 rqy3ZDFkgxviLXNdxiDE7S5OlslS0t4Our6O1V7Xx+k/Jq8B6Q04GjkQ+M3vF3z+HMjDt6T
 eFU9QZFMYkhlsxkmT0Njs1hvSXt9OIddf8jFrwtKIXqAWPTxp8Z+qI6yxm/bkb4Z6l3+sYW
 ls/kXdGvK+dC4guOTOgZIL6DeLldEHtvbO/fa2KorAwzQX5uP7Ie0t/zZnSOqklUWTPcSqV
 nzLf4aC8zJySXhRD6LkioU8ljWr9mlmY+iktQ9YjZcq108FicZgJqyc4AWOrJm6X51pA8AV
 lSo8RIga64z0PevFHPTgSXFsqZHpz+kcNI8RWrPt9ltU0/xmhQ1+jYiOpSn4IuiH0YqFbXN
 fYfpOuseGXPsFWdBSAtUxCWxhIn6ivADa5wxFyHCO5G1buUIzmQ6pwNuWRdK1zUx1Pm5JN0
 6G+qF/pVAN9kZVMrZfBDVLMF5tygGpr6bpRyLfBU0Cwrn8//VI2x9Y+9g+VctmVC1GslYSt
 Uatp4AXtAEKadOdVxG1Rr0sBe2KW/eFa9A/ZfvhBzxxyw4hV/6FDJ8IlZsjM9z14SszeYg+
 yZURZpARso0Svup2hZyQsZ0DSEZfTDeK6Y71mMPE6dBD4KVc/h5RPXMOSx0FOq5IkXWEKy9
 MzNN4ZQyGQsGF4CfmXs8MVVX71Df335WUftB2RKBHSbkta/dhobKTojoSeNYffbLKWdJECG
 2g3WutyIdy5GXLzy7vPu73bUnal7hUSeHMGvmJrvzR9pezlO8btFmFql77us+rvfvsbXNnu
 UUfV1BplF7w
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:35 +0000
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

Two bugs in the IRQ handling path:

1) iommu_group reference leak in rocket_job_handle_irq():
   iommu_group_get() increments the reference count but the returned
   pointer is passed directly to iommu_detach_group() which does not
   consume it. Since this runs on every completed job, the reference
   count accumulates and prevents the group from being freed. Use
   core->iommu_group instead, consistent with rocket_reset().

2) Unsafe hardware register access in shared IRQ handler:
   rocket_job_irq_handler() is registered with IRQF_SHARED but accesses
   hardware registers without checking runtime PM status. If another
   device on the same IRQ line triggers an interrupt while the NPU is
   suspended, register reads return 0xffffffff, spuriously triggering
   WARN_ON macros and falsely returning IRQ_WAKE_THREAD.

   Add pm_runtime_get_if_active() in the hardirq handler to atomically
   verify the device is active before accessing registers. Each handler
   (hardirq and threaded) independently acquires and releases its own
   runtime PM reference to avoid coalescing-related leaks when the
   IRQ core coalesces multiple wakeups into a single thread execution.

Cc: stable@vger.kernel.org
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/accel/rocket/rocket_job.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e8a073e22ac2..f05043619169 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -349,7 +349,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 				return;
 			}
 
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
+			iommu_detach_group(NULL, core->iommu_group);
 			dma_fence_signal(core->in_flight_job->done_fence);
 			pm_runtime_put_autosuspend(core->dev);
 			core->in_flight_job = NULL;
@@ -420,7 +420,10 @@ static irqreturn_t rocket_job_irq_handler_thread(int irq, void *data)
 {
 	struct rocket_core *core = data;
 
-	rocket_job_handle_irq(core);
+	if (pm_runtime_get_if_active(core->dev)) {
+		rocket_job_handle_irq(core);
+		pm_runtime_put(core->dev);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -428,16 +431,24 @@ static irqreturn_t rocket_job_irq_handler_thread(int irq, void *data)
 static irqreturn_t rocket_job_irq_handler(int irq, void *data)
 {
 	struct rocket_core *core = data;
-	u32 raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
+	u32 raw_status;
+
+	if (pm_runtime_get_if_active(core->dev) != 1)
+		return IRQ_NONE;
+
+	raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
 
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
 
 	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
-	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
+	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
+		pm_runtime_put(core->dev);
 		return IRQ_NONE;
+	}
 
 	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+	pm_runtime_put(core->dev);
 
 	return IRQ_WAKE_THREAD;
 }
-- 
2.20.1

