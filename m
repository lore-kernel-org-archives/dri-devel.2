Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28541C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853A310ECBB;
	Wed, 29 Jul 2026 16:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCck5IkD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C7710ECBB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:15:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52B516001D;
 Wed, 29 Jul 2026 16:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA31F00A3A;
 Wed, 29 Jul 2026 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341706;
 bh=H0/aNtZEq38iyubsPkHfAxQ8gJ19sq3+u24qtjHea4w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LCck5IkDWI+lhR2aL/KeyQzBf2ZjbIpjzp6U6++Fr0i5Stv7Sx7iVUb426T0FQE7j
 Vfyu8AMQ/L2hSAj4GypKH4Y09x60GgqqfPB9ez2Ck56VHvtxMLBnFpmBynLGRTCXGE
 bX/KSP1eX8qUD22HUUVR1gD8RoWw852/JZakFCMoB4JLeBA15mi8SuWSiNXv6DqbNb
 jVWxtAhW9HZd3ahyTPBODP/UyOxzXjY8Rf7C30znjy5HzOIZPBvaXt22LPsMUMrZAZ
 INmK+hvU/PA2Z5+6GN/VgdBb1NDpwzOq4S4V9HS9QieRA+2OCgF3XZsrNSEYY/6VGd
 2lE1J1nA7qEfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/17] drm/msm: Fix barriers accessing ctx vm
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-2-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:15:05 +0000
Message-Id: <20260729161505.C4DA31F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Directly accessing `ctx->vm` in ioctl entry points before ensu=
ring the VM is initialized via `msm_context_vm()` causes a NULL pointer der=
eference on the first operation.
- [Critical] `msm_context_vm()` unconditionally caches an `ERR_PTR` inside =
`ctx->vm` upon allocation failure, permanently breaking the context and cau=
sing crashes on subsequent accesses.
- [Critical] Callers of `msm_context_vm()` fail to check if the returned va=
lue is an error pointer, leading to a crash on VM creation failure.
- [High] The patch misses concurrent readers like `msm_gem_close()` that st=
ill perform plain reads of `ctx->vm`, leaving them vulnerable to data races=
 and partially initialized VM states.
--

--- Patch [1]: [PATCH v7 01/17] drm/msm: Fix barriers accessing ctx vm ---
Commit SHA: 8c0550637c7f990d073da2dbc73f127555883df0
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drm/msm: Fix barriers accessing ctx vm

This commit updates msm_context_vm() to use proper memory barriers
(smp_load_acquire and smp_store_release) to prevent callers from observing
a partially initialized VM.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index ac86b427c0e53..29075aafc5cc5 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -224,18 +224,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
*dev, struct msm_context *ctx
>  {
>  	static DEFINE_MUTEX(init_lock);
>  	struct msm_drm_private *priv =3D dev->dev_private;
> +	struct drm_gpuvm *vm =3D smp_load_acquire(&ctx->vm);
> =20
>  	/* Once ctx->vm is created it is valid for the lifetime of the context:=
 */
> -	if (ctx->vm)
> -		return ctx->vm;
> +	if (vm)
> +		return vm;
> +
> +	guard(mutex)(&init_lock);
> =20
> -	mutex_lock(&init_lock);
>  	if (!ctx->vm) {
> -		ctx->vm =3D msm_gpu_create_private_vm(
> +		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -
> +		smp_store_release(&ctx->vm, vm);

[Severity: Critical]
This is a pre-existing issue, but I noticed that msm_gpu_create_private_vm()
can return an ERR_PTR on failure (e.g., if page table allocation fails).=20

If we store that ERR_PTR into ctx->vm without an IS_ERR() check, will=20
future fast-path readers see this truthy pointer and attempt to dereference=
=20
the error value as a valid VM?

>  	}
> -	mutex_unlock(&init_lock);
> =20
>  	return ctx->vm;
>  }

[Severity: Critical]
This is also a pre-existing issue, but does submit_create() need to check=20
the return value of msm_context_vm() before assigning it to submit->vm?

drivers/gpu/drm/msm/msm_gem_submit.c:submit_create() {
	...
	submit->dev =3D dev;
	submit->vm =3D msm_context_vm(dev, queue->ctx);
	submit->gpu =3D gpu;
	...
}

If it returns an ERR_PTR, it will eventually cause a panic when submit->vm=
=20
is dereferenced.

Similarly, in msm_submitqueue_create():

drivers/gpu/drm/msm/msm_submitqueue.c:msm_submitqueue_create() {
	...
	if (flags & MSM_SUBMITQUEUE_VM_BIND) {
		struct drm_gpu_scheduler *sched =3D
			&to_msm_vm(msm_context_vm(drm, ctx))->sched;

		queue->entity =3D &queue->_vm_bind_entity[0];
	...
}

Does this code risk a crash by passing an unchecked pointer to to_msm_vm(),=
=20
which computes an offset from the error pointer and then accesses sched?


[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed some paths directl=
y=20
access ctx->vm before it's guaranteed to be initialized. For example:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
	...
	if (args->pad)
		return -EINVAL;

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
	...
}

If an unprivileged user calls this ioctl as the very first operation on a
new context, won't ctx->vm still be NULL here, leading to an invalid
pointer dereference via the to_msm_vm() offset macro?

I noticed a similar pattern in msm_gem_new_handle():

drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
	...
	if (flags & MSM_BO_NO_SHARE) {
		struct msm_context *ctx =3D file->driver_priv;
		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);

		drm_gem_object_get(r_obj);
	...
}


[Severity: High]
This isn't a bug introduced by this patch, but since the patch addresses=20
concurrent access to ctx->vm, does msm_gem_close() also need to use=20
smp_load_acquire() instead of a plain read?

drivers/gpu/drm/msm/msm_gem.c:msm_gem_close() {
	...
	msm_gem_vma_put(obj);

	/*
	 * If VM isn't created yet, nothing to cleanup.  And in fact calling
	 * put_iova_spaces() with vm=3DNULL would be bad, in that it will tear-
	 * down the mappings of shared buffers in other contexts.
	 */
	if (!ctx->vm)
		return;
	...
}

Without a read barrier, could a concurrent ioctl that initializes the VM
cause this function to observe a non-NULL pointer but read uninitialized
memory from the VM structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D1
