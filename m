Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B9606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYChi+4k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A83D10E726;
	Wed,  4 Nov 2026 06:18:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E93F10E74A;
 Wed,  4 Nov 2026 06:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 141F043D24;
 Wed,  4 Nov 2026 06:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E291F000C1;
 Wed,  4 Nov 2026 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793773082;
 bh=S8y7cTuBO2nGxah0EkWIQO+43F6dKUkL2mO0afocqdc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MYChi+4kSNQyb0Dv8bofQzrWRY1IsnkIsuEed8+13wxnWdQ9H7thJE73rcgbhc7NO
 4LSvE8zDi/hP/1MSGbe0EkHLSfe8b/AAreWImcaVwlyDL2PPe4wHodmzlJfLVgaet9
 EKYAUZMTl+Uw07pbzmHfLEOhQzUSLkd70B5xel9BSJUZza/exEBvJotPyLsk+9yHoF
 EV4bouwqVvlJeDLH6TzqFe/R+ybbSQX6B7yYyhg2etSqG0rrjnqL6ymXr20E3v4tnG
 r8Hi7f2lRrHw20wJeM20Hiy3nkea9aT8syVpAM1tSwS3nIoBN4/HGBg+M+sQQuhD2y
 ZkWu/n7akZD5A==
Message-ID: <sashiko-outbox-196744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/12] mm/hmm: migrate collection in HMM pagewalk -
 pmd level
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "David
 Hildenbrand" <david@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Zi Yan" <ziy@nvidia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Lyude Paul" <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20261103061629.972669-7-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <20261103061629.972669-7-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:18:00 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] mm/hmm: missing folio_test_anon() check in hmm_vma_handle_migrate_=
prepare_pmd()
- [High] mm/hmm: missing device-coherent checks in hmm_vma_handle_migrate_p=
repare_pmd()
- [High] mm/hmm: ABBA folio lock deadlock in migrate_vma_split_folio()
- [Medium] mm/hmm: PMD split in hmm_vma_handle_migrate_prepare_pmd() aborts=
 notifier walk
--

commit 2ed090a278a29feb7fac7d83140b748506dedc9e
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pmd level

This commit implements hmm_vma_handle_migrate_prepare_pmd() to collect
PMD-mapped THPs or split them into PTEs during HMM pagewalk migration, and
factors out __migrate_vma_split_folio() for splitting folios.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index ec9280ef26822..cbde004fd778a 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -511,9 +537,7 @@ static int migrate_vma_split_folio(struct folio *foli=
o,
>  				   struct hmm_vma_walk *hmm_vma_walk,
>  				   pte_t *ptep)
>  {
> -	int ret;
>  	struct folio *fault_folio =3D fault_page ? page_folio(fault_page) : NUL=
L;
> -	struct folio *new_fault_folio =3D NULL;
> =20
>  	/*
>  	 * Take the reference while still holding the PTE lock, so the folio
> @@ -530,44 +554,136 @@ static int migrate_vma_split_folio(struct folio *f=
olio,
>  	if (folio !=3D fault_folio)
>  		folio_lock(folio);
> =20
> -	ret =3D split_folio(folio);
> -	if (ret) {
> -		if (folio !=3D fault_folio) {
> +	return __migrate_vma_split_folio(folio, fault_page);
> +}

[Severity: High]
Can calling folio_lock(folio) in migrate_vma_split_folio() cause an ABBA
deadlock when another folio is already held locked in the walk?

During a migrating hmm_range_fault() walk, the calling thread already holds
folio locks on fault_folio (when called from do_swap_page() ->
migrate_to_ram()) as well as on any folios collected at earlier addresses
in the range via hmm_vma_handle_migrate_prepare_pmd() or
hmm_vma_handle_migrate_prepare().

While normal collection in hmm_vma_handle_migrate_prepare() and
hmm_vma_handle_migrate_prepare_pmd() uses folio_trylock() to avoid deadlock=
ing
against concurrent migrations or faults, migrate_vma_split_folio() drops the
PTE lock and sleeps unconditionally in folio_lock(folio):

  Thread 1                              Thread 2
  holds folio A locked
    (fault_folio or earlier entry)      holds folio B locked
  hmm_vma_handle_migrate_prepare()
    migrate_vma_split_folio(folio B)
      folio_lock(folio B)               migrate_vma_split_folio(folio A)
                                          folio_lock(folio A)
                                          (or migration_entry_wait(folio A))

Should migrate_vma_split_folio() also use folio_trylock(folio) and skip
migrating the folio if it cannot be locked?

> +
> +static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
> +					      pmd_t *pmdp,
> +					      unsigned long start,
> +					      unsigned long end,
> +					      unsigned long *hmm_pfn)
> +{
> +	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct migrate_vma *migrate =3D range->migrate;
> +	struct folio *fault_folio =3D NULL;
> +	enum migrate_vma_info minfo;
> +	struct folio *folio;
> +	unsigned long i;
> +	int r =3D 0;
> +
> +	// Do we want to migrate at all?
> +	minfo =3D hmm_select_migrate(range);
> +	if (!minfo)
> +		return r;
> +
> +	WARN_ON_ONCE(!migrate);
> +	HMM_ASSERT_PMD_LOCKED(hmm_vma_walk, true);
> +
> +	fault_folio =3D migrate->fault_page ?
> +		page_folio(migrate->fault_page) : NULL;
> +
> +	if (pmd_none(*pmdp))
> +		return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
> +
> +	/* Like at the pte level, NUMA hinting (protnone) pmds are migrated */
> +	if (!(hmm_pfn[0] & HMM_PFN_VALID) &&
> +	    !(pmd_trans_huge(*pmdp) && pmd_protnone(*pmdp)))
> +		goto out;
> +
> +	if (pmd_trans_huge(*pmdp)) {
> +		if (!(minfo & MIGRATE_VMA_SELECT_SYSTEM))
> +			goto out;

[Severity: High]
How are PMD-mapped MEMORY_DEVICE_COHERENT folios handled here?

Compound device-coherent folios are mapped as present huge PMDs where
pmd_trans_huge(*pmdp) is true (via migrate_vma_insert_huge_pmd_page() and
remove_migration_pmd()). At the PTE level, hmm_vma_handle_migrate_prepare()
distinguishes system memory from device-coherent pages:

mm/hmm.c:hmm_vma_handle_migrate_prepare() {
    ...
		page =3D vm_normal_page(walk->vma, addr, pte);
		if (page && !is_zone_device_page(page) &&
		    !(minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
			goto out;
		} else if (page && is_device_coherent_page(page)) {
			pgmap =3D page_pgmap(page);

			if (!(minfo &
			      MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
			    pgmap->owner !=3D migrate->pgmap_owner)
				goto out;
		}
    ...
}

In hmm_vma_handle_migrate_prepare_pmd(), requiring MIGRATE_VMA_SELECT_SYSTEM
for all pmd_trans_huge(*pmdp) entries without checking
folio_is_zone_device(folio), folio_is_device_coherent(folio),
MIGRATE_VMA_SELECT_DEVICE_COHERENT, or folio->pgmap->owner means that
migrating device-coherent memory to system RAM with
MIGRATE_VMA_SELECT_DEVICE_COHERENT skips present device-coherent huge PMDs,
while migrating with MIGRATE_VMA_SELECT_SYSTEM collects or splits
device-coherent huge PMDs regardless of pgmap->owner.

Does the pmd_trans_huge(*pmdp) branch need the same zone_device and
device_coherent checks as hmm_vma_handle_migrate_prepare()?

> +
> +		folio =3D pmd_folio(*pmdp);
> +		if (is_huge_zero_folio(folio))
> +			return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
> +
> +	} else if (!pmd_present(*pmdp)) {

[Severity: High]
Should hmm_vma_handle_migrate_prepare_pmd() check folio_test_anon(folio)
before collecting or splitting a PMD-mapped folio?

At the PTE level, hmm_vma_handle_migrate_prepare() rejects non-anonymous
folios:

mm/hmm.c:hmm_vma_handle_migrate_prepare() {
    ...
	/* Only anonymous memory can be migrated to device memory */
	if (!page || !folio_test_anon(page_folio(page)))
		goto out;
    ...
}

Because hmm_vma_capture_migrate_range() and migrate_vma_setup() allow file =
and
shmem VMAs, a PMD in such a VMA can map a non-anonymous THP. Without a
folio_test_anon(folio) check in hmm_vma_handle_migrate_prepare_pmd():

1. If compound migration is selected, the page-cache folio is locked and a =
PMD
   migration entry is installed with HMM_PFN_MIGRATE | HMM_PFN_COMPOUND.
   Holding a page-cache folio locked while hmm_do_fault() -> handle_mm_faul=
t()
   faults subsequent pages in the VMA inverts the mapping->invalidate_lock =
->
   folio_lock ordering. If the caller later splits the unmapped compound
   folio in __migrate_device_pages() -> migrate_vma_split_unmapped_folio(),
   split_huge_pmd_address() zaps the non-anonymous PMD without dropping the
   extra folio reference, and folio_split_unmapped() triggers
   VM_WARN_ON_ONCE_FOLIO(!folio_test_anon(folio), folio) before running
   __folio_freeze_split_anon() on a page-cache folio:

mm/huge_memory.c:folio_split_unmapped() {
	VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
	VM_WARN_ON_ONCE_FOLIO(!folio_test_anon(folio), folio);

	return __folio_freeze_split_anon(folio, new_order, &folio->page,
					 false, NULL, SPLIT_TYPE_UNIFORM);
}

2. If the split fallback is taken, __migrate_vma_split_folio() ->
   split_folio() -> __folio_freeze_split_file() acquires
   i_mmap_lock_read(mapping) while holding locks on previously collected
   folios and unmaps the file folio completely via unmap_folio(). If the
   split fails after unmapping, hmm_vma_handle_migrate_prepare_pmd() return=
s 0
   with stale HMM_PFN_VALID entries for a zapped PMD; if it succeeds, the
   re-walk finds pte_none entries and loses the valid PFNs when
   HMM_PFN_REQ_FAULT is not set.

[ ... ]

> +split:
> +	spin_unlock(hmm_vma_walk->ptl);
> +	hmm_vma_walk->pmdlocked =3D false;
> =20
>  	/*
> -	 * Ensure the lock is held on the correct
> -	 * folio after the split
> +	 * folio_get() above took an extra reference. For the fault folio the
> +	 * caller still holds a reference and the lock, which is the
> +	 * precondition of __migrate_vma_split_folio(), so drop the extra one.
>  	 */
> -	if (!new_fault_folio) {
> -		folio_unlock(folio);
> +	if (folio =3D=3D fault_folio)
>  		folio_put(folio);
> -	} else if (folio !=3D new_fault_folio) {
> -		if (new_fault_folio !=3D fault_folio) {
> -			folio_get(new_fault_folio);
> -			folio_lock(new_fault_folio);
> -		}
> -		folio_unlock(folio);
> -		folio_put(folio);
> -	}
> =20
> -	return 0;
> -}
> +	/* Split failed: not migrated, the valid pfns stay as reported */
> +	if (__migrate_vma_split_folio(folio, migrate->fault_page))
> +		return 0;
> =20
> -static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
> -					      pmd_t *pmdp,
> -					      unsigned long start,
> -					      unsigned long end,
> -					      unsigned long *hmm_pfn)
> -{
> -	// TODO: implement migration entry insertion
> -	return 0;
> +	/* Re-walked as PTEs from start: drop the pmd-level output */
> +	for (i =3D 0; i < (end - start) >> PAGE_SHIFT; i++)
> +		hmm_pfn[i] &=3D HMM_PFN_INOUT_FLAGS;
> +
> +	hmm_vma_walk->last =3D start;
> +	return -EBUSY;
>  }
> =20
>  /*
> @@ -1016,6 +1132,11 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  			hmm_vma_walk->pmdlocked =3D false;
>  		}
> =20
> +		/*
> +		 * hmm_vma_handle_migrate_prepare_pmd() splits the huge pmd in
> +		 * place when needed and returns -EBUSY to re-walk the range as
> +		 * PTEs.
> +		 */
>  		return r;
>  	}

[Severity: Medium]
When range->notifier is set during a migrating hmm_range_fault() call, does
returning -EBUSY out of walk_page_range() after splitting a PMD cause
hmm_range_fault_locked() to abort the walk instead of re-walking the split
PMD as PTEs?

In hmm_vma_handle_migrate_prepare_pmd(), __migrate_vma_split_folio() calls
split_folio() or split_huge_page() -> __folio_split() ->
__folio_freeze_split_anon() -> unmap_folio() -> try_to_migrate_one(), which
invokes mmu_notifier_invalidate_range_start() with MMU_NOTIFY_CLEAR and
range.owner =3D=3D NULL. Because the event is MMU_NOTIFY_CLEAR rather than
MMU_NOTIFY_MIGRATE with range->dev_private_owner, the registered
mmu_interval_notifier updates range->notifier->invalidate_seq.

When hmm_vma_handle_migrate_prepare_pmd() and hmm_vma_walk_pmd() return
-EBUSY back to hmm_range_fault_locked(), the next iteration of the loop che=
cks
mmu_interval_check_retry():

mm/hmm.c:hmm_range_fault_locked() {
    ...
	do {
		/* If range is no longer valid force retry. */
		if (range->notifier && mmu_interval_check_retry(range->notifier,
								range->notifier_seq)) {
			ret =3D  -EBUSY;
			break;
		}
		ret =3D walk_page_range(mm, hmm_vma_walk.last, range->end,
				      &hmm_walk_ops, &hmm_vma_walk);
    ...
}

Because range->notifier was invalidated by the split,
mmu_interval_check_retry() returns true and hmm_range_fault_locked() breaks
out with -EBUSY, forcing a full rollback and retry of the range. By contras=
t,
the PTE-level split in hmm_vma_handle_migrate_prepare() returns -EAGAIN and
restarts locally at the again label inside hmm_vma_walk_pmd() without
returning to hmm_range_fault_locked().

Could hmm_vma_walk_pmd() similarly loop locally to the again label when
hmm_vma_handle_migrate_prepare_pmd() splits the PMD?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061629.9726=
69-1-mpenttil@redhat.com?part=3D6
