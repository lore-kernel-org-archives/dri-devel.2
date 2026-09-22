Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBDCC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECEF10E57A;
	Tue, 22 Sep 2026 05:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lJxMTBq2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FF610E57A;
 Tue, 22 Sep 2026 05:47:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06763600CB;
 Tue, 22 Sep 2026 05:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7461F000FF;
 Tue, 22 Sep 2026 05:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056021;
 bh=5K0t/NTnZB9THBh1syEBjkrsvaEwF24fQrXkHsoG6QQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lJxMTBq2fbyLK3JBoSEN0HhBew6h5a3S4Og6RnQK10UkcDAyUfu5j4JWXDtlZNiiJ
 GGovCuOiQ5CEs0wJYsBL3WPrUjkCZ3BxybnJOc4W6ZdsCR+pdfm2xIVW6wr2434BjH
 5aiGKYK5pta4sR9APk7b58w9EBI22BL8gdmauJFq1oK10GUX9eC7156xYoTkmzb5u1
 5FH1mOlM1ApqOxy9amcNKQwbN3mwG5W43cskRl2N8H/kQbVIXP4dv6FBbgXV+/3sfr
 9RD7691BwaXHuM8/ApAbvkDb0OJNIhtHeC5/aN4EJXlq9Am/Sx6u9oyRxPf3X8VqqT
 fuy5XG/xuewdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/12] mm/hmm: implement folio split for migrate
 needs in HMM pagewalk
To: mpenttil@redhat.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-6-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-6-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:47:00 +0000
Message-Id: <20260922054701.3B7461F000FF@smtp.kernel.org>
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
- [High] mm: livelock in hmm_vma_walk_split() due to refcount elevation bef=
ore trylock
- [High] mm: lock leak and VM_BUG_ON in hmm_vma_walk_split() for tail fault=
_page
- [Medium] mm: spurious migration failure in hmm_vma_walk_split() from TOCT=
OU split
--

commit ecf2b8c21903b70112c2f8a92121be600dc85ab2
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: implement folio split for migrate needs in HMM pagewalk

Implement the helper to split PMD size folios during pagewalk.
Splitting is needed if the start and end addresses are
not PMD aligned, or setting up pmd migration entry fails.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 4805c88347e67..e6469ef4ae6ad 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -514,10 +514,51 @@ static int hmm_vma_walk_split(pmd_t *pmdp,

[ ... ]

> +	folio =3D pmd_folio(*pmdp);
> +	if (is_huge_zero_folio(folio)) {
> +		spin_unlock(ptl);
> +		split_huge_pmd(walk->vma, pmdp, addr);
> +	} else {
> +		folio_get(folio);
> +		spin_unlock(ptl);
> +
> +		if (folio !=3D fault_folio) {
> +			if (unlikely(!folio_trylock(folio))) {

[Severity: High]
Does this create a livelock under contention?

If multiple threads race in hmm_vma_walk_split(), Thread B might elevate the
refcount here before Thread A (which already holds the lock) calls
split_folio(). When Thread A calls split_folio(), the inflated refcount will
cause split_folio() to fail with -EAGAIN. Thread A returns -EAGAIN and drops
the lock, while Thread B fails folio_trylock() and returns -EBUSY. Both can
then retry infinitely.

Could we attempt folio_trylock() before elevating the refcount?

> +				folio_put(folio);
> +				ret =3D -EBUSY;
> +				goto out;
> +			}
> +		}  else {
> +			folio_put(folio);
> +		}
> +
> +		ret =3D split_folio(folio);

[Severity: Medium]
Will this spuriously fail migration if the folio is split concurrently?

If another thread concurrently splits the THP during the lockless window
before we acquire the lock, split_folio() will return -EINVAL. Passing this
error up to hmm_vma_walk_pmd() aborts the pagewalk and marks the range with
HMM_PFN_ERROR instead of treating it as a condition to retry the walk with
the new PTEs.

[Severity: High]
Does this correctly handle cases where fault_page was a tail page?

If hmm_vma_walk_split() is called with migrate->fault_page as a tail page,
fault_folio is resolved as the head page. Before the split,
fault_folio =3D=3D folio evaluates to true, so we bypass unlocking the foli=
o on
the assumption the caller owns the lock.

However, split_folio() leaves the new order-0 tail pages unlocked.
When the caller subsequently uses the now order-0 fault_page and calls
folio_unlock(page_folio(fault_page)), it will crash with
VM_BUG_ON_FOLIO(!folio_test_locked(folio)) because the tail page is
unlocked. In addition, the original head page lock will be permanently
leaked.

> +		if (fault_folio !=3D folio) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +	}
> +out:
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D5
