Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79E4C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CDD10E3FF;
	Fri, 17 Jul 2026 09:17:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+AvVXxw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B886610E3FF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C74F960A61;
 Fri, 17 Jul 2026 09:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F91F00A3A;
 Fri, 17 Jul 2026 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784279821;
 bh=Plx2wmRvkBQJAMg5CpoXDBtHj5Y0Ztmk+ra2U0IY/i0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I+AvVXxwsqdcqbJxmzs/A2J+xSJLRPz8r6ktbaHRAmuRMPJWHGhSY7E9Kvb7+SAAn
 sdjXdSMU/zo6tlFHm2v0/bDWnQ0LnyD5fhJ45DmDW0s1YZ6dRYo9ZQvJEAtM75ghFM
 jWj5b6u0rVLBrmuvBNMlV1qXkew31tjDm8GqlfAlzMMMdGj+BoiyJYKv+L/8yew5/o
 IQIncfnsBFnYpVaE86wKSzemYmvP5HZ0AzOTQlvbaCgd03BLMDi6HkEi2+kqVllL+2
 PfHI0EEXOU/icAKJgkvRRCwlxsHAouVBmDQvemf2h1wd7iUR4qnox+fpgqMqPrfIAN
 X8dgMkZR0xK3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v3 1/2] workqueue: Add support for real-time workers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717090209.26931-2-tvrtko.ursulin@igalia.com>
References: <20260717090209.26931-1-tvrtko.ursulin@igalia.com>
 <20260717090209.26931-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:17:00 +0000
Message-Id: <20260717091701.5C3F91F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Uninitialized pointer `worker` is freed if `ida_alloc()` fails=
 in `create_worker()`, causing memory corruption.
- [High] Worker pools can become permanently deadlocked when the global RT =
worker limit is reached due to an infinite sleep loop in the worker manager.
- [High] The global `total_rtpri_workers` atomic counter is permanently lea=
ked when worker allocation or thread creation fails.
- [High] Strict CPU affinity meant for RT workqueues is immediately discard=
ed and overwritten by standard NUMA attributes.
- [High] Creating an RT workqueue with WQ_AFFN_CPU affinity deterministical=
ly fails due to hitting the total_rtpri_workers limit on initialization.
- [Medium] The safety limit on max_active designed to prevent RT scheduler =
starvation can be bypassed via sysfs.
--

--- Patch [1]: [RFC v3 1/2] workqueue: Add support for real-time workers ---
commit 9672bfd2ee579be7697316d4370a3f3836fac4ce
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

workqueue: Add support for real-time workers

Adds WQ_RTPRI for real-time priority unbound workqueues to avoid latency
spikes from background CPU load. Limits RT workers system-wide to prevent
starvation.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 78068ae8f28a6..30fed46a31640 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
[ ... ]
> @@ -2838,12 +2841,30 @@ static struct worker *create_worker(struct worker=
_pool *pool)
>  	struct worker *worker;
>  	int id;
> =20
> +	/*
> +	 * Do not consume all CPUs with RT workers to avoid scheduler
> +	 * starvation.
> +	 */
> +	if (pool->attrs->prio =3D=3D WQ_PRIO_RT) {
> +		unsigned int max =3D num_online_cpus();
> +
> +		if (max > 2)
> +			max =3D max - 1;
> +		else
> +			max =3D 1;
> +
> +		if (atomic_inc_return(&total_rtpri_workers) > max) {
> +			atomic_dec(&total_rtpri_workers);
> +			return NULL;

[Severity: High]
Does returning NULL here cause a deadlock when called from
maybe_create_worker()?

maybe_create_worker() runs in a while (true) loop and expects create_worker=
()
failures to be temporary memory allocation issues:

maybe_create_worker() {
    while (true) {
        if (create_worker(pool) || !need_to_create_worker(pool))
            break;
        schedule_timeout_interruptible(CREATE_COOLDOWN);
    }
}

If the total_rtpri_workers limit is reached, create_worker() deterministica=
lly
returns NULL. Does this cause the manager thread to enter an infinite sleep
loop and deadlock the pool?

> +		}
> +	}
> +
>  	/* ID is needed to determine kthread name */
>  	id =3D ida_alloc(&pool->worker_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		pr_err_once("workqueue: Failed to allocate a worker ID: %pe\n",
>  			    ERR_PTR(id));
> -		return NULL;
> +		goto fail_ida;

[Severity: Critical]
Is the uninitialized pointer worker freed if ida_alloc() fails?

At this point worker has not been allocated. If ida_alloc() fails, the code
jumps to fail_ida, which falls through to fail:

fail_ida:
    if (pool->attrs->prio =3D=3D WQ_PRIO_RT)
        atomic_dec(&total_rtpri_workers);
fail:
    ida_free(&pool->worker_ida, id);
    kfree(worker);

Will this call kfree() on a garbage pointer?

>  	}
> =20
>  	worker =3D alloc_worker(pool->node);
> @@ -2871,7 +2892,11 @@ static struct worker *create_worker(struct worker_=
pool *pool)
>  			goto fail;

[Severity: High]
Does jumping to fail skip the total_rtpri_workers decrement?

If alloc_worker() or kthread_create_on_node() fails, they jump to the fail
label, which is placed below fail_ida. Doesn't this skip the atomic_dec() a=
nd
permanently leak the global total_rtpri_workers counter?

>  		}
> =20
> -		set_user_nice(worker->task, pool->attrs->nice);
> +		if (pool->attrs->prio =3D=3D WQ_PRIO_RT)
> +			sched_set_fifo_low(worker->task);
> +		else
> +			set_user_nice(worker->task, pool->attrs->nice);
> +
>  		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
>  	}
[ ... ]
> @@ -5622,7 +5663,7 @@ static int alloc_and_link_pwqs(struct workqueue_str=
uct *wq)
[ ... ]
>  	if (wq->flags & __WQ_ORDERED) {
>  		struct pool_workqueue *dfl_pwq;
> =20
> -		ret =3D apply_workqueue_attrs_locked(wq, ordered_wq_attrs[highpri]);
> +		ret =3D apply_workqueue_attrs_locked(wq, ordered_wq_attrs[prio]);
>  		/* there should only be single pwq for ordering guarantee */
>  		dfl_pwq =3D rcu_access_pointer(wq->dfl_pwq);
>  		WARN(!ret && (wq->pwqs.next !=3D &dfl_pwq->pwqs_node ||
>  			      wq->pwqs.prev !=3D &dfl_pwq->pwqs_node),
>  		     "ordering guarantee broken for workqueue %s\n", wq->name);
>  	} else {
> -		ret =3D apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[highpri]=
);
> +		ret =3D apply_workqueue_attrs_locked(wq, unbound_std_wq_attrs[prio]);

[Severity: High]
Does this overwrite the strict CPU affinity intended for RT workqueues?

In __alloc_workqueue(), wq->unbound_attrs is correctly configured with
WQ_AFFN_CPU and affn_strict =3D true for RT workqueues. However,
alloc_and_link_pwqs() immediately calls apply_workqueue_attrs_locked()
with unbound_std_wq_attrs[prio]. Does this replace the strict affinity
with the default NUMA-scoped non-strict attributes?

>  	}
> =20
>  	if (ret)
[ ... ]
> @@ -5857,7 +5904,17 @@ static struct workqueue_struct *__alloc_workqueue(=
const char *fmt,
>  		flags &=3D ~WQ_PERCPU;
>  	}
> =20
> -	if (flags & WQ_BH) {
> +	if (flags & WQ_RTPRI) {
> +		/*
> +		 * RT workqueues are limited to max half of possible CPUs to
> +		 * avoid scheduling starvation and have strict CPU affinity for
> +		 * low latency execution.
> +		 */
> +		max_active =3D min_t(int, max_active,
> +				   DIV_ROUND_UP(num_possible_cpus(), 2));

[Severity: Medium]
Can this max_active safety limit be bypassed via sysfs?

The sysfs max_active attribute uses wq_clamp_max_active(), which does not
recognize WQ_RTPRI and broadly clamps the value to 512 (WQ_MAX_ACTIVE).

Does this allow a privileged user to overwrite this initialization cap and
potentially cause RT scheduler starvation?

> +		wq->unbound_attrs->affn_scope =3D WQ_AFFN_CPU;
> +		wq->unbound_attrs->affn_strict =3D true;

[Severity: High]
Does applying WQ_AFFN_CPU affinity deterministically fail to initialize due=
 to
the global RT worker limit?

If WQ_AFFN_CPU is applied, apply_wqattrs_prepare() will loop over
for_each_possible_cpu() and create a distinct pool for every CPU.

Since total_rtpri_workers is globally capped to num_online_cpus() - 1, won't
attempting to sequentially spawn num_possible_cpus() workers deterministica=
lly
hit the hard limit and fail during initialization?

> +	} else if (flags & WQ_BH) {
>  		/*
>  		 * BH workqueues always share a single execution context per CPU
>  		 * and don't impose any max_active limit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717090209.2693=
1-1-tvrtko.ursulin@igalia.com?part=3D1
