Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F8C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5351110E57A;
	Thu, 23 Jul 2026 11:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VjFR9/yy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5876710E57A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:39:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBDA640C3A;
 Thu, 23 Jul 2026 11:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C951F000E9;
 Thu, 23 Jul 2026 11:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784806792;
 bh=hb1H31aETczk+Uno+nMEjNd1CiZc+MyC+tHcnqxd2XQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VjFR9/yyjR60ktOlzYDGAPvnU5EZvDSmu1FzxhNdycufk0quGZDB5iFsoG78MfQp2
 FHw8IdmNHooih7gaJHRagdFS5QX+27SsFRVOMJzft4Wdfo6yo90jhVi1tITTXon6pa
 lvo18uZL4vMOHICRqfDx4Ni9zImJ7movOwVrBCqqknQqGGn4cxMkSRhmPvqrcgYg7P
 PpxRlJhYbSx73WWV0vj5MqyEoM8PYgFwo1Bycz39kYtBjqfA0Fpi6yG18+iECsHkwo
 giiEHUIi+avXUrObvGL4h4LESDznjWm4qhyH8+bZ6LhzoLdPs8pml/gMpMdZxyCR8p
 rt4tb7o1LXmJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] drm/i915/gem: Remove iterator and use while loop
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723102542.3245495-6-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
 <20260723102542.3245495-6-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:39:51 +0000
Message-Id: <20260723113952.79C951F000E9@smtp.kernel.org>
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

New issues:
- [High] Flawed scatterlist length overflow check bypasses overflow protect=
ion, causing IOVA truncation and IOMMU page table corruption.

Pre-existing issues:
- [High] Pre-existing memory leak in `shmem_sg_alloc_table` error path when=
 scatterlist allocation fails after adding one or more folios to the first =
segment.
--

--- Patch [5]: [PATCH v4 5/5] drm/i915/gem: Remove iterator and use while l=
oop ---
commit 08123ce95aacd0e0eea7518e3cd7a5c53bd75933
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Remove iterator and use while loop

This commit refactors the main loop in shmem_sg_alloc_table to use a while
loop instead of a for loop. It replaces the iterator with a variable tracki=
ng
the completed pages.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index ac8022997553b..f8fe5e3a4eb40 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
[ ... ]
> @@ -223,7 +223,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  		 * and predict where the next folio begins.
>  		 */
>  		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
> -		i +=3D nr_pages - 1;
> +		pages_done +=3D nr_pages;
> =20
>  		/* Check that the i965g/gm workaround works. */
>  		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >=3D 0x00100000UL);

[Severity: High]
This is a pre-existing issue, but does this error path leak folios if we fa=
il
while sg =3D=3D st->sgl?

Looking at shmem_sg_alloc_table() in drivers/gpu/drm/i915/gem/i915_gem_shme=
m.c:

err_sg:
    sg_mark_end(sg);
    if (sg !=3D st->sgl) {
        shmem_sg_free_table(st, mapping, false, false);
    } else {
        mapping_clear_unevictable(mapping);
        sg_free_table(st);
    }

If the scatterlist allocation fails after adding one or more folios to the
first segment, we jump to err_sg. At this point, no second scatterlist
segment was created, so sg still points to st->sgl.

The condition sg !=3D st->sgl evaluates to false, causing us to skip
shmem_sg_free_table(). Does this mean the folios placed in the first segment
are never released, resulting in a memory leak under memory pressure?


[Severity: High]
Can the overflow check be bypassed in iommu_dma_map_sg() within
drivers/iommu/dma-iommu.c?

iommu_dma_map_sg() {
    ...
    if ((s_length & UINT_MAX) =3D=3D 0) {
        /* Prevent possible wrapping upon assignment to s->length. */
        ret =3D -EOVERFLOW;
        goto out_restore_sg;
    }
    ...
}

If a caller maps a buffer larger than 4GB where the alignment calculation
causes s_length + s_iova_off to exceed UINT_MAX, but the lower 32 bits of
the aligned size are non-zero (for example, 0x100010000 with 64KB granules),
the bitwise check evaluates to false.

Does this bypass the intended overflow detection, causing iommu_map_sg() to
map a truncated number of bytes and potentially leading to unmapped IOVAs
remaining accessible via DMA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723102542.3245=
495-1-krzysztof.karas@intel.com?part=3D5
