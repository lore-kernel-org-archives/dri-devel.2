Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DB3C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1122610E659;
	Mon, 13 Jul 2026 19:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fgn4n54/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6673810E642
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 19:00:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AA58410BE;
 Mon, 13 Jul 2026 19:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948861F000E9;
 Mon, 13 Jul 2026 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783969199;
 bh=WwN1FUXHZdBtCSCaA6p8iXqe7Pn9drR2i58Rj5ZKzQ8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Fgn4n54/RZtHB6yzGbfG6nypXHSUVMhBu68Py/sanzic9+rBTQiOelRMl4GXpKW87
 5HNtAyoxKFkYjqnz0tGnJWtZ0trcYAByob2GUCAyWhI2IgexbgQBdaqLLd0Fyn2a/r
 NiT5fGZyjjOgfvIO8AuLWi1jXAiUdVI3f27fXe1rhFG9d0I7QCScog0TfOrDtq1Jpz
 eYoJIzs8HqMpWqxQRsGkNTKYGUcb72qPZ9uYXDumJgrCmmywFuEQPNOgZaR2DFwKju
 +nL1pLNq0bB6yDFfAHyr24gzvXqqXR6nEohk/6MRvEeKSFIMg/VFYK4q89LOF78iMW
 pMuz0uzf3mixQ==
Date: Mon, 13 Jul 2026 08:59:58 -1000
Message-ID: <b3e5bcb21184d13c7c631daac955f465@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Chia-I Wu <olv@google.com>
Subject: Re: [RFC 1/2] workqueue: Add support for real-time workers
In-Reply-To: <20260713141436.21547-2-tvrtko.ursulin@igalia.com>
References: <20260713141436.21547-1-tvrtko.ursulin@igalia.com>
 <20260713141436.21547-2-tvrtko.ursulin@igalia.com>
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

Hello, Tvrtko.

On Mon, Jul 13, 2026 at 03:14:35PM +0100, Tvrtko Ursulin wrote:
> We use a mininum priority level since we only care about winning the
> contest against normal background CPU load. We also limit the number of
> instantiated threads, both per workqueue to a maximum of two, and system-
> wide to a maximum of either two or one less than the number of online
> CPUs. The idea of that is to prevent system wide starvation cause by
> potentially misbehaving work items.

Do your use cases need concurrency management on per-cpu workqueues?
Concurrency management is what per-cpu pools do to reduce the number of
parallel worker contexts when there are multiple pending work items
competing for the same CPU - the next work item starts executing only
after the current worker blocks. That doesn't seem applicable to RT
usage where the point is running each work item as soon as possible.

If it isn't needed, how about supporting RT only on unbound workqueues?
Where per-cpu execution is wanted, an unbound workqueue with the
affinity scope set to "cpu" and affn_strict on behaves like a per-cpu
workqueue sans concurrency management. That'd leave the per-cpu worker
pools alone and confine the changes to the unbound side.

The following is an AI review of the patch:

> For use cases such as the DRM scheduler submitting work to the GPU on
> behalf of low latency userspace applications, where latter have sufficient
> privileges to have had successfuly obtained realtime Vulkan global
> priority, competing with random background CPU load can create large
> latency spikes which gets in the way of a smooth user experience.
>
> For these situations the existing WQ_HIPRI does not bring a noticeable
> improvemet and a stronger hint is needed.
>
> Lets add WQ_RTPRI which creates workers with a SCHED_FIFO scheduling class
> to improve this.
>
> We use a mininum priority level since we only care about winning the
> contest against normal background CPU load. We also limit the number of
> instantiated threads, both per workqueue to a maximum of two, and system-
> wide to a maximum of either two or one less than the number of online
> CPUs. The idea of that is to prevent system wide starvation cause by
> potentially misbehaving work items.

A few typos: "successfuly", "improvemet", "WQ_HIPRI", "mininum",
"cause by".

Where does the "per workqueue to a maximum of two" limit come from?
__alloc_workqueue() clamps max_active to num_online_cpus() / 2, which is
four on an eight-CPU machine; the two in this series comes from the
max_active the panthor patch passes in.

The system-wide limit also doesn't seem to apply to the panthor use case
at all, see the POOL_RT questions below.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 33b721a9af02..0473c009690f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

[ ... ]

> @@ -2863,7 +2868,11 @@ static struct worker *create_worker(struct worker_pool *pool)
>  			goto fail;
>  		}
>
> -		set_user_nice(worker->task, pool->attrs->nice);
> +		if (pool->attrs->prio == WQ_PRIO_RT)
> +			sched_set_fifo_low(worker->task);
> +		else if (pool->attrs->prio == WQ_PRIO_HIGH)
> +			set_user_nice(worker->task, pool->attrs->nice);
> +
>  		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
>  	}

Doesn't this stop applying attrs->nice to WQ_PRIO_NORMAL pools?

Unbound workqueues have a user-settable nice level via the sysfs "nice"
attribute, and wq_nice_store() still accepts it for non-RT workqueues
and stores it in the pool attrs.  For example the "writeback" workqueue
is WQ_UNBOUND | WQ_SYSFS with normal priority.

After this change, a pool created from attrs with prio == WQ_PRIO_NORMAL
and nice != 0 spawns workers that never get the nice value applied, so
the existing sysfs knob silently stops having any effect.

> @@ -2876,6 +2885,9 @@ static struct worker *create_worker(struct worker_pool *pool)
>  	worker->pool->nr_workers++;
>  	worker_enter_idle(worker);
>
> +	if (pool->flags & POOL_RT)
> +		atomic_inc(&total_rtpri_workers);
> +

[ ... ]

> @@ -2909,6 +2921,8 @@ static void reap_dying_workers(struct list_head *cull_list)
>  	list_for_each_entry_safe(worker, tmp, cull_list, entry) {
>  		list_del_init(&worker->entry);
>  		kthread_stop_put(worker->task);
> +		if (worker->flags & WQ_RTPRI)
> +			atomic_dec(&total_rtpri_workers);
>  		kfree(worker);
>  	}
>  }

Is this decrement testing the right flags field?  worker->flags holds
enum worker_flags values (WORKER_DIE, WORKER_IDLE, ...) and no worker
flag uses the bit that WQ_RTPRI (an enum wq_flags value) occupies, so
this condition is never true.

That means total_rtpri_workers is only ever incremented and can never
drop when workers of an RT pool are culled or their pool is released.
The increment above keys off pool->flags & POOL_RT, so the two sides of
the accounting can't pair up as written.

> @@ -3110,6 +3124,19 @@ __acquires(&pool->lock)
>  	mod_timer(&pool->mayday_timer, jiffies + MAYDAY_INITIAL_TIMEOUT);
>
>  	while (true) {
> +		if (pool->flags & POOL_RT) {
> +			unsigned int max = num_online_cpus();
> +
> +			if (max > 2)
> +				max = max - 1;
> +			else
> +				max = 2;
> +
> +			/* Global cap on the number of RT workers */
> +			if (atomic_read(&total_rtpri_workers) >= max)
> +				break;
> +		}
> +
>  		if (create_worker(pool) || !need_to_create_worker(pool))
>  			break;

Three questions about this cap.

1) Isn't the cap already fully consumed at boot?  workqueue_init() runs
create_worker() for every per-CPU standard pool of every online CPU, and
with NR_STD_WORKER_POOLS now 3 that includes the new POOL_RT pool:

	for_each_online_cpu(cpu) {
		for_each_cpu_worker_pool(pool, cpu) {
			pool->flags &= ~POOL_DISASSOCIATED;
			BUG_ON(!create_worker(pool));
		}
	}

On an N-CPU machine total_rtpri_workers is N right after boot while the
cap is max(N - 1, 2), so for any N >= 2 the break above already fires
before the first WQ_RTPRI user exists, and with the decrement never
running (see above) it stays that way.  A side effect is that every
machine now boots one idle SCHED_FIFO kworker per CPU whether or not
anything uses WQ_RTPRI.

2) What happens when this break fires while need_to_create_worker() is
still true?  The code after the loop is:

	timer_delete_sync(&pool->mayday_timer);
	raw_spin_lock_irq(&pool->lock);
	if (need_to_create_worker(pool))
		goto restart;

so the manager goes back to restart and loops forever.  Nothing in the
cap path sleeps, and each pass re-arms and then deletes the mayday timer
before it can expire, so pool_mayday_timeout() never runs and no rescuer
is engaged either.

Since worker_thread() only starts processing work once
may_start_working() holds, the first work item ever queued on a per-CPU
WQ_RTPRI workqueue would leave its SCHED_FIFO worker spinning in
worker_thread() -> manage_workers() -> maybe_create_worker() on that CPU
while the work item is never executed.  Nothing in this series creates a
per-CPU WQ_RTPRI workqueue, but __alloc_workqueue() only rejects the
WQ_HIGHPRI combination, so this is reachable as soon as one appears.

3) POOL_RT is only set on the per-CPU pools in workqueue_init_early().
get_unbound_pool() never sets it, so neither the cap nor the accounting
applies to unbound RT pools, which is the only configuration the panthor
patch in this series uses (WQ_RTPRI | WQ_MEM_RECLAIM | WQ_UNBOUND).

That seems to invert the commit message: the system-wide limit doesn't
restrict the posted consumer at all, while it permanently prevents
worker creation in the per-CPU pools it does cover.

[ ... ]

> @@ -5842,7 +5884,12 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
>  		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
>  			     wq->name);
>
> -	if (flags & WQ_BH) {
> +	if (flags & WQ_RTPRI) {
> +		/*
> +		 * RT workqueues are limited to max half of the online CPUs.
> +		 */
> +		max_active = min_t(int, max_active, num_online_cpus() / 2);
> +	} else if (flags & WQ_BH) {

Can max_active end up 0 here?  Two ways:

  - With one online CPU (nr_cpus=1 or maxcpus=1 boots),
    num_online_cpus() / 2 is 0, so the panthor workqueue created with
    max_active == 2 gets 0.

  - Passing max_active == 0, the documented "use default" value, stays
    0 because the "max_active ?: WQ_DFL_ACTIVE" fallback and
    wq_clamp_max_active(), which enforces a minimum of 1, are in the
    else branch and are skipped for WQ_RTPRI.

With wq->max_active == 0, wq_adjust_max_active() returns before
activating anything and pwq_tryinc_nr_active() can never succeed, so
every work item queued on such a workqueue stays on the inactive list
forever and flush/destroy hang.

Also, num_online_cpus() is sampled once at allocation time, so a
workqueue allocated before secondary CPUs are brought online keeps a
limit computed from the momentary CPU count.

While in this area: for WQ_RTPRI | WQ_MEM_RECLAIM, should the rescuer
get SCHED_FIFO as well?  rescuer_thread() runs at RESCUER_NICE_LEVEL,
so under a mayday the work this flag is trying to keep low latency
executes below the promised priority.

[ ... ]

> @@ -7284,10 +7339,14 @@ static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct workqueue_struct *wq = dev_to_wq(dev);
> -	int written;
> +	int written, nice;
>
>  	mutex_lock(&wq->mutex);
> -	written = scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->nice);
> +	if (wq->unbound_attrs->prio == WQ_PRIO_RT)
> +		nice = INT_MIN;
> +	else
> +		nice = wq->unbound_attrs->nice;
> +	written = scnprintf(buf, PAGE_SIZE, "%d\n", nice);

This isn't a bug, but is INT_MIN the value userspace should read from
the nice attribute of an RT workqueue?  This file has so far only ever
produced values in the [-20, 19] range.

[ ... ]

Thanks.

-- 
tejun
