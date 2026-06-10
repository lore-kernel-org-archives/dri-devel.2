Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32056CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE6710E792;
	Wed, 10 Jun 2026 07:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="lxoC9Ba5";
	dkim-atps=neutral
X-Greylist: delayed 4149 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 07:11:50 UTC
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8607B10E754
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1781075482;
 bh=Lz7tRcHhsQMSOJADDW7TXRw2/HZdu+zrYPBgdVPaoJ0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=lxoC9Ba5gdZVCGgoP21Tk4kTElzw7kh8mZhoCWjlZADl69kDfRwrG8DfQUD2NNoxZ
 TWkQ/JfLg5gPy07a0bsCWaAbhlEIadlrOp54vUlcJEoGE0pYJdbMXwUCqMu3M8iCoM
 dQg9VyytfZGnabcTS4oq8zE65SXW6VXXmUUq0DWE=
X-QQ-mid: esmtpsz20t1781075463tdf94633b
X-QQ-Originating-IP: u7bnKZCN2RIVwN7K432cgmAtncJafcjvuAwIW4UI9ss=
Received: from localhost.localdomain ( [1.202.39.170])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 10 Jun 2026 15:11:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18434185685029258688
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
Subject: [PATCH v6 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Wed, 10 Jun 2026 15:10:45 +0800
Message-Id: <20260610071045.3414828-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610071045.3414828-1-zhaojinming@uniontech.com>
References: <20260610061915.1CA281F00893@smtp.kernel.org>
 <20260610071045.3414828-1-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NRaYAQcThOfQHS/M6CWXU1r/FUxQh0b6LxZ09Zc3ZxGh05Mzzmcp16ME
 tw3CHItjPoiD/3EYQHqYiuzdEdLnkneXhPuvv1xn9DhKn9ezirxBhdb0tBy9n3rXPaH+/FR
 AHjKoOi2gFpasAn/s1MrE+ExYqgyX8RqNFTNoLya6u2ebW4FdTjSdv9NpUvj3IGzHxgPk3m
 wX9YawW9y+N8HgS64TRhD4eeVwR5mZSdDefEoKUPu+If/KYfsIOCEUBbbBQ65NA5sdPCnQ3
 hGu6xJo5kZLIhLuBWnQh8jCwxS5Yt5QBBhFBiPuPVsbq3txBNe7Pltwqgqr2YYTFsXCSMGy
 5PYgztGJXSXciFa8pVL9WxmngHKCoE1f1Zau/gJy3pj41YlM4XVMa9Ksj5SGHLjGAvXOcXs
 yEav71TcBoOGR2D/Rww9c+X3H4UdnO3F6OeZY2HUgv4hPxV6av3F+EyA/G9zIIYVvy94b9n
 LU8Y5vY0MRWtjLiZwMNo91bUXAeE2SBzWwTJpDSUkt1wi3pDgEB0OMxvbdMqTXmhpIXfQoa
 N15PBAuy3JALOkfnth5Va/rwHH8+6fUgoscePceIcpGitIglYPPbLEG9LBCrgyAwd6RxAVn
 qjZT9Vkn892aTVmfvy/1DRR9Z662ngIAA2nmumCKuvKNWvu82PSEJe4fksrdONuDFTN1GIL
 +5GBv4RVMlbJ3AeUN78UAjZlp8bOKLDiGLTSPnM8bEcD+7ghTYPJ7O/1qz7Rc40kcY6jGIJ
 Wnwh46+DpveLuYYSClYEAHTS+s236maKXlMfCG+rDT+qfxJQnqCAydSu2ZnvzyL4cVKNvNe
 I+U61TNedif0/WutKQjAYsYdRxX1KwuKpaEaOPHuoXOUHacNmlf4VudLi6Uk8FayV87SjuT
 b9LTHZkLk1J+MFlz0fjdn9vRSwGeRJNorZpAJmr0yHWPoXRazM1srfnszDgiUm1DuIfL2ir
 iMHY9C8+/2hVJP8oZOuYWyrQA+Rq/58x3HGqdCNI6VqYTCc8sYWq+1LTLY5wZ/ExSW/rXHn
 8FzdCvFKYCLIHmS/W73Ymr1ae205QzKL9iAIVDQbW2KT6etzbafoRTeZzxl/e8iVf7dYUcF
 NlZoc2ewBHpnpm60X5b/asSZw0+ZEpJinL9gG4xmQtbnPO+RDmA3nP78a+Qzf6/jYGO2FxJ
 0Fv3kENyyw0h44A2Be+upcDR4g==
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
 drivers/accel/rocket/rocket_job.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e8a073e22ac2..334bf01c3382 100644
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
+	if (pm_runtime_get_if_active(core->dev) == 1) {
+		rocket_job_handle_irq(core);
+		pm_runtime_put(core->dev);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -428,16 +431,28 @@ static irqreturn_t rocket_job_irq_handler_thread(int irq, void *data)
 static irqreturn_t rocket_job_irq_handler(int irq, void *data)
 {
 	struct rocket_core *core = data;
-	u32 raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
+	u32 raw_status;
+	int ret;
+
+	ret = pm_runtime_get_if_active(core->dev);
+	if (ret == 0)
+		return IRQ_NONE;
+
+	raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
 
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
 
 	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
-	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
+	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
+		if (ret > 0)
+			pm_runtime_put(core->dev);
 		return IRQ_NONE;
+	}
 
 	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+	if (ret > 0)
+		pm_runtime_put(core->dev);
 
 	return IRQ_WAKE_THREAD;
 }
-- 
2.20.1

