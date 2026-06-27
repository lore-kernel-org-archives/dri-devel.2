Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF64AC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 04:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5860C10E448;
	Sat, 27 Jun 2026 04:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YCIVVcqe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 893D310E448
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 04:10:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30EFC407AF;
 Sat, 27 Jun 2026 04:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0091F000E9;
 Sat, 27 Jun 2026 04:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782533436;
 bh=600H/TcEXzMbT+uYVvnEzo/XNkjluiZ8R0QHfXOkHNw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YCIVVcqejnWc7hhB4FXOiWhlC80ommInpC1TwfuuMoxvpmTR+wdBmiDpJRDZnatHi
 j3NLjunCqQIlCSAgmVLYsjmvfGz9rjUzZDTrIGiLqSpu2DJcvnuBpExmkp2Ci97Mo8
 pQJlu9h/PDEP9JRsAKTryREFWmvRy0R803ZR282S2bOP15/5g4C0chGSlG/bBQMasU
 wvlNQNQgnCt6tzpi0rtqA16/SOdyKHdWpCL70TYaIyJeTQXIsH4T8Qt9Zw+K90EsLJ
 eri9z+0cTXFDSwbQcSnkpeiTljsyboNXGBvLhBruJadU97gGXhH0pNkLPF5i0Vc116
 UYWTudbsBiT6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627035418.3796481-1-honglei1.huang@amd.com>
References: <20260627035418.3796481-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 04:10:35 +0000
Message-Id: <20260627041035.DF0091F000E9@smtp.kernel.org>
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
- [High] The page fault handler silently drops the `-EACCES` error and inco=
rrectly returns 0 (success) when migration to device memory is not permitte=
d, leading to an infinite page fault loop.
- [Medium] Concurrent lockless read of `migrate_devmem` races with bitfield=
 update of `unmapped`, causing undefined behavior (KCSAN warning).
--

commit d82186ac8e065d21c32eea3f706b65fa120ad8c5
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags

This commit splits the MM state flags (like unmapped and partial_unmap) out
of drm_gpusvm_pages_flags into a new drm_gpusvm_range_flags struct. It also
updates drivers to check these new range-level flags to avoid handling
unmapped pages.

Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-=
2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..df900553f21a4 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
[ ... ]
> @@ -1784,20 +1784,35 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
>  /**
>   * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
>   * @range: Pointer to the GPU SVM range structure.
> + * @pages: Pointer to the GPU SVM pages structure(s).
> + * @pages_count: Number of GPU SVM pages structure(s) passed in.
>   * @mmu_range: Pointer to the MMU notifier range structure.
>   *
>   * This function marks a GPU SVM range as unmapped and sets the partial_=
unmap flag
>   * if the range partially falls within the provided MMU notifier range.
>   */
>  void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
> +				   struct drm_gpusvm_pages *pages,
> +				   unsigned int pages_count,
>  				   const struct mmu_notifier_range *mmu_range)
>  {
> +	unsigned int i;
> +
>  	lockdep_assert_held_write(&range->gpusvm->notifier_lock);
> =20
> -	range->pages.flags.unmapped =3D true;
> +	range->flags.unmapped =3D true;

[Severity: Medium]
Will this direct bitfield assignment cause a data race?

This assignment generates a read-modify-write on the shared u16 word. If a
concurrent GPU page fault triggers __xe_svm_handle_pagefault() and does a
lockless read of range->base.flags.migrate_devmem, it can race with this
update and trigger undefined behavior.

The patch correctly uses a WRITE_ONCE on a union for pages[i].flags just
below this to prevent this exact issue. Is the same union and WRITE_ONCE
pattern needed here for range->flags?

> +	for (i =3D 0; i < pages_count; ++i) {
> +		struct drm_gpusvm_pages_flags flags =3D {
> +			.__flags =3D pages[i].flags.__flags,
> +		};
> +
> +		flags.unmapped =3D true;
> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> +		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> +	}
[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index b1e1ac26c66d9..63da149f3b7fd 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
[ ... ]
> @@ -1248,8 +1249,10 @@ static int __xe_svm_handle_pagefault(struct xe_vm =
*vm, struct xe_vma *vma,
> =20
>  	xe_svm_range_fault_count_stats_incr(gt, range);
> =20
> -	if (ctx.devmem_only && !range->base.pages.flags.migrate_devmem)
> -		return -EACCES;
> +	if (ctx.devmem_only && !range->base.flags.migrate_devmem) {
> +		err =3D -EACCES;
> +		goto out;
> +	}

[Severity: High]
Does this silently drop the -EACCES error?

Looking at the rest of __xe_svm_handle_pagefault(), the out label
unconditionally returns 0:

out:
	xe_svm_range_fault_us_stats_incr(gt, range, start);
	return 0;

err_out:
	if (err =3D=3D -EAGAIN) {

Jumping to out instead of returning the error (or jumping to err_out) signa=
ls
incorrect success for the unhandled GPU page fault. Could this lead to an
infinite page fault loop where the hardware continually retries and faults
again on the same address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627035418.3796=
481-1-honglei1.huang@amd.com?part=3D1
