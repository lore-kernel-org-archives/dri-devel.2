Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAC606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghxJiKoB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620AB10E73F;
	Wed,  4 Nov 2026 06:18:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A680B10E745;
 Wed,  4 Nov 2026 06:18:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E35D40F14;
 Wed,  4 Nov 2026 06:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9E1F000C1;
 Wed,  4 Nov 2026 06:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793773080;
 bh=CuJ0iEYeJ0qXki1Jq0werAEqmBdF9HjWdgIBgqLLHZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ghxJiKoBvgw3rjS264DhaVbfl70tvUpi0gvqRpYaPK7APNNm7GVK4miPpWjEe4WhS
 gcWBcqKmp6lKQnsvmy8cRVhbtAg664okl396KIwOqKTg6tT0t87ifBXyzo2rthakUj
 +aPNZeo2Z5eEpdDyyki+YQSue8JF1TahYCc7EsA/77lC7MKI1VpLTulSpIWZ9BwKo0
 M2Zuq3k8UXI932gdjriPd7u7AGF//PLMNmelEU7oEcS8J9J07vGIK7AScxsNJm9OL2
 rHR/KYAZSNEwcgYkD9EwSWZX/aE6foCYJSsMJc/OQEqKAyroAGvAbzBhx+r/AabxUy
 4t3rlU4IIxs0A==
Message-ID: <sashiko-outbox-196743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/12] mm/hmm: migrate collection in HMM pagewalk -
 pte level
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
In-Reply-To: <20261103061629.972669-6-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <20261103061629.972669-6-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 06:17:58 +0000
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
- [High] mm/hmm: split of non-anonymous large folios in hmm_vma_handle_migr=
ate_prepare()
- [High] mm/hmm: early PMD walk termination on folio split failure in hmm_v=
ma_walk_pmd()
- [High] mm/hmm: reject KSM folios in hmm_vma_handle_migrate_prepare()
--

commit 9b85d918ada9ba7990835bcd807b9973c5976885
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pte level

This commit implements PTE-level migration preparation and collection in
hmm_vma_handle_migrate_prepare(), along with migrate_vma_split_folio() to
split PTE-mapped large folios during an HMM page table walk.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 854d2c090b20c..ec9280ef26822 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -495,6 +495,71 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk =
*walk, unsigned long start,
>  #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
> =20
>  #ifdef CONFIG_DEVICE_MIGRATION

[ ... ]

> @@ -512,8 +582,230 @@ static int hmm_vma_handle_migrate_prepare(const str=
uct mm_walk *walk,
>  					  unsigned long *hmm_pfn,
>  					  bool *unmapped)
>  {
> -	// TODO: implement migration entry insertion
> +	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct migrate_vma *migrate =3D range->migrate;

[ ... ]

> +		if (folio_test_large(folio)) {
> +			int ret;
> +
> +			ret =3D migrate_vma_split_folio(folio,
> +						      migrate->fault_page,
> +						      hmm_vma_walk,
> +						      ptep);
> +			if (ret)
> +				goto out_error;
> +			return -EAGAIN;
> +		}
> +
> +		pfn =3D page_to_pfn(page);
> +		if (softleaf_is_device_private_write(entry))
> +			writable =3D true;
> +	} else {
> +		pfn =3D pte_pfn(pte);
> +		if (is_zero_pfn(pfn) &&
> +		    (minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
> +			/* Like pte_none(): only anonymous memory can be populated */
> +			if (!vma_is_anonymous(walk->vma))
> +				goto out;
> +			*hmm_pfn &=3D HMM_PFN_INOUT_FLAGS;
> +			*hmm_pfn |=3D HMM_PFN_MIGRATE;
> +			goto out;
> +		}
> +		page =3D vm_normal_page(walk->vma, addr, pte);
> +		if (page && !is_zone_device_page(page) &&
> +		    !(minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
> +			goto out;
> +		} else if (page && is_device_coherent_page(page)) {
> +			pgmap =3D page_pgmap(page);
> +
> +			if (!(minfo &
> +			      MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
> +			    pgmap->owner !=3D migrate->pgmap_owner)
> +				goto out;
> +		}
> +
> +		folio =3D page ? page_folio(page) : NULL;
> +		if (folio && folio_test_large(folio)) {
> +			int ret;
> +
> +			ret =3D migrate_vma_split_folio(folio,
> +						      migrate->fault_page,
> +						      hmm_vma_walk,
> +						      ptep);
> +			if (ret)
> +				goto out_error;
> +			return -EAGAIN;
> +		}
> +
> +		writable =3D pte_write(pte);
> +	}

[Severity: High]
When walking a private file-backed VMA (which can contain a mix of
copy-on-write anonymous pages and read-only pagecache pages), will this
attempt to split non-anonymous large pagecache folios before checking
folio_test_anon()?

In the pte_present(pte) branch of hmm_vma_handle_migrate_prepare(),
migrate_vma_split_folio() is called on any large folio before verifying that
the folio is anonymous. If a PTE maps a read-only large file-backed folio in
the page cache, migrate_vma_split_folio() drops the PTE lock, takes the
sleeping folio_lock(folio) on the pagecache folio while already holding loc=
ks
on previously collected anonymous folios, and calls split_folio().

For file-backed folios, split_folio() -> __folio_freeze_split_file() takes
i_mmap_lock_read() and unmaps the folio without remapping it, leaving the
PTEs as pte_none() on the -EAGAIN retry, only for the resulting order-0
pagecache folio to be skipped by the !folio_test_anon() check. Furthermore,
if the filesystem sets mapping_min_folio_order() > 0, split_folio() fails
with -EINVAL (triggering VM_WARN_ONCE() in __folio_split()) and jumps to
out_error.

Should the !page || !folio_test_anon(folio) check happen before attempting =
to
split the folio in the present PTE path?

> +
> +	/* Only anonymous memory can be migrated to device memory */
> +	if (!page || !folio_test_anon(page_folio(page)))
> +		goto out;

[Severity: High]
Can KSM folios pass this check and be collected for device migration?

In include/linux/page-flags.h, FOLIO_MAPPING_KSM is defined as:

	FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM

Because FOLIO_MAPPING_ANON is set on KSM folios, folio_test_anon() returns
true for them. When hmm_range_fault() runs without HMM_PFN_REQ_WRITE (for
example during migrate_vma_setup() or a read fault with migration),
hmm_vma_handle_pte() does not break CoW on a read-only KSM PTE, and
hmm_vma_handle_migrate_prepare() locks and collects the KSM folio.

If the same KSM folio is mapped a second time later in the walked range,
hmm_vma_handle_pte() marks the second entry HMM_PFN_VALID before
folio_trylock() fails in hmm_vma_handle_migrate_prepare(), and
try_to_migrate() later unmaps that second mapping via rmap_walk_ksm(),
leaving a stale PFN in range->hmm_pfns. More importantly, migrating a KSM
folio to MEMORY_DEVICE_PRIVATE memory updates stable_node->kpfn via
folio_migrate_ksm() to a non-CPU-accessible ZONE_DEVICE PFN and installs
device-private swap entries into other processes sharing the KSM page,
causing ksmd to fault when it later accesses the page in memcmp_pages().

Should hmm_vma_handle_migrate_prepare() also reject folio_test_ksm(folio)?

[ ... ]

> +		set_pte_at(mm, addr, ptep, swp_pte);
> +		folio_remove_rmap_pte(folio, page, walk->vma);
> +		folio_put(folio);
> +		*hmm_pfn |=3D HMM_PFN_VALID | HMM_PFN_MIGRATE;
> +		if (pte_present(pte))
> +			*unmapped =3D true;
> +	} else {
> +		folio_put(folio);
> +	}
> +out:
>  	return 0;
> +out_error:
> +	return -EFAULT;
>  }

[Severity: High]
As reported by Sashiko on v16 [1], when migrate_vma_split_folio() fails in
hmm_vma_handle_migrate_prepare() and jumps to out_error (-EFAULT), does the
caller in hmm_vma_walk_pmd() abort the PMD walk too early and leave the
remaining pages in the PMD unprocessed?

In hmm_vma_walk_pmd(), the PTE loop handles non-zero returns from
hmm_vma_handle_migrate_prepare() by immediately returning 0:

	for (; addr < end; addr +=3D PAGE_SIZE, ptep++, hmm_pfns++) {

		r =3D hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
		...
		r =3D hmm_vma_handle_migrate_prepare(walk, pmdp, ptep, addr, hmm_pfns, &u=
nmapped);
		if (r =3D=3D -EAGAIN) {
			...
			goto again;
		}
		if (r) {
			HMM_ASSERT_UNLOCKED(hmm_vma_walk);
			if (unmapped)
				flush_tlb_range(walk->vma, start, addr);
			return 0;
		}
	}

Because hmm_vma_handle_pte() is called inside the same per-page loop,
returning 0 from hmm_vma_walk_pmd() when a split fails at addr skips both
hmm_vma_handle_pte() and hmm_vma_handle_migrate_prepare() for all remaining
addresses in [addr + PAGE_SIZE, end) of the PMD. As a result,
hmm_range_fault() can return 0 (success) while range->hmm_pfns[] entries for
[addr + PAGE_SIZE, end) remain zeroed without HMM_PFN_VALID, and pages in
that tail of the PMD are neither faulted in (when HMM_PFN_REQ_FAULT is
requested) nor migrated.

[1] https://lore.kernel.org/r/20261021060506.2377545-6-mpenttil@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103061629.9726=
69-1-mpenttil@redhat.com?part=3D5
