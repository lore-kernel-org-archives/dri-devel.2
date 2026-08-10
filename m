Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728BFC5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEE510E207;
	Mon, 10 Aug 2026 16:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LTOCLhhv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B8E010E207
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:35:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D13C60052;
 Mon, 10 Aug 2026 16:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B9E1F000E9;
 Mon, 10 Aug 2026 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786379728;
 bh=qEY8qdMreXYjz2T+5hvc/rMIYQdNixr1BKfyCRS9vvM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LTOCLhhv1tEGQ07WNr2qqq5RcvcSYddWiG5UDCRUbdAK2sOwHODKFnJRO5HSj3zDY
 oLm1FK+a1SulzJrkbWKvIZg8p20rnu8iKIabOYDmp1DoLkRISLqAVBKTkZx4gikjpQ
 LMnte0w5++dI4NzXSJ/mHWL44NyBJoCHhn2RzqPgDXbzlyx9Dw76GddAXGvq9xrBV3
 kRxHYFUMvrN4oamwcktRDManq//nqPQcHs4b/81FqYYc8SLeHnvNLD+I06Bo7JNmRD
 ycfD1vkYEHDy7XECkCgbmOMwXYm31niG1p7wk/ffkD6oVkZ+bAufxbdH3Xt5CHGAzS
 ItSSF9BGlXFrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/amdgpu/userq: bound the eviction fence rearm
 retry loop
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-amdgpu-fixes-v1-3-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-3-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:35:27 +0000
Message-Id: <20260810163528.38B9E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] The retry loop in amdgpu_userq_ensure_ev_fence() fails permanent=
ly with -ENOMEM when ev_fence_seq wraps to -1.

Pre-existing issues:
- [High] Wait dependencies are permanently lost if an error path unwinds th=
e IOCTL or if the IOCTL restarts.
- [High] Missing cancellation of queue->hang_detect_work in the amdgpu_user=
q_create() error path leads to Use-After-Free.
- [High] Leaking fence_drv references stored in fence_drv_array when a fenc=
e is destroyed on error paths or queue teardown.
- [High] Missing rcu_assign_pointer and premature reference drop when updat=
ing evf_mgr->ev_fence causes deadlock and uninitialized memory access.
--

--- Patch [3]: [PATCH 3/5] drm/amdgpu/userq: bound the eviction fence rearm=
 retry loop ---
commit ad19a8a5be75c8d4ceb626d159cd7abccb2976c4
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu/userq: bound the eviction fence rearm retry loop

This patch bounds a previously infinite loop in the userq eviction fence
rearm logic by verifying that the sequence number has advanced. It returns
-ENOMEM if the rearm worker fails to make progress.

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -448,12 +448,16 @@ static void amdgpu_userq_cleanup(struct amdgpu_user=
mode_queue *queue)
>  int
>  amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>  			     struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	struct dma_fence *ev_fence;
> +	int seq, prev_seq =3D -1;
> =20
>  retry:
[ ... ]
>  	if (dma_fence_is_signaled(ev_fence)) {
>  		dma_fence_put(ev_fence);
> +		seq =3D atomic_read(&evf_mgr->ev_fence_seq);
>  		mutex_unlock(&uq_mgr->userq_mutex);
> +		/*
> +		 * The sequence number is only bumped by a successful rearm, so
> +		 * if the flush above ran the worker without moving it then the
> +		 * restore failed and looping again would never terminate.
> +		 */
> +		if (seq =3D=3D prev_seq)
> +			return -ENOMEM;

[Severity: Medium]
Could this condition match incorrectly if the sequence number wraps around?

Since ev_fence_seq is a 32-bit atomic counter incremented on successful
rearms, it will eventually wrap to -1 (0xFFFFFFFF).

If prev_seq is initialized to -1, seq =3D=3D prev_seq would evaluate to true
on the first loop iteration when the counter wraps.

Does this cause amdgpu_userq_ensure_ev_fence() to immediately return
-ENOMEM without attempting to schedule the resume worker, permanently
wedging the user queue manager?

> +		prev_seq =3D seq;
[ ... ]
> @@ -747,7 +762,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>  	if (r)
>  		goto clean_mqd;
> =20
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	r =3D amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	if (r)
> +		goto erase_doorbell;

[Severity: High]
This is a pre-existing issue, but can the goto erase_doorbell error path
cause a use-after-free of the queue structure?

Looking at amdgpu_userq_create(), the queue is inserted into
adev->userq_doorbell_xa earlier in the function, making it globally
visible.

If a hardware fault occurs and schedules queue->hang_detect_work, and then
this error path frees the queue without calling
cancel_delayed_work_sync(&queue->hang_detect_work), will the deferred work
access the freed queue later?

>  	/* don't map the queue if scheduling is halted */
[ ... ]
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -523,7 +523,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev=
, void *data,
>  		goto put_queue;
> =20
>  	/* We are here means UQ is active, make sure the eviction fence is vali=
d */
> -	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	r =3D amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
> +	if (r) {
> +		/* The fence is not initialized yet, so unwind it by hand */
> +		amdgpu_userq_fence_put_fence_drv_array(fence);
> +		amdgpu_userq_fence_driver_put(fence->fence_drv);
> +		kvfree(fence->fence_drv_array);
> +		kfree(fence);
> +		goto put_queue;
> +	}

[Severity: High]
This is a pre-existing issue, but does unwinding the fence here permanently
lose synchronization dependencies?

In amdgpu_userq_fence_alloc(), xa_extract() destructively removes fence
drivers from queue->fence_drv_xa and moves them into fence_drv_array.

If we abort here, the fence and its array are freed, but the dependencies
are never restored to the xarray. If the IOCTL restarts (for example, from
-ERESTARTSYS later), won't it create a new fence missing all previous wait
dependencies?

[Severity: High]
This is also a pre-existing issue, but does amdgpu_userq_fence_free()
leak these extracted dependencies on normal release paths?

While the hand-unwind path above correctly calls
amdgpu_userq_fence_put_fence_drv_array(fence), the standard cleanup
routine misses this:

drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:amdgpu_userq_fence_free() {
    ...
    kvfree(userq_fence->fence_drv_array);
    kfree(userq_fence);
    ...
}

Since amdgpu_userq_fence_free() frees the array memory without dropping the
refcounts of the fence_drv objects inside it, do they leak permanently?

> =20
>  	/* Create the new fence */
>  	amdgpu_userq_fence_init(queue, fence, wptr);
[ ... ]

While reviewing the eviction fence code related to this patch, I noticed
another pre-existing issue:

[Severity: High]
This is a pre-existing issue, but does this direct assignment without
rcu_assign_pointer() risk a deadlock and uninitialized memory access?

drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c:amdgpu_evf_mgr_rearm() {
    ...
    dma_fence_put(evf_mgr->ev_fence);
    evf_mgr->ev_fence =3D &ev_fence->base;
    ...
}

evf_mgr->ev_fence is an RCU annotated pointer. Dropping the reference
to the old fence before the assignment could leave the pointer referencing a
zero-refcount object if preempted here.

A concurrent reader using dma_fence_get_rcu_safe() might enter an infinite
loop if kref_get_unless_zero() fails. Furthermore, without a release
barrier, concurrent readers might see the new fence before it is fully
initialized.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-amdgpu-fix=
es-v1-0-4954a417b8ff@outlook.com?part=3D3
