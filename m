Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1270CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 08:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1115D10ED5B;
	Thu, 18 Jun 2026 08:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aVWLJ5Yz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426CF10ED4A
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 08:22:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50BB76012A;
 Thu, 18 Jun 2026 08:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6151F000E9;
 Thu, 18 Jun 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781770955;
 bh=ho2WDnuW9FtnbRR+A6J4TSnTnbkKNTceeivztLex3pk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aVWLJ5YzC+e/BsYHQi+wMRupG0l6pwtYho9oGfTmuNH+5mcCHscQ/bw0bR1wE28Dw
 3ZgxyNJ+C9ZCokaYg3kkW4jBiSwPnCVKh9Z8d5DU6tMy5CINse2QRUYEnwzurOiWYA
 5OqpN1gxws3Um5fvdrK6SVgpX8QnN6//fJhe9vYxnjaaMVM/pxW+NnZ8J94esjVaS+
 xyp08S00WbhYOTrAS8ks4GEP1BcdUCmToKVxxDCx8xm05OjkdpA2LASjk1HH0EbCCp
 NT1zh2JJ1HquF0ENQOvhjeCtxRKmr327Yw3z0NRZmMAbFfdTSemq/B9vLGbhfcNbhz
 9lrxBWNgc2MjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618080902.1527255-3-honglei1.huang@amd.com>
References: <20260618080902.1527255-1-honglei1.huang@amd.com>
 <20260618080902.1527255-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:22:34 +0000
Message-Id: <20260618082234.DE6151F000E9@smtp.kernel.org>
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
- [High] Reading uninitialized memory `svm_pages->dma_addr[0].dir` in the e=
rror path of `__drm_gpusvm_unmap_pages()` when IOVA allocation fails.
- [High] System memory pages are incorrectly routed to `device_unmap()` dur=
ing unmap of mixed ranges when `use_iova` is true.
--

commit 755aa251270882d2dbbc0da1e00b00a5aafa5b38
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

Since now the drm_gpusvm_pages instance is inherently bound to one
specific drm_device, make that ownership explicit by giving
drm_gpusvm_pages its own drm_device handle, and drive all DMA through
it instead of through the gpusvm.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index df900553f21a4..155e3c2e703d9 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1135,11 +1136,16 @@ static void __drm_gpusvm_unmap_pages(struct drm_g=
pusvm *gpusvm,
>  				     unsigned long npages)
>  {
>  	struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;
> -	struct device *dev =3D gpusvm->drm->dev;
> +	struct device *dev;
>  	unsigned long i, j;
> =20
>  	lockdep_assert_held(&gpusvm->notifier_lock);
> =20
> +	if (!svm_pages->drm)
> +		return;
> +
> +	dev =3D svm_pages->drm->dev;
> +

[Severity: High]
This is a pre-existing issue, but does __drm_gpusvm_unmap_pages() incorrect=
ly
route system memory pages to device_unmap() when use_iova is true?

In a mixed range where ctx->allow_mixed is true, containing both system and
device pages, dpagemap is non-NULL. During unmap, the loop checks:

    if (!use_iova && addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM) {
        dma_unmap_page(...);
    } else if (dpagemap && dpagemap->ops->device_unmap) {
        dpagemap->ops->device_unmap(dpagemap, dev, addr, addr->dir);
    }

If use_iova is true, the first condition evaluates to false for system page=
s,
causing execution to fall through to the else if branch. This passes system
DMA addresses to the device-specific unmap callback, which could lead to
invalid memory accesses or state corruption.

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
This is a pre-existing issue, but does this error path read uninitialized
memory if dma_iova_link() fails on the first iteration where i =3D=3D 0?

Earlier in drm_gpusvm_get_pages(), svm_pages->dma_addr is allocated using
kvmalloc_objs() which does not zero-initialize the memory. If the link fails
on the first iteration, the code jumps to err_unmap before
svm_pages->dma_addr[0] is initialized.

The err_unmap path calls __drm_gpusvm_unmap_pages() with num_dma_mapped set
to 0. Because dma_use_iova() returns true, __drm_gpusvm_unmap_pages()
unconditionally calls dma_iova_destroy() and evaluates
svm_pages->dma_addr[0].dir to pass as the direction argument:

    if (use_iova)
        dma_iova_destroy(dev, &svm_pages->state, svm_pages->dma_addr[0].dir=
, 0);

This evaluates uninitialized memory, which will trigger KMSAN warnings and
pass a garbage DMA direction to the DMA subsystem.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618080902.1527=
255-1-honglei1.huang@amd.com?part=3D2
