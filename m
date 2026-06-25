Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C01CDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C9310E295;
	Thu, 25 Jun 2026 22:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D+Ubm5Ow";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB44B10E295
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 22:40:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20F7E60098;
 Thu, 25 Jun 2026 22:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08321F000E9;
 Thu, 25 Jun 2026 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782427212;
 bh=rkcW+Fl7rcZ9pgg2bVHK6ASURcIVJQ/ulnMU/LeDYig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D+Ubm5OwojkBHb0CJHuwtkPfWmyINkdyLYKCOwB+5LCOplJZ8yiX5N1Xh3tRDgqL3
 szZe4b/y0/3XwYsjeGgsyEG+OsG60s5+D8HTi1GywXD3s0ard8PNhe3LwTtGcduMXV
 jKWV5b5rUv+srBlprnC939Rc/Qf7aLfrwtg/3yDs4aXJRKBSA2bbjb45StFtp/rIAC
 oQtR1oC2QBkZuB5n06ImPFX7l0N5w4qD14IlpMznESyjpC0FtHIwTK+5G55ZJw07yj
 ROppPY6Zxwo1fL9R/85oZajw6pMy7jr/qwydJgH6ba7urfxnT2AskqTD6hSXAfEyub
 oskrdFuUkh7pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/msm: Fix per-process-pgtables check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625222744.22254-5-robin.clark@oss.qualcomm.com>
References: <20260625222744.22254-1-robin.clark@oss.qualcomm.com>
 <20260625222744.22254-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:40:12 +0000
Message-Id: <20260625224012.A08321F000E9@smtp.kernel.org>
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
- [Critical] Insufficient capability check and silent fallback to the globa=
l GPU VM allows userspace to manage the global VM via VM_BIND.
- [High] A time-of-check to time-of-use (TOCTOU) data race when opting into=
 VM_BIND mode allows a state mismatch between `ctx->userspace_managed_vm` a=
nd the underlying IOMMU page table configuration.
--

commit 29eb04f2a503cc0bd049bafc825248eb1ad0a013
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix per-process-pgtables check

ctx->vm should not be inialized yet (or if it has, an error is returned
immediately following this check), so this isn't a valid way to check
for per-process-pgtable support. Instead just check if create_private_vm()
is supported.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: feb8ef4636a4 ("drm/msm: Add opt-in for VM_BIND")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..bff2a773c0d4e 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -505,7 +505,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>  		return msm_context_set_sysprof(ctx, gpu, value);
>  	case MSM_PARAM_EN_VM_BIND:
>  		/* We can only support VM_BIND with per-process pgtables: */
> -		if (ctx->vm =3D=3D gpu->vm)
> +		if (!gpu->funcs->create_private_vm)

[Severity: Critical]
This is a pre-existing issue, but does relying on a static function
pointer here rather than verifying actual VM creation success allow an
invalid configuration to proceed?

If dynamic creation of the private VM fails in msm_gpu_create_private_vm()
(e.g., due to memory allocation failure or missing IOMMU support returning
-ENODEV), it silently falls back to returning the global, kernel-managed
gpu->vm:

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_create_private_vm() {
	...
	if (IS_ERR_OR_NULL(vm))
		vm =3D drm_gpuvm_get(gpu->vm);
	...
}

Because this check allows userspace to set ctx->userspace_managed_vm to
true, could a malicious process then use DRM_IOCTL_MSM_GEM_VM_BIND to issue
unmap and map operations against the global VM?

This seems to allow unmapping kernel structures like the memptrs ringbuffer
and mapping arbitrary memory in its place, potentially hijacking the GPU
ringbuffer and compromising the kernel. Furthermore, passing offset !=3D 0 =
or
handle =3D=3D 0 could trigger a BUG_ON() causing a kernel panic.

>  			return UERR(EINVAL, drm, "requires per-process pgtables");
> =20
>  		/*
>  		 * We can only swtich to VM_BIND mode if the VM has not yet
>  		 * been created:
>  		 */
>  		if (ctx->vm)
>  			return UERR(EBUSY, drm, "VM already created");
> =20
>  		ctx->userspace_managed_vm =3D value;

[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
here because the check of ctx->vm and assignment to ctx->userspace_managed_=
vm
are done without synchronization?

Could a concurrent ioctl (like MSM_GEM_SUBMIT) invoke msm_context_vm(),
which reads ctx->userspace_managed_vm before it is set to true here, causing
it to lazily create a legacy kernel-managed private VM?

drivers/gpu/drm/msm/msm_drv.c:msm_context_vm() {
	...
	vm =3D msm_gpu_create_private_vm(
		priv->gpu, current, !ctx->userspace_managed_vm);
	...
}

If adreno_set_param() then overwrites ctx->userspace_managed_vm to true,
and userspace subsequently issues DRM_IOCTL_MSM_GEM_VM_BIND, would the
ioctl proceed on the kernel-managed VM?

During the bind operation, wouldn't msm_gem_vma_new() see
vm->managed =3D=3D true and execute BUG_ON() if offset !=3D 0 or handle =3D=
=3D 0,
triggering a kernel panic?

> =20
>  		return 0;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625222744.2225=
4-1-robin.clark@oss.qualcomm.com?part=3D4
