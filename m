Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA964606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP3xBdTY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A91810E050;
	Thu, 22 Oct 2026 06:06:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B7FE10E050;
 Thu, 22 Oct 2026 06:06:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 038E7447FD;
 Thu, 22 Oct 2026 06:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98671F000C2;
 Thu, 22 Oct 2026 06:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792649200;
 bh=7rLS0uOUI/ocCbunTNg1g/PS0epTbYFvwScjZMSyXgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NP3xBdTYMG847D761cEGUwZNwnhTylJ1XIP9VO3OcSGPMlV0uAuE9uPztgE5XIBkm
 QpUgUpq2nZpsXwWCwxpI1dy2s05mORatCtrPoaedUC50yp7QhXgqvL38RKY+V26Ctg
 /Sj8MVvpu+UlQHDPZpFyJFC8ILeSS41blgjylYcx/Y1qCGPReMVMMqBFrMT9msYTd0
 NfZMyB6WIWyNX+XqE/n91xcOhFuQSbHOEbyTD1qybNiDX2+JIHHZRHbGHoMgoI89Wr
 O7IG+pSxWFBJIxZ00r9GNHJVRN04YWr0TcgG5i+tLCxLmXvxeIbvVc6z8xxFlnoTBV
 pHLYhmyubPy3g==
Message-ID: <sashiko-outbox-181056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/12] mm/hmm: implement rollback for device page
 migration in HMM pagewalk
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
In-Reply-To: <20261021060506.2377545-9-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-9-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:06:39 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] mm/hmm: premature rollback of migration PTEs in hmm_vma_handle=
_pte()
- [High] mm/hmm: incomplete rollback on mid-PMD lock drop in hmm_vma_walk_p=
md()
- [High] mm/hmm: missing rollback on fault and PMD migration in hmm_vma_wal=
k_pmd()
--

commit 5c75620371e34a43110051163d33f29ab4f700b4
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: implement rollback for device page migration in HMM pagewalk

This commit adds rollback handling during HMM migration page walks to unlock
and drop references on previously collected folios if page tables change wh=
ile
locks are dropped.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 36a4edde9823c..5a1471fd5d288 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -282,6 +289,8 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, u=
nsigned long addr,
>  		return hmm_record_fault(addr, end, required_fault, walk);
>  	}
> =20
> +	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
> +						end, hmm_pfns);
>  	pfn =3D pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>  	for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++) {
>  		hmm_pfns[i] &=3D HMM_PFN_INOUT_FLAGS;

[Severity: High]
What happens if entries in hmm_pfns were previously collected, locks were
dropped, and on re-walk the page table entry now requires a fault, fails wi=
th
-EFAULT, or is a PMD migration entry?

In hmm_vma_handle_pmd(), if required_fault is non-zero, it returns
hmm_record_fault() before calling hmm_vma_handle_migrate_prepare_rollback().
Several other paths similarly return before rolling back previously collect=
ed
entries in range->hmm_pfns:

  - hmm_vma_walk_hole() returns -EFAULT (when !walk->vma) or
    hmm_record_fault() when required_fault is non-zero before reaching
    hmm_pfns_fill().
  - hmm_vma_handle_absent_pmd() returns hmm_record_fault() or -EFAULT when
    required_fault is non-zero without calling
    hmm_vma_handle_migrate_prepare_rollback().
  - hmm_vma_handle_pte() jumps to the fault: label or returns -EFAULT witho=
ut
    rolling back *hmm_pfn.
  - hmm_vma_walk_pmd() returns -EFAULT on pmd_bad(pmd) when
    hmm_range_need_fault() is non-zero, and returns 0 when
    thp_migration_supported() && pmd_is_migration_entry(pmd) is true with
    minfo non-zero, without rolling back collected PTE entries in
    hmm_pfns_start.

If hmm_record_fault() returns HMM_FAULT_PENDING while the current task still
holds folio_lock() on previously collected folios in that range, can
hmm_do_fault() -> handle_mm_fault() deadlock trying to lock the same folio,=
 or
can the early returns leave stale collected folios locked and referenced in
range->hmm_pfns?

> @@ -412,6 +421,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, u=
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

[Severity: Critical]
Could reaching the out: label in hmm_vma_handle_pte() prematurely roll back=
 a
migration PTE that this walk already installed?

In hmm_vma_handle_pte(), when !pte_present(pte) is true, the required_fault
check runs before softleaf_is_migration(entry):

	if (!pte_present(pte)) {
		...
		required_fault =3D
			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
		if (!required_fault)
			goto out;
		...
		if (softleaf_is_migration(entry)) {
			if (!hmm_select_migrate(range)) {
				...
				return -EBUSY;
			}
			return 0;
		}

During a migration walk without HMM_PFN_REQ_FAULT (such as migrate_vma_setu=
p()
where range.default_flags is HMM_PFN_REQ_MIGRATE),
hmm_vma_handle_migrate_prepare() locks the folio, takes a reference, instal=
ls
a migration PTE, and marks *hmm_pfn with HMM_PFN_VALID | HMM_PFN_MIGRATE.

If the walk restarts over that range (for example, after dropping locks in
migrate_vma_split_folio() or on an -EBUSY retry), hmm_vma_handle_pte() sees
!pte_present(pte) for its own migration PTE. Because HMM_PFN_REQ_FAULT is n=
ot
set, hmm_pte_need_fault() returns 0 and jumps to out: with new_pfn_flags =
=3D 0.
At out:, hmm_vma_handle_migrate_prepare_rollback() unlocks the folio, calls
folio_put(), and clears HMM_PFN_VALID | HMM_PFN_MIGRATE from *hmm_pfn while
the migration PTE remains installed in the page table, so
remove_migration_ptes() will never be called for it.

Conversely, when HMM_PFN_REQ_FAULT is set (required_fault !=3D 0), the
softleaf_is_migration(entry) branch returns 0 whenever
hmm_select_migrate(range) is non-zero without checking that
hmm_pfn_collected(*hmm_pfn) is true and that softleaf_to_pfn(entry) matches
the PFN in *hmm_pfn. If the migration PTE belongs to a concurrent migration
(at an uncollected slot or in a replacement PTE table), shouldn't
hmm_vma_handle_pte() roll back any mismatched *hmm_pfn and wait via
migration_entry_wait()?

[ ... ]

> @@ -1117,6 +1193,9 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		if (ptep) {
>  			lazy_mmu_mode_enable();
>  			hmm_vma_walk->ptelocked =3D true;
> +		} else {
> +			/* The pte table is gone */
> +			hmm_vma_handle_migrate_prepare_rollback(walk->private, addr, end, hmm=
_pfns);
>  		}
>  	} else {
>  		ptep =3D pte_offset_map(pmdp, addr);

[Severity: High]
Does this rollback miss entries collected in [start, addr) when the PTE lock
is dropped partway through a PMD?

In hmm_vma_walk_pmd(), the PTE loop advances addr and hmm_pfns from start
toward end while collecting folios into hmm_pfns_start. If
hmm_vma_handle_migrate_prepare() hits a large folio at addr > start,
migrate_vma_split_folio() drops the PTE lock and returns -EAGAIN, and
hmm_vma_walk_pmd() jumps to again: without resetting addr =3D start:

again:
	hmm_pfns =3D &range->hmm_pfns[(addr - range->start) >> PAGE_SHIFT];
	...
	if (minfo) {
		ptep =3D pte_offset_map_lock(mm, pmdp, addr, &hmm_vma_walk->ptl);
		if (ptep) {
			lazy_mmu_mode_enable();
			hmm_vma_walk->ptelocked =3D true;
		} else {
			/* The pte table is gone */
			hmm_vma_handle_migrate_prepare_rollback(walk->private, addr, end, hmm_pf=
ns);
		}
	}
	if (!ptep) {
		addr =3D start;
		goto again;
	}

When ptep is NULL at addr > start, hmm_vma_handle_migrate_prepare_rollback()
is called with addr and hmm_pfns before addr is reset to start, so it only
scans the uncollected tail [addr, end) and leaves folios collected in
[start, addr) (at hmm_pfns_start) locked and referenced.

In addition, if the PTE table was cleared and replaced by another PTE table
while the lock was dropped in migrate_vma_split_folio() (or during a mid-PMD
fault where hmm_record_fault() sets hmm_vma_walk->last =3D addr),
pte_offset_map_lock() succeeds at addr > start on the new PTE table and res=
umes
from addr without re-walking or rolling back [start, addr). Should mid-PMD =
lock
drops restart from start (with hmm_pfns_start) so that [start, addr) is
re-validated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021060506.2377=
545-1-mpenttil@redhat.com?part=3D8
