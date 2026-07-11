Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15D6C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 19:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED1210E042;
	Sat, 11 Jul 2026 19:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="byn/wrUB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D12E10E042
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:12:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5FA543717
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB171F000E9;
 Sat, 11 Jul 2026 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783797142;
 bh=4Xj1cHf3H1BsDr7jUiIVt4ycYWqevI9VLamg3dWDzCg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=byn/wrUBWdxHiMHf9MFxQszMRkhIfFbRL0s482Oad6te3inQRIeNcJQ1mDc2BaoZ+
 M9hZcMzVOQOsjnbxJz/uz6OiAeUkaQXVJ0OrWOWQm4gUtNIswQKuTJkcMTuQ8bXiOI
 YdMXeShsUzLZ9HkM6EI/Mgvvj6gYi7YAdPbApkvHBK7z5tFSFuItSnX0VVPFJAYafV
 mx5fs78NRAZSmJwUipj033KHt0YC4T6AvXanwwt7Yu+Evbhvb/FnPVNIT0YZTtyYgX
 yglieZTm1ftGECM6JQRq/OTjTRNrWBwyWTjXJP+HVms+wwR2EUiO/oXFTVjXjIFVuA
 nzXKKd7plXVFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] mm/mlock: convert mlock code to use vma_flags_t
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-b4-vma-flags-mm-v2-11-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
 <20260711-b4-vma-flags-mm-v2-11-0fa2357d5431@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 19:12:22 +0000
Message-Id: <20260711191222.9CB171F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Page table walk callbacks trigger an infinite loop when pte_offset=
_map_lock() fails.
--

--- Patch [11]: [PATCH v2 11/13] mm/mlock: convert mlock code to use vma_fl=
ags_t ---
commit 4497d6e0c6929dd585b156beb8ad3252bc077a68
Author: Lorenzo Stoakes <ljs@kernel.org>

mm/mlock: convert mlock code to use vma_flags_t

Replace use of the legacy vm_flags_t flags with vma_flags_t values
throughout the mlock logic. No functional change intended.

> diff --git a/mm/mlock.c b/mm/mlock.c
> index 34ffa954006fb..efa6716e4dfbd 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c

[ ... ]

> @@ -368,7 +368,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long =
addr,
>  		folio =3D pmd_folio(*pmd);
>  		if (folio_is_zone_device(folio))
>  			goto out;
> -		if (vma->vm_flags & VM_LOCKED)
> +		if (vma_test(vma, VMA_LOCKED_BIT))
>  			mlock_folio(folio);
>  		else
>  			munlock_folio(folio);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this functio=
n, I
noticed a potential infinite loop in mlock_pte_range().=20

When pte_offset_map_lock() returns NULL (for example, when encountering a
non-present PMD migration entry during concurrent THP migration), the callb=
ack
sets ACTION_AGAIN and returns 0:

	start_pte =3D pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
	if (!start_pte) {
		walk->action =3D ACTION_AGAIN;
		return 0;
	}

Does this cause walk_pmd_range() to continuously retry without yielding the
CPU?=20

Because the function returns 0, it entirely bypasses the cond_resched()
call at the end of mlock_pte_range(). Meanwhile, ACTION_AGAIN instructs
walk_pmd_range() to jump to its retry label and re-process the exact same
PMD.=20

Could an unprivileged user space process trigger a soft or hard CPU lockup
by calling mlock() on a memory range during a concurrent migration?

I also noticed this exact same pattern appears in other page walk callbacks
that return 0 with ACTION_AGAIN when pte_offset_map_lock() fails, such as
queue_folios_pmd(), mincore_pte_range(), smaps_pte_range(),
pagemap_pmd_range(), gather_pte_stats(), clear_refs_pte_range(), and
pagemap2_pte_range().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-b4-vma-fla=
gs-mm-v2-0-0fa2357d5431@kernel.org?part=3D11
