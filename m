Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47151606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ccocfVA4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DD210F9C6;
	Wed, 21 Oct 2026 07:09:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA21D10F9BC
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792566569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsBG8HpW85VGH4TsI9kJ5JFOjaqz4u5SyPuzO7nucOA=;
 b=ccocfVA48G9Ef+uPIfGftmoReU3YvwHno/QNLQz4nwZHIpU1QkJ/+1JrnNGKuSf3Mebv0i
 A76ffPy+yKRBTfCPapbADoVX46tkLAzURFsIFI9NdJupzueBOuwPVS25JXCIdZnL2i7bC8
 UW5NmYkg5/LTi7HoXW4Qk9SVFdhLbWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-_3dOB8yDOT6_gdElnISxmQ-1; Wed, 21 Oct 2026 07:09:28 +0000
X-MC-Unique: _3dOB8yDOT6_gdElnISxmQ-1
X-Mimecast-MFC-AGG-ID: _3dOB8yDOT6_gdElnISxmQ_1792566567
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c430f0f01so285451f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 00:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792566567; x=1793171367;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zsBG8HpW85VGH4TsI9kJ5JFOjaqz4u5SyPuzO7nucOA=;
 b=brz2qhVXglm2qs1z4eaLxkYl+Y82oZLszlW3pTY3jzMSEPYEHx/lfx93nTEb+jUQgb
 b28Ur9K1Mq0eKVSfbHimrS4ZVYtgBc5lHXFD6z5ztjfSXlNfjZ4ngZ9FRd+mh4q6Hs8G
 8eLfJcXltYeFcxarUgCs1bnFg+nVF1+dLBNBViyysKC9dN9dkcIZ8n7xvHYN5olQ082T
 fiA4hngvV/ekuY/a+SnbEzdLBtFigaB3aFWSB2n8zA3prCaSsoBGDKbs3XGzQY7QTojG
 muY43H7DW6v1GO7pV6na1jy0rDQ6aVVUsLjhgfloHVT703rs54G9+3XjBs8AJ0Mbe9Me
 80Ig==
X-Gm-Message-State: AFq9FYK4FDluAOFxIv5q7+gSjAMkpDUw9U2lolvqdSiy1GwYIlp+V6BW
 xNMr6EtO+Pd9pJjWo9pOzXHiygWGqTANErn3ONG86obPdwN0enRuF+UWz1ZSh9H/zarNk855qWA
 EBnrhqc+UR+EiwxGAPF49Z15F8MjqKWg41iuqOjNJ74SHM+mnoxAFMDrB1H/RBkaLySDq
X-Gm-Gg: AYBFou219AGWxKFm0Zu+e66/1mIPhsuQO9bPfA2pSWOhwQP1ns4SCWhg+5/UpLuwEko
 n7N6DPkAWINqgqr4sepZi7Xin/TmYLbj0MGgHbX/QkxGpoRrXaudOE+r2fJg1Cvxag9VF45mPWI
 BAlzcrusDqpIgvrsuQmhTtgJFgeiH7usaP8Ovfr+pXpH+TPp6AXZowCzXruSHElcn4+WVuEAnqO
 3zo9RWz+0MGBlBrARR/scT7o4jMWBvN1HdTWsCiiF18FtxtBJVaPE4D9yOjwg4eySihXT0hForq
 /eLEqko205q27OyXOWpxovkarK82cTDHq/ym5SCTzIvc8exh7f8eo7POjHtTqveWHh09/smUdTO
 7robAKPdmvZVjWU7Z22mOVq5ZuYlwMyo=
X-Received: by 2002:a05:6000:3106:b0:48d:f14a:9179 with SMTP id
 ffacd0b85a97d-48e264afb68mr1928939f8f.48.1792566567171; 
 Wed, 21 Oct 2026 00:09:27 -0700 (PDT)
X-Received: by 2002:a05:6000:3106:b0:48d:f14a:9179 with SMTP id
 ffacd0b85a97d-48e264afb68mr1928883f8f.48.1792566566663; 
 Wed, 21 Oct 2026 00:09:26 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25b04883sm3585158f8f.0.2026.10.21.00.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:09:25 -0700 (PDT)
Message-ID: <cd1dea21-64d7-445c-8595-448e4f283cb0@redhat.com>
Date: Wed, 21 Oct 2026 10:09:23 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/12] mm/hmm: migrate collection in HMM pagewalk -
 pte level
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-6-mpenttil@redhat.com>
 <cc42cbd1-2030-4fbb-94f6-5e92cba2431e@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <cc42cbd1-2030-4fbb-94f6-5e92cba2431e@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EtEbc-SPJy_3W5IewqngG0CLSNd3_9dUkn7WJ8JIwew_1792566567
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/21/26 09:56, Balbir Singh wrote:

> On 10/21/26 5:04 PM, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> Implement the needed hmm_vma_handle_migrate_prepare() function
>> which is mostly carried over from migrate_device.c's
>> migrate_vma_collect_pmd() function.
>>
>> Also implement the migrate_vma_split_folio(), for splitting
>> pte mapped large folios. It is also mostly from migrate_device.c,
>> with care taken to reference folio before relasing page table
>> lock.
> Typo - releasing

ack

>
>> With HMM pagewalk based migration, the idea is that
>> hmm_vma_handle_*() are responsible for faulting,
>> and the pfn collecting part. hmm_vma_handle_migrate_prepare*()
>> do the migration decisions (with HMM_PFN_MIGRATE), possibly split
>> folios, and insert migration ptes/pmds.
>>
>> HMM pagewalk based migration is enabled in later commit, for now
>> now hmm_select_migrate() returns 0.
>>
> now now -> now

thanks

>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> ---
>>  mm/hmm.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 262 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index 119e70dbca56..0ce947d0e572 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -491,6 +491,63 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
>>  #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
>>  
>>  #ifdef CONFIG_DEVICE_MIGRATION
>> +/**
>> + * migrate_vma_split_folio() - Helper function to split a THP folio
>> + * @folio: the folio to split
>> + * @fault_page: struct page associated with the fault if any
>> + * @hmm_vma_walk: walk in progress
>> + * @ptep: pte_t * for unmap and unlock ptl
>> + *
>> + * Returns 0 on success
> and drops the pte_lock associated with the pte

agreed

>
>> + */
>> +static int migrate_vma_split_folio(struct folio *folio,
>> +				   struct page *fault_page,
>> +				   struct hmm_vma_walk *hmm_vma_walk,
>> +				   pte_t *ptep)
>> +{
>> +	int ret;
>> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
>> +	struct folio *new_fault_folio = NULL;
>> +
>> +	if (folio != fault_folio)
>> +		folio_get(folio);
>> +
>> +	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
>> +	hmm_vma_walk->ptelocked = false;
>> +
>> +	if (folio != fault_folio)
>> +		folio_lock(folio);
>> +
> Could you add a comment on why the get and lock is split into separate steps
> with the pte lock dropped in between

yes will add

>> +	ret = split_folio(folio);
>> +	if (ret) {
>> +		if (folio != fault_folio) {
>> +			folio_unlock(folio);
>> +			folio_put(folio);
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
>> +
>> +	/*
>> +	 * Ensure the lock is held on the correct
>> +	 * folio after the split
>> +	 */
>> +	if (!new_fault_folio) {
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +	} else if (folio != new_fault_folio) {
>> +		if (new_fault_folio != fault_folio) {
>> +			folio_get(new_fault_folio);
>> +			folio_lock(new_fault_folio);
>> +		}
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
>>  					      pmd_t *pmdp,
>>  					      unsigned long start,
>> @@ -501,6 +558,11 @@ static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Install migration entries if migration requested, either from fault
>> + * or migrate paths.
>> + *
>> + */
>>  static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
>>  					  pmd_t *pmdp,
>>  					  pte_t *ptep,
>> @@ -508,8 +570,207 @@ static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
>>  					  unsigned long *hmm_pfn,
>>  					  bool *unmapped)
>>  {
>> -	// TODO: implement migration entry insertion
>> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>> +	struct hmm_range *range = hmm_vma_walk->range;
>> +	struct migrate_vma *migrate = range->migrate;
>> +	struct mm_struct *mm = walk->vma->vm_mm;
>> +	struct folio *fault_folio = NULL;
>> +	enum migrate_vma_info minfo;
>> +	struct dev_pagemap *pgmap;
>> +	bool anon_exclusive;
>> +	struct folio *folio;
>> +	unsigned long pfn;
>> +	struct page *page;
>> +	softleaf_t entry;
>> +	pte_t pte, swp_pte;
>> +	bool writable = false;
>> +
>> +	// Do we want to migrate at all?
>> +	minfo = hmm_select_migrate(range);
>> +	if (!minfo)
>> +		return 0;
>> +
>> +	WARN_ON_ONCE(!migrate);
>> +	HMM_ASSERT_PTE_LOCKED(hmm_vma_walk, true);
>> +
>> +	fault_folio = migrate->fault_page ?
>> +		page_folio(migrate->fault_page) : NULL;
>> +
>> +	pte = ptep_get(ptep);
>> +
>> +	if (pte_none(pte)) {
>> +		if (vma_is_anonymous(walk->vma)) {
>> +			*hmm_pfn &= HMM_PFN_INOUT_FLAGS;
>> +			*hmm_pfn |= HMM_PFN_MIGRATE;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	if (!(hmm_pfn[0] & HMM_PFN_VALID))
>> +		goto out;
>> +
> We use *hmm_pfn and then hmm_pfn[0], could we be consistent. Based on this I
> assuming that there is just one entry in hmm_pfn?

yes

>
>> +	if (!pte_present(pte)) {
>> +		/*
>> +		 * Only care about unaddressable device page special
>> +		 * page table entry. Other special swap entries are not
>> +		 * migratable, and we ignore regular swapped page.
>> +		 */
>> +		entry = softleaf_from_pte(pte);
>> +		if (!softleaf_is_device_private(entry))
>> +			goto out;
>> +
>> +		if (!(minfo & MIGRATE_VMA_SELECT_DEVICE_PRIVATE))
>> +			goto out;
>> +
>> +		page = softleaf_to_page(entry);
>> +		folio = page_folio(page);
>> +		if (folio->pgmap->owner != migrate->pgmap_owner)
>> +			goto out;
>> +
>> +		if (folio_test_large(folio)) {
>> +			int ret;
>> +
>> +			ret = migrate_vma_split_folio(folio,
>> +						      migrate->fault_page,
>> +						      hmm_vma_walk,
>> +						      ptep);
>> +			if (ret)
>> +				goto out_error;
>> +			return -EAGAIN;
>> +		}
>> +
>> +		pfn = page_to_pfn(page);
>> +		if (softleaf_is_device_private_write(entry))
>> +			writable = true;
>> +	} else {
>> +		pfn = pte_pfn(pte);
>> +		if (is_zero_pfn(pfn) &&
>> +		    (minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
>> +			*hmm_pfn = HMM_PFN_MIGRATE;
>> +			goto out;
>> +		}
>> +		page = vm_normal_page(walk->vma, addr, pte);
>> +		if (page && !is_zone_device_page(page) &&
>> +		    !(minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
>> +			goto out;
>> +		} else if (page && is_device_coherent_page(page)) {
>> +			pgmap = page_pgmap(page);
>> +
>> +			if (!(minfo &
>> +			      MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
>> +			    pgmap->owner != migrate->pgmap_owner)
>> +				goto out;
>> +		}
>> +
>> +		folio = page ? page_folio(page) : NULL;
>> +		if (folio && folio_test_large(folio)) {
>> +			int ret;
>> +
>> +			ret = migrate_vma_split_folio(folio,
>> +						      migrate->fault_page,
>> +						      hmm_vma_walk,
>> +						      ptep);
>> +			if (ret)
>> +				goto out_error;
>> +			return -EAGAIN;
>> +		}
>> +
>> +		writable = pte_write(pte);
>> +	}
>> +
>> +	if (!page || !page->mapping)
>> +		goto out;
>> +
>> +	/*
>> +	 * By getting a reference on the folio we pin it and that blocks
>> +	 * any kind of migration. Side effect is that it "freezes" the
>> +	 * pte.
>> +	 *
>> +	 * We drop this reference after isolating the folio from the lru
>> +	 * for non device folio (device folio are not on the lru and thus
>> +	 * can't be dropped from it).
>> +	 */
>> +	folio = page_folio(page);
>> +	folio_get(folio);
>> +
>> +	/*
>> +	 * We rely on folio_trylock() to avoid deadlock between
>> +	 * concurrent migrations where each is waiting on the others
>> +	 * folio lock. If we can't immediately lock the folio we fail this
>> +	 * migration as it is only best effort anyway.
>> +	 *
>> +	 * If we can lock the folio it's safe to set up a migration entry
>> +	 * now. In the common case where the folio is mapped once in a
>> +	 * single process setting up the migration entry now is an
>> +	 * optimisation to avoid walking the rmap later with
>> +	 * try_to_migrate().
>> +	 */
>> +
>> +	if (fault_folio == folio || folio_trylock(folio)) {
>> +		anon_exclusive = folio_test_anon(folio) &&
>> +			PageAnonExclusive(page);
>> +
>> +		if (pte_present(pte))
>> +			flush_cache_page(walk->vma, addr, pfn);
>> +
>> +		if (anon_exclusive) {
>> +			pte = ptep_clear_flush(walk->vma, addr, ptep);
>> +
>> +			if (folio_try_share_anon_rmap_pte(folio, page)) {
>> +				set_pte_at(mm, addr, ptep, pte);
>> +				if (fault_folio != folio)
>> +					folio_unlock(folio);
>> +				folio_put(folio);
>> +				goto out;
>> +			}
>> +		} else {
>> +			pte = ptep_get_and_clear(mm, addr, ptep);
>> +		}
>> +
>> +		if (pte_present(pte) && pte_dirty(pte))
>> +			folio_mark_dirty(folio);
>> +
>> +		/* Setup special migration page table entry */
>> +		if (writable)
>> +			entry = make_writable_migration_entry(pfn);
>> +		else if (anon_exclusive)
>> +			entry = make_readable_exclusive_migration_entry(pfn);
>> +		else
>> +			entry = make_readable_migration_entry(pfn);
>> +
>> +		if (pte_present(pte)) {
>> +			if (pte_young(pte))
>> +				entry = make_migration_entry_young(entry);
>> +			if (pte_dirty(pte))
>> +				entry = make_migration_entry_dirty(entry);
>> +		}
>> +
>> +		swp_pte = swp_entry_to_pte(entry);
>> +		if (pte_present(pte)) {
>> +			if (pte_soft_dirty(pte))
>> +				swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> +			if (pte_uffd(pte))
>> +				swp_pte = pte_swp_mkuffd(swp_pte);
>> +		} else {
>> +			if (pte_swp_soft_dirty(pte))
>> +				swp_pte = pte_swp_mksoft_dirty(swp_pte);
>> +			if (pte_swp_uffd(pte))
>> +				swp_pte = pte_swp_mkuffd(swp_pte);
>> +		}
>> +
>> +		set_pte_at(mm, addr, ptep, swp_pte);
>> +		folio_remove_rmap_pte(folio, page, walk->vma);
>> +		folio_put(folio);
>> +		*hmm_pfn |= HMM_PFN_MIGRATE;
>> +		if (pte_present(pte))
>> +			*unmapped = true;
>> +	} else {
>> +		folio_put(folio);
>> +	}
>> +out:
>>  	return 0;
>> +out_error:
>> +	return -EFAULT;
>>  }
>>  
>>  #else
> Thanks,
> Balbir

Thanks Balbir!

