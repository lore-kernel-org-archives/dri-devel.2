Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253B7CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D0C10E2EF;
	Thu,  1 Oct 2026 18:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g2qsU+2+";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBADD10E2EF
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=5+NwR+f12VZ2NmJQs/sr5Nhe1Gh4VmeVbzvPBcAbIqA=; b=
 g2qsU+2+7ZIaWkfw6b46ydsXjoA/3Lw7YMPIW6qKGYMSDM0PCxzek59ny7ZwoAl3EfjFAr/RBsbk7
 0Gy9zq+gy+CqGNBvvmEF166gdCA0E4Ea8BnyeYxa+n2sjb4DL/PJ7t0yYRP7UpaPHt9O1ZblLeW22
 6Hx9rPCNYHT1il8wcQpTp3QkNI1kx6s/UeatxL+ZwvWAzRkj66HDvq/jraVQFapd23K1hYFL95UNp
 njSZldKkHiVP50e7YNgw1BMJ6QF/Xi9DAaXbd3HRjm+hO1Ds8DIVQI9DnqpDf5OChhOqK3Grukisg
 41xH8wESMe4K0cgN/8PZ/2V96ErnwKYQNQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCLps-00AFm1-O9; Thu, 01 Oct 2026 20:48:52 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [RFC v6.1 2/3] workqueue: Add support for real-time workers
Date: Thu,  1 Oct 2026 19:48:48 +0100
Message-ID: <20261001184848.61776-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
References: <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
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
---
 Documentation/core-api/workqueue.rst |   8 ++
 include/linux/workqueue.h            |   5 +-
 kernel/workqueue.c                   | 106 +++++++++++++++++++--------
 tools/workqueue/wq_dump.py           |   9 ++-
 4 files changed, 95 insertions(+), 33 deletions(-)

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
index a283766a192a..ebec9dcc9e5f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -147,9 +147,9 @@ enum wq_affn_scope {
  */
 struct workqueue_attrs {
 	/**
-	 * @nice: nice level
+	 * @prio: priority encoded analoguous to task_struct->prio.
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
index c83d68d7d0ee..31f3ea0dd62e 100644
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
+	RT_PRIORITY		= MAX_RT_PRIO - 1,
 
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
@@ -5928,8 +5937,19 @@ static struct workqueue_attrs *alloc_wq_std_attrs(struct workqueue_struct *wq)
 	if (!attrs)
 		return NULL;
 
-	if (wq->flags & WQ_HIGHPRI)
-		attrs->nice = HIGHPRI_NICE_LEVEL;
+	if (wq->flags & WQ_RT) {
+		attrs->prio = RT_PRIORITY;
+		/*
+		 * RT workqueues have strict CPU affinity for low
+		 * latency execution.
+		 */
+		attrs->affn_scope = WQ_AFFN_CPU;
+		attrs->affn_strict = true;
+	} else if (wq->flags & WQ_HIGHPRI) {
+		attrs->prio = HIGHPRI_PRIORITY;
+	} else {
+		attrs->prio = DEFAULT_PRIO;
+	}
 
 	if (wq->flags & __WQ_ORDERED)
 		attrs->ordered = true;
@@ -6115,6 +6135,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			return NULL;
 	}
 
+	if (flags & WQ_RT) {
+		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=
+			         WQ_UNBOUND))
+			return NULL;
+	}
+
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags = (flags & ~WQ_PERCPU) | WQ_UNBOUND;
@@ -6671,9 +6697,9 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	pr_cont(" flags=0x%x", pool->flags);
 	if (pool->flags & POOL_BH)
 		pr_cont(" bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
 	else
-		pr_cont(" nice=%d", pool->attrs->nice);
+		pr_cont(" nice=%d", PRIO_TO_NICE(pool->attrs->prio));
 }
 
 static void pr_cont_worker_id(struct worker *worker)
@@ -6682,7 +6708,7 @@ static void pr_cont_worker_id(struct worker *worker)
 
 	if (pool->flags & POOL_BH)
 		pr_cont("bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
 	else
 		pr_cont("%d%s", task_pid_nr(worker->task),
 			worker->rescue_wq ? "(RESCUER)" : "");
@@ -7606,7 +7632,11 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
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
@@ -7632,19 +7662,21 @@ static ssize_t nice_store(struct device *dev, struct device_attribute *attr,
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
@@ -7673,6 +7705,10 @@ static ssize_t unbound_cpumask_store(struct device *dev,
 	struct workqueue_attrs *attrs;
 	int ret = -ENOMEM;
 
+	/* Do not allow cpumask changes for RT workers. */
+	if (wq->flags & WQ_RT)
+		return -EINVAL;
+
 	mutex_lock(&wq_pool_mutex);
 
 	attrs = wq_sysfs_prep_attrs(wq);
@@ -7716,6 +7752,10 @@ static ssize_t affinity_scope_store(struct device *dev,
 	struct workqueue_attrs *attrs;
 	int affn, ret = -ENOMEM;
 
+	/* Do not allow affinity changes for RT workers. */
+	if (wq->flags & WQ_RT)
+		return -EINVAL;
+
 	affn = parse_affn_scope(buf);
 	if (affn < 0)
 		return affn;
@@ -7748,6 +7788,10 @@ static ssize_t affinity_strict_store(struct device *dev,
 	struct workqueue_attrs *attrs;
 	int v, ret = -ENOMEM;
 
+	/* Do not allow affinity changes for RT workers. */
+	if (wq->flags & WQ_RT)
+		return -EINVAL;
+
 	if (sscanf(buf, "%d", &v) != 1)
 		return -EINVAL;
 
@@ -7786,6 +7830,10 @@ static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
 	if (!(wq->flags & WQ_UNBOUND))
 		return SYSFS_GROUP_INVISIBLE;
 
+	/* Do not allow priority changes for RT workers. */
+	if ((wq->flags & WQ_RT) && !strcmp(attr->name, "nice"))
+		return 0444;
+
 	return attr->mode;
 }
 
@@ -8310,13 +8358,13 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
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
 
@@ -8339,7 +8387,7 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
 void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	int std_prio[NR_STD_WORKER_POOLS] = { DEFAULT_PRIO, HIGHPRI_PRIORITY };
 	void (*irq_work_fns[NR_STD_WORKER_POOLS])(struct irq_work *) =
 		{ bh_pool_kick_normal, bh_pool_kick_highpri };
 	int i, cpu;
@@ -8391,7 +8439,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_bh_worker_pool(pool, cpu) {
-			init_cpu_worker_pool(pool, cpu, std_nice[i]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i]);
 			pool->flags |= POOL_BH;
 			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
 			i++;
@@ -8399,7 +8447,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_cpu_worker_pool(pool, cpu)
-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i++]);
 	}
 
 	system_wq = alloc_workqueue("events", WQ_PERCPU | __WQ_DEPRECATED, 0);
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index 9313ebe0c525..371601b086ca 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -24,7 +24,7 @@ Worker Pools
 Lists all worker pools indexed by their ID. For each pool:
 
   ref       number of pool_workqueue's associated with this pool
-  nice      nice value of the worker threads in the pool
+  prio      priority of the worker threads in the pool
   idle      number of idle workers
   workers   number of all workers
   cpu       CPU the pool is associated with (per-cpu pool)
@@ -122,6 +122,8 @@ POOL_BH                 = prog['POOL_BH']
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
 cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 
+rt_prio = prog.constant('RT_PRIORITY', filename='kernel/workqueue.c')
+
 print('Affinity Scopes')
 print('===============')
 
@@ -163,7 +165,10 @@ for pi, pool in idr_for_each(worker_pool_idr):
 
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    prio = pool.attrs.prio.value_()
+    if prio == rt_prio:
+        prio = 'rt'
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} prio={prio:3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     if pool.cpu >= 0:
         print(f'cpu={pool.cpu.value_():3}', end='')
-- 
2.55.0

