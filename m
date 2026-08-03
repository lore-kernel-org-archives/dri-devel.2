Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC0C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA78110E02B;
	Mon,  3 Aug 2026 09:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IhKc48r1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4477910E02B
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785750926;
 bh=juMtF9il4sHowpmbeVJrKoAlrCCK8CRS0TU3O/3OaI4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IhKc48r1Lzt3DW7Dos2CZuRcmKicqjJJryVbp21XxDLGs/et3I9TMzxUyS9mWKHNX
 mGRqNzwhIvxFEG3vlm8Rg5xwKTAZ17YVVbWeLcwGZ88GwmexCJg29HNjcOejTKfey4
 8s7YErlmfyq1zpkqb/tjgO3AmJTugLP42WdsnWamEFFBJMN3va3cvk5FAHpQXPOZPu
 FvsyLdQSePbB/NTWLgogWoSy3/6c0ZnzLvj9SxWUMFe9BrMBP0d8phPTkvtG8uftMZ
 RUnwPGGuvrb5BK1uZeM6vHfJzCOyTwznOyf2iSt8jHjRLFhiDoDwihUg8lFYI9w6i6
 hhgn+Hu/Zg2MA==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BD8017E0048;
 Mon, 03 Aug 2026 11:55:26 +0200 (CEST)
Date: Mon, 3 Aug 2026 11:55:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Thomas Zimmermann
 <tzimmermann@suse.de>, David Hildenbrand <david@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Sergio Lopez <slp@redhat.com>, Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org
Subject: Re: [PATCH RFT 2/3] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Message-ID: <20260803115506.5c0acb0e@fedora1.home>
In-Reply-To: <20260731164341.1109827-3-pbonzini@redhat.com>
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <20260731164341.1109827-3-pbonzini@redhat.com>
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

On Fri, 31 Jul 2026 18:43:40 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> This ensures that KVM or VFIO correctly see a writable PTE when
> they request one.  Otherwise, a guest write to an unpopulated
> PTE from a mapping backed by a DRM GEM BO triggers a VM exit
> with EFAULT.
> 
> The code actually is simpler, because the same logic already
> applied to the hugepage mapping case using vmf_insert_pfn_pmd().
> 
> Reported-by: Sergio Lopez <slp@redhat.com>
> Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Glad some MM expert looked at this, because we had this partial "get
rid of pfn_mkwrite()" workaround pending [1], which apparently never
made it to drm-misc-fixes for some reason.

[1]https://lore.kernel.org/dri-devel/20260528114744.463484-1-tzimmermann@suse.de/

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index c989459eb215..33a14f558276 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
>  	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>  }
>  
> +/*
> + * Because the vm_ops have a .pfn_mkwrite() callback, vma_set_page_prot()
> + * has cleared the write bit from vma->vm_page_prot.  vmf_insert_pfn()
> + * would install a read-only entry even for a write fault, relying on a
> + * second fault to reach .pfn_mkwrite() and upgrade it, but that second
> + * fault never happens for fixup_user_fault() callers that directly
> + * walk the page tables with follow_pfnmap_start().  To ensure that
> + * they don't see the read-only entry, pass FAULT_FLAG_WRITE info down
> + * to install a writable entry right away.  Because .pfn_mkwrite() is
> + * not invoked, record the write afterwards.
> + */
>  static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  				 unsigned long pfn)
>  {
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
> +
>  	if (!order) {
> -		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +		ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  	} else if (order == PMD_ORDER) {
>  		unsigned long paddr = pfn << PAGE_SHIFT;
> @@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  
>  		if (aligned &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> -			vm_fault_t ret;
> -
>  			pfn &= PMD_MASK >> PAGE_SHIFT;
> -
> -			/* Unlike PTEs which are automatically upgraded to
> -			 * writeable entries, the PMD upgrades go through
> -			 * .huge_fault(). Make sure we pass the "write" info
> -			 * along in that case.
> -			 * This also means we have to record the write fault
> -			 * here, instead of in .pfn_mkwrite().
> -			 */
> -			ret = vmf_insert_pfn_pmd(vmf, pfn,
> -						 vmf->flags & FAULT_FLAG_WRITE);
> -			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> -				drm_gem_shmem_record_mkwrite(vmf);
> -
> -			return ret;
> +			ret = vmf_insert_pfn_pmd(vmf, pfn, write);
>  		}
>  #endif
>  	}
> -	return VM_FAULT_FALLBACK;
> +
> +	if (ret == VM_FAULT_NOPAGE && write)
> +		drm_gem_shmem_record_mkwrite(vmf);
> +	return ret;
>  }
>  
>  static vm_fault_t drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int order)

