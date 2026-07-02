Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481A5C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C42F10F1A8;
	Thu,  2 Jul 2026 07:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R6pomjcc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AC510F1A8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:45:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2959540A10;
 Thu,  2 Jul 2026 07:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1FE1F00A3D;
 Thu,  2 Jul 2026 07:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782978311;
 bh=ecV5J7O6MltGov8UE9GCtHVyPRQRYCRpOfmdxNd/6ow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R6pomjccJr1KQpPbm7f/tMkZShZOfAiMlPkId2pDUY5LMpTmBOi1ILUtkBa76VZhV
 Sl9dE9V+nb+3ibobqpREcYvBWnAbtzjPkBXPoT7KIvH97IhGsE0caRS7WjTvtZWb7T
 rRLJlNf/5kekNrUxyCaecdgylDO2VarH4+ZimPjX6beN96Zhim+3NvXpbF/KlTUk5n
 fz6RNZMH/4jgv946FVqO+XlL5kmw4p9m/uP1pwyHofoa0PRv5rqowltOgbmBe6oYKS
 ssDfNppcGcIkzBQFGh0OHvlMa/nPJhclG/Yctjp+sg+bEYCnEIN6sUgW3NRpdXiXBC
 8vqA/mc1J2jFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Fix double drm_gem_object_put() in
 dma-buf mmap error path
To: Jhonraushan <raushan.jhon@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072540.2183601-1-raushan.jhon@gmail.com>
References: <20260702072540.2183601-1-raushan.jhon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:45:10 +0000
Message-Id: <20260702074510.DE1FE1F00A3D@smtp.kernel.org>
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
- [High] Double-put of GEM object on the error path of `amdxdna_insert_page=
s()` for native BOs.
- [High] Unconditional dereference of `vma->vm_ops->close` on the error pat=
h for imported BOs in `amdxdna_insert_pages()`.
- [High] Use-after-free of VMA pointer stored in `amdxdna_umap` struct.
- [High] The dmabuf mmap implementation ignores the user-requested mapping =
offset (`vma->vm_pgoff`).
--

commit 09558bc86ce19ddb4577a60f4ba619ba0c0f3e1c
Author: Jhonraushan <raushan.jhon@gmail.com>

accel/amdxdna: Fix double drm_gem_object_put() in dma-buf mmap error path

This commit alters the error path of amdxdna_gem_dmabuf_mmap() to return
directly after vm_ops->close(vma). This prevents falling through to a second
drm_gem_object_put(), fixing a double-free use-after-free issue.

> Return directly after vm_ops->close() instead of falling through to the
> extra drm_gem_object_put(), matching the sibling amdxdna_insert_pages()
> error path.

[Severity: High]
This isn't a bug introduced by this patch, but the commit message mentions
matching the error path in amdxdna_insert_pages(). Does amdxdna_insert_page=
s()
have a similar double-put issue?

If vm_insert_pages() fails in amdxdna_insert_pages(), it calls
vma->vm_ops->close(vma). For native BOs, drm_gem_shmem_vm_close() drops
the GEM object reference. The function then returns an error code up the
stack to drm_gem_mmap_obj().

Since the .mmap callback returns an error, drm_gem_mmap_obj() intercepts it:

drm_gem_mmap_obj() {
    ...
err_drm_gem_object_put:
    drm_gem_object_put(obj);
    return ret;
}

Will this result in the object reference being dropped twice on that failure
path, leading to a use-after-free?

[Severity: High]
This is a pre-existing issue, but looking at the imported BOs error path in
amdxdna_insert_pages():

amdxdna_insert_pages() {
    ...
    if (fault_ret & VM_FAULT_ERROR) {
        vma->vm_ops->close(vma);
        XDNA_ERR(xdna, "Fault in page failed");
        return -EFAULT;
    }
}

Is it safe to unconditionally call vma->vm_ops->close() here? If dma_buf_mm=
ap()
sets up the VMA with an exporter's vm_ops that doesn't provide a .close=20
callback, or if vma->vm_ops is NULL, could this cause a NULL pointer=20
dereference?

[Severity: High]
This is another pre-existing issue, but I noticed a potential lifetime issue
with the VMA pointer in the hmm tracking code.

In amdxdna_hmm_register(), the driver stores the raw VMA pointer:

amdxdna_hmm_register() {
    ...
    mapp->vma =3D vma;
    mapp->abo =3D abo;
}

Since the VMA's lifetime is tied to the process's mm and is destroyed by the
core MM subsystem during munmap(), could the asynchronous work
amdxdna_umap_release() dereference a freed pointer?

amdxdna_umap_release() {
    ...
    if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
        mapping_clear_unevictable(vma->vm_file->f_mapping);
}

If the MM subsystem frees the VMA struct before this workqueue executes,
does this lead to a use-after-free crash?

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c

[ ... ]

> @@ -526,7 +526,12 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *d=
ma_buf, struct vm_area_struc

[Severity: High]
This is a pre-existing issue, but does this function ignore the user-reques=
ted
page offset?

Looking at the code just above this hunk:

amdxdna_gem_dmabuf_mmap() {
    ...
    ret =3D vm_insert_pages(vma, vma->vm_start, abo->base.pages,
                          &num_pages);
    if (ret)
        goto close_vma;
}

By unconditionally passing abo->base.pages to vm_insert_pages(), a user
mapping the dmabuf at a non-zero offset (vma->vm_pgoff) will receive the
beginning of the buffer rather than the requested offset.

Should this code offset the page array using abo->base.pages + vma->vm_pgof=
f,
or use vm_map_pages() instead?

>  	return 0;
> =20
>  close_vma:
> +	/* vm_ops->close() drops the reference taken by drm_gem_object_get()
> +	 * above, so return directly instead of falling through to put_obj
> +	 * and dropping it a second time.
> +	 */
>  	vma->vm_ops->close(vma);
> +	return ret;
>  put_obj:
>  	drm_gem_object_put(gobj);
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072540.2183=
601-1-raushan.jhon@gmail.com?part=3D1
