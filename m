Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF11098797
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C974710EB1C;
	Fri, 20 Mar 2026 15:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bSSkHxP7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BA810EB1C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774021148;
 bh=WoZC4w/AJLISmbAkZiixNcCxDOrJ8srmuM/7zf8ac10=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bSSkHxP7YGRe7ElJ2n0QokhXFF32MegsaDy+Rh8no47ww5pFAGx5Sg3tnzfaBRn+e
 dR+sEMtfTlvFDB6xR2MvHz8IXIgYxoD9X0+aanh+JyC17DlDEMfbUO1IjYuZgYatwg
 lNSAofpioanEhzb7ZPlljDmVDpdV7vDiU0F7o7s6igzAsQPDlfraTwsPbyz9b4Qr9V
 70pxN24vDRGHB2v6TrdCSitAWK+MQWPIqWFcdFOpr4k/ZdP8mohfL173vpLRRXdFsA
 PeuJrQ3ydLAXzfxh+x7tj72ZVVaKPpAGwzimdgPYnnLCGeR5isJyZiVBQKoOsvblwS
 n0z8lXar5aVAg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D829017E0EB4;
 Fri, 20 Mar 2026 16:39:07 +0100 (CET)
Date: Fri, 20 Mar 2026 16:39:02 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mark Brown <broonie@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Pedro Demarchi Gomes
 <pedrodemargomes@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: linux-next: manual merge of the drm tree with the
 drm-misc-fixes tree
Message-ID: <20260320163902.24571f5d@fedora>
In-Reply-To: <ab1XClKfaCMYzg5-@sirena.org.uk>
References: <ab1XClKfaCMYzg5-@sirena.org.uk>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello Mark,

On Fri, 20 Mar 2026 14:17:46 +0000
Mark Brown <broonie@kernel.org> wrote:

> Hi all,
> 
> Today's linux-next merge of the drm tree got a conflict in:
> 
>   drivers/gpu/drm/drm_gem_shmem_helper.c
> 
> between commit:
> 
>   fc3bbf34e643f ("drm/shmem-helper: Fix huge page mapping in fault handler")
> 
> from the drm-misc-fixes tree and commits:
> 
>   5cf8de6cd1620 ("drm/gem-shmem: Return vm_fault_t from drm_gem_shmem_try_map_pmd()")
>   06f3662cb3ba9 ("drm/gem-shmem: Refactor drm_gem_shmem_try_map_pmd()")
> 
> from the drm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I have a slightly different conflict resolution (it's the one we currently
have in drm-tip[1]).

Regards,

Boris

[1]https://gitlab.freedesktop.org/drm/tip

--->8---

diff --cc drivers/gpu/drm/drm_gem_shmem_helper.c
index c549293b5bb6,4500deef4127..2062ca607833
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@@ -574,33 -574,39 +578,38 @@@ static vm_fault_t drm_gem_shmem_any_fau
  {
        struct vm_area_struct *vma = vmf->vma;
        struct drm_gem_object *obj = vma->vm_private_data;
+       struct drm_device *dev = obj->dev;
        struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
        loff_t num_pages = obj->size >> PAGE_SHIFT;
-       vm_fault_t ret;
+       vm_fault_t ret = VM_FAULT_SIGBUS;
        struct page **pages = shmem->pages;
-       pgoff_t page_offset;
+       pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
+       struct page *page;
+       struct folio *folio;
        unsigned long pfn;
  
 +      if (order && order != PMD_ORDER)
 +              return VM_FAULT_FALLBACK;
 +
-       /* Offset to faulty address in the VMA. */
-       page_offset = vmf->pgoff - vma->vm_pgoff;
+       dma_resv_lock(obj->resv, NULL);
  
-       dma_resv_lock(shmem->base.resv, NULL);
- 
-       if (page_offset >= num_pages ||
-           drm_WARN_ON_ONCE(obj->dev, !shmem->pages) ||
-           shmem->madv < 0) {
-               ret = VM_FAULT_SIGBUS;
+       if (page_offset >= num_pages || drm_WARN_ON_ONCE(dev, !shmem->pages) ||
+           shmem->madv < 0)
                goto out;
-       }
  
-       pfn = page_to_pfn(pages[page_offset]);
+       page = pages[page_offset];
+       if (drm_WARN_ON_ONCE(dev, !page))
+               goto out;
+       folio = page_folio(page);
+ 
+       pfn = page_to_pfn(page);
+ 
 -      if (folio_test_pmd_mappable(folio))
 -              ret = drm_gem_shmem_try_insert_pfn_pmd(vmf, pfn);
 -      if (ret != VM_FAULT_NOPAGE)
 -              ret = vmf_insert_pfn(vma, vmf->address, pfn);
 -
 +      ret = try_insert_pfn(vmf, order, pfn);
+       if (ret == VM_FAULT_NOPAGE)
+               folio_mark_accessed(folio);
  
-  out:
-       dma_resv_unlock(shmem->base.resv);
+ out:
+       dma_resv_unlock(obj->resv);
  
        return ret;
  }
@@@ -644,13 -645,29 +653,32 @@@ static void drm_gem_shmem_vm_close(stru
        drm_gem_vm_close(vma);
  }
  
+ static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
+ {
+       struct vm_area_struct *vma = vmf->vma;
+       struct drm_gem_object *obj = vma->vm_private_data;
+       struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+       loff_t num_pages = obj->size >> PAGE_SHIFT;
+       pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
+ 
+       if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
+               return VM_FAULT_SIGBUS;
+ 
+       file_update_time(vma->vm_file);
+ 
+       folio_mark_dirty(page_folio(shmem->pages[page_offset]));
+ 
+       return 0;
+ }
+ 
  const struct vm_operations_struct drm_gem_shmem_vm_ops = {
        .fault = drm_gem_shmem_fault,
 +#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 +      .huge_fault = drm_gem_shmem_any_fault,
 +#endif
        .open = drm_gem_shmem_vm_open,
        .close = drm_gem_shmem_vm_close,
+       .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
  };
  EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
  
