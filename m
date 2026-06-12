Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A4ACD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE50810F3CC;
	Fri, 12 Jun 2026 09:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MFUd2GpI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644A310F3F0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:31:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DC93429E0;
 Fri, 12 Jun 2026 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEF41F000E9;
 Fri, 12 Jun 2026 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256673;
 bh=UJW4XF53hK7NwBRrMBSzRFsEi5qHSfhs+v5WNAqcv+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MFUd2GpIpUXukBmUjbAEvEGVQ/ykCF8K9ODdE6d3ast48KU5qUlFGo1rDo3HElh99
 /w38uKpXe2N7gpVhacaQvY10FfaXynNlHO+JY69jkWADzyW40svoqDy6RUjhX1z2yW
 PKCHHUrrfDC2gZ5McPY45fFoh+Iygk5EDpOVW6VrnI8Pv7qVPdXipKJorYBU3BJwoY
 i1vtZMeqvj4zP6Pd4DYUR9u/7BLZYv0FErJB6E7BOEeh5xJqrL8hKuQ/wMSUyq4JzV
 qLasL0B3xX49echgtUycq3qCFtCllu4R9txC2gJvzLf0p5n23Hr2c29sPeBBonjyS9
 aZ+8eiyoWGrnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/18] drm/amdgpu: implement synchronous TTM eviction
 for SVM BOs
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-16-ray.huang@amd.com>
References: <20260612090928.29682-16-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:31:12 +0000
Message-Id: <20260612093113.0BEF41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The SVM BO eviction path migrates VRAM to system memory synchr=
onously without waiting for pending GPU operations (`ttm_bo_wait_ctx`), ris=
king data corruption and violating `ctx->no_wait_gpu`.
- [High] Using `GFP_KERNEL` allocations inside `drm_pagemap_evict_to_ram()`=
 while holding the BO's `dma_resv` lock creates a deadlock risk with memory=
 reclaim.
- [High] Early return during SVM BO eviction bypasses `amdgpu_bo_move_notif=
y()` and TTM BO statistics tracking.

Pre-existing issues:
- [High] `amdgpu_svm_copy_to_ram` completely ignores the `pre_migrate_fence=
`, risking data corruption on the destination.
--

commit 9be611c0396613a1f2f1bba63eacdcd1d3dd9964
Author: Junhua Shen <Junhua.Shen@amd.com>

drm/amdgpu: implement synchronous TTM eviction for SVM BOs

Implement the TTM eviction path for SVM (Shared Virtual Memory) BOs,
enabling VRAM overcommit scenarios where device-private pages must be
migrated back to system memory when VRAM is full.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_migrate.c
> index 3756404ec334c..88079221eeca7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> @@ -645,6 +645,34 @@ static const struct drm_pagemap_devmem_ops amdgpu_pa=
gemap_ops =3D {
>  	.copy_to_ram         =3D amdgpu_svm_copy_to_ram,

[Severity: High]
This is a pre-existing issue, but does amdgpu_svm_copy_to_ram() ignore the
pre_migrate_fence?

Looking at the implementation of amdgpu_svm_copy_to_ram() referenced here:

amdgpu_svm_copy_to_ram(struct page **pages,
                       struct drm_pagemap_addr *pagemap_addr,
                       unsigned long npages,
                       struct dma_fence *pre_migrate_fence)
{
    ...
}

The function takes pre_migrate_fence as a parameter but does not appear to
wait on it. During P2P migration, could ignoring this fence cause the source
device to begin copying data into the destination device's memory before the
destination is ready, leading to data corruption?

[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 6c6ab4dd6ea95..9d3deec7cedec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
[ ... ]
> @@ -575,6 +585,16 @@ static int amdgpu_bo_move(struct ttm_buffer_object *=
bo, bool evict,
>  		abo->flags &=3D ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>  	}
> =20
> +	/* SVM BO eviction: migrate device-private pages back to RAM */
> +	if (amdgpu_svm_bo_is_svm(bo) &&
> +	    old_mem->mem_type =3D=3D TTM_PL_VRAM &&
> +	    new_mem->mem_type =3D=3D TTM_PL_SYSTEM) {
> +		r =3D amdgpu_svm_bo_evict(abo);

[Severity: Critical]
Does this migration skip synchronizing with pending GPU operations?

Since amdgpu_svm_bo_evict() synchronously migrates VRAM to system memory via
SDMA, missing a call to ttm_bo_wait_ctx() could allow the copy to start whi=
le
the GPU is still executing shaders that access this VRAM.

Additionally, does bypassing ttm_bo_wait_ctx() ignore the ctx->no_wait_gpu
flag, potentially causing illegal stalls if a non-blocking move is requeste=
d?

[Severity: High]
Can this lead to a deadlock with memory reclaim?

This path calls amdgpu_svm_bo_evict() while the TTM buffer object's dma_resv
lock is held. This delegates to drm_pagemap_evict_to_ram(), which performs
an allocation using GFP_KERNEL:

drm_pagemap_evict_to_ram() {
    ...
    buf =3D kvcalloc(npages, 2 * sizeof(*src) + sizeof(*pagemap_addr) +
                   sizeof(*pages), GFP_KERNEL);
    ...
}

Allocating with GFP_KERNEL while holding a dma_resv lock can invoke the
shrinker (fs_reclaim). If the shrinker attempts to acquire dma_resv locks or
waits on fences depending on the held lock, will this cause a circular lock
dependency?

> +		if (!r)
> +			ttm_bo_move_null(bo, new_mem);
> +		return r;

[Severity: High]
Does returning early here bypass mandatory notifications and statistics
updates?

A successful eviction returns immediately, skipping the call to
amdgpu_bo_move_notify() which handles VM tracking cleanup and tracepoints.

It also entirely skips the statistics updates at the tail of
amdgpu_bo_move():

amdgpu_bo_move() {
    ...
    if (evict)
        atomic64_inc(&adev->num_evictions);
    atomic64_add(bo->base.size, &adev->num_bytes_moved);
    return 0;
}

Will missing these updates cause underreporting of evictions and moved byte=
s,
impacting driver debugging metrics and migration throttling?

> +	}
> +
>  	if (adev->mman.buffer_funcs_enabled &&
>  	    ((old_mem->mem_type =3D=3D TTM_PL_SYSTEM &&
>  	      new_mem->mem_type =3D=3D TTM_PL_VRAM) ||

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D15
