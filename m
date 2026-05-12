Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C9BCD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F44010EA51;
	Tue, 12 May 2026 11:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FJkTtVMd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE8510EA48
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585865;
 bh=CUQBJYc42pp+vcizWMfDB+L4bpl6be86GFb9rl+/M1w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FJkTtVMdoA7OsTKYSe9GX1P25fD7snX5/GjUIDjJIpqOLmi5UI/63e9ukdWqAEXwS
 VzQ5K8tnMfY3iggZJJ5W0AhjAwTX9uKNKdNEm9i2LbpVRzXq7w5RNrsyAJJDwD0CG/
 /n3dLblXXSXc9lZmwePgy+V3LtWeK/Wp9jE/3fRLU6H0Svo1xBvjO1BpUD/qqgZV/w
 CockEWIqU200z6CLcyqlAciYsHULMW/y/y/8l5HsaBFNIO4wIL5CWmUzyfddP0Ryjc
 PUeLRPFuOfsXV4kMYAvjacYYK68VpOkvfQMTw5OojjrQ5ePwK7UX/lCwVotJh+V5U4
 aBNM1NlsGGMyw==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 93C6917E38C7;
 Tue, 12 May 2026 13:37:44 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:36 +0200
Subject: [PATCH v2 06/11] drm/panthor: Prepare the scheduler logic for FW
 events in IRQ context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-6-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=21521;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=CUQBJYc42pp+vcizWMfDB+L4bpl6be86GFb9rl+/M1w=;
 b=qyHxATKvzZTJXeuhN7J18J1lxpdaZbjsGOeErPI2S2oKO63gK+AQlBr5mf4RWBMko6prk0HRB
 CyaTx0hJUaDDRdskPaCmw7dmc8E0R9jBFLhcF7OKJQ/WBN8Tcl7fNDR
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

Add a specific spinlock for events processing, and force processing
of events in the panthor_sched_report_fw_events() path rather than
deferring it to a work item. We also fast-track fence signalling by
making the job completion logic IRQ-safe.

Note that it requires changing a couple spin_lock() into
spin_lock_irqsave() when those are taken inside a events_lock section.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 332 +++++++++++++++-----------------
 1 file changed, 155 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..fbf76b59b7ef 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -177,18 +177,6 @@ struct panthor_scheduler {
 	 */
 	struct work_struct sync_upd_work;
 
-	/**
-	 * @fw_events_work: Work used to process FW events outside the interrupt path.
-	 *
-	 * Even if the interrupt is threaded, we need any event processing
-	 * that require taking the panthor_scheduler::lock to be processed
-	 * outside the interrupt path so we don't block the tick logic when
-	 * it calls panthor_fw_{csg,wait}_wait_acks(). Since most of the
-	 * event processing requires taking this lock, we just delegate all
-	 * FW event processing to the scheduler workqueue.
-	 */
-	struct work_struct fw_events_work;
-
 	/**
 	 * @fw_events: Bitmask encoding pending FW events.
 	 */
@@ -254,6 +242,15 @@ struct panthor_scheduler {
 		struct list_head waiting;
 	} groups;
 
+	/**
+	 * @events_lock: Lock taken when processing events.
+	 *
+	 * This also needs to be taken when csg_slots are updated, to make sure
+	 * the event processing logic doesn't touch groups that have left the CSG
+	 * slot.
+	 */
+	spinlock_t events_lock;
+
 	/**
 	 * @csg_slots: FW command stream group slots.
 	 */
@@ -676,9 +673,6 @@ struct panthor_group {
 	 */
 	struct panthor_kernel_bo *protm_suspend_buf;
 
-	/** @sync_upd_work: Work used to check/signal job fences. */
-	struct work_struct sync_upd_work;
-
 	/** @tiler_oom_work: Work used to process tiler OOM events happening on this group. */
 	struct work_struct tiler_oom_work;
 
@@ -999,7 +993,6 @@ static int
 group_bind_locked(struct panthor_group *group, u32 csg_id)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *csg_slot;
 	int ret;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
@@ -1012,9 +1005,7 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	if (ret)
 		return ret;
 
-	csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	group_get(group);
-	group->csg_id = csg_id;
 
 	/* Dummy doorbell allocation: doorbell is assigned to the group and
 	 * all queues use the same doorbell.
@@ -1026,7 +1017,10 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = csg_id + 1;
 
-	csg_slot->group = group;
+	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[csg_id].group = group;
+		group->csg_id = csg_id;
+	}
 
 	return 0;
 }
@@ -1041,7 +1035,6 @@ static int
 group_unbind_locked(struct panthor_group *group)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *slot;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
@@ -1051,9 +1044,12 @@ group_unbind_locked(struct panthor_group *group)
 	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
 		return -EINVAL;
 
-	slot = &ptdev->scheduler->csg_slots[group->csg_id];
+	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
+		group->csg_id = -1;
+	}
+
 	panthor_vm_idle(group->vm);
-	group->csg_id = -1;
 
 	/* Tiler OOM events will be re-issued next time the group is scheduled. */
 	atomic_set(&group->tiler_oom, 0);
@@ -1062,8 +1058,6 @@ group_unbind_locked(struct panthor_group *group)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = -1;
 
-	slot->group = NULL;
-
 	group_put(group);
 	return 0;
 }
@@ -1151,16 +1145,14 @@ queue_suspend_timeout_locked(struct panthor_queue *queue)
 static void
 queue_suspend_timeout(struct panthor_queue *queue)
 {
-	spin_lock(&queue->fence_ctx.lock);
+	guard(spinlock_irqsave)(&queue->fence_ctx.lock);
 	queue_suspend_timeout_locked(queue);
-	spin_unlock(&queue->fence_ctx.lock);
 }
 
 static void
 queue_resume_timeout(struct panthor_queue *queue)
 {
-	spin_lock(&queue->fence_ctx.lock);
-
+	guard(spinlock_irqsave)(&queue->fence_ctx.lock);
 	if (queue_timeout_is_suspended(queue)) {
 		mod_delayed_work(queue->scheduler.timeout_wq,
 				 &queue->timeout.work,
@@ -1168,8 +1160,6 @@ queue_resume_timeout(struct panthor_queue *queue)
 
 		queue->timeout.remaining = MAX_SCHEDULE_TIMEOUT;
 	}
-
-	spin_unlock(&queue->fence_ctx.lock);
 }
 
 /**
@@ -1484,7 +1474,7 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 	u32 fatal;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fatal = cs_iface->output->fatal;
@@ -1532,7 +1522,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 	u32 fault;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fault = cs_iface->output->fault;
@@ -1542,7 +1532,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 		u64 cs_extract = queue->iface.output->extract;
 		struct panthor_job *job;
 
-		spin_lock(&queue->fence_ctx.lock);
+		guard(spinlock_irqsave)(&queue->fence_ctx.lock);
 		list_for_each_entry(job, &queue->fence_ctx.in_flight_jobs, node) {
 			if (cs_extract >= job->ringbuf.end)
 				continue;
@@ -1552,7 +1542,6 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 
 			dma_fence_set_error(job->done_fence, -EINVAL);
 		}
-		spin_unlock(&queue->fence_ctx.lock);
 	}
 
 	if (group) {
@@ -1682,7 +1671,7 @@ cs_slot_process_tiler_oom_event_locked(struct panthor_device *ptdev,
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, !group))
 		return;
@@ -1703,7 +1692,7 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	struct panthor_fw_cs_iface *cs_iface;
 	u32 req, ack, events;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	req = cs_iface->input->req;
@@ -1731,7 +1720,7 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	sched->might_have_idle_groups = true;
 
@@ -1742,16 +1731,102 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
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
+	bool cookie;
+	u32 queue_idx;
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
 	struct panthor_csg_slot *csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (group)
-		group_queue_work(group, sync_upd);
+		group_check_job_completion(group);
 
 	sched_queue_work(ptdev->scheduler, sync_upd);
 }
@@ -1763,7 +1838,7 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	group = csg_slot->group;
 	if (!drm_WARN_ON(&ptdev->base, !group)) {
@@ -1784,7 +1859,7 @@ static void sched_process_csg_irq_locked(struct panthor_device *ptdev, u32 csg_i
 	struct panthor_fw_csg_iface *csg_iface;
 	u32 ring_cs_db_mask = 0;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, csg_id >= ptdev->scheduler->csg_slot_count))
 		return;
@@ -1842,7 +1917,7 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	/* Acknowledge the idle event and schedule a tick. */
 	panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack, GLB_IDLE);
@@ -1858,7 +1933,7 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	u32 req, ack, evts;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	req = READ_ONCE(glb_iface->input->req);
 	ack = READ_ONCE(glb_iface->output->ack);
@@ -1868,30 +1943,6 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 		sched_process_idle_event_locked(ptdev);
 }
 
-static void process_fw_events_work(struct work_struct *work)
-{
-	struct panthor_scheduler *sched = container_of(work, struct panthor_scheduler,
-						      fw_events_work);
-	u32 events = atomic_xchg(&sched->fw_events, 0);
-	struct panthor_device *ptdev = sched->ptdev;
-
-	mutex_lock(&sched->lock);
-
-	if (events & JOB_INT_GLOBAL_IF) {
-		sched_process_global_irq_locked(ptdev);
-		events &= ~JOB_INT_GLOBAL_IF;
-	}
-
-	while (events) {
-		u32 csg_id = ffs(events) - 1;
-
-		sched_process_csg_irq_locked(ptdev, csg_id);
-		events &= ~BIT(csg_id);
-	}
-
-	mutex_unlock(&sched->lock);
-}
-
 /**
  * panthor_sched_report_fw_events() - Report FW events to the scheduler.
  * @ptdev: Device.
@@ -1902,8 +1953,19 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 	if (!ptdev->scheduler)
 		return;
 
-	atomic_or(events, &ptdev->scheduler->fw_events);
-	sched_queue_work(ptdev->scheduler, fw_events);
+	guard(spinlock_irqsave)(&ptdev->scheduler->events_lock);
+
+	if (events & JOB_INT_GLOBAL_IF) {
+		sched_process_global_irq_locked(ptdev);
+		events &= ~JOB_INT_GLOBAL_IF;
+	}
+
+	while (events) {
+		u32 csg_id = ffs(events) - 1;
+
+		sched_process_csg_irq_locked(ptdev, csg_id);
+		events &= ~BIT(csg_id);
+	}
 }
 
 static const char *fence_get_driver_name(struct dma_fence *fence)
@@ -2136,7 +2198,9 @@ tick_ctx_init(struct panthor_scheduler *sched,
 		 * CSG IRQs, so we can flag the faulty queue.
 		 */
 		if (panthor_vm_has_unhandled_faults(group->vm)) {
-			sched_process_csg_irq_locked(ptdev, i);
+			scoped_guard(spinlock_irqsave, &sched->events_lock) {
+				sched_process_csg_irq_locked(ptdev, i);
+			}
 
 			/* No fatal fault reported, flag all queues as faulty. */
 			if (!group->fatal_queues)
@@ -2183,13 +2247,13 @@ group_term_post_processing(struct panthor_group *group)
 		if (!queue)
 			continue;
 
-		spin_lock(&queue->fence_ctx.lock);
-		list_for_each_entry_safe(job, tmp, &queue->fence_ctx.in_flight_jobs, node) {
-			list_move_tail(&job->node, &faulty_jobs);
-			dma_fence_set_error(job->done_fence, err);
-			dma_fence_signal_locked(job->done_fence);
+		scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock) {
+			list_for_each_entry_safe(job, tmp, &queue->fence_ctx.in_flight_jobs, node) {
+				list_move_tail(&job->node, &faulty_jobs);
+				dma_fence_set_error(job->done_fence, err);
+				dma_fence_signal_locked(job->done_fence);
+			}
 		}
-		spin_unlock(&queue->fence_ctx.lock);
 
 		/* Manually update the syncobj seqno to unblock waiters. */
 		syncobj = group->syncobjs->kmap + (i * sizeof(*syncobj));
@@ -2336,8 +2400,10 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 			 * any pending interrupts before we start the new
 			 * group.
 			 */
-			if (group->csg_id >= 0)
+			if (group->csg_id >= 0) {
+				guard(spinlock_irqsave)(&sched->events_lock);
 				sched_process_csg_irq_locked(ptdev, group->csg_id);
+			}
 
 			group_unbind_locked(group);
 		}
@@ -2902,10 +2968,12 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 			u32 csg_id = ffs(slot_mask) - 1;
 			struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 
-			if (flush_caches_failed)
+			if (flush_caches_failed) {
 				csg_slot->group->state = PANTHOR_CS_GROUP_TERMINATED;
-			else
+			} else {
+				guard(spinlock_irqsave)(&sched->events_lock);
 				csg_slot_sync_update_locked(ptdev, csg_id);
+			}
 
 			slot_mask &= ~BIT(csg_id);
 		}
@@ -2920,8 +2988,10 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 
 		group_get(group);
 
-		if (group->csg_id >= 0)
+		if (group->csg_id >= 0) {
+			guard(spinlock_irqsave)(&sched->events_lock);
 			sched_process_csg_irq_locked(ptdev, group->csg_id);
+		}
 
 		group_unbind_locked(group);
 
@@ -3005,22 +3075,6 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
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
@@ -3032,7 +3086,7 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 
 	xa_lock(&gpool->xa);
 	xa_for_each_marked(&gpool->xa, i, group, GROUP_REGISTERED) {
-		guard(spinlock)(&group->fdinfo.lock);
+		guard(spinlock_irqsave)(&group->fdinfo.lock);
 		pfile->stats.cycles += group->fdinfo.data.cycles;
 		pfile->stats.time += group->fdinfo.data.time;
 		group->fdinfo.data.cycles = 0;
@@ -3041,80 +3095,6 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
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
-	spin_lock(&queue->fence_ctx.lock);
-	list_for_each_entry_safe(job, job_tmp, &queue->fence_ctx.in_flight_jobs, node) {
-		if (!syncobj) {
-			struct panthor_group *group = job->group;
-
-			syncobj = group->syncobjs->kmap +
-				  (job->queue_idx * sizeof(*syncobj));
-		}
-
-		if (syncobj->seqno < job->done_fence->seqno)
-			break;
-
-		list_move_tail(&job->node, &done_jobs);
-		dma_fence_signal_locked(job->done_fence);
-	}
-
-	if (list_empty(&queue->fence_ctx.in_flight_jobs)) {
-		/* If we have no job left, we cancel the timer, and reset remaining
-		 * time to its default so it can be restarted next time
-		 * queue_resume_timeout() is called.
-		 */
-		queue_suspend_timeout_locked(queue);
-
-		/* If there's no job pending, we consider it progress to avoid a
-		 * spurious timeout if the timeout handler and the sync update
-		 * handler raced.
-		 */
-		progress = true;
-	} else if (!list_empty(&done_jobs)) {
-		queue_reset_timeout_locked(queue);
-		progress = true;
-	}
-	spin_unlock(&queue->fence_ctx.lock);
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
@@ -3346,9 +3326,8 @@ queue_run_job(struct drm_sched_job *sched_job)
 	job->ringbuf.end = job->ringbuf.start + (instrs.count * sizeof(u64));
 
 	panthor_job_get(&job->base);
-	spin_lock(&queue->fence_ctx.lock);
-	list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
-	spin_unlock(&queue->fence_ctx.lock);
+	scoped_guard(spinlock_irqsave, &queue->fence_ctx.lock)
+		list_add_tail(&job->node, &queue->fence_ctx.in_flight_jobs);
 
 	/* Make sure the ring buffer is updated before the INSERT
 	 * register.
@@ -3683,7 +3662,6 @@ int panthor_group_create(struct panthor_file *pfile,
 	INIT_LIST_HEAD(&group->wait_node);
 	INIT_LIST_HEAD(&group->run_node);
 	INIT_WORK(&group->term_work, group_term_work);
-	INIT_WORK(&group->sync_upd_work, group_sync_upd_work);
 	INIT_WORK(&group->tiler_oom_work, group_tiler_oom_work);
 	INIT_WORK(&group->release_work, group_release_work);
 
@@ -4054,7 +4032,6 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
 	disable_delayed_work_sync(&sched->tick_work);
-	disable_work_sync(&sched->fw_events_work);
 	disable_work_sync(&sched->sync_upd_work);
 
 	mutex_lock(&sched->lock);
@@ -4139,7 +4116,8 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	sched->tick_period = msecs_to_jiffies(10);
 	INIT_DELAYED_WORK(&sched->tick_work, tick_work);
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
-	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
+
+	spin_lock_init(&sched->events_lock);
 
 	ret = drmm_mutex_init(&ptdev->base, &sched->lock);
 	if (ret)

-- 
2.54.0

