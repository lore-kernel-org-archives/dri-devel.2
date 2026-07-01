Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCBCC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050EE10E325;
	Wed,  1 Jul 2026 09:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHewyQdB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8966F10E325
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:09:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E2994401A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0808D1F000E9;
 Wed,  1 Jul 2026 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782896970;
 bh=JN+VrH5Wvnu4KZ51wcbk+KEnUtjBBM5xp6bf8sJ7vvM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHewyQdB8AXXUtistorwIPAGWmPjtMpxQbteU+rqX5fS7R+rWIhSttgY+mmEQnW48
 xW3RNQ60QmSRgZj9iflXu/kNWzOz5tiYIhWeL6UYPqoC9NtpRzeGd+VSsWISbenqcV
 wlyEtrbjwufWjgncRUBwolM/eNnH+ftoAGoMBqRhSx7Q0BDmIDWS9Yx2q1ESK6CTcI
 f6AftIpxSxDV3P0mEl91qQMWeBC0f0hg+EtAy6EO4w7xjIzZnmN9VCK+l//L/zfv/7
 odzm7svgfVqThpVRdK+g9gcxy6jzjplR2Zk3ucL52/uyp32sx+c6QePxGhBRcPi7qS
 YeQRWdz3RalZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/sched: Remove entity->entity_idle
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701085920.3253248-7-phasta@kernel.org>
References: <20260701085920.3253248-2-phasta@kernel.org>
 <20260701085920.3253248-7-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 09:09:29 +0000
Message-Id: <20260701090930.0808D1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removing the `entity_idle` completion introduces a critical ra=
ce condition between the scheduler worker thread and the entity teardown pa=
th, leading to Use-After-Free (UAF) vulnerabilities and SPSC queue corrupti=
on.
--

commit f72f2810652760301a56b6a9cbcac8c26715a4a4
Author: Philipp Stanner <phasta@kernel.org>

drm/sched: Remove entity->entity_idle

The completion entity->entity_idle only existed because the entity was
not properly locked through it's spinlock. The completion served to
inform waiters about whether the entity is actually idle, which is
something locking (previously added to drm_sched_entity_is_idle()) can
fully achieve.

> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/s=
cheduler/sched_entity.c
> index cb03d6a36578b..23536dcfa96a9 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
[ ... ]
> @@ -285,12 +281,7 @@ void drm_sched_entity_kill(struct drm_sched_entity *=
entity)
>  	spin_lock(&entity->lock);
>  	entity->stopped =3D true;
>  	drm_sched_rq_remove_entity(entity->rq, entity);
> -	spin_unlock(&entity->lock);
> =20
> -	/* Make sure this entity is not used by the scheduler at the moment */
> -	wait_for_completion(&entity->entity_idle);
> -
> -	spin_lock(&entity->lock);

[Severity: High]
Does removing this completion introduce a regression involving a race condi=
tion
between the scheduler worker thread and the entity teardown path?

If a userspace application submits gpu jobs and is simultaneously killed wi=
th
a fatal signal, wait_event_killable() in drm_sched_entity_flush() can return
-ERESTARTSYS immediately, bypassing the idle wait.

Then drm_sched_entity_kill() executes and returns without waiting for the
worker thread, allowing the entity to be freed while the scheduler worker
thread is concurrently extracting a job.

This could lead to concurrent spsc_queue_pop() calls in
drm_sched_entity_pop_job() violating spsc queue invariants.

It could also lead to a use-after-free when the worker thread accesses the
freed entity pointer:

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_run_job_work() {
    ...
    sched_job =3D drm_sched_entity_pop_job(entity);
    if (!sched_job) {
    ...
    trace_drm_sched_job_run(sched_job, entity);
    ...
}

>  	prev =3D entity->last_scheduled;
>  	dma_fence_get(prev);
>  	spin_unlock(&entity->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701085920.3253=
248-2-phasta@kernel.org?part=3D5
