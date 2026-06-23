Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B1CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC4B10EB11;
	Tue, 23 Jun 2026 12:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kcvUs32a";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D72C10EB11
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782219071;
 bh=MZC76qSCX8LC4+FPBVy5rw+rV31VcQyL3WLnSAWpeyk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kcvUs32a8b9MFku/miFdnOu7GJZvDixF3H4v39x+kG78QZYkD9B9yu9FpL/y1OQqj
 f8Gl0VuHpg8nifSIZadwDLVECqHrfeRWVxhBCuDtBP7J3vwxgemsKuRplImXinlnxf
 3L9W0Yta3pXQZN3Tp41w9HyNTEkX6w9NrMWhSW/xjxDC7b2xHP3JU2LmJdWsXQgtqW
 YJkmYkl4umsXL66htM7nfgRDZpMNGQw181g5qJ8d18zFA6CcsNGi19sfVS0W9wiXKT
 4LgvX8MC2JD3cWK9+9kLEu0bnS9X3KuVeVs/tm5AmffliuI0RcPjV2mZVXvIVYcGpj
 QaU0rsX82lNRQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D4F7017E1168;
 Tue, 23 Jun 2026 14:51:10 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 23 Jun 2026 14:51:09 +0200
Subject: [PATCH v3 7/7] drm/panthor: Automate CSG IRQ processing at group
 unbind time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-panthor-signal-from-irq-v3-7-2ece396f8ee0@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782219066; l=6813;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=MZC76qSCX8LC4+FPBVy5rw+rV31VcQyL3WLnSAWpeyk=;
 b=6Ei1pXIZmvo3TbXbZD1rW2tmTUyX3avFLFsPbIIhSd4l9pngM8/uAkMvvCtYFoRPOBrOGbgVo
 QfmP+OvjKIEA54mLsPkQmyr33M/5GJx3VW4X9e4Cpi+8YDBabJJo0Ys
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

Make the sched_process_csg_irq_locked() call part of
group_unbind_locked() so we don't have to manually call it in
tick_ctx_apply()/panthor_sched_suspend().

This implies moving group_[un]bind_locked() around to avoid a
forward declaration.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 180 +++++++++++++++-----------------
 1 file changed, 83 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index c8818718d135..124999297aec 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -981,86 +981,6 @@ group_get(struct panthor_group *group)
 	return group;
 }
 
-/**
- * group_bind_locked() - Bind a group to a group slot
- * @group: Group.
- * @csg_id: Slot.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int
-group_bind_locked(struct panthor_group *group, u32 csg_id)
-{
-	struct panthor_device *ptdev = group->ptdev;
-	int ret;
-
-	lockdep_assert_held(&ptdev->scheduler->lock);
-
-	if (drm_WARN_ON(&ptdev->base, group->csg_id != -1 || csg_id >= MAX_CSGS ||
-			ptdev->scheduler->csg_slots[csg_id].group))
-		return -EINVAL;
-
-	ret = panthor_vm_active(group->vm);
-	if (ret)
-		return ret;
-
-	group_get(group);
-
-	/* Dummy doorbell allocation: doorbell is assigned to the group and
-	 * all queues use the same doorbell.
-	 *
-	 * TODO: Implement LRU-based doorbell assignment, so the most often
-	 * updated queues get their own doorbell, thus avoiding useless checks
-	 * on queues belonging to the same group that are rarely updated.
-	 */
-	for (u32 i = 0; i < group->queue_count; i++)
-		group->queues[i]->doorbell_id = csg_id + 1;
-
-	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
-		ptdev->scheduler->csg_slots[csg_id].group = group;
-		group->csg_id = csg_id;
-	}
-
-	return 0;
-}
-
-/**
- * group_unbind_locked() - Unbind a group from a slot.
- * @group: Group to unbind.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int
-group_unbind_locked(struct panthor_group *group)
-{
-	struct panthor_device *ptdev = group->ptdev;
-
-	lockdep_assert_held(&ptdev->scheduler->lock);
-
-	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id >= MAX_CSGS))
-		return -EINVAL;
-
-	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
-		return -EINVAL;
-
-	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
-		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
-		group->csg_id = -1;
-	}
-
-	panthor_vm_idle(group->vm);
-
-	/* Tiler OOM events will be re-issued next time the group is scheduled. */
-	atomic_set(&group->tiler_oom, 0);
-	cancel_work(&group->tiler_oom_work);
-
-	for (u32 i = 0; i < group->queue_count; i++)
-		group->queues[i]->doorbell_id = -1;
-
-	group_put(group);
-	return 0;
-}
-
 static bool
 group_is_idle(struct panthor_group *group)
 {
@@ -1972,6 +1892,88 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
 	}
 }
 
+/**
+ * group_bind_locked() - Bind a group to a group slot
+ * @group: Group.
+ * @csg_id: Slot.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int
+group_bind_locked(struct panthor_group *group, u32 csg_id)
+{
+	struct panthor_device *ptdev = group->ptdev;
+	int ret;
+
+	lockdep_assert_held(&ptdev->scheduler->lock);
+
+	if (drm_WARN_ON(&ptdev->base, group->csg_id != -1 || csg_id >= MAX_CSGS ||
+			ptdev->scheduler->csg_slots[csg_id].group))
+		return -EINVAL;
+
+	ret = panthor_vm_active(group->vm);
+	if (ret)
+		return ret;
+
+	group_get(group);
+
+	/* Dummy doorbell allocation: doorbell is assigned to the group and
+	 * all queues use the same doorbell.
+	 *
+	 * TODO: Implement LRU-based doorbell assignment, so the most often
+	 * updated queues get their own doorbell, thus avoiding useless checks
+	 * on queues belonging to the same group that are rarely updated.
+	 */
+	for (u32 i = 0; i < group->queue_count; i++)
+		group->queues[i]->doorbell_id = csg_id + 1;
+
+	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
+		ptdev->scheduler->csg_slots[csg_id].group = group;
+		group->csg_id = csg_id;
+	}
+
+	return 0;
+}
+
+/**
+ * group_unbind_locked() - Unbind a group from a slot.
+ * @group: Group to unbind.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int
+group_unbind_locked(struct panthor_group *group)
+{
+	struct panthor_device *ptdev = group->ptdev;
+
+	lockdep_assert_held(&ptdev->scheduler->lock);
+
+	if (drm_WARN_ON(&ptdev->base, group->csg_id < 0 || group->csg_id >= MAX_CSGS))
+		return -EINVAL;
+
+	if (drm_WARN_ON(&ptdev->base, group->state == PANTHOR_CS_GROUP_ACTIVE))
+		return -EINVAL;
+
+	scoped_guard(spinlock, &ptdev->scheduler->events_lock) {
+		/* Process all pending IRQs before returning the slot. */
+		sched_process_csg_irq_locked(ptdev, group->csg_id);
+		ptdev->scheduler->csg_slots[group->csg_id].group = NULL;
+		group->csg_id = -1;
+	}
+
+	panthor_vm_idle(group->vm);
+
+	/* Tiler OOM events will be re-issued next time the group is scheduled. */
+	atomic_set(&group->tiler_oom, 0);
+	cancel_work(&group->tiler_oom_work);
+
+	for (u32 i = 0; i < group->queue_count; i++)
+		group->queues[i]->doorbell_id = -1;
+
+	group_put(group);
+	return 0;
+}
+
 static const char *fence_get_driver_name(struct dma_fence *fence)
 {
 	return "panthor";
@@ -2398,18 +2400,8 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 
 	/* Unbind evicted groups. */
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
-		list_for_each_entry(group, &ctx->old_groups[prio], run_node) {
-			/* This group is gone. Process interrupts to clear
-			 * any pending interrupts before we start the new
-			 * group.
-			 */
-			if (group->csg_id >= 0) {
-				guard(spinlock)(&sched->events_lock);
-				sched_process_csg_irq_locked(ptdev, group->csg_id);
-			}
-
+		list_for_each_entry(group, &ctx->old_groups[prio], run_node)
 			group_unbind_locked(group);
-		}
 	}
 
 	for (i = 0; i < sched->csg_slot_count; i++) {
@@ -2990,12 +2982,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 			continue;
 
 		group_get(group);
-
-		if (group->csg_id >= 0) {
-			guard(spinlock)(&sched->events_lock);
-			sched_process_csg_irq_locked(ptdev, group->csg_id);
-		}
-
 		group_unbind_locked(group);
 
 		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));

-- 
2.54.0

