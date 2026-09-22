Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B133DC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B6210E396;
	Tue, 22 Sep 2026 05:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="luK6prjI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E00A10E396;
 Tue, 22 Sep 2026 05:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19D3E60213;
 Tue, 22 Sep 2026 05:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A05B1F000FF;
 Tue, 22 Sep 2026 05:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056298;
 bh=7R+lnbAktUO7NXOwBpWPHGUmWdVJ2uApbShhbKIFqFc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=luK6prjIUL0HdRlWV2YXcJ6per3dxGchw207zWCyiCuYfNs/cxL/7H/O6sMOBNz/X
 0t3uHK5cURoMsWlwozD0BMpI6kfceTlKfnDRDfx3LaDLpt8Mioej1L03Di1djYHxNA
 SKDO8qoWGczIxdHF5l1XBh1SwWSKimANYXM0F1RrNC5M4Cj8aesvqm9lzV7+1n4ZZ1
 EMF8PnQoRgVoLCVLmPoUmnB5vIQ8eZ1L1uPf5cpzk1W26yFUaCCq6NfyOL7UxElkSF
 HTdcCpTf1Ra2PvPW5v2HXpfq8Q3gh62ds4gzfi5HChE34iVkhP7DZlftliYecp86Y4
 iZTEOoL4k9FDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/12] mm/hmm: add lazy MMU mode support for
 migration in HMM pagewalk
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-9-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-9-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:51:38 +0000
Message-Id: <20260922055138.9A05B1F000FF@smtp.kernel.org>
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
- [High] mm: missing TLB flush on hmm_vma_handle_pte error path during migr=
ation
--

commit cabe68b53951d20b6fe5d611bd88bef73ab4ed62
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: add lazy MMU mode support for migration in HMM pagewalk

This commit adds calls to lazy_mmu_mode_enable() and lazy_mmu_mode_disable()
while performing migration in the HMM pagewalk paths.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index a1459bd34c04e..a67a23e545512 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -1178,6 +1184,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		flush_tlb_range(walk->vma, start, addr);

[Severity: High]
Does this skip a necessary TLB flush on the error path during migration?

If hmm_range_fault() with migration enabled successfully unmaps a page in t=
he
loop of hmm_vma_walk_pmd(), and then in the next loop iteration (for the sa=
me
PMD), hmm_vma_handle_pte() encounters a page requiring a fault, it drops the
PTE lock and returns an error:

hmm_vma_walk_pmd() {
        ...
        for (; addr < end; addr +=3D PAGE_SIZE, ptep++, hmm_pfns++) {
                r =3D hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_p=
fns);
                if (r) {
                        /* hmm_vma_handle_pte() did pte_unmap() / pte_unmap=
_unlock */
                        return r;
                }
        ...
}

Because the loop terminates with an immediate return, it completely bypasses
the flush_tlb_range() check shown below. Could this leave stale TLB entries
mapping old physical pages despite the page tables pointing to migration
entries, potentially causing data corruption if writes to the old page are
lost?

> =20
>  	if (hmm_vma_walk->ptelocked) {
> +		lazy_mmu_mode_disable();
>  		pte_unmap_unlock(ptep - 1, hmm_vma_walk->ptl);
>  		hmm_vma_walk->ptelocked =3D false;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D8
