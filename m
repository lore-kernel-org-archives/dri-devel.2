Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69F3C55838
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 05:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E915B10E2C7;
	Thu,  6 Aug 2026 05:46:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JXjwkYD3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFEBD10E2C7
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 05:46:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0204C60A64;
 Thu,  6 Aug 2026 05:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E20F1F000E9;
 Thu,  6 Aug 2026 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785995202;
 bh=ZD1joG4gv5KEwySDvogWgqxBXXb2i1Po/OQaaoSdrMQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JXjwkYD3+4Gv8kMoFSaS0sJaagNNukRTNAxdWv7NmGqZWWh1MpMCEvQAgQFqUNK7b
 d3nBMg/H5P6FhSP4/GqqizvsfRKlyxSeKLQ5sXttgbwKdiByVXCRgR/lXu/YFQSdRO
 MPm1xbxHrg7gli7rjwSvdhniL61EyJF9yYHCfXCX47lmG+g8hipw2MSG5RsfNIaaXQ
 2fZisYDLN+vYeA9iicTcXYfWztz5a/oYLhN8PsiIxG/EdGaYjIx9O9+ILJBU3zf47P
 RQqpg8ceDKS5/bPp++Q7elFkT6egWngO7tSQN8RrjMQo0m2D0a5lJOuV7hyok5qnBM
 +/4P274PY44mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: "Tejas Upadhyay" <tejas.upadhyay@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260806053624.3215216-6-tejas.upadhyay@intel.com>
References: <20260806053624.3215216-4-tejas.upadhyay@intel.com>
 <20260806053624.3215216-6-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 05:46:41 +0000
Message-Id: <20260806054642.0E20F1F000E9@smtp.kernel.org>
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
- [Medium] Memory leak on KUnit assertion failure due to bypassed cleanup.
--

--- Patch [2]: [PATCH V4 2/2] gpu/tests/gpu_buddy: Add KUnit test for gpu_b=
uddy_allocated_addr_to_block ---
commit 429e209c9177a128187845522d6b4613f6fbe30b
Author: Tejas Upadhyay <tejas.upadhyay@intel.com>

gpu/tests/gpu_buddy: Add KUnit test for gpu_buddy_allocated_addr_to_block

This patch adds a new KUnit test gpu_test_buddy_addr_to_block() to validate
the gpu_buddy_allocated_addr_to_block() helper function. The test verifies
exact address matching, unallocated addresses within the manager, and addre=
sses
outside the manager bounds.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 89698563c61b2..5860bfc84a25a 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1422,6 +1422,50 @@ static void gpu_test_buddy_alloc_exceeds_max_order=
(struct kunit *test)
>  	gpu_buddy_fini(&mm);
>  }
> =20
> +static void gpu_test_buddy_addr_to_block(struct kunit *test)
> +{
> +	struct gpu_buddy_block *allocated_block, *found_block;
> +	LIST_HEAD(allocated_list);
> +	const u64 test_size =3D SZ_4M + SZ_2M;
> +	const u64 alloc_start =3D SZ_4M;
> +	const u64 alloc_size =3D SZ_4K;
> +	const u64 chunk_size =3D SZ_4K;
> +	struct gpu_buddy mm;
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size, chunk_size),
> +			       "buddy_init failed\n");
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, alloc_start,
> +							    alloc_start + alloc_size,
> +							    alloc_size, chunk_size,
> +							    &allocated_list, 0),
> +			       "buddy_alloc failed\n");

[Severity: Medium]
Will this leak memory if the allocation fails? KUNIT_ASSERT_FALSE_MSG() abo=
rts
the test execution immediately on failure, bypassing the gpu_buddy_fini(&mm)
cleanup call at the end of the function. This would leak the memory allocat=
ed
by gpu_buddy_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806053624.3215=
216-4-tejas.upadhyay@intel.com?part=3D2
