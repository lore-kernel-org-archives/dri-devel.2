Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646CC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2876E10E1D3;
	Thu, 16 Jul 2026 20:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CQfI100x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8296C10E1D3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:48:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8E0260A5E;
 Thu, 16 Jul 2026 20:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449231F000E9;
 Thu, 16 Jul 2026 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234908;
 bh=lV+6XtMFiX0OaK4T/SO6mt26SAWY2lgcw1t4odE2zB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CQfI100xQeHXpmrXyMKb4yv/Z0cz/HavvM6SpHNy2HltyTxN0T7vEGCOjuMoCX1og
 uw8ku0RvTYBXk8+OYcz9UUDKvCXzryQDgRGin8zUmBnrljFsBImWeYxlx/j65xGctp
 /m0NOqeTyYf+ySiEJJE/zazA3xp6gkMl8V/ZOnHZVJSZ+LiYAzswRGwqdHV1vqJhgJ
 KoYpyFUy0hbpidKJKvW2XJ7+7t1XAzfBr44KCBlL2TEt95Bcxk0rfAHpGM/9D6NFdg
 fI5SJ8YJrk9+PviQBa2wwmY9KPnUhYXzXQ10c/uRtjlVH964MQjnb3mqGiSx1L86oo
 FiewtPvK0g3ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] drm/msm: Fix per-process-pgtables check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-10-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-10-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:48:27 +0000
Message-Id: <20260716204828.449231F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Logic inversion in fallback condition allows VM_BIND contexts =
to hijack the global shared GPU VM, while breaking legacy contexts on older=
 hardware.

Pre-existing issues:
- [High] Missing lock protection when reading and updating `ctx->sysprof`, =
leading to refcount and pm_runtime leaks.
--

--- Patch [9]: [PATCH v5 09/10] drm/msm: Fix per-process-pgtables check ---
commit 439295368270634dcd942a5c715dc37574234eb9
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix per-process-pgtables check

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support. Instead just check if create_private_vm()
is supported.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 84101e534ebef..3370cd44382fe 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -513,7 +513,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_=
context *ctx,

[Severity: High]
This is a pre-existing issue, but does the MSM_PARAM_SYSPROF ioctl handler
in this function need to hold any context-specific locks before calling
msm_context_set_sysprof()?

drivers/gpu/drm/msm/msm_submitqueue.c:msm_context_set_sysprof() {
...
	/* unwind old value: */
	switch (ctx->sysprof) {
	case 2:
		pm_runtime_put_autosuspend(&gpu->pdev->dev);
		fallthrough;
	case 1:
		refcount_dec(&gpu->sysprof_active);
		fallthrough;
	case 0:
		break;
	}

	/* Some gpu families require additional setup for sysprof */
	if (gpu->funcs->sysprof_setup)
		gpu->funcs->sysprof_setup(gpu, false);

	ctx->sysprof =3D sysprof;
...
}

If two threads execute the MSM_PARAM_SYSPROF ioctl concurrently on the same
context, they both enter msm_context_set_sysprof() without any locks.
Both could increment the global refcounts based on the new value, but read
the same old ctx->sysprof value (e.g., 0) during the unwind phase.

Neither thread decrements the old refcounts, but both update ctx->sysprof.
When the context is closed, the refcounts are only decremented once,
leaving a permanent leak that prevents the GPU from powering down.

>  		guard(rwsem_read)(&ctx->ctxlock);
> =20
>  		/* We can only support VM_BIND with per-process pgtables: */
> -		if (ctx->vm =3D=3D gpu->vm)
> +		if (!gpu->funcs->create_private_vm)
>  			return UERR(EINVAL, drm, "requires per-process pgtables");

[Severity: Critical]
While looking at the VM_BIND changes, does the fallback logic in
msm_gpu_create_private_vm() accidentally invert its condition?

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_create_private_vm() {
...
	if (IS_ERR_OR_NULL(vm) && !kernel_managed)
		vm =3D drm_gpuvm_get(gpu->vm);
...
}

If private VM creation fails or is unsupported for a VM_BIND context
(where kernel_managed is false), this condition evaluates to true,
and the context falls back to the global shared GPU VM.

Could this allow userspace to hijack the global shared VM and modify
its pagetables?

Additionally, this logic inversion prevents legacy contexts (where
kernel_managed is true) from falling back to the global VM on older hardwar=
e,
causing initialization failures.

>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D9
