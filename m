Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29A1CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C460A10EB33;
	Tue, 23 Jun 2026 12:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nvfMnZYk";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA09F10EB11
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782219069;
 bh=44FxzyDgXDKvkzIaL43I2RGojC/xIkTcQdUBObK80ns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=nvfMnZYkVrNBGdCljkLEOhgv/RGGSRxZBPa/6Eye1qu31hzOE/snWuQhzGxrbogtk
 BDc4hJ+e/jf/F+qL30fZlvVZNaZumO6MKx6jCIN2N7dpU6Kw0ogJlGBvY+mbYJQWjP
 LqYCitrGn67JVeMDA/xBRZbs/81BKggeTQtPvgA/g7mMcPuDGE7DkU2Kr69BMrQBsV
 GqqSDAZ/+ZHuOBFdGBDx3daVBNxbbDBDhUnL3k5IOMQ56iUFQGtvifa4JhSJpnUCyH
 XNnCLCvHFWN87IhsixduMg+qcSv3unNvmo6o2G2T7od4FozNryjAwVodRnhf7IYR/N
 ATUlft+O4EcMw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 232F417E10FC;
 Tue, 23 Jun 2026 14:51:09 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 23 Jun 2026 14:51:06 +0200
Subject: [PATCH v3 4/7] drm/panthor: Protect events processing with a
 separate spinlock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-panthor-signal-from-irq-v3-4-2ece396f8ee0@collabora.com>
References: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
In-Reply-To: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782219066; l=9425;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=44FxzyDgXDKvkzIaL43I2RGojC/xIkTcQdUBObK80ns=;
 b=YhPGndMB6ZTs6uIDsNKUYk6TXIx6dFqwj1jZ+RN8XkBFU1GIOpwpRDkPHsTc843Vw8EudHfOb
 yIxMvBQbA/9B3CH99WDzXL40sGRhssRiynUgSWk4FNUIKr7CSun8zFk
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

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 74 +++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..4f5d874e5d46 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -254,8 +254,21 @@ struct panthor_scheduler {
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
+	 * Updates to these slots must happen with both panthor_scheduler::lock and
+	 * panthor_scheduler::events_lock held. As a result, reads can happen with
+	 * either of these locks held.
 	 */
 	struct panthor_csg_slot csg_slots[MAX_CSGS];
 
@@ -999,7 +1012,6 @@ static int
 group_bind_locked(struct panthor_group *group, u32 csg_id)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *csg_slot;
 	int ret;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
@@ -1012,9 +1024,7 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	if (ret)
 		return ret;
 
-	csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	group_get(group);
-	group->csg_id = csg_id;
 
 	/* Dummy doorbell allocation: doorbell is assigned to the group and
 	 * all queues use the same doorbell.
@@ -1026,7 +1036,10 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = csg_id + 1;
 
-	csg_slot->group = group;
+	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[csg_id].group = group;
+		group->csg_id = csg_id;
+	}
 
 	return 0;
 }
@@ -1041,7 +1054,6 @@ static int
 group_unbind_locked(struct panthor_group *group)
 {
 	struct panthor_device *ptdev = group->ptdev;
-	struct panthor_csg_slot *slot;
 
 	lockdep_assert_held(&ptdev->scheduler->lock);
 
@@ -1051,9 +1063,12 @@ group_unbind_locked(struct panthor_group *group)
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
@@ -1062,8 +1077,6 @@ group_unbind_locked(struct panthor_group *group)
 	for (u32 i = 0; i < group->queue_count; i++)
 		group->queues[i]->doorbell_id = -1;
 
-	slot->group = NULL;
-
 	group_put(group);
 	return 0;
 }
@@ -1484,7 +1497,7 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
 	u32 fatal;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fatal = cs_iface->output->fatal;
@@ -1532,7 +1545,7 @@ cs_slot_process_fault_event_locked(struct panthor_device *ptdev,
 	u32 fault;
 	u64 info;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	fault = cs_iface->output->fault;
@@ -1682,7 +1695,7 @@ cs_slot_process_tiler_oom_event_locked(struct panthor_device *ptdev,
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, !group))
 		return;
@@ -1703,7 +1716,7 @@ static bool cs_slot_process_irq_locked(struct panthor_device *ptdev,
 	struct panthor_fw_cs_iface *cs_iface;
 	u32 req, ack, events;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	cs_iface = panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
 	req = cs_iface->input->req;
@@ -1731,7 +1744,7 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 {
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	sched->might_have_idle_groups = true;
 
@@ -1748,7 +1761,7 @@ static void csg_slot_sync_update_locked(struct panthor_device *ptdev,
 	struct panthor_csg_slot *csg_slot = &ptdev->scheduler->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (group)
 		group_queue_work(group, sync_upd);
@@ -1763,7 +1776,7 @@ csg_slot_process_progress_timer_event_locked(struct panthor_device *ptdev, u32 c
 	struct panthor_csg_slot *csg_slot = &sched->csg_slots[csg_id];
 	struct panthor_group *group = csg_slot->group;
 
-	lockdep_assert_held(&sched->lock);
+	lockdep_assert_held(&sched->events_lock);
 
 	group = csg_slot->group;
 	if (!drm_WARN_ON(&ptdev->base, !group)) {
@@ -1784,7 +1797,7 @@ static void sched_process_csg_irq_locked(struct panthor_device *ptdev, u32 csg_i
 	struct panthor_fw_csg_iface *csg_iface;
 	u32 ring_cs_db_mask = 0;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	if (drm_WARN_ON(&ptdev->base, csg_id >= ptdev->scheduler->csg_slot_count))
 		return;
@@ -1842,7 +1855,7 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	/* Acknowledge the idle event and schedule a tick. */
 	panthor_fw_update_reqs(glb_iface, req, glb_iface->output->ack, GLB_IDLE);
@@ -1858,7 +1871,7 @@ static void sched_process_global_irq_locked(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	u32 req, ack, evts;
 
-	lockdep_assert_held(&ptdev->scheduler->lock);
+	lockdep_assert_held(&ptdev->scheduler->events_lock);
 
 	req = READ_ONCE(glb_iface->input->req);
 	ack = READ_ONCE(glb_iface->output->ack);
@@ -1875,7 +1888,7 @@ static void process_fw_events_work(struct work_struct *work)
 	u32 events = atomic_xchg(&sched->fw_events, 0);
 	struct panthor_device *ptdev = sched->ptdev;
 
-	mutex_lock(&sched->lock);
+	guard(spinlock)(&sched->events_lock);
 
 	if (events & JOB_INT_GLOBAL_IF) {
 		sched_process_global_irq_locked(ptdev);
@@ -1888,8 +1901,6 @@ static void process_fw_events_work(struct work_struct *work)
 		sched_process_csg_irq_locked(ptdev, csg_id);
 		events &= ~BIT(csg_id);
 	}
-
-	mutex_unlock(&sched->lock);
 }
 
 /**
@@ -2136,7 +2147,8 @@ tick_ctx_init(struct panthor_scheduler *sched,
 		 * CSG IRQs, so we can flag the faulty queue.
 		 */
 		if (panthor_vm_has_unhandled_faults(group->vm)) {
-			sched_process_csg_irq_locked(ptdev, i);
+			scoped_guard(spinlock, &sched->events_lock)
+				sched_process_csg_irq_locked(ptdev, i);
 
 			/* No fatal fault reported, flag all queues as faulty. */
 			if (!group->fatal_queues)
@@ -2336,8 +2348,10 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
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
@@ -2902,10 +2916,12 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
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
@@ -2920,8 +2936,10 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 
 		group_get(group);
 
-		if (group->csg_id >= 0)
+		if (group->csg_id >= 0) {
+			guard(spinlock)(&sched->events_lock);
 			sched_process_csg_irq_locked(ptdev, group->csg_id);
+		}
 
 		group_unbind_locked(group);
 
@@ -4141,6 +4159,8 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	INIT_WORK(&sched->sync_upd_work, sync_upd_work);
 	INIT_WORK(&sched->fw_events_work, process_fw_events_work);
 
+	spin_lock_init(&sched->events_lock);
+
 	ret = drmm_mutex_init(&ptdev->base, &sched->lock);
 	if (ret)
 		return ret;

-- 
2.54.0

