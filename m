Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107CFC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6839B10E0F2;
	Mon, 21 Sep 2026 21:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AjWzjZEC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC70810E0F2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 21:32:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A880960236;
 Mon, 21 Sep 2026 21:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E371F000FF;
 Mon, 21 Sep 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790026369;
 bh=2qCM3j8OBf/mMorckknhQaUR3dGmgAeR0NgOCZZDh48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AjWzjZECtggrzN9B50jkj50P1F0/1bgOkjecuL+eRs8ayw8C4WhGP7xZhMIGJYDDa
 QHYMSkrnsNp+7AbeYGKW/oXzXK10dnsQPwZEuxmO7zHR+kLCp9r1Nky9nNfiMD5O4h
 MfsNx8bd/1zVwD+0em+pwDyAgw5974vWKwTQKDRH5AAosRKDK4ixa/TKeWATRhiiOF
 4oK8EzRIGWgaf5YXXRu7C5sL93O60Kk3pKkw/JJ7VZhANTLNl63e12ypdZb4LPbIdb
 eWVn712pku26cOgcNTT4zVrrXL+45Pk9az1kLr/y39ZVtJTr5D4xFDqoQBbSme0LnH
 haOWwLzPq2xHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] accel/amdxdna: Drop dma-buf wrapping for ubuf
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921211448.39832-1-lizhi.hou@amd.com>
References: <20260921211448.39832-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:32:48 +0000
Message-Id: <20260921213249.34E371F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] amdxdna: UBUF BOs trigger kernel WARN_ON and crash when opened by =
non-PASID client
- [Medium] amdxdna: CREATE_BO ubuf rejects valid multi-VMA user buffers
- [Medium] amdxdna: unprotected assignment to shared abo->mem.uva causes da=
ta race
--

commit 1efe7ea3fe610d7e9d53d3b1fead24d8137d077d
Author: Lizhi Hou <lizhi.hou@amd.com>
Subject: accel/amdxdna: Drop dma-buf wrapping for ubuf

This commit drops dma-buf wrapping for ubuf, directly importing userspace=20
memory as a DRM GEM private object and tracking the user VA with HMM. It=20
removes the FOLL_LONGTERM pin and relies on an MMU interval notifier to=20
fault the range in on command submission.

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index f4832337ec31d..a3d9a54c65634 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
[ ... ]
> @@ -335,12 +336,11 @@ static void amdxdna_hmm_unreg_work(struct work_stru=
ct *work)
>  	amdxdna_hmm_unreg_umaps(abo, false);
>  }
> =20
> -static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
> -				struct vm_area_struct *vma)
> +int amdxdna_hmm_register(struct amdxdna_gem_obj *abo, struct vm_area_str=
uct *vma,
> +			 size_t offset, size_t len)
>  {
>  	struct amdxdna_dev *xdna =3D to_xdna_dev(to_gobj(abo)->dev);
> -	unsigned long len =3D vma->vm_end - vma->vm_start;
> -	unsigned long addr =3D vma->vm_start;
> +	unsigned long addr =3D vma->vm_start + offset;

[Severity: Medium]
If a process creates a BO, forks, and both parent and child processes
concurrently mmap the inherited file descriptor, they can concurrently reach
the early return path in this function where abo->mem.uva is set to addr.

Does this unprotected assignment to abo->mem.uva cause a data race,
potentially leading to corrupted addresses being returned via GET_BO_INFO?

>  	struct amdxdna_umap *mapp;
>  	unsigned long nr_pages;
>  	int ret;
[ ... ]
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna=
/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..5c291786d981b 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
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

[Severity: Medium]
If a user calls CREATE_BO with a ubuf that spans multiple VMAs (such as
adjacent mmaps or split VMAs due to mprotect), find_vma() will return the
first VMA.

Does this check against vma->vm_end fail the entire request and incorrectly
return -EINVAL for a valid multi-VMA userspace buffer?

> -	ret =3D dma_map_sgtable(attach->dev, sg, direction, 0);
> -	if (ret)
> -		goto err_free_table;
> +	ret =3D amdxdna_hmm_register(abo, vma, va_ent->vaddr - vma->vm_start, v=
a_ent->len);
[ ... ]
> +struct amdxdna_gem_obj *amdxdna_alloc_ubuf_bo(struct amdxdna_client *cli=
ent,
> +					      u32 num_entries, void __user *va_entries)
>  {
[ ... ]
> +	bufsize =3D va_ent->len;
> +	abo =3D amdxdna_gem_create_obj(&xdna->ddev, bufsize);
> +	if (IS_ERR(abo)) {
> +		ret =3D PTR_ERR(abo);
> +		goto free_ent;
>  	}
> =20
> -	for (i =3D 0; i < num_entries; i++) {
> -		npages =3D va_ent[i].len >> PAGE_SHIFT;
> -
> -		ret =3D pin_user_pages_fast(va_ent[i].vaddr, npages,
> -					  FOLL_WRITE | FOLL_LONGTERM,
> -					  &ubuf->pages[start]);
> -		if (ret >=3D 0) {
> -			start +=3D ret;
> -			if (ret !=3D npages) {
> -				XDNA_ERR(xdna, "Partially pinned pages %d/%u", ret, npages);
> -				ret =3D -ENOMEM;
> -				goto destroy_pages;
> -			}
> -		} else {
> -			XDNA_ERR(xdna, "Failed to pin pages ret %d", ret);
> -			goto destroy_pages;
> -		}
> -	}
> +	abo->type =3D AMDXDNA_BO_SHARE;

[Severity: High]
If a PASID client creates a UBUF BO and exports it via GEM_FLINK, and a
non-PASID client then calls GEM_OPEN on it, the open path calls
amdxdna_dma_map_bo(). Since the type is set to AMDXDNA_BO_SHARE here, the
mapping routine invokes drm_gem_shmem_get_pages_sgt() for this object.

Can this dereference an uninitialized shmem->base.filp and trigger a kernel
WARN_ON and crash, given that UBUF BOs lack shmem initialization?

> +	abo->mem.uva =3D va_ent->vaddr;
> +	to_gobj(abo)->funcs =3D &amdxdna_gem_ubuf_obj_funcs;
> +	drm_gem_private_object_init(&xdna->ddev, to_gobj(abo), bufsize);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921211448.3983=
2-1-lizhi.hou@amd.com?part=3D1
