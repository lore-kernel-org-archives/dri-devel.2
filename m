Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D90C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE8A10E08A;
	Sat, 27 Jun 2026 04:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oTI1rS3e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230C010E08A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:07:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FD78600AA;
 Sat, 27 Jun 2026 04:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71EE1F000E9;
 Sat, 27 Jun 2026 04:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782533247;
 bh=lAFn95aEVPkZvt5y4Lmzc3CJS1Qip2ko3v3EbxKgiH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oTI1rS3e19axAta/1dwzIbXd4YgAP7e/zdc3eK8nqWf+DwSWBXse+geVBzbkxsyI2
 6qQceKhzacVraPG6KmTzkHpu/5oJAOc1sVZxCKedz4wIVOo4olJR00/JuLbLmQUqdH
 hBXFy75lIdr4a9f56pLmRgba0eJcuhRLN4LnhJG1T/OalbjZCWPREngAVuatFncaql
 6kll69qIFIrCQqid8r2F5T1DVBvckgCdaMrWCQR3xTbAymussWz/zsGGpMYbx8/fN/
 dsXNJKZnY79gV4OBzZRjIhl9jMHFBcs0dAdytlavbe0PAtYHOK7Fqy9wXieV3+s1eo
 WK0pNmGVSrxpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627035418.3796481-2-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
 <20260627035418.3796481-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:07:27 +0000
Message-Id: <20260627040727.B71EE1F000E9@smtp.kernel.org>
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
- [High] Leak of device page DMA mappings in `drm_gpusvm_get_pages()` error=
 path due to deferred assignment of `dpagemap`.
--

commit dfe7715229bc403af2e0a2fb749a3ef0875d2fdf
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

This patch embeds a drm_device pointer directly into drm_gpusvm_pages to
make the physical pages and their DMA view inherently bound to a specific
drm_device. It updates the DMA mapping functions to route all DMA through
svm_pages->drm instead of gpusvm->drm.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index df900553f21a4..155e3c2e703d9 100644
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
This is a pre-existing issue, but does this error path permanently leak
device page DMA mappings?

If dma_mapping_error() fails here (or if dma_iova_sync() fails later), the
code jumps to the err_unmap label which calls __drm_gpusvm_unmap_pages():

err_unmap:
	svm_pages->flags.has_dma_mapping =3D true;
	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);

However, svm_pages->dpagemap isn't assigned until the end of
drm_gpusvm_get_pages() on complete success.

In __drm_gpusvm_unmap_pages(), it checks:

	struct drm_pagemap *dpagemap =3D svm_pages->dpagemap;
	...
	else if (dpagemap && dpagemap->ops->device_unmap)

Since svm_pages->dpagemap is still NULL during the error path, the device
unmap operations will be skipped, leaving the successfully mapped device pa=
ges
in this batch leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627035418.3796=
481-1-honglei1.huang@amd.com?part=3D2
