Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB069CD98C8
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF12F10E7BE;
	Wed, 10 Jun 2026 07:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="hrsS21lO";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E355D10E1D6
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1780997695;
 bh=F/ATENqeutHEFBLWCq5KxclWHjONItFaJGr0IzvOtgs=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=hrsS21lOqN3i5+rw4GQJYsou/okEHaw8A3dvbW4xnGA8vjIFP26VfdlkkRIqrOuM0
 Y0p0jG7oAkgAI8i1lHHCZ2gAguOMejMXAKJM0u4AQwwprNTBPxn45ALc8r5/BTyeWN
 VPSaAt+GkDFqKEjNwRqHBb6XXSx3HlVQTNo9odGo=
X-QQ-mid: esmtpsz17t1780997677tad01d33d
X-QQ-Originating-IP: pIjK55WJPXl+Qs4jtZPT67LZr4pec0GM+rpziWhGDf4=
Received: from localhost.localdomain ( [124.126.19.250])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 09 Jun 2026 17:34:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3266297912186802098
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
Subject: [PATCH v3 2/2] accel/rocket: Fix iommu_group leak and unsafe IRQ
 register access
Date: Tue,  9 Jun 2026 17:33:46 +0800
Message-Id: <20260609093346.380396-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260609093346.380396-1-zhaojinming@uniontech.com>
References: <20260608103845.6F4AB1F00893@smtp.kernel.org>
 <20260609093346.380396-1-zhaojinming@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MaCc72GaN9m8qf291dVW5l5v6BjRZqqJqqnaoaqCSiXKnKE16TR8K2Lk
 cXCgpcdJ7ZJhdiFpGeECCRCl1gmn7Ihe6dfWjHTelziGAvHKk4S5SABhIo2Kn+Xl1o/CeQ5
 fUfmdwsANFcFqKHexaANoj9tDk82BzE+j6o+o3H4kkG9bl3YCddoVepHNFEDsbUmSViBIOy
 xiRoLoTDuAWz86rBtBD0XBiB4FjNTOGkNlsjG1idvR0BXScYFYF9BuWm1BcyWdFz6px3TJQ
 RhW05gxxPg1JBk7xGKJqKZq0Lvdq93kQ9Hufxp62PMWDHqSmVDRbWYK7NexmlQQBhKqqJ9l
 B9aYGTxvc431MPp8hfBdw15DtPVQSnxt+apmlW51o7AoUEGt9CWD2BqV5/1YzRvoekvJr37
 Ommy87BbXWVel2uoSKfXXJ19hXXywIUYp/WAkeasoCSQ88iJ+iEq9JnqEM3FIX+6+Zkl6+I
 6psOiqGO8PRdgnXK0uCixr8y6ehzrwCAGIUyJSkbVGYNJpBLOXW2rOgX0ZI9Qklua9W0v3j
 daSI5HWW6/OEe4a9LggxOFJAGWEgoYJC9prbPqAt5o3wn6XHggo4nwAQfRo4KZnRX+rs7Hp
 4+Eis0yzdigDf6/NTfGF98p4XEQ34gIUyuZctJuSXBslKlp9x6D2VgMbmyWgHxCQJFVnqNP
 urnsp+146OFRhGTYodqZIGmi+3rzBc6k6b36+Rk86pyZ2aWDI2H1J/t5QG5A0koO+jmXytW
 /49XXnYJMixmHMYjTViuSMPXw4o2XnT0gdjRwpIJtjE8KA4E6W0mfIZSw4mCgveErMKnmQL
 MH8KasKfckWy4ziaIthfa1lzcR37QsIeJBUTAKvwhvqDmyVZBW+/gkcMubEBvnUmf42+kSh
 vs09A0Wq1qwl+j/idZIO8xj/FraDKPNQz3tcY5/417iKhOnrdawmAdJlLz95bxTKsZvD98W
 dEjNkNNGl+ttw3qYIBfM3BUX4myvXM9OByxktke0ffJ8TC/078Y0S+kvMw/TPRPefLNJVZQ
 iGFQH/cib7D98XQQVzBMXVwgfZcD4x8A43rk6tdIPg6VVCHiz3/EkxvB5FSg6dHcc7BRh40
 g==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

   Replace with pm_runtime_get_if_active(), which atomically checks the
   device status under spinlock and increments the usage count to keep
   the device active during register access. Balance the extra reference:
   - If the interrupt is not for this device (raw_status does not match
     DPU_0/DPU_1), put in the hardirq handler before returning IRQ_NONE.
   - If the interrupt is for this device, the thread handler puts after
     completing register writes.

Cc: stable@vger.kernel.org
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/accel/rocket/rocket_job.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index e8a073e22ac2..30c677952b64 100644
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
@@ -421,6 +421,7 @@ static irqreturn_t rocket_job_irq_handler_thread(int irq, void *data)
 	struct rocket_core *core = data;
 
 	rocket_job_handle_irq(core);
+	pm_runtime_put(core->dev);
 
 	return IRQ_HANDLED;
 }
@@ -428,14 +429,20 @@ static irqreturn_t rocket_job_irq_handler_thread(int irq, void *data)
 static irqreturn_t rocket_job_irq_handler(int irq, void *data)
 {
 	struct rocket_core *core = data;
+
+	if (!pm_runtime_get_if_active(core->dev))
+		return IRQ_NONE;
+
 	u32 raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
 
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
 
 	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
-	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
+	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1)) {
+		pm_runtime_put(core->dev);
 		return IRQ_NONE;
+	}
 
 	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
 
-- 
2.20.1

