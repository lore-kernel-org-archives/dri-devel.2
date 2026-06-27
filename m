Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FB4C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDED010E445;
	Sat, 27 Jun 2026 04:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JrLKtsRf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB29610E445
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:02:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38267600AA;
 Sat, 27 Jun 2026 04:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19251F000E9;
 Sat, 27 Jun 2026 04:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532967;
 bh=/aSUjdI6rVi85MVhaiEYqSYBezgCG6sfkC3bObGip5g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrLKtsRfEhGYbNXTfzvjI3EP6/NKwxYwqL9iJ0QbQcFKL1SUAPwNB4QB3Mfj602E1
 PpmI/3ILevCpGqaLKJGULjc6FvRjDEc9h3zAzdCdUSsGMKX/mRklgy5MoAXUEszdNy
 yRxZb+iM4u5aUjGcNIdTYhVTbRmbLmJUcKDnom/d3tA0ezfVqkxdt+hmYRWmU89l0j
 4sJhUJLE6TvEw5+b8c4WtB1HAl4/o+dndzhP1WpRkyY2bLLOeAKgksesFr7mc7mBZG
 FtgsRf6+2RUCaAMD+q8xrhhwzr2+3B9aOX0ET8mHnP7yZr96Yu5WCWhZ4SbLFNL5HC
 1P2mnxXYJ6+/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/gpusvm: do not route system pages to
 device_unmap() on IOVA unmap
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627033325.3795298-3-honglei1.huang@amd.com>
References: <20260627033325.3795298-1-honglei1.huang@amd.com>
 <20260627033325.3795298-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:02:47 +0000
Message-Id: <20260627040247.B19251F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IOVA address space is permanently leaked when unmapping mixed rang=
es because `dma_iova_try_alloc` allocates for the entire range but `dma_iov=
a_destroy` only frees the linked portion.
--

commit 00ffc2a555c26b1b1afa96a3e7aabeee992b2163
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: do not route system pages to device_unmap() on IOVA unmap

This commit fixes an issue in mixed ranges where system pages were incorrec=
tly
routed to device_unmap() during IOVA unmap by checking the page protocol.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 2d74e2aae0a77..80b9a3f4cb919 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1161,12 +1161,17 @@ static void __drm_gpusvm_unmap_pages(struct drm_g=
pusvm *gpusvm,
>  		for (i =3D 0, j =3D 0; i < npages; j++) {
>  			struct drm_pagemap_addr *addr =3D &svm_pages->dma_addr[j];
> =20
> -			if (!use_iova && addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM)
> -				dma_unmap_page(dev,
> -					       addr->addr,
> -					       PAGE_SIZE << addr->order,
> -					       addr->dir);
> -			else if (dpagemap && dpagemap->ops->device_unmap)
> +			if (addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM) {
> +				/*
> +				 * IOVA pages are cleaned by the ma_iova_destroy() above.

[Severity: High]
This isn't a bug introduced by this patch, but looking at how IOVA pages are
cleaned up here, does this leak IOVA address space for mixed ranges?

In drm_gpusvm_get_pages(), dma_iova_try_alloc() allocates IOVA space for the
entire range size:

    dma_iova_try_alloc(gpusvm->drm->dev, state, 0, npages * PAGE_SIZE);

However, when this range is unmapped in __drm_gpusvm_unmap_pages(),
dma_iova_destroy() is called with svm_pages->state_offset as the length:

    dma_iova_destroy(dev, &svm_pages->state,
                     svm_pages->state_offset,
                     npages ? svm_pages->dma_addr[0].dir :
                              DMA_BIDIRECTIONAL, 0);

If a user-space application allocates a range and migrates part of it to
device memory (creating a mixed range), state_offset will only be the sum
of the linked system page sizes.

Since dma_iova_destroy() only frees exactly the requested length, it seems
the unlinked portion of the original IOVA allocation is permanently leaked,
which could eventually exhaust the IOVA space.

> +				 */
> +				if (!use_iova)
> +					dma_unmap_page(dev,
> +						       addr->addr,
> +						       PAGE_SIZE << addr->order,
> +						       addr->dir);
> +			} else if (dpagemap && dpagemap->ops->device_unmap)
>  				dpagemap->ops->device_unmap(dpagemap,
>  							    dev, addr);
>  			i +=3D 1 << addr->order;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627033325.3795=
298-1-honglei1.huang@amd.com?part=3D2
