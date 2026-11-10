Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741E860A260E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3ciHHmw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A6110E37E;
	Tue, 10 Nov 2026 20:59:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9DD10EDCB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:59:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2278444E70;
 Tue, 10 Nov 2026 20:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE31F008A4;
 Tue, 10 Nov 2026 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794344386;
 bh=yj+5m3KmopzQkMK0Jm8pRRJElMTMawKOB8MBt/3Wy+E=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=I3ciHHmw9CY/goOk/N59evBzxCPqrhUYKie3yc2jsBMC+jHKcbFLf70kZX4HxRcqB
 9CzPtrZTpCNC3Knx+JdEZ+cNULN2z5R538DQesK7S+gBIw3SUbqTrv5zrMeL3h+3if
 qvg3R/abiVmU3pOdWtUzPLuqKuCFJtbXq1wp4xD1nEHUkvR7RnAJiTBP0mL6ZtXXRV
 IVwD3jivF9i2Rov7rrNqaqojigJL3GMhXsEpsxSouhz+1zzsLig5Xj/sS6rBGGyt41
 ZWGTXfLIlIN6ccV+nk1JgEteaCFY3vOZpFRb02RWeWU6z/BUkpgmz/7z8iiYBEV8Zq
 IIlUOYjjr5xwA==
Message-ID: <sashiko-outbox-207756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] accel/amdxdna: Drop dma-buf wrapping for ubuf
To: "Lizhi Hou" <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110202644.3270432-1-lizhi.hou@amd.com>
References: <20261110202644.3270432-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:59:45 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] accel/amdxdna: amdxdna_ubuf_hmm_register() accepts VM_PFNMAP
  and VM_IO VMAs
- [Medium] accel/amdxdna: missing is_private_bo() check in
  amdxdna_flush_bo()
--

commit 1d6d9a5c2780dbf488fd71cbc00a82dc1ec39b14
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Drop dma-buf wrapping for ubuf

This commit converts ubuf buffer objects from imported dma-buf objects to
private DRM GEM objects and tracks their userspace virtual addresses with
HMM instead of long-term page pinning.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index ffe12a722dfea..a94195ea4e045 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -1364,7 +1370,7 @@ static int amdxdna_bo_pin(struct amdxdna_gem_obj *a=
bo)
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
>  	int ret;
> =20
> -	if (is_import_bo(abo))
> +	if (is_import_bo(abo) || is_private_bo(abo))
>  		return 0;
> =20
>  	ret =3D drm_gem_shmem_pin(&abo->base);
> @@ -1377,7 +1383,7 @@ static void amdxdna_bo_unpin(struct amdxdna_gem_obj=
 *abo)
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
> =20
> -	if (is_import_bo(abo))
> +	if (is_import_bo(abo) || is_private_bo(abo))
>  		return;
> =20
>  	drm_gem_shmem_unpin(&abo->base);

[Severity: Medium]
Should amdxdna_flush_bo() also check is_private_bo(abo) alongside
is_import_bo(abo)?

Previously, ubuf BOs were imported via amdxdna_gem_prime_import(), so
is_import_bo(abo) was true and amdxdna_flush_bo() returned -EOPNOTSUPP.
Because ubuf BOs are now initialized with drm_gem_private_object_init()
and only set abo->private_buffer, DRM_IOCTL_AMDXDNA_SYNC_BO on a ubuf BO
misses the early return in amdxdna_flush_bo():

drivers/accel/amdxdna/amdxdna_gem.c:amdxdna_flush_bo() {
	if (is_import_bo(abo))
		return -EOPNOTSUPP;
    ...
	if (amdxdna_gem_vmap(abo))
		drm_clflush_virt_range(amdxdna_gem_vmap(abo) + offset, size);
	else if (abo->base.pages)
		drm_clflush_pages(abo->base.pages, abo->mem.size >> PAGE_SHIFT);
	else
		return -EINVAL;
}

As a result, syncing a ubuf BO returns 0 when size is 0, or falls through
to amdxdna_gem_vmap(abo) and abo->base.pages and returns -EINVAL instead
of -EOPNOTSUPP.

[ ... ]

> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna=
/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..a5e202fbc72b9 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -6,182 +6,127 @@

[ ... ]

> +static int amdxdna_ubuf_hmm_register(struct amdxdna_client *client,
> +				     struct amdxdna_gem_obj *abo,
> +				     struct amdxdna_drm_va_entry *va_ent)
>  {
> -	struct amdxdna_ubuf_priv *ubuf =3D attach->dmabuf->priv;
> -	struct sg_table *sg;
> +	struct vm_area_struct *vma;
>  	int ret;
> =20
> -	sg =3D kzalloc_obj(*sg);
> -	if (!sg)
> -		return ERR_PTR(-ENOMEM);
> -
> -	ret =3D sg_alloc_table_from_pages(sg, ubuf->pages, ubuf->nr_pages, 0,
> -					ubuf->nr_pages << PAGE_SHIFT, GFP_KERNEL);
> -	if (ret)
> -		goto err_free_sg;
> +	mmap_write_lock(client->mm);
> +	vma =3D find_vma(client->mm, va_ent->vaddr);
> +	if (!vma || vma->vm_start > va_ent->vaddr ||
> +	    vma->vm_end - va_ent->vaddr < va_ent->len) {
> +		ret =3D -EINVAL;
> +		goto unlock;
> +	}
> =20
> -	ret =3D dma_map_sgtable(attach->dev, sg, direction, 0);
> -	if (ret)
> -		goto err_free_table;
> +	ret =3D amdxdna_hmm_register(abo, vma, va_ent->vaddr - vma->vm_start, v=
a_ent->len);
> +	if (!ret && !(vma->vm_flags & (VM_PFNMAP | VM_IO)))
> +		amdxdna_mark_map_invalid(abo);

[Severity: Medium]
Should amdxdna_ubuf_hmm_register() reject VMAs with VM_PFNMAP or VM_IO
instead of skipping amdxdna_mark_map_invalid(abo)?

Previously, amdxdna_get_ubuf() called pin_user_pages_fast(), which
rejected VM_PFNMAP and VM_IO mappings.  Skipping
amdxdna_mark_map_invalid(abo) leaves abo->mem.map_invalid false, so
amdxdna_umap_stale() always returns false and amdxdna_gem_umap_populate()
never faults in the range on command submission; if a VM_PFNMAP or VM_IO
VMA passed to DRM_IOCTL_AMDXDNA_CREATE_BO is lazily populated or has its
PTEs zapped, the device will hit IOMMU page faults when accessing the
PASID address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202644.3270=
432-1-lizhi.hou@amd.com?part=3D1
