Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uvcv8gqo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7351129DE;
	Fri, 30 Oct 2026 21:11:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E23C1129DE
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:11:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BD79601EE;
 Fri, 30 Oct 2026 21:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF62D1F000C1;
 Fri, 30 Oct 2026 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793394704;
 bh=VSKRXAcEMmPD/UzgRcrAjdVrVHataiKPziyzoS0WJys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uvcv8gqoWgb0fkRRgORpYMJK+e71nOBsJbzGqdjkvv3+XE21dQ3a031VY+3EoNVCH
 vROCrxe2lU1NEeBvqXx35mTRRwROmH2t29oAlAyI/uEXV5sPvg2TtWisqeE6zQxDVw
 1U6+zNPqZDVHrYqk4Kh+eDQqlcG4/mEwJAAT4rit37dxXBeC1tp6/o8+PnSutQHcB6
 4uJPnRynqnE+m7dBG3rpv/PaKfS0+yCt6iFRFu+W5y5fL2J3AnmpOaUwg9H1FfPYv+
 /Az4DII0Z4N5ImK8TvRwdcR2gV4XPdLZTMlvv07MgUU2dgxvHzI1ygd+OHOHlVoJ0t
 Fd8/vU2V1sQjA==
Message-ID: <sashiko-outbox-191514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/12] drm/shmem: Add a drm_gem_shmem_sync() helper
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-v3d-cached-maps-v1-3-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
 <20261030-v3d-cached-maps-v1-3-0a6a6b363382@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 21:11:44 +0000
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
- [Critical] drm/shmem: use-after-free in drm_gem_shmem_sync() due to unloc=
ked sgt walk
- [Critical] drm/shmem: drm_gem_shmem_sync() calls dma_sync_single_* on coa=
lesced IOVA sgl
- [High] drm/shmem: drm_gem_shmem_sync() allocates pages on unbacked or pur=
ged BOs
--

commit d4e8dcdfcd9df9ada386f6de7bfd50169a8e2266
Author: Faith Ekstrand <faith.ekstrand@collabora.com>

drm/shmem: Add a drm_gem_shmem_sync() helper

This commit adds a drm_gem_shmem_sync() helper to synchronize CPU-mapped
shmem GEM objects between the CPU and GPU via dma_sync_single_for_device()
and dma_sync_single_for_cpu().

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 13c4a68fdde0e..9bf727fc1c197 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -790,6 +790,99 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *=
shmem, struct vm_area_struct
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_mmap);
> =20
> +/**
> + * drm_gem_shmem_sync - Sync CPU-mapped data
> + * @shmem: shmem GEM object
> + * @offset: Offset into the GEM object
> + * @size: Size of the area to sync
> + * @type: Type of synchronization
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_shmem_sync(struct drm_gem_shmem_object *shmem, size_t offset,
> +		       size_t size, enum drm_gem_shmem_sync_type type)
> +{
> +	const struct drm_device *dev =3D shmem->base.dev;
> +	struct sg_table *sgt;
> +	struct scatterlist *sgl;
> +	unsigned int count;
> +
> +	/* Make sure the range is in bounds. */
> +	if (offset + size < offset || offset + size > shmem->base.size)
> +		return -EINVAL;
> +
> +	/* Disallow CPU-cache maintenance on imported buffers. */
> +	if (drm_gem_is_imported(&shmem->base))
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH:
> +	case DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE:
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Don't bother if it's WC-mapped */
> +	if (shmem->map_wc)
> +		return 0;
> +
> +	/* Nothing to do if the size is zero. */
> +	if (size =3D=3D 0)
> +		return 0;
> +
> +	sgt =3D drm_gem_shmem_get_pages_sgt(shmem);
> +	if (IS_ERR(sgt))
> +		return PTR_ERR(sgt);

[Severity: High]
Won't calling drm_gem_shmem_get_pages_sgt() here allocate backing pages and
create a DMA mapping even when the object has no backing pages yet
(!shmem->pages) or has already been purged (shmem->madv < 0)?

In drivers/gpu/drm/drm_gem_shmem_helper.c, drm_gem_shmem_get_pages_sgt()
calls drm_gem_shmem_get_pages_sgt_locked():

	if (shmem->sgt)
		return shmem->sgt;

	drm_WARN_ON(obj->dev, drm_gem_is_imported(obj));

	ret =3D drm_gem_shmem_get_pages_locked(shmem);

If drm_gem_shmem_sync() is called on an unbacked object, this populates
shmem->pages and shmem->sgt even though no CPU-mapped pages exist to sync.

More importantly, if the object was already purged via
drm_gem_shmem_purge_locked(), shmem->madv is -1 and shmem->sgt is NULL.
Calling drm_gem_shmem_get_pages_sgt() allocates fresh backing pages (or
increments pages_use_count on truncated pages if a VMA is still open) and
creates a new shmem->sgt while shmem->madv remains -1. Because
drm_gem_shmem_is_purgeable() in include/drm/drm_gem_shmem_helper.h checks
for shmem->madv > 0:

	return (shmem->madv > 0) &&
		!refcount_read(&shmem->pages_pin_count) && shmem->sgt &&
		!shmem->base.dma_buf && !drm_gem_is_imported(&shmem->base);

and drm_gem_shmem_madvise_locked() ignores updates when shmem->madv < 0,
those newly allocated pages and sg_table cannot be faulted in by userspace
and can never be reclaimed by the shrinker until the GEM object is
destroyed.

Should drm_gem_shmem_sync() check under shmem->base.resv whether the object
is purged or has no pages before attempting to sync?

> +
> +	for_each_sgtable_dma_sg(sgt, sgl, count) {

[Severity: Critical]
Can traversing sgt here race with drm_gem_shmem_purge_locked() and cause a
use-after-free?

In drivers/gpu/drm/drm_gem_shmem_helper.c, drm_gem_shmem_get_pages_sgt()
unlocks shmem->base.resv before returning sgt, and only increments
shmem->pages_use_count while leaving shmem->pages_pin_count at zero:

	ret =3D dma_resv_lock_interruptible(shmem->base.resv, NULL);
	if (ret)
		return ERR_PTR(ret);
	sgt =3D drm_gem_shmem_get_pages_sgt_locked(shmem);
	dma_resv_unlock(shmem->base.resv);

	return sgt;

For non-imported shmem objects, shmem->sgt and shmem->pages are protected by
shmem->base.resv. If userspace marks the buffer purgeable (shmem->madv > 0)
while shmem->pages_pin_count is zero, a concurrent shrinker thread calling
drm_gem_shmem_purge_locked() (or a caller invoking
__drm_gem_shmem_free_sgt_locked()) can acquire shmem->base.resv right after
drm_gem_shmem_get_pages_sgt() unlocks it:

	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
	sg_free_table(shmem->sgt);
	kfree(shmem->sgt);
	shmem->sgt =3D NULL;

	drm_gem_shmem_put_pages_locked(shmem);

That unmaps and frees shmem->sgt and releases the backing pages while
drm_gem_shmem_sync() is walking sgt and running DMA cache maintenance in
for_each_sgtable_dma_sg().

Should drm_gem_shmem_sync() hold shmem->base.resv (using
drm_gem_shmem_get_pages_sgt_locked()) across the sg_table walk?

> +		if (size =3D=3D 0)
> +			break;
> +
> +		dma_addr_t paddr =3D sg_dma_address(sgl);
> +		size_t len =3D sg_dma_len(sgl);
> +
> +		if (len <=3D offset) {
> +			offset -=3D len;
> +			continue;
> +		}
> +
> +		paddr +=3D offset;
> +		len -=3D offset;
> +		len =3D min_t(size_t, len, size);
> +		size -=3D len;
> +		offset =3D 0;
> +
> +		/* It's unclear whether dma_sync_xxx() is the right API to do CPU
> +		 * cache maintenance given an IOMMU can register their own
> +		 * implementation doing more than just CPU cache flushes/invalidation,
> +		 * and what we really care about here is CPU caches only, but that's
> +		 * the best we have that is both arch-agnostic and does at least the
> +		 * CPU cache maintenance on a <page,offset,size> tuple.
> +		 *
> +		 * Also, I wish we could do a single
> +		 *
> +		 *	dma_sync_single_for_device(BIDIR)
> +		 *
> +		 * and get a flush+invalidate, but that's not how it's implemented
> +		 * in practice (at least on arm64), so we have to make it
> +		 *
> +		 *	dma_sync_single_for_device(TO_DEVICE)
> +		 *	dma_sync_single_for_cpu(FROM_DEVICE)
> +		 *
> +		 * for the flush+invalidate case.
> +		 */
> +		dma_sync_single_for_device(dev->dev, paddr, len, DMA_TO_DEVICE);
> +		if (type =3D=3D DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE)
> +			dma_sync_single_for_cpu(dev->dev, paddr, len, DMA_FROM_DEVICE);

[Severity: Critical]
Is it safe to pass coalesced scatterlist DMA segments (sg_dma_address(sgl)
and sg_dma_len(sgl)) to dma_sync_single_for_device() and
dma_sync_single_for_cpu() when the device is behind an IOMMU?

In drm_gem_shmem_get_pages_sgt_locked(), shmem->sgt is mapped with
dma_map_sgtable(). When dev->dev uses an IOMMU DMA domain, iommu_dma_map_sg=
()
coalesces physically discontiguous scatterlist entries (sgt->orig_nents) in=
to
virtually contiguous IOVA segments (sgt->nents), so a single sg_dma_len(sgl)
entry can span multiple discontiguous physical pages.

However, in drivers/iommu/dma-iommu.c, iommu_dma_sync_single_for_cpu() and
iommu_dma_sync_single_for_device() expect a physically contiguous buffer (as
mapped by dma_map_single() or dma_map_page()) and only translate the starti=
ng
IOVA:

	phys =3D iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
	if (!dev_is_dma_coherent(dev)) {
		arch_sync_dma_for_cpu(phys, size, dir);
		arch_sync_dma_flush();
	}

On a non-coherent device with an IOMMU, calling dma_sync_single_for_device()
and dma_sync_single_for_cpu() across a coalesced sg_dma_len(sgl) range will
perform CPU cache maintenance on [phys, phys + len) starting from the first
page's physical address, leaving the subsequent pages of the GEM object
unsynced while flushing or invalidating unrelated physical memory adjacent
to the first page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-v3d-cached=
-maps-v1-0-0a6a6b363382@igalia.com?part=3D3
