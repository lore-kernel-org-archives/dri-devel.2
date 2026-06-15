Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538F2CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 23:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0D710E78A;
	Mon, 15 Jun 2026 23:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b4puAP2k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D82310E78A
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 23:59:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B0BE6008A;
 Mon, 15 Jun 2026 23:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B411F000E9;
 Mon, 15 Jun 2026 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781567962;
 bh=AzfmEQlv66Pillv8mZ6NBaDoUHiAL+VxXt2aFAfykb8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b4puAP2kD6vfNxS1kF+ODxVp5D2BbwnefcSL/DaDISm/dByoQw3M4asxr6K1aXlzm
 CAXqHG7anPn4HsaXFfn2ddnTR5OKXyT+WNrmi1tjQODuH7xJqDTl3WDq8F+Owo4uAE
 t+P1kzFt6hN8K/UIMGhvoadBOD+rNxmsXLdBANW7ZjMY8JDtRI/Jr6DAd+iI8aJ5mV
 0vO7c2AYvHyv/rvZiIK44RpwrjGS8wXDmGYX/cRpeCng3TYDfK2y4DLJ5zxv6/fWk6
 aYGbGgf+T5U5GgKYus/kCQfsSa9lqOd7lBT4gU2PDV39OHhfxeJPsZ3/39P6nKoNmX
 76Igu7bz4fUmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] drm/ttm/tests: add bulk_move cursor regression
 tests
To: "Samuel Ainsworth" <skainsworth@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615234922.151263-3-skainsworth@gmail.com>
References: <20260615234922.151263-3-skainsworth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:59:21 +0000
Message-Id: <20260615235922.02B411F000E9@smtp.kernel.org>
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
- [Medium] Memory and file descriptor leak for `swap_storage` and `ttm_tt` =
resources on the success path.
- [Medium] Lock held at task exit and freed while locked due to `KUNIT_ASSE=
RT_*` use inside a locked region.
--

commit abed13f9d3397ee088cf5f87e72965189b451b0f
Author: Samuel Ainsworth <skainsworth@gmail.com>

drm/ttm/tests: add bulk_move cursor regression tests

This commit adds two kunit tests for the bulk_move LRU cursor accounting.
The tests verify that a swapped resource is properly removed from the
cursor before being freed, preventing dangling pointers and KASAN warnings.
They run without a GPU using the existing TTM mock device.

> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/tt=
m/tests/ttm_bo_test.c
> index d468f83220720..07ad1a7821fd1 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -603,7 +603,170 @@ static void ttm_bo_multiple_pin_one_unpin(struct ku=
nit *test)
>  	ttm_resource_free(bo, &res);
>  }
> =20
> +/*
> + * Regression tests for bulk_move LRU cursor accounting: a resource adde=
d to a
> + * bo's bulk_move cursor can become unevictable (pinned or swapped) befo=
re it is
> + * freed. ttm_resource_del_bulk_move() must still take it off the cursor=
, or
> + * pos->first/last are left dangling at the freed resource.
> + */
> +
> +/*
> + * Free a swapped (unevictable) resource that is still referenced by the
> + * bulk_move cursor and check that the cursor no longer points at it.
> + */
> +static void ttm_bo_bulk_move_swapped_free_dangles(struct kunit *test)
> +{
[ ... ]
> +	bo1 =3D ttm_bo_kunit_init(test, priv, BO_SIZE, resv);
> +
> +	/* bo1: put a SYSTEM resource on the bulk_move pos */
> +	dma_resv_lock(bo1->base.resv, NULL);
> +	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
> +	err =3D ttm_resource_alloc(bo1, place, &res1, NULL);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
If this KUNIT_ASSERT_EQ() fails, kunit_abort() will immediately terminate
the test thread. Does this leave the bo1->base.resv lock held at task exit?

This could trigger a lockdep BUG splat since KUnit will subsequently free
the resv structure (allocated via kunit_kzalloc) while the mutex is still
locked.

> +	bo1->resource =3D res1;
> +
> +	pos =3D &lru_bulk_move.pos[TTM_PL_SYSTEM][bo1->priority];
> +	/* res1 is now tracked by the bulk_move pos */
> +	KUNIT_EXPECT_PTR_EQ(test, pos->first, res1);
> +	KUNIT_EXPECT_PTR_EQ(test, pos->last, res1);
> +
> +	/* make bo1->ttm swapped so res1 is "unevictable" (ttm_resource_is_swap=
ped) */
> +	tt =3D kunit_kzalloc(test, sizeof(*tt), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, tt);
> +	err =3D ttm_tt_init(tt, bo1, 0, ttm_cached, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	bo1->ttm =3D tt;
> +	err =3D ttm_tt_populate(ttm_dev, tt, &ctx);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	ttm_tt_swapout(ttm_dev, tt, GFP_KERNEL);
> +	KUNIT_ASSERT_TRUE(test, tt->page_flags & TTM_TT_FLAG_SWAPPED);

[Severity: Medium]
Does this code leak the ttm_tt resources and the swap_storage file descript=
or?

ttm_tt_swapout() allocates a shmem file descriptor via shmem_file_setup().
However, the test function never calls ttm_tt_destroy() or fput() on the
swap_storage file upon completion.

Since KUnit's automatic cleanup via kunit_kzalloc() is unaware of the
nested VFS file descriptor and pages, it appears this will leak memory and
file descriptors on every successful run.

> +
> +	/* res1 is still tracked by the pos right before the free */
> +	KUNIT_EXPECT_PTR_EQ(test, pos->first, res1);
[ ... ]
> +static void ttm_bo_bulk_move_dangling_corrupts(struct kunit *test)
> +{
[ ... ]
> +	/* bo1: resource on the bulk_move pos, then swap + free -> dangling pos=
 */
> +	dma_resv_lock(bo1->base.resv, NULL);
> +	ttm_bo_set_bulk_move(bo1, &lru_bulk_move);
> +	err =3D ttm_resource_alloc(bo1, place, &res1, NULL);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	bo1->resource =3D res1;
> +
> +	tt =3D kunit_kzalloc(test, sizeof(*tt), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, tt);
> +	err =3D ttm_tt_init(tt, bo1, 0, ttm_cached, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Similar to the issue above, if KUNIT_ASSERT_EQ() fails here, could it bypass
the dma_resv_unlock() and leave the dma_resv_lock held at task exit?

> +	bo1->ttm =3D tt;
> +	err =3D ttm_tt_populate(ttm_dev, tt, &ctx);
> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	ttm_tt_swapout(ttm_dev, tt, GFP_KERNEL);

[Severity: Medium]
Are the swap_storage file descriptor and ttm_tt resources created by
ttm_tt_swapout() being leaked here on test exit as well?

> +
> +	ttm_resource_free(bo1, &res1);
> +	dma_resv_unlock(bo1->base.resv);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615234922.1512=
63-1-skainsworth@gmail.com?part=3D2
