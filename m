Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A366606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKXQn8Il
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35901129F4;
	Fri, 23 Oct 2026 07:40:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 796451129E3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:40:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84AC1600E2;
 Fri, 23 Oct 2026 07:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC11F01825;
 Fri, 23 Oct 2026 07:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792741249;
 bh=tIc6RvqAx4fgXR/KqgGUy24L4PCMZM/6Y5c91frl0po=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RKXQn8IlhM9I3gmgNHdY8J/J3OqTPcNzBeV2OqJxGNRK0KCR4YxaMHsd46XeUq2kd
 xM0lPS3hpDEqiA1yaEC+f4EcLNSIIerA9fgOHZAy/BUj2bkTqLAWpFdFZ6Ov71UBR3
 uapxp5xvF6IXoNO3Az1a4lM3CBZwl+6kXTbPWRQuHcT5E4AztLsN4fSUQw1yPGVkYc
 bfjuXab/Mznb84OIQLf+jUAoDmAyk1H5X0ESbaHfzf+IdUK1qsy7sWAGQeGOrGwxNH
 VkvpYlAp6/sjzRofjxq+97Av5t5v3bddqYXq32u8P57/5iOTDIpIirBGT+3frX7YPK
 Vme6s9UYrKgCA==
Message-ID: <sashiko-outbox-182428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/16] accel/thames: Add IOCTLs for BO creation and
 mapping
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-7-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-7-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:40:48 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] accel/thames: use-after-free of bo in thames_ioctl_bo_create()
- [High] accel/thames: missing TLB flush when thames_bo_bind() replaces L3 =
table
- [Low] accel/thames: Kconfig selects DRM_GEM_SHMEM_HELPER without MMU depe=
ndency
- [Low] accel/thames: missing MMU, IOMMU_SUPPORT, and 64BIT dependencies in=
 Kconfig
--

commit e7110c2d02687ac644a69317b2f94c6b4caee594
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel/thames: Add IOCTLs for BO creation and mapping

This commit adds the DRM_IOCTL_THAMES_BO_CREATE,
DRM_IOCTL_THAMES_BO_MMAP_OFFSET, and DRM_IOCTL_THAMES_BO_BIND ioctls to
create SHMEM or contiguous DMA buffer objects and map or unmap them in
the DSP page tables of each core.

> diff --git a/drivers/accel/thames/Kconfig b/drivers/accel/thames/Kconfig
> index 9362b92740751..47a2986fcabdc 100644
> --- a/drivers/accel/thames/Kconfig
> +++ b/drivers/accel/thames/Kconfig
> @@ -6,6 +6,8 @@ config DRM_ACCEL_THAMES
>  	depends on TI_K3_DSP_REMOTEPROC
>  	depends on REMOTEPROC
>  	depends on MAILBOX
> +	select DRM_GEM_DMA_HELPER
> +	select DRM_GEM_SHMEM_HELPER
>  	select IOMMU_IO_PGTABLE_LPAE

[Severity: Low]
Can selecting DRM_GEM_SHMEM_HELPER and IOMMU_IO_PGTABLE_LPAE without
inheriting their dependencies cause Kconfig unmet dependency warnings,
build failures, or 32-bit address truncation when COMPILE_TEST is enabled?

In drivers/remoteproc/Kconfig, TI_K3_DSP_REMOTEPROC has:

	config TI_K3_DSP_REMOTEPROC
		tristate "TI K3 DSP remoteproc support"
		depends on ARCH_K3 || COMPILE_TEST

However, DRM_GEM_SHMEM_HELPER in drivers/gpu/drm/Kconfig depends on MMU:

	config DRM_GEM_SHMEM_HELPER
		tristate
		depends on DRM && MMU

And IOMMU_IO_PGTABLE_LPAE in drivers/iommu/Kconfig is guarded by
if IOMMU_SUPPORT (which depends on MMU) and depends on !GENERIC_ATOMIC64,
with drivers/iommu/io-pgtable-arm.c also calling iommu_alloc_pages_node_sz()
and iommu_free_pages() from CONFIG_IOMMU_SUPPORT:

	if IOMMU_SUPPORT
	...
	config IOMMU_IO_PGTABLE_LPAE
		bool "ARMv7/v8 Long Descriptor Format"
		select IOMMU_IO_PGTABLE
		depends on ARM || ARM64 || COMPILE_TEST
		depends on !GENERIC_ATOMIC64	# for cmpxchg64()

In addition, thames_bo_bind() requires dsp_va >=3D THAMES_BIND_VA_START
(SZ_4G) and passes dsp_va through thames_context_map() ->
thames_pgtable_map() -> io_pgtable_ops->map_pages() and ->unmap_pages(),
where the iova parameter is unsigned long and would truncate 64-bit DSP
virtual addresses on 32-bit COMPILE_TEST builds.

Should DRM_ACCEL_THAMES depend on MMU, IOMMU_SUPPORT (or select it as
DRM_PANFROST and DRM_PANTHOR do), !GENERIC_ATOMIC64, and 64BIT?

[ ... ]

> diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/tha=
mes_gem.c
> index b98e0fe203b08..c9fd08c7aaf4d 100644
> --- a/drivers/accel/thames/thames_gem.c
> +++ b/drivers/accel/thames/thames_gem.c

[ ... ]

> +static int thames_bo_bind(struct thames_file_priv *priv, struct thames_g=
em_object *bo,
> +			  u64 dsp_va)
> +{
> +	size_t size =3D bo->base.base.size;
> +	int prot =3D thames_bo_flags_to_prot(bo->flags);
> +	struct thames_binding *binding;
> +	int ret;
> +
> +	if (!IS_ALIGNED(dsp_va, PAGE_SIZE))
> +		return -EINVAL;
> +
> +	if (dsp_va < THAMES_BIND_VA_START || dsp_va > THAMES_BIND_VA_END ||
> +	    size > THAMES_BIND_VA_END - dsp_va)
> +		return -EINVAL;
> +
> +	binding =3D kzalloc_obj(*binding);
> +	if (!binding)
> +		return -ENOMEM;
> +
> +	binding->bo =3D bo;
> +	binding->priv =3D priv;
> +	binding->mm.start =3D dsp_va;
> +	binding->mm.size =3D size;
> +
> +	ret =3D mutex_lock_interruptible(&priv->tdev->bindings_lock);
> +	if (ret)
> +		goto err_free;
> +
> +	if (thames_bo_find_binding(bo, priv)) {
> +		ret =3D -EBUSY;
> +		goto err_unlock;
> +	}
> +
> +	scoped_guard(mutex, &priv->mm_lock)
> +		ret =3D drm_mm_reserve_node(&priv->mm, &binding->mm);
> +	if (ret)
> +		goto err_unlock;
> +
> +	if (bo->flags & DRM_THAMES_BO_CONTIGUOUS)
> +		ret =3D thames_context_map(priv, dsp_va, prot, bo->base.dma_addr, size=
);
> +	else
> +		ret =3D thames_context_map_sgt(priv, dsp_va, prot, bo->shmem.sgt);
> +	if (ret) {
> +		scoped_guard(mutex, &priv->mm_lock)
> +			drm_mm_remove_node(&binding->mm);
> +		goto err_unlock;
> +	}
> +
> +	list_add_tail(&binding->bo_link, &bo->bindings);
> +	list_add_tail(&binding->context_link, &priv->bindings);
> +	mutex_unlock(&priv->tdev->bindings_lock);

[Severity: High]
Can thames_bo_bind() leave stale walk-cache entries on the DSP cores when a
2 MiB block mapping replaces an existing Level 3 page table?

In thames_context_pgtable_init(), the ARM_64_LPAE_S1 page tables are
allocated with cfg.tlb left as NULL:

	struct io_pgtable_cfg cfg =3D {
		.pgsize_bitmap =3D SZ_4K | SZ_2M,
		.ias =3D 48,
		.oas =3D 40,
		.coherent_walk =3D false,
		.iommu_dev =3D tdev->ddev.dev,
	};

Because cfg.tlb is NULL, io_pgtable_tlb_flush_walk() is a no-op and TLB
invalidation relies on thames_context_bump_generation(priv).

If a 4 KiB buffer is bound inside a 2 MiB region and later unbound via
thames_bo_unbind(), __arm_lpae_unmap() clears the Level 3 leaf PTE while
leaving the Level 2 ARM_LPAE_PTE_TYPE_TABLE descriptor in place. If a job
then runs on the DSP, the unbind's mapping_generation is consumed while the
Level 2 table descriptor remains valid and cacheable by the MMU walk cache.

When a 2 MiB buffer is subsequently bound at that 2 MiB-aligned dsp_va via
thames_bo_bind(), arm_lpae_init_pte() in drivers/iommu/io-pgtable-arm.c
unmaps and frees the old Level 3 page table page before installing the
block entry:

	} else if (iopte_type(ptep[i]) =3D=3D ARM_LPAE_PTE_TYPE_TABLE) {
		/*
		 * We need to unmap and free the old table before
		 * overwriting it with a block entry.
		 */
		arm_lpae_iopte *tblp;
		size_t sz =3D ARM_LPAE_BLOCK_SIZE(lvl, data);

		tblp =3D ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
		if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
				     lvl, tblp) !=3D sz) {
			WARN_ON(1);
			return -EINVAL;
		}
	}

Since neither cfg.tlb->tlb_flush_walk nor thames_bo_bind() calls
thames_context_bump_generation(priv), won't the DSP MMU walk cache retain
entries pointing to the freed Level 3 page table page?

[ ... ]

> +int thames_ioctl_bo_create(struct drm_device *ddev, void *data, struct d=
rm_file *file)
> +{
> +	struct drm_thames_bo_create *args =3D data;
> +	struct thames_gem_object *bo;
> +	struct drm_gem_dma_object *mem;
> +	int ret;
> +
> +	if (args->handle)
> +		return -EINVAL;
> +
> +	if (!args->size)
> +		return -EINVAL;
> +
> +	if (args->flags & ~(DRM_THAMES_BO_READ_ONLY | DRM_THAMES_BO_EXECUTABLE |
> +			    DRM_THAMES_BO_CONTIGUOUS))
> +		return -EINVAL;
> +
> +	if (args->flags & DRM_THAMES_BO_CONTIGUOUS) {
> +		mem =3D thames_gem_create(ddev, args->size);
> +		if (IS_ERR(mem))
> +			return PTR_ERR(mem);
> +		bo =3D to_thames_bo(&mem->base);
> +	} else {
> +		bo =3D thames_gem_create_shmem(ddev, args->size);
> +		if (IS_ERR(bo))
> +			return PTR_ERR(bo);
> +	}
> +
> +	bo->flags =3D args->flags;
> +
> +	ret =3D drm_gem_handle_create(file, &bo->base.base, &args->handle);
> +	drm_gem_object_put(&bo->base.base);
> +	if (ret) {
> +		dev_err(ddev->dev, "Failed to create gem handle: %d", ret);
> +		return ret;
> +	}
> +
> +	args->size =3D bo->base.base.size;

[Severity: Critical]
Does reading bo->base.base.size after drm_gem_object_put(&bo->base.base)
cause a use-after-free of bo?

Once drm_gem_handle_create() publishes the handle in file->object_idr and
drm_gem_object_put() drops the local reference, a concurrent thread sharing
the same drm_file can call DRM_IOCTL_GEM_CLOSE on the new handle and free
bo via thames_gem_bo_free() or thames_gem_shmem_bo_free() before
args->size =3D bo->base.base.size is reached.

Should args->size =3D bo->base.base.size be set before calling
drm_gem_handle_create() or before dropping the local reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D7
