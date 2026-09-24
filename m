Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CAC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3CB10E07F;
	Thu, 24 Sep 2026 07:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccau2wq6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5921510E07F;
 Thu, 24 Sep 2026 07:10:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4759A60211;
 Thu, 24 Sep 2026 07:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFF41F000FF;
 Thu, 24 Sep 2026 07:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790233800;
 bh=zpRSA7CrYXE7D7dj+CI+sZ3lymKfCV5N+g4WKde19XY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ccau2wq63Ftw68+AmhtbW9GDvZi4wy8kqwi7hxNpqunZJXcQjUd70mo/pyC5tEnjw
 v0NmfJWFW+uCyHtN8v295izq/UYRSEq4mKZt6jMxyaItg5TOBT1PDWs75voWJR27H3
 XqYg3Zzh4M+y4KzZLjKLrd4WHyRIFwvGhSpDexLEONX0r+l/wfjRNfR5StlaKfipM3
 +HmVt50roqMfDEnK+ko2hGnUi0qXZxG/9eZ0DlDFMJh0cYYUi+Y3VjHGSY4bEhTC+v
 2nFP4vdmDhA6M7lNnn7OG9xuHvC3kPRBvBJGWsSHQtGDd5CpQPmaTMUXttY0FsMVNp
 VRcvvLRqhFLUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/11] mm/hmm: migrate collection in HMM pagewalk -
 pmd level
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-7-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-7-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:09:59 +0000
Message-Id: <20260924070959.BAFF41F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: Use-After-Free in __migrate_vma_split_folio on unlocked tail p=
age
--

commit 303a19fde6deb0a6633524827ecf0a51aa867674
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: migrate collection in HMM pagewalk - pmd level

This commit implements hmm_vma_handle_migrate_prepare_pmd() to handle
migration decisions and split folios for HMM pagewalk-based migration.
It also refactors the folio splitting path by separating it into
__migrate_vma_split_folio() to fix extra refcount and unlock issues.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index a60b669630496..ea77429c5178b 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -492,31 +492,19 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk=
 *walk, unsigned long start,
> =20
>  #ifdef CONFIG_DEVICE_MIGRATION
>  /**
> - * migrate_vma_split_folio() - Helper function to split a THP folio
> + * __migrate_vma_split_folio() - split a folio and move the lock/ref to =
the
> + * order-0 folio backing @fault_page after the split
>   * @folio: the folio to split
> - * @fault_page: struct page associated with the fault if any
> - * @hmm_vma_walk: walk in progress
> - * @ptep: pte_t * for unmap and unlock ptl
>   *
> - * Returns 0 on success
> + * Returns 0 on success.
>   */
> -static int migrate_vma_split_folio(struct folio *folio,
> -				   struct page *fault_page,
> -				   struct hmm_vma_walk *hmm_vma_walk,
> -				   pte_t *ptep)
> +static int __migrate_vma_split_folio(struct folio *folio,
> +				     struct page *fault_page)
>  {
> -	int ret;
>  	struct folio *fault_folio =3D fault_page ? page_folio(fault_page) : NUL=
L;
>  	struct folio *new_fault_folio =3D NULL;
> -
> -	if (folio !=3D fault_folio)
> -		folio_get(folio);
> -
> -	pte_unmap_unlock(ptep, hmm_vma_walk->ptl);
> -	hmm_vma_walk->ptelocked =3D false;
> -
> -	if (folio !=3D fault_folio)
> -		folio_lock(folio);
> +	int ret;
> =20
>  	ret =3D split_folio(folio);
>  	if (ret) {

[Severity: High]
Can this lead to a use-after-free on an unlocked tail page?

If split_folio() successfully splits a THP where the fault page is a tail
page, it returns with the head page locked but unfreezes and unlocks all
the tail pages.

Later in this function, the code directly acquires a reference and lock
on the new tail folio:

	if (new_fault_folio !=3D fault_folio) {
		folio_get(new_fault_folio);
		folio_lock(new_fault_folio);
	}

Since the PMD lock was dropped before calling __migrate_vma_split_folio()
and mmap_lock is only held in read mode, could a concurrent thread (like
memory reclaim) isolate, unmap, and free the unlocked tail page to the buddy
allocator before folio_get() is called?

Should this use folio_try_get() to safely acquire a reference to the
speculatively accessed tail folio?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D6
