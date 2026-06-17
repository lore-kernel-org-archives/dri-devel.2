Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAA1CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5A310EFA6;
	Wed, 17 Jun 2026 10:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxdPCDl+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1603A10EFA8
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:52:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB72544050;
 Wed, 17 Jun 2026 10:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4031F000E9;
 Wed, 17 Jun 2026 10:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781693548;
 bh=ZRneABNIrl832bsIV5sMZH9TqCi27nQeUjcOSYFddyw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mxdPCDl+ZALS0nUCKKdkgqAcM2U9jm1uY5oHEHS9N6x3vq5mXvvCZPoq0K1046pRL
 3Eo9FzTqRh54VQmOddrA5dvuWdjZlW1h6rORbzMvpF32Itt3gFaiy2EYPVljdKm01H
 ERyO0V5CVdz6tTnD2Ie9+Jt4vF+be67uOPGYboL0PnJiOnWkAVItO0JTFK8hwm7OGI
 H5+rBVUpcICaolunsYdrH7OmImAF7vhSEHHETlo1Brax5HrpE+GtUeXcdq2+oQMXH2
 ZaKoFZ4Q8FndxjQdo39rGM0cvbvzraUQgoXIQy4BB0x0U89TbkzBuaWPwb9dWEa0wh
 Hdpki6GAocw0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/gpusvm: move struct drm_gpusvm_pages out of
 struct drm_gpusvm_range
To: "Honglei Huang" <honglei1.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617103602.1491609-5-honglei1.huang@amd.com>
References: <20260617103602.1491609-1-honglei1.huang@amd.com>
 <20260617103602.1491609-5-honglei1.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 10:52:27 +0000
Message-Id: <20260617105228.0D4031F000E9@smtp.kernel.org>
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
- [Medium] Concurrent read-modify-write on `pages[i].flags.unmapped` bitfie=
ld causes a data race with lockless readers.
--

commit 48046c418df88520e7f847caa854ce19133469f6
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_range

This commit abstracts the tracking of physical pages from the MM VA range
in the DRM GPU SVM framework. It removes the embedded pages object from
drm_gpusvm_range, transferring the management of device physical pages
directly to the driver layer using drm_gpusvm_pages helpers.

> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 958cb605aedd5..bb186719b17c4 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c

[ ... ]

> @@ -1799,20 +1799,28 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
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
> +	for (i =3D 0; i < pages_count; ++i)
> +		pages[i].flags.unmapped =3D true;

[Severity: Medium]
Could this bitfield assignment introduce a regression by causing a data race
with lockless readers?

Since unmapped shares a 16-bit union (__flags) with has_devmem_pages and
has_dma_mapping, the C compiler implements this as a read-modify-write on
the entire 16-bit word.

Meanwhile, lockless readers like xe_svm_range_in_vram() in xe_svm.c read
this word concurrently:

xe_svm_range_in_vram() {
    struct drm_gpusvm_pages_flags flags =3D {
        /* Pairs with WRITE_ONCE in drm_gpusvm.c */
        .__flags =3D READ_ONCE(range->pages.flags.__flags),
    };
    ...
}

Does this unmarked RMW conflict with the lockless READ_ONCE(), potentially
allowing compiler load/store tearing? This regression might lead to KCSAN d=
ata
race splats or stale reads of has_devmem_pages.

To satisfy the C memory model, should writers use
WRITE_ONCE(pages[i].flags.__flags, new_flags.__flags) as is already done
in drm_gpusvm_get_pages()?

>  	if (drm_gpusvm_range_start(range) < mmu_range->start ||
>  	    drm_gpusvm_range_end(range) > mmu_range->end)
> -		range->pages.flags.partial_unmap =3D true;
> +		range->flags.partial_unmap =3D true;
>  }
>  EXPORT_SYMBOL_GPL(drm_gpusvm_range_set_unmapped);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617103602.1491=
609-1-honglei1.huang@amd.com?part=3D4
