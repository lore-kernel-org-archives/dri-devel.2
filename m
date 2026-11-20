Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4A606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uo0pzhQq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45D1112075;
	Fri, 20 Nov 2026 10:41:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34472112075
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:44 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so6025115e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171242; x=1795776042; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r3AE3zLxK428z7+9j+YfGisNu564r6/G6Af0bQmzPVk=;
 b=uo0pzhQqTCvTkl14du1WSasNCbIW2qOoYp8chVkyqrUKIeB6VTau5PuDXlSPgGZ0Ne
 664pfqEMEtQs8sZ1zkhl/MG8V1NjJAYeQHBFpMkfNOmPCngQLoy2TEmJYjaUVCOei5Lr
 a2UsIQGo4FxRcHakUDOiOoMUp3L4JCXSWu4fbK8Va/EAGldTbwV+ECQBDbDBiFKNmM49
 8UmvU5KXy/cS2o/q6KTgBPa4CG8/iHboCGUnxAW4XOtQtVxxX3tdC+NbIZ57c9N2hzoz
 ZUq6wZ4GVJBB72X07h3nhf3rfVMyoOmcX9A9O11yp0fmhc9iwHVoGM4Sdukw+kwiQ8f4
 nAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171242; x=1795776042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r3AE3zLxK428z7+9j+YfGisNu564r6/G6Af0bQmzPVk=;
 b=hVwo60G4NDadgPMnynP2y8Q9NCjkuwIavU0ldY1I/q0ZMe4GlruAv4X4oQ71SUnaPI
 djKaMI8oR6DMvxxhdDVF2KjnSODiZ68mQOhY+TwRRIdCUJrw1JcZx0+MgMklDUhGZgnE
 0gxQGAg3tmSslLQ7/e1K+SqGx2zbIGk7GKrqDekoPnXXXUa6mXgFnQ929mztjKnRCnrd
 yj2PUdwcKfUbJ9QHyKvgdfb3MRS0NXOy9mnc+0iJFodwMuPBTk7nM3aECEpKkpCnUMT+
 iWCjcygfD7cIf75HiYV0ttN4nb0tW1N3htqFi3OOwb6UqlbUFWJ095Mt52AuUINqUtNr
 qdHg==
X-Forwarded-Encrypted: i=1;
 AL+hErGFX5XPny7/3rZ7J7mJZYGFRR3o5avcNMPqfClr85lkGUiIKEvvQhASyz4RyYFbVz3Eul+KyUNigDU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8unWhWBvXZTlYy+zPDxVc4JGNbv7skKjbC7lbXkpIlMNCz7MQ8
 2ZN2S34S+mVWNk0dZjDPnKxMU9R1v/3Nk/pocEQbyx0cA57Et5hG6CFq
X-Gm-Gg: AYBFou1kZq6VE8B7ntitbIByzzZoh0w3oVAorIkzFzanud8rqxKU0TTLcA9gD9euopf
 QIQR3zsCEsu/zutHiUyl8KGMIN3muajhfiPAYOBphEL8aBLtyALwwhwbuvT8watMOakkSrO41+x
 4bYhrn7znTIiiWnTFTh8NT70zehB4TGGb1+froyHuBlqpCuGLFnxrtRwRu95LQXNKEi3v2qD5VU
 fJ7qRjjQBi9AAOilRAlNFqNOw9vNHua4TLnRbLA/YcwcGGkrJ9YfkGqIcrH7h76hNIvcGNUVcTC
 hdcEwsEehAv1Dy6GiDZG35r8byBvXa+C7fdLdjTLQ2h7LvkJIdnYBzX0ndpobbk9g0h63S4hwsC
 zFnfwVvL0M6xDbKqfDPmh7GzBjyauGWPYsQfPI7Eqr3UMHwLAi7J7RcyR4ny4DSTs7nwp7K7G8H
 6kttoQvetsd8hQZsYWdJxGBsLgog6lJi9wyAz9pgHMyLKBvrDNm8UzMgmwAPB4mPF8BFGz2iFLe
 wJB/S5ILiwtwquvZHqpNleg2wmYG9OG2S1CX+byuq2i7TFQ5LMgOZ5Oev5ofGQm0QkfwLuMtCI0
 Acg52RIMHn1+3NAyx8NCq0TV4sh16V5iVt5l8LcBVYFV5ePWRSSNXmIuEf8hwAQ4XxrJ/rEUlC1
 XEe8svEIQRKZbcm69XtmolHLmdmcotNUwSAaVRtpxmhyCr1ClLxs=
X-Received: by 2002:a05:600c:a08b:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4bb88922c52mr52970985e9.13.1795171242458; 
 Fri, 20 Nov 2026 02:40:42 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:41 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:31 +0100
Subject: [PATCH 5/7] drm/etnaviv: Change the GPU clock between jobs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-5-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable+noautosel@kernel.org
X-Mailer: b4 0.14.3
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

Thermal throttling changes the core clock while a job is running. This
can hang the GPU. On a GC7000 rev 6009 I toggled the cooling state
every 200 ms during glmark2 runs and got 25 hang recoveries in 24 runs.
With this change I got none in 34 runs.

Hold back new jobs in etnaviv_gpu_submit(..) and wait for the queued
ones before changing the clock. A hang recovery counts the dropped
jobs as completed, so it ends the wait too. If the GPU suspends while
we wait, the resume applies the new scale.

The wait gives up after one job timeout. Then the clock changes while
a job is running, as it did before. The timeout is needed because a
hang recovery stops the scheduler, which waits for the run_job work,
and this work can be the job held back in etnaviv_gpu_submit(..).

drm_sched_wqueue_stop(..) is no alternative. The hang recovery uses
the same pause_submit flag and resubmits jobs without looking at it.

A cooling request now blocks until the GPU is drained, up to one job
timeout, and with it the thermal zone if a governor made the request.
The held back submit blocks the scheduler workqueue, which also cleans
up finished jobs. So the IRQ handler wakes the waiting clock change
itself.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Cc: <stable+noautosel@kernel.org> # needs store_release_wake_up(..)
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 51 ++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h |  1 +
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c819f5fc4418..9b112d053abd 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1452,6 +1452,14 @@ struct dma_fence *etnaviv_gpu_submit(struct etnaviv_gem_submit *submit)
 
 	mutex_lock(&gpu->lock);
 
+	/* a clock change waits for the queued jobs, don't add new ones */
+	while (gpu->clock_change_pending) {
+		mutex_unlock(&gpu->lock);
+		wait_var_event(&gpu->clock_change_pending,
+			       !READ_ONCE(gpu->clock_change_pending));
+		mutex_lock(&gpu->lock);
+	}
+
 	gpu_fence = etnaviv_gpu_fence_alloc(gpu);
 	if (!gpu_fence) {
 		for (i = 0; i < nr_events; i++)
@@ -1542,6 +1550,13 @@ void etnaviv_gpu_recover_hang(struct etnaviv_gem_submit *submit)
 		event_free(gpu, i);
 	spin_unlock(&gpu->event_spinlock);
 
+	/*
+	 * The dropped jobs never complete, count them as completed so a clock
+	 * change does not wait for them. Resubmitted jobs get new fences.
+	 */
+	WRITE_ONCE(gpu->completed_fence, gpu->next_fence);
+	wake_up_all(&gpu->fence_event);
+
 	etnaviv_gpu_hw_init(gpu);
 
 	mutex_unlock(&gpu->lock);
@@ -1652,12 +1667,20 @@ static irqreturn_t irq_handler(int irq, void *data)
 			 * we can end up processing event 0 first, then 1.
 			 */
 			if (fence_after(fence->seqno, gpu->completed_fence))
-				gpu->completed_fence = fence->seqno;
+				WRITE_ONCE(gpu->completed_fence, fence->seqno);
 			dma_fence_signal_timestamp(fence, now);
 
 			event_free(gpu, event);
 		}
 
+		/*
+		 * A clock change waits on fence_event for the queued jobs.
+		 * Job cleanup wakes it, but a submit held back for the clock
+		 * change blocks the ordered scheduler workqueue and with it
+		 * the cleanup. So wake it from here as well.
+		 */
+		wake_up_all(&gpu->fence_event);
+
 		ret = IRQ_HANDLED;
 	}
 
@@ -1789,6 +1812,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 				  unsigned long state)
 {
 	struct etnaviv_gpu *gpu = cdev->devdata;
+	u32 fence;
 
 	mutex_lock(&gpu->lock);
 	if (state == gpu->freq_scale) {
@@ -1798,8 +1822,33 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	gpu->freq_scale = state;
 	/* a suspended or not yet reset GPU picks up freq_scale later */
+	if (gpu->state < ETNA_GPU_STATE_RESET) {
+		mutex_unlock(&gpu->lock);
+		return 0;
+	}
+
+	/*
+	 * Change the clock between jobs: hold back new jobs and wait for the
+	 * queued ones, as a job that runs across a clock change can hang the
+	 * GPU. The wait must be bounded: a hang recovery stops the scheduler,
+	 * which waits for the job held back in etnaviv_gpu_submit(), and that
+	 * job waits for the clock change. So give up after one job timeout and
+	 * change the clock anyway.
+	 */
+	WRITE_ONCE(gpu->clock_change_pending, true);
+	fence = gpu->next_fence;
+	mutex_unlock(&gpu->lock);
+
+	if (!wait_event_timeout(gpu->fence_event,
+				!fence_after(fence, READ_ONCE(gpu->completed_fence)),
+				gpu->sched.timeout))
+		dev_dbg(gpu->dev, "clock change while jobs are running\n");
+
+	mutex_lock(&gpu->lock);
+	/* the GPU may have suspended while waiting, the resume applies it */
 	if (gpu->state >= ETNA_GPU_STATE_RESET)
 		etnaviv_gpu_update_clock(gpu);
+	store_release_wake_up(&gpu->clock_change_pending, false);
 	mutex_unlock(&gpu->lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index e89d591d7404..dddeabce6eb4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -136,6 +136,7 @@ struct etnaviv_gpu {
 	u32 next_fence;
 	u32 completed_fence;
 	wait_queue_head_t fence_event;
+	bool clock_change_pending;
 	u64 fence_context;
 	spinlock_t fence_spinlock;
 

-- 
2.56.0

