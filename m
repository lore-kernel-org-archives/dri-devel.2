Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD36C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3491310F77F;
	Sat, 27 Jun 2026 03:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DggRddv7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86D410F77F
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:52:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A67EE41153;
 Sat, 27 Jun 2026 03:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E151F000E9;
 Sat, 27 Jun 2026 03:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532338;
 bh=mvEC2GwmpSgV0WSTfUwFVYa+GwwO8IAl8zFlfdzH8lc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DggRddv7TSNrVttPahYjDS35MaApnZZ17kwbM9UnwasTOccvNATgk3z+9BBw9OakD
 M7KXuUtIdfw8pjN/TiSSoFd3ZQpCZixhDjHoD1pYXgGBot4v5FTDf7Rgxs//mQFEW8
 BbUL4AXzttYrsglkiKF7n9IS3NJqdEcO6RAtyFNrcYa6NDnq4NNJZJIfCgFkkJoOXr
 kTzPmREUew4hF6LT5oAX8uGab9z0RE0bJtttU/onRiazD22owYYI82OcQM22a1EpEb
 QCoWiqJg0WSEQV/cv0BibT3dDEnaTPqYks+D/Qt/SNd2ZzsaqRtBipRvKcPxg87yGT
 hhgPEPVSjhpQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/gpusvm: avoid reading uninitialized
 dma_addr[0].dir on IOVA unmap
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627033325.3795298-2-honglei1.huang@amd.com>
References: <20260627033325.3795298-1-honglei1.huang@amd.com>
 <20260627033325.3795298-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:52:17 +0000
Message-Id: <20260627035218.59E151F000E9@smtp.kernel.org>
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
- [High] Device memory mappings created by `device_map` are leaked on the e=
rror path in `drm_gpusvm_get_pages()` because `svm_pages->dpagemap` is NULL.
--

commit ba7f1a24074336f55f3749b1bf75d6961df95930
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: avoid reading uninitialized dma_addr[0].dir on IOVA unmap

This commit fixes an issue where an uninitialized DMA direction could be
passed to dma_iova_destroy() on the get_pages() error path. It guards
the direction argument with a check on npages and zeroes the dma_addr array.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..2d74e2aae0a77 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1146,10 +1146,17 @@ static void __drm_gpusvm_unmap_pages(struct drm_g=
pusvm *gpusvm,
>  		};
>  		bool use_iova =3D dma_use_iova(&svm_pages->state);
> =20
> +		/*
> +		 * On the get_pages() error path npages can be 0 with
> +		 * dma_addr[0] still unpopulated, while the IOVA reservation
> +		 * already needs tearing down. Pass DMA_BIDIRECTIONAL in that
> +		 * case instead of reading dma_addr[0].dir.
> +		 */
>  		if (use_iova)
>  			dma_iova_destroy(dev, &svm_pages->state,
>  					 svm_pages->state_offset,
> -					 svm_pages->dma_addr[0].dir, 0);
> +					 npages ? svm_pages->dma_addr[0].dir :
> +						  DMA_BIDIRECTIONAL, 0);
> =20
>  		for (i =3D 0, j =3D 0; i < npages; j++) {
>  			struct drm_pagemap_addr *addr =3D &svm_pages->dma_addr[j];

[Severity: High]
This is a pre-existing issue, but does this error path leak device mappings?

When drm_gpusvm_get_pages() maps device pages successfully using
dpagemap->ops->device_map(), but then fails on a subsequent page (for
example, returning -EOPNOTSUPP because ctx->allow_mixed is false), it jumps
to the err_unmap label:

drm_gpusvm_get_pages() {
        ...
err_unmap:
        svm_pages->flags.has_dma_mapping =3D true;
        __drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
}

However, svm_pages->dpagemap hasn't been assigned the local dpagemap yet.
When __drm_gpusvm_unmap_pages() runs, it reads the uninitialized
svm_pages->dpagemap as NULL.

This causes the cleanup loop in __drm_gpusvm_unmap_pages() to skip
device_unmap():

__drm_gpusvm_unmap_pages() {
        struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;
        ...
        for (i =3D 0, j =3D 0; i < npages; j++) {
            ...
            } else if (dpagemap && dpagemap->ops->device_unmap) {
                dpagemap->ops->device_unmap(dpagemap, dev, addr);
            }
        }
}

Since dpagemap is NULL, device_unmap() is never called for the already
mapped pages. Can this permanently leak the device mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627033325.3795=
298-1-honglei1.huang@amd.com?part=3D1
