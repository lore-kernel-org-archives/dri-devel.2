Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01405C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4897110F3EB;
	Thu,  2 Jul 2026 14:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qRCla6+u";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEBB10F38B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QR/fsnfb/WAlpb76yKdpguH80atHN5QQObuiqg9b1qU=; b=qRCla6+up/XYUOvube0RGma+3D
 FVtKkgqDOoQBOz5VSStYe7egQ79txLnJgL+fQuTEEZpnr4Zpc7yWs5B60o5OAR70UaFg8DCtYCpWN
 16YKAa3D2+PQ5M4zg/6Dx99k4nxqoW1LgYrk0YBNydApaZbnTRJK3rkjHiX8vu2uQ2SyiSQLiXmYp
 pS8+9c1bn0BgzX3TD9TaFtovi5v9nF471tKHchSg7DhcOsFnRKIC5PCOkPpcO17hMYyrOBpT/igQl
 bl2Lw2Y6iFmcUDcOXM37CcFiAhZGws4O/MGkcPGSSBsx2L22ACZWyiY/ZiXZWMcSgrsM4Ffw5lA57
 XgVbhe5g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYE-0084Xr-MI; Thu, 02 Jul 2026 16:38:02 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 7/8] drm/sched: Add ability to change drm_sched_worker priority
Date: Thu,  2 Jul 2026 15:37:44 +0100
Message-ID: <20260702143745.79293-8-tvrtko.ursulin@igalia.com>
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

Add internal API by which DRM scheduler is able to notify the worker of
the appropriate CPU scheduling priority to use.

Design is such that the entities will be calling into
drm_sched_worker_update_priority() providing their previous and current
scheduling attributes, and internal logic would keep a count of active
entities per priority level, together with the time stamp of when each
priority was requested.

This allows multiple entities (or schedulers) to share the worker, which
will then temporarily elevate its priority to the highest currently active
entity. When high priority submitter becomes idle, the worker priority is
lowered after a grace period.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_rq.c | 143 +++++++++++++++++++++++++++
 include/drm/gpu_scheduler.h          |  25 ++++-
 2 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 044546bcb5f8..2645bee960bd 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -3,12 +3,155 @@
 /* Copyright (c) 2025 Valve Corporation */
 
 #include <linux/rbtree.h>
+#include <uapi/linux/sched/types.h>
+#include <linux/sched.h>
 
 #include <drm/drm_print.h>
 #include <drm/gpu_scheduler.h>
 
 #include "sched_internal.h"
 
+static bool drm_sched_attr_is_high(const struct sched_attr *attr)
+{
+	return attr->sched_policy == SCHED_NORMAL && attr->sched_nice < 0;
+}
+
+static bool drm_sched_attr_is_rt(const struct sched_attr *attr)
+{
+	return attr->sched_policy == SCHED_FIFO ||
+	       attr->sched_policy == SCHED_RR;
+}
+
+static unsigned long
+drm_sched_prio_active(struct drm_sched_worker *worker,
+		      enum drm_sched_worker_priority prio,
+		      unsigned long now)
+{
+	unsigned long end;
+
+	if (!worker->requested[prio])
+		return 0;
+
+	end = worker->requested_at[prio] + HZ;
+
+	return time_before(now, end) ? end - now : 0;
+}
+
+static void update_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct drm_sched_worker *worker =
+		container_of(delayed_work, typeof(*worker), update_work);
+	struct sched_attr attr = {
+		.size = sizeof(attr),
+	};
+	enum drm_sched_worker_priority prio;
+	const unsigned long now = jiffies;
+	unsigned long requeue = 0;
+	bool update;
+	size_t i;
+
+	spin_lock(&worker->lock);
+
+	for (prio = DRM_SCHED_WORKER_RT;
+	     prio > DRM_SCHED_WORKER_NORMAL;
+	     prio--) {
+		requeue = drm_sched_prio_active(worker, prio, now);
+		if (requeue)
+			break;
+	}
+
+	update = prio != worker->applied_priority;
+	worker->applied_priority = prio;
+
+	spin_unlock(&worker->lock);
+
+	if (requeue)
+		queue_delayed_work(system_percpu_wq, &worker->update_work,
+				   requeue);
+
+	if (!update)
+		return;
+
+	switch (prio) {
+	case DRM_SCHED_WORKER_RT:
+		attr.sched_policy = SCHED_FIFO;
+		attr.sched_priority = 1;
+	break;
+	case DRM_SCHED_WORKER_HIGH:
+		attr.sched_policy = SCHED_NORMAL;
+		attr.sched_nice = MIN_NICE;
+	break;
+	case DRM_SCHED_WORKER_NORMAL:
+		attr.sched_policy = SCHED_NORMAL;
+	break;
+	case DRM_SCHED_WORKER_NUM_PRIORITIES:
+	default:
+		/* ... */
+	};
+
+	for (i = 0; i < worker->num; i++)
+		sched_setattr_nocheck(worker->worker[i]->task, &attr);
+}
+
+static void __maybe_unused
+drm_sched_worker_update_priority(struct drm_sched_worker *worker,
+				 const struct sched_attr *old_attr,
+				 const struct sched_attr *new_attr)
+{
+	enum drm_sched_worker_priority old_prio = DRM_SCHED_WORKER_NORMAL;
+	enum drm_sched_worker_priority new_prio = DRM_SCHED_WORKER_NORMAL;
+	enum drm_sched_worker_priority prio;
+
+	if (old_attr) {
+		if (drm_sched_attr_is_rt(old_attr))
+			old_prio = DRM_SCHED_WORKER_RT;
+		else if (drm_sched_attr_is_high(old_attr))
+			old_prio = DRM_SCHED_WORKER_HIGH;
+	}
+
+	if (new_attr) {
+		if (drm_sched_attr_is_rt(new_attr))
+			new_prio = DRM_SCHED_WORKER_RT;
+		else if (drm_sched_attr_is_high(new_attr))
+			new_prio = DRM_SCHED_WORKER_HIGH;
+	}
+
+	if (old_prio == new_prio)
+		return;
+
+	spin_lock(&worker->lock);
+
+	if (old_prio == DRM_SCHED_WORKER_RT)
+		worker->num_rt--;
+	else if (old_prio == DRM_SCHED_WORKER_HIGH)
+		worker->num_high--;
+
+	if (new_prio == DRM_SCHED_WORKER_RT)
+		worker->num_rt++;
+	else if (new_prio == DRM_SCHED_WORKER_HIGH)
+		worker->num_high++;
+
+	if (worker->num_rt > worker->num_high)
+		prio = DRM_SCHED_WORKER_RT;
+	else if (worker->num_high)
+		prio = DRM_SCHED_WORKER_HIGH;
+	else
+		prio = DRM_SCHED_WORKER_NORMAL;
+
+	worker->requested[prio] = true;
+	worker->requested_at[prio] = jiffies;
+
+	if (unlikely(!worker->work_initialized)) {
+		INIT_DELAYED_WORK(&worker->update_work, update_work);
+		worker->work_initialized = true;
+	}
+
+	spin_unlock(&worker->lock);
+
+	queue_delayed_work(system_percpu_wq, &worker->update_work, 0);
+}
+
 static __always_inline bool
 drm_sched_entity_compare_before(struct rb_node *a, const struct rb_node *b)
 {
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 37e824d9483e..68e1cff9fe42 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -78,10 +78,25 @@ enum drm_sched_priority {
 
 struct drm_sched_entity_stats;
 
+enum drm_sched_worker_priority {
+	DRM_SCHED_WORKER_NORMAL = 0,
+	DRM_SCHED_WORKER_HIGH,
+	DRM_SCHED_WORKER_RT,
+	DRM_SCHED_WORKER_NUM_PRIORITIES,
+};
+
 struct drm_sched_worker {
-	unsigned int 		num;
-	atomic_t 		last;
-	struct kthread_worker	*worker[4];
+	spinlock_t			lock;
+	bool				requested[DRM_SCHED_WORKER_NUM_PRIORITIES];
+	unsigned long			requested_at[DRM_SCHED_WORKER_NUM_PRIORITIES];
+	enum drm_sched_worker_priority	applied_priority;
+	unsigned int			num_high;
+	unsigned int			num_rt;
+	bool				work_initialized;
+	unsigned int 			num;
+	atomic_t 			last;
+	struct delayed_work		update_work;
+	struct kthread_worker		*worker[4];
 };
 
 enum drm_sched_work_state {
@@ -106,6 +121,8 @@ struct drm_sched_work {
 	if (worker_) { \
 		atomic_set(&worker_->last, 0); \
 		worker_->num = 1; \
+		spin_lock_init(&worker_->lock); \
+		worker_->applied_priority = DRM_SCHED_WORKER_NORMAL; \
 		worker_->worker[0] = kthread_run_worker(PF_MEMALLOC, (fmt), ## __VA_ARGS__); \
 		if (IS_ERR(worker_->worker)) { \
 			kfree(worker_); \
@@ -127,6 +144,8 @@ struct drm_sched_work {
 		cpus_ = num_possible_cpus(); \
 		BUILD_BUG_ON(!is_power_of_2(ARRAY_SIZE(worker_->worker))); \
 		worker_->num = roundup_pow_of_two(min_t(unsigned int, cpus_, ARRAY_SIZE(worker_->worker))); \
+		spin_lock_init(&worker_->lock); \
+		worker_->applied_priority = DRM_SCHED_WORKER_NORMAL; \
 		for (i_ = 0; i_ < worker_->num; i_++) { \
 			worker_->worker[i_] = kthread_run_worker(0, (fmt), ## __VA_ARGS__); \
 			if (IS_ERR(worker_->worker[i_])) { \
-- 
2.54.0

