Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B919FC98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BE310F367;
	Thu, 24 Sep 2026 07:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QXd0YnWz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FBA10F367;
 Thu, 24 Sep 2026 07:16:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADE6441076;
 Thu, 24 Sep 2026 07:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACA41F000FF;
 Thu, 24 Sep 2026 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790234168;
 bh=EzoKA7522s9DKLOzrIGayti3wV0kNBLex7i/R1GOzgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QXd0YnWz048gIvZ+VCClVLMF8njL9GFQhkmrOyEgFOWjei7eVEJdXtzWyyQNQmiD1
 MolPtQfzFtsXvb3kE6ZdknobyZtFDL7Av5Ht0l4Y5LprL2nY31+YjiKSh5elWYfH+y
 eVgNTzkpNJG3o7foJL5SQzwJwk0r1z1sjG749IhWZ0edUfqM+wPqB7sPZemw4x6MKl
 lMoCCgpKVY7CA706C/pOVysFuJtluzCgtb7O5JGJ13oh1TfZ1KzUMM0LReUlh6JnKZ
 MSR42QCsErkqsUe38x3rFLhXWXEyCyIXFeQTuy1G94O58eggU9+OkxqIuWn4fN6l/D
 i3DqMU8ZZKTNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 08/11] mm/hmm: implement rollback for device page
 migration in HMM pagewalk
To: mpenttil@redhat.com
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924065313.899730-9-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
 <20260924065313.899730-9-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 07:16:07 +0000
Message-Id: <20260924071608.5ACA41F000FF@smtp.kernel.org>
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
- [Critical] mm: memory corruption via uninitialized PFN unlock/put during =
rollback
- [High] mm: infinite loop in hmm_range_fault_locked on failed THP split
- [Medium] mm: lost per-PFN input flags on hmm rollback preventing correct =
retries
--

commit 773397c69855b5d4adbb7a21c81d362234a475a7
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/hmm: implement rollback for device page migration in HMM pagewalk

During the migration pagewalk, the PTE table could be cleared
and/or changed into PMD leaf or even another PTE table while
dropped locks.

In these cases the possibly inserted migration ptes are gone.
We have to however undo the collecting done so far, so unlock
the folios and drop reference taken.

[ ... ]

> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 4f56f3419cb46..b08ebc1343dd9 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -111,6 +111,28 @@ static inline unsigned int hmm_pfn_to_map_order(unsi=
gned long hmm_pfn)
>  	return (hmm_pfn >> HMM_PFN_ORDER_SHIFT) & 0x1F;
>  }
> =20
> +/*
> + * hmm_pfn_collected() - is this pfn entry prepared for migration ?
> + * If collected the folio's refcount is increased and the folio
> + * is locked.
> + */
> +static inline bool hmm_pfn_collected(unsigned long hmm_pfn)
> +{
> +	return (hmm_pfn & (HMM_PFN_VALID | HMM_PFN_MIGRATE)) =3D=3D
> +		(HMM_PFN_VALID | HMM_PFN_MIGRATE);
> +}
> +
> +/*
> + * hmm_pfn_rollback_collected() - undoes the collection of hmm_pfn
> + *
> + * Note for total rollback the folio's refcount has to be put
> + * and folio has to be unlocked.
> + */
> +static inline unsigned long hmm_pfn_rollback_collected(unsigned long hmm=
_pfn)
> +{
> +	return hmm_pfn & ~(HMM_PFN_VALID | HMM_PFN_MIGRATE | HMM_PFN_COMPOUND);
> +}

[Severity: Medium]
Will hmm_pfn_rollback_collected() destroy the user's per-PFN request flags?

When pte_offset_map_lock() fails in hmm_vma_walk_pmd(),
hmm_vma_handle_migrate_prepare_rollback() is called on unprocessed entries.
This clears HMM_PFN_VALID and HMM_PFN_MIGRATE here. Because input flags
(HMM_PFN_REQ_FAULT and HMM_PFN_REQ_MIGRATE) share the exact same bit
definitions as the output flags, this effectively destroys the user's reque=
st
flags.

If the outer loop retries the walk, will it see no request flags for these
pages and silently skip them?

> +
>  /*
>   * struct hmm_range - track invalidation lock on virtual address range
>   *
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9fdd945cc0266..daf83f8091518 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -412,6 +421,9 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, u=
nsigned long addr,
> =20
>  	new_pfn_flags =3D pte_pfn(pte) | cpu_flags;
>  out:
> +	hmm_vma_handle_migrate_prepare_rollback(hmm_vma_walk, addr,
> +						addr + PAGE_SIZE,
> +						hmm_pfn);
>  	*hmm_pfn =3D (*hmm_pfn & HMM_PFN_INOUT_FLAGS) | new_pfn_flags;
>  	return 0;

[Severity: Critical]
Can this regression lead to memory corruption via an uninitialized PFN
unlock/put?

Here hmm_vma_handle_migrate_prepare_rollback() is called before the
individual hmm_pfn entry is populated with new_pfn_flags, meaning it reads
and acts on the user's input flags.

If a user calls hmm_range_fault() to request migration using per-PFN flags
(setting HMM_PFN_REQ_MIGRATE | HMM_PFN_REQ_FAULT, which map directly to
HMM_PFN_MIGRATE | HMM_PFN_VALID), hmm_pfn_collected() will incorrectly
evaluate to true.

This causes hmm_vma_handle_migrate_prepare_rollback() to extract the PFN
part (typically 0), cast it to a folio, and attempt to unlock/put it:

hmm_vma_handle_migrate_prepare_rollback() {
	...
	folio =3D page_folio(hmm_pfn_to_page(hmm_pfn[i]));
	if (folio !=3D fault_folio)
		folio_unlock(folio);
	folio_put(folio);
	...
}

[ ... ]

> @@ -1117,6 +1190,9 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		if (ptep) {
>  			lazy_mmu_mode_enable();
>  			hmm_vma_walk->ptelocked =3D true;
> +		} else {
> +			/* The pte table is gone */
> +			hmm_vma_handle_migrate_prepare_rollback(walk->private, addr, end, hmm=
_pfns);
>  		}
>  	} else {
>  		ptep =3D pte_offset_map(pmdp, addr);

[Severity: High]
Is there an infinite loop in hmm_range_fault_locked() when a THP split fail=
s?

When hmm_vma_handle_migrate_prepare_pmd() attempts to split a PMD-mapped THP
via __migrate_vma_split_folio(), the split can fail and return -EBUSY. It
propagates this -EBUSY directly to hmm_vma_walk_pmd() without updating
hmm_vma_walk->last:

hmm_vma_handle_migrate_prepare_pmd() {
	...
	r =3D __migrate_vma_split_folio(folio, migrate->fault_page);
	if (r)
		return r;

	hmm_vma_walk->last =3D start;
	return -EBUSY;
}

However, hmm_vma_walk_pmd() handles -EBUSY as a success sentinel meaning
"split succeeded, please re-walk":

		/*
		 * hmm_vma_handle_migrate_prepare_pmd() splits the huge pmd in
		 * place when needed and returns -EBUSY to re-walk the range as
		 * PTEs; any other error means the split failed.
		 */
		if (r =3D=3D -EBUSY)
			return -EBUSY;

This propagates the -EBUSY to walk_page_range(), and the outer loop in
hmm_range_fault_locked() restarts the walk from hmm_vma_walk.last (which was
not advanced). It encounters the exact same THP, fails to split it again,
and loops infinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924065313.8997=
30-1-mpenttil@redhat.com?part=3D8
