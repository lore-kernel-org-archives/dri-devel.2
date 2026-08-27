Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF75C5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC1C10EE7C;
	Thu, 27 Aug 2026 06:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZA7YN+Si";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 894FA10EE29;
 Thu, 27 Aug 2026 06:32:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55AC8600D2;
 Thu, 27 Aug 2026 06:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88521F000E9;
 Thu, 27 Aug 2026 06:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787812369;
 bh=mQmjfgS7YYAVm2ByS6htNAS00ixjFDPau5DYIu1CTss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZA7YN+Sid5HgG2wZ2njdc8nyolT2zDLQxzbAr0/b1aQ787htva9F/PGX6R2hkGS44
 Rssv2BvnLDH0RVdTVhY7q5PTXIkSR4OsST1EfXbMKKO/w9b2KAUMiZywNlCvLWhZ4B
 0RthGo01VR8W0y415uq9OH+VKAKe3HBdFT4wVT0CybT5sIcXvilRTCxaFmBzHWssgh
 yfUanRd8SvPsdK20ebtlnrTbalGcLORWyx1X6/cgnJugajrvJZwkAVXhDvJfyn+8Lg
 SK9I8tntvXRZeZOQd3H7bFxrBapsWboYzc67ZuZHL//LNkgGgOpOEYIowQ7gbb2Pov
 X5uqdWQ/2Huvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm: Add common drm_user_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org
In-Reply-To: <20260827062142.4038272-2-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260827062142.4038272-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 06:32:48 +0000
Message-Id: <20260827063248.C88521F000E9@smtp.kernel.org>
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
- [High] Lack of a teardown/cancellation API allows Use-After-Free of drive=
r resources and module memory if a fence signals after context teardown.
- [Medium] Deferred dynamic initialization of `work_struct` leads to uninit=
ialized memory access on teardown, data races, and breaks lockdep tracking.
--

commit 4ecbf619a439e885246ba05ae0272714c1c83eb8
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add common drm_user_fence helper

Introduce a common DRM user fence helper providing the kref-managed,
MM-borrowing dma-fence-callback-to-workqueue pattern used by drivers
that must access userspace memory from a kthread context when a GPU
fence signals.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> index 0000000000000..bd76e3d03120e 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c

[ ... ]

> +static void drm_user_fence_work(struct work_struct *w)
> +{
> +	struct drm_user_fence *ufence =3D
> +		container_of(w, struct drm_user_fence, work);
> +	bool mm_ok =3D false;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		kthread_use_mm(ufence->mm);
> +		mm_ok =3D true;
> +	}
> +
> +	ufence->ops->worker(ufence, mm_ok);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
If the driver module has been unloaded after tearing down its context, will
this jump into unmapped driver module text and cause a kernel panic?

This can happen if a foreign dma-fence signals after driver teardown, as
there is no way to safely detach or cancel the user fence.

> +
> +	if (mm_ok) {
> +		kthread_unuse_mm(ufence->mm);
> +		mmput(ufence->mm);
> +	}
> +
> +	drm_user_fence_put(ufence);
> +}
> +
> +static void drm_user_fence_cb(struct dma_fence *fence, struct dma_fence_=
cb *cb)
> +{
> +	struct drm_user_fence *ufence =3D
> +		container_of(cb, struct drm_user_fence, cb);
> +
> +	INIT_WORK(&ufence->work, drm_user_fence_work);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Will calling INIT_WORK() dynamically here instead of during object
initialization hide the work_struct state from teardown paths and break
lockdep tracking?

The work_struct remains completely uninitialized between the call to
drm_user_fence_init() and the fence signaling, preventing the use of standa=
rd
workqueue teardown functions prior to signaling.

> +	queue_work(ufence->wq, &ufence->work);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Could this dereference a freed workqueue if a foreign dma-fence signals
after the driver has torn down its context?

Since drm_user_fence_add_callback() takes a kref on the ufence and there is
no cancellation API, the ufence remains alive on the foreign dma-fence's
callback list even after the driver device is unbound or the module is
unloaded.

> +}
> +
> +/**
> + * drm_user_fence_init - Initialize a user fence
> + * @ufence: user fence to initialize
> + * @wq: workqueue to run the worker on (must be ordered if sequencing ma=
tters)
> + * @ops: driver operations
> + *
> + * Must be called from process context. Grabs a reference to current->mm.
> + */
> +void drm_user_fence_init(struct drm_user_fence *ufence,
> +			 struct workqueue_struct *wq,
> +			 const struct drm_user_fence_ops *ops)
> +{
> +	kref_init(&ufence->refcount);
> +	ufence->mm =3D current->mm;
> +	mmgrab(ufence->mm);
> +	ufence->wq =3D wq;
> +	ufence->ops =3D ops;
> +}

[Severity: Medium]
Should INIT_WORK() be called here instead?

Initializing the work_struct here would prevent lockdep class divergence and
ensure the work_struct is in a valid state for teardown functions.

> +EXPORT_SYMBOL_GPL(drm_user_fence_init);
> +
> +/**
> + * drm_user_fence_add_callback - Attach a user fence to a dma-fence
> + * @ufence: user fence
> + * @fence: dma-fence to watch; caller retains ownership of this reference
> + *
> + * When @fence signals, a work item is queued that calls ops->worker() w=
ith
> + * the process MM active. If @fence has already signaled the work item is
> + * queued immediately.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int drm_user_fence_add_callback(struct drm_user_fence *ufence,
> +				struct dma_fence *fence)
> +{
> +	int err;
> +
> +	drm_user_fence_get(ufence);
> +	err =3D dma_fence_add_callback(fence, &ufence->cb, drm_user_fence_cb);
> +	if (err =3D=3D -ENOENT) {
> +		/* fence already signaled =E2=80=94 queue work immediately */
> +		INIT_WORK(&ufence->work, drm_user_fence_work);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does calling INIT_WORK() dynamically in two different locations cause lockd=
ep
class divergence?

Since INIT_WORK() allocates a static lock class key at the call site, the
work_struct will receive different lockdep keys depending on whether the
fence was already signaled or not.

> +		queue_work(ufence->wq, &ufence->work);
> +		err =3D 0;
> +	} else if (err) {
> +		drm_user_fence_put(ufence);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(drm_user_fence_add_callback);

> diff --git a/include/drm/drm_user_fence.h b/include/drm/drm_user_fence.h
> index 0000000000000..de8e3f47be186 100644
> --- /dev/null
> +++ b/include/drm/drm_user_fence.h

[ ... ]

> +/**
> + * struct drm_user_fence - embeddable DRM user fence
> + *
> + * Drivers embed this in their own structure and implement
> + * &drm_user_fence_ops. Call drm_user_fence_init() at creation and
> + * drm_user_fence_add_callback() to arm on a dma-fence.
> + */
> +struct drm_user_fence {
> +	/** @refcount: Reference count. */
> +	struct kref refcount;
> +	/** @mm: Process MM grabbed at init time. */
> +	struct mm_struct *mm;
> +	/** @work: Work item queued when the dma-fence signals. */
> +	struct work_struct work;
> +	/** @cb: dma-fence callback. */
> +	struct dma_fence_cb cb;
> +	/** @wq: Workqueue to run @work on. */
> +	struct workqueue_struct *wq;
> +	/** @ops: Driver operations. */
> +	const struct drm_user_fence_ops *ops;
> +};

[Severity: High]
Does this API need a cancellation mechanism (e.g., drm_user_fence_cancel())?

Without a way to safely detach the ufence from a foreign dma-fence's
callback list, the ufence remains alive and bound to driver resources even
after the driver tears down its context, which can lead to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827062142.4038=
272-1-srinivasan.shanmugam@amd.com?part=3D1
