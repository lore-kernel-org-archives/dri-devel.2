Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DDBCDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E340A10F1FC;
	Thu, 25 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Kj8H/n21";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864D110F1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380197;
 bh=gYxm4e3QM3o7Kpw5Ldk1CoESPmXCJSG3hepoF5kKlRo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Kj8H/n21MZ9qT9LHiYEb4Md4zq9Vh4Fs24HDPuGX099q9JMkIm+ZgZj8S3WhrjA1f
 z2KvL6rOY4iroPZS5qmbxEfwzBsmPob/GhfudJ/AB9jC8AHfA5LVlooDVCOUyLKdsk
 d9eS+Z5pBVAGBxP7F7CuMyl50nBd4mXdkCGIy1ZyF0PPTuRoEKdwhw6zbtqWTqQDj+
 Fty2sdEBzVJK+0ondaXQiAvbuZlin6nDlZciMTCAJ6Cq3CdoVqD1tczciWAKrECyOr
 kxW0L4dnLPVX7OYsRy7gks/OmY/J8SvXHNCcXS7hnUa7j1CMxupYKg7eFHdiAvSkCX
 KqNZL6QqlrVuQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DAA0B17E027B;
 Thu, 25 Jun 2026 11:36:36 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:31 +0200
Subject: [PATCH v5 16/16] drm/panthor: Automate CSG IRQ processing at group
 unbind time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-16-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=6865;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=gYxm4e3QM3o7Kpw5Ldk1CoESPmXCJSG3hepoF5kKlRo=;
 b=zmc3xAI1oLHdXhVNE9tVcpqmsFuZ0yet49zc3DX6kvHf6NFFAevl44A9rIQiMJqTnOlUEpKF8
 2aviHOokC88AhMQ846YOBxinQ3eHa1WvfMRoZ8mj1W+gOL3ZgCZOV0W
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
 drivers/gpu/drm/panthor/panthor_sched.c | 182 +++++++++++++++-----------------
 1 file changed, 84 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 2a7cd88d012a..7f587e110ebd 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -989,87 +989,6 @@ group_get(struct panthor_group *group)
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
-	if (cancel_work(&group->tiler_oom_work))
-		group_put(group);
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
@@ -1980,6 +1899,89 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
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
+	if (cancel_work(&group->tiler_oom_work))
+		group_put(group);
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
@@ -2406,18 +2408,8 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 
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
@@ -3011,12 +3003,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
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

