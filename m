Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B11606A331
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUPmwUNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF23510E239;
	Wed, 21 Oct 2026 17:24:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4D510E239;
 Wed, 21 Oct 2026 17:24:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E827437F4;
 Wed, 21 Oct 2026 17:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4741F000C1;
 Wed, 21 Oct 2026 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792603478;
 bh=SzfufQJH9HNqkZrhTRrdx4IYMPk4N1COdm2E1FRvks8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BUPmwUNaTCErJlB7ts523bk+g+PCK5eTS6hzZpFpx2F02uVC445UGjy99EA0ud44c
 w52a1k2Io/hjzjD0ClHr0J5tyRxe3zgIDzNaZ47/BoOGfophNyUwCq9khVj1s9h7da
 YlYx7Jzdkb5tyiILobSt0vdOA1v2ft3PmU4uyWnPRmnbyspVjhGUu1g52LGY3YE1nF
 zAkmWj0hUv73TYZbN5ZSXDCdNZyE4ds9rbzi1jHMSm/RA9gPkshzeICgrDu8JCRsvp
 9lps74H1SBOty46NBM0zbTJdzS9vM1Cz/4dNICC6zXQcogBrEbcLgGw3m99hwRDRVZ
 xbt4yEN8MTZyQ==
Message-ID: <sashiko-outbox-180522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] gpu/tests/buddy: Add range-bias pruning and
 free-order tracking tests
To: "Sanjay Yadav" <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
In-Reply-To: <acd1a30cc29c3d6efc14723cb90434d0e378ea0a.1792599420.git.sanjay.kumar.yadav@intel.com>
References: <cover.1792599420.git.sanjay.kumar.yadav@intel.com>
 <acd1a30cc29c3d6efc14723cb90434d0e378ea0a.1792599420.git.sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:24:37 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] gpu/tests/buddy: 64-bit division in gpu_test_buddy_range_bias_pruni=
ng()
--

commit c218b91af95d861d31913d5c9b3ba0681e319523
Author: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

gpu/tests/buddy: Add range-bias pruning and free-order tracking tests

This commit adds KUnit tests in drivers/gpu/tests/gpu_buddy_test.c to verify
range-bias subtree pruning and subtree_max_free_order tracking across block
allocation, splitting, coalescing, and trimming operations.

> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_b=
uddy_test.c
> index b75d32ca6ca0a..4c7e823d57892 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1586,6 +1586,311 @@ static void gpu_test_buddy_addr_to_block(struct k=
unit *test)
>  	gpu_buddy_fini(&mm);
>  }
> =20
[ ... ]
> +static void gpu_test_buddy_range_bias_pruning(struct kunit *test)
> +{
> +	const u64 mm_size =3D SZ_512M, range_end =3D SZ_128M, chunk =3D SZ_4K;
> +	const unsigned int nr =3D range_end / chunk, window =3D 1024;
> +	const u64 holes[] =3D { 0, range_end / 2 + 3 * chunk };
> +	struct gpu_buddy_block *block, *hidden;
> +	u64 first_ns =3D 0, last_ns =3D 0;
> +	unsigned int i, misplaced =3D 0;
> +	LIST_HEAD(allocated);
> +	struct gpu_buddy mm;
> +	LIST_HEAD(tmp);
> +	int err;
[ ... ]
> +	for (i =3D 0; i < nr; i++) {
> +		ktime_t start =3D ktime_get();
> +		u64 elapsed;
> +
> +		err =3D gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
> +					     &allocated, GPU_BUDDY_RANGE_ALLOCATION);
> +		elapsed =3D ktime_to_ns(ktime_sub(ktime_get(), start));
> +		KUNIT_ASSERT_EQ_MSG(test, err, 0, "range alloc %u failed\n", i);
> +
> +		if (i < window)
> +			first_ns +=3D elapsed;
> +		else if (i >=3D nr - window)
> +			last_ns +=3D elapsed;
> +
> +		block =3D list_last_entry(&allocated, struct gpu_buddy_block, link);
> +		if (gpu_buddy_block_offset(block) !=3D range_end - (u64)(i + 1) * chun=
k)
> +			misplaced++;
> +	}
> +
> +	kunit_info(test, "first %u range allocs: %llu us, last %u: %llu us\n",
> +		   window, first_ns / NSEC_PER_USEC, window, last_ns / NSEC_PER_USEC);

[Severity: Low]
In gpu_test_buddy_range_bias_pruning() in drivers/gpu/tests/gpu_buddy_test.=
c,
first_ns and last_ns are u64 variables that accumulate runtime nanosecond
durations. On 32-bit architectures with CONFIG_GPU_BUDDY_KUNIT_TEST enabled,
won't dividing them directly with the / operator by NSEC_PER_USEC emit calls
to __udivdi3 or __aeabi_uldivmod and cause a link failure?

Should this use div_u64() (or ktime_to_us()) instead?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792599420.gi=
t.sanjay.kumar.yadav@intel.com?part=3D2
