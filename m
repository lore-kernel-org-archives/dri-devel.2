Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1ECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A150810E6CA;
	Tue, 26 May 2026 14:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="hV5E1T/8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABF110E6CA
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779807408; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h2KHOJwv/HetVmK4gkRcMaDZ33eimcpWHHM5PeEPRQq45uefqxGyI8UMPUPPRcUbdTIYaUZD7w1SFMWYBKu89IbzHB243qco4i5fWfp6YITN+4A9e1Szdfe56IsuXw5HHykMvEFsqCeIYcxpOJV7ffUtjmKp+5TmIWoC/jLB03E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779807408;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=P4uYynv8jqFOKV2j+Ed4KuBsQHA4WRlcoUWnsLzIeZ4=; 
 b=hqYTn7LfxvxFE7NmkT5BmkPrGOtghccxVjM9sgX2NvC0+QTbBHhnQ3+8tcah9GqWBIcJndHN64+rHl+dWHTTAZ5uURRfqDwanSqb1ukZojpHwM22h9yo/DHEWfzE5USGpJA3JdbpLkUzFYFZwCED/SdbYVFTysuV5mc+AcxZjsg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779807408; 
 s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=P4uYynv8jqFOKV2j+Ed4KuBsQHA4WRlcoUWnsLzIeZ4=;
 b=hV5E1T/8MTAT4Kcm3HZcECqZpSMGZPLYtuR0bZHam71+bZyItXhR+BYje4lQFK85
 2UOu66gOiqCfHehnpZcEATLZopMovi1tYD1fEbofP+W+4JcokYPr12doZDqRKiGRq2D
 pcK2CcwVivpiaFDbzT79RYbBtzR+6gUgYsa2+kMA=
Received: by mx.zohomail.com with SMTPS id 1779807405712511.32591999559907;
 Tue, 26 May 2026 07:56:45 -0700 (PDT)
Message-ID: <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
Date: Tue, 26 May 2026 11:56:40 -0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Thomas Zimmermann <tzimmermann@suse.de>, boris.brezillon@collabora.com,
 loic.molinari@collabora.com, willy@infradead.org, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
Content-Language: en-US
From: Igor Torrente <igor.torrente@collabora.com>
In-Reply-To: <850e8355-7884-405c-a70a-986ce032c019@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Hi Thomas,

On 5/26/26 11:44, Thomas Zimmermann wrote:
> Hi
>
> Am 20.05.26 um 15:11 schrieb Igor Torrente:
> [...]
>>
>> I'm not familiar with the drm_gem, code so I don't any more 
>> insightful information
>> to share.  But hopefully we can find a better fix for this.
>
> Do you have huge pages enabled ?

No, I didn't even compile my kernel with huge pages. I've already been 
burned by that before


BR,
Igor Torrente

>
> Best regards
> Thomas
>
>>
>> BR,
>> Igor Torrente
>>
>>> ---
>>>   drivers/gpu/drm/drm_gem_shmem_helper.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c 
>>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index c3a054899ba3..0c86ad40a049 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -598,6 +598,9 @@ static vm_fault_t drm_gem_shmem_fault(struct 
>>> vm_fault *vmf)
>>>       if (ret != VM_FAULT_NOPAGE)
>>>           ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>>   +    if (likely(!(ret & VM_FAULT_ERROR)))
>>> +        folio_mark_accessed(folio);
>>> +
>>>   out:
>>>       dma_resv_unlock(obj->resv);
>>>   @@ -638,10 +641,27 @@ static void drm_gem_shmem_vm_close(struct 
>>> vm_area_struct *vma)
>>>       drm_gem_vm_close(vma);
>>>   }
>>>   +static vm_fault_t drm_gem_shmem_pfn_mkwrite(struct vm_fault *vmf)
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    struct drm_gem_object *obj = vma->vm_private_data;
>>> +    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>> +    pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page 
>>> offset within VMA */
>>> +    struct page *page = shmem->pages[page_offset];
>>> +    struct folio *folio = page_folio(page);
>>> +
>>> +    file_update_time(vma->vm_file);
>>> +
>>> +    folio_mark_dirty(folio);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   const struct vm_operations_struct drm_gem_shmem_vm_ops = {
>>>       .fault = drm_gem_shmem_fault,
>>>       .open = drm_gem_shmem_vm_open,
>>>       .close = drm_gem_shmem_vm_close,
>>> +    .pfn_mkwrite = drm_gem_shmem_pfn_mkwrite,
>>>   };
>>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
>
