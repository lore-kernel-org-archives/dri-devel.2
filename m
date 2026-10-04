Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED2FCA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDAD410EA56;
	Sun,  4 Oct 2026 15:42:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iaU7+ebA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C2C10EA63
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=iH4cPix+4PeS8SX+P1xZnkYEjhaX6dBLTAgF/w2nRzc=; b=iaU7+ebAdt8gS3hsd0X1mYxtmZ
 S6Gv51n1CzJ8iHVrJKexrKDjknsJiatCaopFFyBgE2zg3fTpGg3L6arJvVxs5PGyC+9+5sJIwbx0p
 Axuud5LbH66If7MtQ7tcXBe6MXcFu/B3jlqQmQjznliSVFKyzMWUuJX/ROloR6i9jL2Nvi0Ml6LG/
 Xbfvzcg4ICYK8ZoCsoMO6hJicLjyIrsYogHRb+UnH3u6r9NmZ/TTO+BhPOxzVmv/2BkPSa3sK+g03
 ifjch7ZvJeOUu6dEDhmsR9EKTI3J6CFwAAHLE73JFYosG6iys/47ZNKmiJjWQ5eaRrSCvhbgcrA3O
 F5xujRjg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMZ-00BNsh-B7; Sun, 04 Oct 2026 17:42:55 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:11 -0300
Subject: [PATCH 11/11] drm/vc4: Split out bin_alloc_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-11-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6331; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Untu7wtpvhNnqHerBaHaI8EQNcf8MO4VxuKLsF116dg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXyrtsyzbDQSuO8EcZVP4DoufbB4TdbHPHO
 PCfuzfZPXOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qjnjB/4hKERKUDq/Liz3KZGB7EwO6to3R4sdgldCKX5GBhSXQnXDtY7OeNgU9UbVKDLJe7IqgwF
 +Lr5PLRjGe22JmggnjMzB0Hs8aN62vLQFiGE06vmyH+6ict3TxFf6nmwW8lzJQEHfb145TcPBgy
 c/r52818b6T9dHkrOVAeoDoODJmPHOm/zcPRiWk/3iqwSVlcum5frO4TNkG8u9PxFrAUmNPHT5j
 kf03tpiDLPuhYU2GMv/FqdT+pP0wEXRwPLfeDUqrlEB84v9hc22E5B712BmZ+p678Ii6X5bCTCw
 Ajs1CuGlh+IqPaAbhwFGydw1CeOEjKhBcxeN0U03HbKzAL3F
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The binner slot pool, tracked by bin_alloc_used and bin_alloc_overflow,
is serialized by job_lock. The pool has a lifecycle of its own: slots are
claimed by bin_slot_try_alloc(), which the submit path retries from a
wait loop, and released from the render done handler, from
vc4_release_exec() and from the overflow worker. Each of those takes the
device-wide job lock to update the binner slot pool, contending the job
queues.

Give the pool its own spinlock. Note that, as vc4_irq_finish_render_job()
frees the finished job's slots and vc4_overflow_mem_work() hand slots over
to a queued job, they hold both locks, nesting bin_alloc_lock inside
job_lock. However, nothing takes them in the other order.

That leaves vc4_overflow_mem_work() holding job_lock over the binner
overflow registers, which it never needed, as the only other writers of
V3D_BPOA and V3D_BPOS are the bind and unbind paths, which run with the
interrupt uninstalled. Write to them once the lock is dropped.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  3 +++
 drivers/gpu/drm/vc4/vc4_gem.c |  7 +++----
 drivers/gpu/drm/vc4/vc4_irq.c | 46 ++++++++++++++++++++++---------------------
 drivers/gpu/drm/vc4/vc4_v3d.c |  2 +-
 4 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index c6ae54d2e8b8..e2cc5bb78791 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -204,6 +204,9 @@ struct vc4_dev {
 	/* Size of blocks allocated within bin_bo. */
 	uint32_t bin_alloc_size;
 
+	/* Protects @bin_alloc_used and @bin_alloc_overflow. */
+	spinlock_t bin_alloc_lock;
+
 	/* Bitmask of the bin_alloc_size chunks in bin_bo that are
 	 * used.
 	 */
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 230558b3f684..09aaa1b796ad 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -846,7 +846,6 @@ vc4_release_exec(struct kref *ref)
 	struct vc4_exec_info *exec = container_of(ref, struct vc4_exec_info,
 						  refcount);
 	struct vc4_dev *vc4 = exec->dev;
-	unsigned long irqflags;
 	unsigned i;
 
 	/* The render done handler signals the fence, so only drop the
@@ -875,9 +874,8 @@ vc4_release_exec(struct kref *ref)
 	 * completion had their slots released in vc4_irq_finish_render_job().
 	 * Only jobs that never completed still have slots to be released here.
 	 */
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
-	vc4->bin_alloc_used &= ~exec->bin_slots;
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	scoped_guard(spinlock_irqsave, &vc4->bin_alloc_lock)
+		vc4->bin_alloc_used &= ~exec->bin_slots;
 
 	/* Let anyone waiting on the binner pool retry. */
 	wake_up_all(&vc4->job_wait_queue);
@@ -1176,6 +1174,7 @@ int vc4_gem_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&vc4->render_job_list);
 	INIT_LIST_HEAD(&vc4->job_done_list);
 	spin_lock_init(&vc4->job_lock);
+	spin_lock_init(&vc4->bin_alloc_lock);
 	spin_lock_init(&vc4->hang_state_lock);
 	spin_lock_init(&vc4->perfmon_state.lock);
 
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index f8787d4169ef..2f3f6fbcedf3 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -64,8 +64,6 @@ vc4_overflow_mem_work(struct work_struct *work)
 		container_of(work, struct vc4_dev, overflow_mem_work);
 	struct vc4_bo *bo;
 	int bin_bo_slot;
-	struct vc4_exec_info *exec;
-	unsigned long irqflags;
 
 	mutex_lock(&vc4->bin_bo_lock);
 
@@ -80,34 +78,37 @@ vc4_overflow_mem_work(struct work_struct *work)
 		goto complete;
 	}
 
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
+	scoped_guard(spinlock_irqsave, &vc4->job_lock) {
+		struct vc4_exec_info *exec;
 
-	if (vc4->bin_alloc_overflow) {
-		/* If we had overflow memory allocated previously,
-		 * then that chunk will free when the current bin job
-		 * is done.  If we don't have a bin job running, then
-		 * the chunk will be done whenever the list of render
-		 * jobs has drained.
-		 */
-		exec = vc4_first_bin_job(vc4);
-		if (!exec)
-			exec = vc4_last_render_job(vc4);
-		if (exec) {
-			exec->bin_slots |= vc4->bin_alloc_overflow;
-		} else {
-			/* There's nothing queued in the hardware, so
-			 * the old slot is free immediately.
+		guard(spinlock)(&vc4->bin_alloc_lock);
+
+		if (vc4->bin_alloc_overflow) {
+			/* If we had overflow memory allocated previously,
+			 * then that chunk will free when the current bin job
+			 * is done.  If we don't have a bin job running, then
+			 * the chunk will be done whenever the list of render
+			 * jobs has drained.
 			 */
-			vc4->bin_alloc_used &= ~vc4->bin_alloc_overflow;
+			exec = vc4_first_bin_job(vc4);
+			if (!exec)
+				exec = vc4_last_render_job(vc4);
+			if (exec) {
+				exec->bin_slots |= vc4->bin_alloc_overflow;
+			} else {
+				/* There's nothing queued in the hardware, so
+				 * the old slot is free immediately.
+				 */
+				vc4->bin_alloc_used &= ~vc4->bin_alloc_overflow;
+			}
 		}
+		vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 	}
-	vc4->bin_alloc_overflow = BIT(bin_bo_slot);
 
 	V3D_WRITE(V3D_BPOA, bo->base.dma_addr + bin_bo_slot * vc4->bin_alloc_size);
 	V3D_WRITE(V3D_BPOS, vc4->bin_alloc_size);
 	V3D_WRITE(V3D_INTCTL, V3D_INT_OUTOMEM);
 	V3D_WRITE(V3D_INTENA, V3D_INT_OUTOMEM);
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
 complete:
 	mutex_unlock(&vc4->bin_bo_lock);
@@ -165,7 +166,8 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 
 	vc4->finished_seqno++;
 
-	vc4->bin_alloc_used &= ~exec->bin_slots;
+	scoped_guard(spinlock, &vc4->bin_alloc_lock)
+		vc4->bin_alloc_used &= ~exec->bin_slots;
 	exec->bin_slots = 0;
 
 	list_move_tail(&exec->head, &vc4->job_done_list);
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index 8a3c90136506..b4bb90765795 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -177,7 +177,7 @@ static int bin_slot_try_alloc(struct vc4_dev *vc4)
 {
 	int slot;
 
-	guard(spinlock_irqsave)(&vc4->job_lock);
+	guard(spinlock_irqsave)(&vc4->bin_alloc_lock);
 
 	slot = ffs(~vc4->bin_alloc_used);
 	if (slot != 0) {

-- 
2.55.0

