Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94B8C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC9510E150;
	Tue,  4 Aug 2026 10:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvarHez9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A3310E150
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:41:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB51043911;
 Tue,  4 Aug 2026 10:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852271F000E9;
 Tue,  4 Aug 2026 10:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785840072;
 bh=Cw5iLwETU4w3Ir8GKv+5NWQQrBNldEGk2myF36o6YEw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VvarHez9F1RDB/nyct0rLmJ4beqFFzuGiznvv1XGmc05f6rPhgwR1ii7YMAaw74V8
 lU+2ElsL+wmWgKx0WudXaMhWqJL5iWwcxl4TvvHb+WG/BBJu722O6z+M4ya6Z9foWg
 0aSQ20q1gYpz378TCqJhDgRX5GYno3EzL5h6pZQUr2WpXp0lVmJ1ktkNNmcZVYfdUj
 woicLBIa6BtBtmu+DKloPnR89Cw1J2aTGexWbIfWbDfFGprb7TGYGpN+rTFAaJCF1V
 USPb3P09t/VcdWFP+H4177eNqrNyXGEcQ/OSvXk+slYRLMHZDaVVuSHWKmbWkWc09R
 w1VVtHdIlmSMA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v4 1/2] workqueue: Add support for real-time workers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
References: <20260804101925.55414-1-tvrtko.ursulin@igalia.com>
 <20260804101925.55414-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:41:12 +0000
Message-Id: <20260804104112.852271F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The rescuer thread for a WQ_RTPRI workqueue executes at SCHED_NORM=
AL (nice -20) rather than SCHED_FIFO, breaking real-time forward-progress g=
uarantees during memory reclaim.

Pre-existing issues:
- [High] restore_unbound_workers_cpumask() restores worker CPU affinity to =
the generic pool cpumask instead of the strict pod cpumask, permanently bre=
aking strict CPU affinity upon CPU hotplug.
--

--- Patch [1]: [RFC v4 1/2] workqueue: Add support for real-time workers ---
commit ef8ef0836020dc31230998f47b57b20e84e4a78c
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

workqueue: Add support for real-time workers

This commit adds support for real-time workers to workqueues by introducing
the WQ_RTPRI flag. These workers use the SCHED_FIFO scheduling policy to
minimize latency spikes for low-latency use cases like DRM scheduling.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 78068ae8f28a6..6b60380a87425 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

[ ... ]

> @@ -5814,6 +5829,12 @@ static struct workqueue_struct *__alloc_workqueue(=
const char *fmt,
>  			return NULL;
>  	}
> =20
> +	if (flags & WQ_RTPRI) {
> +		if (WARN_ON_ONCE((flags & (WQ_HIGHPRI | WQ_UNBOUND)) !=3D
> +			         WQ_UNBOUND))
> +			return NULL;
> +	}
> +

[Severity: High]
Does this code handle the rescuer thread correctly if WQ_RTPRI is combined
with WQ_MEM_RECLAIM?

If normal SCHED_FIFO workers block and memory reclaim is required, the
rescuer thread is created without setting a real-time policy. In
rescuer_thread(), it unconditionally calls set_user_nice() which leaves the
task in SCHED_NORMAL:

kernel/workqueue.c:rescuer_thread() {
    ...
	set_user_nice(current, RESCUER_NICE_LEVEL);
    ...
}

Will this cause a priority inversion where the rescuer runs at a lower
priority than other RT tasks and normal RT workers, potentially starving
the rescuer?

[ ... ]

> @@ -8023,23 +8057,34 @@ void __init workqueue_init_early(void)

[ ... ]

>  	/* create default unbound and ordered wq attrs */
> -	for (i =3D 0; i < NR_STD_WORKER_POOLS; i++) {
> +	for (i =3D 0; i < NR_WQ_ATTRIBUTES; i++) {
>  		struct workqueue_attrs *attrs;
> =20
>  		BUG_ON(!(attrs =3D alloc_workqueue_attrs()));
> +		attrs->prio =3D std_prio[i];
>  		attrs->nice =3D std_nice[i];
> +		if (i =3D=3D WQ_PRIO_RT) {
> +			/*
> +			 * RT workqueues have strict CPU affinity for low
> +			 * latency execution.
> +			 */
> +			attrs->affn_scope =3D WQ_AFFN_CPU;
> +			attrs->affn_strict =3D true;
> +		}

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does CPU hotplug break this strict affinity?

When a CPU comes online, restore_unbound_workers_cpumask() resets the
workers' affinity mask to pool->attrs->cpumask & cpu_online_mask instead
of using the strict pod isolation:

kernel/workqueue.c:restore_unbound_workers_cpumask() {
    ...
	cpumask_and(&cpumask, pool->attrs->cpumask, cpu_online_mask);
	/* as we're called from CPU_ONLINE, the following shouldn't fail */
	for_each_pool_worker(worker, pool)
		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
    ...
}

Since pool->attrs->cpumask represents the global workqueue mask, will
WQ_RTPRI workers suddenly be permitted to migrate freely across all online
CPUs after a hotplug event, completely destroying the strict pod isolation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804101925.5541=
4-1-tvrtko.ursulin@igalia.com?part=3D1
