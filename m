Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64E606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APME4xXi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDA910F0F4;
	Thu, 19 Nov 2026 19:55:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3ED210F0F4
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD67961CCF;
 Thu, 19 Nov 2026 19:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A81F000CC;
 Thu, 19 Nov 2026 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795118121;
 bh=t7KOZUCixvGtBOSCO7Z86m/XNRQ3BGWxbSAXPhpzZ7U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=APME4xXiVka4vcq35CkjTeq5iJbwjhtt8TdscJwM/Gtu/p85BXV8gEdK+ZXtq2kZ/
 oCujeYJUnHOtB+wVuBnysJJTdFzOVldDiyFgLWGNXAu0wE2VhQYQR6a9pf3G7QVpK+
 EVNnesor7WJh0Vbkog3BwbBEk+Qw+WdCVmCbpicbmRBDRLqJ9aqhJXH3w/cZjLb+YP
 F5snHtXq6svYDj3DCte46xVPxxBRjXc3YMZV70nT7j7NtHzpxq9/THzS5Tt3s2hXc7
 VOyhV6siI5TNfUMWi7ZdYN68h/tDG+dcHGBbd2kNE7W6rlfzMwCNVj/8r+P3Oz2jEC
 6Co/H5/Rtv95w==
Message-ID: <sashiko-outbox-223986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] drm/shmem: Add a drm_gem_shmem_sync() helper
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261119-pan-drop-dma-buf-hooks-v1-1-6c6f1629e7f9@igalia.com>
References: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
 <20261119-pan-drop-dma-buf-hooks-v1-1-6c6f1629e7f9@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:55:20 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/shmem: unlocked sgt traversal in drm_gem_shmem_sync()
  causes UAF
- [Medium] drm/shmem: drm_gem_shmem_sync() populates pages on purged or
  unbacked BOs
--

commit 9fdf5667225c80a2c62b9b65dbf8c174b87f854f
Author: Faith Ekstrand <faith.ekstrand@collabora.com>

drm/shmem: Add a drm_gem_shmem_sync() helper

This commit adds a drm_gem_shmem_sync() helper to flush or invalidate CPU
caches for a range of a shmem GEM object by walking its scatter-gather table
and calling dma_sync_single_for_device() and dma_sync_single_for_cpu().

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index d654a22a30ded..72933ed283731 100644
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

[Severity: Medium]
Should drm_gem_shmem_sync() populate backing pages and a scatter-gather
table when shmem->pages is NULL or the object has been purged?

Calling drm_gem_shmem_get_pages_sgt() on an unbacked object allocates and
DMA-maps pages when there is no CPU-cached data to sync.  If the object was
already purged (shmem->madv < 0), drm_gem_shmem_get_pages_sgt() allocates a
new shmem->sgt and pages (or takes another reference on truncated pages
kept alive by an open VMA), and because drm_gem_shmem_is_purgeable()
requires shmem->madv > 0, the newly populated pages and sgt can never be
purged again until the GEM object is freed.

> +
> +	for_each_sgtable_dma_sg(sgt, sgl, count) {
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
[ ... ]
> +		dma_sync_single_for_device(dev->dev, paddr, len, DMA_TO_DEVICE);
> +		if (type =3D=3D DRM_GEM_SHMEM_SYNC_CPU_CACHE_FLUSH_AND_INVALIDATE)
> +			dma_sync_single_for_cpu(dev->dev, paddr, len, DMA_FROM_DEVICE);
> +	}

[Severity: High]
Can sgt be unmapped and freed while drm_gem_shmem_sync() is walking it?

drm_gem_shmem_get_pages_sgt() unlocks shmem->base.resv before returning
sgt, and does not increment shmem->pages_pin_count.  If the buffer is
marked purgeable (shmem->madv > 0, pages_pin_count =3D=3D 0), a concurrent
shrinker can purge it while the loop runs:

CPU0                                  CPU1
drm_gem_shmem_sync()
  drm_gem_shmem_get_pages_sgt()
    dma_resv_lock_interruptible(...)
    drm_gem_shmem_get_pages_sgt_locked()
    dma_resv_unlock(...)
                                      ...
                                        drm_gem_shmem_purge_locked()
                                          dma_unmap_sgtable(..., shmem->sgt=
, ...)
                                          sg_free_table(shmem->sgt)
                                          kfree(shmem->sgt)
  for_each_sgtable_dma_sg(sgt, ...)
    sg_dma_address(sgl)  <-- use-after-free

Holding shmem->base.resv across drm_gem_shmem_get_pages_sgt_locked() and
the scatterlist walk would prevent concurrent purging or sgt teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-pan-drop-d=
ma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com?part=3D1
