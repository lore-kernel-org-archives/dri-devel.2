Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC5660A5BC6
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJl6FzgC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC81710EE79;
	Tue, 10 Nov 2026 07:45:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A586410EE71
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:45:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8602543526;
 Tue, 10 Nov 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794296700;
 b=SazusWqgsWje2Q4Eip0D/bWVhvgNzFohESbMXKbcm/QtWtofBWMSu036nNee+yamtMzw
 OOWOD4iPjMU1AJamA+++sWnyLBCZpdIesmndgJjbgHX03cN8VLA6DeafobBuI6ZeVzsY7
 QPf/qeppThHOwQhI5cBPZML7O2cn5pTWF1f6Wt9WSWGkTHFdjhAuHqqCXzfms9uwsQuH3
 CwgozDn+KxmxcP+47gbuqnWkhGbzHyAHNohSNj4QU0WRAeT+oMfAtDJuRRkJr1ukgYQhF
 8Mapt3X+1B2e1rQlgEV6MEePrhTFfe3N+e4a1ub6HpzichQiZybtdXDt+WCXzMxoNzw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794296700;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=FpCwKFl4RCuFX+xuGc1hi5xyOpBOfF9Tg48KQjLQwsE=;
 b=eJ6EMmUp9W19/zTSD+OUEnhwlHDS85lCKZYoVo8ELh+2gJinPVWAc5o4xcT3HGQ/bj1i
 fyn1NjEA6P2QPBpzC2Vs7Mg/vWoyKhuj6V3j9GpITrb8RbYGs2fxILbOLY59BogfdrReM
 uf2gxoMwfGPoVpSMwpV4CeHI7s6vFpVkYALPNylpnGfLkIkkd7SYLBDqbn5lQknli7qjY
 lxSH+SKGvetauKx/LieT6iBjwcXiqDxrPt2tRorbTnggsesfjwLTjHPWOlIcaAr9gsIiH
 ySOvETBxZQuo8mCKzfcIlFIRFGdZTWt/PiAOQyQDbxPfuiUhisB13ZMQzHqLR2XjB4A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DDF711F008A2;
 Tue, 10 Nov 2026 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794296700;
 bh=FpCwKFl4RCuFX+xuGc1hi5xyOpBOfF9Tg48KQjLQwsE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dJl6FzgC9vUsXzsoj5NXmtJqX2CmjQMlSyJ9LpoJAP4fH6xHMooB0RpQ32GRsGFto
 N/f3/XukpcubeXWWJZIlohZHaoU2J9Pwn2bqvTv4TjfyBQBK5Y5sY5AU9BdMFiOd4a
 B/Lp+lYIUjAGOdlrHVQ29avSEKG4HRdsMlrIHqBGpsCXoO7ncsE1s7JRxlC0sMtr3y
 ibi20fTh1P5cfJGLd7yzgzldddUhQMUnFOKzWyVWKwure0GMtT7N/PZ/EmkaWfY3nR
 U/SJTDs/C/75JNry4r7dIJsd764lex3K1bEGiWBS1/wY1LalK8cej60NjxXRC30tgj
 EFKno9hw1w7Rw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9140D48A22;
 Tue, 10 Nov 2026 07:44:56 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:45:01 +0000
Subject: [PATCH 6/7] drm/panfrost: Soft-stop and resume a job that outlives
 the timeout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-panfrost-long-jobs-v1-6-24508939ae8d@gmail.com>
References: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
In-Reply-To: <20261110-panfrost-long-jobs-v1-0-24508939ae8d@gmail.com>
To: David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794296695; l=14019;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=/xH948+6+1JFrlI3hRaTS/MLKFp0bIPTnomeWYPzid0=;
 b=G46A4qQ3ewMaQRsPHbUheI9OD8Us/Do/bFYhm3QSwCrHS5g6Png0EGvMD3FeoziJNB1/pu4zg
 hukp39hjbplChIFfoJZV0Gijemvx5VGBLtEEMhZxeZ4deQ3nq/TDxY2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

JOB_TIMEOUT_MS is 500 ms, and when it fires panfrost resets the GPU and
the job is lost. But a job that runs longer is not necessarily hung:
OpenCL kernels and heavy fragment jobs legitimately take seconds on a
small GPU. On a Mali-G31 (one shader core) that breaks, among others:

- OpenCL CTS Integer Ops quick_long_math and quick_ulong_math (long16
  64-bit division, > 500 ms per kernel): each subtest logs

    panfrost 1800000.gpu: gpu sched timeout, js=1, config=0x7300, status=0x8, head=0xa0161c0, tail=0xa0161c0

  (status 0x8 = ACTIVE) and fails with the work-items after the reset
  never written; Thread Dimensions quick_2d/3d lose whole rows the same
  way.
- KHR-GLES31.core.blend_equation_advanced.test_coherency.mixedSequence:
  a 44-draw fragment job on a 1024x1024 target needs about 0.7 s, and
  the tiles it had not reached at 500 ms read back as 0,0,0,0.
- dEQP-VK.spirv_assembly.type.vec4.*_frag cases (a loop over the whole
  dataset in every fragment): "Incomplete job or timeout".

The Arm driver time-slices instead: a job is soft-stopped after its
time slice and resumed later, it is hard-stopped only when it has not
stopped after 5 s (JS_HARD_STOP_TICKS_SS = 50 ticks of 100 ms), and the
GPU is reset only when the hard stop has not taken effect 0.5 s after
that (JS_RESET_TICKS_SS = 55). Do the same from the timeout handler:

- a slot whose job is still ACTIVE when the timeout fires is
  soft-stopped and its job resumed from JS_TAIL, without a GPU reset and
  without raising its karma; a soft-stop takes effect at a task boundary
  only, after the tasks already issued have completed, so such a slot
  gets JOB_SOFT_STOP_TIMEOUT_MS (5 s) to go idle, idle or faulted slots
  keep the 10 ms;
- a slot still active after that is hard-stopped, which ends its job at
  once with TERMINATED (-ECANCELED); the stopped jobs on the other slots
  are resumed, nothing is reset;
- the GPU is reset when the hard stop has not taken effect after
  JOB_HARD_STOP_TIMEOUT_MS (0.5 s); the job still running is then failed
  with -ECANCELED instead of being restarted from scratch, where it would
  only time out again;
- without a reset, the address space references of the jobs cancelled
  from _NEXT are released (a reset has panfrost_mmu_reset() drop them),
  and a runtime PM reference is held across the stop and the
  resubmission, so that an autosuspend cannot power the L2 off under a
  soft-stopped job.

The timeout of a job that is merely long is now a dev_dbg(); faults,
jobs that do not stop and the other reset paths are reported as before,
with the status of every slot.

With this, on the Mali-G31 the Integer Ops, Thread Dimensions and
mixedSequence cases pass, and the two vec4 i8/u64 bit_field_insert
count64 fragment cases, which need several seconds to reach a task
boundary, pass in 4-6 s.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 168 ++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 81efa8a86..e37dd9265 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -27,6 +27,19 @@
 #define MAX_JM_CTX_PER_FILE 64
 #define JOB_TIMEOUT_MS 500
 
+/* How long a soft-stopped slot gets to reach a task boundary before its job is
+ * hard-stopped, and how long the hard stop gets before the GPU is reset. These
+ * follow the Arm driver's job slot policy (mali_kbase_config_defaults.h): a job
+ * is soft-stopped after its 100 ms time slice (JS_SOFT_STOP_TICKS = 1 tick),
+ * hard-stopped when it has not stopped by tick 50 (JS_HARD_STOP_TICKS_SS, 5 s)
+ * and the GPU is reset at tick 55 (JS_RESET_TICKS_SS, 5.5 s). A soft-stop
+ * takes effect at a task boundary only, after the tasks already issued (a
+ * compute job's work-groups, a fragment job's tiles) have run to completion,
+ * and a heavy shader needs seconds for that.
+ */
+#define JOB_SOFT_STOP_TIMEOUT_MS 5000
+#define JOB_HARD_STOP_TIMEOUT_MS 500
+
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
@@ -165,8 +178,9 @@ panfrost_dequeue_job(struct panfrost_device *pfdev, int slot)
 {
 	struct panfrost_job *job = pfdev->jobs[slot][0];
 
-	/* An event for a slot we have no job on. Not fatal, as every caller
-	 * copes with a NULL job; a WARN, not an Oops.
+	/* An event for a slot we have no job on: a resubmission raced with
+	 * the first run of the job (see panfrost_reset()). Not fatal, as
+	 * every caller copes with a NULL job; a WARN, not an Oops.
 	 */
 	if (WARN_ON(!job))
 		return NULL;
@@ -672,7 +686,7 @@ static bool panfrost_slots_idle(struct panfrost_device *pfdev)
 
 static void
 panfrost_reset(struct panfrost_device *pfdev,
-	       struct drm_sched_job *bad)
+	       struct drm_sched_job *bad, bool job_active)
 {
 	unsigned int i, j;
 	bool cookie, idle;
@@ -681,6 +695,12 @@ panfrost_reset(struct panfrost_device *pfdev,
 	if (!atomic_read(&pfdev->reset.pending))
 		return;
 
+	/* The jobs we stop drop their runtime PM references before we submit
+	 * them again. Keep the GPU powered in between: a suspend would power
+	 * the L2 off and lose the dirty lines of a soft-stopped job.
+	 */
+	pm_runtime_get_noresume(pfdev->base.dev);
+
 	/* Stop the schedulers.
 	 *
 	 * FIXME: We temporarily get out of the dma_fence_signalling section
@@ -699,7 +719,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 
 	cookie = dma_fence_begin_signalling();
 
-	if (bad)
+	/* A job that is merely long is not guilty of anything. */
+	if (bad && !job_active)
 		drm_sched_increase_karma(bad);
 
 	/* Mask job interrupts and synchronize to make sure we won't be
@@ -714,43 +735,110 @@ panfrost_reset(struct panfrost_device *pfdev,
 		job_write(pfdev, JS_COMMAND(i), JS_COMMAND_SOFT_STOP);
 	}
 
-	/* Wait at most 10ms for soft-stops to complete. Every slot must have
-	 * gone idle before we touch the queues: a job that is still stopping
-	 * (or finishing) raises its interrupt later, when its entry in
-	 * pfdev->jobs[] is gone or belongs to its own resubmission.
+	/* Every slot must have gone idle before we touch the queues: a job
+	 * that is still stopping (or finishing) raises its interrupt later,
+	 * when its entry in pfdev->jobs[] is gone or belongs to its own
+	 * resubmission, and the second start of that job then runs on a slot
+	 * we have no job for.
+	 *
+	 * A slot that was idle or faulted gets 10 ms. A job that was still
+	 * active gets the time the Arm driver gives it to reach a task
+	 * boundary (JOB_SOFT_STOP_TIMEOUT_MS). If it has not stopped by then
+	 * it is hard-stopped, which terminates it at once and fails it
+	 * (TERMINATED, see panfrost_job_handle_err()), instead of resetting
+	 * the GPU under every job on it; the GPU is reset only when the hard
+	 * stop does not take effect either.
 	 */
-	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+	ret = read_poll_timeout(panfrost_slots_idle, idle, idle,
+				job_active ? 200 : 10,
+				job_active ? JOB_SOFT_STOP_TIMEOUT_MS * 1000 : 10000,
 				false, pfdev);
 
-	if (ret)
-		dev_err(pfdev->base.dev, "Soft-stop failed\n");
+	if (ret && job_active) {
+		dev_err(pfdev->base.dev,
+			"Soft-stop failed after %u ms (js status 0x%x 0x%x 0x%x), hard-stopping the active slots\n",
+			JOB_SOFT_STOP_TIMEOUT_MS,
+			job_read(pfdev, JS_STATUS(0)), job_read(pfdev, JS_STATUS(1)),
+			job_read(pfdev, JS_STATUS(2)));
+
+		for (i = 0; i < NUM_JOB_SLOTS; i++) {
+			if (job_read(pfdev, JS_STATUS(i)) ==
+			    DRM_PANFROST_EXCEPTION_ACTIVE)
+				job_write(pfdev, JS_COMMAND(i), JS_COMMAND_HARD_STOP);
+		}
+
+		ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 200,
+					JOB_HARD_STOP_TIMEOUT_MS * 1000, false,
+					pfdev);
+	}
+
+	if (ret) {
+		dev_err(pfdev->base.dev,
+			"%s failed (js status 0x%x 0x%x 0x%x), resetting the GPU\n",
+			job_active ? "Hard-stop" : "Soft-stop",
+			job_read(pfdev, JS_STATUS(0)), job_read(pfdev, JS_STATUS(1)),
+			job_read(pfdev, JS_STATUS(2)));
+		job_active = false;
+	}
 
 	/* Handle the remaining interrupts before we reset. */
 	panfrost_jm_handle_irqs(pfdev);
 
 	/* Remaining interrupts have been handled, but we might still have
-	 * stuck jobs. Let's make sure the PM counters stay balanced by
+	 * stuck jobs, and jobs that were waiting in _NEXT when it was
+	 * cancelled. Let's make sure the PM counters stay balanced by
 	 * manually calling pm_runtime_put_noidle() and
-	 * panfrost_devfreq_record_idle() for each stuck job.
+	 * panfrost_devfreq_record_idle() for each of them.
 	 * Let's also make sure the cycle counting register's refcnt is
-	 * kept balanced to prevent it from running forever
+	 * kept balanced to prevent it from running forever.
 	 */
 	spin_lock(&pfdev->js->job_lock);
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
-			if (pfdev->jobs[i][j]->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
-			    pfdev->jobs[i][j]->is_profiled)
-				panfrost_cycle_counter_put(pfdev->jobs[i][j]->pfdev);
+			struct panfrost_job *job = pfdev->jobs[i][j];
+
+			if (job->requirements & PANFROST_JD_REQ_CYCLE_COUNT ||
+			    job->is_profiled)
+				panfrost_cycle_counter_put(job->pfdev);
 			pm_runtime_put_noidle(pfdev->base.dev);
 			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
+
+			/* The GPU reset wipes the address space assignments;
+			 * without one, release the reference the submission
+			 * took, or the address space can never be reassigned.
+			 */
+			if (job_active)
+				panfrost_mmu_as_put(pfdev, job->mmu);
+
+			/* The job still running on a slot that neither stop
+			 * took effect on is what forces the reset. Fail it,
+			 * as the Arm driver fails every atom on the hardware
+			 * at a reset: restarted from scratch it would hit the
+			 * timeout and the reset again.
+			 */
+			if (!job_active && j == 0 &&
+			    job_read(pfdev, JS_STATUS(i)) ==
+			    DRM_PANFROST_EXCEPTION_ACTIVE)
+				dma_fence_set_error(&job->base.s_fence->finished,
+						    -ECANCELED);
 		}
 	}
-	pfdev->reset.count++;
+	if (!job_active)
+		pfdev->reset.count++;
 	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
 	spin_unlock(&pfdev->js->job_lock);
 
-	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev, false);
+	/* Proceed with reset now, unless the slots were simply busy with long
+	 * jobs that stopped at a task boundary (or a hard stop ended the one
+	 * that did not). The stopped jobs will be resumed from JS_TAIL (see
+	 * panfrost_job_handle_err()). The hardware keeps their resume state in
+	 * the job header and the results of the tasks that already finished
+	 * in the L2: a soft reset throws both away, and a job resumed after it
+	 * completes with stale data in the buffers it had still to write and
+	 * no error reported (panfrost_job_run() fails such a job instead).
+	 */
+	if (!job_active)
+		panfrost_device_reset(pfdev, false);
 
 	/* GPU has been reset, we can clear the reset pending bit. */
 	atomic_set(&pfdev->reset.pending, 0);
@@ -775,6 +863,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	panfrost_jm_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
+
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
 static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
@@ -783,6 +873,8 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	struct panfrost_job *job = to_panfrost_job(sched_job);
 	struct panfrost_device *pfdev = job->pfdev;
 	int js = panfrost_job_get_slot(job);
+	bool job_active;
+	u32 js_status;
 
 	/*
 	 * If the GPU managed to complete this jobs fence, the timeout has
@@ -807,18 +899,34 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 		return DRM_GPU_SCHED_STAT_NO_HANG;
 	}
 
-	dev_err(pfdev->base.dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
-		js,
-		job_read(pfdev, JS_CONFIG(js)),
-		job_read(pfdev, JS_STATUS(js)),
-		job_read(pfdev, JS_HEAD_LO(js)),
-		job_read(pfdev, JS_TAIL_LO(js)),
-		sched_job);
+	/*
+	 * A slot that is still ACTIVE is not hung, it is running a job that
+	 * takes longer than JOB_TIMEOUT_MS. Compute kernels legitimately do.
+	 * Soft-stop such a job and resume it, the way the Arm driver
+	 * time-slices jobs, instead of resetting the GPU under it; the reset
+	 * stays for faults and for jobs that do not stop.
+	 */
+	js_status = job_read(pfdev, JS_STATUS(js));
+	job_active = js_status == DRM_PANFROST_EXCEPTION_ACTIVE;
+
+	if (job_active) {
+		dev_dbg(pfdev->base.dev, "job still active after %u ms, js=%d, head=0x%x, sched_job=%p: soft-stopping it to resume",
+			JOB_TIMEOUT_MS, js, job_read(pfdev, JS_HEAD_LO(js)),
+			sched_job);
+	} else {
+		dev_err(pfdev->base.dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
+			js,
+			job_read(pfdev, JS_CONFIG(js)),
+			js_status,
+			job_read(pfdev, JS_HEAD_LO(js)),
+			job_read(pfdev, JS_TAIL_LO(js)),
+			sched_job);
 
-	panfrost_core_dump(job);
+		panfrost_core_dump(job);
+	}
 
 	atomic_set(&pfdev->reset.pending, 1);
-	panfrost_reset(pfdev, sched_job);
+	panfrost_reset(pfdev, sched_job, job_active);
 
 	return DRM_GPU_SCHED_STAT_RESET;
 }
@@ -828,7 +936,7 @@ static void panfrost_reset_work(struct work_struct *work)
 	struct panfrost_device *pfdev;
 
 	pfdev = container_of(work, struct panfrost_device, reset.work);
-	panfrost_reset(pfdev, NULL);
+	panfrost_reset(pfdev, NULL, false);
 }
 
 static const struct drm_sched_backend_ops panfrost_sched_ops = {

-- 
2.55.0


