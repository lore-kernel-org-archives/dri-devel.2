Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15036CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5872F10EF1B;
	Wed, 17 Jun 2026 10:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QlcNSjkT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A388910EF1B
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:49:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52EFF4405E;
 Wed, 17 Jun 2026 10:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9A81F00A3A;
 Wed, 17 Jun 2026 10:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781693359;
 bh=hkU8XnfEO56YfZAP/E1b3zFxxoxMWvDAV06O7yEkTio=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QlcNSjkTQP1rRKxZhN/6iEoOwkFFe3Ds6Ec8dG1GiOPf9sunsWky+0xF9FEcdIt9f
 Zuh12f6KRgOVTScw8YWymjjHbSeC5sjjq9pML/v10zLfs56oePOKC3NUb3xwSx2Hr9
 2QmPleSXwlABjnIHXkWtrL1XhNXkWxED983y6BdwxmWikdtOtV7LOl0d2G0yvSsj6R
 le9wL0ifanmehn3g3KRhEndSUYBah2QoI6Fwwe0Bz+I6uS6n8bwujmtRt22efYo9jd
 qgcy2kYJ9NX4/J3oGfN6dOeqv081u89rRdUXqE2VGGl4SHOZCYFFMI8pvM6wKKKkkz
 fsoolDfEIKD/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/gpusvm: embed struct drm_device into
 drm_gpusvm_pages
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617103602.1491609-3-honglei1.huang@amd.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
 <20260617103602.1491609-3-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 10:49:18 +0000
Message-Id: <20260617104919.0E9A81F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The `userptr->pages.drm` field is initialized after the MMU inte=
rval notifier is inserted, exposing it to concurrent lockless access by not=
ifier callbacks.

Pre-existing issues:
- [High] Device pages are leaked on the error path in `drm_gpusvm_get_pages=
()` because `svm_pages->dpagemap` is not populated before jumping to the un=
map cleanup logic.
- [High] `__drm_gpusvm_unmap_pages()` incorrectly passes system pages to th=
e `device_unmap` callback when a mixed range is mapped on an IOVA-enabled d=
evice.
- [High] Uninitialized memory read of `svm_pages->dma_addr[0].dir` in the e=
rror path of `__drm_gpusvm_unmap_pages`.
--

commit 5025fa9183334de09c92fc07865022970a487d35
Author: Honglei Huang <honghuan@amd.com>
Subject: drm/gpusvm: embed struct drm_device into drm_gpusvm_pages

drm_gpusvm_pages is the layer that actually represents physical
pages/mappings it owns the dma_addr array, the dma_iova_state...
With the previous patch, so drm_gpusvm_pages is now strictly about
physical pages and their DMA view.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 6cb38c76dc7be..d6407c94cdda3 100644
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
>  	if (svm_pages->flags.has_dma_mapping) {

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the logic when IOVA=
 is
used in __drm_gpusvm_unmap_pages(). When use_iova is true, system pages
evaluating this check:

    if (!use_iova && addr->proto =3D=3D DRM_INTERCONNECT_SYSTEM)
        dma_unmap_page(dev, addr->addr, PAGE_SIZE << addr->order, addr->dir=
);
    else if (dpagemap && dpagemap->ops->device_unmap)
        dpagemap->ops->device_unmap(dpagemap, dev, addr);

would fall through to the else if branch. If the SVM range contains both
system and device pages, dpagemap would be non-NULL, causing the system pag=
es
to be erroneously passed to dpagemap->ops->device_unmap(). Could this result
in an incompatible address format being passed to the device pagemap driver?

[Severity: High]
Another pre-existing issue in this same function: when mapping the very fir=
st
page fails in drm_gpusvm_get_pages(), the error path calls this unmap funct=
ion
with npages (or num_dma_mapped) set to 0. The code here does:

    if (use_iova)
        dma_iova_destroy(dev, &svm_pages->state, svm_pages->state_offset,
                         svm_pages->dma_addr[0].dir, 0);

Since svm_pages->dma_addr is allocated with kvmalloc_objs() (which does not
zero memory) and num_dma_mapped is 0, is it possible this passes
uninitialized memory as the DMA direction?

[ ... ]

> @@ -1590,7 +1599,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>  	}
> =20
>  	if (dma_use_iova(state)) {
> -		err =3D dma_iova_sync(gpusvm->drm->dev, state, 0,
> +		err =3D dma_iova_sync(svm_pages->drm->dev, state, 0,
>  				    svm_pages->state_offset);
>  		if (err)
>  			goto err_unmap;

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about the
error path here. In drm_gpusvm_get_pages(), if an error occurs while mapping
a device page:

    if (dma_mapping_error(svm_pages->drm->dev, svm_pages->dma_addr[j].addr)=
) {
        err =3D -EFAULT;
        goto err_unmap;
    }

The jump to err_unmap happens before svm_pages->dpagemap is populated
at the end of the loop. When __drm_gpusvm_unmap_pages() is then called,
it relies on dpagemap which resolves from svm_pages->dpagemap (which is
still NULL). Does this mean the device's unmap callback is skipped, leaking
all device pages previously mapped in the current batch?

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_user=
ptr.c
> index 6761005c0b900..1b540e62af6c3 100644
> --- a/drivers/gpu/drm/xe/xe_userptr.c
> +++ b/drivers/gpu/drm/xe/xe_userptr.c
> @@ -390,6 +390,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, uns=
igned long start,
>  		     unsigned long range)
>  {
>  	struct xe_userptr *userptr =3D &uvma->userptr;
> +	struct xe_vm *vm =3D xe_vma_vm(&uvma->vma);
>  	int err;
> =20
>  	INIT_LIST_HEAD(&userptr->invalidate_link);
> @@ -402,6 +403,7 @@ int xe_userptr_setup(struct xe_userptr_vma *uvma, uns=
igned long start,
>  		return err;
> =20
>  	userptr->pages.notifier_seq =3D LONG_MAX;
> +	userptr->pages.drm =3D &vm->xe->drm;
> =20
>  	return 0;
>  }

[Severity: Medium]
Could this ordering cause a data race? The MMU interval notifier is inserted
just before this assignment:

    err =3D mmu_interval_notifier_insert(&userptr->notifier, current->mm,
                                       start, range,
                                       &vma_userptr_notifier_ops);
    if (err)
        return err;

This immediately exposes the notifier to asynchronous invalidation callback=
s.
If the invalidation callback executes concurrently on another CPU, it might
read userptr->pages.drm before it is initialized here, leading to potential
KCSAN warnings or lockless access issues. Should the initialization of
userptr->pages.drm happen before the notifier is inserted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617103602.1491=
609-1-honglei1.huang@amd.com?part=3D2
