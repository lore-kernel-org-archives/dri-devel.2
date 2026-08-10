Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA171C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 148D810E1C6;
	Mon, 10 Aug 2026 09:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CGGi+LwS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1DD10E1C6
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:21:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D397643D02;
 Mon, 10 Aug 2026 09:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968761F000E9;
 Mon, 10 Aug 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786353661;
 bh=YIyp/HcUOkLGBYhWU/zsSFditJwpyqKFEdSMGt+LPxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CGGi+LwSS7cQ6qacbhznpNhhjxjK1CmEjeDvAasPyOPoQKC1O+HW7wmbaVZXiaqO0
 /Z8mPkyNJ17M13loSpHVVTIilLnntl7+KQ1aA4q0t9LXzQyycCe8oiaLK71HBp3OOI
 VaiShSYbe1gDFW76J3bmPhhDI+FRGTZAotVsEZI4BNsoj378dR/V7rVQbF5UsdlaS8
 AdxW7HeCBsWp/Iq7aITnyv4w+hy22jyb4pBJ9tf9Yv7B87GdLHxAyuJ6B3SVvl/Y9C
 XPuQrEI9HnqpAfmBurWtVHAL/uSajjtZ5TJdPWF8vM8YLVV/Yv2fBtKYakDIJs5bGO
 Numwlcn9uZ0/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260810091231.11936-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260810091231.11936-1-Arunpravin.PaneerSelvam@amd.com>
 <20260810091231.11936-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:21:00 +0000
Message-Id: <20260810092101.968761F000E9@smtp.kernel.org>
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
- [Medium] Factual error in documentation and commit message regarding __fo=
rce_merge() execution path
--

--- Patch [2]: [PATCH v8 2/2] gpu/tests/buddy: add dirty tracker performanc=
e KUnit test ---
commit fc0bf373f19d84c8ba58395148cb3dec974d2a81
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a KUnit test to demonstrate the performance advantage of t=
he
decoupled dirty-tracker design over the older dual-tree force_merge approach
during severe fragmentation scenarios.

>      1. Contiguous 4 GiB alloc: the old design requires __force_merge()
>         to rebuild max_order from scratch; the new design coalesces during
>         free() so the alloc is O(log N).
>   =20
>           old (force_merge) - 71 ms
>           dirty tracker design - 17 ms

[Severity: Medium]
Is this description accurate regarding the execution of __force_merge()?

Looking at gpu_buddy_alloc_blocks(), when start is 0, size is SZ_4G, and
end is SZ_4G, the condition start + size =3D=3D end evaluates to true:

	/* Actual range allocation */
	if (start + size =3D=3D end) {
		if (!IS_ALIGNED(start | end, min_block_size))
			return -EINVAL;

		return __gpu_buddy_alloc_range(mm, start, size, flags, NULL, blocks);
	}

This takes the __gpu_buddy_alloc_range() fast-path, which completely bypass=
es
__alloc_contig_try_harder() and never invokes __force_merge().

Does the 71 ms latency actually come from the O(N) overhead of traversing a=
nd
linking the 1,048,576 unmerged 4 KiB blocks covering the range, rather than
the cost of __force_merge()?

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 198d8dc4e3f0e..4dc54ed33269e 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
[ ... ]
> @@ -283,6 +283,119 @@ static void gpu_test_buddy_fragmentation_performanc=
e(struct kunit *test)
[ ... ]
> +static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
> +{
[ ... ]
> +	/*
> +	 * Contiguous alloc latency after alternating clear/dirty fragmentation
> +	 *
> +	 * Fill a 4 GiB pool with 4 KiB allocations, partition them into
> +	 * alternating cleared and dirty sets, then free both.  In the old
> +	 * dual-tree design every adjacent buddy pair has one cleared half and
> +	 * one dirty half, so the pair sits on opposite sides of the clear/dirty
> +	 * merge barrier and cannot be coalesced at free() time.  The pool
> +	 * stays fully fragmented and the subsequent contiguous 4 GiB allocation
> +	 * has to invoke __force_merge() to climb back up to max_order before
> +	 * it can succeed.  With the dirty-tracker design buddy pairs coalesce

[Severity: Medium]
The same documentation mismatch appears here in the inline comment for
gpu_test_buddy_dirty_tracker_performance(). Since this 4 GiB allocation
triggers the exact range allocation path in gpu_buddy_alloc_blocks(),
__force_merge() is not invoked. Could we update the comment to accurately
reflect the source of the latency in the old design?

> +	 * unconditionally during free(), so the pool is already at max_order
> +	 * before the timed alloc begins and __force_merge() is not needed.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
> +			       "buddy_init failed\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810091231.1193=
6-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
