Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA6AC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9341210F35B;
	Thu, 24 Sep 2026 07:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iQ7od+fW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BB1D10F356;
 Thu, 24 Sep 2026 07:10:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F2D26022C;
 Thu, 24 Sep 2026 07:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9477D1F000FF;
 Thu, 24 Sep 2026 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790233825;
 bh=SCj4VoBtrnSUkajRCjHDd1tAm4QnWYUvsDZX7q5xPpY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iQ7od+fW0odr62/h2BQIex9HsDyPC49sDl6S7OLLdDX4urvQvWw8pvDUOfkgc5Tdq
 LiA/5bWr54v8LbmwwouedlaLuy8uPiYifnN4E7SKsPIYzMeg3nbNxExbHUK5rWJjjK
 DehQa7X6c87Fe5c5cQVj7gjWYdqgkah+fOsxVnEHam5idzZhlG6O0RpeuoqWvNJn5u
 qsVosBy9zfzoYiaFPBTzmHR8s9sd427nFxdPFWNyVdHRyvL66XlNmzxZms1mLoGYAi
 ttGR/NP64JvVGAjILNLhIIhb81pcqpxGuuE2cQV+uB9osFx8R4OWtSjXiPgIzoAwOt
 dLMOm46AMW2Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/11] mm/hmm: migrate collection in HMM pagewalk -
 pte level
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-6-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-6-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:10:25 +0000
Message-Id: <20260924071025.9477D1F000FF@smtp.kernel.org>
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
- [High] mm: livelock in migrate_vma_split_folio() due to folio_get() befor=
e folio_lock()
- [High] mm: crash in migrate_vma_split_folio() due to unvalidated non-foli=
o compound page
- [High] mm: valid pages marked with HMM_PFN_ERROR after transient split fa=
ilure
--

commit 9b874173389a5794c12372b3f46c3c2b4f634054
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pte level

Implement hmm_vma_handle_migrate_prepare() for migration decisions and
migrate_vma_split_folio() for splitting pte mapped large folios during
HMM pagewalks.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 25f537c87b5f2..a60b669630496 100644
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

[Severity: High]
Can this cause a livelock when splitting the folio?

If multiple threads concurrently fault on the same shared large folio and
enter migrate_vma_split_folio(), they will all acquire a reference via
folio_get() before blocking on folio_lock(). This inflates the refcount,
causing split_folio() to fail with -EAGAIN. Retrying this sequence creates
a permanent livelock.

[ ... ]

> +static int hmm_vma_handle_migrate_prepare(const struct mm_walk *walk,
> +					  pmd_t *pmdp,
> +					  pte_t *ptep,
> +					  unsigned long addr,
> +					  unsigned long *hmm_pfn,
> +					  bool *unmapped)
> +{

[ ... ]

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
> +
> +	if (!page || !page->mapping)
> +		goto out;

[Severity: High]
Does this code operate on uninitialized folio metadata if a driver maps an
uninitialized compound page to userspace?

If a driver allocates a compound page without folio initialization and maps
it, hmm_range_fault() walking the VMA will see PG_head set, and
folio_test_large() will succeed. Because the !page->mapping validation check
is deferred until after the split attempt, this passes the uninitialized
compound page to migrate_vma_split_folio(), which can crash when calling
folio_lock() and split_folio().

[ ... ]

> +out:
>  	return 0;
> +out_error:
> +	return -EFAULT;
>  }

[Severity: High]
Can a transient split failure result in valid pages being falsely marked as
inaccessible?

If migrate_vma_split_folio() fails due to a transient refcount elevation,
hmm_vma_handle_migrate_prepare() returns -EFAULT. When hmm_vma_walk_pmd()
catches this non -EAGAIN error, it breaks the loop and calls
hmm_pfns_fill(..., HMM_PFN_ERROR) for the entire remainder of the PMD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D5
