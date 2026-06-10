Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E928CD98CC
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E3A10E7C7;
	Wed, 10 Jun 2026 07:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="Q3vrav3p";
	dkim-atps=neutral
X-Greylist: delayed 158460 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 06:02:44 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.73.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C7410E707
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1781071331;
 bh=kfi9QQs1sSwBEx+EWPByMHmDQhMKagxQkR72o+z1MxU=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Q3vrav3p2K3rIndpoalfPkjR3tbptoQGE0460gBJDktvHpgYr+qwWyMShs6/eayfe
 cw26sDAS3sO6afKnl4zV6lMEh0jrKn77n2aOh7wDBnxseBn1ZGsGtp1Cw2oYkdzur0
 jn7OB/NFsbz1qclZw0M8jHY2khqPxg4mNtSKZ/V0=
X-QQ-mid: esmtpsz18t1781071313t87eaabd4
X-QQ-Originating-IP: HzTryzSASr1kVugWO+zDD+LA0POeXIQkgLA7vapCPC0=
Received: from localhost.localdomain ( [124.126.19.250])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 10 Jun 2026 14:01:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4142150529808979720
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
Subject: [PATCH v5 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Wed, 10 Jun 2026 14:01:32 +0800
Message-Id: <20260610060132.3239648-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260610060132.3239648-1-zhaojinming@uniontech.com>
References: <20260610031431.E8EA71F00893@smtp.kernel.org>
 <20260610060132.3239648-1-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N9YbC0BvHDAbkCjuMZ1NwoUZFgpUVUCAqzsRZ3gvum4FTtXf4iU8FymF
 uW53nWRxEkGIJRiQj2mIB/yE2aFbrBGNnVOUCFL3xKpkP2GJC1UhBwjIjwZ/VDqZzcoBdcg
 J0LLr2WIomNApAxfDrOusE54FaOs0+kzDiXyI3S+baCdNgs2JlS29cy54V9+a6NuBo0+BZP
 WWkGa2KnHibtGA/ksmXXk7YGx7iIu1ETVJwk0xhM71sLClBDrcKL1IhiStC0Ljvy54BMKNt
 q0dIqLgREVyBsEEA8QLZAMz4K5pKfSyTb5Bg5xWshzO/4U6o8A5lMQsFekNVxQqmY+qH5ao
 mBOaTii/nbW8L12GJLhF0vUAxINwwQl8bUC6O/jolb3MniSpnyMmaWcGPI3bg3Jy4DsjDxV
 Tlsae97O0XsHwCLqqe9O+JO0nX6Us3ncJFV8txROEjtqnVgCTPVuuY9LfN+nd+L2z+BPb8e
 gtmXpc79vclmjVLq/uaxpW5mAbQAgejSRbDwL6vbR6Q7EWhCDi294ousgGp9neT0rKlVI58
 3AuL57y49fyy6QMy8BRTtVrrUGgsRln/W4U9Dw750hleUDrPNSMHpA7IL8zY2D3PxXkEy+A
 O1jIyVPmuGbl3GvcOuciGx7tDlr+03DBGLbS8vaMOnB8JnzVX+WbJ7qXaycdzIA4WQeUbjU
 /XCB2SG8PjWy2jH2reIIj+wkQ3yjLX46lea9Nfgb27jrz1bH5+hstA6eJ+D9FMjKSjTu7bL
 kYN3mr/7b1wexJggVox3qJFkqPbzKcmKlCPYVu0uNAOy2EBlajBuEr6Fhcb30vxQXbp7elC
 K4C231SkHUf3bsM/yZtdD5xtfigl6C/K5aft2CSCm3+H6BTvO5fweQUIB31Zz8a+Xw6AZwS
 nagmIvDV4wpXVQj7z10nmHndZ7lRB05Z9dO4stLg2DGJ0TPrWPkSU3xuh9HXZt1OOYxhNtc
 AHdImdEmJ8Z5MQWsA/3btrGzi8Gf5FbQxnlXdSmpRNOBH3szPHaapZxnQl2J9+fCYOYmoX5
 pMiL6d6qPb6O+CruXGGxyjQJoX3xysvhsu2uXGP4IHjt6AdPnYOTl7+o3aeADvnwgKDZlQd
 XHyy339WLBJ5NetmdOa/T7RBWrSTzG/Zuh9BarncIH8fPyr7Q5qthNAGDOX6FCdkrBvwDBb
 kWzIWrOZauWAPwk=
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
index e8a073e22ac2..0ea3b3099704 100644
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

