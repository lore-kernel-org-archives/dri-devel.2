Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F537C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F79B10E92C;
	Wed, 23 Sep 2026 16:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SxLYZBwx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BAC10E93D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=aIrQn9s9bafTu+uFiPgLvDvAAJdVYC1maxfhhoJR5Ys=; b=
 SxLYZBwxciDru7suCzvja0GSgnEoIdBKHG+8MDvpeEORrB7KYLkR5BqrIdrRZ6ZOy950GX/kdNB5U
 leEh2jLguvyZ6vjC7F1gIayUB1gS3LHt1b0fzv5b9yO57wX9DE021cA0mxscSvMZXatZ7o7FcOYGT
 K+Gk6qC681YPA9zdrR5WAZu8IXwuKMnQLZuSHUkvqlQHQSPobtVRJpmFI/N2MuqksP0s/FycMmjtx
 98KNaIE5F5hGadNyzv3roXgCVG5qkBbvqnV4wkiZVzDSLXr7qVOLOj98TzocTIItv5mVZspTiUqD3
 01AmFyQ0PJNnZ1GObsTG2S/RmYWSvFg9Dg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9Paa-006ECS-CK; Wed, 23 Sep 2026 18:12:56 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [RFC v5 2/3] workqueue: Add support for real-time workers
Date: Wed, 23 Sep 2026 17:12:50 +0100
Message-ID: <20260923161251.45428-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
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

For use cases such as the DRM scheduler submitting work to the GPU on
behalf of low latency userspace applications, where latter have sufficient
privileges to have had successfully obtained realtime Vulkan global
priority, competing with random background CPU load can create large
latency spikes which gets in the way of a smooth user experience.

For these situations the existing WQ_HIGHPRI does not bring a noticeable
improvement and a stronger hint is needed.

Lets add WQ_RTPRI which creates workers with a SCHED_FIFO scheduling class
to improve this.

We use a minimum priority level since we only care about winning the
contest against normal background CPU load.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Bradley Morgan <include@grrlz.net>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
v2:
 * Limit WQ_RTPRI to unbound workqueues and make it have strict CPU
   affinitity. (Tejun)
 * Fixed commit message typos. (AI)
 * Fixed sysfs handling, max_active setting and user modified nice
   application. (AI)

v3:
 * Fix worker->pool null pointer dereference race by moving the
   global decrement to detach_dying_workers().
 * Rebase for upstream changes.

v4:
 * Fixed onion unwind.
 * Moved affinity setting to default attributes.

v5:
 * Dropped global and local limits.
 * Documented in workqueue.rst.
 * Added NR_WQ_ATTRIBUTES.
 * Reverted BH handling changes.

v6:
 * Dropped separate attr->prio in favour of RTPRI_NICE_LEVEL checks. (Tejun)
 * Reworked on top of tj/for-7.4.
---
 Documentation/core-api/workqueue.rst |  5 +++++
 include/linux/workqueue.h            |  9 ++++----
 kernel/workqueue.c                   | 33 +++++++++++++++++++++++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index bb770f556568..24df3d87e2dd 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -225,6 +225,11 @@ resources, scheduled and executed.
   each other.  Each maintains its separate pool of workers and
   implements concurrency management among its workers.
 
+``WQ_RTPRI``
+  Real time priority workqueues must be created as unbound and have the strict
+  CPU affinity set.  Their worker threads use the FIFO scheduling policy with
+  the lowest priority.
+
 ``WQ_CPU_INTENSIVE``
   Work items of a CPU intensive wq do not contribute to the
   concurrency level.  In other words, runnable CPU intensive
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a283766a192a..161f71f4c264 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -374,8 +374,9 @@ enum wq_flags {
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
 	WQ_HIGHPRI		= 1 << 4, /* high priority */
-	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
-	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
+	WQ_RTPRI		= 1 << 5, /* real-time priority, valid only with WQ_UNBOUND */
+	WQ_CPU_INTENSIVE	= 1 << 6, /* cpu intensive workqueue */
+	WQ_SYSFS		= 1 << 7, /* visible in sysfs, see workqueue_sysfs_register() */
 
 	/*
 	 * Per-cpu workqueues are generally preferred because they tend to
@@ -402,8 +403,8 @@ enum wq_flags {
 	 *
 	 * http://thread.gmane.org/gmane.linux.kernel/1480396
 	 */
-	WQ_POWER_EFFICIENT	= 1 << 7,
-	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
+	WQ_POWER_EFFICIENT	= 1 << 8,
+	WQ_PERCPU		= 1 << 9, /* bound to a specific cpu */
 
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e3a4ad56dae8..5cf486291af8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -127,6 +127,7 @@ enum wq_internal_consts {
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_NICE_LEVEL	= MIN_NICE,
+	RTPRI_NICE_LEVEL	= MIN_NICE - 1,
 
 	WQ_NAME_LEN		= 32,
 	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
@@ -3018,7 +3019,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, pool->attrs->nice);
+		if (pool->attrs->nice == RTPRI_NICE_LEVEL)
+			sched_set_fifo_low(worker->task);
+		else
+			set_user_nice(worker->task, pool->attrs->nice);
+
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
 
@@ -5928,8 +5933,17 @@ static struct workqueue_attrs *alloc_wq_std_attrs(struct workqueue_struct *wq)
 	if (!attrs)
 		return NULL;
 
-	if (wq->flags & WQ_HIGHPRI)
+	if (wq->flags & WQ_RTPRI) {
+		attrs->nice = RTPRI_NICE_LEVEL;
+		/*
+		 * RT workqueues have strict CPU affinity for low
+		 * latency execution.
+		 */
+		attrs->affn_scope = WQ_AFFN_CPU;
+		attrs->affn_strict = true;
+	} else if (wq->flags & WQ_HIGHPRI) {
 		attrs->nice = HIGHPRI_NICE_LEVEL;
+	}
 
 	if (wq->flags & __WQ_ORDERED)
 		attrs->ordered = true;
@@ -6115,6 +6129,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			return NULL;
 	}
 
+	if (flags & WQ_RTPRI) {
+		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=
+			         WQ_UNBOUND))
+			return NULL;
+	}
+
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags = (flags & ~WQ_PERCPU) | WQ_UNBOUND;
@@ -7606,7 +7626,10 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
 	int written;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
+	if (wq->attrs->nice == RTPRI_NICE_LEVEL)
+		written = scnprintf(buf, PAGE_SIZE, "rt\n");
+	else
+		written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -7786,6 +7809,10 @@ static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
 	if (!(wq->flags & WQ_UNBOUND))
 		return SYSFS_GROUP_INVISIBLE;
 
+	/* Do not allow priority changes for RT workers. */
+	if ((wq->flags & WQ_RTPRI) && !strcmp(attr->name, "nice"))
+		return 0444;
+
 	return attr->mode;
 }
 
-- 
2.55.0

