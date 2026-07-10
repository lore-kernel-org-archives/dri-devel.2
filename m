Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C952FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466C10E25F;
	Fri, 10 Jul 2026 22:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z/Z0f5d+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753E410E25F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:10:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E67CC60051;
 Fri, 10 Jul 2026 22:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1341F000E9;
 Fri, 10 Jul 2026 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721438;
 bh=o5jzU6v6Gpc2S1GCyr1+7gYiKIp+GopzRcaHmLzMUM4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z/Z0f5d+67SQw8njERPltHUs/E9ebuG2q2xpmAoJnNjZJGpxFuArfAfKz156HG8n7
 GJ7aa1gRuZp/LM61dy9pO2Qc6nyAlDbskEkXGuoJxZhYgN7bh2YuZp/xDsa9yYRdpN
 tOSzbg1FJa7eUg2GKBkQ4XwyigYujOVEmDLdg3MH5qZRNzEKxei+2fFIfUUza0ymIC
 zNBbY0ZZrUawdD9vXxTPeKXwuuzhrR3/7LmvSbDKvu4nTq815euPcmWb+jN1piigr0
 h8O9OTv3eEfAmRdmyuErF4k55RddJVZ6wicU4Um6Vt/ESaCEgAxdeeRGBV8E75G2pk
 RzB6WAicQns3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-12-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-12-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:10:38 +0000
Message-Id: <20260710221038.7D1341F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device memory mappings are leaked on the error path because `dpage=
map` is not yet stored in `svm_pages`.
- [High] Reading uninitialized memory (`svm_pages->dma_addr[0].dir`) when u=
nwinding an IOVA allocation failure.
- [High] System pages are incorrectly routed to `device_unmap` during unmap=
ping of mixed ranges when IOVA is used.
--

--- Patch [11]: [PATCH v2 11/33] drm/gpusvm: Add a DMA-mapping accounting c=
allback ---
commit 98db73f178129cc5ccc6277eaada197044dfbd3b
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/gpusvm: Add a DMA-mapping accounting callback

This commit adds an optional @dma_map_account callback to struct
drm_gpusvm_ops to track mapped pages. It is invoked during mapping and
unmapping to keep symmetric accounting. It also relaxes drm_gpusvm_init() to
allow restricted ops without full-SVM mode.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index fcfe635bc1956..512f52471419e 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1246,6 +1253,8 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpu=
svm *gpusvm,
>  			else if (dpagemap && dpagemap->ops->device_unmap)
>  				dpagemap->ops->device_unmap(dpagemap,
>  							    dev, addr);

[Severity: High]
This isn't a bug introduced by this patch, but can this leak device memory
mappings on the error path?

In drm_gpusvm_get_pages(), if an error occurs after successfully mapping
one or more device pages, the code jumps to err_unmap and calls
__drm_gpusvm_unmap_pages().

However, svm_pages->dpagemap is purposefully only updated after the mapping
loop completes successfully. During the early error unwind, it remains NULL.

Because of this, in __drm_gpusvm_unmap_pages():

    struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;

The dpagemap evaluated here will be NULL, causing this else if condition to
fail and completely bypassing the unmap callback for all successfully mapped
device pages in that chunk.

[Severity: High]
This is also a pre-existing issue, but could this incorrectly unmap system
pages as device pages in a mixed chunk?

In drm_gpusvm_get_pages(), if a chunk has a mix of device and system pages
(ctx->allow_mixed is true) and IOVA is used:

When iterating over the pages in __drm_gpusvm_unmap_pages(), system pages w=
ill
have addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM. However, if use_iova is tr=
ue, the
previous condition:

    if (!use_iova && addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM)
        dma_unmap_page(...)

will evaluate to false.

Execution then falls through to this else if branch. If a previous device p=
age
set dpagemap, it will inappropriately call dpagemap->ops->device_unmap() on=
 the
system page.

> +			if (gpusvm->ops && gpusvm->ops->dma_map_account)
> +				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
>  			i +=3D 1 << addr->order;
>  		}
> =20

[ ... ]

> @@ -1654,6 +1663,10 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  				(addr, DRM_INTERCONNECT_SYSTEM, order,
>  				 dma_dir);
>  		}
> +		if (gpusvm->ops && gpusvm->ops->dma_map_account)
> +			gpusvm->ops->dma_map_account(gpusvm,
> +						     &svm_pages->dma_addr[j],
> +						     1);

[Severity: High]
This is a pre-existing issue, but is it possible to read uninitialized memo=
ry
here if the first page mapping fails?

In drm_gpusvm_get_pages(), svm_pages->dma_addr is allocated via
kvmalloc_objs() without zero-initialization.

If an error occurs on the very first page (i =3D 0), such as an IOVA alloca=
tion
failure, the code jumps to err_unmap with num_dma_mapped =3D 0, and
__drm_gpusvm_unmap_pages() is called with npages =3D 0.

Inside __drm_gpusvm_unmap_pages(), if dma_use_iova(&svm_pages->state) is tr=
ue,
it will unconditionally call:

    dma_iova_destroy(dev, &svm_pages->state,
             svm_pages->state_offset,
             svm_pages->dma_addr[0].dir, 0);

Since npages =3D 0, svm_pages->dma_addr[0] was never initialized, leading to
svm_pages->dma_addr[0].dir being read from uninitialized heap memory.

>  		i +=3D 1 << order;
>  		num_dma_mapped =3D i;
>  		flags.has_dma_mapping =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D11
