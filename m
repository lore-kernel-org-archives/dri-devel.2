Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF9606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=f3FbgWnA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3A511243F;
	Thu, 22 Oct 2026 09:39:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8491F11242F
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=nzgktMgiJ6yBcdO1XGeyyVLXrOSYjDfO/Bw7RR9RTlI=; b=
 f3FbgWnAyjN6K0P9Ok+Fe7ZnJXNSTFjCRO07p7WXIZBluRna/VkQgA93kN3FRwgs3LZ7sGispCKnf
 oyWsS0BF7bTe0joVF394cdFfC5TMAJTjH8p7pLOBPsVpJexBfpMGWLqJtEFUKHY7xmph1WNwLQUHj
 BstEgahzPqWPBfVHuCmX5Vie0w26HH5LQMaQB8a9KPk4PeCJCx1HDEHwDSomCB39Uyb//QkSxzLsp
 Xv/WZywXAd8pkdsuAGtQw8rfWtIk69VIcc+eAcwPDmuPCtA+WuJlnzV9mat2qWr1jMrQ/gcJz1CEf
 th+NGq8s+y6v8ytWOojOPv6b+kfD4ZL72A==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJpG8-006erq-FF; Thu, 22 Oct 2026 11:38:52 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v7 3/4] workqueue: Add support for real-time workers
Date: Thu, 22 Oct 2026 10:38:47 +0100
Message-ID: <20261022093848.5727-4-tvrtko.ursulin@igalia.com>
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
 * Simplify wq_sysfs_unbound_group_visible and use it to deny modifications.
 * Print -rt from pr_cont_pool_info.
 * Keep wq_dump.py more backward compatible.
 * Disallow RT prio change via apply_workqueue_attrs().
---
 Documentation/core-api/workqueue.rst |  8 +++
 include/linux/workqueue.h            |  5 +-
 kernel/workqueue.c                   | 92 +++++++++++++++++++---------
 tools/workqueue/wq_dump.py           |  9 ++-
 4 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index bb770f556568..d699c3832b19 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -225,6 +225,14 @@ resources, scheduled and executed.
   each other.  Each maintains its separate pool of workers and
   implements concurrency management among its workers.
 
+``WQ_RT``
+  Real-time priority workqueues must be created as unbound and will be
+  configured with the strict CPU affinity set. Their worker threads use the FIFO
+  scheduling policy with the lowest applicable priority.
+
+  To be used sparingly for use cases such as the real-time GPU rendering
+  contexts accessible to privileged clients.
+
 ``WQ_CPU_INTENSIVE``
   Work items of a CPU intensive wq do not contribute to the
   concurrency level.  In other words, runnable CPU intensive
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a283766a192a..da9843251018 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -147,9 +147,9 @@ enum wq_affn_scope {
  */
 struct workqueue_attrs {
 	/**
-	 * @nice: nice level
+	 * @prio: priority encoded analogous to task_struct->prio.
 	 */
-	int nice;
+	int prio;
 
 	/**
 	 * @cpumask: allowed CPUs
@@ -404,6 +404,7 @@ enum wq_flags {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
+	WQ_RT			= 1 << 9, /* real-time priority, valid only with WQ_UNBOUND */
 
 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c634b20f1874..b34881830b8b 100644
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
@@ -126,7 +127,8 @@ enum wq_internal_consts {
 	 * all cpus.  Give MIN_NICE.
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
-	HIGHPRI_NICE_LEVEL	= MIN_NICE,
+	HIGHPRI_PRIORITY	= NICE_TO_PRIO(MIN_NICE),
+	RT_PRIORITY		= MAX_RT_PRIO - 2, /* sched_set_fifo_low() */
 
 	WQ_NAME_LEN		= 32,
 	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
@@ -1275,7 +1277,7 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 
 static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 {
-	int high = pool->attrs->nice == HIGHPRI_NICE_LEVEL ? 1 : 0;
+	int high = pool->attrs->prio == HIGHPRI_PRIORITY ? 1 : 0;
 
 	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
 }
@@ -1290,7 +1292,7 @@ static void kick_bh_pool(struct worker_pool *pool)
 		return;
 	}
 #endif
-	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+	if (pool->attrs->prio == HIGHPRI_PRIORITY)
 		raise_softirq_irqoff(HI_SOFTIRQ);
 	else
 		raise_softirq_irqoff(TASKLET_SOFTIRQ);
@@ -2959,7 +2961,8 @@ static int format_worker_id(char *buf, size_t size, struct worker *worker,
 		if (pool->cpu >= 0)
 			return scnprintf(buf, size, "kworker/%d:%d%s",
 					 pool->cpu, worker->id,
-					 pool->attrs->nice < 0  ? "H" : "");
+					 pool->attrs->prio < NICE_TO_PRIO(0) ?
+					 "H" : "");
 		else
 			return scnprintf(buf, size, "kworker/u%d:%d",
 					 pool->id, worker->id);
@@ -3018,7 +3021,12 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, pool->attrs->nice);
+		if (rt_prio(pool->attrs->prio))
+			sched_set_fifo_low(worker->task);
+		else
+			set_user_nice(worker->task,
+				      PRIO_TO_NICE(pool->attrs->prio));
+
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
 
@@ -3910,7 +3918,7 @@ static void bh_worker(struct worker *worker)
 
 	if (budget_exhausted)
 		trace_workqueue_bh_budget_yield(pool, restarts, timeout,
-						pool->attrs->nice == HIGHPRI_NICE_LEVEL);
+						pool->attrs->prio == HIGHPRI_PRIORITY);
 }
 
 /*
@@ -3969,7 +3977,7 @@ static void drain_dead_softirq_workfn(struct work_struct *work)
 	 * don't hog this CPU's BH.
 	 */
 	if (repeat) {
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio == HIGHPRI_PRIORITY)
 			queue_work(system_bh_highpri_wq, work);
 		else
 			queue_work(system_bh_wq, work);
@@ -4001,7 +4009,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 		dead_work.pool = pool;
 		init_completion(&dead_work.done);
 
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio == HIGHPRI_PRIORITY)
 			queue_work(system_bh_highpri_wq, &dead_work.work);
 		else
 			queue_work(system_bh_wq, &dead_work.work);
@@ -5005,6 +5013,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
+	attrs->prio = DEFAULT_PRIO;
 	attrs->affn_scope = WQ_AFFN_DFL;
 	return attrs;
 fail:
@@ -5015,7 +5024,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
 static void copy_workqueue_attrs(struct workqueue_attrs *to,
 				 const struct workqueue_attrs *from)
 {
-	to->nice = from->nice;
+	to->prio = from->prio;
 	cpumask_copy(to->cpumask, from->cpumask);
 	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
 	to->affn_strict = from->affn_strict;
@@ -5046,7 +5055,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 {
 	u32 hash = 0;
 
-	hash = jhash_1word(attrs->nice, hash);
+	hash = jhash_1word(attrs->prio, hash);
 	hash = jhash_1word(attrs->affn_strict, hash);
 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
@@ -5060,7 +5069,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 static bool wqattrs_equal(const struct workqueue_attrs *a,
 			  const struct workqueue_attrs *b)
 {
-	if (a->nice != b->nice)
+	if (a->prio != b->prio)
 		return false;
 	if (a->affn_strict != b->affn_strict)
 		return false;
@@ -5711,6 +5720,13 @@ static void
 sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
 				   struct workqueue_attrs *attrs)
 {
+	if (wq->flags & WQ_RT) {
+		attrs->prio = RT_PRIORITY;
+		/* Strict CPU affinity for low latency execution. */
+		attrs->affn_scope = WQ_AFFN_CPU;
+		attrs->affn_strict = true;
+	}
+
 	if (wq->flags & __WQ_ORDERED)
 		attrs->ordered = true;
 }
@@ -5721,7 +5737,7 @@ sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
 				 struct workqueue_attrs *attrs)
 {
 	if (wq->flags & WQ_HIGHPRI)
-		attrs->nice = HIGHPRI_NICE_LEVEL;
+		attrs->prio = HIGHPRI_PRIORITY;
 }
 
 static void
@@ -6126,6 +6142,11 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
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
@@ -6682,9 +6703,11 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	pr_cont(" flags=0x%x", pool->flags);
 	if (pool->flags & POOL_BH)
 		pr_cont(" bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
+	else if (rt_prio(pool->attrs->prio))
+		pr_cont(" rt");
 	else
-		pr_cont(" nice=%d", pool->attrs->nice);
+		pr_cont(" nice=%d", PRIO_TO_NICE(pool->attrs->prio));
 }
 
 static void pr_cont_worker_id(struct worker *worker)
@@ -6693,7 +6716,7 @@ static void pr_cont_worker_id(struct worker *worker)
 
 	if (pool->flags & POOL_BH)
 		pr_cont("bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
 	else
 		pr_cont("%d%s", task_pid_nr(worker->task),
 			worker->rescue_wq ? "(RESCUER)" : "");
@@ -7617,7 +7640,11 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
 	int written;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
+	if (wq->attrs->prio == RT_PRIORITY)
+		written = scnprintf(buf, PAGE_SIZE, "rt\n");
+	else
+		written = scnprintf(buf, PAGE_SIZE, "%d\n",
+				    PRIO_TO_NICE(wq->attrs->prio));
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -7643,19 +7670,21 @@ static ssize_t nice_store(struct device *dev, struct device_attribute *attr,
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
 	struct workqueue_attrs *attrs;
-	int ret = -ENOMEM;
+	int ret, nice = 0;
+
+	if (sscanf(buf, "%d", &nice) != 1 || nice < MIN_NICE || nice > MAX_NICE)
+		return -EINVAL;
 
 	mutex_lock(&wq_pool_mutex);
 
 	attrs = wq_sysfs_prep_attrs(wq);
-	if (!attrs)
+	if (!attrs) {
+		ret = -ENOMEM;
 		goto out_unlock;
+	}
 
-	if (sscanf(buf, "%d", &attrs->nice) == 1 &&
-	    attrs->nice >= MIN_NICE && attrs->nice <= MAX_NICE)
-		ret = apply_workqueue_attrs_locked(wq, attrs);
-	else
-		ret = -EINVAL;
+	attrs->prio = NICE_TO_PRIO(nice);
+	ret = apply_workqueue_attrs_locked(wq, attrs);
 
 out_unlock:
 	mutex_unlock(&wq_pool_mutex);
@@ -7797,6 +7826,13 @@ static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
 	if (!(wq->flags & WQ_UNBOUND))
 		return 0;
 
+	/* Do not allow priority and affinity changes for RT workers. */
+	if ((wq->flags & WQ_RT) &&
+	     (attr == &dev_attr_nice.attr ||
+	      attr == &dev_attr_affinity_scope.attr ||
+	      attr == &dev_attr_affinity_strict.attr))
+		return 0444;
+
 	return attr->mode;
 }
 
@@ -8321,13 +8357,13 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
 }
 
-static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
+static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int prio)
 {
 	BUG_ON(init_worker_pool(pool));
 	pool->cpu = cpu;
 	cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
 	cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
-	pool->attrs->nice = nice;
+	pool->attrs->prio = prio;
 	pool->attrs->affn_strict = true;
 	pool->node = cpu_to_node(cpu);
 
@@ -8350,7 +8386,7 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
 void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	int std_prio[NR_STD_WORKER_POOLS] = { DEFAULT_PRIO, HIGHPRI_PRIORITY };
 	void (*irq_work_fns[NR_STD_WORKER_POOLS])(struct irq_work *) =
 		{ bh_pool_kick_normal, bh_pool_kick_highpri };
 	int i, cpu;
@@ -8402,7 +8438,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_bh_worker_pool(pool, cpu) {
-			init_cpu_worker_pool(pool, cpu, std_nice[i]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i]);
 			pool->flags |= POOL_BH;
 			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
 			i++;
@@ -8410,7 +8446,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_cpu_worker_pool(pool, cpu)
-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i++]);
 	}
 
 	system_wq = alloc_workqueue("events", WQ_PERCPU | __WQ_DEPRECATED, 0);
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index 9313ebe0c525..650d4cddf25d 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -122,6 +122,8 @@ POOL_BH                 = prog['POOL_BH']
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
 cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 
+rt_prio = prog.constant('RT_PRIORITY', filename='kernel/workqueue.c')
+
 print('Affinity Scopes')
 print('===============')
 
@@ -163,7 +165,12 @@ for pi, pool in idr_for_each(worker_pool_idr):
 
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    nice = pool.attrs.prio.value_()
+    if nice == rt_prio:
+        nice = 'rt'
+    else:
+        nice = nice - 120 # PRIO_TO_NICE
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={nice:3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     if pool.cpu >= 0:
         print(f'cpu={pool.cpu.value_():3}', end='')
-- 
2.56.0

