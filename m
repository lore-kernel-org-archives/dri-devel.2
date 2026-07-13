Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E891C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B571810E9B8;
	Mon, 13 Jul 2026 14:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fR2maVA4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EFFF10E83E
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u7t6AOIDaNt7cBQ+Qzxy/mJOkT7jvyaowGm0Gpy5iZo=; b=fR2maVA43y0R5k/FS9keoWevoO
 s5L0dVkPpsuKln9pPb7KMh0gbUYxycgzy7mMB2QBGX1esPIKXvnFrYtFwWG/k3fMh3kVG5Wv0cqRK
 mxlbiFdfEli99aH/o6Ir+cKxq9yReYOOvx5WY1eoCGUjlMjHbRsAQkixGh8pz4oLMJBeYdP6ye43J
 tk0E7+Cv7UK5DneD7J0TX0eUSPfnTjR2B6PEZXFRyAcx9JwRuzTN2nRTz+m7JjVacf5V68ds8/LV1
 HsE9wo+5DKRiw4j+Dse9YMeRkO/6LeFuAiiI3ZMa1zAI0NLNUqOZSIKwzPmidmObZITmb1AavEqSY
 dJX0Q3jg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjHQe-00EXHF-HP; Mon, 13 Jul 2026 16:14:40 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Chia-I Wu <olv@google.com>,
 Tejun Heo <tj@kernel.org>
Subject: [RFC 1/2] workqueue: Add support for real-time workers
Date: Mon, 13 Jul 2026 15:14:35 +0100
Message-ID: <20260713141436.21547-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713141436.21547-1-tvrtko.ursulin@igalia.com>
References: <20260713141436.21547-1-tvrtko.ursulin@igalia.com>
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
privileges to have had successfuly obtained realtime Vulkan global
priority, competing with random background CPU load can create large
latency spikes which gets in the way of a smooth user experience.

For these situations the existing WQ_HIPRI does not bring a noticeable
improvemet and a stronger hint is needed.

Lets add WQ_RTPRI which creates workers with a SCHED_FIFO scheduling class
to improve this.

We use a mininum priority level since we only care about winning the
contest against normal background CPU load. We also limit the number of
instantiated threads, both per workqueue to a maximum of two, and system-
wide to a maximum of either two or one less than the number of online
CPUs. The idea of that is to prevent system wide starvation cause by
potentially misbehaving work items.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  22 ++++--
 kernel/workqueue.c        | 154 ++++++++++++++++++++++++++++----------
 2 files changed, 131 insertions(+), 45 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 6177624539b3..bc313b9705cb 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -140,6 +140,12 @@ enum wq_affn_scope {
 	WQ_AFFN_NR_TYPES,
 };
 
+enum wq_priority {
+	WQ_PRIO_NORMAL = 0,
+	WQ_PRIO_HIGH = 1,
+	WQ_PRIO_RT = 2
+};
+
 /**
  * struct workqueue_attrs - A struct for workqueue attributes.
  *
@@ -147,7 +153,12 @@ enum wq_affn_scope {
  */
 struct workqueue_attrs {
 	/**
-	 * @nice: nice level
+	 * @prio: priority level
+	 */
+	enum wq_priority prio;
+
+	/**
+	 * @nice: nice level for WQ_PRIO_HIGH
 	 */
 	int nice;
 
@@ -374,8 +385,9 @@ enum wq_flags {
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
 	WQ_HIGHPRI		= 1 << 4, /* high priority */
-	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
-	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
+	WQ_RTPRI		= 1 << 5, /* real-time priority */
+	WQ_CPU_INTENSIVE	= 1 << 6, /* cpu intensive workqueue */
+	WQ_SYSFS		= 1 << 7, /* visible in sysfs, see workqueue_sysfs_register() */
 
 	/*
 	 * Per-cpu workqueues are generally preferred because they tend to
@@ -402,8 +414,8 @@ enum wq_flags {
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
index 33b721a9af02..0473c009690f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -80,9 +80,10 @@ enum worker_pool_flags {
 	 * BH pool is per-CPU and always DISASSOCIATED.
 	 */
 	POOL_BH			= 1 << 0,	/* is a BH pool */
-	POOL_MANAGER_ACTIVE	= 1 << 1,	/* being managed */
-	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
-	POOL_BH_DRAINING	= 1 << 3,	/* draining after CPU offline */
+	POOL_RT			= 1 << 1,	/* is a RT pool */
+	POOL_MANAGER_ACTIVE	= 1 << 2,	/* being managed */
+	POOL_DISASSOCIATED	= 1 << 3,	/* cpu can't serve workers */
+	POOL_BH_DRAINING	= 1 << 4,	/* draining after CPU offline */
 };
 
 enum worker_flags {
@@ -104,7 +105,8 @@ enum work_cancel_flags {
 };
 
 enum wq_internal_consts {
-	NR_STD_WORKER_POOLS	= 2,		/* # standard pools per cpu */
+	NR_STD_WORKER_POOLS	= 3,		/* # standard pools per cpu */
+	NR_BH_WORKER_POOLS	= 2,		/* # bottom-half pools per cpu */
 
 	UNBOUND_POOL_HASH_ORDER	= 6,		/* hashed by pool->attrs */
 	BUSY_WORKER_HASH_ORDER	= 6,		/* 64 pointers */
@@ -495,10 +497,10 @@ static bool wq_debug_force_rr_cpu = false;
 module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
 
 /* to raise softirq for the BH worker pools on other CPUs */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_work [NR_STD_WORKER_POOLS], bh_pool_irq_works);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_work [NR_BH_WORKER_POOLS], bh_pool_irq_works);
 
 /* the BH worker pools */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], bh_worker_pools);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_BH_WORKER_POOLS], bh_worker_pools);
 
 /* the per-cpu worker pools */
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], cpu_worker_pools);
@@ -546,6 +548,8 @@ EXPORT_SYMBOL_GPL(system_bh_highpri_wq);
 struct workqueue_struct *system_dfl_long_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_dfl_long_wq);
 
+static atomic_t total_rtpri_workers = ATOMIC_INIT(0);
+
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
@@ -561,7 +565,7 @@ static void show_one_worker_pool(struct worker_pool *pool);
 
 #define for_each_bh_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(bh_worker_pools, cpu)[0];		\
-	     (pool) < &per_cpu(bh_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
+	     (pool) < &per_cpu(bh_worker_pools, cpu)[NR_BH_WORKER_POOLS]; \
 	     (pool)++)
 
 #define for_each_cpu_worker_pool(pool, cpu)				\
@@ -1236,9 +1240,7 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 
 static struct irq_work *bh_pool_irq_work(struct worker_pool *pool)
 {
-	int high = pool->attrs->nice == HIGHPRI_NICE_LEVEL ? 1 : 0;
-
-	return &per_cpu(bh_pool_irq_works, pool->cpu)[high];
+	return &per_cpu(bh_pool_irq_works, pool->cpu)[pool->attrs->prio];
 }
 
 static void kick_bh_pool(struct worker_pool *pool)
@@ -1251,7 +1253,7 @@ static void kick_bh_pool(struct worker_pool *pool)
 		return;
 	}
 #endif
-	if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+	if (pool->attrs->prio >= WQ_PRIO_HIGH)
 		raise_softirq_irqoff(HI_SOFTIRQ);
 	else
 		raise_softirq_irqoff(TASKLET_SOFTIRQ);
@@ -2801,13 +2803,16 @@ static int format_worker_id(char *buf, size_t size, struct worker *worker,
 				 worker->rescue_wq->name);
 
 	if (pool) {
-		if (pool->cpu >= 0)
+		if (pool->cpu >= 0) {
+			const char *suffix[NR_STD_WORKER_POOLS] = { "", "H", "R" };
+
 			return scnprintf(buf, size, "kworker/%d:%d%s",
 					 pool->cpu, worker->id,
-					 pool->attrs->nice < 0  ? "H" : "");
-		else
+					 suffix[pool->attrs->prio]);
+		} else {
 			return scnprintf(buf, size, "kworker/u%d:%d",
 					 pool->id, worker->id);
+		}
 	} else {
 		return scnprintf(buf, size, "kworker/dying");
 	}
@@ -2863,7 +2868,11 @@ static struct worker *create_worker(struct worker_pool *pool)
 			goto fail;
 		}
 
-		set_user_nice(worker->task, pool->attrs->nice);
+		if (pool->attrs->prio == WQ_PRIO_RT)
+			sched_set_fifo_low(worker->task);
+		else if (pool->attrs->prio == WQ_PRIO_HIGH)
+			set_user_nice(worker->task, pool->attrs->nice);
+
 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
 	}
 
@@ -2876,6 +2885,9 @@ static struct worker *create_worker(struct worker_pool *pool)
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
 
+	if (pool->flags & POOL_RT)
+		atomic_inc(&total_rtpri_workers);
+
 	/*
 	 * @worker is waiting on a completion in kthread() and will trigger hung
 	 * check if not woken up soon. As kick_pool() is noop if @pool is empty,
@@ -2909,6 +2921,8 @@ static void reap_dying_workers(struct list_head *cull_list)
 	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
 		list_del_init(&worker->entry);
 		kthread_stop_put(worker->task);
+		if (worker->flags & WQ_RTPRI)
+			atomic_dec(&total_rtpri_workers);
 		kfree(worker);
 	}
 }
@@ -3110,6 +3124,19 @@ __acquires(&pool->lock)
 	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
 
 	while (true) {
+		if (pool->flags & POOL_RT) {
+			unsigned int max = num_online_cpus();
+
+			if (max > 2)
+				max = max - 1;
+			else
+				max = 2;
+
+			/* Global cap on the number of RT workers */
+			if (atomic_read(&total_rtpri_workers) >= max)
+				break;
+		}
+
 		if (create_worker(pool) || !need_to_create_worker(pool))
 			break;
 
@@ -3765,7 +3792,7 @@ static void drain_dead_softirq_workfn(struct work_struct *work)
 	 * don't hog this CPU's BH.
 	 */
 	if (repeat) {
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio >= WQ_PRIO_HIGH)
 			queue_work(system_bh_highpri_wq, work);
 		else
 			queue_work(system_bh_wq, work);
@@ -3786,7 +3813,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 {
 	int i;
 
-	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
+	for (i = 0; i < NR_BH_WORKER_POOLS; i++) {
 		struct worker_pool *pool = &per_cpu(bh_worker_pools, cpu)[i];
 		struct wq_drain_dead_softirq_work dead_work;
 
@@ -3797,7 +3824,7 @@ void workqueue_softirq_dead(unsigned int cpu)
 		dead_work.pool = pool;
 		init_completion(&dead_work.done);
 
-		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+		if (pool->attrs->prio >= WQ_PRIO_HIGH)
 			queue_work(system_bh_highpri_wq, &dead_work.work);
 		else
 			queue_work(system_bh_wq, &dead_work.work);
@@ -4772,6 +4799,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
 static void copy_workqueue_attrs(struct workqueue_attrs *to,
 				 const struct workqueue_attrs *from)
 {
+	to->prio = from->prio;
 	to->nice = from->nice;
 	cpumask_copy(to->cpumask, from->cpumask);
 	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
@@ -4803,6 +4831,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 {
 	u32 hash = 0;
 
+	hash = jhash_1word(attrs->prio, hash);
 	hash = jhash_1word(attrs->nice, hash);
 	hash = jhash_1word(attrs->affn_strict, hash);
 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
@@ -4817,6 +4846,8 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 static bool wqattrs_equal(const struct workqueue_attrs *a,
 			  const struct workqueue_attrs *b)
 {
+	if (a->prio != b->prio)
+		return false;
 	if (a->nice != b->nice)
 		return false;
 	if (a->affn_strict != b->affn_strict)
@@ -5603,11 +5634,17 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
 
 static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 {
-	bool highpri = wq->flags & WQ_HIGHPRI;
-	int cpu, ret;
+	int prio, cpu, ret;
 
 	lockdep_assert_held(&wq_pool_mutex);
 
+	if (wq->flags & WQ_RTPRI)
+		prio = WQ_PRIO_RT;
+	else if (wq->flags & WQ_HIGHPRI)
+		prio = WQ_PRIO_HIGH;
+	else
+		prio = WQ_PRIO_NORMAL;
+
 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
 	if (!wq->cpu_pwq)
 		goto enomem;
@@ -5624,7 +5661,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 			struct pool_workqueue **pwq_p;
 			struct worker_pool *pool;
 
-			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
+			pool = &(per_cpu_ptr(pools, cpu)[prio]);
 			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
 
 			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
@@ -5644,14 +5681,14 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	if (wq->flags & __WQ_ORDERED) {
 		struct pool_workqueue *dfl_pwq;
 
-		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[prio]);
 		/* there should only be single pwq for ordering guarantee */
 		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
 		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
 			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
-		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
+		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[prio]);
 	}
 
 	if (ret)
@@ -5816,6 +5853,11 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			return NULL;
 	}
 
+	if (flags & WQ_RTPRI) {
+		if (WARN_ON_ONCE(flags & WQ_HIGHPRI))
+			return NULL;
+	}
+
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags |= WQ_UNBOUND;
@@ -5842,7 +5884,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
 			     wq->name);
 
-	if (flags & WQ_BH) {
+	if (flags & WQ_RTPRI) {
+		/*
+		 * RT workqueues are limited to max half of the online CPUs.
+		 */
+		max_active = min_t(int, max_active, num_online_cpus() / 2);
+	} else if (flags & WQ_BH) {
 		/*
 		 * BH workqueues always share a single execution context per CPU
 		 * and don't impose any max_active limit.
@@ -6344,17 +6391,26 @@ void print_worker_info(const char *log_lvl, struct task_struct *task)
 	}
 }
 
+static void pr_cont_bh_suffix(enum wq_priority prio)
+{
+	if (prio == WQ_PRIO_RT)
+		pr_cont("bh-rt");
+	else if (prio == WQ_PRIO_HIGH)
+		pr_cont("bh-hi");
+	else
+		pr_cont("bh");
+}
+
 static void pr_cont_pool_info(struct worker_pool *pool)
 {
 	pr_cont(" cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
 	if (pool->node != NUMA_NO_NODE)
 		pr_cont(" node=%d", pool->node);
-	pr_cont(" flags=0x%x", pool->flags);
+	pr_cont(" flags=0x%x ", pool->flags);
 	if (pool->flags & POOL_BH)
-		pr_cont(" bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+		pr_cont_bh_suffix(pool->attrs->prio);
 	else
-		pr_cont(" nice=%d", pool->attrs->nice);
+		pr_cont("prio=%d", pool->attrs->prio);
 }
 
 static void pr_cont_worker_id(struct worker *worker)
@@ -6362,8 +6418,7 @@ static void pr_cont_worker_id(struct worker *worker)
 	struct worker_pool *pool = worker->pool;
 
 	if (pool->flags & POOL_BH)
-		pr_cont("bh%s",
-			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+		pr_cont_bh_suffix(pool->attrs->prio);
 	else
 		pr_cont("%d%s", task_pid_nr(worker->task),
 			worker->rescue_wq ? "(RESCUER)" : "");
@@ -7284,10 +7339,14 @@ static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
-	int written;
+	int written, nice;
 
 	mutex_lock(&wq->mutex);
-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->nice);
+	if (wq->unbound_attrs->prio == WQ_PRIO_RT)
+		nice = INT_MIN;
+	else
+		nice = wq->unbound_attrs->nice;
+	written = scnprintf(buf, PAGE_SIZE, "%d\n", nice);
 	mutex_unlock(&wq->mutex);
 
 	return written;
@@ -7313,13 +7372,20 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
 {
 	struct workqueue_struct *wq = dev_to_wq(dev);
 	struct workqueue_attrs *attrs;
-	int ret = -ENOMEM;
+	int ret;
 
 	apply_wqattrs_lock();
 
 	attrs = wq_sysfs_prep_attrs(wq);
-	if (!attrs)
+	if (!attrs) {
+		ret = -ENOMEM;
 		goto out_unlock;
+	}
+
+	if (attrs->prio == WQ_PRIO_RT) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	if (sscanf(buf, "%d", &attrs->nice) == 1 &&
 	    attrs->nice >= MIN_NICE && attrs->nice <= MAX_NICE)
@@ -7927,12 +7993,13 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
 }
 
-static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
+static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, enum wq_priority prio, int nice)
 {
 	BUG_ON(init_worker_pool(pool));
 	pool->cpu = cpu;
 	cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
 	cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
+	pool->attrs->prio = prio;
 	pool->attrs->nice = nice;
 	pool->attrs->affn_strict = true;
 	pool->node = cpu_to_node(cpu);
@@ -7956,8 +8023,9 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
 void __init workqueue_init_early(void)
 {
 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
-	void (*irq_work_fns[NR_STD_WORKER_POOLS])(struct irq_work *) =
+	int std_prio[NR_STD_WORKER_POOLS] = { 0, WQ_PRIO_HIGH, WQ_PRIO_RT };
+	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL, 0 };
+	void (*irq_work_fns[NR_BH_WORKER_POOLS])(struct irq_work *) =
 		{ bh_pool_kick_normal, bh_pool_kick_highpri };
 	int i, cpu;
 
@@ -8008,15 +8076,19 @@ void __init workqueue_init_early(void)
 
 		i = 0;
 		for_each_bh_worker_pool(pool, cpu) {
-			init_cpu_worker_pool(pool, cpu, std_nice[i]);
+			init_cpu_worker_pool(pool, cpu, std_prio[i], std_nice[i]);
 			pool->flags |= POOL_BH;
 			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
 			i++;
 		}
 
 		i = 0;
-		for_each_cpu_worker_pool(pool, cpu)
-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+		for_each_cpu_worker_pool(pool, cpu) {
+			init_cpu_worker_pool(pool, cpu, std_prio[i], std_nice[i]);
+			if (i == WQ_PRIO_RT)
+				pool->flags |= POOL_RT;
+			i++;
+		}
 	}
 
 	/* create default unbound and ordered wq attrs */
@@ -8024,6 +8096,7 @@ void __init workqueue_init_early(void)
 		struct workqueue_attrs *attrs;
 
 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
+		attrs->prio = std_prio[i];
 		attrs->nice = std_nice[i];
 		unbound_std_wq_attrs[i] = attrs;
 
@@ -8032,6 +8105,7 @@ void __init workqueue_init_early(void)
 		 * guaranteed by max_active which is enforced by pwqs.
 		 */
 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
+		attrs->prio = std_prio[i];
 		attrs->nice = std_nice[i];
 		attrs->ordered = true;
 		ordered_wq_attrs[i] = attrs;
-- 
2.54.0

