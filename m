Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACFACDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E1610EB3C;
	Tue, 23 Jun 2026 13:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eoDM+za0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13C910EB3C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:07:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D1A142B38;
 Tue, 23 Jun 2026 13:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C27B1F000E9;
 Tue, 23 Jun 2026 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782220056;
 bh=yMHCnCEzHwZkB8OM1Z/fjBH5zmNkjXT/GkoFqhkOK40=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eoDM+za0ZFYtvS9pTrjraOy92gjXZcgijr9zMXXYSifsOj3tdG5xBhanHxoPA5sWx
 Sgay11yqIfZTOA9opyYZN13WvQB/rpaGU+ytL0/CMuNlCllOnlFmcq7bQfXUYiZhvq
 +Gd5Zey/GjZ1K3ft+GlyL3ak22hTtpe8PHcyP+y3e/vUYtEiQ1z4Zda0w2wAzXHFtT
 nwbqh8CnwdSJnc/esFkm8V0cV0rAOOo73co9OjicTHnNnLh0v2Mxmr45sWK94hf7jU
 WG8p7/DEgIr9GQ6iUrpm4h+bEQoA0hmPhND2ePOKxfcUIhVTjaFp8IW0nMZT2ys73X
 YZxEPjXsXX9eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] drm/panthor: Protect events processing with a
 separate spinlock
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623-panthor-signal-from-irq-v3-4-2ece396f8ee0@collabora.com>
References: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
 <20260623-panthor-signal-from-irq-v3-4-2ece396f8ee0@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:07:35 +0000
Message-Id: <20260623130736.1C27B1F000E9@smtp.kernel.org>
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
- [High] Data race and lost updates on `group->fatal_queues` due to split l=
ocking.
- [Medium] Data race on `group->timedout` boolean flag due to split locking.
- [Medium] Data race on `sched->might_have_idle_groups` due to split lockin=
g.
--

commit db6f3f8002805cdf65efff6be24738f26e5f60a4
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Protect events processing with a separate spinlock

This commit introduces a new events_lock spinlock in the panthor scheduler.
It aims to protect event processing and command stream group (CSG) slot
updates, allowing some event processing to be moved to a threaded IRQ
handler.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 5b34032deff81..4f5d874e5d468 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
[ ... ]
> @@ -1484,7 +1497,7 @@ cs_slot_process_fatal_event_locked(struct panthor_d=
evice *ptdev,
>  	u32 fatal;
>  	u64 info;
> =20
> -	lockdep_assert_held(&sched->lock);
> +	lockdep_assert_held(&sched->events_lock);
> =20
>  	cs_iface =3D panthor_fw_get_cs_iface(ptdev, csg_id, cs_id);
>  	fatal =3D cs_iface->output->fatal;

[Severity: High]
With this change, cs_slot_process_fatal_event_locked() now executes with on=
ly
events_lock held, which means the subsequent update to group->fatal_queues
inside this function is no longer protected by sched->lock:

    group->fatal_queues |=3D BIT(cs_id);

However, in tick_ctx_init(), we update this same field while holding
sched->lock, but after dropping the scoped events_lock:

    if (!group->fatal_queues)
        group->fatal_queues |=3D GENMASK(group->queue_count - 1, 0);

Could this result in a data race and lost updates on group->fatal_queues if
these two paths execute concurrently on different CPUs? If the non-atomic
read-modify-write operations overlap, one of the updates might be lost,
potentially leaving a faulty queue unflagged.

This is a pre-existing issue, but it's worth noting that
group_process_tiler_oom() also performs a lockless read-modify-write on
group->fatal_queues:

    group->fatal_queues |=3D BIT(cs_id);

[ ... ]
> @@ -1731,7 +1744,7 @@ static void csg_slot_process_idle_event_locked(stru=
ct panthor_device *ptdev, u32
>  {
>  	struct panthor_scheduler *sched =3D ptdev->scheduler;
> =20
> -	lockdep_assert_held(&sched->lock);
> +	lockdep_assert_held(&sched->events_lock);
> =20
>  	sched->might_have_idle_groups =3D true;
> =20

[Severity: Medium]
Will this lead to a data race on sched->might_have_idle_groups?=20

csg_slot_process_idle_event_locked() sets this flag to true while holding
events_lock. But in tick_ctx_apply(), the flag is overwritten under
sched->lock without holding events_lock:

    sched->might_have_idle_groups =3D ctx->idle_group_count > 0;

Because these paths do not share a common lock, they can execute
concurrently, which violates the C memory model and might trigger KCSAN
warnings.

[ ... ]
> @@ -1763,7 +1776,7 @@ csg_slot_process_progress_timer_event_locked(struct=
 panthor_device *ptdev, u32 c
>  	struct panthor_csg_slot *csg_slot =3D &sched->csg_slots[csg_id];
>  	struct panthor_group *group =3D csg_slot->group;
> =20
> -	lockdep_assert_held(&sched->lock);
> +	lockdep_assert_held(&sched->events_lock);
> =20
>  	group =3D csg_slot->group;
>  	if (!drm_WARN_ON(&ptdev->base, !group)) {

[Severity: Medium]
Since csg_slot_process_progress_timer_event_locked() now holds events_lock
instead of sched->lock, is it still safe to modify group->timedout here?

    group->timedout =3D true;

Other paths like panthor_sched_suspend() and panthor_job_timedout() modify
and read group->timedout while holding only sched->lock:

    csg_slot->group->timedout =3D true;

Concurrent writes from the event processing workqueue and the suspend/timeo=
ut
paths could cause a data race on this boolean flag.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-panthor-si=
gnal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=3D4
