Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFF1C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F59110EB25;
	Tue, 25 Aug 2026 17:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IoiQ0XUL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3B910EB28;
 Tue, 25 Aug 2026 17:32:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3033601E9;
 Tue, 25 Aug 2026 17:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229CF1F000E9;
 Tue, 25 Aug 2026 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787679132;
 bh=GtqPP61gOJ88RfJEv37mZgEQ6pnDgu4qXCI7bOhPWZg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IoiQ0XULpihx4LQ+udvqSWv+1zig1GWmrvU+Cpit1h1x9ivJpr/ix7qlf2NxToT1X
 nFRtuUHt7XY3f2iUSgAIYeHcq4Y8zut95E+Lmgbzq5bYTbeWH5xonZ6KlMZI7EaYh6
 OQ7GvjDcBQTt+MF6O195w2nl/v6LDUO/Bp9IClA+Fgbi2n5iNgKERF/X3swIPgEQ5Q
 NA28GiTIt+2ZWGS59C7kXcDDoEworGfKIGZRwsfdr2xGCO0gPlC3cbBf3d2qS7Ha08
 8aSH0VUq62/BRfLj+qXMI/d8HEZnjH4Vw7kJ5B4DPtyDjJwO7hqSbBboyVhEwcK0kP
 m6yinbu8Jq1rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260825172432.80355-2-Arunpravin.PaneerSelvam@amd.com>
References: <20260825172432.80355-1-Arunpravin.PaneerSelvam@amd.com>
 <20260825172432.80355-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:32:11 +0000
Message-Id: <20260825173212.229CF1F000E9@smtp.kernel.org>
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
- [Medium] Dynamically allocated kernel memory leaks if a KUnit assertion f=
ails during block allocation.
--

commit b7e7a71f5be8a7ec99f348cd4b1b9f77122e136f
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

gpu/tests/buddy: add dirty tracker performance KUnit test

This commit adds a new KUnit test to demonstrate the performance benefits of
the decoupled dirty-tracker design over the old approach. The test runs two
scenarios on a 4 GiB pool with alternating fragmentation and measures block
allocation throughput.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 6ce485eae83ee..b75d32ca6ca0a 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
[ ... ]
> @@ -283,6 +283,121 @@ static void gpu_test_buddy_fragmentation_performanc=
e(struct kunit *test)
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
Could this leak dynamically allocated kernel memory if the test assertion
fails during block allocation?

The test performs 1,048,576 allocations in this loop. If any of these fail
(for instance, due to system memory pressure), KUNIT_ASSERT_FALSE_MSG
triggers and immediately aborts execution. Because there are no deferred
cleanup handlers registered, all previously allocated buddy blocks in the
local lists and internal structures allocated by gpu_buddy_init() are
permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825172432.8035=
5-1-Arunpravin.PaneerSelvam@amd.com?part=3D2
