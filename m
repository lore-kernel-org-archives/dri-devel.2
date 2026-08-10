Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BA1C5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714DF10E936;
	Mon, 10 Aug 2026 16:31:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ozl4699U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97EEB10E942
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:31:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6ECA60052;
 Mon, 10 Aug 2026 16:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381D41F000E9;
 Mon, 10 Aug 2026 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786379464;
 bh=eEAKozSQNtqnGOcB2Hv6oyIpcS0bO53z3RVQElIderU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ozl4699U21lI7SVZI42f4E/KPBJmNKUVlGxdBESaRVA6Qg3Awcw+4TA25r75Ux8AB
 NNu4C87ycmEMxZ7W9z063ugUv22GqYOCY2zSO0Ci+zryyI7dxxzT/31FSdJW2IvOJs
 EbeUTHQoiNkEHvXCGs7KXZsaYHRZH0tEoRcUK4E4UK+eCE7SiUD3ytJ1O8uYgHmixY
 Mr/gjZp9kaQFndx+Zw0++ujQgDMr/+FRcRFbTjAWzXfinaDImenZzaBR+/5yqjr6B9
 9NeTW+G37wje4alY5uxQJ92OUpGunuPEKdY4MhMNn3yNF43Rfkffzof8m73ziD01PR
 A5kvYDnWK3ajA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/amdgpu: free prt_va on the open_kms error path
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-amdgpu-fixes-v1-1-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-1-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:31:03 +0000
Message-Id: <20260810163104.381D41F000E9@smtp.kernel.org>
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
- [High] Incomplete fix for memory leak and use-after-free on `error_vm` pa=
th regarding `csa_va`.
- [High] Bypassing `drm_exec_fini()` on the error path out of the `drm_exec=
_until_all_locked()` loop causes a memory leak and WW context leak.
--

--- Patch [1]: [PATCH 1/5] drm/amdgpu: free prt_va on the open_kms error pa=
th ---
commit 89bac7ae7a8efcfa06425874df2dcd14db52ca52
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu: free prt_va on the open_kms error path

amdgpu_driver_open_kms() creates fpriv->prt_va with amdgpu_vm_bo_add()
before mapping the CSA and the seq64 buffer. If either mapping fails
the function jumps to error_vm, which only calls amdgpu_vm_fini() and
then frees fpriv. amdgpu_vm_fini() releases the amdgpu_bo_va_mapping
objects reachable from vm->freed and the vm->va rbtree, but it never
frees a struct amdgpu_bo_va, so the bo_va allocated for prt_va and the
dma_fence stub reference it holds are both lost.

Fixes: b85891bd6d1b ("drm/amdgpu: IOCTL interface for PRT support v4")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 242c48e85912f..7ef1c1dcc2079 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1509,6 +1509,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, =
struct drm_file *file_priv)
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		r =3D amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(r))
>  			goto error_vm;

[Severity: High]
This is a pre-existing issue, but does this goto error_vm break out of the
loop and bypass the drm_exec_fini() call located immediately after?

Skipping drm_exec_fini() leaks the exec.objects array allocated by
drm_exec_init() and fails to call ww_acquire_fini(), which leaks the WW con=
text
and triggers lockdep splats.

[ ... ]

> @@ -1553,6 +1553,11 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>  		pasid =3D 0;
>  	}
> =20
> +	if (fpriv->prt_va &&
> +	    !WARN_ON(amdgpu_bo_reserve(fpriv->vm.root.bo, true))) {
> +		amdgpu_vm_bo_del(adev, fpriv->prt_va);
> +		amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +	}

[Severity: High]
This is a pre-existing issue, but if amdgpu_seq64_map() fails earlier, the
code jumps to the error_vm label. While this patch correctly frees prt_va,
does it fail to free csa_va?

Since csa_va was already successfully mapped and linked into the global sta=
tic
CSA BO's vm_bo list, and fpriv is subsequently freed, does this dangling
csa_va pointer contain a vm backpointer pointing to freed memory?

Any subsequent traversal of the global CSA BO's mappings (e.g., during
eviction) could trigger a use-after-free.

Additionally, if amdgpu_map_static_csa() or amdgpu_seq64_map() fails
internally, do they call amdgpu_vm_bo_del() without zeroing *bo_va?

amdgpu_csa.c:amdgpu_map_static_csa() {
    ...
    amdgpu_vm_bo_del(adev, *bo_va);
    goto error;
}

Could this leave a dangling pointer in fpriv that prevents a safe
if (fpriv->csa_va) cleanup on the error path?

>  	amdgpu_vm_fini(adev, &fpriv->vm);
> =20
>  error_pasid:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-amdgpu-fix=
es-v1-0-4954a417b8ff@outlook.com?part=3D1
