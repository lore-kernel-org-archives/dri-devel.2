Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DC9C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7750F10ED6A;
	Wed,  5 Aug 2026 08:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGUSfw8A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2FE810ED6A
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:16:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2879D4189F;
 Wed,  5 Aug 2026 08:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CB01F000E9;
 Wed,  5 Aug 2026 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785917786;
 bh=fY+JUPv7wKZXGTHyB7KltS5MjLz2ogcUdKnK8FxdlIo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EGUSfw8ANyjagZL+likOSCUaACQCGBLmewMVGKsO0ojHcUBWmBHPXxxmx6LMfkrA0
 oqKRQd4qLhFVG0gPzBJb86+ClgSSfaB6di8LNw936LO1zRkPlXaTJaA+lTauzjEOCv
 ou2GppxgQGgG/aJ1Dm3SL5OycSiBkTqCZpC1/YNlb7aOz8oZKy6u1i/v6jgv1/08UJ
 Nzv42nri93QJq0rdqS0lYDRRu7jCRnFpUd9//bWR0Gbuji8iF4sRyCRot+B86oNymm
 u+JTx89Ls1+j2G4mT9HHgJaYGlc6de3r1BVhrGZPlDc7DSdGr1O487nV9XUm13IgmT
 wkJcFS0aucg+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gem-dma: bound the mmap against the object size
To: "Baul Lee" <baul.lee@xbow.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805080147.12564-1-baul.lee@xbow.com>
References: <20260805080147.12564-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:16:25 +0000
Message-Id: <20260805081625.D4CB01F000E9@smtp.kernel.org>
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
- [Critical] Double put of the GEM object when dma_mmap_pages() or dma_mmap=
_wc() fails in drm_gem_dma_mmap(), leading to a potential use-after-free.
--

--- Patch [1]: [PATCH] drm/gem-dma: bound the mmap against the object size =
---
commit ec72c1516cca4ec0e08262f650b80d864b2ece0c
Author: Baul Lee <baul.lee@xbow.com>

drm/gem-dma: bound the mmap against the object size

This commit updates drm_gem_dma_mmap() to pass the object size to the DMA
layer instead of the VMA length. It also adds an early bounds check to
reject VMA lengths exceeding the object size.

> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_g=
em_dma_helper.c
> index 1c00a71ab3c9d..4211b404ded22 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
[ ... ]
> @@ -543,12 +546,12 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma=
_obj, struct vm_area_struct *
>  		vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> =20
>  		ret =3D dma_mmap_pages(drm_dev_dma_dev(dma_obj->base.dev),
> -				     vma, vma->vm_end - vma->vm_start,
> +				     vma, obj->size,
>  				     virt_to_page(dma_obj->vaddr));
>  	} else {
>  		ret =3D dma_mmap_wc(drm_dev_dma_dev(dma_obj->base.dev), vma,
>  				  dma_obj->vaddr, dma_obj->dma_addr,
> -				  vma->vm_end - vma->vm_start);
> +				  obj->size);
>  	}
>  	if (ret)
>  		drm_gem_vm_close(vma);

[Severity: Critical]
This is a pre-existing issue, but is it possible this error path causes a
double-put of the GEM object?

When a user calls mmap on a DRM device node under memory pressure,
drm_gem_mmap_obj() in drivers/gpu/drm/drm_gem.c sets vma->vm_private_data
to the object and then calls the object's mmap function:

drivers/gpu/drm/drm_gem.c:drm_gem_mmap_obj() {
    ...
    vma->vm_private_data =3D obj;
    ...
    ret =3D obj->funcs->mmap(obj, vma);
    ...
}

If the underlying dma_mmap_pages() or dma_mmap_wc() fails (for example,
returning -ENOMEM), drm_gem_dma_mmap() calls drm_gem_vm_close(vma), which
drops the first reference.

The error is then returned to drm_gem_mmap_obj(), which takes the error
path and drops a second reference:

drivers/gpu/drm/drm_gem.c:drm_gem_mmap_obj() {
    ...
err_drm_gem_object_put:
    drm_gem_object_put(obj);
    return ret;
}

Could this double-put lead to a use-after-free?

> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805080147.1256=
4-1-baul.lee@xbow.com?part=3D1
