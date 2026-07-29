Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A57C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4B310ECDB;
	Wed, 29 Jul 2026 16:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i++e2+4B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E93E10ECDB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:10:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE7BB43638;
 Wed, 29 Jul 2026 16:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEFC1F00A3A;
 Wed, 29 Jul 2026 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341455;
 bh=hh+sWDHljoi7hPkZkjVqc7u1OES4G2uzhA1ngLCLiPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i++e2+4Bz2es2r/yf38cLEQKQDlb8h7r3l8z8HBeVjQzgJ5m3z77fXdOMoliOpC0/
 UcWkJ+l1FPkz56+cTJoq8rJneETomz+zaQQA0B1RMpuKqJgKWCuXxHbx0X3N/ApNZS
 o7yZYFAODxlOdHybyGRKCgu+yRWC1/o1568skufGEirQgJKN35+Ms9jR1e68DN6Ssh
 pToYiBffnitLO5v1BHxZVTUj4oxRUZNtyAIv7ECnAFCDnKRUvCVbVHqPIEcgyq+ij0
 +xcj5AoJw7uouFTEhUhLkRjiGN7kQddT9IZ8aRhnioa1c/Es7JJPLVPOWNzNqcFLtV
 8JeatFpAX9SzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/17] drm/msm: Synchronize VM creation on ctxlock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-4-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:10:55 +0000
Message-Id: <20260729161055.8CEFC1F00A3A@smtp.kernel.org>
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
- [Critical] `msm_context_vm()` returns `NULL` when VM creation fails, lead=
ing to unhandled NULL pointer dereference in callers.
- [Critical] Flawed hardware capability check in `adreno_set_param()` allow=
s VM_BIND on unsupported hardware.
- [High] Missing error check for `drm_sched_entity_init()` leaves the sched=
uler entity uninitialized.
--

--- Patch [3]: [PATCH v7 03/17] drm/msm: Synchronize VM creation on ctxlock=
 ---
commit fd449ed84ba9ef6ab17d7a557f7bc86f9a0a680e
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Synchronize VM creation on ctxlock

This commit replaces the global init_lock mutex with a per-context
rw_semaphore to synchronize VM creation and serialize setting EN_VM_BIND.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..0d54141ff089c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
[ ... ]
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
> -		if (ctx->vm =3D=3D gpu->vm)
> -			return UERR(EINVAL, drm, "requires per-process pgtables");

[Severity: Critical]
This isn't a bug introduced by this patch, but does this hardware capability
check evaluate correctly before VM creation?

Before this change, the check if (ctx->vm =3D=3D gpu->vm) evaluates to false
because ctx->vm is NULL before lazy VM creation. This allows an unprivileged
user to successfully set ctx->userspace_managed_vm on hardware lacking
create_private_vm support.=20

When the VM is subsequently created, it returns NULL, and the caller crashe=
s.

[ ... ]
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 77681cb4fdc25..a5714e24fcc6c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
[ ... ]
> @@ -230,7 +229,7 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *d=
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
This isn't a bug introduced by this patch, but does msm_context_vm()
properly propagate errors if VM creation fails?

If msm_gpu_create_private_vm() fails (e.g., due to memory exhaustion) and
returns an error pointer, msm_context_vm() does not populate ctx->vm and
returns NULL.

Callers like msm_submitqueue_create() unconditionally cast the return value
using to_msm_vm() and dereference its ->sched member, which can cause a
kernel panic.

I also noticed a pre-existing issue in msm_submitqueue_create() in
drivers/gpu/drm/msm/msm_submitqueue.c:

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to ignore the
return value of drm_sched_entity_init()?

In msm_submitqueue_create(), the return value of drm_sched_entity_init() is
ignored:

drm_sched_entity_init(queue->entity, DRM_SCHED_PRIORITY_KERNEL,
                      &sched, 1, NULL);

If initialization fails, the function continues. The subsequent error check
if (IS_ERR(queue->entity)) fails to detect the error because queue->entity
points to an embedded array element, not an ERR_PTR.=20

This could lead to using an uninitialized scheduler entity, potentially
causing memory corruption or crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D3
