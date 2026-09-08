Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF039C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E7310EDB1;
	Tue,  8 Sep 2026 22:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KWy3ygku";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B8010EDA0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:04:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B09C44583;
 Tue,  8 Sep 2026 22:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010FB1F00A3E;
 Tue,  8 Sep 2026 22:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905098;
 bh=BSE/1dmV9/OlXUyEoOlbChcyMLLbhJNQh9ObguX2hFg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KWy3ygkuKMMALDFZMD3F1kdmflmOnlMZkqF/IBSZIQMF1+oaC/GUfh+Jo7p7dcTzu
 v+aWDpTRyITg/+mCn1Qk6V7VZ9aje1aihtcnMVPkFXK+xNa1urtmsC6tWIiJk7odao
 ZbwrRBl8e1YgX4kvGRdtXSACRbxMmSXW4n3sHFJTbz97KwJYLdKzRMsAuALQoRySf9
 8m3tSBvRBzDjBFf4lN2QVR0ToWw/KLLxnOwuHuMtc5cKUl+6PdbsfucM/L+l2rIlie
 +VYE2LRBtV6Fr2PKOyO3wMMuTIhm6AVE09GlryFkofLLBKwG6b6YIorSPN2Lw9Nsu8
 DD/rDt6AXM4Iw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:42 -0500
Subject: [PATCH v3 05/22] accel: ethosu: Quiesce jobs before scheduler teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-5-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

An NPU job can complete while driver removal tears down the scheduler. Its
IRQ handler could then access scheduler state after it has been
destroyed.

Stop scheduler submission and timeout work, reset the NPU, and
synchronize its IRQ before finalizing the scheduler. Add a cancel_job
callback so drm_sched_fini() signals queued jobs with -ECANCELED; their
runtime-PM references are then released during normal job cleanup.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v3:
 - Add dma_fence_was_initialized() check in job cancel (sashiko)
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_drv.c |  4 ++--
 drivers/accel/ethosu/ethosu_drv.h |  2 ++
 drivers/accel/ethosu/ethosu_job.c | 23 ++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index 9d063daa1aa7..06e432854ce7 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -216,7 +216,7 @@ static const struct drm_driver ethosu_drm_driver = {
 #define U85_MEM_ATTR0_CFG	0x00000000
 #define U85_MEM_ATTR2_CFG	0x000000b7
 
-static int ethosu_reset(struct ethosu_device *ethosudev)
+int ethosu_device_reset(struct ethosu_device *ethosudev)
 {
 	int ret;
 	u32 reg;
@@ -263,7 +263,7 @@ static int ethosu_device_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = ethosu_reset(ethosudev);
+	ret = ethosu_device_reset(ethosudev);
 	if (!ret)
 		return 0;
 
diff --git a/drivers/accel/ethosu/ethosu_drv.h b/drivers/accel/ethosu/ethosu_drv.h
index 2193bc51d425..f59c845c758b 100644
--- a/drivers/accel/ethosu/ethosu_drv.h
+++ b/drivers/accel/ethosu/ethosu_drv.h
@@ -11,6 +11,8 @@ struct ethosu_device;
 struct drm_device;
 struct drm_file;
 
+int ethosu_device_reset(struct ethosu_device *ethosudev);
+
 struct ethosu_file_priv {
 	struct ethosu_device *edev;
 	struct drm_sched_entity sched_entity;
diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index ec65305e0cd7..a1443cd0c5b0 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -189,6 +189,17 @@ static void ethosu_job_free(struct drm_sched_job *sched_job)
 	ethosu_job_put(job);
 }
 
+static void ethosu_job_cancel(struct drm_sched_job *sched_job)
+{
+	struct ethosu_job *job = to_ethosu_job(sched_job);
+
+	if (dma_fence_was_initialized(job->done_fence) &&
+	    !dma_fence_is_signaled(job->done_fence)) {
+		dma_fence_set_error(job->done_fence, -ECANCELED);
+		dma_fence_signal(job->done_fence);
+	}
+}
+
 static void
 ethosu_switch_perfmon(struct ethosu_device *ethosu, struct ethosu_job *job)
 {
@@ -315,7 +326,8 @@ static enum drm_gpu_sched_stat ethosu_job_timedout(struct drm_sched_job *bad)
 static const struct drm_sched_backend_ops ethosu_sched_ops = {
 	.run_job = ethosu_job_run,
 	.timedout_job = ethosu_job_timedout,
-	.free_job = ethosu_job_free
+	.free_job = ethosu_job_free,
+	.cancel_job = ethosu_job_cancel,
 };
 
 int ethosu_job_init(struct ethosu_device *edev)
@@ -363,6 +375,15 @@ int ethosu_job_init(struct ethosu_device *edev)
 
 void ethosu_job_fini(struct ethosu_device *dev)
 {
+	drm_sched_wqueue_stop(&dev->sched);
+	cancel_delayed_work_sync(&dev->sched.work_tdr);
+
+	if (READ_ONCE(dev->in_flight_job)) {
+		WRITE_ONCE(dev->in_flight_job, NULL);
+		ethosu_device_reset(dev);
+	}
+
+	synchronize_irq(dev->irq);
 	drm_sched_fini(&dev->sched);
 }
 

-- 
2.53.0

