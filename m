Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11F606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moqx0b4P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FC01120B0;
	Thu,  5 Nov 2026 21:04:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1580510FDC0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:04:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA4664148E;
 Thu,  5 Nov 2026 21:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FB01F008A1;
 Thu,  5 Nov 2026 21:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793912684;
 bh=ql18uuSZCgztA1nz6EBPa8YRmymR9Q6owZdvhh8bJEw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=moqx0b4PIXCX/lb7miJ+6kGsPRIUUzEALphaqVBkamueX8YVAzlcDgNNq4btn3oHA
 mNQaBRkdS8KyEAG6PLrhAHo728yO0MdovUs5QyYeBxresyjjvVHLfUkvDt0rkBA7+f
 4CNa8wKvH538EOU2dm4LzuGEUwNgziOFQwixVuN+9SvRyb5/uosTVIl299+2CF6d83
 ChJshem4HeP9zMhhj6JI0zTtOYCddPAz+Az0NkTtCmIygThKE5IsauK63LmkWlSBYx
 4TzfNQPOMYVsEGroIVyuvKH6LcUrH7+1jxyRmx1DOjwIStvHo3m1Gbr6G20sCicTX6
 4lX68rUNLIKKQ==
Message-ID: <sashiko-outbox-200180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdkfd: Check ownership of device pages for DMA
 mapping
To: "Felix Kuehling" <felix.kuehling@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105204748.100841-1-felix.kuehling@amd.com>
References: <20261105204748.100841-1-felix.kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:04:44 +0000
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
- [High] drm/amdkfd: foreign same-hive device-private pages fail in svm_ran=
ge_dma_map_dev()
- [Medium] drm/amdkfd: zone_device pages passed to dma_map_page() in svm_ra=
nge_dma_map_dev()
--

commit 4c4b5ea0be7e18e7dd7d7ea4bdf8afccdf70d9ed
Author: Felix Kuehling <felix.kuehling@amd.com>

drm/amdkfd: Check ownership of device pages for DMA mapping

This commit checks whether a zone device page belongs to the target SVM
range via zone_device_data before computing its VRAM address in
svm_range_dma_map_dev(). Device-private pages from other devices or ranges
are rejected with -EINVAL, while other non-owned pages fall through to
dma_map_page().

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index ed5e3318877be..7320a2981d3b2 100644
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
> @@ -189,6 +201,16 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, st=
ruct svm_range *prange,
>  			addr[i] |=3D SVM_RANGE_VRAM_DOMAIN;
>  			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>  			continue;
> +		} else if (is_device_private_page(page)) {
> +			/* Device private memory from another driver or range.
> +			 * This should never happen in practice but it's
> +			 * theoretically possible for read-only VMAs after a
> +			 * process forks, creates a new KFD context and maps
> +			 * the same page.
> +			 */
> +			pr_debug("Trying to map device private page from another device or ra=
nge\n");
> +			addr[i] =3D 0;
> +			return -EINVAL;
>  		}

[Severity: High]
As reported by Sashiko on v1 [1], can this also trigger on writable COW VMAs
after fork() or after mremap() from another range on the same GPU or XGMI
hive, causing svm_range_dma_map_dev() to fail with -EINVAL instead of
faulting the page back to system RAM?

On GPUs using MEMORY_DEVICE_PRIVATE, kgd2kfd_init_zone_device() sets
pgmap->owner to SVM_ADEV_PGMAP_OWNER(adev), which is shared across all
processes and all svm_range instances on that GPU or hive. In
svm_range_validate_and_map(), kfd_svm_page_owner() passes this device-wide
or hive-wide owner to amdgpu_hmm_range_get_pages() even when prange->ttm_res
is NULL or prange->svm_bo does not own the underlying pages:

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
}

When amdgpu_hmm_range_get_pages() calls hmm_range_fault(),
hmm_vma_handle_pte() checks whether the device-private swap entry's
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
	...
}

Because pgmap->owner matches range->dev_private_owner, hmm_vma_handle_pte()
jumps directly to out before calling hmm_pte_need_fault(), returning the
device-private PFN in hmm_pfns without faulting it back to system RAM (even
when HMM_PFN_REQ_WRITE is set on a read-only COW entry after fork(), or
when pages were moved via mremap() from another range).

When those PFNs reach svm_range_dma_map_dev(), svm_page_is_range_owned()
returns false because prange->ttm_res is NULL or page->zone_device_data !=3D
prange->svm_bo, and is_device_private_page(page) returns true, failing with
-EINVAL and causing svm_range_restore_work() to loop indefinitely while user
queues remain suspended.

>  		addr[i] =3D dma_map_page(dev, page, 0, PAGE_SIZE, dir);

[Severity: Medium]
As reported by Sashiko on v1 [2], is it valid to pass non-private
ZONE_DEVICE pages (such as DAX pages or foreign MEMORY_DEVICE_COHERENT pages
from another GPU hive or process) to dma_map_page() here?

When a page in hmm_pfns is a ZONE_DEVICE page that does not belong to prange
(svm_page_is_range_owned(page, prange) is false) and is not a device-private
page (is_device_private_page(page) is false), execution falls through to
dma_map_page(), which expands to dma_map_page_attrs().

In kernel/dma/mapping.c, dma_map_page_attrs() explicitly rejects all
ZONE_DEVICE pages when CONFIG_DMA_API_DEBUG is enabled:

kernel/dma/mapping.c:dma_map_page_attrs() {
	...
	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
	    WARN_ON_ONCE(is_zone_device_page(page)))
		return DMA_MAPPING_ERROR;
	...
}

Wouldn't mapping DAX memory or foreign coherent device pages in an SVM range
trigger this warning and fail with -ENOMEM when CONFIG_DMA_API_DEBUG is
enabled?

[1] https://lore.kernel.org/r/sashiko-outbox-199820@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-199820@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105204748.1008=
41-1-felix.kuehling@amd.com?part=3D1
