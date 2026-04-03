Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A3ED730B6
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E351F10F224;
	Fri,  3 Apr 2026 07:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nPE8SjAn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1E910F224
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 07:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775203075;
 bh=YoTFrjLkGAflEy1qRaxjWbCJiKRCH9HY1UiBdJlgevw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nPE8SjAnEZBbJgABAw3FhSWYZmzKwhs2mme9AMCx9PAn6Cn/Slk4Y4m9Jyg6MlNaP
 9e8q0xE8h88QNwZ5b9wcjvXN5W2del+Vsa4dCgVP0SrZE/cOZ3XKxeCNlxbKO4bLDO
 /RVuh1FR7t67aQstwvfvqPpZ/LkExksNsKpdIRAspq39jm7kJd5cpKWUgjznLImqeA
 WdSg2FDY6l6rejIBPzI85vgHTvZGzbTQ7x4tAAfsLJ6CDHMjVa9hnMc/OQ5uhc+t/J
 awcn0oq1k8y8eatl0dhihjtCtGng34XNmZu1bxuaC2vR/2tieG/FKpf1wqvBnFeofM
 TfrVgpPkB2UxQ==
Received: from [IPV6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa] (unknown
 [IPv6:2a01:e0a:5e3:6100:7aed:fe0e:8590:cbaa])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: loicmolinari)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C0BE317E8683;
 Fri,  3 Apr 2026 09:57:54 +0200 (CEST)
Message-ID: <1268c6cf-f3d7-4085-baca-796526125f44@collabora.com>
Date: Fri, 3 Apr 2026 09:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/shmem_helper: Make sure PMD entries get the writeable
 upgrade
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, kernel@collabora.com,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
References: <20260320151914.586945-1-boris.brezillon@collabora.com>
Content-Language: fr
From: =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>
Organization: Collabora Ltd
In-Reply-To: <20260320151914.586945-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Boris,

On 20/03/2026 16:19, Boris Brezillon wrote:
> Unlike PTEs which are automatically upgraded to writeable entries if
> .pfn_mkwrite() returns 0, the PMD upgrades go through .huge_fault(),
> and we currently pretend to have handled the make-writeable request
> even though we only ever map things read-only. Make sure we pass the
> proper "write" info to vmf_insert_pfn_pmd() in that case.
> 
> This also means we have to record the mkwrite event in the .huge_fault()
> path now. Move the dirty tracking logic to a
> drm_gem_shmem_record_mkwrite() helper so it can also be called from
> drm_gem_shmem_pfn_mkwrite().
> 
> Note that this wasn't a problem before commit 28e3918179aa
> ("drm/gem-shmem: Track folio accessed/dirty status in mmap"), because
> the pgprot were not lowered to read-only before this commit (see the
> vma_wants_writenotify() in vma_set_page_prot()).
> 
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> 
> This patch is based on drm-tip [2], because that's the only branch
> that has both [1] and the dirty tracking changes that live in
> drm-misc-next.
> 
> Also added the THP maintainers in Cc, so I can hopefully get some
> feedback on the fix. For instance, I'm still unsure
> drm_gem_shmem_pfn_mkwrite() is race-free (do we need some locking
> there? should we call folio_mark_dirty_lock()? should we call the
> fault handler directly from there and have all the dirty tracking
> in this .[huge_]fault path?).
> 
> [1]https://yhbt.net/lore/dri-devel/20260319015224.46896-1-pedrodemargomes@gmail.com/
> [2]https://gitlab.freedesktop.org/drm/tip
> ---
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 46 ++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 2062ca607833..545933c7f712 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -554,6 +554,21 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
>   }
>   EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>   
> +static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct drm_gem_object *obj = vma->vm_private_data;
> +	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> +	loff_t num_pages = obj->size >> PAGE_SHIFT;
> +	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
> +
> +	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> +		return;
> +
> +	file_update_time(vma->vm_file);
> +	folio_mark_dirty(page_folio(shmem->pages[page_offset]));

Unless we're sure the folio can't be truncated by another CPU, maybe we 
should use folio_mark_dirty_lock() here. This is what's done for pages 
(not PFNs) in mm/memory.c. Let's wait and see how it goes without 
locking for now.

Reviewed-by: Loïc Molinari <loic.molinari@collabora.com>

Regards,
Loïc

> +}
> +
>   static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>   				 unsigned long pfn)
>   {
> @@ -566,8 +581,23 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>   
>   		if (aligned &&
>   		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> +			vm_fault_t ret;
> +
>   			pfn &= PMD_MASK >> PAGE_SHIFT;
> -			return vmf_insert_pfn_pmd(vmf, pfn, false);
> +
> +			/* Unlike PTEs which are automatically upgraded to
> +			 * writeable entries, the PMD upgrades go through
> +			 * .huge_fault(). Make sure we pass the "write" info
> +			 * along in that case.
> +			 * This also means we have to record the write fault
> +			 * here, instead of in .pfn_mkwrite().
> +			 */
> +			ret = vmf_insert_pfn_pmd(vmf, pfn,
> +						 vmf->flags & FAULT_FLAG_WRITE);
> +			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> +				drm_gem_shmem_record_mkwrite(vmf);
> +
> +			return ret;
>   		}
>   #endif
>   	}
> @@ -655,19 +685,7 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
>   
>   static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
>   {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct drm_gem_object *obj = vma->vm_private_data;
> -	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
> -	loff_t num_pages = obj->size >> PAGE_SHIFT;
> -	pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page offset within VMA */
> -
> -	if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= num_pages))
> -		return VM_FAULT_SIGBUS;
> -
> -	file_update_time(vma->vm_file);
> -
> -	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
> -
> +	drm_gem_shmem_record_mkwrite(vmf);
>   	return 0;
>   }
>   

