Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A65C5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 14:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A1710E3BC;
	Sat, 22 Aug 2026 14:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W/HXwUC8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E631910E3BC
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 14:44:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B962F43E2F;
 Sat, 22 Aug 2026 14:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737851F000E9;
 Sat, 22 Aug 2026 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787409865;
 bh=DlTptzC5E14xwjEg1ZUeAQ69HpxsKOihF6StnmEvGu0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W/HXwUC8Z1p6lvPtfUXi9NMZmc3NfkxIWqBk/v8inMUi85UjoZ/EIt7/jzJKgUEPG
 LP0Cuahi5190+ho15c+NTFCFszAm0UaovBeCRHFDXQupA+gf86pjir0EGzwymZfAmA
 p7jKAtcLOnm4Myko1yJtp8HFzNqwwAZX9eMaVfUI8cq5UKb8tfyQj73QBA+eWtpx7D
 97xagj1RGJutK9jWenUsjRohV4f38Hshc/oU9Xztezvj2iLC+SQgUL7KQB/woLABLp
 cWm6vmjt1hLyVgABK5Z6VQ86FEmrwrqd4nN8ZWnt3EzbqeSIpTrh2EUljyAjS6d6wQ
 JxLJEBwgApxHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: don't leak BOs when process teardown can't
 unmap them
To: "Bocaj Gnuoy" <bocajgnuoy@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822142521.899098-1-bocajgnuoy@gmail.com>
References: <20260822142521.899098-1-bocajgnuoy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:44:25 +0000
Message-Id: <20260822144425.737851F000E9@smtp.kernel.org>
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
- [High] The patch misses applying force=3Dtrue to the error unwind path of=
 kfd_process_alloc_gpuvm(), which can permanently leak internal BOs on unma=
p failure.
- [High] Interruptible lock waiting in reserve_bo_and_cond_vms causes early=
 return on pending signals, bypassing the forced free and silently leaking =
the BO.
--

--- Patch [1]: [PATCH] drm/amdkfd: don't leak BOs when process teardown can=
't unmap them ---
commit 01e590b61624d149d5da9ac22540c56bed4f9a55
Author: Bocaj Gnuoy <bocajgnuoy@gmail.com>
Subject: drm/amdkfd: don't leak BOs when process teardown can't unmap them

This commit addresses a memory leak and subsequent TTM eviction deadlock
that occurs when a process runs out of memory during teardown. It adds a
force flag to amdgpu_amdkfd_gpuvm_free_memory_of_gpu() to ensure BOs are
freed even if unmapping fails. The early -EBUSY return is retained for ioctl
paths where userspace can retry.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5672

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1e71829e0fc6b..dc1fa664fecac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> [ ... ]
> @@ -1922,9 +1922,26 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	 */
> =20
>  	if (mapped_to_gpu_memory > 0) {
> -		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
> -				mem->va, bo_size);
> -		return -EBUSY;
> +		/*
> +		 * Refusing to free a mapped BO is only meaningful while the
> +		 * process can still unmap it. On process teardown (@force)
> +		 * there is no such chance: the caller drops the last handle
> +		 * to @mem regardless, so bailing out here leaks the BO onto
> +		 * process_info->kfd_bo_list / userptr_inval_list. Those lists
> +		 * are then destroyed non-empty in
> +		 * amdgpu_amdkfd_gpuvm_destroy_cb(), leaving a BO in TTM's
> +		 * eviction LRU whose bo_vas point into the freed amdgpu_vm.
> +		 * The next client to trigger eviction deadlocks in
> +		 * amdgpu_vm_bo_move(). Tear the mappings down instead - the
> +		 * VM is going away right after us anyway.
> +		 */
> +		if (!force) {
> +			pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
> +				 mem->va, bo_size);
> +			return -EBUSY;
> +		}
> +		pr_warn("Force-freeing BO VA 0x%llx size 0x%lx still mapped %u time(s)=
\n",
> +			mem->va, bo_size, mapped_to_gpu_memory);
>  	}
> =20
>  	/* At this point the BO is guaranteed to be freed, so unpin the

[Severity: High]
This is a pre-existing issue, but can amdgpu_amdkfd_gpuvm_free_memory_of_gp=
u()
still silently leak the BO if a signal interrupts the lock wait?

Later in this function, the BO is removed from the tracking list before an
interruptible lock wait is performed:

amdgpu_amdkfd_gpuvm_free_memory_of_gpu()
    mutex_lock(&process_info->lock);
    if (!list_empty(&mem->validate_list))
        list_del_init(&mem->validate_list);
    mutex_unlock(&process_info->lock);

    ret =3D reserve_bo_and_cond_vms(mem, NULL, BO_VM_ALL, &ctx);
    if (unlikely(ret))
        return ret;

If reserve_bo_and_cond_vms() returns early (e.g., -ERESTARTSYS) due to a
pending signal, the function bails out. Because the BO was already removed
from validate_list, it is left orphaned.

Additionally, looking at the related caller kfd_process_free_gpuvm_map(),
the map pointer is cleared before the free is attempted:

kfd_process_free_gpuvm_map()
    if (map && !iosys_map_is_null(map)) {
        amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
        iosys_map_clear(map);
    }

If the free is aborted by a signal, subsequent teardown passes will skip
this map and ignore this BO. Does this sequence also create a risk of a
silent memory leak and TTM eviction deadlock when userspace triggers an
error and receives a concurrent signal?

> [ ... ]
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 0a7c1900da959..6d5126aa6fe74 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> [ ... ]
> @@ -814,7 +814,7 @@ static int kfd_process_alloc_gpuvm(struct kfd_process=
_device *pdd,
> =20
>  err_map_mem:
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(kdev->adev, *mem, pdd->drm_priv,
> -					       NULL);
> +					       NULL, false);
>  err_alloc_mem:
>  	*mem =3D NULL;
>  	*kptr =3D NULL;

[Severity: High]
This is a pre-existing issue, but should the error unwind path in
kfd_process_alloc_gpuvm() use force =3D true?

When kfd_process_alloc_gpuvm() hits an error and jumps to err_map_mem, it
calls amdgpu_amdkfd_gpuvm_free_memory_of_gpu() with force =3D false. It then
immediately zeroes out the *mem pointer.

If the free fails (for instance, an unmap failure under memory exhaustion
where force =3D false causes an -EBUSY return), this BO appears to be
permanently leaked since *mem is cleared and no later retry is possible.

Could this lead to the same unrecoverable TTM eviction deadlock that this
patch is fixing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822142521.8990=
98-1-bocajgnuoy@gmail.com?part=3D1
