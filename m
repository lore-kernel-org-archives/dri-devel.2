Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D486C5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93A310E941;
	Tue, 25 Aug 2026 08:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jK/X8phY";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B185310E939
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787644893;
 bh=+2ohjJUid7weiQylVIDJ9OoeuPnFjoyZUfJCRsZnLq0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jK/X8phYWgFkEQetc2gHEB5Gt7X0bg/XP0iJ0kilV71TG1hOkmIXQ9Ttj3nT0KtOw
 dIHUI8YTUP+8WPpRUZHgseVknIICBJhXdP3oBsbg/TpfkjXDZ6oBHeNW3rP0qJ96pT
 zhfgco3S0fSipNhmxyFVoFGRDQnVvi+0nDI3zb2X7wsuyncth15Od3/s6z+Lnf+7mF
 8ZFswp7iHRFv5kSjzNaU4+VZgCUoeJ5NdEzHR2YPAUWXxon/CbuMDzxJ47qIo5DCJ1
 kjB66/+PQ4whuZ9Qbz1gY7+P26A1Blba5w760g29OUjPtYievJOfVbDTNd0S8JKy3h
 DQNjPYcE6aM9w==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A50717E0BDC;
 Tue, 25 Aug 2026 10:01:33 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 25 Aug 2026 10:01:27 +0200
Subject: [PATCH v7 6/9] drm/panthor: Protect events processing with a
 separate spinlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-panthor-signal-from-irq-v7-6-ebb5b4c891a4@collabora.com>
References: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
In-Reply-To: <20260825-panthor-signal-from-irq-v7-0-ebb5b4c891a4@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787644889; l=14507;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=+2ohjJUid7weiQylVIDJ9OoeuPnFjoyZUfJCRsZnLq0=;
 b=fOTq+SGWatV+odDI64VAA3mh5cJbSGt1BFQ2VRZO8xcgw28eSchmEFbar6IuRbsT8o7hzYJbI
 nazwzNpO+ltAs8jf8wuKMNKjXnnZvp7nq5FwxqPxly+7QvuLIg+9zB2
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

Add a specific spinlock for events processing so we can selectively
move some event processing to the threaded IRQ handler. For events to be
processed, we need to have access to the group attached to the CSG slot
which also forces us to protect the csg_slots[] updates with this
lock.

Note that fatal_queues/timedout are turned into atomics to avoid having
to take the events_lock every time those are checked or updated.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 124 ++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 9adf1e21eb83..5e1bf52fa282 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -254,8 +254,22 @@ struct panthor_scheduler {
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
+	 *
+	 * Updates to the group binding must happen with both
+	 * panthor_scheduler::lock and panthor_scheduler::events_lock held.
+	 * The group binding may therefore be read while holding either lock.
+	 * Other slot fields are protected by panthor_scheduler::lock.
 	 */
 	struct panthor_csg_slot csg_slots[MAX_CSGS];
 
@@ -565,8 +579,13 @@ struct panthor_group {
 	/** @idle_queues: Bitmask reflecting the idle queues. */
 	u32 idle_queues;
 
-	/** @fatal_queues: Bitmask reflecting the queues that hit a fatal exception. */
-	u32 fatal_queues;
+	/**
+	 * @fatal_queues: Bitmask reflecting the queues that hit a fatal exception.
+	 *
+	 * This is an atomic because we don't want to acquire the events_lock
+	 * every time we need to check the group state.
+	 */
+	atomic_t fatal_queues;
 
 	/** @tiler_oom: Mask of queues that have a tiler OOM event to process. */
 	atomic_t tiler_oom;
@@ -602,8 +621,14 @@ struct panthor_group {
 	 * any timeout situation is unrecoverable, and the group becomes useless. We
 	 * simply wait for all references to be dropped so we can release the group
 	 * object.
+	 *
+	 * This is an atomic because it can be set from both a scheduling context
+	 * (protected with panthor_scheduler::lock) and an event processing context
+	 * (protected with panthor_scheduler::events_lock). We could protect access
+	 * with the events_lock, but this is simpler to make it an atomic since the
+	 * only allowed transition is false -> true.
 	 */
-	bool timedout;
+	atomic_t timedout;
 
 	/**
 	 * @innocent: True when the group becomes unusable because the group suspension
@@ -996,7 +1021,6 @@ static int
 group_bind_locked(struct panthor_group *group, u32 csg_id)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *csg_slot;
 	int ret;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
@@ -1009,9 +1033,7 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	if (ret)
 		return ret;
 
-	csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	group_get(group);
-	group->csg_id = csg_id;
 
 	/* Dummy doorbell allocation: doorbell is assigned to the group and
 	 * all queues use the same doorbell.
@@ -1023,7 +1045,10 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = csg_id + 1;
 
-	csg_slot->group = group;
+	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[csg_id].group = group;
+		group->csg_id = csg_id;
+	}
 
 	return 0;
 }
@@ -1038,7 +1063,6 @@ static int
 group_unbind_locked(struct panthor_group *group)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *slot;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
@@ -1048,9 +1072,12 @@ group_unbind_locked(struct panthor_group *group)
 	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
 		return -EINVAL;
 
-	slot = &ptdev->scheduler->csg_slots[group->csg_id];
+	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
+		group->csg_id = -1;
+	}
+
 	panthor_vm_idle(group->vm);
-	group->csg_id = -1;
 
 	/* Tiler OOM events will be re-issued next time the group is scheduled. */
 	atomic_set(&group->tiler_oom, 0);
@@ -1060,8 +1087,6 @@ group_unbind_locked(struct panthor_group *group)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = -1;
 
-	slot->group = NULL;
-
 	group_put(group);
 	return 0;
 }
@@ -1079,8 +1104,9 @@ group_can_run(struct panthor_group *group)
 {
 	return group->state != PANTHOR_CS_GROUP_TERMINATED &&
 	       group->state != PANTHOR_CS_GROUP_UNKNOWN_STATE &&
-	       !group->destroyed && group->fatal_queues == 0 &&
-	       !group->timedout;
+	       !group->destroyed &&
+	       !atomic_read(&group->fatal_queues) &&
+	       !atomic_read(&group->timedout);
 }
 
 static bool
@@ -1479,7 +1505,7 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 	u32 fatal;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fatal = cs_iface->output->fatal;
@@ -1489,7 +1515,7 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
 			 group->task_info.pid, group->task_info.comm);
 
-		group->fatal_queues |= BIT(cs_id);
+		atomic_or(BIT(cs_id), &group->fatal_queues);
 	}
 
 	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
@@ -1527,7 +1553,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 	u32 fault;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fault = cs_iface->output->fault;
@@ -1619,7 +1645,7 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
 	 */
 	if (ret && ret != -ENOMEM) {
 		drm_warn(&ptdev->base, "Failed to extend the tiler heap\n");
-		group->fatal_queues |= BIT(cs_id);
+		atomic_or(BIT(cs_id), &group->fatal_queues);
 		sched_queue_delayed_work(sched, tick, 0);
 		goto out_put_heap_pool;
 	}
@@ -1679,7 +1705,7 @@ cs_slot_process_tiler_oom_event_locked(struct panthor_device *ptdev,
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, !group))
 		return;
@@ -1700,7 +1726,7 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	struct panthor_fw_cs_iface *cs_iface;
 	u32 req, ack, events;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	req = cs_iface->input->req;
@@ -1728,7 +1754,7 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	/* Schedule a tick so we can evict idle groups and schedule non-idle
 	 * ones. This will also update runtime PM and devfreq busy/idle states,
@@ -1743,7 +1769,7 @@ static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
 	struct panthor_csg_slot *csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (group)
 		group_queue_work(group, sync_upd);
@@ -1758,14 +1784,14 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	group = csg_slot->group;
 	if (!drm_WARN_ON(&ptdev->base, !group)) {
 		drm_warn(&ptdev->base, "CSG_PROGRESS_TIMER_EVENT: pid=%d, comm=%s\n",
 			 group->task_info.pid, group->task_info.comm);
 
-		group->timedout = true;
+		atomic_set(&group->timedout, true);
 	}
 
 	drm_warn(&ptdev->base, "CSG slot %d progress timeout\n", csg_id);
@@ -1779,7 +1805,7 @@ static void sched_process_csg_irq_locked(struct panthor_device *ptdev, u32 csg_i
 	struct panthor_fw_csg_iface *csg_iface;
 	u32 ring_cs_db_mask = 0;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, csg_id >= ptdev->scheduler->csg_slot_count))
 		return;
@@ -1837,7 +1863,7 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	/* Acknowledge the idle event and schedule a tick. */
 	panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack, GLB_IDLE);
@@ -1853,7 +1879,7 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	u32 req, ack, evts;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	req = READ_ONCE(glb_iface->input->req);
 	ack = READ_ONCE(glb_iface->output->ack);
@@ -1870,7 +1896,7 @@ static void process_fw_events_work(struct work_struct *work)
 	u32 events = atomic_xchg(&sched->fw_events, 0);
 	struct panthor_device *ptdev = sched->ptdev;
 
-	mutex_lock(&sched->lock);
+	guard(spinlock)(&sched->events_lock);
 
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
@@ -1883,8 +1909,6 @@ static void process_fw_events_work(struct work_struct *work)
 		sched_process_csg_irq_locked(ptdev, csg_id);
 		events &= ~BIT(csg_id);
 	}
-
-	mutex_unlock(&sched->lock);
 }
 
 /**
@@ -2131,11 +2155,12 @@ tick_ctx_init(struct panthor_scheduler *sched,
 		 * CSG IRQs, so we can flag the faulty queue.
 		 */
 		if (panthor_vm_has_unhandled_faults(group->vm)) {
-			sched_process_csg_irq_locked(ptdev, i);
+			scoped_guard(spinlock, &sched->events_lock)
+				sched_process_csg_irq_locked(ptdev, i);
 
 			/* No fatal fault reported, flag all queues as faulty. */
-			if (!group->fatal_queues)
-				group->fatal_queues |= GENMASK(group->queue_count - 1, 0);
+			atomic_cmpxchg(&group->fatal_queues, 0,
+				       GENMASK(group->queue_count - 1, 0));
 		}
 
 		tick_ctx_insert_old_group(sched, ctx, group);
@@ -2168,9 +2193,9 @@ group_term_post_processing(struct panthor_group *group)
 		struct panthor_syncobj_64b *syncobj;
 		int err;
 
-		if (group->fatal_queues & BIT(i))
+		if (atomic_read(&group->fatal_queues) & BIT(i))
 			err = -EINVAL;
-		else if (group->timedout)
+		else if (atomic_read(&group->timedout))
 			err = -ETIMEDOUT;
 		else
 			err = -ECANCELED;
@@ -2331,8 +2356,10 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 			 * any pending interrupts before we start the new
 			 * group.
 			 */
-			if (group->csg_id >= 0)
+			if (group->csg_id >= 0) {
+				guard(spinlock)(&sched->events_lock);
 				sched_process_csg_irq_locked(ptdev, group->csg_id);
+			}
 
 			group_unbind_locked(group);
 		}
@@ -2861,7 +2888,7 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 			/* We consider group suspension failures as fatal and flag the
 			 * group as unusable by setting timedout=true.
 			 */
-			csg_slot->group->timedout = true;
+			atomic_set(&csg_slot->group->timedout, true);
 
 			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
 						CSG_STATE_TERMINATE,
@@ -2910,10 +2937,12 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 			u32 csg_id = ffs(slot_mask) - 1;
 			struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 
-			if (flush_caches_failed)
+			if (flush_caches_failed) {
 				csg_slot->group->state = PANTHOR_CS_GROUP_TERMINATED;
-			else
+			} else {
+				guard(spinlock)(&sched->events_lock);
 				csg_slot_sync_update_locked(ptdev, csg_id);
+			}
 
 			slot_mask &= ~BIT(csg_id);
 		}
@@ -2928,8 +2957,10 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 
 		group_get(group);
 
-		if (group->csg_id >= 0)
+		if (group->csg_id >= 0) {
+			guard(spinlock)(&sched->events_lock);
 			sched_process_csg_irq_locked(ptdev, group->csg_id);
+		}
 
 		group_unbind_locked(group);
 
@@ -3421,7 +3452,7 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 	queue_stop(queue, job);
 
 	mutex_lock(&sched->lock);
-	group->timedout = true;
+	atomic_set(&group->timedout, true);
 	if (group->csg_id >= 0) {
 		sched_queue_delayed_work(ptdev->scheduler, tick, 0);
 	} else {
@@ -3843,12 +3874,13 @@ int panthor_group_get_state(struct panthor_file *pfile,
 	memset(get_state, 0, sizeof(*get_state));
 
 	mutex_lock(&sched->lock);
-	if (group->timedout)
+	if (atomic_read(&group->timedout))
 		get_state->state |= DRM_PANTHOR_GROUP_STATE_TIMEDOUT;
-	if (group->fatal_queues) {
+
+	get_state->fatal_queues = atomic_read(&group->fatal_queues);
+	if (get_state->fatal_queues)
 		get_state->state |= DRM_PANTHOR_GROUP_STATE_FATAL_FAULT;
-		get_state->fatal_queues = group->fatal_queues;
-	}
+
 	if (group->innocent)
 		get_state->state |= DRM_PANTHOR_GROUP_STATE_INNOCENT;
 	mutex_unlock(&sched->lock);
@@ -4146,6 +4178,8 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
 	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
 
+	spin_lock_init(&sched->events_lock);
+
 	ret = drmm_mutex_init(&ptdev->base, &sched->lock);
 	if (ret)
 		return ret;

-- 
2.55.0

