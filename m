Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBB4C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AEE10E4DF;
	Fri, 17 Jul 2026 21:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+GYGM3s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418EC10E4DF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:05:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 957D860051;
 Fri, 17 Jul 2026 21:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B18B1F000E9;
 Fri, 17 Jul 2026 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322349;
 bh=KFf4z1TyjREm7WpCwZ9s0rqHdPdCeu5swj5eiPnNQe0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m+GYGM3s6MJtFV77qdt34oYbQu7GzD43GLF0Pf8INWMJtTdWGLe7eyxZreZbdopeA
 fz9pYIX2mgUEH8tSfFQABJKtxfR7IENGg/BgKJrwEa/vZzRHGJYfTfUATaFPAMnucz
 EQ0nAN2tAvuDg0V3dp/0CahDWCEXE7/6yQ9Hd5rvgNVM9ZbKOqihnvWTgjEslCeGEo
 xwYRVOKpcUeA45HWwLC/7jbhKP+OJLVbptbKuvqF0ei2LMmjbni95T+UusC2kMaMPr
 nsLNApqCT8WezDJNYxoh8v2mw0oXGvK5WChzQ5ZD9KzXPE5P5DP+Q3b6YnIKga3sAq
 gQTFVYAJL9VGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/16] drm/msm: Synchronize VM creation on ctxlock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-4-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:05:48 +0000
Message-Id: <20260717210549.2B18B1F000E9@smtp.kernel.org>
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
- [Critical] `msm_context_vm()` propagates errors as `ERR_PTR` or `NULL` wi=
thout callers checking, leading to wild pointer dereferences.
- [Critical] Direct access to uninitialized `ctx->vm` in `msm_ioctl_gem_sub=
mit()` causes a guaranteed NULL pointer dereference.
- [High] Hardware capability check in `adreno_set_param()` fails due to laz=
y VM initialization, bypassing restrictions.
--

--- Patch [3]: [PATCH v6 03/16] drm/msm: Synchronize VM creation on ctxlock=
 ---
commit 78d3ed784b530d2c180edb9b49939bea521dccd3
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Synchronize VM creation on ctxlock
   =20
This commit serializes the setting of EN_VM_BIND against VM creation
by synchronizing it on ctxlock.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..0d54141ff089c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -503,7 +503,9 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>  		if (!perfmon_capable())
>  			return UERR(EPERM, drm, "invalid permissions");
>  		return msm_context_set_sysprof(ctx, gpu, value);
> -	case MSM_PARAM_EN_VM_BIND:
> +	case MSM_PARAM_EN_VM_BIND: {
> +		guard(rwsem_read)(&ctx->ctxlock);
> +
>  		/* We can only support VM_BIND with per-process pgtables: */
>  		if (ctx->vm =3D=3D gpu->vm)

[Severity: High]
This isn't a bug introduced by this patch, but does this hardware capability
check properly account for lazy VM initialization?

Since VMs are lazily initialized, ctx->vm will be NULL at this stage. This
means the check evaluates NULL =3D=3D gpu->vm, which is always false. Does =
this
allow all hardware, even those without per-process pagetables, to bypass th=
is=20
restriction?

>  			return UERR(EINVAL, drm, "requires per-process pgtables");

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 380b3e2bf734e..20c5a6cc82019 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -223,7 +223,6 @@ static void load_gpu(struct drm_device *dev)
>   */
>  struct drm_gpuvm *msm_context_vm(struct drm_device *dev, struct msm_cont=
ext *ctx)
>  {
> -	static DEFINE_MUTEX(init_lock);
>  	struct msm_drm_private *priv =3D dev->dev_private;
>  	struct drm_gpuvm *vm =3D smp_load_acquire(&ctx->vm);
> =20
> @@ -231,7 +230,7 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *d=
ev, struct msm_context *ctx
>  	if (vm)
>  		return vm;
> =20
> -	guard(mutex)(&init_lock);
> +	guard(rwsem_write)(&ctx->ctxlock);
> =20
>  	if (!ctx->vm) {
>  		vm =3D msm_gpu_create_private_vm(

[Severity: Critical]
This is a pre-existing issue, but does msm_context_vm() propagate an
unhandled error pointer or NULL on failure?

If msm_gpu_create_private_vm() returns ERR_PTR or NULL (e.g., during an OOM
condition or on platforms without per-process pagetables), it appears
msm_context_vm() stores and returns this directly.=20

Callers like msm_submitqueue_create() in msm_submitqueue.c blindly assume
success:

    struct drm_gpu_scheduler *sched =3D &to_msm_vm(msm_context_vm(drm, ctx)=
)->sched;

If an error pointer or NULL is returned, to_msm_vm() yields an invalid
address. Could this lead to an immediate kernel crash when it is
dereferenced in drm_sched_entity_init()?


[Severity: Critical]
This is another pre-existing issue, but does direct access to ctx->vm cause=
 a
NULL pointer dereference?

If a user issues a DRM_IOCTL_MSM_GEM_SUBMIT ioctl before executing any
commands that lazily initialize the VM, ctx->vm is still NULL.

In msm_ioctl_gem_submit():

    if (to_msm_vm(ctx->vm)->unusable)
        return UERR(EPIPE, dev, "context is unusable");

Because ctx->vm is NULL, the to_msm_vm() macro returns a negative offset
pointer. Does dereferencing ->unusable here immediately crash the kernel
instead of calling msm_context_vm() to lazily initialize it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D3
