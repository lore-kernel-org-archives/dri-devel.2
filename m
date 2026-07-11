Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A41C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 21:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0B810E0A3;
	Sat, 11 Jul 2026 21:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bibNFbOA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5651310E0A3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 21:02:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FEA160098
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 21:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F001F000E9;
 Sat, 11 Jul 2026 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783803745;
 bh=TnPsdIsKuWMK8aTWgXnkzDCAg/thdyb9K33stjKETRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bibNFbOAhdl5JXb5qkKpNcphWyAFNF8e71gQ9lQFTDbijSBNwCVmDA96Kr8EDLyyE
 5UYpxUm83szaMphCV6fh97cP2Rne9d8hfVKoU7ddqKvCzg3MemjWXWaKaAtOPDjihw
 bYLsMFd0pVOHc0bBShZdyOzsTHUFSM06y/4UM3A0DVpPHgToslMH9WK+TJ1S6+6bf5
 WotmwzDybXgbUtOHYj2c6wRRLEH3/Pn8yp0xWFwcJJk0o1Hls0iTl9xZKuNYoDddFa
 D7ACmnLVPykLgu93eYc3N6efi1Xumogd4t85sOrTE90O2vw19QhLCzJL9zsJh6lGYo
 iGxgwt/DhYE9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] mm: introduce vma_get_page_prot() and use it
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-b4-vma-flags-mm-v2-8-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
 <20260711-b4-vma-flags-mm-v2-8-0fa2357d5431@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 21:02:24 +0000
Message-Id: <20260711210224.92F001F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Modifying `vma->vm_page_prot` after `vm_mmap()` without `vma_start=
_write(vma)` causes data races with per-VMA lock readers and allows cache a=
liasing via concurrent page faults.
- [High] Multiple DRM drivers call `drm_gem_vm_close(vma)` on their interna=
l `mmap` error paths, causing a double-put and Use-After-Free (UAF).
- [High] `i915_gem_mmap_ioctl()` leaks a user-space memory mapping (VMA) if=
 operations fail after `vm_mmap()` succeeds.
- [High] `exynos_drm_gem_mmap()` leaks a GEM object reference when delegati=
ng mapping of an imported dma-buf.
--

--- Patch [8]: [PATCH v2 08/13] mm: introduce vma_get_page_prot() and use i=
t ---
commit 02617eb8c6f24873696c9debadc114509af28be5
Author: Lorenzo Stoakes <ljs@kernel.org>

mm: introduce vma_get_page_prot() and use it

This commit introduces a new helper vma_get_page_prot() to simplify
retrieving the page protection from a VMA. It replaces numerous direct
calls to vm_get_page_prot() across various DRM and core mm files.

> diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_g=
em_dma_helper.c
> index 1c00a71ab3c9d..7d9612075d310 100644
> --- a/drivers/gpu/drm/drm_gem_dma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_dma_helper.c
> @@ -540,7 +540,7 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_o=
bj, struct vm_area_struct *
>  	vm_flags_mod(vma, VM_DONTDUMP | VM_DONTEXPAND, VM_PFNMAP);
> =20
>  	if (dma_obj->map_noncoherent) {
> -		vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> +		vma->vm_page_prot =3D vma_get_page_prot(vma);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential refere=
nce
count underflow here.

In drm_gem_dma_mmap(), if the dma_mmap_pages() or dma_mmap_wc() mapping
fails, we call drm_gem_vm_close(vma) which drops the GEM object reference.
However, the caller drm_gem_mmap_obj() will also hit its own error path
and call drm_gem_object_put(obj) again on the same object. Could this
lead to a double-put and use-after-free? I see a similar pattern in
__tegra_gem_mmap() in the tegra driver as well.

> =20
>  		ret =3D dma_mmap_pages(drm_dev_dma_dev(dma_obj->base.dev),
>  				     vma, vma->vm_end - vma->vm_start,

> [ ... ]

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gem.c
> index 9a6270f3dca6b..0208c92595725 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -377,13 +377,13 @@ static int exynos_drm_gem_mmap(struct drm_gem_objec=
t *obj, struct vm_area_struct
> =20
>  	/* non-cachable as default. */
>  	if (exynos_gem->flags & EXYNOS_BO_CACHABLE)
> -		vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> +		vma->vm_page_prot =3D vma_get_page_prot(vma);

[Severity: High]
This is a pre-existing issue, but does this function leak a GEM object
reference when mapping an imported dma-buf?

When exynos_drm_gem_mmap() delegates an imported dma-buf to dma_buf_mmap()
early in the function, the dma_buf_mmap() routine replaces
vma->vm_private_data and vma->vm_ops with the exporter's state. When the
VMA is later unmapped, the exporter's close handler is invoked instead of
drm_gem_vm_close(). Doesn't this mean the reference originally taken by
drm_gem_mmap_obj() right before calling this callback is never dropped?

>  	else if (exynos_gem->flags & EXYNOS_BO_WC)
>  		vma->vm_page_prot =3D
> -			pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +			pgprot_writecombine(vma_get_page_prot(vma));

> [ ... ]

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i=
915/gem/i915_gem_mman.c
> index 0644f85c6c8e5..9ca90c1bb5b42 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -112,7 +112,7 @@ i915_gem_mmap_ioctl(struct drm_device *dev, void *dat=
a,

[Severity: High]
This isn't a bug introduced by this patch, but could this code leak a VMA?

If vm_mmap() succeeds earlier in i915_gem_mmap_ioctl(), but we then hit
the mmap_write_lock_killable() failure path:

i915_gem_mmap_ioctl()
    addr =3D vm_mmap(...);
    ...
    if (mmap_write_lock_killable(mm)) {
        addr =3D -EINTR;
        goto err;
    }
   =20
Does this overwrite the successfully mapped address and jump to the error
handling without unmapping the VMA, permanently leaking it?

>  		vma =3D find_vma(mm, addr);
>  		if (vma && __vma_matches(vma, obj->base.filp, addr, args->size))
>  			vma->vm_page_prot =3D
> -				pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> +				pgprot_writecombine(vma_get_page_prot(vma));

[Severity: High]
This is also a pre-existing issue, but is it safe to modify the VMA
page protection properties here without holding the per-VMA write lock?

We hold the mmap_write_lock, but since vma_start_write() is not called
first, per-VMA lock readers are not drained. Could a concurrent page
fault handle install Write-Back PTEs while we change the VMA to
Write-Combine, leading to cache aliasing?

>  		else
>  			addr =3D -ENOMEM;
>  		mmap_write_unlock(mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-b4-vma-fla=
gs-mm-v2-0-0fa2357d5431@kernel.org?part=3D8
