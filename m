Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E720C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984DF10F983;
	Fri, 10 Jul 2026 22:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RiTtTtNZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0394D10F983
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:18:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DCA160052;
 Fri, 10 Jul 2026 22:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5141F000E9;
 Fri, 10 Jul 2026 22:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721922;
 bh=CCZy3g/slKlvOspITqK0AWjdNm9vVN6r3JNlqdqHuF8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RiTtTtNZbTEUFouXz5s4b8/lqCIH7lxGpLbqbFaxK2dMxHNtYMR68zXsikM55diua
 TI+VDfcFgUNapD7/yOOnbJL6OZIkZOm21uvG3krB21oKADk4DJAGtIUsHBrN7MKFRe
 E5l9e2a49QY32IrH9OfTLxk8P+2wenBhPciS0sRLlXdppwSotP8+0OB/LNH9L9F8Md
 FB/frIBrY+1wBzbQeZhRsEGZ/weqwafGtFMSNsRWvogChvo869PkZRx5EGmr/RrwXV
 g0IPDn/f99jYWoDXIBePD9IvcG69IS8Qq6x2f0rMa3EXxEHlnyYVokEJ6IQoj5/+mf
 DCLJAKmaBHHpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/33] drm/xe: Skip self-copies for borrowed pages on
 defrag moves
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-20-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-20-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:18:41 +0000
Message-Id: <20260710221842.0A5141F000E9@smtp.kernel.org>
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
- [High] Out-of-bounds array access due to incorrect page shift in start_pa=
ge calculation
- [High] Hardware assertion failure and command stream corruption due to us=
ing PAGE_SIZE as pitch
--

--- Patch [19]: [PATCH v2 19/33] drm/xe: Skip self-copies for borrowed page=
s on defrag moves ---
commit 0cb7423f91b7764bc47ff13572694c591c1f58e2
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Skip self-copies for borrowed pages on defrag moves

A defrag move may harvest already beneficial-order chunks from the old
tt, so the freshly reallocated backing borrows (references) some of the
same physical pages.

> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migr=
ate.c
> index 956fd75454fa0..450ca8bf4f3b6 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c

[ ... ]

> @@ -835,6 +835,63 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb=
 *bb,
>  		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
>  }
> =20
> +/*
> + * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, ski=
pping

[ ... ]

> +		/* Coalesce a run of pages that actually need copying. */
> +		while (i + run < npages &&
> +		       src_tt->pages[start_page + i + run] !=3D
> +		       dst_tt->pages[start_page + i + run])
> +			run++;
> +
> +		if (bb)
> +			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
> +				  dst_L0_ofs + (u64)i * PAGE_SIZE,
> +				  run * PAGE_SIZE, PAGE_SIZE);

[Severity: High]
Can the use of PAGE_SIZE here cause a hardware assertion failure and command
stream corruption on systems with 64KB pages?

The PAGE_SIZE is passed as the pitch parameter to emit_copy(), which flows =
into
emit_xy_fast_copy() where there is a hardware limit check:

xe_gt_assert(gt, pitch <=3D U16_MAX);

On 64KB page systems, PAGE_SIZE is 65536, which exceeds U16_MAX (65535). Th=
is
will unconditionally trigger the driver assertion. Furthermore, because the
pitch is bitwise OR'ed into the BLT command instruction, won't this oversiz=
ed
pitch overflow its bit field and corrupt adjacent fields in the GPU command?

Should this use XE_PAGE_SIZE (4096) instead, similar to the fallback path
in normal emit_copy() usage?

[ ... ]

> @@ -985,6 +1052,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe=
_migrate *m,
>  		u64 ccs_ofs, ccs_size;
>  		u32 ccs_pt;
>  		u32 pte_flags;
> +		pgoff_t start_page =3D (xe_bo_size(src_bo) - size) >> XE_PTE_SHIFT;
> +		u32 ndata_blits =3D 1;
> =20
>  		bool usm =3D xe->info.has_usm;

[Severity: High]
Is there a risk of an out-of-bounds array access here on systems with a
page size larger than 4KB (like 64KB on ARM64 or PPC64)?

By shifting with XE_PTE_SHIFT (12), the index is computed in terms of 4KB
GPU pages. However, this index is later passed to emit_copy_chunks() to
index the src_tt->pages and dst_tt->pages arrays:

if (src_tt->pages[start_page + i] =3D=3D dst_tt->pages[start_page + i]) {

Since the ttm_tt page arrays are sized based on the system's PAGE_SHIFT,
wouldn't an index calculated with XE_PTE_SHIFT grow much faster than the
array bounds on a 64KB page system, leading to a memory out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D19
