Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39A5C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5F910E8D1;
	Mon, 20 Jul 2026 12:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JcpK3w9S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C725710E8D1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:22:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 755AF43662;
 Mon, 20 Jul 2026 12:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D7D1F00A3D;
 Mon, 20 Jul 2026 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784550131;
 bh=i+GvNqoRrH8sjaK8+QXAFspCPR2SfAHv2SiEvMZ1suQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JcpK3w9S+SQV9nKGwnsEUupv7GF/00n0yu8o2heGMUVPQvqybp4WrwGb/lBTSIIeD
 DkBBRBDgeR9xxsWZN6hd6G7e18gwtqLQDU7AZeOTVjcuyvO25JaZ4e+7aYDHXRmKim
 uObN636mjKRO/XRZpXRGRmKJ1GQDFT2zs62AqJGIQm5Y7pc5dcsR31i+7zP4j3pa8s
 /sETcGG+Qvm690FTfN7N4ARvKoNKI4Qbhg1WECkrpZHRt5yAZVH5q5s2RAsSDonLCS
 urWICWVLESZRGSKAC91l+we/5zlg9qUDfUkNVfZAO8+rN4bMT30guqNhy25PVcZGJ/
 7jNtQUVX03JMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720121041.339981-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260720121041.339981-1-Arunpravin.PaneerSelvam@amd.com>
 <20260720121041.339981-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:22:10 +0000
Message-Id: <20260720122211.37D7D1F00A3D@smtp.kernel.org>
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

New issues:
- [Medium] Massive SLAB memory allocation in test loop risks OOM failures a=
nd softlockups
- [Medium] Unrecoverable memory leak on KUnit assertion failures

Pre-existing issues:
- [High] 32-bit integer truncation in buddy allocator causing out-of-bounds=
 array access and kernel panic
--

--- Patch [2]: [PATCH v6 2/2] gpu/tests/buddy: add dirty tracker performanc=
e KUnit test ---
commit 8a42f0ba9e5529f275dfb03ab95221fffce4cab8
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a new KUnit test to demonstrate the performance benefits
of the decoupled dirty-tracker design in the GPU buddy allocator. It
evaluates both contiguous allocation latency and repeated allocation
throughput under maximal fragmentation.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index e31f368ada951..e37505849ecc7 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
[ ... ]
> @@ -283,6 +283,115 @@ static void gpu_test_buddy_fragmentation_performanc=
e(struct kunit *test)
[ ... ]
> +static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
> +{
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
Does this loop risk out-of-memory failures and softlockups?

Fragmenting a 4 GiB pool into 4 KiB blocks requires 1,048,576 iterations,
allocating >2 million struct gpu_buddy_block nodes and later generating
524,288 struct gpu_dirty_extent nodes when alternating blocks are freed.

This demands ~225 MB of unswappable SLAB memory, which might trigger OOM
failures in memory-constrained KUnit test environments like 128 MB UML
instances.

Additionally, could a loop of this size without a cond_resched() trigger
RCU stalls or softlockups on non-preemptible kernels?

[Severity: Medium]
Will this lead to an unrecoverable memory leak if the assertion fails?

KUNIT_ASSERT_FALSE_MSG aborts the test function immediately. Since the test
uses standard kernel allocators instead of KUnit's managed resource API, an
allocation failure (such as from the massive SLAB requirements mentioned
above) will bypass gpu_buddy_fini() and permanently leak the mm structure's
tree nodes and all allocated blocks.

> +
> +	count =3D 0;
> +	list_for_each_entry_safe(block, tmp, &allocated, link) {
> +		if (count++ % 2 =3D=3D 0)
> +			list_move_tail(&block->link, &clear_blocks);
> +		else
> +			list_move_tail(&block->link, &dirty_blocks);
> +	}
> +
> +	gpu_buddy_free_list(&mm, &clear_blocks, GPU_BUDDY_CLEARED);
> +	gpu_buddy_free_list(&mm, &dirty_blocks, 0);
> +
> +	start =3D ktime_get();
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4G, SZ_4K,
> +						      &results,
> +						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
> +			       "contiguous alloc failed\n");

[Severity: High]
This is a pre-existing issue, but does this test request trigger a 32-bit
integer truncation in the buddy allocator?

When the test asks for a contiguous 4 GiB allocation (SZ_4G), the underlying
buddy allocator uses roundup_pow_of_two(size) and rounddown_pow_of_two(size)
inside __alloc_contig_try_harder().

Because these macros cast their arguments to unsigned long, passing 4 GiB
on a 32-bit platform truncates the size to 0. This results in
order =3D fls(0) - 1 evaluating to UINT_MAX.

Could this cause an out-of-bounds array access on mm->free_tree[order]
and crash 32-bit CI environments that run this new test suite?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720121041.3399=
81-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
