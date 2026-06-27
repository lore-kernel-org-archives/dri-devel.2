Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207ACC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 05:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE0510E45E;
	Sat, 27 Jun 2026 05:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gKwezYO2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144F710E45E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 05:55:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 22294600AA;
 Sat, 27 Jun 2026 05:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A41F000E9;
 Sat, 27 Jun 2026 05:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782539752;
 bh=RjRjt91ZQusV5v07nHICEpZEpp4mASPt1J1N1CGnXp4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gKwezYO28GNM0Voos6hGTmpkPf1SYAP5KqMs3HBhJc9RdyeUzDIN49XKLHmdjhTnS
 zPGrdWxflKf0QxuLWDLfk/NfuiPH72KUoHK7CIBcb8Dwe6dlAiQ7p12Gr6dUeUzcyj
 6RyAb80o5tgB3yiIP4UnZvrvHgu3dyMxBbk6qx4CFXVILuXXtLgQO4G3PvWjYwuTFU
 O58ElPjfKiAlrtzpHMaKSXMZZspofL7UnOISVooSRn6alsLgy5ieJb1PVcMl78M+OV
 QFeHmM2bK/3lX4xLHagp8zQlhiPqsFY84Px2q3Ln0AeCat5aJSuQ7ZzrYA+h0KW4RE
 w9z4HDcO5dyOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627034303.3795627-2-honglei1.huang@amd.com>
References: <20260627034303.3795627-1-honglei1.huang@amd.com>
 <20260627034303.3795627-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 05:55:52 +0000
Message-Id: <20260627055552.A93A41F000E9@smtp.kernel.org>
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
- [High] The -EACCES error code is silently swallowed in `__xe_svm_handle_p=
agefault()`, causing an infinite page fault loop.
- [Medium] Bitfield updates to `range->flags` race with lockless reads of `=
migrate_devmem`, causing undefined behavior.
--

commit 2033c4f597ae276e3dc70c93dc50a6a05f5c821a
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags

This commit splits the MM virtual-address state flags and device mapping
state flags into separate structures. It introduces drm_gpusvm_range_flags
on drm_gpusvm_range to hold the unmapped and migrate_devmem state, keeping
drm_gpusvm_pages_flags strictly for mapping state.

Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-=
2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..df900553f21a4 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
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
Will this bitfield assignment cause a data race?

Since range->flags.unmapped and range->flags.migrate_devmem share the same
underlying 16-bit union (struct drm_gpusvm_range_flags), this assignment
generates a read-modify-write of the whole word.

Meanwhile, __xe_svm_handle_pagefault() reads range->base.flags.migrate_devm=
em
locklessly. This concurrent access to the bitfields could lead to torn
reads or KCSAN warnings. Should this be updated using WRITE_ONCE() or a
similar atomic operation like the loop below does for pages[i].flags.__flag=
s?

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
Does this goto unintentionally swallow the -EACCES error?

Looking at __xe_svm_handle_pagefault() in drivers/gpu/drm/xe/xe_svm.c:

out:
	xe_svm_range_fault_us_stats_incr(gt, range, start);
	return 0;

The out label unconditionally returns 0 instead of returning err. By
returning success without actually mapping the pages, won't the GPU
immediately retry the access and enter an infinite page fault loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627034303.3795=
627-1-honglei1.huang@amd.com?part=3D1
