Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F3606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRa85gNo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD0A10E1AF;
	Fri, 23 Oct 2026 07:34:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F4E10E1AF
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85210415BE;
 Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBA1F01825;
 Fri, 23 Oct 2026 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792740892;
 bh=eXol6dZvKepAqGtyVkHPm9mEeBZl0qhviZljTMDM3Zs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NRa85gNoK1jT3cXw1Y/3OAlcqKaKvVdZMTqV3A1Eq6TJQIAiGTPWaTNgzfis+XxaA
 rdtIwwtVdrOcYYHnesiyAEyVmjg+U9+p8jrgOFaRC4kLz/s42jBdqI7ooTybXgxCg1
 XUn+5CJ2XrUZTCJJmbWZXLFaGl4zzY/rDND9sOo62ICacDPugyRqSy1ZjMEdihSrUW
 W8rHl4pkaor3O114/tSND33YiBmzwtxEgT1q7E5/qzAKyn05s9x+eWtXE+6MD7VPhs
 UCR6U7lPXe5WNcAMaDWSixa2+IMdEevvT4PX3iDnvewLVYUVWycl81w1Csz+qzUOVq
 2QYKcLIamabBA==
Message-ID: <sashiko-outbox-182415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] accel/thames: Install memory mappings
 populated and dirty
To: "Tomeu Vizoso" <tomeu.vizoso@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261023-thames-v3-12-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-12-3ab40aa17157@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:34:51 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] accel/thames: double put and NULL deref on error in thames_gem=
_mmap()
- [Critical] accel/thames: COW bypass in thames_gem_mmap() on MAP_PRIVATE m=
appings
- [Low] accel/thames: MMU-only PTE helpers in thames_gem.c break !MMU COMPI=
LE_TEST builds
--

commit c4d46a848bca800b97f80e3d5bd5a0d1cb370cf4
Author: Tomeu Vizoso <tomeu.vizoso@gmail.com>

accel/thames: Install memory mappings populated and dirty

This commit replaces the default GEM DMA and GEM shmem mmap helpers in the
thames accelerator driver with custom mmap callbacks that pre-populate page
table entries as writable and dirty up front.

> diff --git a/drivers/accel/thames/thames_gem.c b/drivers/accel/thames/tha=
mes_gem.c
> index 5a4dc497768f8..9f55169c6370b 100644
> --- a/drivers/accel/thames/thames_gem.c
> +++ b/drivers/accel/thames/thames_gem.c
> @@ -808,12 +808,82 @@ static void thames_gem_shmem_bo_free(struct drm_gem=
_object *obj)
>  	drm_gem_shmem_free(&bo->shmem);
>  }
> =20
> +/*
> + * Installed dirty and writable: the A53s have no hardware dirty-bit man=
agement,
> + * so every first write would fault.
> + */
> +static int thames_gem_mmap(struct drm_gem_object *obj, struct vm_area_st=
ruct *vma)
> +{
> +	struct drm_gem_dma_object *dma_obj =3D to_drm_gem_dma_obj(obj);
> +	pgprot_t prot;
> +	int ret;
> +
> +	vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);
> +	vm_flags_mod(vma, VM_DONTDUMP | VM_DONTEXPAND, VM_PFNMAP);
> +
> +	prot =3D vm_get_page_prot(vma->vm_flags);
> +	if (vma->vm_flags & VM_WRITE)
> +		prot =3D pte_pgprot(pte_mkdirty(pte_mkwrite_novma(pfn_pte(0, prot))));
> +	vma->vm_page_prot =3D prot;

[Severity: Critical]
What happens here if userspace calls mmap() with PROT_WRITE and MAP_PRIVATE
on a contiguous buffer object?

In that case, vma_is_cow_mapping(vma) is true (VM_WRITE is set while
VM_SHARED is clear), so vm_get_page_prot(vma->vm_flags) returns read-only
page protection to fault on writes for copy-on-write.

Because thames_gem_mmap() does not reject vma_is_cow_mapping(vma) (unlike
thames_gem_shmem_mmap() below) and applies pte_mkwrite_novma() whenever
VM_WRITE is set, dma_mmap_pages() -> remap_pfn_range() will install
hardware-writable PTEs pointing directly to dma_obj->vaddr in a private
mapping, allowing writes to bypass copy-on-write and mutate the shared DMA
buffer.

Should thames_gem_mmap() reject vma_is_cow_mapping(vma) with -EINVAL as wel=
l?

> +
> +	ret =3D dma_mmap_pages(drm_dev_dma_dev(obj->dev), vma, vma->vm_end - vm=
a->vm_start,
> +			     virt_to_page(dma_obj->vaddr));
> +	if (ret)
> +		drm_gem_vm_close(vma);
> +
> +	return ret;
> +}

[Severity: Critical]
Does calling drm_gem_vm_close(vma) when dma_mmap_pages() fails cause a
double put or a NULL pointer dereference?

thames_gem_mmap() is wired up as the drm_gem_object_funcs.mmap callback in
thames_gem_funcs.

When called via drm_gem_mmap() -> drm_gem_mmap_obj(), drm_gem_mmap_obj()
takes one reference on obj for the VMA and drops that reference on error:

drivers/gpu/drm/drm_gem.c:drm_gem_mmap_obj() {
	drm_gem_object_get(obj);

	vma->vm_private_data =3D obj;
	vma->vm_ops =3D obj->funcs->vm_ops;

	if (obj->funcs->mmap) {
		ret =3D obj->funcs->mmap(obj, vma);
		if (ret)
			goto err_drm_gem_object_put;
	...
err_drm_gem_object_put:
	drm_gem_object_put(obj);
	return ret;
}

Since drm_gem_vm_close(vma) also calls drm_gem_object_put(vma->vm_private_d=
ata),
a failure in dma_mmap_pages() (for example, -ENOMEM in remap_pfn_range() or
-ENXIO on an out-of-range page offset) drops obj's reference twice,
underflowing the reference count held by the GEM handle and prematurely
freeing the buffer object.

Furthermore, when called on an exported DMA-BUF via
dma_buf_mmap_internal() -> drm_gem_dmabuf_mmap() -> drm_gem_prime_mmap(),
vma->vm_private_data is still NULL when obj->funcs->mmap(obj, vma) runs:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_mmap() {
	if (obj->funcs && obj->funcs->mmap) {
		vma->vm_ops =3D obj->funcs->vm_ops;

		drm_gem_object_get(obj);
		ret =3D obj->funcs->mmap(obj, vma);
		if (ret) {
			drm_gem_object_put(obj);
			return ret;
		}
		vma->vm_private_data =3D obj;
		return 0;
	}
}

In that path, calling drm_gem_vm_close(vma) passes NULL to
drm_gem_object_put(), triggering a NULL pointer dereference.

> +
> +/*
> + * Every page installed now, dirty and writable: they are pinned for the
> + * object's life, and the helper would take two faults on each.
> + */
> +static int thames_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_a=
rea_struct *vma)
> +{
> +	struct thames_gem_object *bo =3D to_thames_bo(obj);
> +	unsigned long addr =3D vma->vm_start;
> +	struct scatterlist *sg;
> +	pgprot_t prot;
> +	unsigned int i;
> +	int ret;
> +
> +	if (vma_is_cow_mapping(vma))
> +		return -EINVAL;
> +
> +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	prot =3D vm_get_page_prot(vma->vm_flags);
> +	if (vma->vm_flags & VM_WRITE)
> +		prot =3D pte_pgprot(pte_mkdirty(pte_mkwrite_novma(pfn_pte(0, prot))));
> +	vma->vm_page_prot =3D prot;

[Severity: Low]
Could the use of pfn_pte(), pte_mkwrite_novma(), pte_mkdirty(), and
pte_pgprot() in both thames_gem_mmap() and thames_gem_shmem_mmap() break
COMPILE_TEST builds when CONFIG_MMU is disabled or clear protection bits on
architectures without a custom pte_pgprot()?

In drivers/accel/thames/Kconfig, DRM_ACCEL_THAMES depends on
TI_K3_DSP_REMOTEPROC (which allows COMPILE_TEST) without a depends on MMU
dependency. On !CONFIG_MMU targets, pfn_pte(), pte_mkwrite_novma(), and
pte_mkdirty() are not declared. Additionally, on architectures that rely on
the generic fallback in include/linux/pgtable.h:

#ifndef pte_pgprot
#define pte_pgprot(x) ((pgprot_t) {0})
#endif

pte_pgprot() zeroes out all protection bits in prot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-thames-v3-=
0-3ab40aa17157@tomeuvizoso.net?part=3D12
