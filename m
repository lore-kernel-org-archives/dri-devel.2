Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ACBCD4F35
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3663F10EA4E;
	Tue, 12 May 2026 11:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RNDLfhX/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ED210EA4C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585865;
 bh=REchwpGJ0fRHYnGCFCV85K4FIzboSiKvbKSEt7SzV28=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RNDLfhX/aAyXsibKQu2zCoKwLoL/vPYWqoH220WpXKaAcYtrigoqzj1120rj9++aG
 if3goDofRCVq0wle3kguBMgp23UM9nPQneECsSyMY1RetowSg0AmyUwT0HnF+kwuzx
 rvGCuT3qBU0eigYjbFGB5UiUICzRNKuKtFBnCFNt4cMGMkJ29X0I6DeDKPT8YcBkfC
 r9AjkG9nzN1FhWKPZu3QD84b/pEECfwbgo9Q7rtojWk8nthWydsBxGtcIYlt7uA239
 tRCKMc4uqjYm2SyvaJSeod4UCaAyS9Zm0MC5zSEtFf+vYbLpy9l5u7fn1WSfY4bfdl
 Rj88qC/A1odQA==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2735E17E38CB;
 Tue, 12 May 2026 13:37:45 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 12 May 2026 13:37:37 +0200
Subject: [PATCH v2 07/11] drm/panthor: Automate CSG IRQ processing at group
 unbind time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-panthor-signal-from-irq-v2-7-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=6632;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=REchwpGJ0fRHYnGCFCV85K4FIzboSiKvbKSEt7SzV28=;
 b=cuxpwt3ZyepDcbzOs8nJAQ0Wyc4bWXqRgt3VO+iEHgn0V3v9b25ugKURj+qPf7POrEdR2pkLQ
 9uaRwuDRoZ2DWpxrw31gfMlZUEDAnVWC7XHDTIbNOWeTa7k6gmFIAix
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

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 176 +++++++++++++++-----------------
 1 file changed, 82 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index fbf76b59b7ef..6c5ba747ae45 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -982,86 +982,6 @@ group_get(struct panthor_group *group)
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
-	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
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
-	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
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
@@ -1968,6 +1888,88 @@ void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events)
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
+	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
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
+	scoped_guard(spinlock_irqsave, &ptdev->scheduler->events_lock) {
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
@@ -2396,15 +2398,6 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 	/* Unbind evicted groups. */
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
 		list_for_each_entry(group, &ctx->old_groups[prio], run_node) {
-			/* This group is gone. Process interrupts to clear
-			 * any pending interrupts before we start the new
-			 * group.
-			 */
-			if (group->csg_id >= 0) {
-				guard(spinlock_irqsave)(&sched->events_lock);
-				sched_process_csg_irq_locked(ptdev, group->csg_id);
-			}
-
 			group_unbind_locked(group);
 		}
 	}
@@ -2988,11 +2981,6 @@ void panthor_sched_suspend(struct panthor_device *ptdev)
 
 		group_get(group);
 
-		if (group->csg_id >= 0) {
-			guard(spinlock_irqsave)(&sched->events_lock);
-			sched_process_csg_irq_locked(ptdev, group->csg_id);
-		}
-
 		group_unbind_locked(group);
 
 		drm_WARN_ON(&group->ptdev->base, !list_empty(&group->run_node));

-- 
2.54.0

