Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FA2CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202ED10E05A;
	Thu,  1 Oct 2026 16:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X8MbAy59";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C10110E32D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:21:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B91842A57;
 Thu,  1 Oct 2026 16:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F58C1F000FF;
 Thu,  1 Oct 2026 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790871705;
 bh=jzGKhs38uD/BkmuQm8hjDGlWWheEzEwWEuXcjrLGhOo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X8MbAy598F9BFuTJDruUiL+t3iheHpkAaabYTISnSsHN7wI8U8b6WOuasivZuO212
 Y62Aod8GZJ6hF1C0gWxSznWvng6awT6QmksRpkH6BKrjF9YPlYAl0dwpOOqIT8AC/6
 FjiLrr6m2Xj2UPL0xP9sAA1DFLL7wYcNR4V9Df9QbxfdEMcKnwB4Pd8TXNc9pSZRI9
 qqDrvdlOhfijf9XPPJsi/0e2GLHpAxLAUIpzkfJQGhuiuyvUTu1cn4LVZ1/oVbnWFX
 Y/pw18YZ2g174oPWfZISiiswDRTsUyqR78YFUmLk4iGhrgx+/wtSLCsXsU50HT6nhZ
 VLBzUt1pdLKMw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v6 2/3] workqueue: Add support for real-time workers
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
References: <20261001160711.59888-1-tvrtko.ursulin@igalia.com>
 <20261001160711.59888-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:21:43 +0000
Message-Id: <20261001162144.3F58C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Zero-initialization in alloc_workqueue_attrs_noprof() promotes bac=
kground workqueues to RT
- [Medium] WQ_RT workers are created as standard CFS tasks due to incorrect=
 RT_PRIORITY
- [Medium] Sysfs cpumask attribute allows modifying strict CPU affinity of =
WQ_RT workqueues
--

commit c69a2e22b185b64246092a869b9af42c347b149b
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

    workqueue: Add support for real-time workers
   =20
    For use cases such as the DRM scheduler submitting work to the GPU on
    behalf of low latency userspace applications, where latter have suffici=
ent
    privileges to have had successfully obtained realtime Vulkan global
    priority, competing with random background CPU load can create large
    latency spikes which gets in the way of a smooth user experience.

> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index c8a36423cb346..d37b8bee37c6f 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -147,9 +147,9 @@ enum wq_affn_scope {
>   */
>  struct workqueue_attrs {
>  	/**
> -	 * @nice: nice level
> +	 * @prio: priority encoded analoguous to task_struct->prio.
>  	 */
> -	int nice;
> +	int prio;

[Severity: High]
Does introducing this prio field cause a regression where
alloc_workqueue_attrs_noprof() implicitly promotes background workqueues to
real-time?

When alloc_workqueue_attrs_noprof() allocates the attribute structure with
kzalloc_obj(), the newly introduced prio field is zero-initialized rather t=
han
being explicitly set to DEFAULT_PRIO (120).

In the kernel priority scale, 0 is equivalent to MAX_DL_PRIO. When these
attributes are applied to a pool, rt_prio(0) evaluates to true, causing
create_worker() to call sched_set_fifo_low(worker->task).

Subsystems that dynamically allocate attributes without manually assigning a
priority (like padata) may inadvertently apply real-time priority to parall=
el
CPU-intensive workloads.

[ ... ]

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 71423d9b7cf96..93a73ebefecd3 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -126,7 +127,8 @@ enum wq_internal_consts {
>  	 * all cpus.  Give MIN_NICE.
>  	 */
>  	RESCUER_NICE_LEVEL	=3D MIN_NICE,
> -	HIGHPRI_NICE_LEVEL	=3D MIN_NICE,
> +	HIGHPRI_PRIORITY	=3D NICE_TO_PRIO(MIN_NICE),
> +	RT_PRIORITY		=3D MAX_PRIO,

[Severity: Medium]
Will this assignment cause a regression where WQ_RT workers are created as
standard CFS tasks instead of real-time tasks?

When creating a WQ_RT worker, its priority is set to RT_PRIORITY. However, =
since
RT_PRIORITY is defined as MAX_PRIO (140), passing it to rt_prio(140) evalua=
tes
to false, as 140 is not < 100.

[ ... ]

> @@ -3018,7 +3021,12 @@ static struct worker *create_worker(struct worker_=
pool *pool)
>  			goto fail;
>  		}
> =20
> -		set_user_nice(worker->task, pool->attrs->nice);
> +		if (rt_prio(pool->attrs->prio))
> +			sched_set_fifo_low(worker->task);
> +		else
> +			set_user_nice(worker->task,
> +				      PRIO_TO_NICE(pool->attrs->prio));
> +

[Severity: Medium]
When execution falls back here to set_user_nice() for WQ_RT workers due to
the RT_PRIORITY value, won't it pass PRIO_TO_NICE(140) which equals 20?

Since 20 exceeds MAX_NICE (19), the nice change is silently ignored and the
real-time workqueues fail to receive the intended real-time scheduling poli=
cy.

>  		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
>  	}

[ ... ]

> @@ -7740,6 +7771,10 @@ static ssize_t affinity_scope_store(struct device =
*dev,
>  	struct workqueue_attrs *attrs;
>  	int affn, ret =3D -ENOMEM;
> =20
> +	/* Do not allow affinity changes for RT workers. */
> +	if (wq->flags & WQ_RT)
> +		return -EINVAL;
> +
>  	affn =3D parse_affn_scope(buf);
>  	if (affn < 0)
>  		return affn;

[Severity: Medium]
Should unbound_cpumask_store() also restrict affinity changes for RT workers
to prevent a regression?

While affinity_scope_store() and affinity_strict_store() explicitly block
modifications for WQ_RT workqueues by returning -EINVAL here, the adjacent
unbound_cpumask_store() lacks this check.

This omission allows users with write permissions to the sysfs node to break
the strict CPU affinity binding of WQ_RT workqueues, violating the document=
ed
invariant.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001160711.5988=
8-1-tvrtko.ursulin@igalia.com?part=3D2
