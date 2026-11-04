Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8D606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOiqqcL6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635BF10E7FB;
	Wed,  4 Nov 2026 06:18:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9749010E726;
 Wed,  4 Nov 2026 06:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8035243CBF;
 Wed,  4 Nov 2026 06:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F0E1F000C1;
 Wed,  4 Nov 2026 06:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793773083;
 bh=nzaeub9u1nKaKfD0WJgHHnPdTNDe5eQthOF5KFonLqw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cOiqqcL6J540P5mYaQb3I5GFzxzx+iS0tQcOXe4Bl50LAbWsSpwzMnOhFixzVf28+
 CndUjTyzPA4GRd04x8pi+ElIh39sd5qHqhyntcBTIzNpkft93J9rfgF9FN5e2W8dE8
 KtuwyEaIgU82gPjamFUpCs84Ia/ChdWBr5MhouoEdlBIpH4UcXNnZBUZ+5hwp5c6Cp
 w7IZ7HL+nT+kFw3alumBxlH6QkIkAPuWmngh/QRgw8qTKwcN0adYogZ3Y1/h65CqzF
 BExT+CXdrIcSxaDOFXPVdl0r5FqknHWu3qg7Nu+9I5p/JwBtjjNyi5ELREqo5Y6JKG
 rF7uOhVBHxHqQ==
Message-ID: <sashiko-outbox-196746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 08/12] mm/hmm: implement rollback for device page
 migration in HMM pagewalk
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
In-Reply-To: <20261103061629.972669-9-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <20261103061629.972669-9-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:18:02 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm/hmm: missing rollback of prior entries when restarting after fa=
ult
- [High] mm/hmm: missing rollback and incomplete walk on folio split failure
- [High] mm/hmm: self-deadlock on -EBUSY retry due to memset() of hmm_pfns
--

commit 57b87c4290e06aea8db775c69fa86c746acfe43d
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: implement rollback for device page migration in HMM pagewalk

This commit adds rollback handling to unlock and unreference already
collected folios if page tables vanish or change while page table locks are
dropped during a migration pagewalk. It also skips migration PTEs installed
earlier in the same walk when restarting a PMD walk.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 690b73908f34e..1c8a3fa29c4e6 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -331,6 +344,15 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>  	if (!pte_present(pte)) {
>  		const softleaf_t entry =3D softleaf_from_pte(pte);
> =20
> +		/*
> +		 * Our own migration entry, collected earlier in this walk:
> +		 * keep the collected pfn, don't fault or roll it back.
> +		 */
> +		if (softleaf_is_migration(entry) && hmm_select_migrate(range) &&
> +		    hmm_pfn_collected(*hmm_pfn) &&
> +		    hmm_pfn_to_page(*hmm_pfn) =3D=3D softleaf_to_page(entry))
> +			return 0;

[Severity: High]
When hmm_range_fault_locked() aborts with -EBUSY (or a caller retries
hmm_range_fault() after mmu_interval_read_retry() trips) after collecting
earlier pages in the range, those folios remain locked, referenced, and
mapped as migration PTEs.

When the caller retries hmm_range_fault() with the same range and hmm_pfns
array, hmm_range_fault_locked() zeroes range->hmm_pfns:

mm/hmm.c:hmm_range_fault_locked() {
    ...
	if (hmm_select_migrate(range)) {
		WARN_ON_ONCE(range->pfn_flags_mask);
		WARN_ON_ONCE(range->dev_private_owner !=3D
			     range->migrate->pgmap_owner);
		memset(range->hmm_pfns, 0,
		       ((range->end - range->start) >> PAGE_SHIFT) *
		       sizeof(*range->hmm_pfns));
	}
    ...
}

On the retry walk, hmm_pfn_collected(*hmm_pfn) evaluates to false for the
migration PTEs installed by the current thread on the previous attempt. Does
this cause hmm_vma_handle_pte() and hmm_vma_walk_pmd() to treat our own
migration entries as belonging to another thread and call
hmm_do_fault()->handle_mm_fault()->migration_entry_wait() on folios already
locked by current, resulting in a self-deadlock?

> +
>  		/*
>  		 * Don't fault in device private pages owned by the caller,
>  		 * just report the PFN.
> @@ -416,6 +438,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, u=
nsigned long addr,
> =20
>  	new_pfn_flags =3D pte_pfn(pte) | cpu_flags;
>  out:
> +	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
> +						addr + PAGE_SIZE,
> +						hmm_pfn);
>  	*hmm_pfn =3D (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
>  	return 0;
> =20
> @@ -427,7 +452,19 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, =
unsigned long addr,
>  	} else {
>  		pte_unmap(ptep);
>  	}
> -	/* Fault any virtual address we were asked to fault */
> +	/*
> +	 * This pte needs a fault, so it is not our migration entry: a pfn
> +	 * collected here earlier is gone, roll it back before faulting.
> +	 */
> +	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
> +						addr + PAGE_SIZE, hmm_pfn);
> +	/*
> +	 * Fault any virtual address we were asked to fault. When migrating,
> +	 * only this page: later ptes may be our own migration entries or
> +	 * caller owned device private pages, which must not be faulted.
> +	 */
> +	if (hmm_select_migrate(range))
> +		end =3D addr + PAGE_SIZE;
>  	return hmm_record_fault(addr, end, required_fault, walk);
>  }

[Severity: High]
As reported by Sashiko on v16 [1], when a PTE fault occurs at addr after
earlier PTEs at addresses below addr have already been collected by
hmm_vma_handle_migrate_prepare(), the fault path drops hmm_vma_walk->ptl,
rolls back only [addr, addr + PAGE_SIZE), and calls hmm_record_fault(),
which sets hmm_vma_walk->last =3D addr and returns HMM_FAULT_PENDING.

In hmm_range_fault_locked(), HMM_FAULT_PENDING disarms the migration
invalidation range via hmm_vma_migrate_disarm() and runs hmm_do_fault()
without holding any page table spinlock, then resumes walk_page_range() at
hmm_vma_walk.last:

mm/hmm.c:hmm_range_fault_locked() {
    ...
		ret =3D walk_page_range(mm, hmm_vma_walk.last, range->end,
				      &hmm_walk_ops, &hmm_vma_walk);
		if (ret =3D=3D HMM_FAULT_PENDING) {
			hmm_vma_migrate_disarm(&hmm_vma_walk);
			ret =3D hmm_do_fault(mm, &hmm_vma_walk);
    ...
}

Because walk_page_range() restarts at addr rather than range->start,
hmm_vma_walk_pmd() is invoked with start =3D addr (and any earlier PMDs in
[range->start, addr) are skipped completely).

If the migration PTEs or PTE page table covering [range->start, addr) were
zapped or replaced while locks were dropped during hmm_do_fault(), can those
earlier collected entries in range->hmm_pfns ever be revisited or rolled
back, or will they leak folio locks and references?

[ ... ]

> @@ -1192,6 +1311,12 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  				flush_tlb_range(walk->vma, start, addr);
>  				unmapped =3D false;
>  			}
> +			/*
> +			 * The pte lock was dropped and the pte table may have
> +			 * changed: re-walk from start. Our own migration entries
> +			 * are kept, anything else collected is rolled back.
> +			 */
> +			addr =3D start;
>  			goto again;
>  		}
>  		if (r) {

[Severity: High]
When hmm_vma_handle_migrate_prepare() attempts to split a large folio via
migrate_vma_split_folio(), it unconditionally drops hmm_vma_walk->ptl and
sleeps on folio_lock() before calling __migrate_vma_split_folio():

mm/hmm.c:migrate_vma_split_folio() {
    ...
	lazy_mmu_mode_disable();
	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
	hmm_vma_walk->ptelocked =3D false;

	if (folio !=3D fault_folio)
		folio_lock(folio);

	return __migrate_vma_split_folio(folio, fault_page);
}

If __migrate_vma_split_folio() fails, hmm_vma_handle_migrate_prepare()
returns -EFAULT, and the if (r) branch in hmm_vma_walk_pmd() flushes the TLB
and returns 0 immediately:

mm/hmm.c:hmm_vma_walk_pmd() {
    ...
		if (r) {
			/*
			 * Splitting the folio failed; migrate_vma_split_folio()
			 * already dropped the PTE lock. Don't migrate the rest
			 * of the pmd range; addr keeps its valid pfn.
			 */
			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
			if (unmapped)
				flush_tlb_range(walk->vma, start, addr);
			return 0;
		}
    ...
}

Since the PTE lock was dropped while waiting on folio_lock(), if migration
PTEs or the PTE table in [start, end) vanished during that window, won't
returning 0 without re-walking [start, end) skip rolling back those
collected folios, and also leave range->hmm_pfns unpopulated for the
remaining addresses in [addr + PAGE_SIZE, end)?

[1] https://lore.kernel.org/r/20261021060506.2377545-9-mpenttil@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061629.9726=
69-1-mpenttil@redhat.com?part=3D8
