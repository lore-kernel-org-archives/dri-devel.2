Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974A7C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CF910F3E0;
	Thu,  2 Jul 2026 14:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IDEq+5nR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF2510E4F0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bEVvYJXV2/FUF1H8LQX6vbQdp87dnbDcBVXEa7KnZ8E=; b=IDEq+5nRJYvwXyjYNB3+DgdTVh
 Tqf+zGeSZJ+phkqGv9BC1RBtcuqVrPV5UHxeOkSzepPB3YcU9bLIyk9MT+idY3hVp+rTKBH/v5jsT
 xi2mSfC06BltATiwJUX9LkxVcX7h3xRSCu2s2NX8gE11UEcoUAuUNTcE4ZL7tgKvolz5R4H97mMoW
 rX0/iteesvlFhzQ55D7QABEcG1kPzmET4Cm7l+j3vUj13q/R+ZPki86PstezbjT8XDzXeQkRxbhY6
 KmIv8y619+Y93N+lsxgjaLA4T3to482gYNYGu5eHzS9Cnixb6ck6VZs5iJmjxj9Qm1Vk3r8rRJhW+
 cF0gNFRg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYD-0084Xm-VO; Thu, 02 Jul 2026 16:38:02 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 6/8] drm/sched: Convert the scheduler job submission to
 kthread_worker
Date: Thu,  2 Jul 2026 15:37:43 +0100
Message-ID: <20260702143745.79293-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
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

Convert the DRM scheduler to use kthread_work instead of a workqueue for
job submission.

Goal is to build a priority inversion avoidance scheme on top of the
kthread_work, and by doing so improve worst case latency of elevated
priority clients such as compositors ie. improve the smoothness of the
user interface. Or in other words, avoid an effective priority inversion
where high priority clients have their work processed by a normal priority
workqueues which compete with random background tasks.

As some DRM scheduler users create per userspace client workqueues we
implement a trivial round-robin kthread_worker pool with a small maximum
which can be improved upon later.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 80 +++++++++++++++++++++++++-
 include/drm/gpu_scheduler.h            | 75 +++++++++++++++++++-----
 2 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1e728838a4a2..fff908d0f4c7 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1246,7 +1246,85 @@ EXPORT_SYMBOL(drm_sched_job_is_signaled);
 
 void drm_sched_destroy_worker(struct drm_sched_worker *worker)
 {
-	destroy_workqueue(worker->worker);
+	unsigned int i;
+
+	for (i = 0; i < worker->num; i++) {
+		if (worker->worker[i])
+			kthread_destroy_worker(worker->worker[i]);
+	}
 	kfree(worker);
 }
 EXPORT_SYMBOL(drm_sched_destroy_worker);
+
+static void drm_sched_kworkfn(struct kthread_work *work_)
+{
+	struct drm_sched_work *work =
+		container_of(work_, typeof(*work), work);
+	unsigned long flags;
+
+	BUILD_BUG_ON(offsetof(struct drm_sched_work, work));
+
+	spin_lock_irqsave(&work->lock, flags);
+	work->state = DRM_SCHED_WORK_RUNNING;
+	spin_unlock_irqrestore(&work->lock, flags);
+
+	work->func(work);
+
+	spin_lock_irqsave(&work->lock, flags);
+	switch (work->state) {
+	case DRM_SCHED_WORK_MIGRATING:
+		/*
+		 * drm_sched_queue_work re-quested a re-queue while we were
+		 * running, and has potentially changed the assigned worker so
+		 * lets handle it.
+		 */
+		work->state = DRM_SCHED_WORK_QUEUED;
+		kthread_init_work(&work->work, drm_sched_kworkfn);
+		kthread_queue_work(work->worker, &work->work);
+		break;
+	default:
+		work->state = DRM_SCHED_WORK_IDLE;
+	};
+	spin_unlock_irqrestore(&work->lock, flags);
+}
+
+void drm_sched_queue_work(struct drm_sched_worker *worker,
+			  struct drm_sched_work *work)
+{
+	struct kthread_worker *kw;
+	unsigned long flags;
+	unsigned int i = 0;
+
+	if (worker->num > 1)
+		i = atomic_inc_return(&worker->last) & (worker->num - 1);
+
+	kw = worker->worker[i];
+
+	spin_lock_irqsave(&work->lock, flags);
+	switch (work->state) {
+	case DRM_SCHED_WORK_IDLE:
+		work->worker = kw;
+		work->state = DRM_SCHED_WORK_QUEUED;
+		kthread_init_work(&work->work, drm_sched_kworkfn);
+		kthread_queue_work(work->worker, &work->work);
+		break;
+	case DRM_SCHED_WORK_RUNNING:
+		/*
+		 * We must ensure only once instance of the work is running so
+		 * flag to change the worker and self re-queue from the worker
+		 * when it is safe to do so.
+		 */
+		work->worker = kw;
+		work->state = DRM_SCHED_WORK_MIGRATING;
+		break;
+	case DRM_SCHED_WORK_QUEUED:
+	case DRM_SCHED_WORK_MIGRATING:
+		/*
+		 * Do nothing if the work is already queued but not started yet,
+		 * or if self re-queue was already marked.
+		 */
+		break;
+	};
+	spin_unlock_irqrestore(&work->lock, flags);
+}
+EXPORT_SYMBOL(drm_sched_queue_work);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 391663360426..37e824d9483e 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -28,6 +28,7 @@
 #include <linux/average.h>
 #include <linux/dma-fence.h>
 #include <linux/completion.h>
+#include <linux/kthread.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
 
@@ -78,17 +79,34 @@ enum drm_sched_priority {
 struct drm_sched_entity_stats;
 
 struct drm_sched_worker {
-	struct workqueue_struct	*worker;
+	unsigned int 		num;
+	atomic_t 		last;
+	struct kthread_worker	*worker[4];
 };
 
-#define drm_sched_work work_struct
+enum drm_sched_work_state {
+	DRM_SCHED_WORK_IDLE = 0,
+	DRM_SCHED_WORK_QUEUED,
+	DRM_SCHED_WORK_RUNNING,
+	DRM_SCHED_WORK_MIGRATING,
+};
+
+struct drm_sched_work {
+	struct kthread_work		work;
+	spinlock_t			lock;
+	enum drm_sched_work_state	state;
+	struct kthread_worker		*worker;
+	void				(*func)(struct drm_sched_work *);
+};
 
 #define drm_sched_create_ordered_worker(fmt, ...) \
 ({ \
 	struct drm_sched_worker *worker_; \
-	worker_ = kmalloc_obj(typeof(*worker_)); \
+	worker_ = kzalloc_obj(typeof(*worker_)); \
 	if (worker_) { \
-		worker_->worker = alloc_ordered_workqueue((fmt), WQ_MEM_RECLAIM, ## __VA_ARGS__); \
+		atomic_set(&worker_->last, 0); \
+		worker_->num = 1; \
+		worker_->worker[0] = kthread_run_worker(PF_MEMALLOC, (fmt), ## __VA_ARGS__); \
 		if (IS_ERR(worker_->worker)) { \
 			kfree(worker_); \
 			worker_ = ERR_CAST(worker_->worker); \
@@ -102,12 +120,22 @@ struct drm_sched_worker {
 #define drm_sched_create_concurrent_worker(fmt, ...) \
 ({ \
 	struct drm_sched_worker *worker_; \
-	worker_ = kmalloc_obj(typeof(*worker_)); \
+	worker_ = kzalloc_obj(typeof(*worker_)); \
 	if (worker_) { \
-		worker_->worker = alloc_workqueue((fmt), WQ_UNBOUND, 0, ## __VA_ARGS__); \
-		if (IS_ERR(worker_->worker)) { \
-			kfree(worker_); \
-			worker_ = ERR_CAST(worker_->worker); \
+		size_t i_, cpus_; \
+		atomic_set(&worker_->last, 0); \
+		cpus_ = num_possible_cpus(); \
+		BUILD_BUG_ON(!is_power_of_2(ARRAY_SIZE(worker_->worker))); \
+		worker_->num = roundup_pow_of_two(min_t(unsigned int, cpus_, ARRAY_SIZE(worker_->worker))); \
+		for (i_ = 0; i_ < worker_->num; i_++) { \
+			worker_->worker[i_] = kthread_run_worker(0, (fmt), ## __VA_ARGS__); \
+			if (IS_ERR(worker_->worker[i_])) { \
+				int ret_ = PTR_ERR(worker_->worker[i_]); \
+				while (i_ > 0) \
+					kthread_destroy_worker(worker_->worker[--i_]); \
+				kfree(worker_); \
+				worker_ = ERR_PTR(ret_); \
+			} \
 		} \
 	} else { \
 		worker_ = ERR_PTR(-ENOMEM); \
@@ -117,11 +145,30 @@ struct drm_sched_worker {
 
 void drm_sched_destroy_worker(struct drm_sched_worker *worker);
 
-#define drm_sched_init_work		INIT_WORK
-#define drm_sched_queue_work(worker_, work_) \
-	queue_work((struct workqueue_struct *)(worker_), (work_))
-#define drm_sched_flush_work		flush_work
-#define drm_sched_cancel_work_sync	cancel_work_sync
+void drm_sched_queue_work(struct drm_sched_worker *worker,
+			  struct drm_sched_work *work);
+
+static inline void
+drm_sched_init_work(struct drm_sched_work *work,
+		    void (*func)(struct drm_sched_work *))
+{
+	work->state = DRM_SCHED_WORK_IDLE;
+	work->worker = NULL;
+	work->func = func;
+
+	spin_lock_init(&work->lock);
+}
+
+
+static inline void drm_sched_flush_work(struct drm_sched_work *work)
+{
+	kthread_flush_work(&work->work);
+}
+
+static inline bool drm_sched_cancel_work_sync(struct drm_sched_work *work)
+{
+	return kthread_cancel_work_sync(&work->work);
+}
 
 /**
  * struct drm_sched_entity - A wrapper around a job queue (typically
-- 
2.54.0

