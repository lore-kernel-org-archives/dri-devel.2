Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4B2CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:15:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA8C10FD74;
	Wed, 14 Oct 2026 12:15:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E93E10FD6B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBC74600DA;
 Wed, 14 Oct 2026 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1671F000FF;
 Wed, 14 Oct 2026 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791980103;
 bh=Xw+uJwKhhgmiJPZk192FQIQdI+iU6jvIfKrqQj996rk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f+ELTsfOkZuv2kYDZ89ZGqu8KA+pYppIjlPTe3C4nvW9L4+hcm4H1PXVZs8EYfpJt
 yGdAiPx58E3AODqvz61YFYq7gnd5FDRjrRNsmRjeacd28ndHQz8bMJBJr0N0jWHPj1
 kOJKYZQoF6Rg3FTR5ivAF6ZndXTBVcQ4yuah/Aw5FZo6qroZ0KsYB8ZbJorTfIUXZ6
 qF+vOa4bZ+B69a6BLJw4f7JX6Nzvy0ljQr/QFTjxPq6Ipzb+0ar/bSB+65IwLrU/DC
 M0M2cDsqR8xWdaROl6id0XcAUo3rDeLV5ffpgc2xZaFVj+mo01lRJeQXXIzVZ8t9fi
 n21WYlEBTulWw==
Message-ID: <sashiko-outbox-171250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
To: "Konstantin Khorenko" <khorenko@virtuozzo.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 12:15:02 +0000
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
- [High] mm: NULL pointer dereference in zap_huge_pmd() for special PMDs on=
 PowerPC
--

commit 5100f57130de5473973d1370273238b4778fae24
Author: Konstantin Khorenko <khorenko@virtuozzo.com>

mm/huge_memory: recheck a special PMD under the lock in copy_huge_pmd()

copy_huge_pmd() reads the source PMD without the page table lock and,
for a special PMD, installs that value in the child without reading it
again under the lock. This commit reads the PMD again under the lock to
ensure it wasn't cleared concurrently by unmap_mapping_range().

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e5d68acf62a5..fcea98f0d8865 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struc=
t mm_struct *src_mm,
>  		src_ptl =3D pmd_lockptr(src_mm, src_pmd);
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>  		/*
> -		 * No need to recheck the pmd, it can't change with write
> -		 * mmap lock held here.
> -		 *
> -		 * Meanwhile, making sure it's not a CoW VMA with writable
> -		 * mapping, otherwise it means either the anon page wrongly
> -		 * applied special bit, or we made the PRIVATE mapping be
> -		 * able to wrongly write to the backend MMIO.
> +		 * The mmap and VMA write locks of the source keep faults
> +		 * out, but unmap_mapping_range() does not take the mmap
> +		 * lock and may have cleared the pmd since the lockless
> +		 * read. Let copy_pmd_range() skip it then.
> +		 */
> +		pmd =3D pmdp_get(src_pmd);
> +		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
> +			spin_unlock(src_ptl);
> +			spin_unlock(dst_ptl);
> +			return -EAGAIN;
> +		}
> +		/*
> +		 * Make sure it's not a CoW VMA with writable mapping,
> +		 * otherwise it means either the anon page wrongly applied
> +		 * special bit, or we made the PRIVATE mapping be able to
> +		 * wrongly write to the backend MMIO.
>  		 */
>  		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
>  		goto set_pmd;

[Severity: High]
Does this code cause a NULL pointer dereference on PowerPC when a special
PMD is unmapped by the child?

Because the jump to set_pmd bypasses pgtable allocation and deposition
for the child process's new special PMD, no pgtable is deposited.
Later, when the child unmaps the VMA or exits, zap_pmd_range() calls
zap_huge_pmd().

On architectures like PowerPC (hash mode) where
arch_needs_pgtable_deposit() is true, this leads to:

mm/huge_memory.c:zap_huge_pmd() {
    ...
    if (has_deposit)
        zap_deposited_table(mm, pmd);
    ...
}

This will unconditionally assume a deposited table exists and try to
withdraw it. Then in zap_deposited_table():

mm/huge_memory.c:zap_deposited_table() {
    ...
    pgtable =3D pgtable_trans_huge_withdraw(mm, pmd);
    pte_free(mm, pgtable);
    ...
}

Since no page table was ever deposited, pgtable_trans_huge_withdraw()
returns NULL, and passing NULL to pte_free() leads to a kernel crash.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-prep-vs=
tor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.co=
m?part=3D1
