Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC885C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054AE10F1E8;
	Wed,  8 Jul 2026 17:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="deeFjpYc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D60510F1E8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:52:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 488DF6001A;
 Wed,  8 Jul 2026 17:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B6D1F000E9;
 Wed,  8 Jul 2026 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783533147;
 bh=ZuUoL06KDhXEq1Dl/HHqTOqT06SdEnzixrcLNyATEfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=deeFjpYccOBxaE6E6jXFZelEtchY8Oxl/n+hJwCwA23b5BE0D7IBJiYJzTisiQv36
 5IszH8Zl40umdWAGVufbTSznouV5WF9eHXl3Flm+84q4jitvhHrllLXKs6BZlr8kjI
 3SKuE1Mx/nw/0IfWN4UfuFyZtZVuGadZbdCJlipDLM/+10OossmrbMHq0U27jiaPCB
 W6XEF6vFY7IxBRh7JPAwme8coBjnwHqsO6bsAlRuwqyLLMnWzCDNgBglU3TM6lto5M
 +t6MeNqZ3QoWvVA7otV3Q/1utgOlAjLt3zLPxDOwMygMatqPggE/Vg/cqyn+MXUAXh
 IVdOq9kCCgSig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] drm/msm: Fix barriers accessing ctx vm
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708173356.578713-2-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
 <20260708173356.578713-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:52:26 +0000
Message-Id: <20260708175226.D1B6D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Silent fallback to the global GPU VM when private VM allocatio=
n fails breaks memory isolation.
- [High] Direct access to ctx->vm before initialization causes a NULL point=
er dereference in IOCTL handlers.
- [High] Missing smp_load_acquire() when reading ctx->vm in msm_gem_close()=
 can lead to accessing partially initialized memory.
--

--- Patch [1]: [PATCH v4 1/6] drm/msm: Fix barriers accessing ctx vm ---
commit 5827c45dcfd83b1ca9d1ff0ea3f3c026fba67fb3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix barriers accessing ctx vm

This commit fixes memory barrier issues when accessing the context VM
by introducing smp_load_acquire and smp_store_release in msm_context_vm.
It prevents callers from seeing a partially initialized virtual machine.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 79f78e7e16e9d..3c8b5083a1fbe 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -225,18 +225,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
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

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at the VM creation
logic in msm_gpu_create_private_vm() called above, does it safely handle
memory allocation failures?

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_create_private_vm() {
    ...
    if (gpu->funcs->create_private_vm) {
        vm =3D gpu->funcs->create_private_vm(gpu, kernel_managed);
        ...
    }

    if (IS_ERR_OR_NULL(vm))
        vm =3D drm_gpuvm_get(gpu->vm);
   =20
    return vm;
}

If the private VM allocation fails (returning ERR_PTR(-ENOMEM) due to
system memory exhaustion), this fallback grants the userspace context access
to the shared global GPU VM.

Could an attacker intentionally exhaust memory to force this fallback,
thereby bypassing private VM isolation and gaining unauthorized access to
structures stored in the global VM?

> -
> +		smp_store_release(&ctx->vm, vm);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing the
barriers for ctx->vm initialization here, does msm_gem_close() also need an
smp_load_acquire() barrier?

Looking at msm_gem_close() in drivers/gpu/drm/msm/msm_gem.c, it reads
ctx->vm using a plain load:

drivers/gpu/drm/msm/msm_gem.c:msm_gem_close() {
    ...
    if (!ctx->vm)
        return;
    ...
}

If msm_gem_close() executes concurrently with VM creation, could it see a
non-NULL pointer without an acquire barrier and access partially
initialized memory?

[Severity: High]
This is a pre-existing issue, but I noticed there are paths that directly
access ctx->vm without calling msm_context_vm() first to ensure it is
created.

For example, in msm_ioctl_gem_submit():

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
    if (to_msm_vm(ctx->vm)->unusable)
        return -EPIPE;
    ...
}

And in msm_gem_new_handle():

drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
    ...
    struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
    ...
}

If userspace calls either of these IOCTLs on a fresh context before the
VM is initialized, could ctx->vm be NULL here, leading to a NULL pointer
dereference when computing the struct offset or dereferencing it?

> -	mutex_unlock(&init_lock);
> =20
>  	return ctx->vm;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708173356.5787=
13-1-robin.clark@oss.qualcomm.com?part=3D1
