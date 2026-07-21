Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B04CC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC54510E34B;
	Tue, 21 Jul 2026 11:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EAkA02Uj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8DC210E34B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:51:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DF3B41B15;
 Tue, 21 Jul 2026 11:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469F81F000E9;
 Tue, 21 Jul 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784634663;
 bh=FBj+i2GQfsYeCId/DocHffz7e9Nf1n66gUpRuElvKNI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EAkA02UjU+9dEQ1Cleh+AAr+YNQDMfGuT5ElteLsC+FxD0uu/79ipTNTDT7WH8aqm
 J0Pj6t5pAssC6Y1rCgMmKjs0PKNafAlVpOSeYKbQ1W3N79Hxarz2HjSQFQ4zr4mQNG
 wdT2Zms20URrwdoGmtBokCxcQp5eoHSpsN+WZh0SCXqI2brlHzXmf821/40UPbgmcG
 McwStZWi2ZH8bJWRNteKH0+a8vzFtgcFIBqLCgnbB46/6b85oKzvTsWDqM/AEP9eV+
 WdT1oB8SC/Ge37LkMmQxO64h12vFIr3zVL+w9+BNkUISmU3Rir5+1SHNhvV3yFkEB2
 yzZHu8ZkPukww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] drm/tests/gpu_buddy: add a new test case for buffer
 clearance during resume
To: "Arunpravin Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com>
References: <20260721114236.507578-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:51:02 +0000
Message-Id: <20260721115103.469F81F000E9@smtp.kernel.org>
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
- [Medium] The test fails to create the intended alternating block fragment=
ation, allocating contiguous blocks instead.
--

--- Patch [1]: [PATCH v6] drm/tests/gpu_buddy: add a new test case for buff=
er clearance during resume ---
commit 8231e2c55481150c6a9aaa5025aef00267d3c249
Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

drm/tests/gpu_buddy: add a new test case for buffer clearance during resume

This commit adds a new unit test case for buffer clearance issues during
resume. It aims to allocate alternating blocks of 4KiB in an even and odd
sequence, then free them as cleared, to verify that split blocks are proper=
ly
merged.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c

[ ... ]

> +	/*
> +	 * Using a non-power-of-two mm size, allocate alternating blocks of 4Ki=
B in an
> +	 * even sequence and free them as cleared. All blocks should be marked =
as
> +	 * dirty and the split blocks should be merged back to their original
> +	 * size when the blocks clear reset function is called.
> +	 */
> +	KUNIT_EXPECT_FALSE(test, gpu_buddy_init(&mm, mm_size, ps));
> +	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
> +
> +	i =3D 0;
> +	n_pages =3D mm_size / ps;
> +	do {
> +		if (i % 2 =3D=3D 0)
> +			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +									    ps, ps, &allocated, 0),
> +					"buddy_alloc hit an error size=3D%lu\n", ps);
> +	} while (++i < n_pages);

[Severity: Medium]
Does this loop actually create an alternating fragmented pattern?

Since gpu_buddy_alloc_blocks() simply returns the next available contiguous
free block, skipping loop iterations with if (i % 2 =3D=3D 0) might merely =
halve
the total number of sequential allocations.=20

This would result in a single contiguous chunk of allocated blocks rather
than the intended interleaved checkerboard pattern, bypassing the fragmenta=
tion
scenario the test relies on.

To properly interleave blocks, shouldn't the test allocate all pages into
two different lists and selectively free one of them, similar to what is
done earlier in this same test function?

> +
> +	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +	gpu_buddy_reset_clear(&mm, false);
> +	KUNIT_EXPECT_EQ(test, mm.clear_avail, 0);
> +
> +	/*
> +	 * Using a non-power-of-two mm size, allocate alternating blocks of 4Ki=
B in an
> +	 * odd sequence and free them as cleared. All blocks should be marked as
> +	 * cleared and the split blocks should be merged back to their original
> +	 * size when the blocks clear reset function is called.
> +	 */
> +	i =3D 0;
> +	do {
> +		if (i % 2 !=3D 0)
> +			KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size,
> +									    ps, ps, &allocated, 0),
> +					"buddy_alloc hit an error size=3D%lu\n", ps);
> +	} while (++i < n_pages);

[Severity: Medium]
Does this odd sequence suffer from the same contiguous allocation issue as
the even sequence loop above?

> +
> +	gpu_buddy_free_list(&mm, &allocated, GPU_BUDDY_CLEARED);
> +	gpu_buddy_reset_clear(&mm, true);
> +	KUNIT_EXPECT_EQ(test, mm.clear_avail, mm_size);
> +	gpu_buddy_fini(&mm);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721114236.5075=
78-1-Arunpravin.PaneerSelvam@amd.com?part=3D1
