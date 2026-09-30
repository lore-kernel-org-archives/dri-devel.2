Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3E1CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F7710F1C7;
	Wed, 30 Sep 2026 06:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CAN2C/Ov";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F7610E848;
 Wed, 30 Sep 2026 06:31:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C738340450;
 Wed, 30 Sep 2026 06:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E241F00893;
 Wed, 30 Sep 2026 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790749891;
 bh=zjjOp/bBq8sIeidl3k+BOyABPGYHepOACzXwLsypV/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CAN2C/OvYcw3G3293VXiFcpymLRDzNVsQbcF/siKnv0QwhICYVYYJn6ZMP5iMPgD9
 xZ1amcAbH0VfnQaldP2jJgNEIguwzwKwF3Cv6Pwmqxdf6oijvalYGrQe4d3ekBysY3
 i6BlI1SAumFVGJ/zDOuB2X8wRM97qpyfQCDUwpQot42uJ34scPj78b5vh3L3FGtXN9
 UodtCSuuI7E7BI0AaRjY19HAK0sEuOMt84nP9FzhbdrM5POZ/OwEUTC+EQ2fIsNUDT
 eqVIX0uwVZbujYU/2Uv6DFoNbgpzDSJKGdgrnhv831U00gG/zXZdRXEhmhL7ZPJs31
 lSomHepW8+lCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] gpu/buddy: add range-restricted contiguous
 allocation fallback
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
References: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:31:30 +0000
Message-Id: <20260930063131.69E241F00893@smtp.kernel.org>
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
- [High] gpu/buddy: range-restricted alloc fails when free space exceeds ra=
nge_end
--

commit 2ed4c9d1a70c51390968b65e939095ce52c8ee07
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: add range-restricted contiguous allocation fallback

A range + contiguous allocation rounds its size up to a power of two
and requires a naturally aligned free block of that size. The
non-range contiguous path already recovers from fragmentation via
__alloc_contig_try_harder(), which is now given a range window to
support the range + contiguous case.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe351..5265e1f6a3183 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
[ ... ]
> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
[ ... ]
>  		if (!err) {
>  			/* Allocate the unaligned RHS offset using round_down */
>  			gpu_buddy_free_list_internal(mm, blocks);
> -			err =3D __alloc_contig_aligned_retry(mm, rhs_offset,
> -							   size,
> -							   min_block_size,
> -							   flags, blocks);
> -			if (!err)
> -				return 0;
> -			if (err !=3D -ENOSPC) {
> -				gpu_buddy_free_list_internal(mm, blocks);
> -				return err;
> +
> +			aligned =3D round_down(rhs_offset, min_block_size);
> +			if (aligned >=3D range_start &&
> +			    aligned + size <=3D range_end) {
> +				err =3D __gpu_buddy_alloc_range(mm, aligned, size,
> +							      flags, NULL, blocks);
> +				if (!err)
> +					return 0;
> +				if (err !=3D -ENOSPC) {
> +					gpu_buddy_free_list_internal(mm, blocks);
> +					return err;
> +				}
>  			}
>  			goto next;
>  		}

[Severity: High]
Does this skip the left-hand side (LHS) fallback when contiguous free space
exceeds range_end?

If __gpu_buddy_alloc_range() succeeds at finding free space starting at
rhs_offset, err is 0. If the free space extends beyond range_end, the newly
added check (aligned >=3D range_start && aligned + size <=3D range_end) mig=
ht
fail. But since err is still 0, it hits the unconditional goto next.

By skipping to next, doesn't this bypass the LHS window-sliding logic below?
If there was valid free space to the left of rhs_offset that perfectly fits
the window, it appears it would be ignored, causing the allocator to return
-ENOSPC despite sufficient space existing within the requested range.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930062117.5850=
89-1-arunpravin.paneerselvam@amd.com?part=3D1
