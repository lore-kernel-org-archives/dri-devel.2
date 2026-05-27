Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E9FCD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 15:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519810E274;
	Wed, 27 May 2026 15:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="aBnBvFY5";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DC610E274
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779894177; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GC2AFMYW5XBUGepg2yChJL+MVuU7qyT6sFRvfXM5IDqZSmhMm03T4JT2jLIPGki6owsbarpePIzuXs8jilkRCkLiLvhXbfA38Qh0imbM/DdHGdGTXVD+O2uSWFfJEAei857jTsQKIAIT1q45Kqva02sLcE8+9tNuaQ7X/NrtVRc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779894177;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2DVdpSqizLXrRnmwsc4NgvlHfA1kTlJlNvFuSbzPxxQ=; 
 b=byPqEwIqVQFyQi2Loh4epvx0F75VrsyPiRpcivSYrFhkYmTTcdQfj9k5J9I2XI8xD7fXESl9wizwgG63qhcvCo1Z3j5RPIckuFyV/OHje6VrC5pYeF0IY8CtqHa8L/OClgQi8vtX9RFdd1XKknzOterAEjoZ+kZGuMz4xllx/wY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
 dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779894177; 
 s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=2DVdpSqizLXrRnmwsc4NgvlHfA1kTlJlNvFuSbzPxxQ=;
 b=aBnBvFY58sBXNM+hYFZ2ntD445V3PIsoQg+pNM4as20fXTDdDvucSCfh19D7PG7Q
 +AkjWjLvXkGxlXbfZJFM9FPBkIhl5w8IK2wSBjqXVTKjk8FgutsoDWRHSX3l2YKZPjl
 hT1teGDrcqMSJqqZjgQqbit0GInLV7SgytLHTAcQ=
Received: by mx.zohomail.com with SMTPS id 1779894173814945.6444780909185;
 Wed, 27 May 2026 08:02:53 -0700 (PDT)
Message-ID: <16cbd262-aa82-4ca7-ac12-d587ed78ff3b@collabora.com>
Date: Wed, 27 May 2026 12:02:48 -0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: loic.molinari@collabora.com, willy@infradead.org, frank.binns@imgtec.com, 
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
 <850e8355-7884-405c-a70a-986ce032c019@suse.de>
 <831c0943-c75f-4d42-aa5f-90ce34cf8530@collabora.com>
 <67855fcd-2afe-4a1d-a51a-210e45f56167@suse.de>
 <20260527121832.7264f0db@fedora>
 <025ee28d-c941-4cf1-a6cf-565686ea0bec@suse.de>
Content-Language: en-US
From: Igor Torrente <igor.torrente@collabora.com>
In-Reply-To: <025ee28d-c941-4cf1-a6cf-565686ea0bec@suse.de>
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

Hi Tomas,

I tested your patch and Boris's modifications on top of your patch, and
I'm happy to report that both seem to work just fine.

BR,
Igor Torrente

On 5/27/26 07:32, Thomas Zimmermann wrote:
> Hi
>
> Am 27.05.26 um 12:18 schrieb Boris Brezillon:
>> Hello Thomas,
>>
>> I'm inlining the diff you posted so I can comment on it directly before
>> it's officially posted to the list.
>
> Thanks, I'll incorporate those in the next test rev or the official 
> patch.
>
> Best regards
> Thomas
>
>>
>> On Wed, 27 May 2026 08:56:33 +0200
>> Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c 
>>> b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index 545933c7f712..07e117673124 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -554,21 +554,6 @@ int drm_gem_shmem_dumb_create(struct drm_file 
>>> *file, struct drm_device *dev,
>>>   }
>>>   EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
>>>   -static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
>>> -{
>>> -    struct vm_area_struct *vma = vmf->vma;
>>> -    struct drm_gem_object *obj = vma->vm_private_data;
>>> -    struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
>>> -    loff_t num_pages = obj->size >> PAGE_SHIFT;
>>> -    pgoff_t page_offset = vmf->pgoff - vma->vm_pgoff; /* page 
>>> offset within VMA */
>>> -
>>> -    if (drm_WARN_ON(obj->dev, !shmem->pages || page_offset >= 
>>> num_pages))
>>> -        return;
>>> -
>>> -    file_update_time(vma->vm_file);
>>> - folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>>> -}
>>> -
>>>   static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned 
>>> int order,
>>>                    unsigned long pfn)
>>>   {
>>> @@ -581,23 +566,16 @@ static vm_fault_t try_insert_pfn(struct 
>>> vm_fault *vmf, unsigned int order,
>>>             if (aligned &&
>>> folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
>>> -            vm_fault_t ret;
>>> -
>>>               pfn &= PMD_MASK >> PAGE_SHIFT;
>>>   -            /* Unlike PTEs which are automatically upgraded to
>>> +            /*
>>> +             * Unlike PTEs which are automatically upgraded to
>>>                * writeable entries, the PMD upgrades go through
>>>                * .huge_fault(). Make sure we pass the "write" info
>>>                * along in that case.
>>> -             * This also means we have to record the write fault
>>> -             * here, instead of in .pfn_mkwrite().
>>>                */
>>> -            ret = vmf_insert_pfn_pmd(vmf, pfn,
>>> -                         vmf->flags & FAULT_FLAG_WRITE);
>>> -            if (ret == VM_FAULT_NOPAGE && (vmf->flags & 
>>> FAULT_FLAG_WRITE))
>>> -                drm_gem_shmem_record_mkwrite(vmf);
>>> -
>>> -            return ret;
>>> +            return vmf_insert_pfn_pmd(vmf, pfn,
>>> +                          vmf->flags & FAULT_FLAG_WRITE);
>> I believe we can go back to
>>
>>             return vmf_insert_pfn_pmd(vmf, pfn, false);
>>
>> if the mappings are no longer adjusted to catch write accesses.
>>
>>>           }
>>>   #endif
>>>       }
>>> @@ -635,8 +613,15 @@ static vm_fault_t 
>>> drm_gem_shmem_any_fault(struct vm_fault *vmf, unsigned int ord
>>>       pfn = page_to_pfn(page);
>>>         ret = try_insert_pfn(vmf, order, pfn);
>>> -    if (ret == VM_FAULT_NOPAGE)
>>> +    if (ret == VM_FAULT_NOPAGE) {
>>>           folio_mark_accessed(folio);
>>> +        /*
>>> +         * Always record write access to the buffer. The natural
>>> +         * place would be pfn_mkwrite, but this breaks KVM.
>>> +         */
>>> +        file_update_time(vma->vm_file);
>>> +        folio_mark_dirty(folio);
>> We can be a bit smarter here:
>>
>>         /*
>>          * Always record write access to the buffer if the
>>          * mapping is writeable. The natural place would be
>>          * pfn_mkwrite, but this breaks KVM.
>>          */
>>         if (vma->vm_flags & VM_WRITE) {
>>             file_update_time(vma->vm_file);
>>             folio_mark_dirty(folio);
>>         }
>>
>>> +    }
>> The rest looks good to me.
>>
>> Regards,
>>
>> Boris
>
