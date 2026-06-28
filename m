Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652CAC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 06:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF9310E597;
	Sun, 28 Jun 2026 06:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XCBzao/U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA31110E597
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 06:38:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83672413D2;
 Sun, 28 Jun 2026 06:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C981F000E9;
 Sun, 28 Jun 2026 06:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782628737;
 bh=gOFaJZVyZ55aqH0b5ZjNXNys1I8JF3hnb4afRJ/Wu6I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XCBzao/UCeAd3OUlHsTEo08UcmL4ZDz4DbOcloDS2cAD9qIVCImhfxgZ7yk3UzQxg
 KB9omopvjddPCQ0+O6jJheXpKzu6t8MepBdwJFlg8th+9agtENYwswF3sWpkOUmo2L
 ZyOM6S8vi9GFCPFJsqbDWLzsVIKORA/iIhPOpyK9d/9m7B66pPpbVraDeZ796Sgao3
 qTd0oFF6V/LqzVh9pxfB9X4cV6A1MIZ+C04Rd1jt+LBlyqeYell54eYx8ceh6WGQkp
 3uJMbgEvgkn35rkoN1eMMWMSk65oW0Z1xRt/3EA24W7G2YftBXGHOGzoARZmwnt8Rv
 yYOfVI3HZtPNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628062518.4094189-2-honglei1.huang@amd.com>
References: <20260628062518.4094189-1-honglei1.huang@amd.com>
 <20260628062518.4094189-2-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 06:38:56 +0000
Message-Id: <20260628063857.35C981F000E9@smtp.kernel.org>
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
- [Medium] Data race on `drm_gpusvm_range_flags` bitfields due to concurren=
t lockless read of `migrate_devmem` and non-atomic read-modify-write of `un=
mapped`/`partial_unmap`.
--

commit aa71420929382a15e51348799bb5ab52f6b78fc7
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags

This commit splits the MM state flags (unmapped, partial_unmap, migrate_dev=
mem)
into a new drm_gpusvm_range_flags structure. It shrinks drm_gpusvm_pages_fl=
ags
and mirrors the unmapped state to backing pages.

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
> +	for (i =3D 0; i < pages_count; ++i) {
> +		struct drm_gpusvm_pages_flags flags =3D {
> +			.__flags =3D pages[i].flags.__flags,
> +		};
> +
> +		flags.unmapped =3D true;
> +		/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
> +		WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
> +	}
>  	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>  	    drm_gpusvm_range_end(range) > mmu_range->end)
> -		range->pages.flags.partial_unmap =3D true;
> +		range->flags.partial_unmap =3D true;
>  }

[Severity: Medium]
Can this cause a data race on drm_gpusvm_range_flags?

The MMU notifier path calls drm_gpusvm_range_set_unmapped() which performs a
non-atomic direct assignment to the bitfield range->flags.unmapped (and
potentially range->flags.partial_unmap). This translates to a read-modify-w=
rite
of the underlying u16 memory location.

Concurrently, __xe_svm_handle_pagefault() and xe_svm_range_needs_migrate_to=
_vram()
read range->base.flags.migrate_devmem locklessly, without holding the
notifier_lock.

While migrate_devmem itself is immutable after creation, reading and writing
bitfields concurrently without READ_ONCE() and WRITE_ONCE() on the shared _=
_flags
union violates the C memory model and can trigger KCSAN warnings or undefin=
ed
behavior.

Should range->flags use WRITE_ONCE(range->flags.__flags, ...) and
READ_ONCE(range->flags.__flags) exactly like pages[i].flags does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628062518.4094=
189-1-honglei1.huang@amd.com?part=3D1
