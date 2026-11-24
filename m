Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AD606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Pdd1cFY/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72E410F0DF;
	Tue, 24 Nov 2026 21:57:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A50CE10F0DF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:57:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30715497
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:57:07 -0800 (PST)
Received: from [10.2.11.19] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 D67123F763
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795557430; bh=bpiX+NehYtjOn104gSrnkTT9oI27YzkEJxqY6Ww988k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pdd1cFY/wZnwOfeMrJfN2kGM9FPKDFXk+KBhfaHGrsKZi16j/GY9+a/J5O0RSoYQr
 asPacG1XpHgFAkcu9hotCQGyrEV0mklQ2qfguF6tTsZjgxkrXExNehL/v3vA5W/lZo
 1AUG/hpMXIwdLuozsjLjNRIIPyRngQz9NcPNWz68=
Date: Tue, 24 Nov 2026 21:56:51 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drm/shmem: Add a drm_gem_shmem_sync() helper
Message-ID: <awYII3tzMzv89tAV@e142607>
References: <20261122-pan-drop-dma-buf-hooks-v2-0-2ed42dce9db6@igalia.com>
 <20261122-pan-drop-dma-buf-hooks-v2-1-2ed42dce9db6@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261122-pan-drop-dma-buf-hooks-v2-1-2ed42dce9db6@igalia.com>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 22, 2026 at 07:14:49PM -0300, Maíra Canal wrote:
> From: Faith Ekstrand <faith.ekstrand@collabora.com>
> 
> This enables syncing mapped GEM objects between the CPU and GPU via calls
> to dma_sync_*().  It's a bit annoying as it requires walking the sg_table
> so it's best if every driver doesn't hand-roll it.
> 
> Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> [mcanal: rebased on top of drm-misc-next, fixed kernel-doc nits, added a
> resv lock across the sgt walk, and skip unbacked/purged BOs]
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 108 +++++++++++++++++++++++++++++++++
>  include/drm/drm_gem_shmem_helper.h     |  17 ++++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index d654a22a30de..cc3d04d2d58e 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -901,6 +901,114 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt);
>  
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
> +	const struct drm_device *dev = shmem->base.dev;
> +	struct sg_table *sgt;
> +	struct scatterlist *sgl;
> +	unsigned int count;
> +	int ret;
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
> +	if (size == 0)
> +		return 0;
> +
> +	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* No CPU mapping can exist without pages, and purged BOs have
> +	 * no content to be synced.
> +	 */
> +	if (!shmem->pages || shmem->madv < 0)
> +		goto out_unlock;
> +
> +	sgt = drm_gem_shmem_get_pages_sgt_locked(shmem);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto out_unlock;
> +	}
> +
> +	for_each_sgtable_dma_sg(sgt, sgl, count) {
> +		if (size == 0)
> +			break;
> +
> +		dma_addr_t paddr = sg_dma_address(sgl);
> +		size_t len = sg_dma_len(sgl);
> +
> +		if (len <= offset) {
> +			offset -= len;
> +			continue;
> +		}
> +
> +		paddr += offset;
> +		len -= offset;
> +		len = min_t(size_t, len, size);
> +		size -= len;
> +		offset = 0;
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
> +		if (type == DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE)
> +			dma_sync_single_for_cpu(dev->dev, paddr, len, DMA_FROM_DEVICE);
> +	}
> +
> +out_unlock:
> +	dma_resv_unlock(shmem->base.resv);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_sync);
> +
>  /**
>   * drm_gem_shmem_prime_import_sg_table - Produce a shmem GEM object from
>   *                 another driver's scatter/gather table of pinned pages
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index bcbb92f3fe9b..a5def70fae7a 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -122,6 +122,23 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
>  				 struct iosys_map *map);
>  int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct *vma);
>  
> +/**
> + * enum drm_gem_shmem_sync_type - Type of synchronization
> + */
> +enum drm_gem_shmem_sync_type {
> +	/** @DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH: Flush CPU caches */
> +	DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH = 0,
> +
> +	/**
> +	 * @DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE: Flush and
> +	 * invalidate CPU caches
> +	 */
> +	DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE,
> +};
> +
> +int drm_gem_shmem_sync(struct drm_gem_shmem_object *shmem, size_t offset,
> +		       size_t size, enum drm_gem_shmem_sync_type type);
> +
>  int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin_locked(struct drm_gem_shmem_object *shmem);
>  
> 
> -- 
> 2.56.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
