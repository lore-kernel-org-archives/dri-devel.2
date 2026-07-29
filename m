Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6351BC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7CE610ECEA;
	Wed, 29 Jul 2026 16:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EcSvatiJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC4610ECEA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:27:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B4FC6001D;
 Wed, 29 Jul 2026 16:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A141F00A3A;
 Wed, 29 Jul 2026 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785342471;
 bh=qTiaaDl05EqpTDYVXjkZNoUQT6gBY5D+4z2LapbOa8Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EcSvatiJjGVujiciVSULrvCfpcsbPAimcs3ZLn6EThnKjCYDQpF0++8Uo+ZiVcoGs
 XPODiH/iECSnrfUdvZNDp3VD6BOXpqsjkBS13yHLvtWgup3kV6ilgHxxlDvikUpbjG
 mAKFThftb5StqlY1b+2YgKPrn7MrdJoNrkVsbbV73N8MqqZF8H/D0LK9iBnF+61qe1
 k7wrlSTyp9cQcEQil8V/ujM7oR5KNlqlXKb62zQZG7ZAsqdAM2jf4Rqaq9WOBudkRT
 WbzrM7q0v2kVGvG4XfDr18NVQQRI6lvoRYpleobwvR/gYfLbFpoDnaZmVm7XtAeEDW
 mHhCbfk5Xy2cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/17] drm/msm: Don't fallback to shared VM for VM_BIND
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-16-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-16-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:27:50 +0000
Message-Id: <20260729162750.A2A141F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unbounded memory leak of mmu objects in a6xx_create_private_vm() o=
n userspace-managed VM creation failure
- [Medium] Flawed struct_size() overflow check in submit_create()
--

--- Patch [15]: [PATCH v7 15/17] drm/msm: Don't fallback to shared VM for V=
M_BIND ---
commit fad81fcf16686d778f256dee3ff6070327d5931e
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drm/msm: Don't fallback to shared VM for VM_BIND

This patch modifies the virtual memory creation path in the MSM DRM driver.
If a user process requests a userspace managed VM, the driver will no longer
silently fall back to the shared, kernel-managed VM upon failure or absence
of private VM support.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 84b126c6347f7..db1b655dd055b 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -234,7 +234,8 @@ struct drm_gpuvm *msm_context_vm(struct drm_device *d=
ev, struct msm_context *ctx
>  	if (!ctx->vm) {
>  		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -		smp_store_release(&ctx->vm, vm);
> +		if (!IS_ERR_OR_NULL(vm))
> +			smp_store_release(&ctx->vm, vm);
>  	}
> =20
>  	return ctx->vm;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 03c0578560658..0c2c356362518 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -879,7 +879,7 @@ msm_gpu_create_private_vm(struct msm_gpu *gpu, struct=
 task_struct *task,
>  			to_msm_vm(vm)->pid =3D get_pid(task_pid(task));
>  	}
> =20
> -	if (IS_ERR_OR_NULL(vm))
> +	if (IS_ERR_OR_NULL(vm) && kernel_managed)
>  		vm =3D drm_gpuvm_get(gpu->vm);
> =20
>  	return vm;

[Severity: High]
This isn't a bug introduced by this patch, but does this change allow
userspace to trigger an unbounded memory leak?

When kernel_managed is false and gpu->funcs->create_private_vm()
(e.g., a6xx_create_private_vm()) fails, it returns an error pointer.
Before this patch, the code would fall back to the global gpu->vm.
Now, it propagates the error pointer back to the caller.

If we look at a6xx_create_private_vm():

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_create_private_vm() {
	...
	mmu =3D msm_iommu_pagetable_create(gpu->aspace->mmu);
	if (IS_ERR(mmu))
		return ERR_CAST(mmu);

	return msm_gem_vm_create(gpu->dev, mmu, "gpu", ADRENO_VM_START,
				 adreno_private_vm_size(gpu), kernel_managed);
}

If msm_gem_vm_create() fails, the previously allocated mmu object is not
freed.

Because this patch propagates the error and leaves ctx->vm as NULL in
msm_context_vm(), can an unprivileged user repeatedly issue an ioctl with
MSM_PARAM_EN_VM_BIND set, hit this error path, and continuously leak
mmu objects?

A similar pre-existing leak exists in the GMU probe path if
msm_gem_vm_create() fails:

drivers/gpu/drm/msm/adreno/a6xx_gmu.c:a6xx_gmu_memory_probe() {
	...
	gmu->vm =3D msm_gem_vm_create(drm, mmu, "gmu", 0x0, 0x80000000, true);
	if (IS_ERR(gmu->vm))
		return PTR_ERR(gmu->vm);
	...
}


[Severity: Medium]
This is a pre-existing issue, but does this code properly handle overflow?

Looking at submit_create() in msm_gem_submit.c:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_create() {
	...
	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);
	...
}

According to the DRM subsystem guidelines, struct_size() saturates at
SIZE_MAX upon overflow. On a 64-bit system where SIZE_MAX is UINT64_MAX,
adding a non-zero value wraps the uint64_t variable to a small value.
Does this make the sz > SIZE_MAX check dead code that fails to catch the
overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D15
