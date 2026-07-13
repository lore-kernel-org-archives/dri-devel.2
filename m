Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCDCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BF610E5B1;
	Mon, 13 Jul 2026 10:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nH6YJMQ7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CD910E5B1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 10:09:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7514E6004E;
 Mon, 13 Jul 2026 10:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0202E1F000E9;
 Mon, 13 Jul 2026 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783937368;
 bh=GEHRFIoU/ec/IOV3MhQ3dq6ojA7P77sC+mgR0E23Gf0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nH6YJMQ71r3DKA90ounx2YVBdEGBIztD3+Cv4sFyYjeEOZ6iOBXj729HOa0L+gI65
 +nt6B9mxhXwv11zf6gEWaz7Hb9mDKxT/Ia5lu4ejFMtrXCUfz1EFcj7rgX3+kIsbaJ
 YA8MGxT8XpvuvPeiggy2y0ZDM9sIl8Jz9TsAbsQNnsLtJIm26QwTA71q2XC64CnEXa
 D+HrERz5RTdPTyjQfx6gKsxreeHJouCPtVf+ECiA89TRUqEotsTOtf90PRX8VE6Nfr
 OA89VgPLHzRooumT0k+isje9qMM6U+aBNwQwIr2kUZdo+4t3KcFai3WR19jlsL6pXU
 +QsJOH3djSDQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] drm/i915/gem: Remove iterator and use while loop
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713095812.1014365-6-krzysztof.karas@intel.com>
References: <20260713095812.1014365-1-krzysztof.karas@intel.com>
 <20260713095812.1014365-6-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 10:09:27 +0000
Message-Id: <20260713100928.0202E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Pinned folios are permanently leaked in the error path if an alloc=
ation fails before the scatterlist pointer `sg` is advanced past the first =
entry.
--

--- Patch [5]: [PATCH v3 5/5] drm/i915/gem: Remove iterator and use while l=
oop ---
commit f3eba03d9fc5ce905a11cce1578d72ea21a144f1
Author: Krzysztof Karas <krzysztof.karas@intel.com>

drm/i915/gem: Remove iterator and use while loop

This commit changes the main "for" loop into a "while" loop to get rid of
the obscure iterator "i" and use a more descriptive name to indicate how
many pages were already covered.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/=
i915/gem/i915_gem_shmem.c
> index 7c8de8fe0a225..66d0f8f6ffccb 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c

[ ... ]

> @@ -212,7 +211,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i91=
5, struct sg_table *st,
>  		}
> =20
>  		next_pfn =3D folio_pfn(folio) + folio_page_index + nr_pages;
> -		i +=3D nr_pages - 1;
> +		pages_done +=3D nr_pages;
> =20
>  		/* Check that the i965g/gm workaround works. */
>  		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >=3D 0x00100000UL);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error handling
in shmem_sg_alloc_table() in drivers/gpu/drm/i915/gem/i915_gem_shmem.c (aro=
und
line 228), is it possible to leak pinned folios?

If an allocation fails after successfully allocating the first folio(s) into
the first scatterlist entry, st->nents will be 1 but sg will still equal
st->sgl. The error path jumps to err_sg:

err_sg:
	sg_mark_end(sg);
	if (sg !=3D st->sgl) {
		shmem_sg_free_table(st, mapping, false, false);
	} else {
		mapping_clear_unevictable(mapping);
		sg_free_table(st);
	}

Since sg =3D=3D st->sgl, this takes the else branch and bypasses
shmem_sg_free_table(), leaving the folios in the first scatterlist entry
pinned. Would checking if (st->nents > 0) be more appropriate here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713095812.1014=
365-1-krzysztof.karas@intel.com?part=3D5
