Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D57606A333
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JjnkRsUU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C796511224D;
	Thu, 26 Nov 2026 09:37:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 985AF112249
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 09:37:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C705408F9;
 Thu, 26 Nov 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795685859;
 b=Vv/dizKXiDRXBaB7zVdjax6JHxtJYTI9wi783z4qrnJbuTsIjp66M9LJEzS6mhF6tLuk
 /GP/dpqoFfyhamEojY23K2hxSZH/d2YpGBUu2tpCiUnZ1Hr3jS2poXyBBJ52Iz3QK8hLX
 wXG4c5GYW4FwaxuWFgwQb4qBdiW/hCkRutCa3ZBeZ0++qNiMIaim5ilMGJIwBierMlUu5
 pjW+zJ67DRUwwJ1dRcQIk/dkIJUbCkultXGxTpMLZsAq4itqiqFTJECShNs/QXqxtK8BH
 jZnvXc5M76cTr+ayWpmAYqdMgPwPNomsVXGAP2kyHV98GMUxYruYnQqFNHOnwOwlKLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795685859;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=h3h9bw8Jpuvzx8sX4+SIGCLaJBn0e80ktvGPfxRpGtA=;
 b=tFCzivx3vmC1jm9g9CZxjthdsU9xcYUeXpFdgdzcCgjXjFSza+sGVcHkLuUlZ0hnDGGE
 BydVBi1kshipczFw/e0YBpZ103oYrJhJ1YGpVObzdfh4pm2kWdXHdbQHyYolQ6g7u+Ye6
 G9rqJV3YHdi2QFa8SA9nGpX4xRTcCC968dcgC7X2LkLJFlj1wjXuK5WeCahobeJ3nBpcD
 E70m8bWzQsb5JKJhFKxNfX+Emckpmsk3SdvxO3/OW0aVKayn9IEDzXRwDqHx8VCwrQPHb
 Ajd48Fe1HkAvl6m37UvShHLmkWeYwX6ebicjCh+ft+dgiYqh/Y51d3Fug1wdGZxczLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4C5871F00A3D;
 Thu, 26 Nov 2026 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795685859;
 bh=h3h9bw8Jpuvzx8sX4+SIGCLaJBn0e80ktvGPfxRpGtA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=JjnkRsUUksm6fFSDXHAFoNfIdM9AiQufKibQvN+Pz+jTINbEviIDtO5aUxse10n6L
 SN6c8+PbmEpGHeQrh8564rPKVCLSrrhS3qCGga0jFcj7U8AnMqvanuQLeFCRc1jne1
 gxm0YTygOR2f/xs9emeOkR8oXvK66p2ugwNGThKAu4o0qlULfqh239rzmBT0AgdqzF
 jDavTG9uta+pFUwqgsR1vTipoP6puxdF/oyyFpZAyRXuibCYIoueQLuFCaVhf9/Mrn
 kNUeqCzi44PtSp7gS6/7Q2l7AhdMeLciexFzzayJgvW3PdjzontmNfwT8SMNJ/XOMs
 J0Fl0cCmoCYMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4020A4D3AC;
 Thu, 26 Nov 2026 09:36:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:36:59 +0000
Subject: [PATCH v4 16/17] drm/panfrost: Soft-stop and resume a job that
 outlives the timeout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-panfrost-long-jobs-v4-16-23579629ceca@gmail.com>
References: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
In-Reply-To: <20261126-panfrost-long-jobs-v4-0-23579629ceca@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795685806; l=9818;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=DWD0EGqX3/qNIA/GhZU0LgsY/HqiZX8jfDhJshxzwZ4=;
 b=2qYK/dDKr6yfjzNR97kMdaUNUcd+3FnXVdVN65nOSAub7G4msHzW8W2OGDLxktTJI8swl5oDx
 dTKfHJlbEUKDnRjeDf551DXyfJrbShFE+Dq5XSXf8IVpRd8i/PyFgTf
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

At the 500 ms job timeout panfrost resets the GPU and the job is lost,
but OpenCL kernels and heavy fragment jobs can take seconds on a small
GPU. On a Mali-G31 this fails OpenCL CTS Integer Ops long math and
Thread Dimensions, KHR-GLES31 mixedSequence (a 0.7 s fragment job) and
dEQP-VK spirv_assembly vec4 fragment cases.

Do as the Arm driver does:
- A job still ACTIVE at the timeout is soft-stopped and resumed from
  JS_TAIL, without a reset or karma. Its slot gets
  JOB_SOFT_STOP_TIMEOUT_MS (5 s) to reach a task boundary.
- A job still active then is hard-stopped and gets karma and a
  devcoredump; the other stopped jobs are resumed.
- If the hard stop has no effect within JOB_HARD_STOP_TIMEOUT_MS
  (0.5 s), the GPU is reset and that job is failed, not restarted.
- A reset requested meanwhile (job fault, MMU) overrides the stop-only
  request, PANFROST_RESET_STOP_ONLY.
- A job that completes between the fence check and the JS_STATUS read
  is a spurious timeout.
- Without a reset, the AS references of jobs cancelled from _NEXT are
  released here.

With this, those cases pass; two vec4 fragment cases take 4-6 s.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
v4: the runtime PM reference in panfrost_reset() moved to patch 14.
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 152 +++++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 7a2503f4e..bc6add918 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -27,6 +27,13 @@
 #define MAX_JM_CTX_PER_FILE 64
 #define JOB_TIMEOUT_MS 500
 
+/* Arm driver: DEFAULT_JS_HARD_STOP_TICKS_SS, DEFAULT_JS_RESET_TICKS_SS */
+#define JOB_SOFT_STOP_TIMEOUT_MS 5000
+#define JOB_HARD_STOP_TIMEOUT_MS 500
+
+/* reset.pending: stop the slots, no GPU reset; 1 overrides it */
+#define PANFROST_RESET_STOP_ONLY 2
+
 #define job_write(dev, reg, data) writel(data, dev->iomem + (reg))
 #define job_read(dev, reg) readl(dev->iomem + (reg))
 
@@ -661,13 +668,25 @@ static bool panfrost_slots_idle(struct panfrost_device *pfdev)
 	return true;
 }
 
+/* The second job if the first's DONE is still pending */
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
@@ -691,7 +710,7 @@ panfrost_reset(struct panfrost_device *pfdev,
 
 	cookie = dma_fence_begin_signalling();
 
-	if (bad)
+	if (bad && !job_active)
 		drm_sched_increase_karma(bad);
 
 	/* Mask job interrupts and synchronize to make sure we won't be
@@ -716,20 +735,65 @@ panfrost_reset(struct panfrost_device *pfdev,
 	}
 	spin_unlock(&pfdev->js->job_lock);
 
-	/* Wait at most 10ms for soft-stops to complete */
-	ret = read_poll_timeout(panfrost_slots_idle, idle, idle, 10, 10000,
+	/* No slot may be active when we touch the queues. */
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
@@ -739,19 +803,36 @@ panfrost_reset(struct panfrost_device *pfdev,
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
+			/* Restarted, it would only time out again. */
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
@@ -781,6 +862,8 @@ panfrost_job_handle_timeout(struct drm_sched_job *sched_job)
 	struct panfrost_job *job = to_panfrost_job(sched_job);
 	struct panfrost_device *pfdev = job->pfdev;
 	int js = panfrost_job_get_slot(job);
+	bool job_active;
+	u32 js_status;
 
 	/*
 	 * If the GPU managed to complete this jobs fence, the timeout has
@@ -805,18 +888,41 @@ panfrost_job_handle_timeout(struct drm_sched_job *sched_job)
 		return DRM_GPU_SCHED_STAT_NO_HANG;
 	}
 
-	dev_err(pfdev->base.dev, "gpu sched timeout, js=%d, config=0x%x, status=0x%x, head=0x%x, tail=0x%x, sched_job=%p",
-		js,
-		job_read(pfdev, JS_CONFIG(js)),
-		job_read(pfdev, JS_STATUS(js)),
-		job_read(pfdev, JS_HEAD_LO(js)),
-		job_read(pfdev, JS_TAIL_LO(js)),
-		sched_job);
+	js_status = job_read(pfdev, JS_STATUS(js));
+	job_active = js_status == DRM_PANFROST_EXCEPTION_ACTIVE;
 
-	panfrost_core_dump(job);
+	/* The job may have completed since the fence check above. */
+	if (!job_active) {
+		if (job_read(pfdev, JOB_INT_RAWSTAT) & JOB_INT_MASK_DONE(js))
+			return DRM_GPU_SCHED_STAT_NO_HANG;
 
-	atomic_set(&pfdev->reset.pending, 1);
-	panfrost_reset(pfdev, sched_job);
+		synchronize_irq(pfdev->js->irq);
+		if (dma_fence_is_signaled(job->done_fence))
+			return DRM_GPU_SCHED_STAT_NO_HANG;
+	}
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
+
+		panfrost_core_dump(job);
+	}
+
+	if (job_active)
+		atomic_cmpxchg(&pfdev->reset.pending, 0,
+			       PANFROST_RESET_STOP_ONLY);
+	else
+		atomic_set(&pfdev->reset.pending, 1);
+	panfrost_reset(pfdev, sched_job, job_active);
 
 	return DRM_GPU_SCHED_STAT_RESET;
 }
@@ -843,7 +949,7 @@ static void panfrost_reset_work(struct work_struct *work)
 	if (pm_runtime_resume_and_get(pfdev->base.dev))
 		return;
 
-	panfrost_reset(pfdev, NULL);
+	panfrost_reset(pfdev, NULL, false);
 	pm_runtime_put_autosuspend(pfdev->base.dev);
 }
 

-- 
2.55.0


