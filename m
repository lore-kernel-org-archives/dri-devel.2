Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BD1C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F1310E812;
	Tue, 28 Jul 2026 09:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WIjoG0nG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CAC10E812
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:15:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66E884044D;
 Tue, 28 Jul 2026 09:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0392E1F000E9;
 Tue, 28 Jul 2026 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785230148;
 bh=zzkr28eGki5OoDiKfX1NlwX1nfsKUU68oidiXADWT90=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WIjoG0nGSu45buwHZaPjeqiVQLmRdBCaXPI7VXHP4cs+YNVDkI60lmtXvdWlFIHtC
 /TYbUzzGdWaWfYvHpBeJY8Xf7uwPyihMXMbWEcFUC/3yy8eGt4nxyfB1iCX5TpWPqY
 kVmryx5Da9KWHYG9jkSK/AIeDYML2B1tKE+AhF4jJqBlB3MdnSzY9pnE5suYEuKG3L
 S2e/wkNXkEQXDrEnoWN43TbKWLp/6jLR3a+pfeoJFzKC+BBGl5ODzsI7tEX19YekdY
 sz/dDpLKoZzaPvBpimdorbmTjYebozawtoH15U30m4da6toTuxZG/Y0DR/g/OOA6hM
 YIEXaMq+hJeJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/pagemap: Reset migration page count on eviction retry
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728090304.1264759-1-arvind.yadav@intel.com>
References: <20260728090304.1264759-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 09:15:47 +0000
Message-Id: <20260728091548.0392E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA mappings are leaked in migration error paths because the desti=
nation page array is zeroed before unmapping.
- [High] DMA unmapping occurs after pages are exposed to the CPU, violating=
 cache coherency rules.
--

--- Patch [1]: [PATCH] drm/pagemap: Reset migration page count on eviction =
retry ---
commit f4a68acf50f418cad59d91b95424edfe21778ec5
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/pagemap: Reset migration page count on eviction retry

This commit updates drm_pagemap_evict_to_ram() to reset the mpages
counter to 0 at the retry label. This ensures that retried eviction
attempts do not incorrectly proceed using the page count from the
previous attempt.

> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 15c78eca180b7..695401cb2da24 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
[ ... ]
> @@ -1121,6 +1121,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_dev=
mem *devmem_allocation)
>  	npages =3D devmem_allocation->size >> PAGE_SHIFT;
> =20
>  retry:
> +	mpages =3D 0;
>  	if (!mmget_not_zero(devmem_allocation->mm))
>  		return -EFAULT;
> =20

Further down in drm_pagemap_evict_to_ram():

> err_finalize:
> 	if (err)
> 		drm_pagemap_migration_unlock_put_pages(npages, dst);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak
DMA mappings?

If an error occurs (such as a failure to copy to RAM),
drm_pagemap_migration_unlock_put_pages() is called, which zeroes the
destination page array entries in dst.

Subsequently, when drm_pagemap_migrate_unmap_pages() iterates over these
entries, it skips unmapping because the page evaluates to NULL:

drm_pagemap_migrate_unmap_pages() {
    ...
    struct page *page =3D migrate_pfn_to_page(migrate_pfn[i]);

    if (!page || !pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_ad=
dr[i].addr))
        goto next;
    ...
}

Could this cause the DMA addresses to remain permanently mapped in the IOMMU
or SWIOTLB?

> 	migrate_device_pages(src, dst, npages);
> 	migrate_device_finalize(src, dst, npages);
> 	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, ds=
t, npages,
> 					DMA_FROM_DEVICE, &state);

[Severity: High]
This is also a pre-existing issue, but is the ordering of CPU exposure and
DMA unmapping safe here?

migrate_device_finalize() is called before drm_pagemap_migrate_unmap_pages(=
).

The finalize function removes migration PTEs and restores normal CPU page
table entries, allowing userspace to immediately access the migrated pages.

However, the DMA API requires that dma_unmap_page() completes before the
CPU accesses the memory. Because dma_unmap_page() for DMA_FROM_DEVICE
mappings invalidates the CPU cache on non-coherent architectures, executing
it after the CPU has been granted access could destroy recent CPU writes or
cause the CPU to read stale speculative cache lines.

The identical unsafe ordering appears to be present in
__drm_pagemap_migrate_to_ram() where migrate_vma_finalize() is called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728090304.1264=
759-1-arvind.yadav@intel.com?part=3D1
