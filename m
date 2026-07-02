Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12226C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4198510F1A4;
	Thu,  2 Jul 2026 07:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7oeX840";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97A010F1A4
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:32:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7448B43A1E;
 Thu,  2 Jul 2026 07:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D61F000E9;
 Thu,  2 Jul 2026 07:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977538;
 bh=wbajQ4simsNInqwjwkXf6RfflKw/sO/s2NbgH9WTRPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7oeX840TQYi85dhLkHVzgYKWcLySiBwUHJUNySu7Rm+PmY7IGRFKLCKpuGHFBmRo
 zSx/6zmUPbhEqZlgNd1VvmDKl9qGllu141Yd2v6vTSCUhmWJpm3BLqtfcCuGv+5OqS
 W+Mum2EzsZQEPYW0tPYQ46E64b++lVCQ6VM4V7pjcBY7i1aen9Rn5p/vLKrkTfNSc9
 7y6ToYLBYxcCj4soYgsRSQModHKrF4VAaMa2/aCTQI7llItBNqvlOmjuXPmqJ9kSfB
 vlCJwrCLKqK/yox7q0KGV5YAK5sNdtY8StlCWWl43h76nfPHQUz1lG5RvJtoFhLqIs
 e4ZHCF7vcrwAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] drm/vblank_work: Add methods to schedule
 vblank_work in 2 stages
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-2-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:32:17 +0000
Message-Id: <20260702073218.413D61F000E9@smtp.kernel.org>
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
- [High] Missing read memory barrier (`smp_rmb` or `smp_load_acquire`) when=
 reading `work->armed` in `drm_handle_vblank_works` breaks transitive order=
ing.
- [Medium] `drm_vblank_work_schedule` early return logic fails to arm a dis=
abled work if the target vblank count is identical.

Pre-existing issues:
- [High] Use-after-free risk due to calling `list_del_init(&work->node)` af=
ter `kthread_queue_work()`.
--

commit 2d70bdfd10b5fd90f1bf2ecac514ae3f86ae65ba
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/vblank_work: Add methods to schedule vblank_work in 2 stages

In case of vblank evasion in intel/display, it's necessary to
perform some work in advance, so the critical section will always run in
constant time on PREEMPT_RT.

> diff --git a/drivers/gpu/drm/drm_vblank_work.c b/drivers/gpu/drm/drm_vbla=
nk_work.c
> index 70f0199251ea0..ed62c189fe041 100644
> --- a/drivers/gpu/drm/drm_vblank_work.c
> +++ b/drivers/gpu/drm/drm_vblank_work.c
> @@ -54,7 +54,8 @@ void drm_handle_vblank_works(struct drm_vblank_crtc *vb=
lank)
>  	assert_spin_locked(&vblank->dev->event_lock);
> =20
>  	list_for_each_entry_safe(work, next, &vblank->pending_work, node) {
> -		if (!drm_vblank_passed(count, work->count))
> +		/* READ_ONCE pairs with WRITE_ONCE in drm_vblank_work_enable() */
> +		if (!READ_ONCE(work->armed) || !drm_vblank_passed(count, work->count))
>  			continue;

[Severity: High]
Does this READ_ONCE() need a corresponding read memory barrier like
smp_rmb() or smp_load_acquire() to establish transitive ordering?

Since drm_vblank_work_enable() uses an smp_wmb() before writing to
work->armed, if the reader just uses READ_ONCE() here without an acquire
barrier before transferring the work via kthread_queue_work(), the memory
model doesn't guarantee the writer's data updates will be transitively
visible to the worker thread.

Could the kthread end up reading stale driver state as a result?

[ ... ]

> @@ -139,6 +118,7 @@ int drm_vblank_work_schedule(struct drm_vblank_work *=
work,
>  		rescheduling =3D true;
>  	}
> =20
> +	work->armed =3D armed;
>  	work->count =3D count;

[Severity: Medium]
Does the early return logic in __drm_vblank_work_schedule() break if a work
item is first scheduled disabled, and then re-scheduled to be armed with the
exact same target count?

Earlier in __drm_vblank_work_schedule(), if work->count =3D=3D count, the f=
unction
takes an early return:

	} else if (work->count =3D=3D count) {
		/* Already scheduled w/ same vbl count */
		goto out;
	} else {

If a driver uses drm_vblank_work_schedule_disabled() to schedule the work,
and later calls drm_vblank_work_schedule() with the exact same count to arm=
 it,
doesn't the early return bypass this new work->armed =3D armed assignment?

Could this leave the work permanently disabled and never executed?

[ ... ]

> @@ -147,7 +127,7 @@ int drm_vblank_work_schedule(struct drm_vblank_work *=
work,
>  			     "crtc %d vblank %llu already passed (current %llu)\n",
>  			     vblank->pipe, count, cur_vbl);
> =20
> -	if (!nextonmiss && passed) {
> +	if (!nextonmiss && passed && armed) {
>  		drm_vblank_put(dev, vblank->pipe);
>  		ret =3D kthread_queue_work(vblank->worker, &work->base);
> =20

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk here when
rescheduling a work item that has already passed?

If rescheduling is true, the code right below this in
__drm_vblank_work_schedule() does:

		ret =3D kthread_queue_work(vblank->worker, &work->base);

		if (rescheduling) {
			list_del_init(&work->node);
			wake =3D true;
		}

Since kthread_queue_work() immediately places the work on the worker's queu=
e,
could the worker thread run concurrently and execute the work before
list_del_init() is called on the current CPU?

If the work is freed by the executing kthread, the list_del_init() call
would then access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D1
