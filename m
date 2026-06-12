Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6954DCD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C508510E9BC;
	Fri, 12 Jun 2026 09:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZg272Nr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1DD10E9BC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:25:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72B92443BC;
 Fri, 12 Jun 2026 09:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C31F000E9;
 Fri, 12 Jun 2026 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256358;
 bh=EvK1V166S4rO3+nW82kOKfdqCk7pYlEkvCRDoLKQh8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KZg272NrGbI49oPZdvj8RaOBRjueaS0337w0th2NaoMgdxMbX78bk/GmxA00Y2M2z
 niQ6ksSqF5yqRDNVA+FlQcF39sod0lV7YJnkMcmaJc2XnDE34GEaZtX2Gw83WvBjwm
 VJNqJCx0EpPqudbjmdyi+XFZUjBONGKYFBG9ngsludTm1Q/KS16EyxwBc7a1u3JCVE
 9ZCX//9mrX9hXcOdpf028gaWn3Hoectdl2YTpbbcAy77/f1PJ94+1HbdR+jJjjEJF+
 6+TKH/HeIn5HzQ4/4RbGGB4o+x7iG1Fxwhp0dJxm+/6vAZtjJ2zHeXpAfMtGmvZlvt
 jItcPw9BxXdlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/18] drm/amdgpu: implement drm_pagemap SDMA
 migration callbacks
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-15-ray.huang@amd.com>
References: <20260612090928.29682-15-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:25:57 +0000
Message-Id: <20260612092558.3A7C31F000E9@smtp.kernel.org>
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
- [Critical] Missing NULL check for destination device pages in `amdgpu_svm=
_copy_to_devmem` leads to arbitrary GPU physical memory corruption.
- [High] Missing dma_resv lock acquisition before migration causes lockdep =
warnings, an imbalanced unlock, and a potential Use-After-Free in `amdgpu_s=
vm_populate_mm`.
- [High] `amdgpu_svm_copy_to_ram` executes asynchronous VRAM-to-RAM SDMA co=
pies without waiting for prior GPU operations to complete, causing data cor=
ruption during eviction.
--

commit 856e5efda96bd0348d0213ccfceffe664315be95
Author: Junhua Shen <Junhua.Shen@amd.com>
Subject: drm/amdgpu: implement drm_pagemap SDMA migration callbacks

This commit implements the drm_pagemap_devmem_ops and drm_pagemap_ops
callbacks for the DRM GPUSVM migration framework. It introduces a new BO
subtype for SVM to carry device memory allocations and implements mechanics
for SDMA copies between system RAM and VRAM.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_migrate.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c

[ ... ]

> @@ -380,31 +380,31 @@ static int
>  amdgpu_svm_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>  			    u64 *vram, u64 npages, int direction,
>  			    struct dma_fence **mfence)
>  {
>  	const u64 max_pages =3D AMDGPU_GTT_MAX_TRANSFER_SIZE;
>  	struct amdgpu_ring *ring =3D to_amdgpu_ring(adev->mman.buffer_funcs_sch=
eds[0]);
>  	struct amdgpu_ttm_buffer_entity *entity =3D &adev->mman.move_entities[0=
];
>  	u64 gart_s, gart_d;
>  	struct dma_fence *next;
>  	u64 size;
>  	int r;
> =20
>  	mutex_lock(&entity->lock);
> =20
>  	while (npages) {
>  		size =3D min(max_pages, npages);
> =20
>  		if (direction =3D=3D FROM_VRAM_TO_RAM) {
>  			gart_s =3D amdgpu_svm_direct_mapping_addr(adev, *vram);
>  			r =3D amdgpu_svm_gart_map(ring, entity, size, sys,
>  						&gart_d, AMDGPU_PTE_WRITEABLE);
>  		} else {
>  			r =3D amdgpu_svm_gart_map(ring, entity, size, sys,
>  						&gart_s, 0);
>  			gart_d =3D amdgpu_svm_direct_mapping_addr(adev, *vram);
>  		}
>  		if (r) {
>  			dev_err(adev->dev, "failed %d to map GART for SDMA\n", r);
>  			goto out_unlock;
>  		}
> =20
>  		AMDGPU_MIGRATE_TRACE("SDMA_COPY: %s npages=3D%llu vram_off=3D0x%llx\n",
>  				  direction =3D=3D FROM_RAM_TO_VRAM ? "RAM->VRAM" : "VRAM->RAM",
>  				  size, (u64)*vram);
> =20
>  		r =3D amdgpu_copy_buffer(adev, entity, gart_s, gart_d,
>  				       size * PAGE_SIZE,
>  				       NULL, &next, true, 0);

[Severity: High]
Can this SDMA copy race against active GPU compute shaders during eviction?

Looking at amdgpu_svm_bo_evict, it calls drm_pagemap_evict_to_ram,
which eventually calls amdgpu_svm_copy_to_ram without synchronously waiting
on the BO resv. Then amdgpu_svm_copy_memory_gart passes NULL for the resv
argument here to amdgpu_copy_buffer.

Without a CPU wait on bo->tbo.base.resv or implicit dependencies added to
the SDMA job, wouldn't the VRAM-to-RAM copy start immediately while writers
might still be modifying the VRAM, migrating corrupted or torn data back to
system memory?

[ ... ]

> +	for (i =3D 0, j =3D 0; i < npages; i++) {
> +		if (!pagemap_addr[i].addr)
> +			goto flush;
> +
> +		sys[j] =3D pagemap_addr[i].addr;
> +		vram[j] =3D ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +			  svm_dm->hpa_base;

[Severity: Critical]
Does this code safely handle missing destination pages?

The preamble loop in amdgpu_svm_copy_to_devmem acknowledges that the pages
array may contain NULL entries, but this loop only checks if the source
system page is valid via !pagemap_addr[i].addr.

If pages[i] is NULL, evaluating page_to_pfn(pages[i]) will perform pointer
arithmetic on a NULL pointer and produce a garbage PFN. Could this
instruct the SDMA engine to silently overwrite arbitrary GPU physical memor=
y?

The sister function amdgpu_svm_copy_to_ram explicitly checks !pages[i].

> +
> +		/* Check if next vram page is contiguous with current */
> +		if (j > 0 && vram[j] !=3D vram[j - 1] + PAGE_SIZE)
> +			goto flush;
> +
> +		j++;
> +		continue;
> +flush:
> +		if (j) {
> +			ret =3D amdgpu_svm_copy_memory_gart(adev, sys, vram, j,
> +							  FROM_RAM_TO_VRAM,
> +							  &mfence);
> +			if (ret)
> +				goto out_fence;
> +			j =3D 0;
> +		}
> +		/* Re-process current page if it was valid but broke contiguity */
> +		if (pagemap_addr[i].addr) {
> +			sys[0] =3D pagemap_addr[i].addr;
> +			vram[0] =3D ((u64)page_to_pfn(pages[i]) << PAGE_SHIFT) -
> +				  svm_dm->hpa_base;
> +			j =3D 1;
> +		}

[Severity: Critical]
Similarly, does the flush reprocessing block here need the same !pages[i]
check to prevent translating a NULL page pointer into a bogus VRAM offset?

[ ... ]

> @@ -735,21 +735,21 @@ static int
>  amdgpu_svm_populate_mm(struct drm_pagemap *dpagemap,
>  			unsigned long start, unsigned long end,
>  			struct mm_struct *mm,
>  			unsigned long timeslice_ms)
>  {
>  	struct amdgpu_device *adev =3D dpagemap_to_adev(dpagemap);
>  	struct drm_pagemap_migrate_details mdetails =3D {
>  		.timeslice_ms =3D timeslice_ms,
>  	};
>  	struct amdgpu_bo_svm *svm_bo;
>  	int ret;
> =20
>  	svm_bo =3D amdgpu_bo_svm_alloc(adev, dpagemap, mm, end - start);
>  	if (IS_ERR(svm_bo))
>  		return PTR_ERR(svm_bo);
> =20
>  	AMDGPU_MIGRATE_TRACE("populate_mm: [0x%lx-0x%lx] size=3D%lu\n",
>  			  start, end, end - start);
> =20
>  	ret =3D drm_pagemap_migrate_to_devmem(&svm_bo->devmem,
>  					     mm, start, end,
>  					     &mdetails);
> =20
>  	amdgpu_bo_unreserve(&svm_bo->bo);
> =20
>  	return ret;
>  }

[Severity: High]
Is this BO actually locked before being unreserved?

In amdgpu_bo_svm_alloc, bp.resv is zero-initialized to NULL, which causes
amdgpu_bo_create to explicitly unreserve the BO before returning it. So the
BO is passed unlocked to drm_pagemap_migrate_to_devmem.

This seems to cause three issues:
1. amdgpu_svm_populate_devmem_pfn will fail its
dma_resv_assert_held(bo->tbo.base.resv) check.
2. amdgpu_bo_unreserve is attempting to unlock a ww_mutex that is already
unlocked.
3. If the migration fails and the framework drops the devmem reference,
amdgpu_svm_devmem_release frees the BO. The subsequent unreserve here
would then dereference freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D14
