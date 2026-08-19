Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8158C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD2510E134;
	Wed, 19 Aug 2026 10:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dio2U0Ak";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AAC10E134;
 Wed, 19 Aug 2026 10:53:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D8AA4148C;
 Wed, 19 Aug 2026 10:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136571F000E9;
 Wed, 19 Aug 2026 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787136781;
 bh=1lInBAJN59pCt+Pj2cgGafiJvW9ZIxP54OMePKcSqZs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dio2U0AkXnEGX9qYA1LB2O9GvrNxqL1iR5xf3ASo1NnNu7eJQdFJigj6tYQbTqzkO
 hSwjV9e/VAyifef+WDaLzEhJrwYJlJ/tSYAGqHnYdJqaZOj/FOHgCva5aBX9E69A2I
 OIGF6tRSvl837qgBDxQ7o1l2PgeBNsFuU2KsLL/KDi2NO9TDwpJhq1te3+acU9GgIr
 PH4X459RKjFjsNCewL2SjkRhG+sjMOs4SLU2PZpfDSrl5T8z0uXLD5pMi4ZfM3FwVu
 bASUEvWpZOKMJ5FPvHkuVA5tEthwU8ElRMEZ9O9evEp1srPC6GROb2SyJnsFtFs0ZQ
 chDdLNP9HouGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260819104242.10703-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
 <20260819104242.10703-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:53:00 +0000
Message-Id: <20260819105301.136571F000E9@smtp.kernel.org>
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
- [Medium] Scenario 1 of the dirty tracker performance test fails to exerci=
se the contiguous allocation path and `__force_merge()`, rendering its benc=
hmark results invalid.
--

--- Patch [2]: [PATCH v10 2/2] gpu/tests/buddy: add dirty tracker performan=
ce KUnit test ---
commit 31fa603bd9e94c9fc78fd665cdb47f320c0dabdd
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a new KUnit test to demonstrate the performance advantage
of the decoupled dirty-tracker design over the previous dual-tree and
force_merge approach.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 6ce485eae83ee..04344468ab6bf 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
[ ... ]
> +static void gpu_test_buddy_dirty_tracker_performance(struct kunit *test)
> +{
[ ... ]
> +	start =3D ktime_get();
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, SZ_4G, SZ_4G, SZ_4K,
> +						      &results,
> +						      GPU_BUDDY_CONTIGUOUS_ALLOCATION),
> +			       "contiguous alloc failed\n");

[Severity: Medium]
Does this allocation actually exercise the contiguous allocation path and
invoke __force_merge() as intended?

Looking at gpu_buddy_alloc_blocks(), when start + size =3D=3D end (0 + SZ_4=
G =3D=3D
SZ_4G), the function takes an early exact-range allocation path and returns
__gpu_buddy_alloc_range():

drivers/gpu/buddy.c:gpu_buddy_alloc_blocks() {
    ...
	/* Actual range allocation */
	if (start + size =3D=3D end) {
		if (!IS_ALIGNED(start | end, min_block_size))
			return -EINVAL;

		return __gpu_buddy_alloc_range(mm, start, size, flags, NULL, blocks);
	}
    ...
}

This bypasses the contiguous allocation logic entirely, meaning the baseline
measurement of 71 ms might just be the overhead of iterating the tree and
gathering 1,048,576 individual 4 KiB fragments into a list, rather than
measuring __force_merge() performance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819104242.1070=
3-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
