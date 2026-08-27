Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D786C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1C310EECD;
	Thu, 27 Aug 2026 07:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ANCAH1aS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D633D10EEC5;
 Thu, 27 Aug 2026 07:29:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFE9E403AC;
 Thu, 27 Aug 2026 07:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6301F000E9;
 Thu, 27 Aug 2026 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787815786;
 bh=VvHaZIVB2YqtsyptQJZpt4TN1NiNBcUQ/OxjPtrfOPs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ANCAH1aS7usJGe9aH+kf7OJMt20kG8JJvP0JOCBWJ5Oz9nTT+wfHjjqYYDPc47tdd
 P3N7723jHFFKRBqZv1U897h83E1/aWfMFNp8Ubykjb5AIcki91lwYue+ozKILl4Qx4
 P2L8Q8L4Hk5ks27dQdBv73KJSHJ8myKObp/zM6Cy6skZ1qDMwK4x5FMrnTsPixPVkM
 +z2eQFX9CNY4UilruJf6L9xnWrzHQ5TlH03qJ6z9oi+wcXU9zxQqg+gSnFIVT/PfHI
 R1kIo2QNZNc26/I/LP0wfVYuoxpR6QwAyD8CQMEfwKUd4W2ORGOs2s+XudLdUh9Ciw
 wg5zgX6MCCBlw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/5] drm/gpusvm: move dma_addr allocation before
 the notifier lock
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827071449.520398-3-honghuan@amd.com>
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-3-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:29:46 +0000
Message-Id: <20260827072946.6D6301F000E9@smtp.kernel.org>
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
- [High] Device mappings are permanently leaked on the error path because `=
svm_pages->dpagemap` is assigned too late.
--

commit 69970ff2a9a2262bbdbdbce9ebee1a8d4c896b22
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: move dma_addr allocation before the notifier lock

The dma_addr allocation was in a lazy allocation flow, it needs unlock
and goto map_pages. The allocation only needs npages, so just do it
before taking the lock. Drop the map_pages label and the relock flow, so
the sequence becomes fault, allocate, then lock, validate, map and
unlock. No functional change intended.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 507ef6f0a60e7..3496cb5688365 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1575,18 +1583,6 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  		goto retry;
>  	}
> =20
> -	if (!svm_pages->dma_addr) {
> -		/* Unlock and restart mapping to allocate memory. */
> -		drm_gpusvm_notifier_unlock(gpusvm);
> -		svm_pages->dma_addr =3D
> -			kvmalloc_objs(*svm_pages->dma_addr, npages);
> -		if (!svm_pages->dma_addr) {
> -			err =3D -ENOMEM;
> -			goto err_free;
> -		}
> -		goto map_pages;
> -	}
> -
>  	zdd =3D NULL;
>  	pagemap =3D NULL;
>  	num_dma_mapped =3D 0;

[Severity: High]
This is a pre-existing issue, but does the error path here permanently leak
device mappings?

If dpagemap->ops->device_map() succeeds for some pages in
drm_gpusvm_get_pages(), but a subsequent mapping operation (like
dma_map_page() or dma_iova_link()) fails, the code jumps to err_unmap:

	err_unmap:
		svm_pages->flags.has_dma_mapping =3D true;
		__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);

Inside __drm_gpusvm_unmap_pages(), it reads:

	struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;

And later checks it before unmapping:

	else if (dpagemap && dpagemap->ops->device_unmap)
		dpagemap->ops->device_unmap(dpagemap, dev, addr);

However, back in drm_gpusvm_get_pages(), svm_pages->dpagemap is only
assigned at the very end of the success path:

	if (pagemap) {
		flags.has_devmem_pages =3D true;
		drm_pagemap_get(dpagemap);
		drm_pagemap_put(svm_pages->dpagemap);
		svm_pages->dpagemap =3D dpagemap;
	}

Does this mean that during the error path, svm_pages->dpagemap is NULL,
causing __drm_gpusvm_unmap_pages() to silently skip calling
dpagemap->ops->device_unmap() and permanently leak the mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827071449.5203=
98-1-honghuan@amd.com?part=3D2
