Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A1606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEjYqMIt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC08B10E361;
	Thu,  5 Nov 2026 19:11:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A64E10E958
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:11:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A3B543CE5;
 Thu,  5 Nov 2026 19:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625841F000C1;
 Thu,  5 Nov 2026 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793905871;
 bh=44c+2abRtx38LSEFyM9cf57rXevIrgeIDvzpvUkQI5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KEjYqMItAq2hODp5uUYrR2b29D1diVdJLNO6B+30N5HZFwOLdueNRkNRaFIgfcpFt
 SWuLTZtnpF7eKwSTZkng/UJJfv1jyUatt9GF2GeUxNQeJLbwze5A8MCw4O29AM53LC
 UDfP1m5RxajBzwWPebzQApdo9+Tgco32/l8eBfQn5ddctphZOPtS/YkMtJPhpS+F3n
 MJ7yrI8z7KEUzz2mZ33QzVAI+ERodhK04wDnoyJVWtlhkk4R004xyuRIM6NT7TN+dG
 4d+sGK6dw4dQ1asrhZF0xqVmP/SDVIYro8Nosh4ES+qBPVoD+F31zX4ui6yFkMpTbQ
 jgGlACN8iuPtw==
Message-ID: <sashiko-outbox-199820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Check ownership of device pages for DMA
 mapping
To: "Felix Kuehling" <felix.kuehling@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105185828.85367-1-felix.kuehling@amd.com>
References: <20261105185828.85367-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:11:11 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/amdkfd: foreign same-hive device-private pages fail in svm_ran=
ge_dma_map_dev()
- [High] drm/amdkfd: double dma_unmap_page() on error return in svm_range_d=
ma_map_dev()
- [Medium] drm/amdkfd: calling dma_map_page() on zone_device pages in svm_r=
ange_dma_map_dev()
--

commit 591a056ad47c1c9d032b2eceed7f51b0bb221d8d
Author: Felix Kuehling <felix.kuehling@amd.com>

drm/amdkfd: Check ownership of device pages for DMA mapping

This commit checks whether a zone device page belongs to the target SVM
range via svm_page_is_range_owned() before computing a VRAM domain
address in svm_range_dma_map_dev(). Device-private pages not owned by
the range trigger a warning and return -EINVAL, while other non-owned
pages fall through to dma_map_page().

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index ed5e3318877be..5807a26d7debf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -156,6 +156,18 @@ svm_is_valid_dma_mapping_addr(struct device *dev, dm=
a_addr_t dma_addr)
>  	       !(dma_addr & SVM_RANGE_VRAM_DOMAIN);
>  }
> =20
> +static bool svm_page_is_range_owned(struct page *page, struct svm_range =
*prange)
> +{
> +	bool is_owned;
> +
> +	mutex_lock(&prange->lock);
> +	is_owned =3D is_zone_device_page(page) && prange->ttm_res &&
> +		page->zone_device_data =3D=3D prange->svm_bo;
> +	mutex_unlock(&prange->lock);
> +
> +	return is_owned;
> +}
> +
>  static int
>  svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *pran=
ge,
>  		      unsigned long offset, unsigned long npages,
> @@ -180,7 +192,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, str=
uct svm_range *prange,
>  			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
> =20
>  		page =3D hmm_pfn_to_page(hmm_pfns[i]);
> -		if (is_zone_device_page(page)) {
> +		if (svm_page_is_range_owned(page, prange)) {
>  			struct amdgpu_device *bo_adev =3D prange->svm_bo->node->adev;
> =20
>  			addr[i] =3D (hmm_pfns[i] << PAGE_SHIFT) +
> @@ -189,6 +201,11 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, st=
ruct svm_range *prange,
>  			addr[i] |=3D SVM_RANGE_VRAM_DOMAIN;
>  			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>  			continue;
> +		} else if (WARN_ON_ONCE(is_device_private_page(page))) {
> +			/* Device private memory from another driver or range.
> +			 * This should never happen.
> +			 */
> +			return -EINVAL;
>  		}

[Severity: High]
Can device-private pages from another SVM range or a parent process on
the same GPU or XGMI hive reach this branch and trigger WARN_ON_ONCE()
and -EINVAL?

On GPUs using MEMORY_DEVICE_PRIVATE, kgd2kfd_init_zone_device() sets
pgmap->owner to SVM_ADEV_PGMAP_OWNER(adev), which is a device-wide or
hive-wide pointer shared across all processes and all svm_range structs
on that GPU or hive.

In svm_range_validate_and_map(), owner is computed via
kfd_svm_page_owner(), which unconditionally returns
SVM_ADEV_PGMAP_OWNER(pdd->dev->adev) even when prange->ttm_res is NULL
or prange->svm_bo is a different BO:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:kfd_svm_page_owner() {
	...
	return SVM_ADEV_PGMAP_OWNER(pdd->dev->adev);
}

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_validate_and_map() {
	...
	owner =3D kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
						MAX_GPU_INSTANCE));
	for_each_set_bit(idx, ctx->bitmap, MAX_GPU_INSTANCE) {
		if (kfd_svm_page_owner(p, idx) !=3D owner) {
			owner =3D NULL;
			break;
		}
	}
	...
	r =3D amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
				       readonly, owner,
				       ctx->hmm_range[bitmap_unchanged]);
}

When amdgpu_hmm_range_get_pages() calls hmm_range_fault(),
hmm_vma_handle_pte() skips faulting any device-private swap entry whose
pgmap->owner matches range->dev_private_owner:

mm/hmm.c:hmm_vma_handle_pte() {
	...
		if (softleaf_is_device_private(entry) &&
		    page_pgmap(softleaf_to_page(entry))->owner =3D=3D
		    range->dev_private_owner) {
			cpu_flags =3D HMM_PFN_VALID;
			if (softleaf_is_device_private_write(entry))
				cpu_flags |=3D HMM_PFN_WRITE;
			new_pfn_flags =3D softleaf_to_pfn(entry) | cpu_flags;
			goto out;
		}
}

If a process validates an SVM range containing MEMORY_DEVICE_PRIVATE
pages inherited via fork() or moved via mremap() from another range on
the same GPU or hive, hmm_range_fault() will not fault those pages back
to system RAM and will return them in hmm_pfns. When
svm_range_dma_map_dev() then checks svm_page_is_range_owned(page,
prange), it returns false because prange->ttm_res is NULL or
page->zone_device_data !=3D prange->svm_bo, hitting the WARN_ON_ONCE() and
failing range validation with -EINVAL.

[Severity: High]
Also, if this -EINVAL path is taken when addr[i] previously held a valid
system-memory DMA mapping, does it leave a stale DMA address in addr[i]
that causes a double dma_unmap_page()?

At the start of the loop in svm_range_dma_map_dev(), an existing valid
mapping is unmapped without clearing addr[i]:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_map_dev() {
	...
	for (i =3D 0; i < npages; i++) {
		if (svm_is_valid_dma_mapping_addr(dev, addr[i]))
			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
}

Prior to this change, every path after dma_unmap_page() overwrote
addr[i]. Returning -EINVAL before updating or zeroing addr[i] leaves the
unmapped DMA address in prange->dma_addr[gpuidx], so a later call to
svm_range_dma_unmap_dev() (or a subsequent svm_range_dma_map_dev() call)
will see svm_is_valid_dma_mapping_addr(dev, addr[i]) as true and call
dma_unmap_page() a second time on the same address:

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_dma_unmap_dev() {
	...
	for (i =3D offset; i < offset + npages; i++) {
		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
			continue;
		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
		dma_addr[i] =3D 0;
	}
}

>  		addr[i] =3D dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>  		r =3D dma_mapping_error(dev, addr[i]);

[Severity: Medium]
Is it valid to pass non-private ZONE_DEVICE pages (such as DAX pages or
foreign MEMORY_DEVICE_COHERENT pages) to dma_map_page() here?

When svm_page_is_range_owned(page, prange) and
is_device_private_page(page) both return false for a ZONE_DEVICE page,
execution falls through to dma_map_page(), which expands to
dma_map_page_attrs(). In kernel/dma/mapping.c, dma_map_page_attrs()
rejects all ZONE_DEVICE pages when CONFIG_DMA_API_DEBUG is enabled:

kernel/dma/mapping.c:dma_map_page_attrs() {
	...
	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
	    WARN_ON_ONCE(is_zone_device_page(page)))
		return DMA_MAPPING_ERROR;
}

Wouldn't mapping DAX memory or coherent device pages from another GPU
hive trigger this warning and fail with -ENOMEM on kernels with
CONFIG_DMA_API_DEBUG enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185828.8536=
7-1-felix.kuehling@amd.com?part=3D1
