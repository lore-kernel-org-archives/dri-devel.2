Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB2CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F121F10F3BD;
	Fri, 12 Jun 2026 09:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YPDcjYvJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC7B10F3BD
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:32:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5467642DC8;
 Fri, 12 Jun 2026 09:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D95A1F000E9;
 Fri, 12 Jun 2026 09:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256762;
 bh=GWEd0jJ5UDT2r6vAar+aoThdG6/XUp2e5xaLgQjERrA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YPDcjYvJ7ToS6sE6/0Fosp/5KuED1dqzuy9+bABD7JiFwCtYlQOD1CYfVq47dUzvy
 2GOTsj6GilTF5hvBdlyXVFbXYMmGzIXLztfbJPdPUMCFzxtQmjwK9YQJ4j8rtQV9T4
 cy5aFxFkXwqEnUGJy2uXACrW3MmdGQ1YnhRWYIOCF+K/HhGuolU4op3Qg38j6RLyXq
 RhctvoZ3jwV2WnKgIM1X6KecOOBX6XA2GJoisn0Wsz6un+mDS03DX5wPJBOJGNowo1
 Dltrn1zOkoEmrpcE/TbIa8jDkcGdjRI+aktGqxdqIrD1DR5Csu9ctSYbFV1vCQ8N80
 Jaau9Sp4iYoXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-8-ray.huang@amd.com>
References: <20260612090928.29682-8-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:32:41 +0000
Message-Id: <20260612093242.1D95A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Updating `range->gpu_mapped` outside `notifier_lock` creates a=
 TOCTOU race with MMU notifiers, leading to GPU UAF.
- [Critical] Fallible memory allocation inside the MMU notifier callback (`=
amdgpu_svm_range_zap_ptes`) can cause a GPU use-after-free.
- [High] Missing `goto retry;` logic after `-EOPNOTSUPP` eviction in `amdgp=
u_svm_range_get_pages` permanently fails mapping.
- [High] TLB is flushed and mapping is marked complete before asynchronous =
PDE updates finish.
- [High] `amdgpu_svm_range_map_attrs` fails the ioctl with `-EAGAIN` upon M=
MU notifier invalidation instead of retrying.
- [Medium] Ignored return value of `dma_fence_wait` in `amdgpu_svm_range_up=
date_mapping` masks `-ERESTARTSYS` errors.
--

commit fcda6b5ee02461678a8cd1586240f44fb136a85f
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/amdgpu: implement SVM range GPU mapping core

This patch implements GPU page table mapping in amdgpu_svm_range.c. It
introduces functions for validating, finding, evicting, and updating SVM
ranges, as well as handling PTE flags and updating mappings.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_svm_range.c
> new file mode 100644
> index 0000000000000..e1b392b2cf56a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

[ ... ]

> +int
> +amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
> +			  struct amdgpu_svm_range *range,
> +			  unsigned long start_page,
> +			  unsigned long last_page)
> +{
> +	struct dma_fence *fence =3D NULL;
> +	unsigned int flags;
> +	int ret;
> +
> +	if (last_page < start_page)
> +		return 0;
> +
> +	flags =3D memalloc_noreclaim_save();
> +	ret =3D amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, f=
alse,
> +				     NULL, start_page, last_page, 0, 0, 0, NULL,
> +				     NULL, &fence);
> +	memalloc_noreclaim_restore(flags);

[Severity: Critical]
Is it safe to rely on amdgpu_vm_update_range() inside the MMU notifier
callback path?

amdgpu_vm_update_range() dynamically allocates memory even when called
within a memalloc_noreclaim_save() block (e.g., allocating tlb_cb). Under
memory pressure, if this allocation fails, the PTEs will not be cleared.
Since the MMU notifier cannot fail gracefully to prevent the physical page
from being freed, could this result in the GPU retaining valid access to
freed memory and causing a use-after-free?

[ ... ]

> +int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
> +			       struct drm_gpusvm_range *range,
> +			       struct drm_gpusvm_ctx *ctx)
> +{

[ ... ]

> +	if (ret =3D=3D -EOPNOTSUPP) {
> +		AMDGPU_SVM_ERR(
> +			"range get pages -EOPNOTSUPP, evict and retry: gpuva=3D[0x%lx-0x%lx) =
ret=3D%d\n",
> +			drm_gpusvm_range_start(range),
> +			drm_gpusvm_range_end(range), ret);
> +		amdgpu_svm_range_evict(svm, range);
> +	}
> +
> +	return ret;
> +}

[Severity: High]
Should there be a retry loop after the eviction?

When drm_gpusvm_range_get_pages() returns -EOPNOTSUPP for unmappable
device memory, this code successfully evicts it back to system RAM but
then just falls through and returns -EOPNOTSUPP anyway. Does this lack of
a "goto retry" statement permanently fail the mapping operation instead of
recovering it?

[ ... ]

> +int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
> +				    struct amdgpu_svm_range *range,
> +				    const struct amdgpu_svm_attrs *attrs,
> +				    bool read_only,
> +				    bool intr, bool wait,
> +				    bool flush_tlb)
> +{

[ ... ]

> +	drm_gpusvm_notifier_unlock(&svm->gpusvm);
> +	memalloc_noreclaim_restore(flags);
> +
> +	if (!ret && fence)
> +		dma_fence_wait(fence, intr);

[Severity: Medium]
Is it intentional to discard the return value of dma_fence_wait() here?

If the wait is interrupted by a signal (since intr can be true), it
returns -ERESTARTSYS. Because ret remains 0, the code proceeds as if the
GPU mapping completed successfully. Could this lead to userspace
scheduling GPU execution on memory whose page tables have not finished
updating?

> +	dma_fence_put(fence);
> +
> +	if (!ret)
> +		ret =3D amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
> +
> +	if (!ret) {
> +		if (flush_tlb)
> +			svm->flush_tlb(svm);

[Severity: High]
Should we wait for the asynchronous PDE updates to finish before returning?

The amdgpu_vm_update_pdes() call uses immediate=3Dfalse, meaning PDE updates
are asynchronously queued to the SDMA ring. However, this function
immediately flushes the CPU-side TLB and returns success to userspace.

Can a user compute shader begin executing immediately and hit a GPU page
fault because the hardware page directory entries have not yet been
written?

> +		WRITE_ONCE(range->attr_flags, attrs->flags);
> +		WRITE_ONCE(range->gpu_mapped, true);

[Severity: Critical]
Could updating range->gpu_mapped outside the notifier_lock create a TOCTOU
race with MMU notifiers?

The lock is released before setting WRITE_ONCE(range->gpu_mapped, true).
Concurrently, an MMU notifier could run on another CPU, acquire the
notifier_lock, and check the flag. Because it hasn't been updated yet,
the notifier sees false, skips zapping the hardware PTEs, and allows the
CPU to free the physical memory.

Should gpu_mapped be updated inside the notifier_lock critical section to
prevent a GPU use-after-free?

> +		range->validate_timestamp =3D ktime_get_boottime();
> +	}
> +
> +	drm_exec_fini(&exec);
> +	return ret;
> +}

[ ... ]

> +int
> +amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,

[ ... ]

> +		ret =3D amdgpu_svm_range_update_mapping(svm, range, attrs,
> +						      map_ctx.read_only,
> +						      true, true,
> +						      true);
> +		if (ret) {
> +			AMDGPU_SVM_ERR("failed to update gpu map for range [0x%lx-0x%lx), ret=
=3D%d\n",
> +					drm_gpusvm_range_start(&range->base),
> +					drm_gpusvm_range_end(&range->base), ret);
> +			return ret;
> +		}

[Severity: High]
Should this handle -EAGAIN by retrying instead of propagating the error
to userspace?

If the MMU notifier sequence changes concurrently during mapping,
amdgpu_svm_range_update_mapping() safely catches this and returns -EAGAIN.
However, there is no retry loop here to handle that expected condition.
Will normal concurrent memory reclaim cause spurious ioctl failures to
userspace if we abort the entire ioctl instead of transparently retrying
the get_pages() and locking sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D7
