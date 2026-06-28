Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99376C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB6F010E58A;
	Sun, 28 Jun 2026 06:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X+L06cJq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3ECC10E58A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 06:36:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8ABB541B4A;
 Sun, 28 Jun 2026 06:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFA61F000E9;
 Sun, 28 Jun 2026 06:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782628600;
 bh=HRWQc13EBG+IrZtb+iqf0KMjfZ2a5InDnmIhs/lOS7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X+L06cJq8U55KrOkKRY1E0ygWJvgk/IH+fqgdwMCMbYwBQ3ChqoclVw8tCLrO9gh0
 Rjdj6XajdAIO7a+moa/cvLH6rHpRRRN54NZv3VHdMW+IPbZejBWRtB+lD7OVZvtLPN
 Mxpl65+uQKNE6LE8ctPmpgBmmcyaSHe417uK0dDaqZv+nUgtFDmzR2D5BHtX0BiS0Y
 e/3tF2dNNld0972FuehJ2tZUh39oAvz+smsfTUxpIFRK4t2gg6n5WQGJhK561AT4Z3
 IrsJ/UvWZ5jlpcs9AmD/tkRpOD2/vOyrOQrxXHOau1QIIoOV8xItcE7r/x6w8RzeBD
 8/1axI9JNPTDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628062518.4094189-3-honglei1.huang@amd.com>
References: <20260628062518.4094189-1-honglei1.huang@amd.com>
 <20260628062518.4094189-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 06:36:39 +0000
Message-Id: <20260628063640.3AFA61F000E9@smtp.kernel.org>
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
- [High] High severity issue: Uninitialized memory read in DMA cleanup. In =
the error path of `drm_gpusvm_get_pages()`, if `dma_iova_link()` fails on t=
he first page, uninitialized memory is consumed.
--

commit d0364428a8d456c414e83668f7405b6b9a856fea
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

This patch explicitly binds drm_gpusvm_pages instances to a specific
drm_device to route all DMA through it instead of through gpusvm->drm.
It introduces drm to struct drm_gpusvm_pages, binds it during
initialization, and replaces gpusvm->drm with svm_pages->drm in DMA
operations.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index df900553f21a4..155e3c2e703d9 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
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
>  						    dma_dir, 0);
>  				if (err)
>  					goto err_unmap;

[Severity: High]
This is a pre-existing issue, but in the error path of
drm_gpusvm_get_pages(), if dma_iova_link() fails on the first page, is
uninitialized memory consumed?

When the execution jumps directly to __drm_gpusvm_unmap_pages(), could the
uninitialized dir field be passed to dma_iova_destroy() during the DMA
cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628062518.4094=
189-1-honglei1.huang@amd.com?part=3D2
