Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786B3C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FD910E141;
	Tue, 30 Jun 2026 03:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f3J+l7tZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872FE10E141
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 03:47:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B77860008;
 Tue, 30 Jun 2026 03:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288651F000E9;
 Tue, 30 Jun 2026 03:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782791272;
 bh=7EJSF/1YxnK/FBatXrhFLmEs/xbSNsZVwcIfRokkRjk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f3J+l7tZmoiSPLl42cHzabiXomY5/pzaR0ildH4ZYK6peKJI+bQltvbJFjNXD83n5
 NpEb085MLBMzdRwZiLrhsplP55+WNp7i8MbS4CSB6rfruioC0sQEK00Mnp3yOqdmhd
 8y6iZOFydF9Q263QKsAxNsPUjMdweISKqb3Z66iUv2VAKt+Urub3PqsgnGVLxWFzoV
 icVaoL/EoqGVGDHtvWmAaEbDPVhd4j4QFascZo1GvuToaMaP9LMyjnFpzwibmwZ9zD
 0u0JB0jUZzWwPSHbKIDzrK63bLsTuy5aW2/EMRuwSOOPvXBzUuxVIZ7YBTQIKZZyS3
 gsYqjfWx/Eyzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630033132.361144-3-honghuan@amd.com>
References: <20260629022921.17533-1-honghuan@amd.com>
 <20260630033132.361144-1-honghuan@amd.com>
 <20260630033132.361144-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 03:47:51 +0000
Message-Id: <20260630034752.288651F000E9@smtp.kernel.org>
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
- [High] Device memory DMA mappings are leaked if an error occurs during th=
e mapping loop in `drm_gpusvm_get_pages()`.
- [High] An uninitialized memory read occurs in `__drm_gpusvm_unmap_pages()=
` if IOVA allocation succeeds but linking fails on the very first page.
--

commit 4fe6a3e14e9c6c05c83b0d432b653dc56d06006d
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

Embeds the drm_device into drm_gpusvm_pages so that the pages object explic=
itly owns the drm handle. It routes DMA operations through svm_pages->drm i=
nstead of gpusvm->drm.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index abdfdaaf5e23c..604554e40f62d 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1532,10 +1541,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusv=
m,
>  			}
>  			svm_pages->dma_addr[j] =3D
>  				dpagemap->ops->device_map(dpagemap,
> -							  gpusvm->drm->dev,
> +							  svm_pages->drm->dev,
>  							  page, order,
>  							  dma_dir);
> -			if (dma_mapping_error(gpusvm->drm->dev,
> +			if (dma_mapping_error(svm_pages->drm->dev,
>  					      svm_pages->dma_addr[j].addr)) {
>  				err =3D -EFAULT;
>  				goto err_unmap;

[Severity: High]
This isn't a bug introduced by this patch, but does this leak device memory=
 DMA mappings if an error occurs here?

If dma_mapping_error() fails (or if a later operation fails and jumps to er=
r_unmap), __drm_gpusvm_unmap_pages() is called. However, svm_pages->dpagema=
p is not updated until the very end of drm_gpusvm_get_pages() on the succes=
s path.

Because svm_pages->dpagemap is still NULL in the error path, __drm_gpusvm_u=
nmap_pages() evaluates the condition else if (dpagemap && dpagemap->ops->de=
vice_unmap) as false and silently skips cleanup for all successfully mapped=
 device memory pages.

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
This is a pre-existing issue, but can this lead to an uninitialized memory =
read if linking fails on the very first page?

If dma_iova_try_alloc() succeeds but dma_iova_link() fails on the first ite=
ration (i =3D=3D 0), the code jumps to err_unmap with num_dma_mapped =3D 0 =
before initializing svm_pages->dma_addr[0].

The error path then calls __drm_gpusvm_unmap_pages(..., 0). Because use_iov=
a is true, it unconditionally evaluates svm_pages->dma_addr[0].dir to call =
dma_iova_destroy(), reading from the uninitialized memory of the dma_addr a=
rray (which was allocated via kvmalloc_objs without zeroing).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630033132.3611=
44-1-honghuan@amd.com?part=3D2
