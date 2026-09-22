Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C50EC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660C10EB86;
	Tue, 22 Sep 2026 05:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LfLTxPF+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B05910EB86;
 Tue, 22 Sep 2026 05:49:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3D1C6020F;
 Tue, 22 Sep 2026 05:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AB11F000FF;
 Tue, 22 Sep 2026 05:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790056176;
 bh=c/GKfY1khZVA1eMuDcKGSWhMi1ml8GgKZ/b6otdwhDs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LfLTxPF+Bg7UwMGzbUF/s8ItBMwyrSIfZYAxAxQoHZ6IVXbcN96LtKdvEaP/dmwsO
 PTFz2gFg4WBWOztc4CPR7Iztz46Yx5cttG7aOBFelF0XmOjPh74FBkGAxqPjA2OLRu
 37E9Ahu82uVU29wyiIpRDwRgQTxebu06bQF4UrZ9q4CkMlQW65IJtllhAABANwmCHA
 Z0ZwD7kt/wjRFA4ZM38ynXdnUEGP+Qz6xLiZGtZGoqknoB6Glr2kCNUQWx7J1IoRvO
 VlS7xe7+PgVbBzUMvSbbXYESz8VOzliwyWf5pwkSwC4riYpEgcfLeyOc0xBBmpzs3L
 4qiXHMRGlCsEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/12] mm/hmm: preparations for HMM to participate
 in migration
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-4-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-4-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:49:35 +0000
Message-Id: <20260922054936.26AB11F000FF@smtp.kernel.org>
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
- [High] mm: hmm: migration range start address truncated on page walk retry
- [High] mm: hmm: unbalanced MMU notifier invalidation when dev_private_own=
er is NULL
- [High] mm: hmm: NULL pointer dereference in hmm_range_fault_unlocked_time=
out
--

commit 7ddb4b8635599a4339659239ade3b1bbc78ceec7
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

    mm/hmm: preparations for HMM to participate in migration
   =20
    For migration to happen after hmm_range_fault(), the vma has to
    retrieved. Luckily, pagewalk already resolves that for us, so
    just have to save it for further use. For migration, mmap_lock
    has to be hold for the whole operation, so vma stays stable.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 2f1e98c6b6440..be39d2e5403ab 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c

[ ... ]

> @@ -400,6 +407,57 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk =
*walk, unsigned long start,
>  }
>  #endif  /* CONFIG_ARCH_HAS_PMD_SOFTLEAVES */
> =20
> +static int hmm_vma_capture_migrate_range(unsigned long start,
> +					 unsigned long end,
> +					 struct mm_walk *walk)
> +{
> +	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
> +	struct hmm_range *range =3D hmm_vma_walk->range;
> +
> +	if (!hmm_select_migrate(range))
> +		return 0;
> +
> +	if (hmm_vma_walk->vma && (hmm_vma_walk->vma !=3D walk->vma))
> +		return -ERANGE;
> +
> +	hmm_vma_walk->vma =3D walk->vma;
> +	hmm_vma_walk->start =3D start;

[Severity: High]
Is the tracked start address unconditionally overwritten on every walk rest=
art?

If the walk requires a retry, returning -EBUSY, the outer loop restarts
walk_page_range() from the intermediate faulting address. On retry, could t=
his
clobber the tracking start with the intermediate address, leading to a
truncated start address?

> +	hmm_vma_walk->end =3D end;
> +
> +	if (end - start > range->end - range->start)
> +		return -ERANGE;
> +
> +	if (!hmm_vma_walk->mmu_range.owner) {

[Severity: High]
Could using the owner field as an initialization flag be problematic here?

If range->dev_private_owner is legitimately NULL, mmu_range.owner becomes
NULL. If a page fault retry occurs, the check passes again, causing a
duplicate mmu_notifier_invalidate_range_start(). Can this cause unbalanced
MMU notifier invalidation?

> +		mmu_notifier_range_init_owner(&hmm_vma_walk->mmu_range, MMU_NOTIFY_MIG=
RATE, 0,
> +					      walk->vma->vm_mm, start, end,
> +					      range->dev_private_owner);
> +		mmu_notifier_invalidate_range_start(&hmm_vma_walk->mmu_range);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hmm_vma_post_range_fault(struct hmm_vma_walk *hmm_vma_walk)
> +{
> +
> +	struct hmm_range *range =3D hmm_vma_walk->range;
> +
> +	if (hmm_select_migrate(range) &&
> +	    hmm_vma_walk->mmu_range.owner) {

[Severity: High]
Are we missing a call to mmu_notifier_invalidate_range_end() if the owner is
NULL?

Assuming a NULL owner means the invalidation was never started could
permanently leak the invalidation if dev_private_owner is legitimately NULL.

> +		/*
> +		 *  The migrate_vma path has the following initialized,
> +		 *  so take care of fault path below.
> +		 */
> +		if (range->notifier) {
> +			hmm_fill_migrate_vma(range,
> +					     hmm_vma_walk->vma,
> +					     hmm_vma_walk->start,

[Severity: High]
Will this propagate the truncated start address back to the caller's migrat=
ion
struct?

If the walk was retried and the start address was clobbered in
hmm_vma_capture_migrate_range(), it could cause the migration setup to
miscalculate the page count and read from the wrong array offset.

> +					     hmm_vma_walk->end);
> +		}
> +		mmu_notifier_invalidate_range_end(&hmm_vma_walk->mmu_range);
> +	}
> +}

[ ... ]

> @@ -694,19 +757,31 @@ static int hmm_range_fault_locked(struct hmm_range =
*range, bool *locked)
>  {
>  	struct hmm_vma_walk hmm_vma_walk =3D {
>  		.range =3D range,
> -		.locked =3D locked,
> +		.mmlocked =3D locked,
>  		.last =3D range->start,
>  	};
> -	struct mm_struct *mm =3D range->notifier->mm;
> +	/*
> +	 *  Could be serving a device fault or come from migrate
> +	 *  entry point. For the former we have not resolved the vma
> +	 *  yet, and the latter we don't have a notifier (but have a vma).
> +	 *
> +	 */
> +	struct mm_struct *mm =3D hmm_range_fault_mm(range);

[Severity: High]
How does this API change affect hmm_range_fault_unlocked_timeout()?

The patch modifies the HMM API to allow range->notifier to be NULL for
migration entry points, handling it gracefully here with
hmm_range_fault_mm(). However, looking at hmm_range_fault_unlocked_timeout()
in mm/hmm.c:

int hmm_range_fault_unlocked_timeout(struct hmm_range *range,
                                     unsigned long timeout)
{
        struct mm_struct *mm =3D range->notifier->mm;

It unconditionally dereferences range->notifier->mm at its very first line.=
 Can
this trigger a NULL pointer dereference if driver code passes a migration r=
ange
with a NULL notifier to the unlocked variant?

>  	int ret;
> =20
> +	/* Migration is incompatible with mmap lock drop */
> +	if (locked && hmm_select_migrate(range))
> +		return -EINVAL;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D3
