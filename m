Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F87CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB6310F22C;
	Tue,  6 Oct 2026 07:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BgE6NQGO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FE210F226;
 Tue,  6 Oct 2026 07:41:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDA0360142;
 Tue,  6 Oct 2026 07:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D11F000FF;
 Tue,  6 Oct 2026 07:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791272496;
 bh=ItQG7RFeFV94tjIRfkZTpHxZLRCzdw2c8uiAYdFZVKs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BgE6NQGOTcfQHEu3DqsOcWlxjujNPys/Pq4HWWv7jLz7KSszp3LUJtLwlibjDW0cv
 TOfEWb31lmFHlZohbH0J9//JSq9zmJjGQroGy7ROMePHQbJ6NXOKlBBQ9q0hX13YNn
 sTqwlqquPEuG/8kMvaQA43x/fTkWRz0B6r7WRpmMns3mssbwaTCWhkTfVu1R1jLQAG
 X4ywJaLlMim5PY7snOsswnv+A+RsPJbZST2PHQDb6knXxpi9gJCIlqWV3+NNx+Y4OT
 B7zC42k73gg7dtRnJvTXk4kPf1JFMqKvFm6wnEFoSjM6mn8yAppSXUV1BndRnAlNA9
 Cx73biVPAV2/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] gpu/buddy: add range-restricted contiguous
 allocation fallback
To: "Arunpravin Paneer Selvam" <arunpravin.paneerselvam@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261006072643.211568-1-arunpravin.paneerselvam@amd.com>
References: <20261006072643.211568-1-arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 07:41:35 +0000
Message-Id: <20261006074136.564D11F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] gpu/buddy: try_harder skips leftward shift on successful out-of-ra=
nge scan
- [High] gpu/buddy: try_harder misses valid range candidates due to strict =
start and order bounds
- [High] gpu/buddy: out-of-window scan inflates filled size, breaking try_h=
arder fallback
--

commit 9e12b0182f3fa80f621385a50621b754c45d5811
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/buddy: add range-restricted contiguous allocation fallback

This commit adds a fallback path for contiguous allocation requests with
range restrictions to help prevent false -ENOSPC errors due to fragmented
memory. By confining the try_harder scan to the requested range, it attempts
to satisfy requests by stitching smaller adjacent blocks.

> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1685,26 +1685,14 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
> +				     u64 range_start, u64 range_end,
>  				     u64 size,
>  				     u64 min_block_size,
>  				     unsigned long flags,
>  				     struct list_head *blocks)
>  {
> -	u64 rhs_offset, lhs_offset, filled;
> +	u64 rhs_offset, lhs_offset, filled, aligned;

[Severity: High]
Does this function miss valid range candidates due to its strict starting
order bound?

__alloc_contig_try_harder() starts its search strictly downwards from
order =3D fls(pages) - 1. If a higher-order block was rejected by the normal
allocator because its rounded-up size didn't fit the range, its splits are
undone. Because this fallback never searches higher orders, it completely
misses any unsplit free blocks that might contain valid range candidates.

[ ... ]

> @@ -1729,25 +1717,36 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
> =20
>  		rhs_offset =3D gpu_buddy_block_offset(block);
> =20
> +		if (rhs_offset >=3D range_end) {
> +			iter =3D rb_prev(iter);
> +			continue;
> +		}
> +		if (rhs_offset < range_start)
> +			break;

[Severity: High]
Does this loop termination artificially ignore free space inside a block
that starts before the range but extends into it?

If a free block begins before range_start but extends well into the valid
range, its right half could still satisfy the allocation. Breaking here
discards the entire block and terminates the loop, causing the allocator
to miss perfectly valid free space.

>  		/* Allocate blocks traversing RHS */
>  		err =3D  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>  					       flags, &filled, blocks);

[Severity: High]
Does passing size directly here without clamping it to range_end - rhs_offs=
et
cause the forward scan to populate filled with space beyond range_end?

If the forward scan hits a busy block outside the window, filled will
reflect the total contiguous free bytes found, including those beyond
range_end. This artificially inflates the filled value.

>  		if (err && err !=3D -ENOSPC)
>  			return err;
> -		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
> +		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
> +		    rhs_offset >=3D range_start && rhs_offset + size <=3D range_end)
>  			return 0;
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

[Severity: High]
Does this unconditional goto skip checking if shifting the allocation to the
left (to fit within range_end) would succeed, leading to false allocation
failures?

When err =3D=3D 0 on the forward scan, we know at least size contiguous byt=
es
are free starting at rhs_offset. If rhs_offset + size > range_end, the
allocation could still be satisfied by shifting the window left to end exac=
tly
at range_end.

However, the code completely bypasses this leftward shift via this goto nex=
t,
only performing leftward shifts when err =3D=3D -ENOSPC. This causes the al=
locator
to miss perfectly valid free space that crosses the right boundary but has
enough room if shifted left.

>  		}
> @@ -1759,15 +1758,17 @@ static int __alloc_contig_try_harder(struct gpu_b=
uddy *mm,
> =20
>  		/* Allocate the unaligned LHS offset using round_down */
>  		gpu_buddy_free_list_internal(mm, blocks);
> -		err =3D __alloc_contig_aligned_retry(mm, lhs_offset,
> -						   size,
> -						   min_block_size,
> -						   flags, blocks);
> -		if (!err)
> -			return 0;
> -		if (err !=3D -ENOSPC) {
> -			gpu_buddy_free_list_internal(mm, blocks);
> -			return err;
> +
> +		aligned =3D round_down(lhs_offset, min_block_size);
> +		if (aligned >=3D range_start && aligned + size <=3D range_end) {

[Severity: High]
Because filled is artificially inflated from the out-of-window scan above,
lhs_offset (calculated prior to this block as rhs_offset - (size - filled))
will be shifted too far to the right.

This causes the perfectly valid left-shifted candidate to remain partially
out-of-bounds, failing the bounds check here and returning a false -ENOSPC.

> +			err =3D __gpu_buddy_alloc_range(mm, aligned, size,
> +						      flags, NULL, blocks);
> +			if (!err)
> +				return 0;
> +			if (err !=3D -ENOSPC) {
> +				gpu_buddy_free_list_internal(mm, blocks);
> +				return err;
> +			}
>  		}
>  next:
>  		gpu_buddy_free_list_internal(mm, blocks);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006072643.2115=
68-1-arunpravin.paneerselvam@amd.com?part=3D1
