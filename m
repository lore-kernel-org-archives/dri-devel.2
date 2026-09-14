Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2D1C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C7610E796;
	Mon, 14 Sep 2026 20:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ItfaR8vN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D464710E796
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 20:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 268BD60252;
 Mon, 14 Sep 2026 20:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F911F000FF;
 Mon, 14 Sep 2026 20:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789418621;
 bh=uArpvazUkuD0Y0Ad7kfXhIvleSaSpGuWjJ03nJl6w2A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ItfaR8vN79hg8lkOrOWv110HW+CbY/TcKcpelbKlyDxWsXkjchzQycgVNe+JHBGVP
 /4/Mllmto11j/6NwzbnC9Yihwy1RZuy7DJE1VJEZT7VmBeH9H1e8J/Ikfvp3XgARVR
 4HlKoPuszx8Lkfz/EySXDiTiTX0lgi2Yv+xl/t3Nny6FXxqAKQJR/eVpULukzXGEr5
 78Hqp4R5PXeZIO0Bvb1cHokg5XBgYD7WSBkFwcGCY/dW5H8hrTruD/izUze7dcvrfR
 VUy/bp1llMTsxJ5i209VlV4GEuxu/i7Z4m3qRif3KpbtbO0zhh6/yKpiW7MRjPxLM1
 /BY9FkTYZ38QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
 <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 20:43:41 +0000
Message-Id: <20260914204341.A7F911F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] amdgpu_vm_clear_freed errors are ignored in KFD BO unmap and G=
EM close paths, leaving active PTEs mapped to freed memory. A running user-=
mode queue shader can continue to access the memory after it has been reall=
ocated.
--

commit 16b841a63bb4a2522f39993f74bd498158fed54e
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm/amdgpu: don't free mapping when amdgpu_vm_update_range fails

This commit modifies amdgpu_vm_clear_freed to avoid freeing a mapping and
removing it from the freed list if amdgpu_vm_update_range fails. It assumes
that leaving the mapping in the freed list will allow a subsequent
amdgpu_cs_ioctl to retry clearing it, preventing invalid access.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 09037df76400d..5bde36754607f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *a=
dev,
>  	while (!list_empty(&vm->freed)) {
>  		mapping =3D list_first_entry(&vm->freed,
>  			struct amdgpu_bo_va_mapping, list);
> -		list_del(&mapping->list);
> =20
>  		r =3D amdgpu_vm_update_range(adev, vm, false, false, true, false,
>  					   &sync, mapping->start, mapping->last,
>  					   0, 0, 0, NULL, NULL, &f);
> -		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  		if (r) {
>  			dma_fence_put(f);
>  			goto error_free;
>  		}

[Severity: Critical]
This is a pre-existing issue, but does leaving the mapping in the freed list
actually guarantee it will be cleared later?

The commit message assumes that a later amdgpu_cs_ioctl will retry the
clearing. However, are there paths that bypass the CS ioctl where this error
is ignored?

For instance, in KFD unmap_bo_from_gpuvm in
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, the error from
amdgpu_vm_clear_freed is explicitly ignored:

	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);

This marks the BO as unmapped in software, allowing it to be subsequently
freed via amdgpu_amdkfd_gpuvm_free_memory_of_gpu without waiting for the
PTEs to be cleared. Because KFD uses hardware user-mode queues, the clearing
is never retried by a CS ioctl. A running user-mode queue shader could
continue to access the freed memory.

Similarly, in amdgpu_gem_object_close in
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c, the error is ignored and it bails
out without attaching a fence:

	r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
	if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
		dev_err(adev->dev, "failed to clear page "
			"tables on GEM object close (%ld)\n", r);
	if (r || !fence)
		goto out_unlock;

Could this leave active PTEs mapped to freed memory, leading to a potential
information leak or memory corruption if amdgpu_vm_update_range fails
(e.g., due to an early -ENOMEM)?

> +		list_del(&mapping->list);
> +		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  	}
> =20
>  	if (fence && f) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-amdgpu_vm_=
fixes-v1-0-d6d835591e0f@igalia.com?part=3D3
