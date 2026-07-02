Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C32C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4B410E4F0;
	Thu,  2 Jul 2026 14:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PYCc+wfZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B465E10F382
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=by9Ur2OtDyzF/Otnf2111xHF7jDS3heiGQw0DlEg0dQ=; b=PYCc+wfZAw886yD8YaaJ9M6XrO
 EQBV0VyoWr0tYwxz/kQhsh2dziVqz3btZGueTla7l9FPmpo/H/XYL/3n4w/SSnSrV4WrvDF8zSpl5
 hl38vDRobEKty84FNsrtv0f/rV7H7mgjpw8kVXenkjCbJqtNUcJZ3af0v0tQ83ifodPfsrd4a3m2k
 oYReyBF4CJ2be+tjSunLTIHivMlbmptds6b9vnGFLergBomNhDmaYlRU6uSQ1As/ImHaZRmzK15Dp
 Jhj+SPwyJsgz4Z1hyLwqfdau/tGgCemwvUHVv/5QJGTql7r+yHIw11sE3kotLdp19kR2xvJgiAUtV
 iMQS2ijQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYB-0084XZ-PQ; Thu, 02 Jul 2026 16:37:59 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 3/8] drm/sched: Use generic naming for workqueue helpers
Date: Thu,  2 Jul 2026 15:37:40 +0100
Message-ID: <20260702143745.79293-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

A little bit of decoupling the internal scheduler implementation details
from the public API - replace the name 'wq' in submission start/stop/ready
helpers with generic 'submission'. Decoupling is however not complete
since users which pass in their own workqueue still know that is what the
scheduler uses. Still, this is a step in the right direction.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_device.c  |  4 ++--
 drivers/gpu/drm/scheduler/sched_main.c      | 26 ++++++++++-----------
 drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  4 ++--
 include/drm/gpu_scheduler.h                 |  6 ++---
 13 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 389bad724273..b8d4cda0fc1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1773,7 +1773,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
-		drm_sched_wqueue_stop(&ring->sched);
+		drm_sched_submission_stop(&ring->sched);
 	}
 
 	seq_puts(m, "run ib test:\n");
@@ -1789,7 +1789,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 
 		if (!amdgpu_ring_sched_ready(ring))
 			continue;
-		drm_sched_wqueue_start(&ring->sched);
+		drm_sched_submission_start(&ring->sched);
 	}
 
 	up_write(&adev->reset_domain->sem);
@@ -2029,7 +2029,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 		goto pro_end;
 
 	/* stop the scheduler */
-	drm_sched_wqueue_stop(&ring->sched);
+	drm_sched_submission_stop(&ring->sched);
 
 	/* preempt the IB */
 	r = amdgpu_ring_preempt_ib(ring);
@@ -2063,7 +2063,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 failure:
 	/* restart the scheduler */
-	drm_sched_wqueue_start(&ring->sched);
+	drm_sched_submission_start(&ring->sched);
 
 	up_read(&adev->reset_domain->sem);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 211d30f03d25..1e6b75ecafe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5632,7 +5632,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_wqueue_stop(&ring->sched);
+			drm_sched_submission_stop(&ring->sched);
 
 			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
@@ -5716,7 +5716,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			if (!amdgpu_ring_sched_ready(ring))
 				continue;
 
-			drm_sched_wqueue_start(&ring->sched);
+			drm_sched_submission_start(&ring->sched);
 		}
 
 		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9ecc6387c1eb..57ebae8bdc78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -136,11 +136,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-		drm_sched_wqueue_stop(&ring->sched);
+		drm_sched_submission_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* Start the scheduler again */
-			drm_sched_wqueue_start(&ring->sched);
+			drm_sched_submission_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b97fa35bac23..09593fcdb2f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -906,7 +906,7 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 	if (!ring)
 		return false;
 
-	if (ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
+	if (ring->no_scheduler || !drm_sched_submission_ready(&ring->sched))
 		return false;
 
 	return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fcd81242059e..1ac0d28d8049 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -568,10 +568,10 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * This ensures that no new tasks are submitted to the queues while
 		 * the reset is in progress.
 		 */
-		drm_sched_wqueue_stop(&gfx_ring->sched);
+		drm_sched_submission_stop(&gfx_ring->sched);
 
 		if (adev->sdma.has_page_queue)
-			drm_sched_wqueue_stop(&page_ring->sched);
+			drm_sched_submission_stop(&page_ring->sched);
 	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
@@ -601,10 +601,10 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 */
 		if (!ret) {
 			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
-			drm_sched_wqueue_start(&gfx_ring->sched);
+			drm_sched_submission_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
 				amdgpu_fence_driver_force_completion(page_ring, NULL);
-				drm_sched_wqueue_start(&page_ring->sched);
+				drm_sched_submission_start(&page_ring->sched);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 616967519869..b261aa7c1ba8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1512,9 +1512,9 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 	 * This ensures that no new tasks are submitted to the queues while
 	 * the reset is in progress.
 	 */
-	drm_sched_wqueue_stop(&vinst->ring_dec.sched);
+	drm_sched_submission_stop(&vinst->ring_dec.sched);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_stop(&vinst->ring_enc[i].sched);
+		drm_sched_submission_stop(&vinst->ring_enc[i].sched);
 
 	/* Perform the VCN reset for the specified instance */
 	r = vinst->reset(vinst);
@@ -1540,9 +1540,9 @@ int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
 	 * if they were stopped by this function. This allows new tasks
 	 * to be submitted to the queues after the reset is complete.
 	 */
-	drm_sched_wqueue_start(&vinst->ring_dec.sched);
+	drm_sched_submission_start(&vinst->ring_dec.sched);
 	for (i = 0; i < vinst->num_enc_rings; i++)
-		drm_sched_wqueue_start(&vinst->ring_enc[i].sched);
+		drm_sched_submission_start(&vinst->ring_enc[i].sched);
 
 unlock:
 	mutex_unlock(&vinst->engine_reset_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 409e103ffe8c..fa478f9a3875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -472,7 +472,7 @@ void amdgpu_xcp_release_sched(struct amdgpu_device *adev,
 	if (!adev->xcp_mgr)
 		return;
 
-	if (drm_sched_wqueue_ready(sched)) {
+	if (drm_sched_submission_ready(sched)) {
 		struct amdgpu_ring *ring = to_amdgpu_ring(sched);
 
 		atomic_dec(&adev->xcp_mgr->xcp[ring->xcp_id].ref_cnt);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7f001c32e911..08e9abfb381c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1663,7 +1663,7 @@ static int vcn_v4_0_3_reset_jpeg_pre_helper(struct amdgpu_device *adev, int inst
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 
-		drm_sched_wqueue_stop(&ring->sched);
+		drm_sched_submission_stop(&ring->sched);
 		/* Get the last emitted fence sequence */
 		wait_seq = atomic_read(&ring->fence_drv.last_seq);
 		if (wait_seq)
@@ -1700,7 +1700,7 @@ static int vcn_v4_0_3_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 		if (r)
 			return r;
 
-		drm_sched_wqueue_start(&ring->sched);
+		drm_sched_submission_start(&ring->sched);
 
 		DRM_DEV_DEBUG(adev->dev, "JPEG ring %d (inst %d) restored and sched restarted\n",
 		      i, inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index d3db0494341e..2aae051b5f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -1310,7 +1310,7 @@ static int vcn_v5_0_1_reset_jpeg_pre_helper(struct amdgpu_device *adev, int inst
 	for (i = 0; i < adev->jpeg.num_jpeg_rings; ++i) {
 		ring = &adev->jpeg.inst[inst].ring_dec[i];
 
-		drm_sched_wqueue_stop(&ring->sched);
+		drm_sched_submission_stop(&ring->sched);
 		wait_seq = atomic_read(&ring->fence_drv.last_seq);
 		if (wait_seq)
 			continue;
@@ -1346,7 +1346,7 @@ static int vcn_v5_0_1_reset_jpeg_post_helper(struct amdgpu_device *adev, int ins
 		if (r)
 			return r;
 
-		drm_sched_wqueue_start(&ring->sched);
+		drm_sched_submission_start(&ring->sched);
 
 		DRM_DEV_DEBUG(adev->dev, "JPEG ring %d (inst %d) restored and sched restarted\n",
 		      i, inst);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f20320ef66a..34485257300e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -347,7 +347,7 @@ static void suspend_scheduler(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
 
-		drm_sched_wqueue_stop(sched);
+		drm_sched_submission_stop(sched);
 	}
 }
 
@@ -358,7 +358,7 @@ static void resume_scheduler(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++) {
 		struct drm_gpu_scheduler *sched = &gpu->rb[i]->sched;
 
-		drm_sched_wqueue_start(sched);
+		drm_sched_submission_start(sched);
 	}
 }
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..4e180f21b946 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -387,7 +387,7 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 {
 	struct drm_sched_job *s_job, *tmp;
 
-	drm_sched_wqueue_stop(sched);
+	drm_sched_submission_stop(sched);
 
 	/*
 	 * Reinsert back the bad job here - now it's safe as
@@ -497,7 +497,7 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
 	}
 
 	drm_sched_start_timeout_unlocked(sched);
-	drm_sched_wqueue_start(sched);
+	drm_sched_submission_start(sched);
 }
 EXPORT_SYMBOL(drm_sched_start);
 
@@ -1129,7 +1129,7 @@ static void drm_sched_cancel_remaining_jobs(struct drm_gpu_scheduler *sched)
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
-	drm_sched_wqueue_stop(sched);
+	drm_sched_submission_stop(sched);
 
 	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
 	wake_up_all(&sched->job_scheduled);
@@ -1187,49 +1187,49 @@ void drm_sched_increase_karma(struct drm_sched_job *bad)
 EXPORT_SYMBOL(drm_sched_increase_karma);
 
 /**
- * drm_sched_wqueue_ready - Is the scheduler ready for submission
+ * drm_sched_submission_ready - Is the scheduler ready for submission
  *
  * @sched: scheduler instance
  *
  * Returns true if submission is ready
  */
-bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched)
+bool drm_sched_submission_ready(struct drm_gpu_scheduler *sched)
 {
 	return sched->ready;
 }
-EXPORT_SYMBOL(drm_sched_wqueue_ready);
+EXPORT_SYMBOL(drm_sched_submission_ready);
 
 /**
- * drm_sched_wqueue_stop - stop scheduler submission
+ * drm_sched_submission_stop - stop scheduler submission
  * @sched: scheduler instance
  *
  * Stops the scheduler from pulling new jobs from entities. It also stops
  * freeing jobs automatically through drm_sched_backend_ops.free_job().
  */
-void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
+void drm_sched_submission_stop(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, true);
 	cancel_work_sync(&sched->work_run_job);
 	cancel_work_sync(&sched->work_free_job);
 }
-EXPORT_SYMBOL(drm_sched_wqueue_stop);
+EXPORT_SYMBOL(drm_sched_submission_stop);
 
 /**
- * drm_sched_wqueue_start - start scheduler submission
+ * drm_sched_submission_start - start scheduler submission
  * @sched: scheduler instance
  *
- * Restarts the scheduler after drm_sched_wqueue_stop() has stopped it.
+ * Restarts the scheduler after drm_sched_submission_stop() has stopped it.
  *
  * This function is not necessary for 'conventional' startup. The scheduler is
  * fully operational after drm_sched_init() succeeded.
  */
-void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
+void drm_sched_submission_start(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, false);
 	queue_work(sched->submit_wq, &sched->work_run_job);
 	queue_work(sched->submit_wq, &sched->work_free_job);
 }
-EXPORT_SYMBOL(drm_sched_wqueue_start);
+EXPORT_SYMBOL(drm_sched_submission_start);
 
 /**
  * drm_sched_is_stopped() - Checks whether drm_sched is stopped
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index 67d8ce368486..ed7f4f52b3c8 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -91,13 +91,13 @@ void xe_sched_fini(struct xe_gpu_scheduler *sched)
 
 void xe_sched_submission_start(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_wqueue_start(&sched->base);
+	drm_sched_submission_start(&sched->base);
 	queue_work(sched->base.submit_wq, &sched->work_process_msg);
 }
 
 void xe_sched_submission_stop(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_wqueue_stop(&sched->base);
+	drm_sched_submission_stop(&sched->base);
 	cancel_work_sync(&sched->work_process_msg);
 }
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index d61c19e78182..342e28611509 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -640,9 +640,9 @@ unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler *sched);
 void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
 			      unsigned long remaining);
 void drm_sched_tdr_queue_imm(struct drm_gpu_scheduler *sched);
-bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched);
-void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
-void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
+bool drm_sched_submission_ready(struct drm_gpu_scheduler *sched);
+void drm_sched_submission_stop(struct drm_gpu_scheduler *sched);
+void drm_sched_submission_start(struct drm_gpu_scheduler *sched);
 void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
 void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
 void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
-- 
2.54.0

