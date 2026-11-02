Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E327606F207
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWJnFkz/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF46D10EFC6;
	Mon,  2 Nov 2026 15:17:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5ED10EFC6
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:17:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CA6F43FD3;
 Mon,  2 Nov 2026 15:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F691F00A17;
 Mon,  2 Nov 2026 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793632639;
 bh=myt9x1lACVP6WnHo5iSfzeXU2a4P69pXSCUxVBPYZ0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LWJnFkz/Wu2Nce+8KMHQj0VC5+38qvmzmHTDqG/be5sDVXHRgHHqEezWZ52/y4rBx
 5LB4maFzFuEqnPfYHcTaEqzPHlIcI/qlTpPLlbL4D0IahroTLRsfEuG0kMlqz2AFbE
 MP57lHE8UINFMK5tfOkNds2EDDU5SMJZGiqsFq5Kcsx0tpQ03fL9QLFDwgb8BBSecr
 HS8XbJlwqI3sJc8mnbotoSOP46/Bgxly0n+BVH6VltEth0K3QrjR13u1Qv6rc1aY2E
 uEu1pg1cTu5P3Pcq/xnGAo8dPjYkUw3f/DwrCibOV+vDJg2UvEhwJG2B+n+rxhXGt3
 5tL8yJ5Gf9X2g==
Message-ID: <sashiko-outbox-193648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: reject foreign device pages in
 svm_range_dma_map_dev()
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com>
References: <20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:17:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] drm/amdkfd: race and UAF on prange->svm_bo in svm_range_dma_ma=
p_dev()
- [Critical] drm/amdkfd: foreign svm_bo pages on same GPU mapped in svm_ran=
ge_dma_map_dev()
--

commit c0faccc56cc8a73d1adc2bd585a5c86379e8e7e7
Author: Aveline Noir <jm5905938@gmail.com>

drm/amdkfd: reject foreign device pages in svm_range_dma_map_dev()

This commit updates svm_range_dma_map_dev() to reject zone device pages who=
se
pgmap does not match the device of prange->svm_bo with -EFAULT, clearing the
DMA address entry before returning.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index ed5e3318877be..6e9b9dcaa1361 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -181,7 +181,21 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, st=
ruct svm_range *prange,
> =20
>  		page =3D hmm_pfn_to_page(hmm_pfns[i]);
>  		if (is_zone_device_page(page)) {
> -			struct amdgpu_device *bo_adev =3D prange->svm_bo->node->adev;
> +			struct amdgpu_device *bo_adev =3D prange->svm_bo ?
> +				prange->svm_bo->node->adev : NULL;

[Severity: Critical]
Can reading prange->svm_bo here without checking prange->ttm_res and without
holding prange->lock race with svm_range_bo_release() and cause a
use-after-free or NULL pointer dereference?

A struct svm_range only holds a reference on prange->svm_bo while
prange->ttm_res is non-NULL. When svm_range_vram_node_free() releases a
range's VRAM allocation, it clears prange->ttm_res and drops the range's
reference on prange->svm_bo while leaving prange->svm_bo non-NULL until the
final reference is released:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_vram_node_free() {
	if (prange->ttm_res) {
		prange->ttm_res =3D NULL;
		mutex_unlock(&prange->lock);
		svm_range_bo_unref(prange->svm_bo);
	} else
		mutex_unlock(&prange->lock);
}

When the last reference to svm_bo is dropped (for example via asynchronous
folio release work in svm_migrate_folio_free() -> svm_range_bo_unref_async()
-> svm_range_bo_wq_release()), svm_range_bo_release() clears prange->svm_bo
under prange->lock without holding prange->migrate_mutex and then frees
svm_bo:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_bo_release() {
		mutex_lock(&prange->lock);
		prange->svm_bo =3D NULL;
		/* prange should not hold vram page now */
		WARN_ONCE(prange->actual_loc, "prange should not hold vram page");
		mutex_unlock(&prange->lock);
}

In svm_range_validate_and_map(), svm_range_dma_map() ->
svm_range_dma_map_dev() runs before svm_range_lock(prange) is acquired:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_validate_and_map() {
		if (!r) {
			offset =3D (addr >> PAGE_SHIFT) - prange->start;
			r =3D svm_range_dma_map(prange, ctx->bitmap, offset, npages,
					      range->hmm_range.hmm_pfns);
			if (r)
				pr_debug("failed %d to dma map range\n", r);
		}

		svm_range_lock(prange);
}

If prange->ttm_res is NULL while a stale prange->svm_bo pointer is still se=
t,
can svm_range_bo_release() clear prange->svm_bo and free svm_bo concurrently
with svm_range_dma_map_dev()? In addition, if a stale prange->svm_bo on the
same device allows addr[i] to be marked with SVM_RANGE_VRAM_DOMAIN while
prange->ttm_res is NULL, wouldn't svm_range_map_to_gpus() see
(prange->svm_bo && prange->ttm_res) as false and pass vram_base_offset =3D =
0, or
crash in svm_range_get_pte_flags() when dereferencing prange->svm_bo->node?

> +
> +			/*
> +			 * The pgmap owner is per device or XGMI hive, so HMM
> +			 * may return a page of another svm_bo, e.g. one shared
> +			 * with another process after fork(). The VRAM address
> +			 * below and svm_range_get_pte_flags() assume the
> +			 * svm_bo device.
> +			 */
> +			if (!bo_adev ||
> +			    page_pgmap(page) !=3D &bo_adev->kfd.pgmap) {
> +				addr[i] =3D 0;
> +				return -EFAULT;
> +			}

[Severity: Critical]
Does checking page_pgmap(page) !=3D &bo_adev->kfd.pgmap still allow foreign
svm_bo pages that reside on the same amdgpu_device to be mapped into the
range's GPU page tables?

In svm_migrate_get_vram_page(), each KFD VRAM zone device page records its
owning struct svm_range_bo in page->zone_device_data, whereas
bo_adev->kfd.pgmap is shared across the entire amdgpu_device:

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:svm_migrate_get_vram_page() {
	svm_range_bo_ref(prange->svm_bo);
	page->zone_device_data =3D prange->svm_bo;
	zone_device_page_init(page, page_pgmap(page), 0);
}

After fork(), a child range can hold both system RAM pages and COW-shared
device-private pages belonging to the parent's svm_bo on a given GPU. If the
child migrates that range to the same GPU via svm_migrate_ram_to_vram(),
svm_range_vram_node_new() allocates a new child svm_bo on that GPU, and
svm_migrate_vma_to_vram() only selects system RAM pages via
MIGRATE_VMA_SELECT_SYSTEM, leaving the parent's device-private PTEs in plac=
e:

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:svm_migrate_vma_to_vram() {
	migrate.vma =3D vma;
	migrate.start =3D start;
	migrate.end =3D end;
	migrate.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
	migrate.pgmap_owner =3D SVM_ADEV_PGMAP_OWNER(adev);
}

When svm_range_validate_and_map() -> svm_range_dma_map_dev() subsequently
validates the child range, hmm_range_fault() returns the parent's zone devi=
ce
pages, and page_pgmap(page) =3D=3D &bo_adev->kfd.pgmap succeeds because both
svm_bo objects are on the same amdgpu_device.

Wouldn't accepting a page with page->zone_device_data !=3D prange->svm_bo:
1. Map COW-shared parent VRAM pages as writable in the child's GPU VM when
   vma->vm_flags has VM_WRITE set, allowing the child GPU to overwrite pare=
nt
   memory?
2. Leave dangling GPU PTEs when the parent's svm_bo is evicted or freed,
   because the child prange is only on its own prange->svm_bo->range_list?
3. Use the wrong XCP partition in svm_range_get_pte_flags()
   (bo_node =3D prange->svm_bo->node) on multi-partition GPUs that share a
   single adev->kfd.pgmap?
4. Underflow old->vram_pages during svm_range_split_pages(), which counts a=
ll
   dma_addr entries with SVM_RANGE_VRAM_DOMAIN set even though those foreign
   pages were never added to prange->vram_pages?

Should this check verify that prange->ttm_res is non-NULL and
page->zone_device_data =3D=3D prange->svm_bo instead of comparing page_pgma=
p(page)
against &bo_adev->kfd.pgmap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-kfd-svm-fo=
reign-vram-20261103-v1-1-d6282053cad3@gmail.com?part=3D1
