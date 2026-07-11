Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F3C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3110F10E2B4;
	Sat, 11 Jul 2026 03:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WjvGDNqD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FA510E2B4
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:10:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2B2660051;
 Sat, 11 Jul 2026 03:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BDE1F000E9;
 Sat, 11 Jul 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783739416;
 bh=9geI2oowRQdvHmPn/6KBMSfSrGGV6IVZ6I/aOFJmXns=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WjvGDNqD6YvUhjox/jAHnVH2EdFCQ829jvr/tiuiOlHirvwaLPPPAWnYpJZGABn4F
 ibV0f3cCXMpeV6D7BliMKkIetc8Zv1P1Qq7BtJw1OTr0IBZqI00Ex5aL0Xklz6cwhu
 0lfTpqtGLbBSA8S1wPXMV4IaMpiA6bv+me9QleudfdR7hgcbLIG5dZjCQNHL8GcM1O
 RYRf5t8GGBaWlXfE5dHcaFfaP48jUaSjOpUaB3/vE4atM7gIF7ltrJBx07twe2QRP5
 qlE7UtSZoJL9Nj1qkNMq7JtcSt1gwu9NaiEnXC7wLSBYv5X3TWEVKAlt13T/UKplgA
 4pjmnajB2mz0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting callback
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-12-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-12-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:10:15 +0000
Message-Id: <20260711031016.48BDE1F000E9@smtp.kernel.org>
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
- [High] Uninitialized memory read of `svm_pages->dma_addr[0].dir` passed t=
o `dma_iova_destroy()` on the error path.
- [High] System memory pages are erroneously unmapped using the device-spec=
ific unmap callback in mixed SVM ranges.
- [High] Device memory DMA mappings are leaked on the error path because `s=
vm_pages->dpagemap` is assigned too late.
--

--- Patch [11]: [PATCH v3 11/33] drm/gpusvm: Add a DMA-mapping accounting c=
allback ---
commit c12d7531ab5aab8f1172b95a5e7473303dec85e1
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

drm/gpusvm: Add a DMA-mapping accounting callback

The patch adds a dma_map_account callback to drm_gpusvm_ops to allow drivers
to symmetrically account for DMA-mapped pages during map and unmap operatio=
ns.

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
This isn't a bug introduced by this patch, but does the error path in
drm_gpusvm_get_pages() trigger an uninitialized memory read here?

If the first page's mapping fails (e.g., dma_iova_link() fails), the code
jumps to the err_unmap label with num_dma_mapped =3D 0. Because
dma_iova_try_alloc() succeeded, use_iova evaluates to true in
__drm_gpusvm_unmap_pages(). This unconditionally executes dma_iova_destroy()
just before this loop, reading svm_pages->dma_addr[0].dir by value:

    if (use_iova)
        dma_iova_destroy(dev, &svm_pages->state, svm_pages->state_offset,
                         svm_pages->dma_addr[0].dir, 0);

Since svm_pages->dma_addr was allocated using kvmalloc_objs without
zero-initialization, this passes an uninitialized enum dma_data_direction i=
nto
a kernel DMA API, which can trigger KMSAN panics or BUG_ON checks in DMA
debugging routines.

[Severity: High]
This is a pre-existing issue, but does this logic misroute system memory pa=
ges
to the device unmap callback?

When ctx->allow_mixed is true, an SVM range can contain both system and dev=
ice
pages. In this scenario, use_iova evaluates to true, and svm_pages->dpagemap
is initialized to the device's pagemap. During __drm_gpusvm_unmap_pages(), =
the
loop iterates over all pages. For a system page, addr->proto =3D=3D
DRM_INTERCONNECT_SYSTEM is true, but !use_iova evaluates to false.

This causes the execution to fall through to the else if condition without
validating the page type:

    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(dpagemap, dev, addr);

This incorrectly executes the device's unmap callback on a system memory pa=
ge
(containing an IOVA address), which seems likely to cause memory corruption=
 or
a crash.

[Severity: High]
This is also a pre-existing issue, but are device memory DMA mappings leaked
on the error path because svm_pages->dpagemap is assigned too late?

If an error occurs during drm_gpusvm_get_pages() after successfully mapping
one or more device private pages, the code jumps to the err_unmap cleanup
path. However, svm_pages->dpagemap is only updated at the very end of the
success path:

    if (pagemap) {
        flags.has_devmem_pages =3D true;
        drm_pagemap_get(dpagemap);
        drm_pagemap_put(svm_pages->dpagemap);
        svm_pages->dpagemap =3D dpagemap;
    }

Consequently, inside __drm_gpusvm_unmap_pages(), the local dpagemap variable
is NULL, causing the condition dpagemap && dpagemap->ops->device_unmap to
evaluate to false. The device unmap callback is skipped, leaking the device
memory mappings. The newly added dma_map_account callback will un-account
these leaked pages, causing internal accounting to irreversibly drift from =
the
hardware state.

> +			if (gpusvm->ops && gpusvm->ops->dma_map_account)
> +				gpusvm->ops->dma_map_account(gpusvm, addr, -1);
>  			i +=3D 1 << addr->order;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D11
