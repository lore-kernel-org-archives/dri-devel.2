Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE841C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F30210EB53;
	Tue, 11 Aug 2026 11:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="pryvNSBB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62F910EB4D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447422;
 bh=3NRjvFxL5rlB3twQb44i+QFtWmo1Zowmn+0rf5uAf1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pryvNSBBaFXdniz5Eo5ECIcYpmIKt2yWLv+WvXiHTdQUcr147y+bfHkJvTSlwz5lB
 19ciq0caCyO4ZrK3QbOBnLb2mmam8c8pZaBEZ/cXWtk0par/jr8MBPsptqcBjJJAB7
 N76EErHnWmih6La9Iuv271C+Z205qInGrjmFnWA1b5r3pnW6wKc8QRrja900HFiqxI
 qs1nuIkr4qXI0XMthuU3gWAqDxThuXFRuF/T/nZ6v0ycnSNCC67Htw41BR0Te5jM5U
 HVgEhhmdbQbBdiiURLH1vSlmHwwrFGPcxPwe0w0DGl8Vs6xYOc4sqIEgzx9Dfc4Q2o
 ZEUwRW2oM4+eg==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 48C4B17E0FAB;
 Tue, 11 Aug 2026 13:23:42 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 13:23:41 +0200
Subject: [PATCH v6 7/9] drm/panthor: Don't defer job completion checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-signal-from-irq-v6-7-12f2ab53d735@collabora.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
In-Reply-To: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=7802;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=3NRjvFxL5rlB3twQb44i+QFtWmo1Zowmn+0rf5uAf1I=;
 b=pwCOwhtEyGGm4ilpjyOGlJ0i68vrVklAtWfbu6vJWbD8WJVW2OwJ2zjl0QHBJ2Bl90zTrlK9O
 /ANEB4hZQkqDySsPCg3Emi9DhG3T3DcK1PvVyLSnExKDeCrBQI8Zypp
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Call group_check_job_completion() directly from
csg_slot_sync_update_locked() instead of deferring it.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 182 +++++++++++++++-----------------
 1 file changed, 87 insertions(+), 95 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 794105e239e6..1ef9da55030c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -697,9 +697,6 @@ struct panthor_group {
 	 */
 	struct panthor_kernel_bo *protm_suspend_buf;
 
-	/** @sync_upd_work: Work used to check/signal job fences. */
-	struct work_struct sync_upd_work;
-
 	/** @tiler_oom_work: Work used to process tiler OOM events happening on this group. */
 	struct work_struct tiler_oom_work;
 
@@ -1762,6 +1759,92 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 	sched_queue_delayed_work(sched, tick, 0);
 }
 
+static void update_fdinfo_stats(struct panthor_job *job)
+{
+	struct panthor_group *group = job->group;
+	struct panthor_queue *queue = group->queues[job->queue_idx];
+	struct panthor_gpu_usage *fdinfo = &group->fdinfo.data;
+	struct panthor_job_profiling_data *slots = queue->profiling.slots->kmap;
+	struct panthor_job_profiling_data *data = &slots[job->profiling.slot];
+
+	scoped_guard(spinlock_irqsave, &group->fdinfo.lock) {
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
+			fdinfo->cycles += data->cycles.after - data->cycles.before;
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
+			fdinfo->time += data->time.after - data->time.before;
+	}
+}
+
+static bool queue_check_job_completion(struct panthor_queue *queue)
+{
+	struct panthor_syncobj_64b *syncobj = NULL;
+	struct panthor_job *job, *job_tmp;
+	bool cookie, progress = false;
+	LIST_HEAD(done_jobs);
+
+	cookie = dma_fence_begin_signalling();
+	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
+		list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_flight_jobs, node) {
+			if (!syncobj) {
+				struct panthor_group *group = job->group;
+
+				syncobj = group->syncobjs->kmap +
+					  (job->queue_idx * sizeof(*syncobj));
+			}
+
+			if (syncobj->seqno < job->done_fence->seqno)
+				break;
+
+			list_move_tail(&job->node, &done_jobs);
+			dma_fence_signal_locked(job->done_fence);
+		}
+
+		if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
+			/* If we have no job left, we cancel the timer, and reset remaining
+			 * time to its default so it can be restarted next time
+			 * queue_resume_timeout() is called.
+			 */
+			queue_suspend_timeout_locked(queue);
+
+			/* If there's no job pending, we consider it progress to avoid a
+			 * spurious timeout if the timeout handler and the sync update
+			 * handler raced.
+			 */
+			progress = true;
+		} else if (!list_empty(&done_jobs)) {
+			queue_reset_timeout_locked(queue);
+			progress = true;
+		}
+	}
+	dma_fence_end_signalling(cookie);
+
+	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
+		if (job->profiling.mask)
+			update_fdinfo_stats(job);
+		list_del_init(&job->node);
+		panthor_job_put(&job->base);
+	}
+
+	return progress;
+}
+
+static void group_check_job_completion(struct panthor_group *group)
+{
+	u32 queue_idx;
+	bool cookie;
+
+	cookie = dma_fence_begin_signalling();
+	for (queue_idx = 0; queue_idx < group->queue_count; queue_idx++) {
+		struct panthor_queue *queue = group->queues[queue_idx];
+
+		if (!queue)
+			continue;
+
+		queue_check_job_completion(queue);
+	}
+	dma_fence_end_signalling(cookie);
+}
+
 static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
 					u32 csg_id)
 {
@@ -1771,7 +1854,7 @@ static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
 	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (group)
-		group_queue_work(group, sync_upd);
+		group_check_job_completion(group);
 
 	sched_queue_work(ptdev->scheduler, sync_upd);
 }
@@ -3043,22 +3126,6 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 	}
 }
 
-static void update_fdinfo_stats(struct panthor_job *job)
-{
-	struct panthor_group *group = job->group;
-	struct panthor_queue *queue = group->queues[job->queue_idx];
-	struct panthor_gpu_usage *fdinfo = &group->fdinfo.data;
-	struct panthor_job_profiling_data *slots = queue->profiling.slots->kmap;
-	struct panthor_job_profiling_data *data = &slots[job->profiling.slot];
-
-	scoped_guard(spinlock, &group->fdinfo.lock) {
-		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
-			fdinfo->cycles += data->cycles.after - data->cycles.before;
-		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
-			fdinfo->time += data->time.after - data->time.before;
-	}
-}
-
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 {
 	struct panthor_group_pool *gpool = pfile->groups;
@@ -3079,80 +3146,6 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 	xa_unlock(&gpool->xa);
 }
 
-static bool queue_check_job_completion(struct panthor_queue *queue)
-{
-	struct panthor_syncobj_64b *syncobj = NULL;
-	struct panthor_job *job, *job_tmp;
-	bool cookie, progress = false;
-	LIST_HEAD(done_jobs);
-
-	cookie = dma_fence_begin_signalling();
-	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
-		list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_flight_jobs, node) {
-			if (!syncobj) {
-				struct panthor_group *group = job->group;
-
-				syncobj = group->syncobjs->kmap +
-					  (job->queue_idx * sizeof(*syncobj));
-			}
-
-			if (syncobj->seqno < job->done_fence->seqno)
-				break;
-
-			list_move_tail(&job->node, &done_jobs);
-			dma_fence_signal_locked(job->done_fence);
-		}
-
-		if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
-			/* If we have no job left, we cancel the timer, and reset remaining
-			 * time to its default so it can be restarted next time
-			 * queue_resume_timeout() is called.
-			 */
-			queue_suspend_timeout_locked(queue);
-
-			/* If there's no job pending, we consider it progress to avoid a
-			 * spurious timeout if the timeout handler and the sync update
-			 * handler raced.
-			 */
-			progress = true;
-		} else if (!list_empty(&done_jobs)) {
-			queue_reset_timeout_locked(queue);
-			progress = true;
-		}
-	}
-	dma_fence_end_signalling(cookie);
-
-	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
-		if (job->profiling.mask)
-			update_fdinfo_stats(job);
-		list_del_init(&job->node);
-		panthor_job_put(&job->base);
-	}
-
-	return progress;
-}
-
-static void group_sync_upd_work(struct work_struct *work)
-{
-	struct panthor_group *group =
-		container_of(work, struct panthor_group, sync_upd_work);
-	u32 queue_idx;
-	bool cookie;
-
-	cookie = dma_fence_begin_signalling();
-	for (queue_idx = 0; queue_idx < group->queue_count; queue_idx++) {
-		struct panthor_queue *queue = group->queues[queue_idx];
-
-		if (!queue)
-			continue;
-
-		queue_check_job_completion(queue);
-	}
-	dma_fence_end_signalling(cookie);
-
-	group_put(group);
-}
-
 struct panthor_job_ringbuf_instrs {
 	u64 buffer[MAX_INSTRS_PER_JOB];
 	u32 count;
@@ -3718,7 +3711,6 @@ int panthor_group_create(struct panthor_file *pfile,
 	INIT_LIST_HEAD(&group->wait_node);
 	INIT_LIST_HEAD(&group->run_node);
 	INIT_WORK(&group->term_work, group_term_work);
-	INIT_WORK(&group->sync_upd_work, group_sync_upd_work);
 	INIT_WORK(&group->tiler_oom_work, group_tiler_oom_work);
 	INIT_WORK(&group->release_work, group_release_work);
 

-- 
2.55.0

