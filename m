Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764ED606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+JE/cat
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F4C112345;
	Thu, 22 Oct 2026 06:06:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD8410E397;
 Thu, 22 Oct 2026 06:06:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BF46439AF;
 Thu, 22 Oct 2026 06:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD481F000C1;
 Thu, 22 Oct 2026 06:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792649199;
 bh=KYOBgX/+yo2riUFpd1xn1ySK9zxSUz3LCiU8ZmGTV+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h+JE/catl2s783LDDSEBow012Vfz68t17sLqDrqMdq5VV35+ZTa2JkCOxY5BS22LV
 QQkXHEeN0vdSiW1Vxu21MKurK+NXkHpiqcTZ+AKLu990fBi/Pde0WQXfh8Z31imE3L
 cA5AH9zDWkeb7dqPvBwbUUY0FtPw9u1I/Iuxz7H5UCYiND7zJgZrANci+bApoXFQrr
 7nbhKSucI+UzODJhDGqT0KASgzORhZ7BySpOs4e3ECf4gPqwu/VoGLELvJji8gJv30
 PmaqbGJFMMSx8i+R/n7J+xqeL4zD8UkFEClwEdSToc6pxHM5FRg3C84GyJ5LGTzvsH
 D3A9YB87BUWEw==
Message-ID: <sashiko-outbox-181054@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 06/12] mm/hmm: migrate collection in HMM pagewalk -
 pmd level
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
In-Reply-To: <20261021060506.2377545-7-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-7-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:06:37 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm/hmm: stale hmm_pfns left across PMD split re-walk in hmm_vma_wa=
lk_pmd()
- [Medium] mm/hmm: hmm_vma_handle_migrate_prepare_pmd() clobbers valid PFNs=
 on skip
--

commit 19d71de5ba9a8df49f896d9047f6e5016503f7dc
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pmd level

This commit implements hmm_vma_handle_migrate_prepare_pmd() and integrates =
it
into hmm_vma_walk_pmd() to prepare PMD-level THP and device-private entries
for migration or split them for PTE re-walking.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 0ce947d0e5727..5891efee3e182 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -548,14 +536,145 @@ static int migrate_vma_split_folio(struct folio *f=
olio,
>  	return 0;
>  }
> =20
> +/**
> + * migrate_vma_split_folio() - drop the pte lock and split a THP folio
> + * @folio: the folio to split
> + * @fault_page: struct page associated with the fault if any
> + * @hmm_vma_walk: walk in progress
> + * @ptep: pte_t * for unmap and unlock ptl
> + *
> + * Returns 0 on success
> + */
> +static int migrate_vma_split_folio(struct folio *folio,
> +				   struct page *fault_page,
> +				   struct hmm_vma_walk *hmm_vma_walk,
> +				   pte_t *ptep)
> +{
> +	struct folio *fault_folio =3D fault_page ? page_folio(fault_page) : NUL=
L;
> +
> +	if (folio !=3D fault_folio)
> +		folio_get(folio);
> +
> +	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
> +	hmm_vma_walk->ptelocked =3D false;
> +
> +	if (folio !=3D fault_folio)
> +		folio_lock(folio);
> +
> +	return __migrate_vma_split_folio(folio, fault_page);
> +}
> +
>  static int hmm_vma_handle_migrate_prepare_pmd(const struct mm_walk *walk,
>  					      pmd_t *pmdp,
>  					      unsigned long start,
>  					      unsigned long end,
>  					      unsigned long *hmm_pfn)
>  {

[ ... ]

> +	folio_get(folio);
> +
> +	if (folio !=3D fault_folio && unlikely(!folio_trylock(folio))) {
> +		folio_put(folio);
> +		hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
> +		return 0;
> +	}
> +
> +	if (thp_migration_supported() &&
> +	    (migrate->flags & MIGRATE_VMA_SELECT_COMPOUND) &&
> +	    (IS_ALIGNED(start, HPAGE_PMD_SIZE) &&
> +	     IS_ALIGNED(end, HPAGE_PMD_SIZE))) {
> +		struct page_vma_mapped_walk pvmw =3D {
> +			.ptl =3D hmm_vma_walk->ptl,
> +			.address =3D start,
> +			.pmd =3D pmdp,
> +			.vma =3D walk->vma,
> +		};
> +
> +		hmm_pfn[0] |=3D HMM_PFN_MIGRATE | HMM_PFN_COMPOUND;
> +
> +		r =3D set_pmd_migration_entry(&pvmw, folio_page(folio, 0));
> +		if (r) {
> +			hmm_pfn[0] &=3D ~(HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
> +			goto split;	/* fall back to splitting the pmd */
> +		}
> +		for (i =3D 1, start +=3D PAGE_SIZE; start < end; start +=3D PAGE_SIZE,=
 i++)
> +			hmm_pfn[i] &=3D HMM_PFN_INOUT_FLAGS;
> +
> +	} else {
> +		goto split;		/* fall back to splitting the pmd */
> +	}
> +
> +out:
> +	return r;
> +
> +split:
> +	spin_unlock(hmm_vma_walk->ptl);
> +	hmm_vma_walk->pmdlocked =3D false;
> +
> +	/*
> +	 * folio_get() above took an extra reference. For the fault folio the
> +	 * caller still holds a reference and the lock, which is the
> +	 * precondition of __migrate_vma_split_folio(), so drop the extra one.
> +	 */
> +	if (folio =3D=3D fault_folio)
> +		folio_put(folio);
> +
> +	r =3D __migrate_vma_split_folio(folio, migrate->fault_page);
> +	if (r)
> +		return -EFAULT;
> +
> +	hmm_vma_walk->last =3D start;
> +	return -EBUSY;
>  }

[Severity: High]
Can returning -EBUSY from the split path in
hmm_vma_handle_migrate_prepare_pmd() leave stale pre-split PMD entries in
range->hmm_pfns[] across the re-walk?

When migration is enabled (in the later commit "mm: enable device page
migration from HMM pagewalk"), hmm_vma_walk_pmd() first calls
hmm_vma_handle_pmd() or hmm_vma_handle_absent_pmd() before calling
hmm_vma_handle_migrate_prepare_pmd():

mm/hmm.c:hmm_vma_walk_pmd()
  hmm_vma_handle_pmd() / hmm_vma_handle_absent_pmd()
    for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++) {
        hmm_pfns[i] &=3D HMM_PFN_INOUT_FLAGS;
        hmm_pfns[i] |=3D pfn | cpu_flags;
    }
  hmm_vma_handle_migrate_prepare_pmd()

This populates hmm_pfns_start[0..npages-1] with the pre-split PMD PFNs,
HMM_PFN_VALID, HMM_PFN_WRITE, and hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIF=
T).

When hmm_vma_handle_migrate_prepare_pmd() then takes the split path (for
example, when MIGRATE_VMA_SELECT_COMPOUND is not set, [start, end) is small=
er
than HPAGE_PMD_SIZE, or set_pmd_migration_entry() fails), it drops
hmm_vma_walk->ptl, splits the folio via __migrate_vma_split_folio() (which
also unlocks the folio when folio !=3D fault_folio), sets
hmm_vma_walk->last =3D start, and returns -EBUSY without clearing
hmm_pfns_start[0..npages-1].

This breaks the hmm_range_fault_locked() expectation that range->hmm_pfns[]
entries at or after hmm_vma_walk.last have not been overwritten with output
flags when -EBUSY is returned.

On the subsequent PTE re-walk of [start, end), if any split page is
concurrently turned into a migration entry while the page table and folio
locks were dropped (with HMM_PFN_REQ_FAULT set), hmm_vma_handle_pte() retur=
ns
0 without updating *hmm_pfn:

mm/hmm.c:hmm_vma_handle_pte()
  if (softleaf_is_migration(entry)) {
      if (!hmm_select_migrate(range)) {
          ...
          return -EBUSY;
      }
      return 0;
  }

and hmm_vma_handle_migrate_prepare() sees !pte_present(pte) and
!softleaf_is_device_private(entry) and also returns 0 without updating
*hmm_pfn (similarly, if the PMD became a PMD migration entry,
hmm_vma_walk_pmd() returns 0 without clearing hmm_pfns_start). The later
commit "mm/hmm: implement rollback for device page migration in HMM pagewal=
k"
only rolls back entries that have both HMM_PFN_VALID and HMM_PFN_MIGRATE se=
t,
so these pre-split entries (which lack HMM_PFN_MIGRATE) remain in
range->hmm_pfns[], allowing callers that map non-migrated HMM PFNs in place
(such as nouveau_dmem_migrate_fault()) to map a stale 2MB host range into t=
he
device MMU.

Furthermore, if a caller sets range->pfn_flags_mask, overwriting
hmm_pfns_start[0..npages-1] with HMM_PFN_VALID (which shares its bit positi=
on
with HMM_PFN_REQ_FAULT) and HMM_PFN_WRITE (which shares its bit position wi=
th
HMM_PFN_REQ_WRITE) before the split clobbers the per-page request flags for
the PTE re-walk.

> @@ -958,6 +1077,17 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  			hmm_vma_walk->pmdlocked =3D false;
>  		}
> =20
> +		/*
> +		 * hmm_vma_handle_migrate_prepare_pmd() splits the huge pmd in
> +		 * place when needed and returns -EBUSY to re-walk the range as
> +		 * PTEs; any other error means the split failed.
> +		 */
> +		if (r =3D=3D -EBUSY)
> +			return -EBUSY;
> +		if (r) {
> +			/* Split not successful, skip */
> +			return hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR);
> +		}
>  		return r;
>  	}

[Severity: Medium]
Should the folio_trylock() failure path in
hmm_vma_handle_migrate_prepare_pmd() and the split failure path here in
hmm_vma_walk_pmd() preserve the valid PFNs in range->hmm_pfns[] instead of
overwriting them with HMM_PFN_ERROR?

Before hmm_vma_handle_migrate_prepare_pmd() is called, hmm_vma_handle_pmd()
(or hmm_vma_handle_absent_pmd()) has already populated
hmm_pfns_start[0..npages-1] with the valid PFNs (HMM_PFN_VALID without
HMM_PFN_MIGRATE).

However, in two best-effort migration skip cases, those valid PFNs are
clobbered with HMM_PFN_ERROR:

1. In hmm_vma_handle_migrate_prepare_pmd(), when folio_trylock(folio) fails
   while holding hmm_vma_walk->ptl, it calls
   hmm_pfns_fill(start, end, hmm_vma_walk, HMM_PFN_ERROR) even though the P=
MD
   lock was never dropped and the mapping is still valid.

2. When compound migration is not selected or [start, end) is smaller than
   HPAGE_PMD_SIZE (such as single-page faults in nouveau_dmem_migrate_fault=
()
   in the later commit "drm/nouveau/svm: add support for migrate on fault"),
   hmm_vma_handle_migrate_prepare_pmd() jumps to split and calls
   __migrate_vma_split_folio(). If split_folio() fails (for example, when t=
he
   THP is pinned or has extra references), it returns -EFAULT and
   hmm_vma_walk_pmd() overwrites the range with HMM_PFN_ERROR.

By contrast, the other non-migrating exits in
hmm_vma_handle_migrate_prepare_pmd() (goto out) and folio_trylock() failure
at the PTE level in hmm_vma_handle_migrate_prepare():

mm/hmm.c:hmm_vma_handle_migrate_prepare()
	if (fault_folio =3D=3D folio || folio_trylock(folio)) {
		...
	} else {
		folio_put(folio);
	}
out:
	return 0;

leave range->hmm_pfns[] with the valid PFNs and without HMM_PFN_MIGRATE.
Because migrate_hmm_range_setup() only collects entries with HMM_PFN_MIGRATE
set, leaving the valid PFNs intact still skips migration while allowing
callers such as nouveau_dmem_migrate_fault() to map the present THP in place
instead of treating it as an error and falling back to a redundant page tab=
le
walk and GPU PFNMAP ioctl.

Could both skip paths return 0 without calling hmm_pfns_fill(...,
HMM_PFN_ERROR)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021060506.2377=
545-1-mpenttil@redhat.com?part=3D6
