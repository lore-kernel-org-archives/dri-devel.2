Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71190C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 03:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE47F10E707;
	Sat, 11 Jul 2026 03:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WPK030W4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E97710E707
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 03:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9BBB43435;
 Sat, 11 Jul 2026 03:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA921F000E9;
 Sat, 11 Jul 2026 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783740289;
 bh=xD2av9+/cUXTJua2sSznSIlG80mM5T4hxYSrY0PgrWg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WPK030W4dWFY/Upc5K+lQUFdVjdE3gXt1Ghy+n510JrrAwg3yk36Iyw7ARtKxP9s3
 ewC05uZFu8ZWLrVhs4DPI3PCIZZTLT0juxr1PjqnoI/80A8DxxbXST17tx5gDonI09
 xX2mEHnHEP2lw5V/U9Ks+SGRIrcxA5EgUvUMAyfw5XXc23IrGEeRJqJtevRyyuZvni
 SMB9tdnITdYvFvxnPoX/8Q43Gjxrm30zGfsfX0Fh2+Jl3jLWY/ezDQUVKIVM0GrBpr
 HlTDXfouRCHYkvdQcOHSonyYl+PWin93mT9TXbX81Tfd6qbq5gALWMlHLiAXgiIHRG
 2C/XAWlMyVCMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 31/33] drm/xe: Blit src-natural to dst-packed for
 defrag-IOVA copies
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711025619.2540575-32-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-32-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 03:24:49 +0000
Message-Id: <20260711032449.9CA921F000E9@smtp.kernel.org>
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
- [Critical] Overloading `dst_packed_pages =3D=3D 0` to mean 'not a packed =
destination' causes out-of-bounds cursor access and memory corruption when =
a packed defrag move has exactly zero changed pages.

Pre-existing issues:
- [Critical] During a TT-to-TT CCS defrag pass on DGFX systems, an uninitia=
lized stack variable (`ccs_ofs`) is passed to the GPU blitter, causing memo=
ry corruption.
--

--- Patch [31]: [PATCH v3 31/33] drm/xe: Blit src-natural to dst-packed for=
 defrag-IOVA copies ---
commit f45aa97c2f11618672e201ef92ad9ef7898d5e9c
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies

This commit introduces a packed-destination mode in __xe_migrate_copy() for
defrag moves with IOVA enabled. It adds a dst_packed_pages argument to hand=
le
asymmetric geometries where the destination only exposes changed pages. The
destination PTE update size is calculated based on the changed-page count.

> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migr=
ate.c
> index e9f050eab8871..8eb5e331d5156 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c

[ ... ]

> @@ -1033,7 +1179,9 @@ static struct dma_fence *__xe_migrate_copy(struct x=
e_migrate *m,
>  	else
>  		xe_res_first(src, 0, size, &src_it);
>  	if (!dst_is_vram)
> -		xe_res_first_tt(dst_bo->ttm.ttm, 0, size, &dst_it);
> +		xe_res_first_tt(dst_bo->ttm.ttm, 0,
> +				pack_dst ? (u64)dst_packed_pages << PAGE_SHIFT :
> +				size, &dst_it);
>  	else
>  		xe_res_first(dst, 0, size, &dst_it);

[Severity: Critical]
Does overloading dst_packed_pages =3D=3D 0 to mean 'not a packed destinatio=
n'
cause issues when a packed defrag move has exactly zero changed pages?

If a defragmentation move executes under memory pressure and fails to alloc=
ate
any new pages, it results in 100% borrowed pages. The IOVA mapping function
legitimately maps 0 pages, so xe_migrate_copy_defrag_iova() is called with
dst_packed_pages =3D 0.

Because dst_packed_pages =3D=3D 0, pack_dst becomes false (set earlier in
__xe_migrate_copy). This forces the fallback to a full-size non-packed copy,
and initializes dst_it requesting the full BO size against a destination IO=
VA
that was packed to size 0.

Can this walk the broken cursor and fetch garbage DMA addresses for the GPU
blitter, corrupting memory?

[ ... ]

> @@ -1145,16 +1355,22 @@ static struct dma_fence *__xe_migrate_copy(struct=
 xe_migrate *m,
> =20
>  		if (skip_borrowed)
>  			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
> -					 src_tt, dst_tt, start_page);
> +					 src_tt, dst_tt, start_page, pack_dst);
>  		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
>  			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
> =20
> -		if (needs_ccs_emit)
> +		if (ccs_pack) {
> +			if (emit_ccs_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs,
> +						 src_L0, src_tt, dst_tt,
> +						 start_page))
> +				flush_flags =3D MI_FLUSH_DW_CCS;
> +		} else if (needs_ccs_emit) {
>  			flush_flags =3D xe_migrate_ccs_copy(m, bb, src_L0_ofs,
>  							  IS_DGFX(xe) ? src_is_vram : src_is_pltt,
>  							  dst_L0_ofs,
>  							  IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
>  							  src_L0, ccs_ofs, copy_ccs);
> +		}

[Severity: Critical]
This is a pre-existing issue, but can this pass an uninitialized ccs_ofs st=
ack
variable to the GPU blitter during a TT-to-TT CCS defrag pass on DGFX syste=
ms?

When __xe_migrate_copy() is called with flags.defrag_ccs =3D true,
copy_system_ccs evaluates to false, leaving ccs_ofs uninitialized.

Because !flags.defrag_copy is true, needs_ccs_emit evaluates to true and ca=
lls
xe_migrate_ccs_copy(). For a TT source on DGFX, IS_DGFX(xe) ? src_is_vram :
src_is_pltt evaluates to false (meaning src_is_indirect is false).

xe_migrate_ccs_copy() then consumes the uninitialized ccs_ofs:

drivers/gpu/drm/xe/xe_migrate.c:xe_migrate_ccs_copy() {
    ...
    } else if (copy_ccs) {
        if (!src_is_indirect)
            src_ofs =3D ccs_ofs;
    ...
}

Does this cause the uninitialized src_ofs to be emitted into the GPU batch
buffer, resulting in memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711025619.2540=
575-1-matthew.brost@intel.com?part=3D31
