Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61386C88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B2310E2F7;
	Thu, 10 Sep 2026 20:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAQ6r/QT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2705210E2F7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 20:14:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D76DB417E0;
 Thu, 10 Sep 2026 20:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910E81F000FF;
 Thu, 10 Sep 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789071243;
 bh=0Hkjf4SWXGPizvX8SvE9381btQr57v8lITE281T+YcM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EAQ6r/QTyIkgA0iXryaQhkc8ut4uj6+lRgDm+dKG4SR/t71fl7pBrDbAEa0/hXC3y
 4kwV/Fy1Io0Uvfwx7X1HYzyDQ8AD3/+OXHHRKbzXVxsZc0Azyu0/OUGzjoh6vNsAqL
 +IYT0fgv6RDfjz5bCoDEo/cZ9UudO4JHaCC2DQmcyX7+vmS6nNkwAxlq2yX3egdsEi
 Uq/UGM5qaitN1U9opiwvmFJUdGUkm/64yw66y5WS69tf6fgGA2CgX928k4a+4hOAz0
 U0VQlq+l2lXWcU23vGQG2MATFaKyXLG5zj6kCLuN0KIqY4G3XQKD+YnJUvdY/s8fhA
 BkYn5RnsKpZVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Fix unsafe use of handle_mm_fault()
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910195807.1093852-1-lizhi.hou@amd.com>
References: <20260910195807.1093852-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 20:14:03 +0000
Message-Id: <20260910201403.910E81F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying vma->vm_pgoff in the dma-buf mmap exporter breaks the dm=
a-buf interval tree, preventing memory revocation.
- [High] The patch completely bans mapping the BO at a non-zero offset, whi=
ch breaks userspace compatibility for partial mappings.
--

commit f5b497b44e071da0d7d3ac56c9b4055ed5127ba8
Author: Lizhi Hou <lizhi.hou@amd.com>
Subject: accel/amdxdna: Fix unsafe use of handle_mm_fault()

This commit replaces the use of handle_mm_fault() from the mmap callback
with a VM_MIXEDMAP and vm_insert_pages() approach for shmem BOs. For import=
ed
BOs, it marks the mapping as invalid and relies on the first command
submission to fault in the pages.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 3f05fa8811af1..612f36a2c0725 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -490,16 +491,12 @@ static int amdxdna_insert_pages(struct amdxdna_gem_=
obj *abo,
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
>  	unsigned long num_pages =3D vma_pages(vma);
> -	unsigned long offset =3D 0;
>  	int ret;
> =20
> -	if (!is_import_bo(abo)) {
> -		ret =3D drm_gem_shmem_mmap(&abo->base, vma);
> -		if (ret) {
> -			XDNA_ERR(xdna, "Failed shmem mmap %d", ret);
> -			return ret;
> -		}
> -	} else {
> +	if (vma->vm_pgoff - drm_vma_node_start(&to_gobj(abo)->vma_node))
> +		return -EINVAL;

[Severity: High]
Does this check artificially reject valid non-zero offsets that were previo=
usly
supported?

Userspace applications that attempt to mmap a sub-region of a Buffer Object
will receive an unexpected -EINVAL error.

If a userspace process calls mmap() on the DRM device fd, passing an offset
that includes both the DRM mmap node offset and a logical offset within the=
 BO,
it seems this strict equality check will fail and ban partial mappings.

> +
> +	if (is_import_bo(abo)) {
>  		vma->vm_private_data =3D NULL;
[ ... ]
>  static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_ar=
ea_struct *vma)
>  {
>  	struct drm_gem_object *gobj =3D dma_buf->priv;
>  	struct amdxdna_gem_obj *abo =3D to_xdna_obj(gobj);
> -	unsigned long num_pages =3D vma_pages(vma);
>  	int ret;
> =20
> -	vma->vm_ops =3D &drm_gem_shmem_vm_ops;
> +	vma->vm_ops =3D &amdxdna_gem_mixedmap_vm_ops;
>  	vma->vm_private_data =3D gobj;
> =20
>  	drm_gem_object_get(gobj);
> +	vma->vm_pgoff +=3D drm_vma_node_start(&gobj->vma_node);

[Severity: High]
Could modifying vma->vm_pgoff here corrupt the logical offset used for link=
ing
the VMA into the dma-buf address_space interval tree?

After the callback returns, the core memory management (mmap_region) links =
the
VMA into the dma-buf's file mapping interval tree using this highly inflated
vm_pgoff.

Because of this, memory revocation mechanisms for dma-bufs might fail to fi=
nd
and unmap this VMA, leaving stale PTEs that can lead to a use-after-free if
the backing memory is freed.

>  	ret =3D drm_gem_shmem_mmap(&abo->base, vma);
>  	if (ret)
>  		goto put_obj;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910195807.1093=
852-1-lizhi.hou@amd.com?part=3D1
