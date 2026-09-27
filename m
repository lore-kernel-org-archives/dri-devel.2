Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA17C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFCC10E053;
	Sun, 27 Sep 2026 20:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fE2OH3MR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937C510E053
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 20:47:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4222D41B30;
 Sun, 27 Sep 2026 20:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7251F000FF;
 Sun, 27 Sep 2026 20:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790542049;
 bh=/Bfkc1mMzdoI6DJf4ffixO762p7ODXAF5SNmPdvBi5Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fE2OH3MRkmylrYSEqbDrgXFnzqcMC95W8GWFcytGpoM0HEEuKWGWYFcl1iqH5pFyI
 DnrnV8fBrV01kjIU6B1gf4q1B86N8NJHrDahyqCUr3cqMjHmsBqshtCCke2NtGI+mU
 4bZAmu7AV0Kke+oNxQtR6DbRi4UYq++AVuJ8RjHD921u2ZoyqiUJvEQk2+yzJBiBDk
 mZv7gV+BnD6XrEXkE9B6DvJKSmXwKIwCUeiZ2q1baxL4lE/tFe/N0p9xtG0b/5w/8G
 soC51Qg2gLoHCADRGM9b/usmV5M4yGdfOWBAoC5DcxSneW8AdneSGAy3luqAgWhQAV
 379bmm0u/CFSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: Set DRM DMA device directly from HVS and V3D
To: "Daniel Drake" <dan@reactivated.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net>
References: <20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 20:47:28 +0000
Message-Id: <20260927204728.EF7251F000FF@smtp.kernel.org>
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
- [High] drm/vc4: dma_free_wc() used with wrong device in vc4_bo_purge()
--

commit abd61016c96bce404abb5e31405d8c24a7acfb12
Author: Daniel Drake <dan@reactivated.net>

    drm/vc4: Set DRM DMA device directly from HVS and V3D
   =20
    vc4 uses of_dma_configure() during bind to set the DMA configuration of
    the drm device by borrowing the configuration of one of its component
    devices.

> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index e715147d091ca..305770c87dcf0 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
[ ... ]
> @@ -1662,6 +1663,19 @@ static int vc4_hvs_bind(struct device *dev, struct=
 device *master, void *data)
>  		hvs->regset.nregs =3D ARRAY_SIZE(vc4_hvs_regs);
>  	}
> =20
> +	if (vc4->gen >=3D VC4_GEN_6_C) {
> +		ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Use the HVS as the DRM device's DMA controller for buffer
> +	 * allocations if one has not already been configured.
> +	 */
> +	if (drm_dev_dma_dev(drm) =3D=3D drm->dev)
> +		drm_dev_set_dma_dev(drm, dev);

[Severity: High]
Will this change lead to a DMA API regression in vc4_bo_purge()?

Looking at drivers/gpu/drm/vc4/vc4_bo.c, when a DMA allocation fails under
memory pressure, vc4_bo_userspace_cache_purge() calls vc4_bo_purge() to
reclaim memory from BOs marked as DONTNEED.

In vc4_bo_purge(), the memory is freed using the virtual aggregate device
instead of the newly configured DMA device:

static void vc4_bo_purge(struct drm_gem_object *obj)
{
	...
	dma_free_wc(dev->dev, obj->size, bo->base.vaddr, bo->base.dma_addr);
	...
}

Since buffer objects are allocated using drm_gem_dma_create(), which now
uses the properly configured drm_dev_dma_dev(drm) device, bypassing GEM
helpers and explicitly calling dma_free_wc(dev->dev, ...) breaks the DMA
API contract.

This contract requires memory to be freed with the exact same device pointer
used for allocation. Using a different device guarantees IOMMU unmap failur=
es,
as the aggregate device no longer has a matching DMA/IOMMU configuration.

Should vc4_bo_purge() be updated to use drm_dev_dma_dev(dev) instead of
dev->dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-drm-dma-de=
vice-2-v1-1-3230afcdc851@reactivated.net?part=3D1
