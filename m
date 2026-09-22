Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF2C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0381F10EB74;
	Tue, 22 Sep 2026 05:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nqcb4nfH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0B610EB74;
 Tue, 22 Sep 2026 05:50:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16FD44051C;
 Tue, 22 Sep 2026 05:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EEB1F000FF;
 Tue, 22 Sep 2026 05:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056223;
 bh=vOTie0+bTokL5o1+xIpv4XGcWyX1H7gpSNZI8uLHn74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Nqcb4nfHw5SXt5XF1Z16oJCtGAOyw0vFfShJ2fPUCUVep9XDZoNpZVCLcbIG7JSJP
 t1e/IZe5voXRMVsKJiEMICgCiqizrs11SU7kp8KzvL0eK4nzr7SBun6Fdi82cWDK/J
 Ykfzg7ccyeObYKzO2W1/giRl7YRsHOfpZkpZMT0HM6F+5RnktDPouYsYc+DMooNlBH
 nY/SjAxol6zzN5ZY18Pe0oYwMxqqb064qHZu0eyMsh8QeNUrrCylKPWud50vPXNAJe
 MU9eqEJ/GNjOUJfpO0rVThSmuFXVlHoqf3Scjc1mhls2+wjaR5tdRYgvctLxQ69wmB
 iP5YvUPKejYmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/12] mm/hmm: migrate collection in HMM pagewalk -
 pmd level
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-8-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-8-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:50:22 +0000
Message-Id: <20260922055022.C1EEB1F000FF@smtp.kernel.org>
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
- [Critical] mm: set_pmd_migration_entry() uses wrong subpage for >2MB foli=
os
- [High] mm: pmd_folio() dereferences bogus pointer for non-present PMD lea=
f entries
- [High] mm: unreachable device-private PMD branch causes infinite fault lo=
ops
--

commit 191891c0dfbd0707d81f83e9fa9b79a00e1693ac
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pmd level

Implement hmm_vma_handle_migrate_prepare_pmd() for HMM pagewalk migration.
It makes migration decisions, possibly splits folios, and inserts migration
pmds.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index b3b79d13c7978..a1459bd34c04e 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -552,8 +552,100 @@ static int hmm_vma_handle_migrate_prepare_pmd(const=
 struct mm_walk *walk,
[ ... ]
> +	if (pmd_trans_huge(*pmdp)) {
> +		if (!(minfo & MIGRATE_VMA_SELECT_SYSTEM))
> +			goto out;
> +
> +		folio =3D pmd_folio(*pmdp);

[Severity: High]
Does this code handle non-present PMD leaf entries correctly?

When pmd_trans_huge() is called, it can return true for non-present PMD leaf
entries like migration or device-private swap entries because they have the
huge bit set. If that happens, this path will unconditionally call
pmd_folio(), which can produce a bogus struct page pointer because swap
metadata is interpreted as a PFN. Could this lead to an invalid memory acce=
ss
if userspace triggers HMM migration on memory regions with these entries?

> +		if (is_huge_zero_folio(folio))
> +			return hmm_pfns_fill(start, end, hmm_vma_walk, 0);
> +
> +	} else if (!pmd_present(*pmdp)) {

[Severity: High]
Is this branch actually reachable for device-private PMDs?

According to the MM subsystem guide, pmd_present() returns true for
non-present PMD leaf entries, which includes device-private entries. That
would make !pmd_present(*pmdp) evaluate to false. If device-private PMDs
bypass the huge PMD check and fail this condition, they will fall through to
the final else block and return -EBUSY. Returning -EBUSY causes the outer
walk_page_range() loop in hmm_range_fault_locked() to retry the same address
indefinitely. Can this cause a denial of service via an infinite loop?

> +		const softleaf_t entry =3D softleaf_from_pmd(*pmdp);
[ ... ]
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

[Severity: Critical]
Will this use the correct subpage for folios larger than 2MB?

For file-backed folios that are larger than PMD size (e.g., 1GB), they can
be mapped by multiple PMDs. Using folio_page(folio, 0) always evaluates to
the head page of the large folio, regardless of which 2MB chunk the PMD
actually maps. Since set_pmd_migration_entry() uses page_to_pfn() on the
provided page, all PMD migration entries for the large folio might encode
the PFN of the head chunk. Upon migration restoration, could this silently
corrupt data by mapping all PMDs to the first 2MB chunk's physical memory?
Would it be safer to use pmd_page(*pmdp) here to get the specific subpage?

> +		if (r) {
> +			hmm_pfn[0] &=3D ~(HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
> +			r =3D -ENOENT;  // fallback

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D7
