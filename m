Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1D6C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E104F10F9A8;
	Fri, 10 Jul 2026 22:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3shIXAX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0769710F9A8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB23C4108E;
 Fri, 10 Jul 2026 22:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DED51F000E9;
 Fri, 10 Jul 2026 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722632;
 bh=243JxOLClJJZjSVIZk8lyk4wCZTYkUkCsRC/T+CWK7w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q3shIXAX9BnqMG4bomHeTGwGAYOE6bidssZ03jwWcII14X5CyWBu/L+0GGt/ksick
 lehMDe9R92dDN7L0r03zFdipmPADdBoObo5r2TOIZ4lwX8ZY9yXkVtpY6PPQeG4m0q
 eNmLLIkUlA5ZggXz5NsIlHGnqn4XlePvCSzyFf2Zuw4TpMK2GaMyRcMtahfc+G7XUo
 yk1PP7gfhVcuI+L3FWQmlPAL617NIJZVlMXLJWhuxVLUEoBE8li78yXDh8dHYXMsn+
 pLVzQe+GZrwCtiDEc7hC8rdJse8aiGWRu3u6+DgdGvywvGtXzduDkWGAdn5Xk7Z6be
 GHxlsa3EYpZKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/33] drm/xe: Blit src-natural to dst-packed for
 defrag-IOVA copies
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-32-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-32-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:30:32 +0000
Message-Id: <20260710223032.8DED51F000E9@smtp.kernel.org>
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
- [High] Overloading `dst_packed_pages` as a boolean flag causes GPU IOMMU =
faults when defragmentation yields 0 changed pages.

Pre-existing issues:
- [High] Mismatch between XE_PTE_SHIFT and PAGE_SHIFT causes out-of-bounds =
array indexing and assertion failures on architectures with 64K pages.
--

--- Patch [31]: [PATCH v2 31/33] drm/xe: Blit src-natural to dst-packed for=
 defrag-IOVA copies ---
commit b1d39bbd2548d9ad82a4ac12f4936dc748d93736
Author: Matthew Brost <matthew.brost@intel.com>
Subject: drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies

This commit adds a packed-destination mode to __xe_migrate_copy for defrag
moves with IOVA enabled. It allows reading from the old tt at natural offse=
ts
and writing to the new tt at packed contiguous offsets. A new
xe_migrate_copy_defrag_iova entry point is exposed for this functionality.

> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migr=
ate.c
> index 0a3a1c5ca1938..35fd0253fef30 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
[ ... ]
> @@ -883,9 +949,71 @@ static u32 emit_copy_chunks(struct xe_gt *gt, struct=
 xe_bb *bb,
> =20
>  		if (bb)
>  			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
> -				  dst_L0_ofs + (u64)i * PAGE_SIZE,
> +				  dst_L0_ofs +
> +				  (u64)(pack_dst ? pack : i) * PAGE_SIZE,
>  				  run * PAGE_SIZE, PAGE_SIZE);

[Severity: High]
This isn't a bug introduced by this patch, but does passing PAGE_SIZE as the
pitch to emit_copy overflow the 16-bit pitch limit on systems with 64KB CPU
pages? The xe_gt_assert condition in emit_xy_fast_copy expects the pitch to=
 be
<=3D U16_MAX, which could cause a crash on architectures like ARM64 when
defragmenting BOs.

>  		nblits++;
> +		pack +=3D run;
> +		i +=3D run;
> +	}
[ ... ]
> @@ -1005,6 +1134,23 @@ static struct dma_fence *__xe_migrate_copy(struct =
xe_migrate *m,
>  	 */
>  	struct ttm_tt *dst_tt =3D dst_bo->ttm.ttm;
>  	bool skip_borrowed =3D flags.defrag_copy && src_tt && dst_tt;
> +	/*
> +	 * Defrag-IOVA copy: the destination tt only maps the changed
> +	 * (non-borrowed) pages, packed contiguously into the first
> +	 * @dst_packed_pages pages of its IOVA. The source is read from the old
> +	 * tt at natural offsets and each changed run is blitted into the packed
> +	 * destination prefix.
> +	 */
> +	bool pack_dst =3D dst_packed_pages !=3D 0;

[Severity: High]
Can evaluating pack_dst this way lead to GPU IOMMU faults when a
defragmentation move yields 0 changed pages?

If a BO defragmentation successfully borrows all pages, dst_packed_pages wi=
ll
be 0. This makes pack_dst false, which disables the packed CCS logic. During
the CCS pass, the driver might then fall back to a full BO CCS copy via
xe_migrate_ccs_copy(), assuming the destination is fully mapped. However,
because the destination IOVA mapping only covers the 0 changed pages, the G=
PU
would write CCS data to unmapped IOVA addresses.

> +	/*
> +	 * Packed defrag CCS pass: migrate the flat-CCS aux state of the changed
> +	 * pages only, from the source at its natural offset to the destination
> +	 * packed prefix. Borrowed pages share the physical page (and thus its
> +	 * aux) on both sides, so they are skipped exactly like the data pass.
> +	 */
> +	bool ccs_pack =3D flags.defrag_ccs && pack_dst && src_tt && dst_tt;
[ ... ]
> @@ -1054,29 +1202,86 @@ static struct dma_fence *__xe_migrate_copy(struct=
 xe_migrate *m,
>  		u32 pte_flags;
>  		pgoff_t start_page =3D (xe_bo_size(src_bo) - size) >> XE_PTE_SHIFT;

[Severity: High]
This isn't a bug introduced by this patch, but could the start_page
calculation cause out-of-bounds array indexing on architectures with
64KB pages?=20

The index start_page is computed using XE_PTE_SHIFT (which is 4KB), but
it is later used to index ttm_tt->pages which is sized based on
PAGE_SHIFT. On a 64KB page system, the calculated index would be 16x
larger than the array bounds, potentially leading to memory corruption
during defragmentation.

>  		u32 ndata_blits =3D 1;
> +		u32 nchg =3D 0;
> +		u64 dst_size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D31
