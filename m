Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493AEC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA1310E4E2;
	Tue,  7 Jul 2026 14:24:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OZswYO7U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23D810E4E2
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:24:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5320E61836;
 Tue,  7 Jul 2026 14:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D415F1F00A3A;
 Tue,  7 Jul 2026 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783434269;
 bh=YGrZdKeiKV5oD7U7d2LrItf6Qr2GRcGnHISq3Gwqq/4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OZswYO7UcerASXvgFKA28d/KtdT2plW5BU7GlRH/oRslSWbi9UVd0GnkwN4YlnGuH
 S9fxJpkTHuhMK9fxNviapKuRcEg8DzASXPHIvARwlxdB6hqyIVYjKqi66m1k9CyX56
 dt0RWYli8W49MxeM6kevXc4cykkNMrrD3tX/WOs/KVi3bHtXeXajSL7a3ThJvmnuTP
 W3tMp0xeWJyJqKf3iLewUSH5ZFfFYJTIkdhkKLFcniT7hDLSN0JMb9ZygG0YpojgGK
 2zOG7Ydt/L+c4OkFvEcAYOnJ8WuMP2xBtyFXEVc+MInFl/HFChO9e6AJTzGFqW+kbf
 m8918wIfgWDIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707141238.711499-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260707141238.711499-1-Arunpravin.PaneerSelvam@amd.com>
 <20260707141238.711499-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:24:27 +0000
Message-Id: <20260707142428.D415F1F00A3A@smtp.kernel.org>
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
- [Medium] Resource exhaustion (OOM) due to massive allocation loop in KUni=
t test
--

--- Patch [2]: [PATCH v5 2/2] gpu/tests/buddy: add dirty tracker performanc=
e KUnit test ---
commit 227b33731ff64ce8294c937aa003f6e17a7481ed
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a new KUnit test to demonstrate the performance advantage =
of the decoupled dirty-tracker design. The test runs two scenarios on a 4 G=
iB pool with 4 KiB allocations to evaluate contiguous and repeated allocati=
on latency.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index e31f368ada951..e37505849ecc7 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
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
Could this loop cause an Out-Of-Memory (OOM) regression in constrained KUnit
environments?

Since the test fragments a 4 GiB pool into 4 KiB chunks, this loop executes
1,048,576 times. The allocator will create nearly 2 million struct
gpu_buddy_block metadata nodes, which can consume around 192 MB of kernel s=
lab
memory (and significantly more with KASAN enabled).=20

KUnit tests often run in restricted environments like UML with 128-256 MB of
RAM, so this might reliably trigger an OOM panic and break the test suite.

Could a smaller pool size be used to demonstrate the performance difference
without consuming as much kernel memory?

[ ... ]
> +	/*
> +	 * Repeated alloc throughput from a maximally fragmented pool
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
The same massive allocation loop is repeated for the second scenario here.
Does this need to be scaled down as well to avoid exhausting memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707141238.7114=
99-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
