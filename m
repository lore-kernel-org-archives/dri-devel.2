Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E67FC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECDFC10E6EC;
	Fri, 10 Jul 2026 22:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k36rB2Db";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD3510E6EC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:17:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED550402FB;
 Fri, 10 Jul 2026 22:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E061F000E9;
 Fri, 10 Jul 2026 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783721851;
 bh=C+Q5QOn9Dwcws6m8nPE5TQOSs61/gDQQXqS3QOgwwio=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k36rB2DbUHy2UGe1geQ8EtWfT7oIEv1An6KzDsaSB4VMzqxk2E06VbHnJP0aJuKCx
 0UvGrMD2Zswmdj+sk/Mz+qrsKfc4f9LnKGQAycQ6155j1QCI90jaeSw2WYdU4X7edg
 DzmxSMHaKNbrfSWmDLOAsL7uC6eFeBg55FTW4hbJGUd3xiY/7Ys8fLcB5OXU35Ep/O
 M0esPXP1Mq9H0kP6e2CAnwnSW5KzuNKvvAU6nALqkxyIwKjYbdDJAff6M/z9zHuUuy
 Y5jeMls+voC0ZLqKlWkqUIdJrLUFqb4tvQ595d5lIhKNjtd2flfkRtRg5JlWyugKL6
 Vty8Xbl2fkEIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/33] drm/xe: Add xe_migrate_copy_defrag() for
 on-GPU defrag copies
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-18-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-18-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:17:31 +0000
Message-Id: <20260710221731.B0E061F000E9@smtp.kernel.org>
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
- [Critical] Uninitialized variable `ccs_ofs` and kernel assertion failure =
in `xe_migrate_ccs_copy()` during `defrag_ccs` pass for TT memory on DGFX.
- [High] Defragmentation bypasses mandatory CCS metadata clearing for BOs w=
ithout CCS, causing a security/information leak.
--

--- Patch [17]: [PATCH v2 17/33] drm/xe: Add xe_migrate_copy_defrag() for o=
n-GPU defrag copies ---
commit b14779b7d60fb7520bb68944732a8ae6ceb089e7
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies

Add xe_migrate_copy_defrag(), a copy helper for the upcoming page
defragmentation path where a single BO has its backing reallocated at a
more beneficial page order. The contents are relocated in up to two
passes (data and CCS) because they require opposite compression PAT
settings.

> diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migr=
ate.c
> index 9428dd5e7760c..956fd75454fa0 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
[ ... ]
> @@ -905,20 +931,29 @@ static struct dma_fence *__xe_migrate_copy(struct x=
e_migrate *m,
>  	bool src_is_vram =3D mem_type_is_vram(src->mem_type);
>  	bool dst_is_vram =3D mem_type_is_vram(dst->mem_type);
>  	bool type_device =3D src_bo->ttm.type =3D=3D ttm_bo_type_device;
> -	bool needs_ccs_emit =3D type_device && xe_migrate_needs_ccs_emit(xe);
> +	bool needs_ccs_emit =3D type_device && xe_migrate_needs_ccs_emit(xe) &&
> +		!flags.defrag_copy;
> +	bool copy_ccs =3D xe_device_has_flat_ccs(xe) &&
> -		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
> -	bool copy_system_ccs =3D copy_ccs && (!src_is_vram || !dst_is_vram);
> +		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo) &&
> +		!flags.defrag_copy;
> +	bool copy_system_ccs =3D copy_ccs && (!src_is_vram || !dst_is_vram) &&
> +		!flags.defrag_ccs && !flags.defrag_copy;

[Severity: High]
If a BO does not use CCS, does forcing needs_ccs_emit to false during the
data pass bypass the mandatory security clearing of its CCS metadata?

In xe_migrate_copy_defrag(), if need_ccs is false, it performs the data pass
and returns early:

    struct dma_fence *fence =3D
        __xe_migrate_copy(..., (struct xe_migrate_copy_flags) {
            .defrag_copy =3D true,
        });

    if (IS_ERR(fence) || !need_ccs)
        return fence;

Since needs_ccs_emit is false when flags.defrag_copy is true,
xe_migrate_ccs_copy() is never called to clear the CCS metadata. Could this
leave stale cross-process data in the newly allocated destination pages?

[ ... ]
> @@ -1014,7 +1053,7 @@ static struct dma_fence *__xe_migrate_copy(struct x=
e_migrate *m,
>  		bb->cs[bb->len++] =3D MI_BATCH_BUFFER_END;
>  		update_idx =3D bb->len;
> =20
> -		if (!copy_only_ccs)
> +		if (!flags.copy_only_ccs && !flags.defrag_ccs)
>  			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
> =20
>  		if (needs_ccs_emit)

[Severity: Critical]
Can this pass an uninitialized ccs_ofs to xe_migrate_ccs_copy() and trigger
a kernel assertion failure on DGFX?

During a defrag_ccs pass for a TT memory BO, flags.defrag_ccs is true, which
forces copy_system_ccs to false:

    bool copy_system_ccs =3D copy_ccs && (!src_is_vram || !dst_is_vram) &&
        !flags.defrag_ccs && !flags.defrag_copy;

Because copy_system_ccs is false, the loop skips the initialization of ccs_=
ofs:

    if (copy_system_ccs) {
        ...
        batch_size +=3D pte_update_size(..., &ccs_ofs, ...);
    }

However, needs_ccs_emit remains true (since flags.defrag_copy is false). Th=
is
causes xe_migrate_ccs_copy() to be called with the uninitialized ccs_ofs.

Furthermore, for TT memory on DGFX, both src_is_vram and dst_is_vram are fa=
lse.
These are passed as the indirect flags to xe_migrate_ccs_copy():

    flush_flags =3D xe_migrate_ccs_copy(m, bb, src_L0_ofs,
                      IS_DGFX(xe) ? src_is_vram : src_is_pltt,
                      dst_L0_ofs,
                      IS_DGFX(xe) ? dst_is_vram : dst_is_pltt,
                      src_L0, ccs_ofs, copy_ccs);

Inside xe_migrate_ccs_copy(), this will trigger the assertion because both
indirect flags are false:

    xe_gt_assert(gt, src_is_indirect || dst_is_indirect);
    if (!src_is_indirect)
        src_ofs =3D ccs_ofs;

And then it programs the GPU copy engine with the uninitialized ccs_ofs,
which could lead to arbitrary GPU memory access or data corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D17
