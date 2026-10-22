Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F90606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckzr4USQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B3111234B;
	Thu, 22 Oct 2026 06:06:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F81C10E19E;
 Thu, 22 Oct 2026 06:06:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF5EF41AD7;
 Thu, 22 Oct 2026 06:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C31B1F000C1;
 Thu, 22 Oct 2026 06:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792649195;
 bh=Bu3FYvdlSrhvOhlM4Mt347mn54yT2j4t/Kl7aBUly8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ckzr4USQQRTl+xZ9HzXymiivfu2eDBOMv3ZtqpdHzUdcGZ+fTB892Hj/YmaiLh1la
 iVYgGgzdd+TWgY7P7NUhbSKqRhAvthelJf0rD3jmzIvspF2NsSt3brTtaj/5dS5C6p
 LohyY+05RbWzuzwEey+5e7DQEycxwRedis/S747pXeR08TxZIVo7swd+Eq8CabJJpc
 D+YAiD4+L9AzMBAhGPHtAvwpZwrzKNbQIsbEePCCHR9j1uqRcrvFWIoWNX22E41ce0
 w2JaY29a0uVl4jnJLHM2voXZVhOaZXiQxTdenNWBOwWOjCd7aY51GXutS8VlBMqH5p
 eo4qrMLhj0WSA==
Message-ID: <sashiko-outbox-181052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/12] mm/hmm: do the plumbing for HMM to
 participate in migration
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "David
 Hildenbrand" <david@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Zi Yan" <ziy@nvidia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Lyude Paul" <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20261021060506.2377545-5-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-5-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:06:34 +0000
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
- [High] mm/hmm: broken migration entries in hmm_vma_handle_pte() and hmm_v=
ma_walk_pmd()
- [High] mm/hmm: broken state and rollback in hmm_vma_walk_pmd() on retry a=
fter -EAGAIN
- [Medium] mm/hmm: hmm_vma_walk_pmd() aborts PMD walk and clobbers PFNs on =
split failure
--

commit 25901a209351c6985ba22f8dfc40a2db03ec4bdf
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: do the plumbing for HMM to participate in migration

This commit adds page table locking state and migration preparation plumbing
to hmm_range_fault() and its pagewalk callbacks in mm/hmm.c so that PTE and
PMD locks are held across entry handling and migration collection and dropp=
ed
before faulting.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 4e9542aedc253..119e70dbca56f 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -305,14 +360,25 @@ static int hmm_vma_handle_pte(struct mm_walk *walk,=
 unsigned long addr,
>  			goto fault;
> =20
>  		if (softleaf_is_migration(entry)) {
> -			pte_unmap(ptep);
> -			hmm_vma_walk->last =3D addr;
> -			migration_entry_wait(walk->mm, pmdp, addr);
> -			return -EBUSY;
> +			if (!hmm_select_migrate(range)) {
> +				HMM_ASSERT_UNLOCKED(hmm_vma_walk);
> +				pte_unmap(ptep);
> +				hmm_vma_walk->last =3D addr;
> +				migration_entry_wait(walk->mm, pmdp, addr);
> +				return -EBUSY;
> +			}
> +			return 0;
>  		}

[Severity: High]
In include/linux/hmm.h, the input request flags share the same bit positions
as the output flags (HMM_PFN_REQ_FAULT =3D=3D HMM_PFN_VALID,
HMM_PFN_REQ_WRITE =3D=3D HMM_PFN_WRITE, HMM_PFN_REQ_MIGRATE =3D=3D HMM_PFN_=
MIGRATE),
and callers using range->default_flags with range->pfn_flags_mask =3D=3D 0 =
are
not required to initialize range->hmm_pfns[] on input.

In hmm_vma_handle_pte(), the !pte_present(pte) path evaluates
required_fault =3D hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0) first:

	required_fault =3D
		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
	if (!required_fault)
		goto out;

Because of that check, if (softleaf_is_migration(entry)) is only reached wh=
en
required_fault !=3D 0 (HMM_PFN_REQ_FAULT was requested). When
hmm_select_migrate(range) is non-zero, returning 0 directly here skips both
migration_entry_wait() (which would require unlocking hmm_vma_walk->ptl fir=
st)
and the out: label that masks *hmm_pfn to HMM_PFN_INOUT_FLAGS:

out:
	*hmm_pfn =3D (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
	return 0;

Won't returning 0 directly on a concurrent migration entry leave stale input
flags or uninitialized bits (such as HMM_PFN_REQ_FAULT / HMM_PFN_VALID and
HMM_PFN_REQ_MIGRATE / HMM_PFN_MIGRATE) in *hmm_pfn, pass a migration PTE in=
to
hmm_vma_handle_migrate_prepare(), and allow hmm_range_fault() to succeed
without waiting for the migration entry to resolve despite HMM_PFN_REQ_FAUL=
T?

Conversely, when HMM_PFN_REQ_FAULT is not set (such as the default in
migrate_vma_setup()), if (!required_fault) goto out runs before checking
softleaf_is_migration(entry). If a retry re-walks a migration PTE that was
already installed by this walk, won't jumping to out: clear *hmm_pfn (and
trigger rollback in the later patch "mm/hmm: implement rollback for device
page migration in HMM pagewalk") while leaving the migration PTE in the page
table?

[ ... ]

> @@ -468,46 +593,116 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
> -	unsigned long *hmm_pfns =3D
> -		&range->hmm_pfns[(start - range->start) >> PAGE_SHIFT];
>  	unsigned long npages =3D (end - start) >> PAGE_SHIFT;
> +	struct mm_struct *mm =3D walk->vma->vm_mm;
> +	unsigned long *hmm_pfns, *hmm_pfns_start;
> +	enum migrate_vma_info minfo;
>  	unsigned long addr =3D start;
> +	bool unmapped =3D false;
> +	unsigned long i;
>  	pte_t *ptep;
>  	pmd_t pmd;
> +	int r =3D 0;
> =20
> +	minfo =3D hmm_select_migrate(range);
> +	hmm_pfns_start =3D &range->hmm_pfns[(start - range->start) >> PAGE_SHIF=
T];
>  again:
> -	pmd =3D pmdp_get_lockless(pmdp);
> -	if (pmd_none(pmd))
> -		return hmm_vma_walk_hole(start, end, -1, walk);
> +	hmm_pfns =3D &range->hmm_pfns[(addr - range->start) >> PAGE_SHIFT];
> +	hmm_vma_walk->ptelocked =3D false;
> +	hmm_vma_walk->pmdlocked =3D false;
> +
> +	if (minfo) {
> +		hmm_vma_walk->ptl =3D pmd_lock(mm, pmdp);
> +		hmm_vma_walk->pmdlocked =3D true;
> +		pmd =3D pmdp_get(pmdp);
> +	} else
> +		pmd =3D pmdp_get_lockless(pmdp);
> +
> +	if (pmd_none(pmd)) {
> +		r =3D hmm_vma_walk_hole(start, end, -1, walk);
> +
> +		if (hmm_vma_walk->pmdlocked) {
> +			spin_unlock(hmm_vma_walk->ptl);
> +			hmm_vma_walk->pmdlocked =3D false;
> +		}
> +		return r;
> +	}
> =20
>  	if (thp_migration_supported() && pmd_is_migration_entry(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0)) {
> -			hmm_vma_walk->last =3D addr;
> -			pmd_migration_entry_wait(walk->mm, pmdp);
> -			return -EBUSY;
> +		if (!minfo) {
> +			if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns_start, npages, 0)) {
> +				hmm_vma_walk->last =3D addr;
> +				pmd_migration_entry_wait(walk->mm, pmdp);
> +				return -EBUSY;
> +			}
> +			for (i =3D 0; start < end; start +=3D PAGE_SIZE, i++)
> +				hmm_pfns_start[i] &=3D HMM_PFN_INOUT_FLAGS;
> +		}
> +
> +		if (hmm_vma_walk->pmdlocked) {
> +			spin_unlock(hmm_vma_walk->ptl);
> +			hmm_vma_walk->pmdlocked =3D false;
>  		}
> -		return hmm_pfns_fill(start, end, range, 0);
> +
> +		return 0;
>  	}

[Severity: High]
Similarly, in hmm_vma_walk_pmd(), when thp_migration_supported() &&
pmd_is_migration_entry(pmd) is true and minfo !=3D 0, both the
hmm_range_need_fault() check and the loop masking hmm_pfns_start[] to
HMM_PFN_INOUT_FLAGS are skipped by if (!minfo).

When a concurrent PMD migration entry is encountered during a migration wal=
k,
doesn't skipping that block leave hmm_pfns_start[0..npages - 1] unmasked and
uninitialized, and also fail to unlock hmm_vma_walk->ptl and wait in
pmd_migration_entry_wait() when a fault was requested? Neither this path nor
the PTE migration entry path in hmm_vma_handle_pte() appears to be updated =
in
the subsequent patches in the series.

> -	if (!pmd_present(pmd))
> -		return hmm_vma_handle_absent_pmd(walk, start, end, hmm_pfns,
> -						 pmd);
> +	if (pmd_trans_huge(pmd) || !pmd_present(pmd)) {
> +		if (!pmd_present(pmd)) {
> +			r =3D hmm_vma_handle_absent_pmd(walk, start, end, hmm_pfns_start,
> +						      pmd);
> +			// If not migrating we are done
> +			if (r || !minfo) {
> +				if (hmm_vma_walk->pmdlocked) {
> +					spin_unlock(hmm_vma_walk->ptl);
> +					hmm_vma_walk->pmdlocked =3D false;
> +				}
> +				return r;
> +			}
> +		}
> =20
> -	if (pmd_trans_huge(pmd)) {
> -		/*
> -		 * No need to take pmd_lock here, even if some other thread
> -		 * is splitting the huge pmd we will get that event through
> -		 * mmu_notifier callback.
> -		 *
> -		 * So just read pmd value and check again it's a transparent
> -		 * huge or device mapping one and compute corresponding pfn
> -		 * values.
> -		 */
> -		pmd =3D pmdp_get_lockless(pmdp);
> -		if (!pmd_trans_huge(pmd))
> -			goto again;
> +		if (pmd_trans_huge(pmd)) {
> +			/*
> +			 * No need to take pmd_lock here if not migrating,
> +			 * even if some other thread is splitting the huge
> +			 * pmd we will get that event through mmu_notifier callback.
> +			 *
> +			 * So just read pmd value and check again it's a transparent
> +			 * huge or device mapping one and compute corresponding pfn
> +			 * values.
> +			 */
> +
> +			if (!minfo) {
> +				pmd =3D pmdp_get_lockless(pmdp);
> +				if (!pmd_trans_huge(pmd))
> +					goto again;
> +			}
> =20
> -		return hmm_vma_handle_pmd(walk, addr, end, hmm_pfns, pmd);
> +			r =3D hmm_vma_handle_pmd(walk, start, end, hmm_pfns_start, pmd);
> +
> +			// If not migrating we are done
> +			if (r || !minfo) {
> +				if (hmm_vma_walk->pmdlocked) {
> +					spin_unlock(hmm_vma_walk->ptl);
> +					hmm_vma_walk->pmdlocked =3D false;
> +				}
> +				return r;
> +			}
> +		}
> +
> +		r =3D hmm_vma_handle_migrate_prepare_pmd(walk, pmdp, start, end, hmm_p=
fns_start);
> +
> +		if (hmm_vma_walk->pmdlocked) {
> +			spin_unlock(hmm_vma_walk->ptl);
> +			hmm_vma_walk->pmdlocked =3D false;
> +		}
> +
> +		return r;
> +	}
> +
> +	if (hmm_vma_walk->pmdlocked) {
> +		spin_unlock(hmm_vma_walk->ptl);
> +		hmm_vma_walk->pmdlocked =3D false;
>  	}
> =20
>  	/*
> @@ -517,24 +712,64 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	 * recover.
>  	 */
>  	if (pmd_bad(pmd)) {
> -		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
> +		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns_start, npages, 0))
>  			return -EFAULT;
> -		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
> +		return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
>  	}
> =20
> -	ptep =3D pte_offset_map(pmdp, addr);
> -	if (!ptep)
> +	if (minfo) {
> +		ptep =3D pte_offset_map_lock(mm, pmdp, addr, &hmm_vma_walk->ptl);
> +		if (ptep)
> +			hmm_vma_walk->ptelocked =3D true;
> +	} else {
> +		ptep =3D pte_offset_map(pmdp, addr);
> +	}
> +	if (!ptep) {
> +		addr =3D start;
>  		goto again;
> +	}
> +
>  	for (; addr < end; addr +=3D PAGE_SIZE, ptep++, hmm_pfns++) {
> -		int r;
> =20
>  		r =3D hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
>  		if (r) {
> -			/* hmm_vma_handle_pte() did pte_unmap() */
> +			/* hmm_vma_handle_pte() did pte_unmap() / pte_unmap_unlock */
> +			if (unmapped)
> +				flush_tlb_range(walk->vma, start, addr);
>  			return r;
>  		}
> +
> +		r =3D hmm_vma_handle_migrate_prepare(walk, pmdp, ptep, addr, hmm_pfns,=
 &unmapped);
> +		if (r =3D=3D -EAGAIN) {
> +			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
> +			if (unmapped) {
> +				flush_tlb_range(walk->vma, start, addr);
> +				unmapped =3D false;
> +			}
> +			goto again;
> +		}

[Severity: High]
When hmm_vma_handle_migrate_prepare() (populated in the later patch "mm/hmm:
migrate collection in HMM pagewalk - pte level") encounters a PTE-mapped la=
rge
folio at addr > start after order-0 pages in [start, addr) have already been
collected, migrate_vma_split_folio() drops the PTE lock and returns -EAGAIN,
jumping to again: with addr > start.

Even with the later patch "mm/hmm: implement rollback for device page
migration in HMM pagewalk", can jumping back to again: with addr > start le=
ave
stale collected state in [start, addr) or leak folio locks and references?

1. If pte_offset_map_lock() returns null (!ptep) at addr > start because the
   PTE table disappeared while the PTE lock was dropped, the rollback patch
   calls hmm_vma_handle_migrate_prepare_rollback(walk->private, addr, end,
   hmm_pfns) on the unwalked tail [addr, end) instead of rolling back the
   already-collected prefix [start, addr) at hmm_pfns_start before resetting
   addr =3D start.

2. If the PTE page table was removed or replaced while the PTE lock was
   dropped in migrate_vma_split_folio() (or after !ptep jumps to again:), t=
he
   PMD-level paths at again: do not roll back [start, addr) when
   pmd_is_migration_entry(pmd) is true (which returns 0 with [start, addr)
   still marked HMM_PFN_VALID | HMM_PFN_MIGRATE and addr still marked
   HMM_PFN_VALID from hmm_vma_handle_pte()), or when hmm_vma_walk_hole(),
   hmm_vma_handle_absent_pmd(), hmm_vma_handle_pmd(), or pmd_bad() returns
   HMM_FAULT_PENDING or -EFAULT. Likewise, if the PTE table was replaced by=
 a
   new PTE table while the lock was dropped, again: resumes at addr > start
   without rolling back or re-walking [start, addr).

> +		if (r) {
> +			/* A non -EAGAIN error here means migrate_vma_split_folio()
> +			 * already dropped the PTE lock and cleared ptelocked.
> +			 */
> +			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
> +			if (unmapped)
> +				flush_tlb_range(walk->vma, start, addr);
> +			hmm_pfns_fill(addr, end, hmm_vma_walk, HMM_PFN_ERROR);
> +			return 0;
> +		}

[Severity: Medium]
When hmm_vma_handle_migrate_prepare() returns a non-EAGAIN error in the lat=
er
patch "mm/hmm: migrate collection in HMM pagewalk - pte level" because
migrate_vma_split_folio() failed to split a PTE-mapped large folio, why does
hmm_vma_walk_pmd() fill [addr, end) with HMM_PFN_ERROR and return 0?

First, hmm_vma_handle_pte() has already recorded the valid PFN and
HMM_PFN_VALID in *hmm_pfns for addr. Overwriting addr with HMM_PFN_ERROR me=
ans
callers such as nouveau_dmem_migrate_fault() (in "drm/nouveau/svm: add supp=
ort
for migrate on fault") that fall back to mapping present CPU pages in place
when migration does not happen cannot use the PFN, unlike folio_trylock() or
folio_try_share_anon_rmap_pte() failures which preserve the valid PFN witho=
ut
HMM_PFN_MIGRATE.

Second, returning 0 immediately aborts the loop for the rest of the PMD ran=
ge
[addr + PAGE_SIZE, end), skipping both faulting (hmm_vma_handle_pte()) and
migration collection (hmm_vma_handle_migrate_prepare()) for all remaining P=
TEs
in that PMD and returning 0 from hmm_range_fault() with HMM_PFN_ERROR entri=
es
even when HMM_PFN_REQ_FAULT was requested.

>  	}
> -	pte_unmap(ptep - 1);
> +
> +	if (unmapped)
> +		flush_tlb_range(walk->vma, start, addr);
> +
> +	if (hmm_vma_walk->ptelocked) {
> +		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
> +		hmm_vma_walk->ptelocked =3D false;
> +	} else {
> +		pte_unmap(ptep - 1);
> +	}
> +
>  	return 0;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021060506.2377=
545-1-mpenttil@redhat.com?part=3D4
