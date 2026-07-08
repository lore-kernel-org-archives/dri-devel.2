Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FA9C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1EF10F1E5;
	Wed,  8 Jul 2026 17:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HVUAT+Tx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3070410F1E5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F4BE6001A;
 Wed,  8 Jul 2026 17:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232911F000E9;
 Wed,  8 Jul 2026 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783533044;
 bh=YEtkgga5w2k4ikW9U/e8bTjhHLODV9x0BJKcTa6ZxXg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HVUAT+TxlUyHjmQgx78bybvldNdxkJqbGnAMOzC7e6ZFsTb4dH/uTjqkX3GlbHeCB
 0c3bwyvcu0KO5Nm+3rxwyGYHbyf8xC3M4o+MfP2ovvPNX6RWnhbasT2lKzHySraeEM
 2Dc42kYhkGrX+sR4fGJnTMWYyM0IPm0OIWRrM7Kpym1U/HXysIi+MrnzzZ9Aah5hIy
 /vH3GCTOpTF2nIqrW8YIgznKyA6hxbsv8X/7AdKnPB5oG3gkyoRdVsCVljYbdOm/LI
 F3tgQlrBoAv3H1n0nNEEz86VoIT4EYXM43WCf8g+DCFpoyftg4E9rn+EOsX8lmerKC
 j6aiU18ZjJPeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] drm/msm: Block VM_BIND for shared VMs
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708173356.578713-3-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
 <20260708173356.578713-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:50:43 +0000
Message-Id: <20260708175044.232911F000E9@smtp.kernel.org>
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
- [Critical] Incomplete fix: Falling back to the shared VM on private VM al=
location failure allows EXECBUF isolation bypass, arbitrary kernel memory a=
ccess, and information leaks.
- [High] Direct access to `ctx->vm` in `msm_ioctl_gem_submit()` before the =
VM is guaranteed to be initialized causes a NULL pointer dereference.
--

--- Patch [2]: [PATCH v4 2/6] drm/msm: Block VM_BIND for shared VMs ---
commit 14b0c06028a80fcfb812d65ea727ff988063c94e
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Block VM_BIND for shared VMs

We already block MSM_PARAM_EN_VM_BIND where per-process VMs are not
supported.  But in error paths when we actually try to create the VM
(allocation failures, etc) we could still end up with a shared-VM.

Since we need to create the VM lazily, for backwards compat, there
isn't really a better place to return an error.  But this isn't to
happen in practice.  Just block VM_BIND ioctls in this case so we
aren't giving userspace a way to manage the shared VM.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 1a952b171ed7f..c88b4352ad751 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
[ ... ]
> @@ -1449,7 +1450,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *dat=
a, struct drm_file *file)
>  	 * Maybe we could allow just UNMAP ops?  OTOH userspace should just
>  	 * immediately close the device file and all will be torn down.
>  	 */
> -	if (to_msm_vm(msm_context_vm(dev, ctx))->unusable)
> +	if (to_msm_vm(vm)->unusable)
>  		return UERR(EPIPE, dev, "context is unusable");
> =20
>  	/*
> @@ -1457,7 +1458,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *dat=
a, struct drm_file *file)
>  	 * place, if you haven't opted in to VM_BIND context.  But it is
>  	 * cleaner / less confusing, to check this case directly.
>  	 */
> -	if (!msm_context_is_vmbind(ctx))
> +	if (to_msm_vm(vm)->managed)

[Severity: Critical]
This is a pre-existing issue, but does falling back to the shared VM on pri=
vate
VM allocation failure allow an execbuf isolation bypass?

While this patch blocks vm_bind ioctls for shared VMs, an attacker could st=
ill
opt into vm_bind (setting ctx->userspace_managed_vm =3D true) and intention=
ally
cause private VM allocation to fail. In this case, msm_gpu_create_private_v=
m()
falls back to the global kernel VM:

drivers/gpu/drm/msm/msm_gpu.c:msm_gpu_create_private_vm() {
	...
	vm =3D drm_gpuvm_get(gpu->vm);
	...
}

If the attacker then creates a normal submitqueue and calls
msm_ioctl_gem_submit(), command validation is skipped because
msm_context_is_vmbind(ctx) still returns true based on user intent rather
than actual VM state:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
	...
	cmds_to_parse =3D msm_context_is_vmbind(ctx) ? 0 : args->nr_cmds;
	...
}

This allows the unvalidated user-provided IOVA to be mapped and executed
within the global kernel VM:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_lookup_cmds() {
	...
	submit->cmd[i].iova =3D submit_cmd.iova;
	...
}

Could this lead to arbitrary kernel memory access, or leak other processes'
data into the devcoredump if a job hangs?

[Severity: High]
This isn't a bug introduced by this patch, but does direct access to ctx->vm
in msm_ioctl_gem_submit() cause a null pointer dereference?

If a user directly calls msm_ioctl_gem_submit() on a fresh context without
performing any prior operation (like msm_ioctl_vm_bind) that initializes the
VM, ctx->vm remains null due to lazy initialization.

Does this check in msm_ioctl_gem_submit() cause an immediate crash when
dereferencing the offset to unusable?

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
	...
	if (to_msm_vm(ctx->vm)->unusable)
	...
}

>  		return UERR(EINVAL, dev, "context does not support vmbind");
> =20
>  	if (args->flags & ~MSM_VM_BIND_FLAGS)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708173356.5787=
13-1-robin.clark@oss.qualcomm.com?part=3D2
