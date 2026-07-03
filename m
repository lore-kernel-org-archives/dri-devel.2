Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71590C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A950510E19E;
	Fri,  3 Jul 2026 16:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8ZeLHZp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAED10E19E
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:55:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5361543B3B;
 Fri,  3 Jul 2026 16:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF681F000E9;
 Fri,  3 Jul 2026 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783097728;
 bh=21II/GG0agwVpOm+bttpi4g15h3S//hvCjVpwpmkapY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m8ZeLHZpFq1sG8mFWxoUB4/yV2DwxZ0b/YsqUL5JZHtODa5IKOgQi5A3DH2g+u8rA
 v+DoryBHiz94Ue3MjG2g9Y8QANeB4PV1iNil4ayRg2rANLdoJIERAFzd9EQbN2l4sC
 899UtdgassJzUefhoFD+AvlG7dEkfYi5mevyX9+aPaZJYe5ce8aDI7JxQhIXp9YtM6
 52jW34COD8akegw7C8ChKCLOcBVUaqy3s6xfMBLhnflo/gLOLVr6226e2mz8w+l9iQ
 2b+nsKSXeIaaQNqEumAgsYVONmGr4nTgqxRIy7slzuzg3VzaRmIkI5vYxLZHyjDIix
 1VJx0SWODh7aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] drm/ttm: switch to
 ttm_bo_lru_for_each_reserved_guarded for swapout
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-5-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-5-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 16:55:27 +0000
Message-Id: <20260703165528.0DF681F000E9@smtp.kernel.org>
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
- [High] An unconditional `continue;` inside the `ttm_device_swapout` loop =
bypasses return value checking and early return logic.
- [Medium] The modified `ttm_bo_swapout` signature and removed export break=
s KUnit tests, causing a compilation failure.
--

commit d0589786d39c3dde940e7f100cb47e8cc913ab55
Author: Christian K=C3=B6nig <christian.koenig@amd.com>

drm/ttm: switch to ttm_bo_lru_for_each_reserved_guarded for swapout

This commit refactors the TTM buffer object swapout logic to use
ttm_bo_lru_for_each_reserved_guarded instead of the wrapper walk.
It simplifies ttm_bo_swapout by removing the target page count
and resource manager arguments.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 1fb8c53da0362..24c52df169ac8 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -1183,37 +1176,6 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struc=
t ttm_buffer_object *bo)
>  	return ret;
>  }
> =20
> -/**
> - * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
> - * @bdev: The ttm device.
> - * @ctx: The ttm_operation_ctx governing the swapout operation.
> - * @man: The resource manager whose resources / buffer objects are
> - * goint to be swapped out.
> - * @gfp_flags: The gfp flags used for shmem page allocations.
> - * @target: The desired number of pages to swap out.
> - *
> - * Return: The number of pages actually swapped out, or negative error c=
ode
> - * on error.
> - */
> -s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ct=
x,
> -		   struct ttm_resource_manager *man, gfp_t gfp_flags,
> -		   s64 target)
> -{
[ ... ]
> -}
> -EXPORT_SYMBOL_FOR_TESTS_ONLY(ttm_bo_swapout);

[Severity: Medium]
Does removing this export and changing the function signature break KUnit
tests?

It looks like ttm_bo_validate_test_cases() in=20
drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c still calls this function=
=20
using the previous 5-argument signature, which could break the build when
CONFIG_DRM_TTM_KUNIT_TEST is enabled.

> -
>  void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)
>  {
>  	if (bo->ttm =3D=3D NULL)
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_d=
evice.c
> index d3bfb9a696a74..e4188e2ee7ab1 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
[ ... ]
> @@ -179,10 +185,15 @@ int ttm_device_swapout(struct ttm_device *bdev, str=
uct ttm_operation_ctx *ctx,
>  		if (!man || !man->use_tt)
>  			continue;
> =20
> -		lret =3D ttm_bo_swapout(bdev, ctx, man, gfp_flags, 1);
> -		/* Can be both positive (num_pages) and negative (error) */
> -		if (lret)
> -			return lret;
> +		ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &arg, bo) {
> +			lret =3D ttm_bo_swapout(bo, ctx, gfp_flags);
> +				continue;

[Severity: High]
Does this unconditional continue make the error checking and return logic
below unreachable?

Because the loop skips to the next iteration immediately, it will
indiscriminately swap out every buffer object on the LRU list regardless of
the target pages and ignore any return values. Callers like
ttm_global_swapout() would interpret a 0 return value as failure to swap,
which could cause loops in ttm_tt_populate() to terminate prematurely even
if memory limits are exceeded.

> +			/* Can be both positive (num_pages) and negative (error) */
> +			if (lret && lret !=3D -EBUSY && lret !=3D -EALREADY)
> +				return lret;
> +		}
> +		if (IS_ERR(bo))
> +			return PTR_ERR(bo);
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D5
