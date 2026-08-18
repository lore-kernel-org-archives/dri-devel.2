Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DF4C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D29710EAAB;
	Tue, 18 Aug 2026 10:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bW8Zzuzf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F85C10EA9B;
 Tue, 18 Aug 2026 10:05:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23BAF416A8;
 Tue, 18 Aug 2026 10:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C7E1F000E9;
 Tue, 18 Aug 2026 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787047537;
 bh=h4EIxp18XFo3pImDTA9Mf1R2dqbXshSH5CFQu5u5Ibk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bW8Zzuzfee86lUlOO5UxW24x4vJxqIJLb+5zqHi+wjj27DFqdBYfJwK/mElbTXF9J
 UeuYwSPXY7wk78+bHDmtxVcuZsx5/3QhqdgNqoTf3maRgT6OzMmNANkSqHfLR9fOG7
 h9lFYWTKkyl9HRJbjhNVdns64SqWvluA5GO+A3lQlY+q8ADHQMJPhUPS/z5QTDsrXW
 s+bJmb5cylI7mLqXpAtpw6BPjvB2pvtpnGsIjWUWtJGS0guOJxa0N+TXSwPA9WtQJ+
 3e/miKY8XGAFX30l9pTtH4fSx3cFE+fweA0BrTxwMMO1omhWd/ht941AtX4nsQ0Vkw
 yu/WFpuMlQF9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] drm/i915/selftests: Use drm_* prints in mock
 selftests
To: "Krzysztof Karas" <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260818095624.3254368-2-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-2-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:05:36 +0000
Message-Id: <20260818100536.C5C7E1F000E9@smtp.kernel.org>
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
- [Medium] Replacing `pr_err()` and `pr_debug()` with `drm_err(NULL, ...)` =
and `drm_dbg(NULL, ...)` in mock selftests pollutes the kernel log with `(N=
ULL device *)` boilerplate.
- [Low] Incorrect indentation on `err =3D expect_pfn_sgtable(...);`.
- [Low] Renaming the `ignored` parameter to `arg` without using it reduces =
code clarity.
--

--- Patch [1]: [PATCH v2 1/8] drm/i915/selftests: Use drm_* prints in mock =
selftests ---
commit bac5b0f26375c24916b2bc63bce26e485e392abc
Author: Krzysztof Karas <krzysztof.karas@intel.com>

    drm/i915/selftests: Use drm_* prints in mock selftests

This commit replaces generic pr_* prints with drm_* versions in the mock
selftests to be more device context aware.

> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu=
/drm/i915/selftests/i915_sw_fence.c
> index 6a305322e30db..462704e575f5b 100644
> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
[ ... ]
> @@ -107,7 +109,7 @@ static int test_dag(void *arg)
>  		return -ENOMEM;
> =20
>  	if (i915_sw_fence_await_sw_fence_gfp(A, A, GFP_KERNEL) !=3D -EINVAL) {
> -		pr_err("recursive cycle not detected (AA)\n");
> +		drm_err(NULL, "recursive cycle not detected (AA)\n");

[Severity: Medium]
Will passing NULL to drm_err() here and elsewhere result in the log being
polluted with "(NULL device *)" boilerplate? Since mock selftests typically
run without a real device context, does using drm_err(NULL, ...) actually
provide the context mentioned in the commit message, or does it just
degrade the log output formatting?

[ ... ]
> diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/d=
rm/i915/selftests/scatterlist.c
> index 7e59591bbed6c..d8fbe5a8060b6 100644
> --- a/drivers/gpu/drm/i915/selftests/scatterlist.c
> +++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
[ ... ]
> @@ -275,7 +281,7 @@ static const npages_fn_t npages_funcs[] =3D {
>  	NULL,
>  };
> =20
> -static int igt_sg_alloc(void *ignored)
> +static int igt_sg_alloc(void *arg)

[Severity: Low]
This isn't a bug, but renaming the parameter from "ignored" to "arg" makes
it less obvious that the parameter is intentionally unused. Is there a
reason this was changed?

[ ... ]
> @@ -305,7 +311,7 @@ static int igt_sg_alloc(void *ignored)
> =20
>  				prandom_seed_state(&prng,
>  						   i915_selftest.random_seed);
> -				err =3D expect_pfn_sgtable(&pt, *npages, &prng,
> +					err =3D expect_pfn_sgtable(&pt, *npages, &prng,

[Severity: Low]
This isn't a bug, but it looks like this line was accidentally indented
with an extra tab, causing it to misalign with the surrounding code.

>  							 "sg_alloc_table",
>  							 end_time);
>  				sg_free_table(&pt.st);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818095624.3254=
368-1-krzysztof.karas@intel.com?part=3D1
