Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E8CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 14:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A744C10E0CC;
	Sat, 16 May 2026 14:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dRtYqAj5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA7C10E0CC
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RAjEV2u0wbUbeOB+fs6iieBuLeYR07/gzKV2MJzOV7M=; b=dRtYqAj5r+sVKrcRicm2yBcL5X
 75Zy+vtYRgjIMpRAqWaEBCJLzGTJNG1P7HpoOah0OLkD0nFQLvNQ96H0kshPfWLjGQX3JOlTObpZg
 IkCJU8keBQWm8C0PuFVhP4Pc+w0mAn91gS0sVkq7tIR8mZ4v0SVZvHArI8p2xuflQdrfn+sv1nzSa
 5EGNW7pYayBY987bgIr2d4t1T+ijVCRHG/elrX3vISKXEnhLVsrU0rd6OPkuogE+uawk7AhbNDyG1
 0Z1XymJFnL3pjWMgmWCKHNbwXbSWRyv5FQMBBj8A7Z46Qm9T+NK3qkyRA7Jp1FIynLuks8FPQ94h2
 rIFNLYmw==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wOGHr-000yTa-S7; Sat, 16 May 2026 16:46:44 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] accel: ethosu: Remove redundant job_lock
Date: Sat, 16 May 2026 11:40:59 -0300
Message-ID: <20260516144623.2582427-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The job_lock mutex guarded dev->in_flight_job across ethosu_job_run(),
the threaded IRQ handler, and ethosu_job_timedout(). However, the DRM
scheduler already provides most of the serialization required, which
makes this mutex redundant.

Analyzing the different scenarios:

  1. run_job() and timedout_job() are mutually exclusive scheduler
     callbacks, so the scheduler itself serializes them.

  2. run_job() and the IRQ handler are implicitly serialized, but they can
     overlap in time: dma_fence_signal() synchronously queues the next
     run_job onto submit_wq, and the worker can execute run_job(next) on
     another CPU before the IRQ thread finishes. The mutex previously kept
     the IRQ's trailing "in_flight_job = NULL" from racing run_job(next)'s
     "in_flight_job = next" store.

     The handler is now restructured to clear in_flight_job before calling
     dma_fence_signal(), so any run_job(next) woken by the signal observes
     NULL.

  3. timedout_job() and the IRQ handler can also overlap if the hardware
     completes the timed-out job near the timeout boundary, since
     drm_sched_stop()'s cancel_work_sync() only synchronizes with the
     scheduler's workqueue. The IRQ handler saves in_flight_job into a
     local with READ_ONCE() before dereferencing ->done_fence, and
     run_job()/timedout_job() publish the field with WRITE_ONCE(). This
     prevents the compiler from reloading the pointer, and keeps the IRQ
     thread operating on the same job for the duration of the handler even
     if timedout_job() concurrently clears the field.

Drop the mutex along with its initialization.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---

Hi,

I noticed this pattern while reviewing "[PATCH v2] accel: ethosu: Add
performance counter support" and I had the impression this could be a
nice code simplification. However, I don't have the hardware to test it,
so this was only "compile-tested".

Best regards,
- Maíra

 drivers/accel/ethosu/ethosu_device.h |  2 --
 drivers/accel/ethosu/ethosu_job.c    | 22 ++++++++--------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_device.h b/drivers/accel/ethosu/ethosu_device.h
index b189fa783d6a..c2c59681a019 100644
--- a/drivers/accel/ethosu/ethosu_device.h
+++ b/drivers/accel/ethosu/ethosu_device.h
@@ -173,8 +173,6 @@ struct ethosu_device {
 	struct drm_ethosu_npu_info npu_info;
 
 	struct ethosu_job *in_flight_job;
-	/* For in_flight_job and ethosu_job_hw_submit() */
-	struct mutex job_lock;
 
 	/* For dma_fence */
 	spinlock_t fence_lock;
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 418463c03bfb..5a9bd017f3bc 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -194,10 +194,8 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 		       dev->fence_context, ++dev->emit_seqno);
 	dma_fence_get(fence);
 
-	scoped_guard(mutex, &dev->job_lock) {
-		dev->in_flight_job = job;
-		ethosu_job_hw_submit(dev, job);
-	}
+	WRITE_ONCE(dev->in_flight_job, job);
+	ethosu_job_hw_submit(dev, job);
 
 	return fence;
 }
@@ -205,6 +203,7 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
 static void ethosu_job_handle_irq(struct ethosu_device *dev)
 {
 	u32 status = readl_relaxed(dev->regs + NPU_REG_STATUS);
+	struct ethosu_job *job;
 
 	if (status & (STATUS_BUS_STATUS | STATUS_CMD_PARSE_ERR)) {
 		dev_err(dev->base.dev, "Error IRQ - %x\n", status);
@@ -212,11 +211,10 @@ static void ethosu_job_handle_irq(struct ethosu_device *dev)
 		return;
 	}
 
-	scoped_guard(mutex, &dev->job_lock) {
-		if (dev->in_flight_job) {
-			dma_fence_signal(dev->in_flight_job->done_fence);
-			dev->in_flight_job = NULL;
-		}
+	job = READ_ONCE(dev->in_flight_job);
+	if (job) {
+		WRITE_ONCE(dev->in_flight_job, NULL);
+		dma_fence_signal(job->done_fence);
 	}
 }
 
@@ -272,8 +270,7 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 
 	drm_sched_stop(&dev->sched, bad);
 
-	scoped_guard(mutex, &dev->job_lock)
-		dev->in_flight_job = NULL;
+	WRITE_ONCE(dev->in_flight_job, NULL);
 
 	/* Proceed with reset now. */
 	pm_runtime_force_suspend(dev->base.dev);
@@ -304,9 +301,6 @@ int ethosu_job_init(struct ethosu_device *edev)
 	int ret;
 
 	spin_lock_init(&edev->fence_lock);
-	ret = devm_mutex_init(dev, &edev->job_lock);
-	if (ret)
-		return ret;
 	ret = devm_mutex_init(dev, &edev->sched_lock);
 	if (ret)
 		return ret;
-- 
2.54.0

