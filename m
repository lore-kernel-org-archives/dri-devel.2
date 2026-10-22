Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09BE60A260D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=i3iEehNH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5197C112438;
	Thu, 22 Oct 2026 09:39:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37EAF112437
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=d/esycuTb9nfJgABmuNcc5M22++wxUVlqxX/q/QqJUE=; b=
 i3iEehNH+Ev9jFhoCSTTS9zlu2nHb8rrximAqBTq4jga8NdQPV21sWgijSKxPoVtmftCQ6VoBksmA
 v/M0Ah1x2+LhqmSlrSkgfgQNn1S+UY9T9m/zTX8hZHyVD1aB34gAWGYkp2nh8jKPAske9e2v/hvCn
 ezX/AlargJofR9htYM3jLTAttDoznjd6ooD4ajcHOP86L8iVsQKXUoJneU9NoU24h0cLlvgKHXoMo
 1ZobIVbzp1Z7kmZRYOJUvMQXZKJQWo0JztvUhUwVbIWCBPCTNwW0UkVNbJyeD0tG7JkTaODszTVmO
 qzOr2tm1K9i2BZsGS5vy7DK0iLzjWBiHYA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJpG9-006ers-5z; Thu, 22 Oct 2026 11:38:53 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v7 4/4] drm/panthor: Create per queue priority workqueues
Date: Thu, 22 Oct 2026 10:38:48 +0100
Message-ID: <20261022093848.5727-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Split the single workqueue shared between the driver internal logic and
DRM scheduler use into separate ones, where the DRM scheduler one is
created per GPU priority level using the appropriate mapping to
workqueue priorities.

Low and medium GPU priority are served by a normal workqueue,
high is server by a WQ_HIGHPRI instance, while realtime GPU priority is
using the newly added WQ_RTPRI flag for lowest possible latency.

These workqueues are device global and for all three we set the maximum
concurrency to two in order to keep the GPU optimally fed with work.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 37 ++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..257895e5e48b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -152,11 +152,18 @@ struct panthor_scheduler {
 	 *
 	 * Used for the scheduler tick, group update or other kind of FW
 	 * event processing that can't be handled in the threaded interrupt
-	 * path. Also passed to the drm_gpu_scheduler instances embedded
-	 * in panthor_queue.
+	 * path.
 	 */
 	struct workqueue_struct *wq;
 
+	/**
+	 * @submit_wq: Per priority workqueues for the DRM scheduler
+	 *
+	 * Passed to the drm_gpu_scheduler instances embedded
+	 * in panthor_queue based on the queue priority.
+	 */
+	struct workqueue_struct *submit_wq[PANTHOR_CSG_PRIORITY_COUNT];
+
 	/**
 	 * @heap_alloc_wq: Workqueue used to schedule tiler_oom works.
 	 *
@@ -3582,8 +3589,14 @@ group_create_queue(struct panthor_group *group,
 		goto err_free_queue;
 	}
 
+	if (group->priority >= ARRAY_SIZE(group->ptdev->scheduler->submit_wq) ||
+	    !group->ptdev->scheduler->submit_wq[group->priority]) {
+		ret = -EINVAL;
+		goto err_free_queue;
+	}
+
 	sched_args.name = queue->name;
-
+	sched_args.submit_wq = group->ptdev->scheduler->submit_wq[group->priority];
 	ret = drm_sched_init(&queue->scheduler, &sched_args);
 	if (ret)
 		goto err_free_queue;
@@ -4073,6 +4086,15 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
 	if (!sched || !sched->csg_slot_count)
 		return;
 
+	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM])
+		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM]);
+
+	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH])
+		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH]);
+
+	if (sched->submit_wq[PANTHOR_CSG_PRIORITY_RT])
+		destroy_workqueue(sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]);
+
 	if (sched->wq)
 		destroy_workqueue(sched->wq);
 
@@ -4174,7 +4196,14 @@ int panthor_sched_init(struct panthor_device *ptdev)
 	 */
 	sched->heap_alloc_wq = alloc_workqueue("panthor-heap-alloc", WQ_UNBOUND, 0);
 	sched->wq = alloc_workqueue("panthor-csf-sched", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
-	if (!sched->wq || !sched->heap_alloc_wq) {
+	sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] = alloc_workqueue("panthor-drm", WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
+	sched->submit_wq[PANTHOR_CSG_PRIORITY_LOW] = sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM];
+	sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] = alloc_workqueue("panthor-drm-high", WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
+	sched->submit_wq[PANTHOR_CSG_PRIORITY_RT] = alloc_workqueue("panthor-drm-rt", WQ_RT | WQ_MEM_RECLAIM | WQ_UNBOUND, 2);
+	if (!sched->wq || !sched->heap_alloc_wq ||
+	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_MEDIUM] ||
+	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_HIGH] ||
+	    !sched->submit_wq[PANTHOR_CSG_PRIORITY_RT]) {
 		panthor_sched_fini(&ptdev->base, sched);
 		drm_err(&ptdev->base, "Failed to allocate the workqueues");
 		return -ENOMEM;
-- 
2.56.0

