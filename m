Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65138606A335
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=hjZpO2cq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0627610FA9E;
	Wed,  4 Nov 2026 09:52:48 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D54910FA93
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=HKPiaLfERveTqD0XMwioTOgjk0GtpywD0T2awIRmek4=;
 t=1793785956; x=2109145956; b=hjZpO2cqDDVV+mE6HE6ufjkWfPF8IoMB26AUVMC1T6mzQNr
 yxBh7O9oufo4e0fPuuxx5He68CYBzg90Hhh4J6/v7yZbK0pmnz3H04K99tRilCXOxtDuZBDdPcPqE
 93eQceUXN18oUHltERoiN+KuZ7l/sfhTLT0GKuZ0ENVYyPgqZKPbF93LA54wLpSDY/DSrA2Clbsh6
 aLu+PICzoZ/pMsSsRmv35MgzeStE4fHRAYm6O185TjZbaw8WUm4jV7CqUa7XOxe+4GDD/dAk7S7gd
 gzR+csdctJWCYBQxPzfRODjRceF8koX3YLrLaje90RtO0sI5Pv7ZdOdA8sB9OcUQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOXfW-002854-6m; Wed, 04 Nov 2026 10:52:34 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v8 3/6] workqueue: Convert nice value tracking to priority
 based
Date: Wed,  4 Nov 2026 09:52:22 +0000
Message-ID: <20261104095225.32654-4-tvrtko.ursulin@igalia.com>
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

In preparation for adding real-time priority workqueues lets convert the
tracking of the nice level to be priority based, ie. following the same
"encoding" as trask_struct->prio.

No functional change.

wq_dump.py is extended to support both old and new kernels by auto-
detecting the available struct member.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h  |  4 +--
 kernel/workqueue.c         | 62 +++++++++++++++++++++-----------------
 tools/workqueue/wq_dump.py | 27 +++++++++++++++--
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index c8a36423cb34..985fff90f033 100644
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
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2f0c3f738c70..0ed93b263389 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -126,7 +126,7 @@ enum wq_internal_consts {
 	 * all cpus.  Give MIN_NICE.
 	 */
 	RESCUER_NICE_LEVEL	= MIN_NICE,
-	HIGHPRI_NICE_LEVEL	= MIN_NICE,
+	HIGHPRI_PRIORITY	= NICE_TO_PRIO(MIN_NICE),
 
 	WQ_NAME_LEN		= 32,
 	WORKER_ID_LEN		= 10 + WQ_NAME_LEN, /* "kworker/R-" + WQ_NAME_LEN */
@@ -1275,7 +1275,7 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 
 static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 {
-	int high = pool->attrs->nice == HIGHPRI_NICE_LEVEL ? 1 : 0;
+	int high = pool->attrs->prio == HIGHPRI_PRIORITY ? 1 : 0;
 
 	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
 }
@@ -1290,7 +1290,7 @@ static void kick_bh_pool(struct worker_pool *pool)
 		return;
 	}
 #endif
-	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+	if (pool->attrs->prio == HIGHPRI_PRIORITY)
 		raise_softirq_irqoff(HI_SOFTIRQ);
 	else
 		raise_softirq_irqoff(TASKLET_SOFTIRQ);
@@ -2959,7 +2959,8 @@ static int format_worker_id(char *buf, size_t size, struct worker *worker,
 		if (pool->cpu >= 0)
 			return scnprintf(buf, size, "kworker/%d:%d%s",
 					 pool->cpu, worker->id,
-					 pool->attrs->nice < 0  ? "H" : "");
+					 pool->attrs->prio < NICE_TO_PRIO(0) ?
+					 "H" : "");
 		else
 			return scnprintf(buf, size, "kworker/u%d:%d",
 					 pool->id, worker->id);
@@ -3018,7 +3019,8 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, pool->attrs->nice);
+		set_user_nice(worker->task, PRIO_TO_NICE(pool->attrs->prio));
+
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
 
@@ -3910,7 +3912,7 @@ static void bh_worker(struct worker *worker)
 
 	if (budget_exhausted)
 		trace_workqueue_bh_budget_yield(pool, restarts, timeout,
-						pool->attrs->nice == HIGHPRI_NICE_LEVEL);
+						pool->attrs->prio == HIGHPRI_PRIORITY);
 }
 
 /*
@@ -3969,7 +3971,7 @@ static void drain_dead_softirq_workfn(struct work_struct *work)
 	 * don't hog this CPU's BH.
 	 */
 	if (repeat) {
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio == HIGHPRI_PRIORITY)
 			queue_work(system_bh_highpri_wq, work);
 		else
 			queue_work(system_bh_wq, work);
@@ -4001,7 +4003,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 		dead_work.pool = pool;
 		init_completion(&dead_work.done);
 
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio == HIGHPRI_PRIORITY)
 			queue_work(system_bh_highpri_wq, &dead_work.work);
 		else
 			queue_work(system_bh_wq, &dead_work.work);
@@ -5005,6 +5007,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
 		goto fail;
 
 	cpumask_copy(attrs->cpumask, cpu_possible_mask);
+	attrs->prio = DEFAULT_PRIO;
 	attrs->affn_scope = WQ_AFFN_DFL;
 	return attrs;
 fail:
@@ -5015,7 +5018,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
 static void copy_workqueue_attrs(struct workqueue_attrs *to,
 				 const struct workqueue_attrs *from)
 {
-	to->nice = from->nice;
+	to->prio = from->prio;
 	cpumask_copy(to->cpumask, from->cpumask);
 	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
 	to->affn_strict = from->affn_strict;
@@ -5046,7 +5049,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 {
 	u32 hash = 0;
 
-	hash = jhash_1word(attrs->nice, hash);
+	hash = jhash_1word(attrs->prio, hash);
 	hash = jhash_1word(attrs->affn_strict, hash);
 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
@@ -5060,7 +5063,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 static bool wqattrs_equal(const struct workqueue_attrs *a,
 			  const struct workqueue_attrs *b)
 {
-	if (a->nice != b->nice)
+	if (a->prio != b->prio)
 		return false;
 	if (a->affn_strict != b->affn_strict)
 		return false;
@@ -5727,7 +5730,7 @@ sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
 				 struct workqueue_attrs *attrs)
 {
 	if (wq->flags & WQ_HIGHPRI)
-		attrs->nice = HIGHPRI_NICE_LEVEL;
+		attrs->prio = HIGHPRI_PRIORITY;
 }
 
 /* allocate the attrs and pwqs for later installation */
@@ -6704,9 +6707,9 @@ static void pr_cont_pool_info(struct worker_pool *pool)
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
@@ -6715,7 +6718,7 @@ static void pr_cont_worker_id(struct worker *worker)
 
 	if (pool->flags & POOL_BH)
 		pr_cont("bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+			pool->attrs->prio == HIGHPRI_PRIORITY ? "-hi" : "");
 	else
 		pr_cont("%d%s", task_pid_nr(worker->task),
 			worker->rescue_wq ? "(RESCUER)" : "");
@@ -7639,7 +7642,8 @@ static ssize_t nice_show(struct device *dev, struct device_attribute *attr,
 	int written;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->attrs->nice);
+	written = scnprintf(buf, PAGE_SIZE, "%d\n",
+			    PRIO_TO_NICE(wq->attrs->prio));
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -7665,19 +7669,21 @@ static ssize_t nice_store(struct device *dev, struct device_attribute *attr,
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
@@ -8342,13 +8348,13 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
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
 
@@ -8371,7 +8377,7 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
 void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
+	int std_prio[NR_STD_WORKER_POOLS] = { DEFAULT_PRIO, HIGHPRI_PRIORITY };
 	void (*irq_work_fns[NR_STD_WORKER_POOLS])(struct irq_work *) =
 		{ bh_pool_kick_normal, bh_pool_kick_highpri };
 	int i, cpu;
@@ -8423,7 +8429,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_bh_worker_pool(pool, cpu) {
-			init_cpu_worker_pool(pool, cpu, std_nice[i]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i]);
 			pool->flags |= POOL_BH;
 			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
 			i++;
@@ -8431,7 +8437,7 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_cpu_worker_pool(pool, cpu)
-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i++]);
 	}
 
 	system_wq = alloc_workqueue("events", WQ_PERCPU | __WQ_DEPRECATED, 0);
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index f81d6ee01c79..b3b33a2d1f7c 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -95,6 +95,20 @@ def wq_attrs(wq):
     except AttributeError:
         return wq.unbound_attrs
 
+def pool_nice(pool):
+    if HAS_PRIO:
+        return pool.attrs.prio.value_() - 120 # PRIO_TO_NICE
+    else:
+        return pool.attrs.nice.value_()
+
+def pool_bh_type(pool):
+    if HAS_PRIO:
+        bh_hi = pool.attrs.prio.value_() == HIGHPRI_PRIORITY.value_()
+    else:
+        bh_hi = pool.attrs.nice.value_() == HIGHPRI_NICE_LEVEL.value_()
+
+    return 'bh-hi' if bh_hi else 'bh'
+
 def worker_current_start(worker):
     try:
         return worker.current_start.value_()
@@ -137,7 +151,6 @@ WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 POOL_BH                 = prog['POOL_BH']
 POOL_BH_DRAINING        = prog['POOL_BH_DRAINING']
 POOL_DISASSOCIATED      = prog['POOL_DISASSOCIATED']
-HIGHPRI_NICE_LEVEL      = prog['HIGHPRI_NICE_LEVEL']
 WORKER_IDLE             = prog['WORKER_IDLE']
 
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
@@ -145,6 +158,13 @@ cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 hz                      = get_hz()
 jiffies_mask            = (1 << (prog['jiffies'].type_.size * 8)) - 1 if 'jiffies' in prog else 0
 
+HAS_PRIO = prog.type('struct workqueue_attrs').has_member('prio')
+
+if HAS_PRIO:
+    HIGHPRI_PRIORITY = prog['HIGHPRI_PRIORITY']
+else:
+    HIGHPRI_NICE_LEVEL = prog['HIGHPRI_NICE_LEVEL']
+
 print('Affinity Scopes')
 print('===============')
 
@@ -186,13 +206,14 @@ for pi, pool in idr_for_each(worker_pool_idr):
 
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    nice = pool_nice(pool)
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={nice:3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     bh_type = None
     if pool.cpu >= 0:
         print(f'cpu={pool.cpu.value_():3}', end='')
         if pool.flags & POOL_BH:
-            bh_type = 'bh-hi' if pool.attrs.nice == HIGHPRI_NICE_LEVEL else 'bh'
+            bh_type = pool_bh_type(pool)
             print(f' {bh_type}', end='')
             if pool.flags & POOL_BH_DRAINING:
                 print(' draining', end='')
-- 
2.56.0

