Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D0EF43691
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2C910EA22;
	Fri, 17 Apr 2026 11:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Nwg7X+ms";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649DE10EA18;
 Fri, 17 Apr 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776424293; x=1807960293;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=GJJ1eykbixJ4GcCvu3xsSBaHvL4LT+XEk9C0TMgv5+w=;
 b=Nwg7X+mseht8tru324Ct9HfoOwgZwXhPn/qYwmzXbVdbuuIexMp0WwN0
 5RbgF0Mq37lnmCPW8xNRvW3tDcIZ85ddD3B3N4FF836OKAgB9//XexJsw
 Cwk5u0TxT06R6W8F2tjLYepGk1CymSNHAaDyXuRr2Qb16nnxx9FvJj+qe
 UEkX6LUZ4qINrtvb8DgfI4jzlFSEgpDQzn5zNSr6kYoZow95YA2Eo/4lF
 nHQku7VJEVwyB7S8Bb0MZfRwzWRljW2JkGIQ2k8tREillC7v2Wkk9qx0p
 IJM5MaIjKPKhX8KuRiB1uUoNyOZbk5z7rhWYkE9QMBVhuMvTwH9JRAXqy w==;
X-CSE-ConnectionGUID: ZRedqMQQQeOycSQm/NIfyw==
X-CSE-MsgGUID: flW1eNN4Sv+8nPZ9yXRliQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77347477"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77347477"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:11:32 -0700
X-CSE-ConnectionGUID: E7rPphpjSmSHBrnsgmxj7g==
X-CSE-MsgGUID: rPUw0PmCTjuQy0dKjZ1hWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="235997273"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:11:30 -0700
Message-ID: <a2bb9c822ac3f635006ef6906f938a2626a628cc.camel@linux.intel.com>
Subject: Re: [PATCH v7 4/5] drm/pagemap: Use dma-map IOVA alloc, link, and
 sync API for DRM pagemap
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Francois Dugast <francois.dugast@intel.com>
Date: Fri, 17 Apr 2026 13:11:28 +0200
In-Reply-To: <20260410205929.3914474-5-matthew.brost@intel.com>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
 <20260410205929.3914474-5-matthew.brost@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, 2026-04-10 at 13:59 -0700, Matthew Brost wrote:
> The dma-map IOVA alloc, link, and sync APIs perform significantly
> better
> than dma-map / dma-unmap, as they avoid costly IOMMU
> synchronizations.
> This difference is especially noticeable when mapping a 2MB region in
> 4KB pages.
>=20
> Use the IOVA alloc, link, and sync APIs for DRM pagemap, which create
> DMA
> mappings between the CPU and GPU for copying data.
>=20
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>



> ---
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 85 ++++++++++++++++++++++++++++----=
-
> --
> =C2=A01 file changed, 70 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index ee4d9f90bf67..bd2037c77c92 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -291,6 +291,19 @@
> drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * struct drm_pagemap_iova_state - DRM pagemap IOVA state
> + * @dma_state: DMA IOVA state.
> + * @offset: Current offset in IOVA.
> + *
> + * This structure acts as an iterator for packing all IOVA addresses
> within a
> + * contiguous range.
> + */
> +struct drm_pagemap_iova_state {
> +	struct dma_iova_state dma_state;
> +	unsigned long offset;
> +};
> +
> =C2=A0/**
> =C2=A0 * drm_pagemap_migrate_map_system_pages() - Map system or device
> coherent
> =C2=A0 * migration pages for GPU SVM migration
> @@ -299,22 +312,25 @@
> drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> =C2=A0 * @migrate_pfn: Array of page frame numbers of system pages or pee=
r
> pages to map.
> =C2=A0 * @npages: Number of system or device coherent pages to map.
> =C2=A0 * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
> =C2=A0 *
> =C2=A0 * This function maps pages of memory for migration usage in GPU
> SVM. It
> =C2=A0 * iterates over each page frame number provided in @migrate_pfn,
> maps the
> =C2=A0 * corresponding page, and stores the DMA address in the provided
> @dma_addr
> =C2=A0 * array.
> =C2=A0 *
> - * Returns: 0 on success, -EFAULT if an error occurs during mapping.
> + * Returns: 0 on success, negative error code on failure.
> =C2=A0 */
> =C2=A0static int
> =C2=A0drm_pagemap_migrate_map_system_pages(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> *pagemap_addr,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long *migrate_pfn,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction dir)
> +				=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction dir,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_iova_state
> *state)
> =C2=A0{
> =C2=A0	unsigned long i;
> +	bool try_alloc =3D false;
> =C2=A0
> =C2=A0	for (i =3D 0; i < npages;) {
> =C2=A0		struct page *page =3D
> migrate_pfn_to_page(migrate_pfn[i]);
> @@ -329,9 +345,31 @@ drm_pagemap_migrate_map_system_pages(struct
> device *dev,
> =C2=A0		folio =3D page_folio(page);
> =C2=A0		order =3D folio_order(folio);
> =C2=A0
> -		dma_addr =3D dma_map_page(dev, page, 0,
> page_size(page), dir);
> -		if (dma_mapping_error(dev, dma_addr))
> -			return -EFAULT;
> +		if (!try_alloc) {
> +			dma_iova_try_alloc(dev, &state->dma_state,
> +					=C2=A0=C2=A0 (npages - i) * PAGE_SIZE
> >=3D
> +					=C2=A0=C2=A0 HPAGE_PMD_SIZE ?
> +					=C2=A0=C2=A0 HPAGE_PMD_SIZE : 0,
> +					=C2=A0=C2=A0 npages * PAGE_SIZE);
> +			try_alloc =3D true;
> +		}
> +
> +		if (dma_use_iova(&state->dma_state)) {
> +			int err =3D dma_iova_link(dev, &state-
> >dma_state,
> +						page_to_phys(page),
> +						state->offset,
> page_size(page),
> +						dir, 0);
> +			if (err)
> +				return err;
> +
> +			dma_addr =3D state->dma_state.addr + state-
> >offset;
> +			state->offset +=3D page_size(page);
> +		} else {
> +			dma_addr =3D dma_map_page(dev, page, 0,
> page_size(page),
> +						dir);
> +			if (dma_mapping_error(dev, dma_addr))
> +				return -EFAULT;
> +		}
> =C2=A0
> =C2=A0		pagemap_addr[i] =3D
> =C2=A0			drm_pagemap_addr_encode(dma_addr,
> @@ -342,6 +380,9 @@ drm_pagemap_migrate_map_system_pages(struct
> device *dev,
> =C2=A0		i +=3D NR_PAGES(order);
> =C2=A0	}
> =C2=A0
> +	if (dma_use_iova(&state->dma_state))
> +		return dma_iova_sync(dev, &state->dma_state, 0,
> state->offset);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -353,6 +394,7 @@ drm_pagemap_migrate_map_system_pages(struct
> device *dev,
> =C2=A0 * @pagemap_addr: Array of DMA information corresponding to mapped
> pages
> =C2=A0 * @npages: Number of pages to unmap
> =C2=A0 * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + * @state: DMA IOVA state for mapping.
> =C2=A0 *
> =C2=A0 * This function unmaps previously mapped pages of memory for GPU
> Shared Virtual
> =C2=A0 * Memory (SVM). It iterates over each DMA address provided in
> @dma_addr, checks
> @@ -362,10 +404,16 @@ static void
> drm_pagemap_migrate_unmap_pages(struct device *dev,
> =C2=A0					=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> *pagemap_addr,
> =C2=A0					=C2=A0=C2=A0=C2=A0 unsigned long
> *migrate_pfn,
> =C2=A0					=C2=A0=C2=A0=C2=A0 unsigned long npages,
> -					=C2=A0=C2=A0=C2=A0 enum dma_data_direction
> dir)
> +					=C2=A0=C2=A0=C2=A0 enum dma_data_direction
> dir,
> +					=C2=A0=C2=A0=C2=A0 struct
> drm_pagemap_iova_state *state)
> =C2=A0{
> =C2=A0	unsigned long i;
> =C2=A0
> +	if (state && dma_use_iova(&state->dma_state)) {
> +		dma_iova_destroy(dev, &state->dma_state, state-
> >offset, dir, 0);
> +		return;
> +	}
> +
> =C2=A0	for (i =3D 0; i < npages;) {
> =C2=A0		struct page *page =3D
> migrate_pfn_to_page(migrate_pfn[i]);
> =C2=A0
> @@ -420,7 +468,7 @@ drm_pagemap_migrate_remote_to_local(struct
> drm_pagemap_devmem *devmem,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devmem->pre_migrate_fence);
> =C2=A0out:
> =C2=A0	drm_pagemap_migrate_unmap_pages(remote_device, pagemap_addr,
> local_pfns,
> -					npages, DMA_FROM_DEVICE);
> +					npages, DMA_FROM_DEVICE,
> NULL);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -430,11 +478,13 @@ drm_pagemap_migrate_sys_to_dev(struct
> drm_pagemap_devmem *devmem,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *local_pages[],
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> pagemap_addr[],
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_=
ops
> *ops)
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_=
ops
> *ops,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_iova_state *s=
tate)
> =C2=A0{
> =C2=A0	int err =3D drm_pagemap_migrate_map_system_pages(devmem->dev,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pagemap_addr,
> sys_pfns,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 npages,
> DMA_TO_DEVICE);
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 npages,
> DMA_TO_DEVICE,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state);
> =C2=A0
> =C2=A0	if (err)
> =C2=A0		goto out;
> @@ -443,7 +493,7 @@ drm_pagemap_migrate_sys_to_dev(struct
> drm_pagemap_devmem *devmem,
> =C2=A0				=C2=A0 devmem->pre_migrate_fence);
> =C2=A0out:
> =C2=A0	drm_pagemap_migrate_unmap_pages(devmem->dev, pagemap_addr,
> sys_pfns, npages,
> -					DMA_TO_DEVICE);
> +					DMA_TO_DEVICE, state);
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> @@ -471,6 +521,7 @@ static int drm_pagemap_migrate_range(struct
> drm_pagemap_devmem *devmem,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 const struct migrate_range_loc
> *cur,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> drm_pagemap_migrate_details *mdetails)
> =C2=A0{
> +	struct drm_pagemap_iova_state state =3D {};
> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	if (cur->start =3D=3D 0)
> @@ -498,7 +549,7 @@ static int drm_pagemap_migrate_range(struct
> drm_pagemap_devmem *devmem,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 &pages[last-
> >start],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> &pagemap_addr[last->start],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 cur->start -
> last->start,
> -						=C2=A0=C2=A0=C2=A0=C2=A0 last->ops);
> +						=C2=A0=C2=A0=C2=A0=C2=A0 last->ops,
> &state);
> =C2=A0
> =C2=A0out:
> =C2=A0	*last =3D *cur;
> @@ -1060,6 +1111,7 @@ EXPORT_SYMBOL(drm_pagemap_put);
> =C2=A0int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem
> *devmem_allocation)
> =C2=A0{
> =C2=A0	const struct drm_pagemap_devmem_ops *ops =3D
> devmem_allocation->ops;
> +	struct drm_pagemap_iova_state state =3D {};
> =C2=A0	unsigned long npages, mpages =3D 0;
> =C2=A0	struct page **pages;
> =C2=A0	unsigned long *src, *dst;
> @@ -1101,7 +1153,7 @@ int drm_pagemap_evict_to_ram(struct
> drm_pagemap_devmem *devmem_allocation)
> =C2=A0	err =3D
> drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
> =C2=A0						=C2=A0=C2=A0 pagemap_addr,
> =C2=A0						=C2=A0=C2=A0 dst, npages,
> -						=C2=A0=C2=A0 DMA_FROM_DEVICE);
> +						=C2=A0=C2=A0 DMA_FROM_DEVICE,
> &state);
> =C2=A0	if (err)
> =C2=A0		goto err_finalize;
> =C2=A0
> @@ -1125,7 +1177,7 @@ int drm_pagemap_evict_to_ram(struct
> drm_pagemap_devmem *devmem_allocation)
> =C2=A0	migrate_device_pages(src, dst, npages);
> =C2=A0	migrate_device_finalize(src, dst, npages);
> =C2=A0	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev,
> pagemap_addr, dst, npages,
> -					DMA_FROM_DEVICE);
> +					DMA_FROM_DEVICE, &state);
> =C2=A0
> =C2=A0err_free:
> =C2=A0	kvfree(buf);
> @@ -1137,6 +1189,7 @@ int drm_pagemap_evict_to_ram(struct
> drm_pagemap_devmem *devmem_allocation)
> =C2=A0
> =C2=A0	if (retry_count--) {
> =C2=A0		cond_resched();
> +		state =3D (struct drm_pagemap_iova_state){};
> =C2=A0		goto retry;
> =C2=A0	}
> =C2=A0
> @@ -1170,6 +1223,7 @@ static int __drm_pagemap_migrate_to_ram(struct
> vm_area_struct *vas,
> =C2=A0				=C2=A0 MIGRATE_VMA_SELECT_COMPOUND,
> =C2=A0		.fault_page	=3D page,
> =C2=A0	};
> +	struct drm_pagemap_iova_state state =3D {};
> =C2=A0	struct drm_pagemap_zdd *zdd;
> =C2=A0	const struct drm_pagemap_devmem_ops *ops;
> =C2=A0	struct device *dev =3D NULL;
> @@ -1229,7 +1283,7 @@ static int __drm_pagemap_migrate_to_ram(struct
> vm_area_struct *vas,
> =C2=A0
> =C2=A0	err =3D drm_pagemap_migrate_map_system_pages(dev,
> pagemap_addr,
> =C2=A0						=C2=A0=C2=A0 migrate.dst,
> npages,
> -						=C2=A0=C2=A0 DMA_FROM_DEVICE);
> +						=C2=A0=C2=A0 DMA_FROM_DEVICE,
> &state);
> =C2=A0	if (err)
> =C2=A0		goto err_finalize;
> =C2=A0
> @@ -1254,7 +1308,8 @@ static int __drm_pagemap_migrate_to_ram(struct
> vm_area_struct *vas,
> =C2=A0	migrate_vma_finalize(&migrate);
> =C2=A0	if (dev)
> =C2=A0		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr,
> migrate.dst,
> -						npages,
> DMA_FROM_DEVICE);
> +						npages,
> DMA_FROM_DEVICE,
> +						&state);
> =C2=A0err_free:
> =C2=A0	kvfree(buf);
> =C2=A0err_out:
