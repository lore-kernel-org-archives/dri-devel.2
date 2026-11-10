Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70403606A916
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meJ5dehI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C673A10EECC;
	Tue, 10 Nov 2026 09:23:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40DB10E0EF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:22:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 792064082E;
 Tue, 10 Nov 2026 09:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306441F008A2;
 Tue, 10 Nov 2026 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794302577;
 bh=Y5HFF9Lbqc/jUcxqumtCCcxHLkUdM953Ip1z6l6I7mE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=meJ5dehIBFgW7JGyQAbU/c7dZWEou7rp8OSZ5VH4+5zrSybPRUxr4VNmctLIqtKlI
 czG7+0HmeViyCD0az4oab3dMlXlPiwpEcPDVUNJ3KJ9kv5lGISPWHIvlcmBVQqKNS/
 1oQtXn9xQ7Mx797qalnIFm0dbzVkgKbtm1j8mFy8kqJNImeQ135vc/m0djb/2ELMAh
 S1Tgw4XL27lelZy5HR63Oi3fP/dAEBQ8u21C27cIcSDqITTqkdcfuGKyax+twSSPay
 KZp8eKU94yFc5KfciWUeRgIh+U4FDamIpL6ulDlkx5lBdX4VMao8nBB0rFbAT3mo0e
 1Dh7d16SJq80Q==
Message-ID: <sashiko-outbox-206721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/ttm: check for NULL resource in
 ttm_bo_vm_fault_reserved()
To: kaii-k <harshicon28@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261109202330.1816799-3-harshicon28@gmail.com>
References: <20261109202330.1816799-1-harshicon28@gmail.com>
 <20261109202330.1816799-3-harshicon28@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:22:56 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/xe/oa: missing vm_pgoff check in xe_oa_mmap() [1]
--

commit e95d22b6c456f4e471c0ed18ffb86dc352011af3
Author: Harsh Parmar <kaii02ctf@gmail.com>

drm/ttm: check for NULL resource in ttm_bo_vm_fault_reserved()

This commit adds a NULL check on bo->resource in ttm_bo_vm_fault_reserved()
and returns VM_FAULT_SIGBUS when a buffer object has no backing store.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo=
_vm.c
> index 872bf444b1f0f..69dd6bdd54022 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -205,6 +205,9 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *=
vmf,
>  	if (unlikely(ret !=3D 0))
>  		return ret;
> =20
> +	if (unlikely(!bo->resource))
> +		return VM_FAULT_SIGBUS;
> +
>  	err =3D ttm_mem_io_reserve(bo->bdev, bo->resource);
>  	if (unlikely(err !=3D 0))
>  		return VM_FAULT_SIGBUS;

[Severity: Critical]
This problem wasn't introduced by this patch, but can the prefault loop in
ttm_bo_vm_fault_reserved() read past the end of ttm->pages[] [1] when a
VMA has a non-zero vm_pgoff?

drivers/gpu/drm/ttm/ttm_bo_vm.c:ttm_bo_vm_fault_reserved() {
	...
	page_offset =3D linear_page_index(vma, address) -
		drm_vma_node_start(&bo->base.vma_node);
	page_last =3D vma_end_pgoff(vma) -
		drm_vma_node_start(&bo->base.vma_node);

	if (unlikely(page_offset >=3D PFN_UP(bo->base.size)))
		return VM_FAULT_SIGBUS;
	...
	for (i =3D 0; i < num_prefault; ++i) {
		if (bo->resource->bus.is_iomem) {
			pfn =3D ttm_bo_io_mem_pfn(bo, page_offset);
		} else {
			page =3D ttm->pages[page_offset];
			...
			pfn =3D page_to_pfn(page);
		}
		...
		ret =3D vmf_insert_pfn_prot(vma, address, pfn, prot);
		...
		address +=3D PAGE_SIZE;
		if (unlikely(++page_offset >=3D page_last))
			break;
	}
}

For example, xe_oa_mmap() checks that the VMA size equals xe_bo_size(bo)
before calling drm_gem_mmap_obj(), but neither checks nor zeroes
vma->vm_pgoff.  Because stream->oa_buffer.bo is a ttm_bo_type_kernel object,
drm_vma_node_start(&bo->base.vma_node) is 0 and page_last becomes
vma->vm_pgoff + PFN_UP(bo->base.size).  A fault near the end of the buffer
passes the initial PFN_UP(bo->base.size) check, and the prefault loop then
steps page_offset past PFN_UP(bo->base.size) toward page_last, dereferencing
out-of-bounds ttm->pages[] entries or mapping out-of-bounds PFNs into
userspace.

[1] https://sashiko.dev/#/bug/linux-d5cc9df6-b93b-44e4-8837-59f1909411f7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109202330.1816=
799-1-harshicon28@gmail.com?part=3D3
