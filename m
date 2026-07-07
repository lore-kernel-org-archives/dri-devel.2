Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8600CC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EE410E486;
	Tue,  7 Jul 2026 11:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="v3TUoo/T";
	dkim-atps=neutral
X-Greylist: delayed 383 seconds by postgrey-1.36 at gabe;
 Tue, 07 Jul 2026 11:54:48 UTC
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com
 [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA2310E486
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:54:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783424903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QJNxgS2ZMVArdUnfPnNqeviasCuf+pC7uN+iH0jQFCU=;
 b=v3TUoo/TQLW2cE6ULzb6xWGMtCKdRBby5qbMGdRVAvkB4FCTz6Xmc8LAdoW2Tdkrw3rkWU
 jLF5aYkfQSSGQv9QWDvEuxDm1NB2Bew5wgz258rSm7WzvXI+RxEKqXNDs4e5vitwJbRf3s
 wSwxmcbXdpiUUu+s6mhr5myN/S+sEJQ=
From: Marco Pagani <marco.pagani@linux.dev>
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Marco Pagani <marco.pagani@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/sched/tests: Let the DRM scheduler manage job
 lifetimes
Date: Tue,  7 Jul 2026 13:48:06 +0200
Message-ID: <20260707114807.154572-1-marco.pagani@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Currently, the mock scheduler uses KUnit-managed memory for jobs. This ties
the job's memory lifetime to the test suite rather than the DRM scheduler's
callbacks. This does not represent real driver behavior and can lead to
potential Use-After-Free bugs in the tests.

Update the mock scheduler to let the lifetime of jobs be managed by the DRM
scheduler's asynchronous callbacks instead of KUnit managed memory. Add a
kref reference counter to track the job's lifetime between test suites and
the scheduler.

Finally, to avoid memory leaks in the event of an early test abortion,
register a cleanup KUnit action that automatically puts the reference to
the job.

Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
---
 .../gpu/drm/scheduler/tests/mock_scheduler.c  | 68 ++++++++++++++-----
 drivers/gpu/drm/scheduler/tests/sched_tests.h |  6 ++
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
index 14403a762335..51f81082f37a 100644
--- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
+++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
@@ -96,6 +96,14 @@ drm_mock_sched_job_signal_timer(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static void drm_mock_sched_job_cleanup_action(void *ptr)
+{
+	struct drm_mock_sched_job *job = ptr;
+
+	job->test = NULL;
+	drm_mock_sched_job_put(job);
+}
+
 /**
  * drm_mock_sched_job_new - Create a new mock scheduler job
  *
@@ -111,23 +119,34 @@ drm_mock_sched_job_new(struct kunit *test,
 	struct drm_mock_sched_job *job;
 	int ret;
 
-	job = kunit_kzalloc(test, sizeof(*job), GFP_KERNEL);
+	/* Let the DRM Scheduler manage the lifetime of the job */
+	job = kzalloc_obj(*job, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, job);
 
+	kref_init(&job->refcount);
+	job->test = test;
+
 	ret = drm_sched_job_init(&job->base,
 				 &entity->base,
 				 1,
 				 NULL,
 				 1);
-	KUNIT_ASSERT_EQ(test, ret, 0);
-
-	job->test = test;
+	if (ret) {
+		kfree(job);
+		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "drm_sched_job_init failed");
+	}
 
 	init_completion(&job->done);
 	INIT_LIST_HEAD(&job->link);
 	hrtimer_setup(&job->timer, drm_mock_sched_job_signal_timer,
 		      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
+	ret = kunit_add_action(test, drm_mock_sched_job_cleanup_action, job);
+	if (ret) {
+		drm_mock_sched_job_put(job);
+		KUNIT_ASSERT_EQ_MSG(test, ret, 0, "kunit_add_action failed");
+	}
+
 	return job;
 }
 
@@ -152,7 +171,7 @@ static void drm_mock_sched_hw_fence_release(struct dma_fence *fence)
 
 	hrtimer_cancel(&job->timer);
 
-	/* Containing job is freed by the kunit framework */
+	drm_mock_sched_job_put(job);
 }
 
 static const struct dma_fence_ops drm_mock_sched_hw_fence_ops = {
@@ -173,6 +192,8 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
 		       sched->hw_timeline.context,
 		       atomic_inc_return(&sched->hw_timeline.next_seqno));
 
+	kref_get(&job->refcount);
+
 	dma_fence_get(&job->hw_fence); /* Reference for the job_list */
 
 	spin_lock_irq(&sched->lock);
@@ -200,6 +221,17 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
 	return &job->hw_fence;
 }
 
+static void mock_sched_free_job(struct drm_sched_job *sched_job)
+{
+	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
+
+	/* Only if the fence has been successfully initialized */
+	if (job->hw_fence.ops)
+		dma_fence_put(&job->hw_fence);
+
+	drm_mock_sched_job_put(job);
+}
+
 /*
  * Normally, drivers would take appropriate measures in this callback, such as
  * killing the entity the faulty job is associated with, resetting the hardware
@@ -232,21 +264,26 @@ mock_sched_timedout_job(struct drm_sched_job *sched_job)
 	}
 	spin_unlock_irqrestore(&sched->lock, flags);
 
-	dma_fence_put(&job->hw_fence);
-	drm_sched_job_cleanup(sched_job);
-	/* Mock job itself is freed by the kunit framework. */
+	mock_sched_free_job(sched_job);
 
 	return DRM_GPU_SCHED_STAT_RESET;
 }
 
-static void mock_sched_free_job(struct drm_sched_job *sched_job)
+static void drm_mock_sched_job_release(struct kref *ref)
 {
-	struct drm_mock_sched_job *job = drm_sched_job_to_mock_job(sched_job);
+	struct drm_mock_sched_job *job;
+
+	job = container_of(ref, struct drm_mock_sched_job, refcount);
 
-	dma_fence_put(&job->hw_fence);
-	drm_sched_job_cleanup(sched_job);
+	drm_sched_job_cleanup(&job->base);
 
-	/* Mock job itself is freed by the kunit framework. */
+	kfree(job);
+}
+
+void drm_mock_sched_job_put(struct drm_mock_sched_job *job)
+{
+	if (job)
+		kref_put(&job->refcount, drm_mock_sched_job_release);
 }
 
 static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
@@ -265,10 +302,7 @@ static void mock_sched_cancel_job(struct drm_sched_job *sched_job)
 	}
 	spin_unlock_irqrestore(&sched->lock, flags);
 
-	/*
-	 * The GPU Scheduler will call drm_sched_backend_ops.free_job(), still.
-	 * Mock job itself is freed by the kunit framework.
-	 */
+	/* The GPU Scheduler will call drm_sched_backend_ops.free_job() */
 }
 
 static const struct drm_sched_backend_ops drm_mock_scheduler_ops = {
diff --git a/drivers/gpu/drm/scheduler/tests/sched_tests.h b/drivers/gpu/drm/scheduler/tests/sched_tests.h
index 553d45abd057..e4d33f0bf935 100644
--- a/drivers/gpu/drm/scheduler/tests/sched_tests.h
+++ b/drivers/gpu/drm/scheduler/tests/sched_tests.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/kref.h>
 
 #include <drm/gpu_scheduler.h>
 
@@ -90,6 +91,7 @@ struct drm_mock_sched_entity {
  */
 struct drm_mock_sched_job {
 	struct drm_sched_job	base;
+	struct kref		refcount;
 
 	struct completion	done;
 
@@ -144,6 +146,8 @@ struct drm_mock_sched_job *
 drm_mock_sched_job_new(struct kunit *test,
 		       struct drm_mock_sched_entity *entity);
 
+void drm_mock_sched_job_put(struct drm_mock_sched_job *job);
+
 /**
  * drm_mock_sched_job_submit - Arm and submit a job in one go
  *
@@ -151,6 +155,8 @@ drm_mock_sched_job_new(struct kunit *test,
  */
 static inline void drm_mock_sched_job_submit(struct drm_mock_sched_job *job)
 {
+	kref_get(&job->refcount);
+
 	drm_sched_job_arm(&job->base);
 	drm_sched_entity_push_job(&job->base);
 }
-- 
2.55.0

