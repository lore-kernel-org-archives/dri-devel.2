Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908E2C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A6110F19E;
	Fri, 31 Jul 2026 07:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfZseyD+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EC210F19E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:19:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7AFE7600AD;
 Fri, 31 Jul 2026 07:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ED71F000E9;
 Fri, 31 Jul 2026 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785482361;
 bh=S6xEUtz3vJS4DSdcg36xCH/vM+3eRLfOe6c6IX+oxwQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfZseyD+DgGBZd6Q3TgSYb9p4kAaJR7TCqD/l0/u/jOJztKja6VWB8Eb4hbOaKaIO
 D++OLANGQeqoa9rAfixjwBb7eiJ7kMyRUJsdOq7NQ1oTNIDSoPtXAEbpdrGPRqPS4h
 EWh+uKQNGyGTPPcHxuTxDTeyxGuz5cQVOCURYfD3zOh6RiT05tl8IohHB+kXYe9ptP
 ukkIRyJzmtfhvRM+6K1FA6YKAbp8EZ6bxmgPnAbz95ogBf8M5rREmvFXyUI8xYnkIn
 FiZjleSfRj0UVjP0Z35oYjZtGFlzkbardYycDTDnao2jXYNvU/sZbteuN6RwXTAi3a
 n8fujuALPPrhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
 <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:19:20 +0000
Message-Id: <20260731071920.D4ED71F000E9@smtp.kernel.org>
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
- [Medium] Massive memory footprint in KUnit test triggers OOM in constrain=
ed environments
- [Medium] Benchmark logic bypasses the measured path in the baseline alloc=
ator
--

--- Patch [2]: [PATCH v7 2/2] gpu/tests/buddy: add dirty tracker performanc=
e KUnit test ---
commit 7af49c21f49c14e81ea1bc47365402c2ec976aec
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a KUnit test `gpu_test_buddy_dirty_tracker_performance`
to demonstrate the performance benefits of the decoupled dirty-tracker
design compared to the dual-tree approach. It measures contiguous
allocation latency and repeated allocation throughput after fragmentation.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index f8e56da5058e6..3fc2bfa66ee15 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c

[ ... ]

> +static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
> +{
> +	struct gpu_buddy_block *block, *tmp;
> +	unsigned long elapsed_ms;

[ ... ]

> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, SZ_4G, SZ_4K),
> +			       "buddy_init failed\n");
> +
> +	for (i =3D 0; i < SZ_4G / SZ_4K; i++)
> +		KUNIT_ASSERT_FALSE_MSG(test,
> +				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4K, SZ_4K,
> +							      &allocated, 0),
> +				       "buddy_alloc hit an error size=3D%u\n", SZ_4K);

[Severity: Medium]
Will this massive memory footprint trigger an Out-Of-Memory panic in
constrained environments?

Allocating a 4 GiB pool using 4 KiB block granularity requires creating over
1 million struct gpu_buddy_block nodes dynamically from the slab. This will
consume well over 100 MiB of kernel memory.

Default UML environments for KUnit often have a memory limit of 256 MiB or=
=20
less, and this exhaustive allocation is likely to crash the test suite.

[ ... ]

> +	/*
> +	 * Repeated alloc throughput from a maximally fragmented pool
> +	 *
> +	 * Fill a 4 GiB pool with 4 KiB allocations, free even-indexed blocks
> +	 * as cleared and odd-indexed blocks as dirty.  The alternating pattern
> +	 * ensures every adjacent buddy pair has one cleared half and one dirty
> +	 * half, so each pair lands on opposite sides of the old merge barrier.
> +	 * Each of the 16 384 x 256 KiB allocations in the timed loop has to
> +	 * pay the __force_merge() cost on the alloc path under the old design.
> +	 * With the dirty-tracker design the pool collapses to one max_order
> +	 * block during free(), so each alloc is a simple O(log N) split.
> +	 */

[ ... ]

> +	start =3D ktime_get();
> +	for (i =3D 0; i < SZ_4G / SZ_256K; i++)
> +		KUNIT_ASSERT_FALSE_MSG(test,
> +				       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_256K, SZ_4K,
> +							      &results, 0),
> +				       "buddy_alloc hit an error size=3D%u\n", SZ_256K);

[Severity: Medium]
Does this benchmark logic bypass the measured path in the baseline allocato=
r?

The commit message states this measures the __force_merge() cost on the
alloc path under the old design. However, the flags parameter is passed as 0
here, which omits GPU_BUDDY_CONTIGUOUS_ALLOCATION.

Without the contiguous flag, the baseline allocator does not enforce that
the 256 KiB allocation must be a single block. Instead, it will fall back to
satisfying the 256 KiB request with 64 independent 4 KiB blocks.

Because 4 KiB blocks are readily available in the fragmented pool, the
allocation succeeds without ever invoking the __force_merge() fallback.

Are we actually comparing the cost of 64 tree lookups against 1 tree lookup,
rather than measuring the __force_merge() overhead?

> +	end =3D ktime_get();
> +	elapsed_ms =3D ktime_to_ms(ktime_sub(end, start));
> +
> +	kunit_info(test, "Repeated 256 KiB allocs from fragmented pool: %lu ms\=
n",
> +		   elapsed_ms);
> +
> +	gpu_buddy_free_list(&mm, &results, 0);
> +	gpu_buddy_fini(&mm);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731070741.2654=
251-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
