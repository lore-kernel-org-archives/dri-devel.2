Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAFC606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQKqqlB5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869001122F2;
	Fri, 13 Nov 2026 09:03:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A921122D9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:03:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B71D44662A;
 Fri, 13 Nov 2026 09:02:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794560578;
 b=A/rwHlDfI/4g3QTBxnOV23zNAAixwAx2ZV1AELeFIk1Vt+mZD4An0p1YW5hn0k7hH1+e
 pWIzkMrwes9XsR5CNpmMm0mS/aK93q+UemoJyox8Q/va+V05zQLWEjxv3lzepuoxipA2V
 mOqU/ZGrHSeFSdPETs7429IMQ8Y8PCvTcerq6O1MHKlTMQy9pVjZl6FGDnC8mFI5hSrqW
 /Sf72BBJWB/2DQDYSGmpQeGRXgePEr9599rqj+1v8lUC1kxdfXWzZ87Ht66y31gBCgUu6
 8nPk0RSrM6g13orr7CEU2uIgnsuY4xpfE/Oqi4CSIkeUXtqBnV+Zb9gssJAM8zZsK6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794560578;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=HXsuLwCyBGtPcEVj9WiiSPRqZFV5wAzakXEPHNQ3hmI=;
 b=vuaR2YJF4Bs/gt5HAMSlO869HEGqbi/TPqsyyz8CcONOcYtNFsk2CTGKDx3jqBltygk1
 JhDj+P+pmrZAGN5ZPZ+1uH8eul1vkyM0/QTZbJ9/lGqzi193+9DUuWxBgG8/WOHozgiDL
 NSUcheUK7ODyfQlMFwSjVIhytdzt4hd8tsqo/P/h/6XL+Yix0ja+2qctLOyDXlVgLWNsc
 xSK3xtgRyIx7Etw2CNGPYT7VVzsV0DkAN3hf/B/KwNdypZThFzbJCfs2JirM3sK4Z9To6
 45XOqWSHHpc2riQSEMYAt1sLmJAO2WpG54dFNodsTCMcEiZCv9S9IRE+FJB5mszcDyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F118E1F000D3;
 Fri, 13 Nov 2026 09:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794560578;
 bh=HXsuLwCyBGtPcEVj9WiiSPRqZFV5wAzakXEPHNQ3hmI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XQKqqlB59UgMRSXuXasDs89ok2vxUdkDRwTK3801PpbnNgqNzgdqBdNurblk+Ismd
 9KNryrxRkUgprGDq/ZIbcM+a0eer0jYGSC926YIa/jnZ8atOnKEnNlBCxUpQrcgT3r
 cEchFhMYJGe5vCmZeBHyYei/ruOaEQrWIgcxVL+WE2fTqPh0kBPWUUHZoDGS89OHZY
 s01Mh3aq0xTWmK7UfR6ZlsABvMPt16kmOw6BjsueSbcToHGs2MbQuRTRaykEzERbNb
 AJRiFT5tyWQkHcIedaVAE+Cjh+jv4d1FGTrx8DpH/osZFoTEncYN8TMHJSwIY4DR49
 YCSRwtlPvoGeA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C9EEC47706;
 Fri, 13 Nov 2026 09:02:54 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 09:03:05 +0000
Subject: [PATCH v3 13/14] drm/panfrost: Soft-stop and resume a job that
 outlives the timeout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-panfrost-long-jobs-v3-13-80ae78d38f6e@gmail.com>
References: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
In-Reply-To: <20261113-panfrost-long-jobs-v3-0-80ae78d38f6e@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794560572; l=13381;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=l+TiCSzhGF7BccUN/ZncEMKLVuubenaZDs4QLiWC3vw=;
 b=lr+vZizRnAFG1cGWLUwyc7BSLb6WcrUYX2ok1V9ZlivGXJijXNU3Ys/3GfQXCRwVkWnWN0PzJ
 G9jHEC21y+RAZexrPlaLxJnItbQI6viTr14YejUQv9MJDILjlXJA8rZ
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

When the 500 ms job timeout fires, panfrost resets the GPU and the job
is lost. But OpenCL kernels and heavy fragment jobs legitimately take
seconds on a small GPU. On a Mali-G31 (one shader core) this breaks,
among others:

- OpenCL CTS Integer Ops quick_long_math and quick_ulong_math (long16
  64-bit division, > 500 ms per kernel): each subtest logs

    panfrost 1800000.gpu: gpu sched timeout, js=1, config=0x7300, status=0x8, head=0xa0161c0, tail=0xa0161c0

  (status 0x8 = ACTIVE) and fails with the work-items after the reset
  never written; Thread Dimensions quick_2d/3d lose whole rows the same
  way.
- KHR-GLES31.core.blend_equation_advanced.test_coherency.mixedSequence:
  a 44-draw fragment job on a 1024x1024 target needs about 0.7 s, and
  the tiles not reached at 500 ms read back as 0,0,0,0.
- dEQP-VK.spirv_assembly.type.vec4.*_frag cases (a loop over the whole
  dataset in every fragment): "Incomplete job or timeout".

The Arm driver soft-stops a job after its time slice and resumes it
later, hard-stops it when it has not stopped after 5 s
(DEFAULT_JS_HARD_STOP_TICKS_SS = 50 ticks of 100 ms), and resets the GPU
when the hard stop has not taken effect 0.5 s later
(DEFAULT_JS_RESET_TICKS_SS = 55). Do the same from the timeout handler:

- A slot whose job is still ACTIVE at the timeout is soft-stopped and
  its job resumed from JS_TAIL, without a GPU reset or karma. A
  soft-stop takes effect at a task boundary only, so such a slot gets
  JOB_SOFT_STOP_TIMEOUT_MS (5 s) to go idle; idle or faulted slots keep
  the 10 ms.
- A slot still active after that is hard-stopped, which ends its job
  with TERMINATED (-ECANCELED). That job is hung, so it gets karma and a
  devcoredump, as before. The stopped jobs on the other slots are
  resumed; nothing is reset.
- The GPU is reset when the hard stop has not taken effect after
  JOB_HARD_STOP_TIMEOUT_MS (0.5 s). The job that did not stop is failed
  with -ECANCELED rather than restarted, as it would only time out
  again. Jobs that only had the 10 ms of a reset for another reason are
  restarted, as before.
- The timeout marks reset.pending with PANFROST_RESET_STOP_ONLY. A reset
  requested while the slots are being stopped (a job fault that needs
  one, the MMU) overrides it, and the GPU is then reset.
- A job that completes between the timeout handler's fence check and its
  JS_STATUS read has its DONE interrupt pending or being handled: the
  timeout is spurious.
- Without a reset, the address space references of the jobs cancelled
  from _NEXT are released (panfrost_mmu_reset() drops them otherwise),
  and a runtime PM reference is held across the stop and the
  resubmission, so that autosuspend cannot power the GPU off in between.

The timeout of a job that is merely long is a dev_dbg(); the other paths
report as before, with the status of every slot.

With this, on the Mali-G31 the Integer Ops, Thread Dimensions and
mixedSequence cases pass, and the two vec4 i8/u64 bit_field_insert
count64 fragment cases, which need several seconds to reach a task
boundary, pass in 4-6 s.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 182 +++++++++++++++++++++++++++-----
 1 file changed, 157 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 8235d182d..6757d0fbf 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -27,6 +27,19 @@
 #define MAX_JM_CTX_PER_FILE 64
 #define JOB_TIMEOUT_MS 500
 
+/* Time a soft-stopped job gets to reach a task boundary before it is
+ * hard-stopped, and time the hard stop gets before the GPU is reset: the Arm
+ * driver's DEFAULT_JS_HARD_STOP_TICKS_SS (5 s) and DEFAULT_JS_RESET_TICKS_SS
+ * (5.5 s).
+ */
+#define JOB_SOFT_STOP_TIMEOUT_MS 5000
+#define JOB_HARD_STOP_TIMEOUT_MS 500
+
+/* reset.pending value for a stop of the slots without a GPU reset. A request
+ * for a reset (1) overrides it.
+ */
+#define PANFROST_RESET_STOP_ONLY 2
+
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
@@ -664,18 +677,35 @@ static bool panfrost_slots_idle(struct panfrost_device *pfdev)
 	return true;
 }
 
+/* The running job: the second one if the first's DONE is still pending. */
+static struct panfrost_job *
+panfrost_running_job(struct panfrost_device *pfdev, unsigned int slot)
+{
+	if (pfdev->jobs[slot][1] &&
+	    (job_read(pfdev, JOB_INT_RAWSTAT) & JOB_INT_MASK_DONE(slot)))
+		return pfdev->jobs[slot][1];
+
+	return pfdev->jobs[slot][0];
+}
+
 static void
 panfrost_reset(struct panfrost_device *pfdev,
-	       struct drm_sched_job *bad)
+	       struct drm_sched_job *bad, bool job_active)
 {
 	struct panfrost_job *evicted[NUM_JOB_SLOTS] = {};
+	struct panfrost_job *hung[NUM_JOB_SLOTS] = {};
+	bool cookie, idle, stop_failed = false, reset_gpu;
 	unsigned int i, j;
-	bool cookie, idle;
 	int ret;
 
 	if (!atomic_read(&pfdev->reset.pending))
 		return;
 
+	/* The stopped jobs drop their runtime PM references before they are
+	 * resubmitted: keep the GPU powered in between.
+	 */
+	pm_runtime_get_noresume(pfdev->base.dev);
+
 	/* Stop the schedulers.
 	 *
 	 * FIXME: We temporarily get out of the dma_fence_signalling section
@@ -694,7 +724,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 
 	cookie = dma_fence_begin_signalling();
 
-	if (bad)
+	/* A job that is merely long is not guilty of anything. */
+	if (bad && !job_active)
 		drm_sched_increase_karma(bad);
 
 	/* Mask job interrupts and synchronize to make sure we won't be
@@ -723,23 +754,73 @@ panfrost_reset(struct panfrost_device *pfdev,
 	}
 	spin_unlock(&pfdev->js->job_lock);
 
-	/* Wait at most 10ms for soft-stops to complete. No slot may be active
-	 * when we touch the queues: a late interrupt would find the wrong job,
-	 * or none, in pfdev->jobs[].
+	/* No slot may be active when we touch the queues: a late interrupt
+	 * would find the wrong job, or none, in pfdev->jobs[]. If the job that
+	 * timed out was active, wait JOB_SOFT_STOP_TIMEOUT_MS, then hard-stop;
+	 * otherwise wait 10 ms.
 	 */
-	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+	ret = read_poll_timeout(panfrost_slots_idle, idle, idle,
+				job_active ? 200 : 10,
+				job_active ? JOB_SOFT_STOP_TIMEOUT_MS * 1000 : 10000,
 				false, pfdev);
 
+	if (ret && job_active) {
+		dev_err(pfdev->base.dev,
+			"Soft-stop failed after %u ms (js status 0x%x 0x%x 0x%x), hard-stopping the active slots\n",
+			JOB_SOFT_STOP_TIMEOUT_MS,
+			job_read(pfdev, JS_STATUS(0)), job_read(pfdev, JS_STATUS(1)),
+			job_read(pfdev, JS_STATUS(2)));
+
+		/* No task boundary in all that time: the job is hung. */
+		for (i = 0; i < NUM_JOB_SLOTS; i++) {
+			if (job_read(pfdev, JS_STATUS(i)) ==
+			    DRM_PANFROST_EXCEPTION_ACTIVE)
+				hung[i] = panfrost_running_job(pfdev, i);
+			if (hung[i])
+				drm_sched_increase_karma(&hung[i]->base);
+		}
+
+		/* The dump allocates memory: leave the signalling section. */
+		dma_fence_end_signalling(cookie);
+		for (i = 0; i < NUM_JOB_SLOTS; i++) {
+			if (hung[i])
+				panfrost_core_dump(hung[i]);
+		}
+		cookie = dma_fence_begin_signalling();
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
+		stop_failed = ret;
+	}
+
 	if (ret)
-		dev_err(pfdev->base.dev, "Soft-stop failed\n");
+		dev_err(pfdev->base.dev,
+			"%s failed (js status 0x%x 0x%x 0x%x), resetting the GPU\n",
+			job_active ? "Hard-stop" : "Soft-stop",
+			job_read(pfdev, JS_STATUS(0)), job_read(pfdev, JS_STATUS(1)),
+			job_read(pfdev, JS_STATUS(2)));
 
 	/* Handle the remaining interrupts before we reset. */
 	panfrost_jm_handle_irqs(pfdev);
 
+	/* No reset if the slots only had to stop, did, and nobody (a job
+	 * fault just handled, the MMU) asked for one meanwhile.
+	 */
+	reset_gpu = !job_active || stop_failed ||
+		    atomic_read(&pfdev->reset.pending) != PANFROST_RESET_STOP_ONLY;
+
 	/* Remaining interrupts have been handled, but we might still have
-	 * stuck jobs. Let's make sure the PM counters stay balanced by
+	 * stuck jobs, and jobs that were waiting in _NEXT when it was
+	 * cancelled. Let's make sure the PM counters stay balanced by
 	 * manually calling pm_runtime_put_noidle() and
-	 * panfrost_devfreq_record_idle() for each stuck job.
+	 * panfrost_devfreq_record_idle() for each of them.
 	 * Let's also make sure the cycle counting register's refcnt is
 	 * kept balanced to prevent it from running forever
 	 */
@@ -750,19 +831,38 @@ panfrost_reset(struct panfrost_device *pfdev,
 			pfdev->jobs[i][pfdev->jobs[i][0] ? 1 : 0] = evicted[i];
 
 		for (j = 0; j < ARRAY_SIZE(pfdev->jobs[0]) && pfdev->jobs[i][j]; j++) {
-			panfrost_job_put_cycle_counter(pfdev->jobs[i][j]);
+			struct panfrost_job *job = pfdev->jobs[i][j];
+
+			panfrost_job_put_cycle_counter(job);
 			pm_runtime_put_noidle(pfdev->base.dev);
 			panfrost_devfreq_record_idle(&pfdev->pfdevfreq);
+
+			/* A GPU reset drops the AS references itself. */
+			if (!reset_gpu)
+				panfrost_mmu_as_put(pfdev, job->mmu);
+
+			/* Restarted, the job that forced the reset would only
+			 * time out again: fail it.
+			 */
+			if (stop_failed && job == hung[i])
+				dma_fence_set_error(&job->base.s_fence->finished,
+						    -ECANCELED);
 		}
 	}
 	memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
 	spin_unlock(&pfdev->js->job_lock);
 
 	/* Proceed with reset now. */
-	panfrost_device_reset(pfdev, false);
+	if (reset_gpu) {
+		panfrost_device_reset(pfdev, false);
 
-	/* GPU has been reset, we can clear the reset pending bit. */
-	atomic_set(&pfdev->reset.pending, 0);
+		/* GPU has been reset, we can clear the reset pending bit. */
+		atomic_set(&pfdev->reset.pending, 0);
+	} else {
+		/* A reset requested since stays pending for its requester. */
+		atomic_cmpxchg(&pfdev->reset.pending,
+			       PANFROST_RESET_STOP_ONLY, 0);
+	}
 
 	/* Now resubmit jobs that were previously queued but didn't have a
 	 * chance to finish.
@@ -784,6 +884,8 @@ panfrost_reset(struct panfrost_device *pfdev,
 	panfrost_jm_enable_interrupts(pfdev);
 
 	dma_fence_end_signalling(cookie);
+
+	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 
 static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
@@ -792,6 +894,8 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
 	struct panfrost_job *job = to_panfrost_job(sched_job);
 	struct panfrost_device *pfdev = job->pfdev;
 	int js = panfrost_job_get_slot(job);
+	bool job_active;
+	u32 js_status;
 
 	/*
 	 * If the GPU managed to complete this jobs fence, the timeout has
@@ -816,18 +920,46 @@ static enum drm_gpu_sched_stat panfrost_job_timedout(struct drm_sched_job
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
+	 * A slot that is still ACTIVE runs a long job, not a hung one:
+	 * soft-stop and resume it instead of resetting the GPU.
+	 */
+	js_status = job_read(pfdev, JS_STATUS(js));
+	job_active = js_status == DRM_PANFROST_EXCEPTION_ACTIVE;
+
+	/* The job may have completed since the fence check above. */
+	if (!job_active) {
+		if (job_read(pfdev, JOB_INT_RAWSTAT) & JOB_INT_MASK_DONE(js))
+			return DRM_GPU_SCHED_STAT_NO_HANG;
+
+		synchronize_irq(pfdev->js->irq);
+		if (dma_fence_is_signaled(job->done_fence))
+			return DRM_GPU_SCHED_STAT_NO_HANG;
+	}
 
-	panfrost_core_dump(job);
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
 
-	atomic_set(&pfdev->reset.pending, 1);
-	panfrost_reset(pfdev, sched_job);
+		panfrost_core_dump(job);
+	}
+
+	/* Ask for a reset, or only for the stop if no reset is pending. */
+	if (job_active)
+		atomic_cmpxchg(&pfdev->reset.pending, 0,
+			       PANFROST_RESET_STOP_ONLY);
+	else
+		atomic_set(&pfdev->reset.pending, 1);
+	panfrost_reset(pfdev, sched_job, job_active);
 
 	return DRM_GPU_SCHED_STAT_RESET;
 }
@@ -847,7 +979,7 @@ static void panfrost_reset_work(struct work_struct *work)
 		return;
 	}
 
-	panfrost_reset(pfdev, NULL);
+	panfrost_reset(pfdev, NULL, false);
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 

-- 
2.55.0


