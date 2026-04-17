Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583BCF4368D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78F8010EA1F;
	Fri, 17 Apr 2026 11:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DbwYQX8i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A4410EA18;
 Fri, 17 Apr 2026 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776424161; x=1807960161;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=//jBJU1xdXWYSAXW9KHdVJbcWPV4ILWVE1J7CFlCOck=;
 b=DbwYQX8iUgy/Kb4OIW496hyQB0c7BDojpaXJ73C9ZOvnxbXM9R1Ey8uX
 3TQwwTNsH98pZN7E0fDr+EHp8A/4FHFdf4P8S3Zs8TTSrngGxSQVT+2Y5
 aLzCUu6jbdHGRUHGv66+MfudIkAow1TspxonSBSkSp8OKoDjk5cEHHM1c
 lmwWLFBY+skUoTQeaT0UDZhjBT+Ur33UhpzIsTSizTTKdNlXUNSa7tgK/
 nMxFf+hh+CIMxi1KLWZlj/KfdG0iDkYNIpFB2ewcuuFbWaBof2bfY9Aum
 x3pMMW8EqYaKFr9duItYqpcqkaIClPRyoJlRsOtB/9BhMCdmLK4q+vR0T g==;
X-CSE-ConnectionGUID: AtEVHwXyRoSKiGbgxQj3NA==
X-CSE-MsgGUID: kVnE0FkNRlO9TMPSqgkBtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="102900194"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="102900194"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:09:21 -0700
X-CSE-ConnectionGUID: 8XACuQr3TlmiqOJSoiXd5w==
X-CSE-MsgGUID: 7RLpY6qZScmvXqoRMrr5Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="254230928"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.184])
 ([10.245.245.184])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 04:09:20 -0700
Message-ID: <53f2047397754b7b6ec03e77e7a3114ecc1a0fd5.camel@linux.intel.com>
Subject: Re: [PATCH v7 3/5] drm/pagemap: Split drm_pagemap_migrate_map_pages
 into device / system
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Francois Dugast <francois.dugast@intel.com>
Date: Fri, 17 Apr 2026 13:09:17 +0200
In-Reply-To: <20260410205929.3914474-4-matthew.brost@intel.com>
References: <20260410205929.3914474-1-matthew.brost@intel.com>
 <20260410205929.3914474-4-matthew.brost@intel.com>
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
> Split drm_pagemap_migrate_map_pages into device / system helpers
> clearly
> seperating these operations. Will help with upcoming changes to split
> IOVA allocation steps.
>=20
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/drm_pagemap.c | 151 ++++++++++++++++++++++---------=
-
> --
> =C2=A01 file changed, 100 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_pagemap.c
> b/drivers/gpu/drm/drm_pagemap.c
> index 63f32cf6e1a7..ee4d9f90bf67 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -216,7 +216,8 @@ static void drm_pagemap_get_devmem_page(struct
> page *page,
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * drm_pagemap_migrate_map_pages() - Map migration pages for GPU SVM
> migration
> + * drm_pagemap_migrate_map_device_private_pages() - Map device
> private migration
> + * pages for GPU SVM migration
> =C2=A0 * @dev: The device performing the migration.
> =C2=A0 * @local_dpagemap: The drm_pagemap local to the migrating device.
> =C2=A0 * @pagemap_addr: Array to store DMA information corresponding to
> mapped pages.
> @@ -232,58 +233,50 @@ static void drm_pagemap_get_devmem_page(struct
> page *page,
> =C2=A0 *
> =C2=A0 * Returns: 0 on success, -EFAULT if an error occurs during mapping=
.
> =C2=A0 */
> -static int drm_pagemap_migrate_map_pages(struct device *dev,
> -					 struct drm_pagemap
> *local_dpagemap,
> -					 struct drm_pagemap_addr
> *pagemap_addr,
> -					 unsigned long *migrate_pfn,
> -					 unsigned long npages,
> -					 enum dma_data_direction
> dir,
> -					 const struct
> drm_pagemap_migrate_details *mdetails)
> +static int
> +drm_pagemap_migrate_map_device_private_pages(struct device *dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap
> *local_dpagemap,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> *pagemap_addr,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long
> *migrate_pfn,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction
> dir,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> drm_pagemap_migrate_details *mdetails)
> =C2=A0{
> =C2=A0	unsigned long num_peer_pages =3D 0, num_local_pages =3D 0, i;
> =C2=A0
> =C2=A0	for (i =3D 0; i < npages;) {
> =C2=A0		struct page *page =3D
> migrate_pfn_to_page(migrate_pfn[i]);
> -		dma_addr_t dma_addr;
> +		struct drm_pagemap_zdd *zdd;
> +		struct drm_pagemap *dpagemap;
> +		struct drm_pagemap_addr addr;
> =C2=A0		struct folio *folio;
> =C2=A0		unsigned int order =3D 0;
> =C2=A0
> =C2=A0		if (!page)
> =C2=A0			goto next;
> =C2=A0
> +		WARN_ON_ONCE(!is_device_private_page(page));
> =C2=A0		folio =3D page_folio(page);
> =C2=A0		order =3D folio_order(folio);
> =C2=A0
> -		if (is_device_private_page(page)) {
> -			struct drm_pagemap_zdd *zdd =3D
> drm_pagemap_page_zone_device_data(page);
> -			struct drm_pagemap *dpagemap =3D zdd-
> >dpagemap;
> -			struct drm_pagemap_addr addr;
> -
> -			if (dpagemap =3D=3D local_dpagemap) {
> -				if (!mdetails-
> >can_migrate_same_pagemap)
> -					goto next;
> -
> -				num_local_pages +=3D NR_PAGES(order);
> -			} else {
> -				num_peer_pages +=3D NR_PAGES(order);
> -			}
> +		zdd =3D drm_pagemap_page_zone_device_data(page);
> +		dpagemap =3D zdd->dpagemap;
> =C2=A0
> -			addr =3D dpagemap->ops->device_map(dpagemap,
> dev, page, order, dir);
> -			if (dma_mapping_error(dev, addr.addr))
> -				return -EFAULT;
> +		if (dpagemap =3D=3D local_dpagemap) {
> +			if (!mdetails->can_migrate_same_pagemap)
> +				goto next;
> =C2=A0
> -			pagemap_addr[i] =3D addr;
> +			num_local_pages +=3D NR_PAGES(order);
> =C2=A0		} else {
> -			dma_addr =3D dma_map_page(dev, page, 0,
> page_size(page), dir);
> -			if (dma_mapping_error(dev, dma_addr))
> -				return -EFAULT;
> -
> -			pagemap_addr[i] =3D
> -				drm_pagemap_addr_encode(dma_addr,
> -
> 							DRM_INTERCONNECT_SYSTEM,
> -							order, dir);
> +			num_peer_pages +=3D NR_PAGES(order);
> =C2=A0		}
> =C2=A0
> +		addr =3D dpagemap->ops->device_map(dpagemap, dev,
> page, order, dir);
> +		if (dma_mapping_error(dev, addr.addr))
> +			return -EFAULT;
> +
> +		pagemap_addr[i] =3D addr;
> +
> =C2=A0next:
> =C2=A0		i +=3D NR_PAGES(order);
> =C2=A0	}
> @@ -298,6 +291,60 @@ static int drm_pagemap_migrate_map_pages(struct
> device *dev,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * drm_pagemap_migrate_map_system_pages() - Map system or device
> coherent
> + * migration pages for GPU SVM migration
> + * @dev: The device performing the migration.
> + * @pagemap_addr: Array to store DMA information corresponding to
> mapped pages.
> + * @migrate_pfn: Array of page frame numbers of system pages or peer
> pages to map.
> + * @npages: Number of system or device coherent pages to map.
> + * @dir: Direction of data transfer (e.g., DMA_BIDIRECTIONAL)
> + *
> + * This function maps pages of memory for migration usage in GPU
> SVM. It
> + * iterates over each page frame number provided in @migrate_pfn,
> maps the
> + * corresponding page, and stores the DMA address in the provided
> @dma_addr
> + * array.
> + *
> + * Returns: 0 on success, -EFAULT if an error occurs during mapping.
> + */
> +static int
> +drm_pagemap_migrate_map_system_pages(struct device *dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> *pagemap_addr,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long *migrate_pfn,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 enum dma_data_direction dir)
> +{
> +	unsigned long i;
> +
> +	for (i =3D 0; i < npages;) {
> +		struct page *page =3D
> migrate_pfn_to_page(migrate_pfn[i]);
> +		dma_addr_t dma_addr;
> +		struct folio *folio;
> +		unsigned int order =3D 0;
> +
> +		if (!page)
> +			goto next;
> +
> +		WARN_ON_ONCE(is_device_private_page(page));
> +		folio =3D page_folio(page);
> +		order =3D folio_order(folio);
> +
> +		dma_addr =3D dma_map_page(dev, page, 0,
> page_size(page), dir);
> +		if (dma_mapping_error(dev, dma_addr))
> +			return -EFAULT;
> +
> +		pagemap_addr[i] =3D
> +			drm_pagemap_addr_encode(dma_addr,
> +						DRM_INTERCONNECT_SYS
> TEM,
> +						order, dir);
> +
> +next:
> +		i +=3D NR_PAGES(order);
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0/**
> =C2=A0 * drm_pagemap_migrate_unmap_pages() - Unmap pages previously mappe=
d
> for GPU SVM migration
> =C2=A0 * @dev: The device for which the pages were mapped
> @@ -358,9 +405,13 @@ drm_pagemap_migrate_remote_to_local(struct
> drm_pagemap_devmem *devmem,
> =C2=A0				=C2=A0=C2=A0=C2=A0 const struct
> drm_pagemap_migrate_details *mdetails)
> =C2=A0
> =C2=A0{
> -	int err =3D drm_pagemap_migrate_map_pages(remote_device,
> remote_dpagemap,
> -						pagemap_addr,
> local_pfns,
> -						npages,
> DMA_FROM_DEVICE, mdetails);
> +	int err =3D
> drm_pagemap_migrate_map_device_private_pages(remote_device,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> remote_dpagemap,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> pagemap_addr,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> local_pfns,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> npages,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> DMA_FROM_DEVICE,
> +							=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> mdetails);
> =C2=A0
> =C2=A0	if (err)
> =C2=A0		goto out;
> @@ -379,12 +430,11 @@ drm_pagemap_migrate_sys_to_dev(struct
> drm_pagemap_devmem *devmem,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *local_pages[],
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_pagemap_addr
> pagemap_addr[],
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long npages,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_=
ops
> *ops,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> drm_pagemap_migrate_details *mdetails)
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_pagemap_devmem_=
ops
> *ops)
> =C2=A0{
> -	int err =3D drm_pagemap_migrate_map_pages(devmem->dev, devmem-
> >dpagemap,
> -						pagemap_addr,
> sys_pfns, npages,
> -						DMA_TO_DEVICE,
> mdetails);
> +	int err =3D drm_pagemap_migrate_map_system_pages(devmem->dev,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pagemap_addr,
> sys_pfns,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 npages,
> DMA_TO_DEVICE);
> =C2=A0
> =C2=A0	if (err)
> =C2=A0		goto out;
> @@ -448,7 +498,7 @@ static int drm_pagemap_migrate_range(struct
> drm_pagemap_devmem *devmem,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 &pages[last-
> >start],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> &pagemap_addr[last->start],
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 cur->start -
> last->start,
> -						=C2=A0=C2=A0=C2=A0=C2=A0 last->ops,
> mdetails);
> +						=C2=A0=C2=A0=C2=A0=C2=A0 last->ops);
> =C2=A0
> =C2=A0out:
> =C2=A0	*last =3D *cur;
> @@ -1010,7 +1060,6 @@ EXPORT_SYMBOL(drm_pagemap_put);
> =C2=A0int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem
> *devmem_allocation)
> =C2=A0{
> =C2=A0	const struct drm_pagemap_devmem_ops *ops =3D
> devmem_allocation->ops;
> -	struct drm_pagemap_migrate_details mdetails =3D {};
> =C2=A0	unsigned long npages, mpages =3D 0;
> =C2=A0	struct page **pages;
> =C2=A0	unsigned long *src, *dst;
> @@ -1049,10 +1098,10 @@ int drm_pagemap_evict_to_ram(struct
> drm_pagemap_devmem *devmem_allocation)
> =C2=A0	if (err || !mpages)
> =C2=A0		goto err_finalize;
> =C2=A0
> -	err =3D drm_pagemap_migrate_map_pages(devmem_allocation->dev,
> -					=C2=A0=C2=A0=C2=A0 devmem_allocation-
> >dpagemap, pagemap_addr,
> -					=C2=A0=C2=A0=C2=A0 dst, npages,
> DMA_FROM_DEVICE,
> -					=C2=A0=C2=A0=C2=A0 &mdetails);
> +	err =3D
> drm_pagemap_migrate_map_system_pages(devmem_allocation->dev,
> +						=C2=A0=C2=A0 pagemap_addr,
> +						=C2=A0=C2=A0 dst, npages,
> +						=C2=A0=C2=A0 DMA_FROM_DEVICE);
> =C2=A0	if (err)
> =C2=A0		goto err_finalize;
> =C2=A0
> @@ -1121,7 +1170,6 @@ static int __drm_pagemap_migrate_to_ram(struct
> vm_area_struct *vas,
> =C2=A0				=C2=A0 MIGRATE_VMA_SELECT_COMPOUND,
> =C2=A0		.fault_page	=3D page,
> =C2=A0	};
> -	struct drm_pagemap_migrate_details mdetails =3D {};
> =C2=A0	struct drm_pagemap_zdd *zdd;
> =C2=A0	const struct drm_pagemap_devmem_ops *ops;
> =C2=A0	struct device *dev =3D NULL;
> @@ -1179,8 +1227,9 @@ static int __drm_pagemap_migrate_to_ram(struct
> vm_area_struct *vas,
> =C2=A0	if (err)
> =C2=A0		goto err_finalize;
> =C2=A0
> -	err =3D drm_pagemap_migrate_map_pages(dev, zdd->dpagemap,
> pagemap_addr, migrate.dst, npages,
> -					=C2=A0=C2=A0=C2=A0 DMA_FROM_DEVICE,
> &mdetails);
> +	err =3D drm_pagemap_migrate_map_system_pages(dev,
> pagemap_addr,
> +						=C2=A0=C2=A0 migrate.dst,
> npages,
> +						=C2=A0=C2=A0 DMA_FROM_DEVICE);
> =C2=A0	if (err)
> =C2=A0		goto err_finalize;
> =C2=A0
