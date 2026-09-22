Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3391CC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387A610EB73;
	Tue, 22 Sep 2026 05:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h/7Sw75S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F5D10E396;
 Tue, 22 Sep 2026 05:50:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74F116020F;
 Tue, 22 Sep 2026 05:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5081F000FF;
 Tue, 22 Sep 2026 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056217;
 bh=0jks0YzokmoiSuY0E9589SmbWo+NIquNspqdqqeg4+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h/7Sw75SxE+ffad/tQmVE/tsdni/q+sDSqzSDtC8CRbhVjzgFvWE0hWt9NFns2nHt
 l2+fxrj6r3uXj6VmJmWwrBDTP2gWV3h8P/ZPrLVTVGLkhRcB2CHP478VAGrtZVE6oG
 tdHSJGsWoBn1lY9u/6KoAEz984gkH4EpULI5Ix6NCFLPw9izhHPQ5N+vXIz8e8a0nu
 SgzUKBxxROJflaxgdZ2rBveuHWOqGk/+VSQ02eTcOl5YF+Jkxq3MIK+kR6r1Q4x7qE
 EWcl1wP+n8THZot2ybN0CJvS+81mp5HACilNySVABGodfu2kGXP1CizLLxSGHi2NIW
 fanlCPoPN2ccQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 04/12] mm/hmm: do the plumbing for HMM to
 participate in migration
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-5-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-5-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:50:16 +0000
Message-Id: <20260922055016.EA5081F000FF@smtp.kernel.org>
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
- [Critical] mm: missing TLB flush on error path in hmm_vma_walk_pmd()
- [High] mm: unbalanced mmu_notifier_invalidate_range_start() on -EINTR
--

commit 7a6e1d53570e6b253761aafa0e2f9a00e3b80665
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>
Subject: mm/hmm: do the plumbing for HMM to participate in migration

This commit prepares hmm_range_fault() and pagewalk callbacks for migration
by adding hmm_vma_handle_migrate_prepare_pmd() and managing PMD and PTE
locks across the pagewalk.

diff --git a/mm/hmm.c b/mm/hmm.c
index be39d2e5403ab..4805c88347e67 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -398,15 +480,72 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *=
walk, unsigned long start,
[ ... ]
> +static int hmm_vma_capture_migrate_range(unsigned long start,
> +					 unsigned long end,
> +					 struct mm_walk *walk)
> +{
> +	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +	struct hmm_range *range =3D hmm_vma_walk->range;
[ ... ]
> +	if (!hmm_vma_walk->mmu_range.owner) {
> +		mmu_notifier_range_init_owner(&hmm_vma_walk->mmu_range, MMU_NOTIFY_MIG=
RATE, 0,
> +					      walk->vma->vm_mm, start, end,
> +					      range->dev_private_owner);
> +		mmu_notifier_invalidate_range_start(&hmm_vma_walk->mmu_range);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does this mmu_notifier_invalidate_range_start() become unbalanced if the
fault path is interrupted?

When hmm_vma_capture_migrate_range() sets up the active range, the matching
mmu_notifier_invalidate_range_end() happens in hmm_vma_post_range_fault() at
the end of hmm_range_fault_locked().

However, hmm_range_fault_locked() has an early return for fatal signals:

mm/hmm.c:hmm_range_fault_locked() {
    ...
		if (ret =3D=3D HMM_FAULT_PENDING) {
			ret =3D hmm_do_fault(mm, &hmm_vma_walk);
			if (ret =3D=3D HMM_FAULT_UNLOCKED) {
				if (fatal_signal_pending(current))
					return -EINTR;
    ...

If we take this -EINTR return, does the MMU notifier range remain active
permanently, potentially hanging other invalidation threads?

@@ -465,46 +604,128 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
[ ... ]
>  	for (; addr < end; addr +=3D PAGE_SIZE, ptep++, hmm_pfns++) {
> -		int r;
> =20
>  		r =3D hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, hmm_pfns);
>  		if (r) {
> -			/* hmm_vma_handle_pte() did pte_unmap() */
> +			/* hmm_vma_handle_pte() did pte_unmap() / pte_unmap_unlock */
>  			return r;
>  		}

[Severity: Critical]
Can this early return bypass the TLB flush for pages unmapped in previous
iterations?

If hmm_vma_handle_migrate_prepare() sets unmapped =3D true in an earlier lo=
op
iteration, and then hmm_vma_handle_pte() returns an error on a subsequent
iteration, we immediately return r here.

Does this leave stale TLB entries in place for the previously unmapped page=
s,
since we skip the flush_tlb_range(walk->vma, start, addr) at the end of the
function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D4
