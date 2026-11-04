Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C8E606A333
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=UxGtUSQP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AB010EEE1;
	Wed,  4 Nov 2026 09:52:46 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF9C10FA9E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=uTNqRaPynMKFFpyGBaSclIkAF8P18EdRnMISxVMIvWs=;
 t=1793785956; x=2109145956; b=UxGtUSQPtNRCcubVK6wdJ+muhJ2NRNjzQ1UqoyYvnEa3n2/
 BTNrlcKlQHQNIZVl9Pk1KPbVnml4Z7t96Lp+599Y1CEgaqU6ztV/7nXB3dTjTx64VmzcUJ1qQPz1J
 j8I7df+f9bdwAtq4jwV8e1wS6kOkJi5v8zkj3SPZQNqGmE5C26kT0CTw8nC4ka2W9d1hq8Ax/XFvS
 9fxFAmNNud+EyPLjr73jmOO0z1A+XUshEWM8jovNFPrs6W0l7Eg71AwrrwzjnU3TpS8VN9jiSvs+3
 V/Uh0DgdUy7MCi+i6uQPatTbMj/ioXIAv8CH61qAs+Y5sNVSASlulfE+ULlTr/1Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOXfW-002858-Tj; Wed, 04 Nov 2026 10:52:35 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v8 4/6] workqueue: Add support for real-time workers
Date: Wed,  4 Nov 2026 09:52:23 +0000
Message-ID: <20261104095225.32654-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
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

For use cases such as the DRM scheduler submitting work to the GPU on
behalf of low latency userspace applications, where latter have sufficient
privileges to have had successfully obtained realtime Vulkan global
priority, competing with random background CPU load can create large
latency spikes which gets in the way of a smooth user experience.

For these situations the existing WQ_HIGHPRI does not bring a noticeable
improvement and a stronger hint is needed.

Lets add WQ_RT which creates workers with a SCHED_FIFO scheduling class to
improve this.

We use a minimum priority level since we only care about winning the
contest against normal background CPU load.

With this, a benchmark which measures the GPU submit latency against a
real-time Vulkan queue when faced with CPU saturation, highlights a
dramatic reduction in the 95- and 98-th percentiles:

    us      7.3.0   WQ_RT

   median     30     21
    min        2      3
    max     1038    941
   95pct    2384     49
   98pct    2922     63

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com> # v9
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
 * Dropped separate attr->prio in favour of RTPRI_NICE_LEVEL checks.
   (Tejun)
 * Reworked on top of tj/for-7.4.

v7:
 * Convert to attrs->prio encoded analoguous to task_struct->prio.
 * Rename flag to WQ_PRIO and do not re-order enums.
 * Forbid WQ_RT affinity modifications via sysfs.
 * Added wq_dump.py support.

v8:
 * Fix max rt prio confusion.
 * Initialize priority also in alloc_workqueue_attrs_noprof.
 * Restrict rt cpumask modifications.

v9:
 * Reject WQ_RT | __WQ_ORDERED.
 * Fixed spelling in a comment.
 * Align RT_PRIORITY with sched_set_fifo_low.
 * Simplify wq_sysfs_unbound_group_visible and use it to deny
   modifications.
 * Print -rt from pr_cont_pool_info.
 * Keep wq_dump.py more backward compatible.
 * Disallow RT prio change via apply_workqueue_attrs().

v10:
 * Split as separate patch in the series, decoupling from nice to prio
   conversion.
 * Extracted implicit strict CPU affinity to a follow up patch.
 * Update the comments describing sysfs attributes. (Tejun)
---
 Documentation/core-api/workqueue.rst |  7 ++++++
 include/linux/workqueue.h            |  1 +
 kernel/workqueue.c                   | 33 +++++++++++++++++++++++++---
 tools/workqueue/wq_dump.py           | 13 +++++++----
 4 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index bb770f556568..54697907f2b0 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -225,6 +225,13 @@ resources, scheduled and executed.
   each other.  Each maintains its separate pool of workers and
   implements concurrency management among its workers.
 
+``WQ_RT``
+  Real-time priority workqueues must be created as unbound. Their worker threads
+  use the FIFO scheduling policy with the lowest applicable priority.
+
+  To be used sparingly for use cases such as the real-time GPU rendering
+  contexts accessible to privileged clients.
+
 ``WQ_CPU_INTENSIVE``
   Work items of a CPU intensive wq do not contribute to the
   concurrency level.  In other words, runnable CPU intensive
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 985fff90f033..6a220a57a9c6 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -404,6 +404,7 @@ enum wq_flags {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
+	WQ_RT			= 1 << 9, /* real-time priority, valid only with WQ_UNBOUND */
 
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0ed93b263389..637240667cf7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -47,6 +47,7 @@
 #include <linux/jhash.h>
 #include <linux/hashtable.h>
 #include <linux/rculist.h>
+#include <linux/sched/rt.h>
 #include <linux/nodemask.h>
 #include <linux/moduleparam.h>
 #include <linux/uaccess.h>
@@ -127,6 +128,7 @@ enum wq_internal_consts {
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
 	HIGHPRI_PRIORITY	= NICE_TO_PRIO(MIN_NICE),
+	RT_PRIORITY		= MAX_RT_PRIO - 2, /* sched_set_fifo_low() */
 
 	WQ_NAME_LEN		= 32,
 	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
@@ -3019,7 +3021,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, PRIO_TO_NICE(pool->attrs->prio));
+		if (rt_prio(pool->attrs->prio))
+			sched_set_fifo_low(worker->task);
+		else
+			set_user_nice(worker->task,
+				      PRIO_TO_NICE(pool->attrs->prio));
 
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
@@ -5717,6 +5723,9 @@ static void
 sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
 				   struct workqueue_attrs *attrs)
 {
+	if (wq->flags & WQ_RT)
+		attrs->prio = RT_PRIORITY;
+
 	if (wq->flags & __WQ_ORDERED)
 		attrs->ordered = true;
 }
@@ -6127,6 +6136,11 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			return NULL;
 	}
 
+	if (WARN_ON_ONCE((flags & WQ_RT) &&
+			 ((flags & (WQ_HIGHPRI | WQ_UNBOUND | __WQ_ORDERED)) !=
+			 WQ_UNBOUND)))
+		return NULL;
+
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags = (flags & ~WQ_PERCPU) | WQ_UNBOUND;
@@ -6708,6 +6722,8 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	if (pool->flags & POOL_BH)
 		pr_cont(" bh%s",
 			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
+	else if (rt_prio(pool->attrs->prio))
+		pr_cont(" rt");
 	else
 		pr_cont(" nice=%d", PRIO_TO_NICE(pool->attrs->prio));
 }
@@ -7564,6 +7580,10 @@ module_param_cb(default_affinity_scope, &wq_affn_dfl_ops, NULL, 0644);
  *  cpumask		RW mask	: bitmask of allowed CPUs for the workers
  *  affinity_scope	RW str  : worker CPU affinity scope (cache, numa, none)
  *  affinity_strict	RW bool : worker CPU affinity is strict
+ *
+ * As an exception, the WQ_RT workqueues export the nice attribute as:
+ *
+ *  nice		RO str	: "rt"
  */
 struct wq_device {
 	struct workqueue_struct		*wq;
@@ -7642,8 +7662,11 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
 	int written;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n",
-			    PRIO_TO_NICE(wq->attrs->prio));
+	if (wq->attrs->prio == RT_PRIORITY)
+		written = scnprintf(buf, PAGE_SIZE, "rt\n");
+	else
+		written = scnprintf(buf, PAGE_SIZE, "%d\n",
+				    PRIO_TO_NICE(wq->attrs->prio));
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -7824,6 +7847,10 @@ static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
 	if (!(wq->flags & WQ_UNBOUND))
 		return 0;
 
+	/* Do not allow priority changes for RT workers. */
+	if ((wq->flags & WQ_RT) && (attr == &dev_attr_nice.attr))
+		return 0444;
+
 	return attr->mode;
 }
 
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index b3b33a2d1f7c..67186d83e86e 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -25,7 +25,7 @@ Lists all worker pools indexed by their ID. For each pool:
 
   flags     pool flags in hex
   ref       number of pool_workqueue's associated with this pool
-  nice      nice value of the worker threads in the pool
+  nice      nice value of the worker threads in the pool, or "rt"
   idle      number of idle workers
   workers   number of all workers
   cpu       CPU the pool is associated with (per-cpu pool)
@@ -97,9 +97,13 @@ def wq_attrs(wq):
 
 def pool_nice(pool):
     if HAS_PRIO:
-        return pool.attrs.prio.value_() - 120 # PRIO_TO_NICE
+        prio = pool.attrs.prio.value_()
+        if prio == rt_prio:
+            return 'rt'
+        else:
+            return str(prio - 120) # PRIO_TO_NICE
     else:
-        return pool.attrs.nice.value_()
+        return str(pool.attrs.nice.value_())
 
 def pool_bh_type(pool):
     if HAS_PRIO:
@@ -162,6 +166,7 @@ HAS_PRIO = prog.type('struct workqueue_attrs').has_member('prio')
 
 if HAS_PRIO:
     HIGHPRI_PRIORITY = prog['HIGHPRI_PRIORITY']
+    rt_prio = prog.constant('RT_PRIORITY', filename='kernel/workqueue.c').value_()
 else:
     HIGHPRI_NICE_LEVEL = prog['HIGHPRI_NICE_LEVEL']
 
@@ -207,7 +212,7 @@ for pi, pool in idr_for_each(worker_pool_idr):
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
     nice = pool_nice(pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={nice:3} ', end='')
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={nice:>3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     bh_type = None
     if pool.cpu >= 0:
-- 
2.56.0

