Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D4AC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D468610F4AB;
	Fri, 24 Jul 2026 22:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tn+SvPjX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C13D10F4AC
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:36:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9123C43CCB;
 Fri, 24 Jul 2026 22:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DCD1F000E9;
 Fri, 24 Jul 2026 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784932559;
 bh=6Uf6yt9ZfQjre7JcJiQYlzwXCWQlNBUC6JYUBXbxFSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tn+SvPjXhYF5ipaJvp6AC1v5m9RSIt326jmMoiofPWpCdCuthBYyDP3mbljlwHzY4
 hvVI14psb2E8chyycppHTnJXuzbb3C9VJJy3gYK7AF8ziPKXDKLnbaQK2o2lt0yI7p
 mL6Evw8wqeYp4A30K0PhXIr0KxpzP505WHf1tmUARJ5KgRqsyzDqh6srQam7UyCfTi
 vKkPPxkZqr0s9/kh/K+n48AfCcy6ak9BKCP2mRT9b+ipAwlgKzTtcZul2tNU96T1WI
 qwffUDibFf2tc/zeHUL5pBLlaRCAhsusKFDVWKfhXedDcYwYcHNHHh8LWTZ/q5eJ2z
 cRGJON/sRV71A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/etnaviv: honor read-only userptr flag in GPU MMU
 mapping
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724222124.537101-1-clusk@northecho.dev>
References: <20260514131401.2660079-1-clusk@northecho.dev>
 <20260724222124.537101-1-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 22:35:58 +0000
Message-Id: <20260724223559.49DCD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] MMUv1 hardware lacks read-only page protection, allowing unpri=
vileged users to overwrite arbitrary read-only CPU pages (e.g., `/etc/passw=
d`) via the GPU.
- [Critical] The MMUv1 linear window shortcut for single-entry BOs bypasses=
 page-table isolation, allowing unprivileged users to arbitrarily read and =
write physical memory.
- [High] Read-only userptr BOs are mapped using DMA_BIDIRECTIONAL, causing =
memory corruption when SWIOTLB bounce buffers are unmapped.
- [High] Calling drm_gem_object_put() on a partially initialized GEM object=
 triggers a kernel panic via list_del() on an uninitialized list node.
--

--- Patch [1]: [PATCH v2] drm/etnaviv: honor read-only userptr flag in GPU =
MMU mapping ---
commit 3b31d2a8b362305b34038576c89dbe65957eea85
Author: Christopher Lusk <clusk@northecho.dev>

drm/etnaviv: honor read-only userptr flag in GPU MMU mapping

The userptr interface records the requested access mode in
etnaviv_obj->userptr.ro, but etnaviv_iommu_map_gem() ignores it and maps
every buffer with ETNAVIV_PROT_READ | ETNAVIV_PROT_WRITE. This patch
builds the protection mask from userptr.ro instead, enforcing read-only
mappings on MMUv2 and confining the GPU to mapped pages on MMUv1.

Link: https://lore.kernel.org/all/20260508180518.1417371-1-n7l8m4@u.northwe=
stern.edu/

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
[ ... ]
> @@ -735,9 +735,20 @@ int etnaviv_gem_new_userptr(struct drm_device *dev, =
struct drm_file *file,
>  	uintptr_t ptr, u32 size, u32 flags, u32 *handle)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj;
> +	u32 bo_flags =3D ETNA_BO_CACHED;
>  	int ret;
> =20
> -	ret =3D etnaviv_gem_new_private(dev, size, ETNA_BO_CACHED,
> +	/*
> +	 * Keep read-only userptr BOs out of the MMUv1 linear window, which
> +	 * would expose far more than the pinned pages to the GPU.  MMUv1
> +	 * PTEs have no writeable bit, so this confines the GPU rather than
> +	 * making the BO read-only; MMUv2 enforces read-only per PTE in
> +	 * etnaviv_iommu_map_gem().
> +	 */
> +	if (!(flags & ETNA_USERPTR_WRITE))
> +		bo_flags |=3D ETNA_BO_FORCE_MMU;

[Severity: Critical]
This is a pre-existing issue, but does this explicitly leave read-only
userptr BOs writable by the GPU on MMUv1 hardware?

Since MMUv1 lacks read-only page protection and ignores the protection
argument, an unprivileged user could pin a read-only file via the userptr
ioctl and submit a GPU command stream to write to the mapped buffer.

Does this allow arbitrary modification of read-only files or the zero
page?

[Severity: Critical]
This is a pre-existing issue, but does the MMUv1 linear window shortcut
bypass page-table isolation for single-entry BOs?

While this patch forces ETNA_BO_FORCE_MMU for read-only userptrs, writable
userptrs or standard shmem BOs lacking this flag are given an IOVA directly
offset into a 2GB linear window in etnaviv_iommu_map_gem():

	if (context->global->version =3D=3D ETNAVIV_IOMMU_V1 &&
	    sgt->nents =3D=3D 1 && !(etnaviv_obj->flags & ETNA_BO_FORCE_MMU)) {
		u32 iova;

		iova =3D sg_dma_address(sgt->sgl) - memory_base;

Without bounds checking, could a malicious command stream access this offset
to read or write arbitrary physical pages in the contiguous memory area?

[ ... ]
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etna=
viv/etnaviv_mmu.c
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
[ ... ]
> @@ -269,10 +269,18 @@ int etnaviv_iommu_map_gem(struct etnaviv_iommu_cont=
ext *context,
>  {
>  	struct sg_table *sgt =3D etnaviv_obj->sgt;
>  	struct drm_mm_node *node;
> +	int prot =3D ETNAVIV_PROT_READ;
>  	int ret;
> =20
>  	lockdep_assert_held(&etnaviv_obj->lock);
> =20
> +	/*
> +	 * Read-only userptr BOs drop ETNAVIV_PROT_WRITE.  MMUv2 honors this
> +	 * via MMUv2_PTE_WRITEABLE; MMUv1 ignores prot entirely.
> +	 */
> +	if (!etnaviv_obj->userptr.mm || !etnaviv_obj->userptr.ro)
> +		prot |=3D ETNAVIV_PROT_WRITE;
> +

[Severity: Critical]
This is a pre-existing issue, but does dropping ETNAVIV_PROT_WRITE only
protect MMUv2?

In etnaviv_iommu_map_gem(), since MMUv1 ignores the protection flag entirel=
y,
the read-only userptr remains writable by the GPU. Could this overwrite
arbitrary read-only CPU pages?

[ ... ]
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
[ ... ]
>  if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
>  	dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);

[Severity: High]
This is a pre-existing issue, but does etnaviv_gem_scatter_map() hardcode
DMA_BIDIRECTIONAL for all cached BOs, including read-only userptrs?

If the system uses SWIOTLB bounce buffering, dma_unmap_sgtable() with
DMA_BIDIRECTIONAL in etnaviv_gem_scatterlist_unmap() will copy the
modified bounce buffer contents back over the original CPU pages.

For a userptr pinned without FOLL_WRITE, could this forcefully overwrite
read-only file mappings or the zero page?

[ ... ]
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/dr=
m/etnaviv/etnaviv_gem_prime.c
[ ... ]
>  fail:
>  	drm_gem_object_put(&etnaviv_obj->base);

[Severity: High]
This is a pre-existing issue, but can calling drm_gem_object_put() on a
partially initialized GEM object trigger a kernel panic?

In etnaviv_gem_prime_import_sg_table(), if object initialization fails,
the error path drops the refcount to 0 and calls etnaviv_gem_free_object():

	mutex_lock(&priv->gem_lock);
	list_del(&etnaviv_obj->gem_node);
	mutex_unlock(&priv->gem_lock);

Since etnaviv_gem_obj_add() was not yet called, the gem_node is
uninitialized. Will list_del() dereference NULL pointers and crash here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724222124.5371=
01-1-clusk@northecho.dev?part=3D1
