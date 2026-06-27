Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBF2C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6759710F780;
	Sat, 27 Jun 2026 03:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Izx3QdCb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27F810F780
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:53:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1A87438CF;
 Sat, 27 Jun 2026 03:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852AE1F000E9;
 Sat, 27 Jun 2026 03:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532430;
 bh=Bq4PdiBfQgBdvKZYBmbrparHuBbDGt44P1l0ostQmeA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Izx3QdCbWOlGUYh5e9mHEZNWc55MFMvnTyCffZvXAlMuSx+VKFMofkvYHrnlxuE0P
 tlRoEyxC8lQPCPtDOc35c8FFcPHy5q7HNGanq7oy/rwiFJcARz3ha0zBpZiZDzjHML
 amm9T/mjsxRCsvFrYxzTCM+wZEg1RXb0+NGXkf2yinvxvsKmSqHMhUPTjI/NaKCyCO
 6af/CRCKPV4fXtKUNGzKq0sPn0uxXoBoJ9XnDqvXYzKQbJsQEj5cD8JG7nogNgydyP
 1wTfWLXpY0ySND92s7NXFgeWwHOWygbE2GvO2tVfqPaY1bs1/3sK59XvjKJnb2oNsA
 +iA1tI6SCYXjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627034303.3795627-3-honglei1.huang@amd.com>
References: <20260627034303.3795627-1-honglei1.huang@amd.com>
 <20260627034303.3795627-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:53:50 +0000
Message-Id: <20260627035350.852AE1F000E9@smtp.kernel.org>
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
- [High] Device page mappings leak in `drm_gpusvm_get_pages()` when an erro=
r occurs during mapping because `svm_pages->dpagemap` is not updated until =
after the mapping loop.
- [High] `dma_iova_destroy()` is called with an uninitialized direction arg=
ument if `dma_iova_link()` fails on the first iteration.
--

commit d0ee6a6661ec76713dcfa1129d5f568e328726f5
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

This commit embeds struct drm_device directly into drm_gpusvm_pages
to explicitly track the DRM device owning the DMA mappings. It routes
all DMA operations through svm_pages->drm and updates initialization
sites to set this handle.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index df900553f21a4..155e3c2e703d9 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_g=
pusvm *gpusvm,
>  				     unsigned long npages)
>  {
>  	struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;

[Severity: High]
This is a pre-existing issue, but does this leak device page mappings when
called from the error path in drm_gpusvm_get_pages()?

If a mapping operation spanning device memory pages fails partway through
(e.g., during dma_map_page or dma_iova_sync), __drm_gpusvm_unmap_pages()
is called to clean up. However, because svm_pages->dpagemap is not
updated until the very end of the success path in drm_gpusvm_get_pages(),
this reads a NULL (or stale) dpagemap.

Consequently, when we reach the unmap loop in this function:

	else if (dpagemap && dpagemap->ops->device_unmap)
		dpagemap->ops->device_unmap(dpagemap, dev, addr);

It will skip calling device_unmap() for successfully mapped device pages,
permanently leaking the hardware mappings.

[ ... ]

> @@ -1555,11 +1564,11 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusv=
m,
>  			}
> =20
>  			if (!i)
> -				dma_iova_try_alloc(gpusvm->drm->dev, state,
> +				dma_iova_try_alloc(svm_pages->drm->dev, state,
>  						   0, npages * PAGE_SIZE);
> =20
>  			if (dma_use_iova(state)) {
> -				err =3D dma_iova_link(gpusvm->drm->dev, state,
> +				err =3D dma_iova_link(svm_pages->drm->dev, state,
>  						    hmm_pfn_to_phys(pfns[i]),
>  						    svm_pages->state_offset,
>  						    PAGE_SIZE << order,

[Severity: High]
This isn't a bug introduced by this patch, but can this result in an
uninitialized memory read on error rollback?

If dma_iova_try_alloc() succeeds for the very first page (i =3D=3D 0), but
dma_iova_link() fails, it jumps to err_unmap with num_dma_mapped =3D 0.
The dma_addr array was allocated earlier in the function via kvmalloc_objs()
but dma_addr[0] is never initialized.

The rollback calls __drm_gpusvm_unmap_pages(..., npages =3D 0). Because
dma_use_iova() is true, it calls dma_iova_destroy():

	if (use_iova)
		dma_iova_destroy(dev, &svm_pages->state,
				 svm_pages->state_offset,
				 svm_pages->dma_addr[0].dir, 0);

This directly reads the uninitialized svm_pages->dma_addr[0].dir.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627034303.3795=
627-1-honglei1.huang@amd.com?part=3D2
