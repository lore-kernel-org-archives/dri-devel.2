Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511BECD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 11:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27A310F066;
	Thu, 28 May 2026 11:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hkGqY1gp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0095F10F066
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 11:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779968341;
 bh=6BbE/VtvTsRidCICMewpm0oWjwe3p3VmGllvWPm6zF4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hkGqY1gpKOXZhWet38wVFbAeKCO5SB/UMPxUdIZ90X9/Wqyy7+C5EgGxZkOgg0Zsi
 w+G5h4Yee5RJ5X++TA/VP8g7neaASVXODhqPPF2IEgYQx+RQIySCrblFOQ2z6wYr8z
 +rTpWk7LSzre3hw6fStWMYpbUgvBhg360YuPxz0yh+DhaVg5DtlpL42arESUV6qeS0
 23fdL/2Fa6n+BgG+he6g3T8ZzzTl6gWbbU+qy7Kl0Y537ix5V4KuyStcF9AL7G950X
 DBDLGKm24edtQNW2wGcuUDP+GmcttuIR4pyz+kJ4RF/cGfbp1NezYsQQTBbuXE3MYp
 M8Aap66sVtlpQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 319F517E0246;
 Thu, 28 May 2026 13:39:01 +0200 (CEST)
Date: Thu, 28 May 2026 13:38:56 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: igor.torrente@collabora.com, simona@ffwll.ch, airlied@gmail.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/gem-shmem: Immediately record writable mmap; drop
 pfn_mkwrite
Message-ID: <20260528133856.27eb0c8c@fedora>
In-Reply-To: <20260528102809.399127-1-tzimmermann@suse.de>
References: <20260528102809.399127-1-tzimmermann@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Thu, 28 May 2026 12:27:59 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Using pfn_mkwrite breaks KVM with "error: kvm run failed Bad address".
> Seen on a Mali-G610 GPU. Fix this by marking writable mmapped pages as
> written when installing the mapping in the page table.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Igor Torrente <igor.torrente@collabora.com>
> Closes: https://lore.kernel.org/dri-devel/d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com/raw
> Tested-by: Igor Torrente <igor.torrente@collabora.com>
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Two nits below.

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 48 ++++++++------------------
>  1 file changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 545933c7f712..7af31932af84 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -554,21 +554,6 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>  
> -static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct drm_gem_object *obj = vma->vm_private_data;
> -	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> -	loff_t num_pages = obj->size >> PAGE_SHIFT;
> -	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
> -
> -	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> -		return;
> -
> -	file_update_time(vma->vm_file);
> -	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
> -}
> -
>  static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  				 unsigned long pfn)
>  {
> @@ -581,23 +566,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  
>  		if (aligned &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> -			vm_fault_t ret;
> -
>  			pfn &= PMD_MASK >> PAGE_SHIFT;
>  
> -			/* Unlike PTEs which are automatically upgraded to
> +			/*
> +			 * Unlike PTEs which are automatically upgraded to
>  			 * writeable entries, the PMD upgrades go through
>  			 * .huge_fault(). Make sure we pass the "write" info
>  			 * along in that case.
> -			 * This also means we have to record the write fault
> -			 * here, instead of in .pfn_mkwrite().
>  			 */

We can drop the comment altogether since we no longer have this
read-only -> rw upgrade now that pfn_mkwrite is gone.

> -			ret = vmf_insert_pfn_pmd(vmf, pfn,
> -						 vmf->flags & FAULT_FLAG_WRITE);
> -			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> -				drm_gem_shmem_record_mkwrite(vmf);
> -
> -			return ret;
> +			return vmf_insert_pfn_pmd(vmf, pfn, false);
>  		}
>  #endif
>  	}
> @@ -635,8 +612,18 @@ static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int ord
>  	pfn = page_to_pfn(page);
>  
>  	ret = try_insert_pfn(vmf, order, pfn);
> -	if (ret == VM_FAULT_NOPAGE)
> +	if (ret == VM_FAULT_NOPAGE) {
>  		folio_mark_accessed(folio);

Please add a blank line here.

> +		/*
> +		 * Immediately record write access to the buffer. The
> +		 * natural place would be pfn_mkwrite at the time when
> +		 * the access happens, but this breaks KVM.
> +		 */
> +		if (vma->vm_flags & VM_WRITE) {
> +			file_update_time(vma->vm_file);
> +			folio_mark_dirty(folio);
> +		}
> +	}
>  
>  out:
>  	dma_resv_unlock(obj->resv);
> @@ -683,12 +670,6 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>  	drm_gem_vm_close(vma);
>  }
>  
> -static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
> -{
> -	drm_gem_shmem_record_mkwrite(vmf);
> -	return 0;
> -}
> -
>  const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>  	.fault = drm_gem_shmem_fault,
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> @@ -696,7 +677,6 @@ const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>  #endif
>  	.open = drm_gem_shmem_vm_open,
>  	.close = drm_gem_shmem_vm_close,
> -	.pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>  };
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>  

