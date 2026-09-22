Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B91DC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11CA10EB5E;
	Tue, 22 Sep 2026 05:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GWoe71rq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EF510E7DA;
 Tue, 22 Sep 2026 05:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46B0140BB4;
 Tue, 22 Sep 2026 05:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045201F000FF;
 Tue, 22 Sep 2026 05:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056062;
 bh=hOaZ1ecnWLL9TWPKgD4JXT/MGDbYP1l4pbjIN4ZZFvA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GWoe71rqBtTQszEOCHh3xX4C9dgBZkU65drLxQ12knJ8SgM3PtY9wYFkQajRKsopt
 o3OKYCAs4FCUpe0Q8numU4beSZQd52xbhD3U0vd4qYLA6tfqbcokAbfb7Nk4iepnk/
 VPb812bcnSPN/0eBIGa3Tieh0+PSLlHsOCLDQFvRMkQx0RHLwCVkRL9bDfoXyQHSnl
 WEVhnipu7BAuCsALozpwo/clvJ4oLn/qLI4RVrCPV0o/Z5spBmlc64Ev1rgM7IE40i
 nsT8o6+l/EQfzIseZ4Cl1fXuyKl3pGttj/EVPm6c3JUsUGI8CD4hIFj8H5EzyQ5YFk
 hLgUc9FrBrUew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 06/12] mm/hmm: migrate collection in HMM pagewalk -
 pte level
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-7-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-7-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:47:41 +0000
Message-Id: <20260922054742.045201F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] mm: hmm: double unlock of caller-locked fault_folio on rmap share =
failure
- [High] mm: hmm: livelock in large folio split due to refcount inflation b=
efore locking
- [High] mm: hmm: kernel crash due to split_folio() on non-folio compound p=
ages
--

commit 5d5a85160b145735bf86c066185b4f70abea7ca4
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pte level
   =20
Implement hmm_vma_handle_migrate_prepare() and migrate_vma_split_folio() for
HMM pagewalk-based migration. The hmm_vma_handle_migrate_prepare() function
is responsible for migration decisions, possibly splitting folios, and
inserting migration entries.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index e6469ef4ae6ad..b3b79d13c7978 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
[ ... ]
> +static int migrate_vma_split_folio(struct folio *folio,
> +				   struct page *fault_page,
> +				   struct hmm_vma_walk *hmm_vma_walk,
> +				   pte_t *ptep)
> +{
> +	int ret;
> +	struct folio *fault_folio =3D fault_page ? page_folio(fault_page) : NUL=
L;
> +	struct folio *new_fault_folio =3D NULL;
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
> +	ret =3D split_folio(folio);

[Severity: High]
Does taking the reference via folio_get() before blocking on folio_lock()
create a livelock when multiple threads fault on the same large folio?

If multiple threads execute migrate_vma_split_folio() simultaneously, they
would all elevate the refcount and block on the lock. When the lock is fina=
lly
acquired, split_folio() expects the refcount to be exactly
folio_expected_ref_count() + 1. The extra references held by the waiting
threads would cause split_folio() to return -EAGAIN repeatedly, preventing
forward progress.

[ ... ]
> +static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
> +					  pmd_t *pmdp,
> +					  pte_t *ptep,
> +					  unsigned long addr,
> +					  unsigned long *hmm_pfn,
> +					  bool *unmapped)
> +{
[ ... ]
> +	} else {
> +		pfn =3D pte_pfn(pte);
> +		if (is_zero_pfn(pfn) &&
> +		    (minfo & MIGRATE_VMA_SELECT_SYSTEM)) {
> +			*hmm_pfn =3D HMM_PFN_MIGRATE;
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

[Severity: High]
Can this split_folio() crash if a driver mapped a raw compound page into the
VMA using vm_insert_page()?

The large folio check here uses folio_test_large() which returns true for a=
ny
compound page (since PG_head is set). However, page_folio() blindly casts
compound pages. If the compound page lacks initialized folio metadata (like=
 a
valid mapping or LRU state), splitting it will corrupt memory. The structur=
al
validation gate checking for a valid mapping (!page || !page->mapping) is o=
nly
performed after this split attempt.

> +			if (ret)
> +				goto out_error;
> +			return -EAGAIN;
> +		}
> +
> +		writable =3D pte_write(pte);
> +	}
> +
> +	if (!page || !page->mapping)
> +		goto out;
[ ... ]
> +	if (fault_folio =3D=3D folio || folio_trylock(folio)) {
> +		anon_exclusive =3D folio_test_anon(folio) &&
> +			PageAnonExclusive(page);
> +
> +		if (pte_present(pte))
> +			flush_cache_page(walk->vma, addr, pfn);
> +
> +		if (anon_exclusive) {
> +			pte =3D ptep_clear_flush(walk->vma, addr, ptep);
> +
> +			if (folio_try_share_anon_rmap_pte(folio, page)) {
> +				set_pte_at(mm, addr, ptep, pte);
> +				folio_unlock(folio);

[Severity: High]
Does this error path unconditionally unlock a folio that the caller might h=
old
the lock for?

When entering this block, if fault_folio =3D=3D folio, the code bypasses ca=
lling
folio_trylock(folio) because the caller already owns the lock. If
folio_try_share_anon_rmap_pte() subsequently fails, calling folio_unlock()
here would destroy the caller's lock state, causing a double-unlock crash
when the caller attempts to unlock it later.

> +				folio_put(folio);
> +				goto out;
> +			}
> +		} else {
> +			pte =3D ptep_get_and_clear(mm, addr, ptep);
> +		}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D6
