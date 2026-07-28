Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C54C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E554210E16A;
	Tue, 28 Jul 2026 12:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dcvORl7R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5368910E558
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:05:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39D8460AA1;
 Tue, 28 Jul 2026 12:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91E71F000E9;
 Tue, 28 Jul 2026 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785240322;
 bh=FPRahgvdd4dDdXnDF0/91WDRz9wh7ykNmLLC4P9sK34=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dcvORl7RCUQylRKKTJysa8LVA9GbIzmTKirZpUhUAVLm0egC8xdLWzVD0vw64hFAk
 0ZsGzRELqnaHIM5Z/wvlrws1XOsE7mECl8ce1s6fJVSNzFSZ0niYGTlbmogRrrpSVE
 p1jbAVlxMh/bLbbj027wlTvVdOchgfavjQjvMwtWAPFyCZEC8aLaca2K8lmfRZ/Y9M
 w0egHhEsYAjA9JNSIkoUpFcYDHRFeZz0bcWnL5l+6xkwLwul/5w8MC39n1f+Qtt2qN
 GEOKQKNPH8Sg/syTRJY+JSDG2++k+Kk+Z815i5k9DXaadFyeRdYs2+5mqiNM+eyJAt
 x+e3cIGH7MtPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 2/2] gpu/tests/gpu_buddy: Add KUnit test for
 gpu_buddy_allocated_addr_to_block
To: "Tejas Upadhyay" <tejas.upadhyay@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728114923.2675866-6-tejas.upadhyay@intel.com>
References: <20260728114923.2675866-4-tejas.upadhyay@intel.com>
 <20260728114923.2675866-6-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:05:22 +0000
Message-Id: <20260728120522.B91E71F000E9@smtp.kernel.org>
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
- [Low] Unused-but-set variable `target_addr` triggers compiler warning and=
 indicates untested dynamic address.
--

--- Patch [2]: [PATCH V2 2/2] gpu/tests/gpu_buddy: Add KUnit test for gpu_b=
uddy_allocated_addr_to_block ---
commit 6c61f24067cbdd29a5bf648a9a91a04477bc909c
Author: Tejas Upadhyay <tejas.upadhyay@intel.com>

gpu/tests/gpu_buddy: Add KUnit test for gpu_buddy_allocated_addr_to_block

This commit adds a new KUnit test gpu_test_buddy_addr_to_block() to validate
the gpu_buddy_allocated_addr_to_block() helper. The test verifies exact
address matching, unallocated addresses, and out-of-bounds addresses.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index 89698563c61b2..826a309697ed3 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
[ ... ]
> @@ -1422,6 +1422,48 @@ static void gpu_test_buddy_alloc_exceeds_max_order=
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
> +	u64 target_addr;
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, test_size, chunk_size),
> +			       "buddy_init failed\n");
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, alloc_start,
> +							    alloc_start + alloc_size,
> +							    alloc_size, chunk_size,
> +							    &allocated_list, 0),
> +			       "buddy_alloc failed\n");
> +
> +	allocated_block =3D list_first_entry(&allocated_list, struct gpu_buddy_=
block, link);
> +	KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(allocated_block), alloc_st=
art);
> +	KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, allocated_block), alloc=
_size);
> +	target_addr =3D gpu_buddy_block_offset(allocated_block);
> +
> +	found_block =3D gpu_buddy_allocated_addr_to_block(&mm, alloc_start);

[Severity: Low]
Is target_addr intentionally left unused here? It is assigned the offset
of the allocated block, but alloc_start is passed directly to
gpu_buddy_allocated_addr_to_block() instead. This might trigger a compiler
warning for an unused-but-set variable and suggests the test could be
bypassing the dynamic address it intended to validate.

> +	KUNIT_EXPECT_PTR_EQ(test, found_block, allocated_block);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728114923.2675=
866-4-tejas.upadhyay@intel.com?part=3D2
