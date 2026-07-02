Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F62C44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F3B10F382;
	Thu,  2 Jul 2026 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ju6gyLj8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4573110F382
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QW16BdB0NI73630QIqQYdn3GMDFiBp7/v0i3a1NtrXI=; b=Ju6gyLj8jgErca4pRsO+wZjsJl
 bga3NQyBO1moyspUqWIKgh5ufoxKCESbU5R//EqUwPMY0hOivgL0OsfcQud5UM1V9bF0wW8/Zd3jh
 /lnlx0VITintCcHGGNgYhBx2B6XUbD8YlHLAeJipmoDv9oGM9CzJ55FbEw6IRWTg+j8a7E51daRBL
 9oouQYbAJvqeSBhe4QZpyp242k84wQNADcBgD9v9xTvhniWS/v52qN4IFESA8RavjIFUmZoWOo0G2
 9PCu7AaWUUZ+PBJAeze1vzfmq4SJ75Mb4ZLNKTLWuDlEKAK6iCj2rkTXH8n/VJCWQUsetr/FfpfXP
 uk7aQcJw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYF-0084Y6-BW; Thu, 02 Jul 2026 16:38:03 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 8/8] drm/sched: Notify worker of the entity submission priority
Date: Thu,  2 Jul 2026 15:37:45 +0100
Message-ID: <20260702143745.79293-9-tvrtko.ursulin@igalia.com>
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

Entities are required to track the CPU scheduling priority of the most
recent submitter and upon a change notify the drm_sched_worker associated
with the current scheduler of this change.

Worker is then able to keep correct count of the number of active
submitters per priority level and activate priority inheritance.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  3 ++
 drivers/gpu/drm/scheduler/sched_rq.c     | 61 +++++++++++++++++++++++-
 include/drm/gpu_scheduler.h              |  3 ++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index c51101ec70c1..7b6635e59afc 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -148,6 +148,9 @@ int drm_sched_entity_init(struct drm_sched_entity *entity,
 	atomic_set(&entity->fence_seq, 0);
 	entity->fence_context = dma_fence_context_alloc(2);
 
+	spin_lock_init(&entity->sched_attr_lock);
+	entity->sched_attr.size = sizeof(entity->sched_attr);
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_sched_entity_init);
diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index 2645bee960bd..1fe0ce468628 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -94,7 +94,7 @@ static void update_work(struct work_struct *work)
 		sched_setattr_nocheck(worker->worker[i]->task, &attr);
 }
 
-static void __maybe_unused
+static void
 drm_sched_worker_update_priority(struct drm_sched_worker *worker,
 				 const struct sched_attr *old_attr,
 				 const struct sched_attr *new_attr)
@@ -380,6 +380,43 @@ static ktime_t drm_sched_entity_update_vruntime(struct drm_sched_entity *entity)
 	return runtime;
 }
 
+static bool update_current_sched_attr(struct drm_sched_entity *entity,
+				      struct sched_attr *old_attr,
+				      struct sched_attr *new_attr)
+{
+	bool updated = false;
+
+	memset(new_attr, 0, sizeof(*new_attr));
+	new_attr->size = sizeof(*new_attr);
+	new_attr->sched_policy = current->policy;
+	/* QQQ? */
+	switch (new_attr->sched_policy) {
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
+		new_attr->sched_nice = task_nice(current);
+		break;
+	case SCHED_FIFO:
+	case SCHED_RR:
+		new_attr->sched_priority = current->rt_priority;
+		break;
+	case SCHED_DEADLINE:
+		new_attr->sched_runtime  = current->dl.dl_runtime;
+		new_attr->sched_deadline = current->dl.dl_deadline;
+		new_attr->sched_period   = current->dl.dl_period;
+		break;
+	}
+
+	spin_lock(&entity->sched_attr_lock);
+	if (memcmp(new_attr, &entity->sched_attr, sizeof(*new_attr))) {
+		memcpy(old_attr, &entity->sched_attr, sizeof(*new_attr));
+		memcpy(&entity->sched_attr, new_attr, sizeof(*new_attr));
+		updated = true;
+	}
+	spin_unlock(&entity->sched_attr_lock);
+
+	return updated;
+}
+
 /**
  * drm_sched_rq_add_entity - add an entity
  * @entity: scheduler entity
@@ -392,10 +429,14 @@ static ktime_t drm_sched_entity_update_vruntime(struct drm_sched_entity *entity)
 struct drm_gpu_scheduler *
 drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 {
+	struct sched_attr attr_old, attr_new;
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_rq *rq;
+	bool update;
 	ktime_t ts;
 
+	update = update_current_sched_attr(entity, &attr_old, &attr_new);
+
 	/* Add the entity to the run queue */
 	spin_lock(&entity->lock);
 	if (entity->stopped) {
@@ -407,6 +448,15 @@ drm_sched_rq_add_entity(struct drm_sched_entity *entity)
 
 	rq = entity->rq;
 	sched = container_of(rq, typeof(*sched), rq);
+
+	/*
+	 * Calling from ->add_entity() will miss priority updates if the entity
+	 * never transitions the queue from busy to idle but for now this is
+	 * good enough.
+	 */
+	if (update)
+		drm_sched_worker_update_priority(sched->submit_worker,
+						 &attr_old, &attr_new);
 	spin_lock(&rq->lock);
 
 	if (list_empty(&entity->list)) {
@@ -476,11 +526,20 @@ void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
 		ts = drm_sched_entity_update_vruntime(entity);
 		drm_sched_rq_update_tree_locked(entity, rq, ts);
 	} else {
+		struct drm_gpu_scheduler *sched;
 		ktime_t min_vruntime;
 
 		drm_sched_rq_remove_tree_locked(entity, rq);
 		min_vruntime = drm_sched_rq_get_min_vruntime(rq);
 		drm_sched_entity_save_vruntime(entity, min_vruntime);
+
+		sched = container_of(rq, typeof(*sched), rq);
+		spin_lock(&entity->sched_attr_lock);
+		drm_sched_worker_update_priority(sched->submit_worker,
+						 &entity->sched_attr, NULL);
+		memset(&entity->sched_attr, 0, sizeof(entity->sched_attr));
+		entity->sched_attr.size = sizeof(entity->sched_attr);
+		spin_unlock(&entity->sched_attr_lock);
 	}
 	spin_unlock(&rq->lock);
 	spin_unlock(&entity->lock);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 68e1cff9fe42..2f087a91d2e1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -31,6 +31,7 @@
 #include <linux/kthread.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/sched/types.h>
 
 DECLARE_EWMA(drm_sched_avgtime, 6, 4);
 
@@ -356,6 +357,8 @@ struct drm_sched_entity {
 	 */
 	struct rb_node			rb_tree_node;
 
+	spinlock_t 		sched_attr_lock;
+	struct sched_attr	sched_attr;
 };
 
 /**
-- 
2.54.0

