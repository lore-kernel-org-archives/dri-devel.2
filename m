Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED373C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2551310E699;
	Mon, 27 Jul 2026 17:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7Osxeg6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2F810E4C3;
 Mon, 27 Jul 2026 17:33:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8829E60A5E;
 Mon, 27 Jul 2026 17:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC6B1F00A3D;
 Mon, 27 Jul 2026 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785173629;
 bh=0LfB6KuoOFNXsiQAfPS12DYpgKOAtCt559kAcXuey7E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=B7Osxeg6cU6rWMDCBt5m4Ddp66YpGYzEEIpZ4639Tj2PNrdAKhSRq2eZiaUAlqXvE
 Q/EhAc8WS4ZjI5VieaC0YJ1QJ22hFGylK22IjGl3JNF+hDv3zoeDaRjnpU/di+97KG
 agcBP6aL6YD5aQY+BCl9O7+eWhQXODKOof9ozN+L7pVAyv1QZ5gmyhEIHzkc1pYFKt
 CQj8PLuYNQrRaNd8syLSSHJ8z4s2CQCTT+zDXT0+LLFCTWS7Y+nxTCnN6h5WbtxhAO
 rSpkJs6tjPKdc2pe2j3Ph4+O9TYC+woqtoXQC3xD+/V11M82Iqlud8Qm5XyDlt5po4
 j1F2beXRjfigg==
Message-ID: <a0c06d8c-fc3a-4ede-8aba-8c7430027a35@kernel.org>
Date: Mon, 27 Jul 2026 19:33:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/huge_memory: add folio_split_driver_managed()
To: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Dave Airlie
 <airlied@redhat.com>, Matthew Wilcox <willy@infradead.org>
References: <20260722044220.1110278-1-matthew.brost@intel.com>
 <DK564OOZ3JUK.292JORO9KGKEV@nvidia.com>
 <DK57FVTRTLR2.1A906PYJ2TCE4@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <DK57FVTRTLR2.1A906PYJ2TCE4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
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

On 7/22/26 17:28, Zi Yan wrote:
> On Wed Jul 22, 2026 at 10:26 AM EDT, Zi Yan wrote:
>> On Wed Jul 22, 2026 at 12:42 AM EDT, Matthew Brost wrote:
>>> Add a lightweight structural split primitive for large (compound) folios
>>> that a driver allocated with __GFP_COMP and manages entirely by itself,
>>> outside of the core mm's view.
>>>
>>> The existing split paths - split_folio() and folio_split_unmapped() -
>>> are built for folios that the mm owns: they perform a refcount freeze,
>>> walk and remap the rmap, and take the anon_vma / i_mmap locks, and
>>> folio_split_unmapped() further assumes an anon, pagecache-style refcount
>>> model (nr_pages + 1). None of that applies to a folio that is:
>>>
>>>   - singly referenced (the caller holds the only reference),
>>>   - not mapped through the rmap (folio_mapped() == 0),
>>>   - not in the page cache or swap cache (folio->mapping == NULL),
>>>   - not on any LRU or the deferred-split list.
>>>
>>> For such a folio the split is purely structural: because nothing else in
>>> the kernel can reach it, there is no need to freeze the refcount or touch
>>> any mapping. folio_split_driver_managed() therefore performs only the
>>
>> I do not think so. PFN scanners like memory compaction should be able to
>> see them, unless you mean something else about "a driver allocated with
>> __GFP_COMP". You will need to freeze it to prevent the to-be-split
>> folios being touched by others.
>>
>>
>>> compound and split-accounting teardown via __split_unmapped_folio() and
>>> then hands each resulting order-@new_order folio its own reference,
>>> mirroring split_page() for compound folios. The caller keeps the original
>>> reference on the first resulting folio and is responsible for freeing all
>>> of them individually.
>>>
>>> The immediate user is TTM's GPU page pool, which allocates higher-order
>>> compound pages, maps them into userspace via VM_PFNMAP (never through the
>>> rmap), and needs to split them into order-0 folios under memory pressure
>>> so pages can be backed up to shmem and freed one at a time.
>>>
>>> A CONFIG_TRANSPARENT_HUGEPAGE=n stub is provided so callers can build
>>> without the split machinery; it warns and returns -EINVAL.
>>>
>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>>> Cc: Maxime Ripard <mripard@kernel.org>
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: David Airlie <airlied@gmail.com>
>>> Cc: Simona Vetter <simona@ffwll.ch>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Huang Rui <ray.huang@amd.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: "Liam R. Howlett" <liam@infradead.org>
>>> Cc: Nico Pache <npache@redhat.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: Barry Song <baohua@kernel.org>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Dave Airlie <airlied@redhat.com>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>> Assisted-by: GitHub-Copilot:claude-opus-4.8
>>>
>>> ---
>>>
>>> The patch is based on drm-tip rather than the core MM branches to
>>> facilitate Intel CI testing and initial review. It can be rebased onto
>>> the core MM branches in a subsequent revision.
>>> ---
>>>  include/linux/huge_mm.h |  8 ++++++
>>>  mm/huge_memory.c        | 63 +++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 71 insertions(+)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index ad20f7f8c179..35661d82d54a 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -402,6 +402,7 @@ enum split_type {
>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>  		unsigned int new_order);
>>>  int folio_split_unmapped(struct folio *folio, unsigned int new_order);
>>> +int folio_split_driver_managed(struct folio *folio, unsigned int new_order);
>>>  unsigned int min_order_for_split(struct folio *folio);
>>>  int split_folio_to_list(struct folio *folio, struct list_head *list);
>>>  int folio_check_splittable(struct folio *folio, unsigned int new_order,
>>> @@ -656,6 +657,13 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
>>>  	return -EINVAL;
>>>  }
>>>  
>>> +static inline int folio_split_driver_managed(struct folio *folio,
>>> +					     unsigned int new_order)
>>> +{
>>> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
>>> +	return -EINVAL;
>>> +}
>>> +
>>>  static inline int folio_split(struct folio *folio, unsigned int new_order,
>>>  		struct page *page, struct list_head *list)
>>>  {
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2bccb0a53a0a..06f9a5f35df8 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -4185,6 +4185,69 @@ int folio_split_unmapped(struct folio *folio, unsigned int new_order)
>>>  	return ret;
>>>  }
>>>  
>>> +/**
>>> + * folio_split_driver_managed() - split an exclusively-owned, off-LRU folio
>>> + * @folio: folio to split. Must be a large (compound) folio that is owned
>>> + *         exclusively by the caller and is invisible to the core mm.
>>> + * @new_order: the order of the folios after the split.
>>> + *
>>> + * This is a lightweight structural split for folios that a driver allocated
>>> + * and manages itself (for example TTM's GPU page pool, which allocates
>>> + * higher-order compound pages with __GFP_COMP and maps them into userspace
>>> + * via VM_PFNMAP rather than through the rmap). Such folios are:
> 
> Strickly speaking, these vm_insert*() compound pages are not folios,
> since folios are supposed to be rmappable and they are either anonymous
> memory or file-backed memory. I am working on separating them from
> rmappable folios by replacing PG_private with PG_folio and marking all
> pages in a folio with PG_folio in page_rmappable_folio().
> 
> Hopefully, we can find a better name, like refcounted_folio, later for
> these non-rmappable compound pages.

They wouldn't really be folios, I guess. They would likely be a simple
"refcounted" memtype that allows for compound pages.

But what is the conclusion here? It sounds like "folio_split_" is the entirely
wrong interface for these compound pages.

-- 
Cheers,

David
