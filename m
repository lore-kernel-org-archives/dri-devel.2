Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A6DC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AA810E282;
	Wed,  2 Sep 2026 10:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W9Zoyfy6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BDA10E282
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 10:11:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6962F600C8;
 Wed,  2 Sep 2026 10:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0FA1F000E9;
 Wed,  2 Sep 2026 10:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788343868;
 bh=qyHr4QwZFqtJxxYHoudfNxBo14C4k3c3CVA+26nU4pI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W9Zoyfy69k5UQdjCURnEkbpAbT01lOjyDGl3EJE+PKVbcwr9pcPKH/vxDm5SI5FwX
 fr+lLjJNUmFfWH334mIdbGjlme7SXk/9QhyXWYD+ZymmjAgZOILC0+piryrH8XeDBo
 clBzgbxHU+xm8nNBRn6TOn5QoL0slzBnOYQ5CcDCp3kUFY6vixsn5P+eGEAmTzYvl5
 wqCaTCe1lY375yg3JoxVZPLzIqnf5NlJVjPYbnknV9XYsLDBeQp28Fn5QaJM0GC0y6
 b9mgd0YyzrECKQFCOtVCcrHyul0eV/qkRa4Ca+GJMiQwnI9xAQWEIc9z9n3pqyVN6u
 +BGUPnt1ITiRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/imagination: Propagate map failures correctly
 from pvr_mmu_map_sgl()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
References: <20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com>
 <20260902-mmu_fix-v1-1-c55a23fb7cab@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:11:07 +0000
Message-Id: <20260902101107.EB0FA1F000E9@smtp.kernel.org>
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
- [High] Latent NULL pointer dereference in `pvr_mmu_op_context_unmap_curr_=
page()` when unmapping missing page tables, due to `-ENXIO` being improperl=
y swallowed.
--

commit 9512cb5ae9264ab1bc6ea5bf3b2a374fe88ffc0e
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()

This commit ensures that map failures from pvr_mmu_map_sgl() are correctly
returned to the caller, preventing the pvr_mmu_map() interface from continu=
ing
incorrectly. It also adds logging for page unmapping failures during cleanu=
p.

> diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imag=
ination/pvr_mmu.c
> index 3cac482e10347..175f0ba4d993f 100644
> --- a/drivers/gpu/drm/imagination/pvr_mmu.c
> +++ b/drivers/gpu/drm/imagination/pvr_mmu.c

[ ... ]

> @@ -2553,7 +2554,9 @@ pvr_mmu_map_sgl(struct pvr_mmu_op_context *op_ctx, =
struct scatterlist *sgl,
> =20
>  err_destroy_pages:
>  	memcpy(&op_ctx->curr_page, &ptr_copy, sizeof(op_ctx->curr_page));
> -	err =3D pvr_mmu_op_context_unmap_curr_page(op_ctx, page);
> +	if (pvr_mmu_op_context_unmap_curr_page(op_ctx, page))

[Severity: High]
This is a pre-existing issue, but could this unmap call trigger a NULL poin=
ter
dereference under certain conditions?

If an unmap operation spans an L1 boundary into an unmapped area where the
L0 table is missing, pvr_mmu_op_context_next_page() clears
op_ctx->curr_page.l0_table to NULL and calls pvr_mmu_op_context_load_tables=
().

In pvr_mmu_op_context_load_tables(), the -ENXIO error indicating a missing =
L0
table is swallowed:

	if (err =3D=3D -ENXIO)
		err =3D 0;

Because it returns 0 instead of -ENXIO, the loop inside
pvr_mmu_op_context_unmap_curr_page() misses its guard:

	err =3D pvr_mmu_op_context_next_page(op_ctx, false);
	if (err =3D=3D -ENXIO)
		continue;
	else if (err)
		return err;

	pvr_page_destroy(op_ctx);

This causes it to unconditionally proceed to pvr_page_destroy(), which then
dereferences the NULL l0_table when checking if the entry is valid.

Since this patch modifies the error handling around unmapping pages, is the=
re
a way to address the swallowed -ENXIO so that sparse unmap requests or
rollbacks that cross into a missing L0 table skip properly instead of crash=
ing?

> +		drm_err(from_pvr_device(op_ctx->mmu_ctx->pvr_dev), "%s : Failure in un=
mapping pages\n",
> +			__func__);
> =20
>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-mmu_fix-v1=
-0-c55a23fb7cab@imgtec.com?part=3D1
