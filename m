Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96888C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 19:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E293A10E08B;
	Sat, 11 Jul 2026 19:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gw/jTffQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A449710E08B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C139A60052
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 19:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565891F000E9;
 Sat, 11 Jul 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783797292;
 bh=nAqD/lKv0PcncDYCe9ZVqQnlJzn+e728rZ7oF2lErdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gw/jTffQsqgXqPFERnM3977sz4UJZ67LBBfy+Q9ldry945hX4AIT0U1/eSQ68oemW
 Ai2M3eajmLduNdpX7wwxpphqrNeg7LL/gXgY/h/gcXiBq7jmqzqdWGajERSAmQpe6Y
 tLE9LppPIkY5EpMoq/8muCG5tCXx+hoXqSkqDZkSnN9R+nStQDodwFOefRafVWIJDu
 /aHtUF0+yGKfCIbra0ZO+Dr2RcZDGA7NR0OwUqReSZJWLB8hDFE2144flaNS05g21f
 O0TKCUE2W7g/yfFfki25bsdNo8/Jq4isBPvjRl7+NcCzt9QSjhCZMYdJnEijEkLjK1
 DPf0AKNHKsoTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] mm/mremap: convert mremap code to use vma_flags_t
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711-b4-vma-flags-mm-v2-13-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
 <20260711-b4-vma-flags-mm-v2-13-0fa2357d5431@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 19:14:51 +0000
Message-Id: <20260711191452.565891F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Permanent leak of `vm_committed_as` committed memory when `do_vmi_=
munmap()` fails in `unmap_source_vma()`.
- [High] Permanent leak of `vm_committed_as` (delta size) in the `move_vma(=
)` error path when page table moves fail.
- [High] Permanent leak of `mm->locked_vm` when `MREMAP_DONTUNMAP` is calle=
d on a locked VMA.
- [High] `mremap_to()` with `MREMAP_SHRINK` permanently inflates committed =
memory by failing to reset `vrm->delta`.
--

--- Patch [13]: [PATCH v2 13/13] mm/mremap: convert mremap code to use vma_=
flags_t ---
commit 2acb878e611c682f5c4e70b5f73085e003532a49
Author: Lorenzo Stoakes <ljs@kernel.org>

mm/mremap: convert mremap code to use vma_flags_t

This commit replaces legacy vm_flags_t with vma_flags_t bitwise values
across the mremap codebase. It updates flag modification functions to their
corresponding vma_* counterparts. No functional changes are intended.

> diff --git a/mm/mremap.c b/mm/mremap.c
> index 384ef4cc2195b..b64aa1f6e07ed 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c

[ ... ]

> @@ -985,7 +985,7 @@ static bool vrm_calc_charge(struct vma_remap_struct *=
vrm)
>  {
>  	unsigned long charged;
> =20
> -	if (!(vrm->vma->vm_flags & VM_ACCOUNT))
> +	if (!vma_test(vrm->vma, VMA_ACCOUNT_BIT))
>  		return true;

[Severity: High]
This isn't a bug introduced by this patch, but since we're updating the
accounting logic here, could this lead to a committed memory leak when
handling a shrink operation?

When mremap_to() processes MREMAP_SHRINK, it sets vrm->old_len to
vrm->new_len but appears to leave vrm->delta at its original value. When
vrm_calc_charge() is subsequently called during move_vma(), it uses
vrm->delta to charge new committed memory, effectively re-charging the
memory that was just shrunk.

Does this permanently inflate vm_committed_as under strict overcommit?

[ ... ]

> @@ -1195,7 +1195,7 @@ static void unmap_source_vma(struct vma_remap_struc=
t *vrm)
>  	 * portions of the original VMA that remain.
>  	 */
>  	if (accountable_move) {
> -		vm_flags_clear(vma, VM_ACCOUNT);
> +		vma_clear_flags(vma, VMA_ACCOUNT_BIT);
>  		/* We are about to split vma, so store the start/end. */
>  		vm_start =3D vma->vm_start;
>  		vm_end =3D vma->vm_end;

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak of committed
memory here during error handling in unmap_source_vma().

If do_vmi_munmap() fails shortly after this block (e.g., due to OOM when
splitting an adjacent VMA), the error path calls vm_acct_memory() but
returns early without restoring VMA_ACCOUNT_BIT on the surviving VMA:

	if (err) {
		/* OOM: unable to split vma, just get accounts right */
		vm_acct_memory(len >> PAGE_SHIFT);
		return;
	}

Because the bit is stripped, will the system permanently leak this charge
since do_vmi_munmap() won't unaccount it when the VMA is eventually torn
down?

[Severity: High]
This is also a pre-existing issue on the same path. Can this lead to a
similar leak if move_page_tables() fails inside copy_vma_and_data()?

In that scenario, copy_vma_and_data() assigns new_vma to vrm->vma and
returns an error. Then, move_vma() invokes unmap_source_vma() to clean up
new_vma.

This block will strip VMA_ACCOUNT_BIT from new_vma before unmapping
it, which seems to prevent do_vmi_munmap() from uncharging the delta added
earlier by vrm_calc_charge().

[ ... ]

> @@ -1330,8 +1332,8 @@ static void dontunmap_complete(struct vma_remap_str=
uct *vrm,
>  	unsigned long old_start =3D vrm->vma->vm_start;
>  	unsigned long old_end =3D vrm->vma->vm_end;
> =20
> -	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
> -	vm_flags_clear(vrm->vma, VM_LOCKED_MASK);
> +	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
> +	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);

[Severity: High]
This is a pre-existing issue, but could stripping the locked mask here leak
the mm->locked_vm count?

By clearing VMA_LOCKED_MASK unconditionally from the old VMA without
decrementing mm->locked_vm or unlocking the pages, it seems the old VMA
will no longer account for its locked pages when it is eventually unmapped.

Since move_vma() already added the new VMA's size to mm->locked_vm, does
this permanently inflate the process's locked memory count?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711-b4-vma-fla=
gs-mm-v2-0-0fa2357d5431@kernel.org?part=3D13
