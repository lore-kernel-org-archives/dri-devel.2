Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8DDCA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B9D10E5F5;
	Wed, 30 Sep 2026 18:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XSbfMQbc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF8610E5F5
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=nX19E66SJVMW2YaeRl0yu31vE3yeeTemSge1jphkEd4=; b=XSbfMQbcGCM8R9j0MtlPYXptcB
 JBonWElbCN9XhOJ+5S5Kkcsw1xCFBhfK0FDvyI1uWdJ79VtPob5ed2EdfyobM96CEs7KHW10bDPKf
 1+tyo0/qj351lGPLDi4U5IeF0hwU2/1A22l7EKnSK4FNoAHL2AHnL4h1g1m+s/ozc3eN66/oc3csB
 OtETAPDzMkZsBebx8O/J34hJGjE1iLe7IsTN4yf097IuS2KN8nVwYQz/Ud5zshthOnHXF75w2sZJn
 lM1C9jDpFWeqkmH/10cwmABmv7K6d/69PGKcs/uERq5sKd05VgIKJ2HrJfSsCY5B3U5o0zjbjEZrx
 3xLZzmag==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xBywc-009Yzs-QJ; Wed, 30 Sep 2026 20:22:19 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/vc4: Fix binner slot allocation failing on an idle GPU
Date: Wed, 30 Sep 2026 15:20:44 -0300
Message-ID: <20260930182204.1877361-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A job's binner slots are returned to bin_alloc_used by vc4_complete_exec(),
which runs from the job_done workqueue, but the seqno
vc4_v3d_get_bin_slot() waits on is incremented earlier, in the function
vc4_irq_finish_render_job(). Therefore, a waiter can wake, retry, and still
find the pool full because the worker has not run. By then, the job might
have left the render_job_list, so no seqno remains to wait on and the
allocation fails returning -ENOMEM.

This scenario can be reproduced on a Raspberry Pi 3 by using a burst of
small jobs (e.g. Piglit's `quick_gl` suite), with userspace seeing a
rejected submit for a pool about to become free.

Note that the slots are held from validation until the render completes,
so the pool can also be exhausted by jobs still queued on bin_job_list,
leaving render_job_list empty and nothing to wait on.

Release the slots from the FRDONE handler and wait on the pool instead of
on one job's seqno. This bounds the wait to the actual resource. Also, by
claiming the slot inside the wait condition, another submit is unable to
take the slot between the wakeup and the retry. vc4_complete_exec() keeps
clearing the slots for jobs that never completed, and now wakes the
waiters too.

Note that the wait takes a deadline, since the two callers need different
ones. The submit path is a user task and can be interrupted, so it waits
without one. On the other hand, vc4_overflow_mem_work() runs on a worker
and never sees a signal, so it needs a deadline. During a reset,
vc4_irq_disable() masks V3D_DRIVER_IRQS before draining the worker, and
with those masked nothing can release a slot. This deadlocks: the worker
would wait for slots that only the reset can free, while the reset waits
in cancel_work_sync() for the worker.

Fixes: 553c942f8b2c ("drm/vc4: Allow using more than 256MB of CMA memory.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h      |  2 +-
 drivers/gpu/drm/vc4/vc4_gem.c      |  8 +++++-
 drivers/gpu/drm/vc4/vc4_irq.c      |  6 +++-
 drivers/gpu/drm/vc4/vc4_v3d.c      | 44 ++++++++++++++----------------
 drivers/gpu/drm/vc4/vc4_validate.c |  2 +-
 5 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 695bc6a29d30..09134809bf15 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -1053,7 +1053,7 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 /* vc4_v3d.c */
 extern struct platform_driver vc4_v3d_driver;
 extern const struct of_device_id vc4_v3d_dt_match[];
-int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
+int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, long timeout);
 int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used);
 void vc4_v3d_bin_bo_put(struct vc4_dev *vc4);
 int vc4_v3d_pm_get(struct vc4_dev *vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 3212b9167620..356d7bb7f46a 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -889,11 +889,17 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 		drm_gem_object_put(&bo->base.base);
 	}
 
-	/* Free up the allocation of any bin slots we used. */
+	/* Free up the allocation of any bin slots we used. Jobs that ran to
+	 * completion had their slots released in vc4_irq_finish_render_job().
+	 * Only jobs that never completed still have slots to be released here.
+	 */
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	vc4->bin_alloc_used &= ~exec->bin_slots;
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	/* Let anyone waiting on the binner pool retry. */
+	wake_up_all(&vc4->job_wait_queue);
+
 	/* Release the reference on the binner BO if needed. */
 	if (exec->bin_bo_used)
 		vc4_v3d_bin_bo_put(vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 3a3ea1e62dcb..e44ff996eaac 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -74,7 +74,7 @@ vc4_overflow_mem_work(struct work_struct *work)
 
 	bo = vc4->bin_bo;
 
-	bin_bo_slot = vc4_v3d_get_bin_slot(vc4);
+	bin_bo_slot = vc4_v3d_get_bin_slot(vc4, msecs_to_jiffies(500));
 	if (bin_bo_slot < 0) {
 		drm_err(&vc4->base, "Couldn't allocate binner overflow mem\n");
 		goto complete;
@@ -165,6 +165,10 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 	trace_vc4_rcl_end_irq(dev, exec->seqno);
 
 	vc4->finished_seqno++;
+
+	vc4->bin_alloc_used &= ~exec->bin_slots;
+	exec->bin_slots = 0;
+
 	list_move_tail(&exec->head, &vc4->job_done_list);
 
 	nextbin = vc4_first_bin_job(vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index b40d98c9d1d2..3b0b01820c97 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -152,46 +152,42 @@ void vc4_v3d_init_hw(struct drm_device *dev)
 	V3D_WRITE(V3D_VPMBASE, 0);
 }
 
-int vc4_v3d_get_bin_slot(struct vc4_dev *vc4)
+static int bin_slot_try_alloc(struct vc4_dev *vc4)
 {
-	struct drm_device *dev = &vc4->base;
-	unsigned long irqflags;
 	int slot;
-	uint64_t seqno = 0;
-	struct vc4_exec_info *exec;
 
-	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
-		return -ENODEV;
+	guard(spinlock_irqsave)(&vc4->job_lock);
 
-try_again:
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	slot = ffs(~vc4->bin_alloc_used);
 	if (slot != 0) {
 		/* Switch from ffs() bit index to a 0-based index. */
 		slot--;
 		vc4->bin_alloc_used |= BIT(slot);
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
-		return slot;
+	} else {
+		slot = -ENOMEM;
 	}
 
-	/* Couldn't find an open slot.  Wait for render to complete
-	 * and try again.
-	 */
-	exec = vc4_last_render_job(vc4);
-	if (exec)
-		seqno = exec->seqno;
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	return slot;
+}
 
-	if (seqno) {
-		int ret = vc4_wait_for_seqno(dev, seqno, ~0ull, true);
+int vc4_v3d_get_bin_slot(struct vc4_dev *vc4, long timeout)
+{
+	int slot;
+	long ret;
 
-		if (ret == 0)
-			goto try_again;
+	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
+		return -ENODEV;
 
+	/* If the pool is full, wait for a job to release its slots. */
+	ret = wait_event_interruptible_timeout(vc4->job_wait_queue,
+					       (slot = bin_slot_try_alloc(vc4)) >= 0,
+					       timeout);
+	if (ret < 0)
 		return ret;
-	}
+	if (ret == 0)
+		return -ENOMEM;
 
-	return -ENOMEM;
+	return slot;
 }
 
 /*
diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index d2a65c968b1f..565227657b43 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -402,7 +402,7 @@ validate_tile_binning_config(VALIDATE_ARGS)
 		return -EINVAL;
 	}
 
-	bin_slot = vc4_v3d_get_bin_slot(vc4);
+	bin_slot = vc4_v3d_get_bin_slot(vc4, MAX_SCHEDULE_TIMEOUT);
 	if (bin_slot < 0) {
 		if (bin_slot != -EINTR && bin_slot != -ERESTARTSYS) {
 			drm_err(dev, "Failed to allocate binner memory: %d\n",
-- 
2.55.0

