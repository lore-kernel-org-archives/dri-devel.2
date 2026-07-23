Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C0CC44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1615610E2FD;
	Thu, 23 Jul 2026 08:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UjmYmpoM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344B110E2FD
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:29:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF14D4363E;
 Thu, 23 Jul 2026 08:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6DB1F000E9;
 Thu, 23 Jul 2026 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784795346;
 bh=GETfjsiJTn9pVSCi3BCxvf3rRmEVVRN+pFiUV+pM4Ko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UjmYmpoM3jeDUPHBcw3w608RzGZACaD1T6is089Cj7v/sKKePewIRUGqsbTioMDBu
 sxF5LUc7dxLFtqFdgKsvMg1p47mEwMY5Rg3/P/mHABwQEZyjYqH2b8J8wGS/wX8RQX
 9l6mCUhQuhLmftu7ygFlmKvxzTo3yBSCP/djBjMs0TKK7OcQB1CqOoHzlQoDsd3stb
 eVguSiJ/GBfSd5y3EjkYA1iaeKu0l/1dpbTt6XSrj0nnRdEisL0xEMnC0t6Z+iozKA
 nJg+0dVlBode4955SvZycsad4VIEHF16iCy+TIesXziMj3YnxiSCOUJqTFKo0o4C3v
 HEyUenNYzzVNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] lib/test_hmm: remove dead NULL checks after
 GFP_NOFAIL allocations
To: "Gou Hao" <gouhao@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723081813.176792-4-gouhao@uniontech.com>
References: <20260723081813.176792-1-gouhao@uniontech.com>
 <20260723081813.176792-4-gouhao@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 08:29:06 +0000
Message-Id: <20260723082906.9F6DB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked return value from folio_alloc() leading to a NULL pointe=
r dereference under memory pressure.
- [High] VMA iteration on an external mm_struct is performed without checki=
ng if the address space is stable.
--

--- Patch [3]: [PATCH 3/4] lib/test_hmm: remove dead NULL checks after GFP_=
NOFAIL allocations ---
commit f8d849c03b7bcb5aa594e8169391ebb8d17dfdcc
Author: Gou Hao <gouhao@uniontech.com>

lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations

This commit removes unreachable NULL checks for kvcalloc() allocations
that use the __GFP_NOFAIL flag. Since __GFP_NOFAIL guarantees the
allocation will succeed, checking the return value is unnecessary.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 9c59d1ceb5b57..d615e4e5fc447 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -1209,16 +1209,10 @@ static int dmirror_migrate_to_device(struct dmirr=
or *dmirror,
>  	if (!mmget_not_zero(mm))
>  		return -EINVAL;
> =20
> -	ret =3D -ENOMEM;
>  	src_pfns =3D kvcalloc(PTRS_PER_PTE, sizeof(*src_pfns),
>  			  GFP_KERNEL | __GFP_NOFAIL);
> -	if (!src_pfns)
> -		goto free_mem;
> -
>  	dst_pfns =3D kvcalloc(PTRS_PER_PTE, sizeof(*dst_pfns),
>  			  GFP_KERNEL | __GFP_NOFAIL);
> -	if (!dst_pfns)
> -		goto free_mem;
> =20
>  	ret =3D 0;
>  	mmap_read_lock(mm);

[Severity: High]
This is a pre-existing issue, but is it safe to iterate over the VMAs
of an external mm_struct here without first verifying the address space
is stable?

As noted in the MM subsystem guidelines, when iterating over VMAs on an
external mm_struct, we need to ensure the tree is stable:

lib/test_hmm.c:dmirror_migrate_to_device() {
    ...
    mmap_read_lock(mm);
    for (addr =3D start; addr < end; addr =3D next) {
        vma =3D vma_lookup(mm, addr);
    ...
}

If the target process is OOM-killed or fails dup_mmap(), the maple tree
could contain XA_ZERO_ENTRY markers, which might cause vma_lookup()
or the traversal to crash. Could this code call check_stable_address_space(=
mm)
right after acquiring the mmap lock?

[Severity: High]
This is another pre-existing issue in the same file, but could a failed
memory allocation cause a NULL pointer dereference under memory pressure?

In dmirror_device_evict_chunk(), folio_alloc() is called without the
__GFP_NOFAIL flag, but the return value is not checked before use:

lib/test_hmm.c:dmirror_device_evict_chunk() {
    ...
    dpage =3D folio_page(folio_alloc(GFP_HIGHUSER_MOVABLE,
                  order), 0);
    lock_page(dpage);
    ...
}

If folio_alloc() returns NULL due to memory pressure, folio_page() evaluates
to NULL, which is then unconditionally passed to lock_page(). Would it make
sense to add a NULL check here, or perhaps use __GFP_NOFAIL if the allocati=
on
is truly required to succeed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723081813.1767=
92-1-gouhao@uniontech.com?part=3D3
