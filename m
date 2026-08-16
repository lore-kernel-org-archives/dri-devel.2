Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2403AC5DF74
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DF2410E66B;
	Mon, 17 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=grrlz.net header.i=@grrlz.net header.b="lb0pJc2t";
	dkim-atps=neutral
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48BD10E359
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
 s=stigmate; t=1786912161;
 bh=hcCfQYCMHdop2vJaxONF9fSuleEm4S66lilNaHay7CA=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=lb0pJc2tcM+lnGNZj4MbuylhAMaq4u6+lnetP5TnbVXEPmR1oCPHLdoOOTZ7tEpje
 ZNolQZ6VpKlVrXKbnwb2DBm7lLvkRCXmMm1oHEwFYuFc5xLKcKxc+17BLGqBKB/Wx1
 d3l+2umU5IpDZi576kL2MMjkvgDKkMquspRtUxZU=
Received: from mx1.investici.org (unknown [127.0.0.1])
 by confino.investici.org (Postfix) with ESMTP id 4hNSHP1DXLz10nN;
 Sun, 16 Aug 2026 20:29:21 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hNSHN2P9Zz10nM;
 Sun, 16 Aug 2026 20:29:20 +0000 (UTC)
Date: Sun, 16 Aug 2026 21:29:20 +0100
From: Bradley Morgan <include@grrlz.net>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
CC: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Chia-I Wu <olv@google.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v4 1/2] workqueue: Add support for real-time workers
In-Reply-To: <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
References: <20260804101925.55414-1-tvrtko.ursulin@igalia.com>
 <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
Message-ID: <7BD75DC2-CA88-4A4A-AA0F-2A108967EB76@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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

On 4 August 2026 11:19:24 BST, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
wrote:
>For use cases such as the DRM scheduler submitting work to the GPU on
>behalf of low latency userspace applications, where latter have sufficient
>privileges to have had successfully obtained realtime Vulkan global
>priority, competing with random background CPU load can create large
>latency spikes which gets in the way of a smooth user experience.
>
>For these situations the existing WQ_HIGHPRI does not bring a noticeable
>improvement and a stronger hint is needed.
>
>Lets add WQ_RTPRI which creates workers with a SCHED_FIFO scheduling class
>to improve this.
>
>We use a minimum priority level since we only care about winning the
>contest against normal background CPU load.
>
>Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>Cc: Boris Brezillon <boris.brezillon@collabora.com>
>Cc: Bradley Morgan <include@grrlz.net>
>Cc: Chia-I Wu <olv@google.com>
>Cc: Liviu Dudau <liviu.dudau@arm.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: Steven Price <steven.price@arm.com>
>Cc: Tejun Heo <tj@kernel.org>
>---
>v2:
> * Limit WQ_RTPRI to unbound workqueues and make it have strict CPU
>   affinitity. (Tejun)
> * Fixed commit message typos. (AI)
> * Fixed sysfs handling, max_active setting and user modified nice
>   application. (AI)
>
>v3:
> * Fix worker->pool null pointer dereference race by moving the
>   global decrement to detach_dying_workers().
> * Rebase for upstream changes.
>
>v4:
> * Fixed onion unwind.
> * Moved affinity setting to default attributes.
>
>v5:
> * Dropped global and local limits.
> * Documented in workqueue.rst.
> * Added NR_WQ_ATTRIBUTES.
> * Reverted BH handling changes.
>---
> Documentation/core-api/workqueue.rst |  5 ++
> include/linux/workqueue.h            | 23 ++++++--
> kernel/workqueue.c                   | 80 ++++++++++++++++++++++------
> 3 files changed, 86 insertions(+), 22 deletions(-)
>
>diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
>index 411e1b28b8de..6b6179e0a38a 100644
>--- a/Documentation/core-api/workqueue.rst
>+++ b/Documentation/core-api/workqueue.rst
>@@ -225,6 +225,11 @@ resources, scheduled and executed.
>   each other.  Each maintains its separate pool of workers and
>   implements concurrency management among its workers.
> 
>+``WQ_RTPRI``
>+  Real time priority workqueues must be created as unbound and have the strict
>+  CPU affinity set.  Their worker threads use the FIFO scheduling policy with
>+  the lowest priority.
>+
> ``WQ_CPU_INTENSIVE``
>   Work items of a CPU intensive wq do not contribute to the
>   concurrency level.  In other words, runnable CPU intensive
>diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
>index a283766a192a..e9ab53568e0c 100644
>--- a/include/linux/workqueue.h
>+++ b/include/linux/workqueue.h
>@@ -140,6 +140,13 @@ enum wq_affn_scope {
> 	WQ_AFFN_NR_TYPES,
> };
> 
>+enum wq_priority {
>+	WQ_PRIO_NORMAL = 0,
>+	WQ_PRIO_HIGH = 1,
>+	WQ_PRIO_RT = 2,
>+	NUM_WQ_PRIO, /* Keep last */
>+};
>+
> /**
>  * struct workqueue_attrs - A struct for workqueue attributes.
>  *
>@@ -147,7 +154,12 @@ enum wq_affn_scope {
>  */
> struct workqueue_attrs {
> 	/**
>-	 * @nice: nice level
>+	 * @prio: priority level
>+	 */
>+	enum wq_priority prio;
>+
>+	/**
>+	 * @nice: nice level for WQ_PRIO_HIGH
> 	 */
> 	int nice;
> 
>@@ -374,8 +386,9 @@ enum wq_flags {
> 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
> 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
> 	WQ_HIGHPRI		= 1 << 4, /* high priority */
>-	WQ_CPU_INTENSIVE	= 1 << 5, /* cpu intensive workqueue */
>-	WQ_SYSFS		= 1 << 6, /* visible in sysfs, see workqueue_sysfs_register() */
>+	WQ_RTPRI		= 1 << 5, /* real-time priority, valid only with WQ_UNBOUND */
>+	WQ_CPU_INTENSIVE	= 1 << 6, /* cpu intensive workqueue */
>+	WQ_SYSFS		= 1 << 7, /* visible in sysfs, see workqueue_sysfs_register() */
> 
> 	/*
> 	 * Per-cpu workqueues are generally preferred because they tend to
>@@ -402,8 +415,8 @@ enum wq_flags {
> 	 *
> 	 * http://thread.gmane.org/gmane.linux.kernel/1480396
> 	 */

I feel we could clean this link up.

The link doesn't even resolve, smh man. + Its http and all of that nonsense

>-	WQ_POWER_EFFICIENT	= 1 << 7,
>-	WQ_PERCPU		= 1 << 8, /* bound to a specific cpu */
>+	WQ_POWER_EFFICIENT	= 1 << 8,
>+	WQ_PERCPU		= 1 << 9, /* bound to a specific cpu */
> 
> 	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
> 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
>diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>index 78068ae8f28a..6b60380a8742 100644
>--- a/kernel/workqueue.c
>+++ b/kernel/workqueue.c
>@@ -105,6 +105,7 @@ enum work_cancel_flags {
> 
> enum wq_internal_consts {
> 	NR_STD_WORKER_POOLS	= 2,		/* # standard pools per cpu */
>+	NR_WQ_ATTRIBUTES	= NUM_WQ_PRIO,	/* # of attributes */
> 
> 	UNBOUND_POOL_HASH_ORDER	= 6,		/* hashed by pool->attrs */
> 	BUSY_WORKER_HASH_ORDER	= 6,		/* 64 pointers */
>@@ -509,10 +510,10 @@ static DEFINE_IDR(worker_pool_idr);	/* PR: idr of all pools */
> static DEFINE_HASHTABLE(unbound_pool_hash, UNBOUND_POOL_HASH_ORDER);
> 
> /* I: attributes used when instantiating standard unbound pools on demand
> */
>-static struct workqueue_attrs *unbound_std_wq_attrs[NR_STD_WORKER_POOLS];
>+static struct workqueue_attrs *unbound_std_wq_attrs[NR_WQ_ATTRIBUTES];
> 
> /* I: attributes used when instantiating ordered pools on demand */
>-static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
>+static struct workqueue_attrs *ordered_wq_attrs[NR_WQ_ATTRIBUTES];
> 
> /*
>  * I: kthread_worker to release pwq's. pwq release needs to be bounced to a
>@@ -2871,7 +2872,11 @@ static struct worker *create_worker(struct worker_pool *pool)
> 			goto fail;
> 		}
> 
>-		set_user_nice(worker->task, pool->attrs->nice);
>+		if (pool->attrs->prio == WQ_PRIO_RT)
>+			sched_set_fifo_low(worker->task);
>+		else
>+			set_user_nice(worker->task, pool->attrs->nice);
>+
> 		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
> 	}
> 
>@@ -4780,6 +4785,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void)
> static void copy_workqueue_attrs(struct workqueue_attrs *to,
> 				 const struct workqueue_attrs *from)
> {
>+	to->prio = from->prio;
> 	to->nice = from->nice;
> 	cpumask_copy(to->cpumask, from->cpumask);
> 	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
>@@ -4811,6 +4817,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
> {
> 	u32 hash = 0;
> 
>+	hash = jhash_1word(attrs->prio, hash);
> 	hash = jhash_1word(attrs->nice, hash);
> 	hash = jhash_1word(attrs->affn_strict, hash);
> 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
>@@ -4825,6 +4832,8 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
> static bool wqattrs_equal(const struct workqueue_attrs *a,
> 			  const struct workqueue_attrs *b)
> {
>+	if (a->prio != b->prio)
>+		return false;
> 	if (a->nice != b->nice)
> 		return false;
> 	if (a->affn_strict != b->affn_strict)
>@@ -5601,11 +5610,17 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
> 
> static int alloc_and_link_pwqs(struct workqueue_struct *wq)
> {
>-	bool highpri = wq->flags & WQ_HIGHPRI;
>-	int cpu, ret;
>+	int prio, cpu, ret;
> 
> 	lockdep_assert_held(&wq_pool_mutex);
> 
>+	if (wq->flags & WQ_RTPRI)
>+		prio = WQ_PRIO_RT;
>+	else if (wq->flags & WQ_HIGHPRI)
>+		prio = WQ_PRIO_HIGH;
>+	else
>+		prio = WQ_PRIO_NORMAL;
>+
> 	wq->cpu_pwq = alloc_percpu(struct pool_workqueue *);
> 	if (!wq->cpu_pwq)
> 		goto enomem;
>@@ -5622,7 +5637,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
> 			struct pool_workqueue **pwq_p;
> 			struct worker_pool *pool;
> 
>-			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
>+			pool = &(per_cpu_ptr(pools, cpu)[prio]);
> 			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
> 
> 			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
>@@ -5642,14 +5657,14 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
> 	if (wq->flags & __WQ_ORDERED) {
> 		struct pool_workqueue *dfl_pwq;
> 
>-		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[highpri]);
>+		ret = apply_workqueue_attrs_locked(wq, ordered_wq_attrs[prio]);
> 		/* there should only be single pwq for ordering guarantee */
> 		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
> 		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
> 			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
> 		     "ordering guarantee broken for workqueue %s\n", wq->name);
> 	} else {
>-		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]);
>+		ret = apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[prio]);
> 	}
> 
> 	if (ret)
>@@ -5814,6 +5829,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
> 			return NULL;
> 	}
> 
>+	if (flags & WQ_RTPRI) {
>+		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=
>+			         WQ_UNBOUND))
>+			return NULL;
>+	}
>+
> 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
> 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
> 		flags = (flags & ~WQ_PERCPU) | WQ_UNBOUND;
>@@ -7302,7 +7323,11 @@ static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
> 	int written;
> 
> 	mutex_lock(&wq->mutex);
>-	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->nice);
>+	if (wq->unbound_attrs->prio != WQ_PRIO_RT)
>+		written = scnprintf(buf, PAGE_SIZE, "%d\n",
>+				    wq->unbound_attrs->nice);
>+	else
>+		written = -EINVAL;
> 	mutex_unlock(&wq->mutex);
> 
> 	return written;
>@@ -7328,13 +7353,20 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
> {
> 	struct workqueue_struct *wq = dev_to_wq(dev);
> 	struct workqueue_attrs *attrs;
>-	int ret = -ENOMEM;
>+	int ret;
> 
> 	mutex_lock(&wq_pool_mutex);
> 
> 	attrs = wq_sysfs_prep_attrs(wq);
>-	if (!attrs)
>+	if (!attrs) {
>+		ret = -ENOMEM;
> 		goto out_unlock;
>+	}
>+
>+	if (attrs->prio == WQ_PRIO_RT) {
>+		ret = -EINVAL;
>+		goto out_unlock;
>+	}
> 
> 	if (sscanf(buf, "%d", &attrs->nice) == 1 &&
> 	    attrs->nice >= MIN_NICE && attrs->nice <= MAX_NICE)
>@@ -7942,12 +7974,13 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
> 	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
> }
> 
>-static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
>+static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, enum wq_priority prio, int nice)
> {
> 	BUG_ON(init_worker_pool(pool));
> 	pool->cpu = cpu;
> 	cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
> 	cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
>+	pool->attrs->prio = prio;
> 	pool->attrs->nice = nice;
> 	pool->attrs->affn_strict = true;
> 	pool->node = cpu_to_node(cpu);
>@@ -7971,7 +8004,8 @@ static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int n
> void __init workqueue_init_early(void)
> {
> 	struct wq_pod_type *pt = &wq_pod_types[WQ_AFFN_SYSTEM];
>-	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
>+	int std_prio[NR_WQ_ATTRIBUTES] = { 0, WQ_PRIO_HIGH, WQ_PRIO_RT };
>+	int std_nice[NR_WQ_ATTRIBUTES] = { 0, HIGHPRI_NICE_LEVEL, 0 };
> 	void (*irq_work_fns[NR_STD_WORKER_POOLS])(struct irq_work *) =
> 		{ bh_pool_kick_normal, bh_pool_kick_highpri };
> 	int i, cpu;
>@@ -8023,23 +8057,34 @@ void __init workqueue_init_early(void)
> 
> 		i = 0;
> 		for_each_bh_worker_pool(pool, cpu) {
>-			init_cpu_worker_pool(pool, cpu, std_nice[i]);
>+			init_cpu_worker_pool(pool, cpu, std_prio[i], std_nice[i]);
> 			pool->flags |= POOL_BH;
> 			init_irq_work(bh_pool_irq_work(pool), irq_work_fns[i]);
> 			i++;
> 		}
> 
> 		i = 0;
>-		for_each_cpu_worker_pool(pool, cpu)
>-			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
>+		for_each_cpu_worker_pool(pool, cpu) {
>+			init_cpu_worker_pool(pool, cpu, std_prio[i], std_nice[i]);
>+			i++;
>+		}
> 	}
> 
> 	/* create default unbound and ordered wq attrs */
>-	for (i = 0; i < NR_STD_WORKER_POOLS; i++) {
>+	for (i = 0; i < NR_WQ_ATTRIBUTES; i++) {
> 		struct workqueue_attrs *attrs;
> 
> 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
>+		attrs->prio = std_prio[i];
> 		attrs->nice = std_nice[i];
>+		if (i == WQ_PRIO_RT) {
>+			/*
>+			 * RT workqueues have strict CPU affinity for low
>+			 * latency execution.
>+			 */
>+			attrs->affn_scope = WQ_AFFN_CPU;
>+			attrs->affn_strict = true;
>+		}
> 		unbound_std_wq_attrs[i] = attrs;
> 
> 		/*
>@@ -8047,6 +8092,7 @@ void __init workqueue_init_early(void)
> 		 * guaranteed by max_active which is enforced by pwqs.
> 		 */
> 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
>+		attrs->prio = std_prio[i];
> 		attrs->nice = std_nice[i];
> 		attrs->ordered = true;
> 		ordered_wq_attrs[i] = attrs;
>

Thanks!
