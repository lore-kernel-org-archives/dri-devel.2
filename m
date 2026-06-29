Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06B9C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE5C10E816;
	Mon, 29 Jun 2026 10:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HWaF98Oz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFB210E816
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:52:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4F1F600AA
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6D1F000E9;
 Mon, 29 Jun 2026 10:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782730353;
 bh=JRE6aOi7qNylU5nbAZbVIIGRSgiREscbRG6ceE8f0Q0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HWaF98Oza9GaS+ANiO0bTjMdcGiBZMEmFkqpNxzbESLfHGAZdOiq6bvfmgPrAUjps
 RzDifpyRBWmZz2PcB0uXi2K3gcT7xzydhkJm6CYT8mpe1l+9AgUeTpPc4FEtZVnX9d
 BQ3gTUjcLODGhW0xbUXfJqeY3rV1PSkdbLH6z2eByzOX7ojiGnf/e6qzRtZSB3jyai
 sWwPae0YNtQ7ohKYnzXk2eH6aFyP+FUpLTlOq+BZOPtgp1kk6bxH6XAcUS9Tn9ePI5
 plY7WKGMlcUKocARFcJWrxdKMeZcuWx7nK/ByLx0oYb6zr9X/HQT++ScldbJ8CpY+Z
 MmsZ82O4lhxOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/sched: Guard sched->ready with ACCESS_ONCE()
To: "Philipp Stanner" <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629104040.2695163-2-phasta@kernel.org>
References: <20260629104040.2695163-2-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 10:52:33 +0000
Message-Id: <20260629105233.67E6D1F000E9@smtp.kernel.org>
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

New issues:
- [Low] The commit message incorrectly references the deprecated ACCESS_ONC=
E() macro.

Pre-existing issues:
- [Critical] When all schedulers are marked as not ready, drm_sched_pick_be=
st() returns NULL, leading to a fatal NULL pointer dereference during job s=
ubmission.
- [High] A TOCTOU race in drm_sched_run_job_queue allows work to be queued =
to a destroyed workqueue during scheduler teardown.
--

commit c1a983b76226585f5c944e3f1f105517183427a9
Author: Philipp Stanner <phasta@kernel.org>
Subject: drm/sched: Guard sched->ready with ACCESS_ONCE()

This commit modifies the tracking of the scheduler's ready state by wrapping
accesses to the 'ready' flag with READ_ONCE() and WRITE_ONCE() to prevent
compiler optimization issues.

> drm/sched: Guard sched->ready with ACCESS_ONCE()
>
> commit faf6e1a87e07 ("drm/sched: Add boolean to mark if sched is ready to=
 work v5")
[ ... ]
> Make the code base more robust by guarding access to the 'ready' flag
> with ACCESS_ONCE().

[Severity: Low]
The commit message claims to guard access with ACCESS_ONCE(), but the code
actually uses READ_ONCE() and WRITE_ONCE(). ACCESS_ONCE() was deprecated
and removed from the kernel. Could the commit message be updated to match
the implementation?

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -929,7 +929,7 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_=
list,
>  	for (i =3D 0; i < num_sched_list; ++i) {
>  		sched =3D sched_list[i];
> =20
> -		if (!sched->ready) {
> +		if (!READ_ONCE(sched->ready)) {

[Severity: Critical]
This is a pre-existing issue, but does this lead to a fatal page fault if
all schedulers are marked as not ready?=20

If all schedulers in entity->sched_list fail this READ_ONCE(sched->ready)
check, drm_sched_pick_best() returns NULL. When this happens,
drm_sched_entity_select_rq() sets entity->rq to NULL.=20

Later, when a job is submitted, drm_sched_job_arm() computes a pointer
using container_of(entity->rq, ...), which results in an invalid negative
pointer since entity->rq is NULL. This invalid pointer is then dereferenced
in drm_sched_entity_push_job() via atomic_inc(sched->score).

The documentation for drm_sched_job_init() mentions returning -ENOENT when
the hardware has died (which causes this ready flag to be false), but the
function actually returns 0. Should drm_sched_job_init() or the callers
be updated to properly handle the NULL return from drm_sched_pick_best()?

>  			DRM_WARN("scheduler %s is not ready, skipping",
>  				 sched->name);
>  			continue;
[ ... ]
> @@ -1143,7 +1143,18 @@ void drm_sched_fini(struct drm_gpu_scheduler *sche=
d)
> =20
>  	if (sched->own_submit_wq)
>  		destroy_workqueue(sched->submit_wq);

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
risk when destroying the workqueue here?

Functions like drm_sched_run_job_queue() check !drm_sched_is_stopped(sched)
locklessly before calling queue_work(sched->submit_wq, ...). If a thread is
preempted right after the check, and concurrently drm_sched_fini() calls
drm_sched_wqueue_stop(), the cancel_work_sync() will return immediately
because the work isn't queued yet.=20

drm_sched_fini() then proceeds to destroy sched->submit_wq. When the
preempted thread resumes, it calls queue_work() on the destroyed workqueue.
Can the workqueue destruction be safely synchronized against threads that
might be paused in this time-of-check to time-of-use window?

> -	sched->ready =3D false;
> +
> +	/* The 'ready' flag only exists in drm_sched because amdgpu uses it to
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629104040.2695=
163-2-phasta@kernel.org?part=3D1
