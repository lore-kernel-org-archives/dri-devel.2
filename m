Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA51BCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184E110F26C;
	Thu, 25 Jun 2026 12:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UEDUEOPg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C30B10F26C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:01:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37D9660018;
 Thu, 25 Jun 2026 12:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB431F000E9;
 Thu, 25 Jun 2026 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388916;
 bh=mPfen+sOd/kRTXBrP/NkrcQVZ41pCXYNIoFfm/v3Ri4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UEDUEOPgyWrFmLIXCAuzy8DcjfSCRhwZqsZ9NVtq8zY8UKx8UtMZQ5oxWyD+xrGqN
 voav/t9HKqaWHagLAy8+ZYCuTH9yxhfsRfv8JAFI1SFSB73x6nOrFtrX9//sV6yIiS
 zmCGwYa8YAIX1iyR2U9VsCWmnFtLgqmGpHC8iKLfNsgbZX/EL7omNC8JicJZKGcGPo
 XgYFzU8mBSESXeMU7eAlGl+8zTJN5m7lcR6E9a992zU67KtoyDDu3on9HMh7+7Ur3y
 nH9nnItdzgsuNSjuah3zQdZxM8YqVzI+nYb384E3PeX2Q0xeJV3rBHk9SdNrlIvKF8
 R70wYMt8NyoPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: Fix use-after-free in
 amdxdna_gem_dmabuf_mmap()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625113239.49764-1-vulab@iscas.ac.cn>
References: <20260625113239.49764-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:01:55 +0000
Message-Id: <20260625120156.BBB431F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] amdxdna_gem_dmabuf_mmap() ignores the requested VMA page offset wh=
en mapping exported dma-bufs.
- [High] Double `drm_gem_object_put()` in the `amdxdna_insert_pages()` erro=
r path causes a use-after-free.
- [High] Asynchronous use-after-free of the `vma` pointer in `amdxdna_umap_=
release()`.
--

commit 719267a0bdbc7550a107cb7df5bae4b3e649880b
Author: Wentao Liang <vulab@iscas.ac.cn>

accel/amdxdna: Fix use-after-free in amdxdna_gem_dmabuf_mmap()

When vm_insert_pages() fails, the error path calls vma->vm_ops->close(vma)
which internally calls drm_gem_vm_close() -> drm_gem_object_put(),
releasing the gem object reference acquired at the start of the function.

Cc: stable@vger.kernel.org

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index 63976c3bcbe0f..91323dddad445 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -527,6 +527,7 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf *dm=
a_buf, struct vm_area_struc
> =20
>  close_vma:
>  	vma->vm_ops->close(vma);

[Severity: High]
This is a pre-existing issue, but does this function ignore the requested
vma page offset when mapping exported dma-bufs?

A few lines above in amdxdna_gem_dmabuf_mmap(), the base pages array is
passed to vm_insert_pages() without being offset:

	ret =3D vm_insert_pages(vma, vma->vm_start, abo->base.pages,
			      &num_pages);

When an exported dma-buf is mapped by userspace, vma->vm_pgoff specifies
the real offset within the buffer in pages. Because the base pages array
is passed directly, if userspace requests a mapping with a non-zero offset,
could it erroneously map the beginning of the buffer instead, corrupting
the userspace memory view for partial or offset mappings?

> +	return ret;
>  put_obj:
>  	drm_gem_object_put(gobj);
>  	return ret;


While reviewing this code, I also noticed a couple of other pre-existing
issues in the amdxdna driver that might be worth looking into.

[Severity: High]
This is a pre-existing issue, but is there a double drm_gem_object_put()
in the amdxdna_insert_pages() error path that causes a use-after-free?

When vm_insert_pages() fails inside amdxdna_insert_pages(), the driver
attempts to clean up by manually calling the close handler:

	XDNA_ERR(xdna, "Failed insert pages %d", ret);
	vma->vm_ops->close(vma);
	return ret;

Because vma->vm_ops is assigned to &drm_gem_shmem_vm_ops, this triggers
drm_gem_shmem_vm_close(), which unconditionally drops a gem object
reference via drm_gem_vm_close(). The function then returns an error back
up to drm_gem_mmap_obj().

However, drm_gem_mmap_obj() handles .mmap callback failures by putting the
gem object reference itself on its error path. Does this result in the same
gem object reference being put twice, leading to a refcount underflow and
use-after-free?


[Severity: High]
This is a pre-existing issue, but could there be an asynchronous
use-after-free of the vma pointer in amdxdna_umap_release()?

amdxdna_hmm_register() caches the userspace vma pointer in mapp->vma.
During memory unmapping, amdxdna_hmm_invalidate() receives an
MMU_NOTIFY_UNMAP event and asynchronously queues mapp->hmm_unreg_work
to a workqueue, but it does not block waiting for the work to complete.

Consequently, the core mm proceeds to tear down and free the vma via
vm_area_free(). When the asynchronous worker eventually executes
amdxdna_umap_release(), it dereferences the stale vma pointer:

	if (is_import_bo(abo) && vma->vm_file && vma->vm_file->f_mapping)
		mapping_clear_unevictable(vma->vm_file->f_mapping);

Since the vma has likely already been freed by the core mm, does this
dereference trigger a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625113239.4976=
4-1-vulab@iscas.ac.cn?part=3D1
