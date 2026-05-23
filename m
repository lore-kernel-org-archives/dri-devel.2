Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48740CD5BAC
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 10:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8220C10E028;
	Sat, 23 May 2026 10:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YP8a5G7y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFD710E028
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bfxub8wI9wJW5oTaWjRFJziLCVjOdHIxtiFdmUYYo0I=; b=YP8a5G7yuuahLmgMMKyBJ209w9
 DTi0P7+z9yzLEC8tNX/ZnvAnhJ91ixOoCVnLkdTsoGhwZaFV0hkfSyArXgftiur8J+Mf5ly2SDDm0
 MSVpG1hlUBBhLN6ik/j9qSc1cibR5/lbwYcJgnb98M2JQfaIiRfgxqHksPcOBwzZ+JxAprwlAT0am
 yA77nabwcL3to84M5DG8d2jzh6YnyDs8RAK4zFdgoZ2KV6yfy/4UQKwMCwpq1n8aR8DfQwjHsQQL/
 534bignkd74jAgnDEoRxRPVSpEt6mX1GNqRcCufSHPBAmnAAYk9oT2G41fDLDUe257fYhwIQCEUS8
 1ODD6MSw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wQjsT-005hFP-KL; Sat, 23 May 2026 12:46:45 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
Subject: [RFC v2 2/2] drm/panthor: Use separate workqueue for DRM scheduler
Date: Sat, 23 May 2026 11:46:39 +0100
Message-ID: <20260523104639.61994-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
References: <20260522113817.11745-3-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

Currently an unordered workqueue is used for the DRM scheduler which means
its concurrency is externally managed, and given there is one scheduler
instance per userspace queue, that means workqueue management logic is
within its rights to spawn many kernel threads to submit their respective
jobs.

Problem there is that all run job callbacks are serialized on the device
global mutex, making the potential thread storm just causing lock
contention.

If we add a separate ordered workqueue for the DRM scheduler integration
we can avoid this problem, since the ordered property directly expresses
the nature of the submission backend implementation.

And considering the other user of this workqueue, the free job callback,
which is not globally serialized in this manner so could be thought to
potentially regress with this change, it should not be the case since
commit
a58f317c1ca0 ("drm/sched: Free all finished jobs at once")
made the DRM scheduler handle the cleanup of finished jobs more promptly.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>
---
v2:
 * Actually create an unordered wq.
 * Put back WQ_MEM_RECLAIM to sched->wq.
---
 drivers/gpu/drm/panthor/panthor_sched.c | 26 +++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 2bee1c92fb9e..f4dfd82ad8a8 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -147,13 +147,11 @@ struct panthor_scheduler {
 	struct panthor_device *ptdev;
 
 	/**
-	 * @wq: Workqueue used by our internal scheduler logic and
-	 * drm_gpu_scheduler.
+	 * @wq: Workqueue used by our internal scheduler logic.
 	 *
 	 * Used for the scheduler tick, group update or other kind of FW
 	 * event processing that can't be handled in the threaded interrupt
-	 * path. Also passed to the drm_gpu_scheduler instances embedded
-	 * in panthor_queue.
+	 * path.
 	 */
 	struct workqueue_struct *wq;
 
@@ -166,6 +164,14 @@ struct panthor_scheduler {
 	 */
 	struct workqueue_struct *heap_alloc_wq;
 
+	/**
+	 * @sched_wq: Workqueue used for the DRM scheduler.
+	 *
+	 * Workqueue used for drm_gpu_scheduler instances embedded in
+	 * panthor_queue.
+	 */
+	struct workqueue_struct *sched_wq;
+
 	/** @tick_work: Work executed on a scheduling tick. */
 	struct delayed_work tick_work;
 
@@ -3488,7 +3494,7 @@ group_create_queue(struct panthor_group *group,
 {
 	struct drm_sched_init_args sched_args = {
 		.ops = &panthor_queue_sched_ops,
-		.submit_wq = group->ptdev->scheduler->wq,
+		.submit_wq = group->ptdev->scheduler->sched_wq,
 		/*
 		 * The credit limit argument tells us the total number of
 		 * instructions across all CS slots in the ringbuffer, with
@@ -4078,6 +4084,9 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
 	if (sched->heap_alloc_wq)
 		destroy_workqueue(sched->heap_alloc_wq);
 
+	if (sched->sched_wq)
+		destroy_workqueue(sched->sched_wq);
+
 	for (prio = PANTHOR_CSG_PRIORITY_COUNT - 1; prio >= 0; prio--) {
 		drm_WARN_ON(ddev, !list_empty(&sched->groups.runnable[prio]));
 		drm_WARN_ON(ddev, !list_empty(&sched->groups.idle[prio]));
@@ -4168,12 +4177,13 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	 * allocate memory, and fail the tiling job if none of these
 	 * countermeasures worked.
 	 *
-	 * Set WQ_MEM_RECLAIM on sched->wq to unblock the situation when the
-	 * system is running out of memory.
+	 * Set WQ_MEM_RECLAIM on sched->wq and wq->sched_wq to unblock the
+	 * situation when the system is running out of memory.
 	 */
 	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
 	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	if (!sched->wq || !sched->heap_alloc_wq) {
+	sched->sched_wq = alloc_ordered_workqueue("panthor-drm-sched", WQ_MEM_RECLAIM);
+	if (!sched->wq || !sched->heap_alloc_wq || !sched->sched_wq) {
 		panthor_sched_fini(&ptdev->base, sched);
 		drm_err(&ptdev->base, "Failed to allocate the workqueues");
 		return -ENOMEM;
-- 
2.54.0

