Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68243C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B563610F675;
	Fri, 26 Jun 2026 15:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mU5R5TjA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39E3E10F647
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:06:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B14CF600C8;
 Fri, 26 Jun 2026 15:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356271F000E9;
 Fri, 26 Jun 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486376;
 bh=BScSLW7paEA8IOa+CNovFvuI76QIymtgkJQnNAzKDaw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mU5R5TjAEHuyMjQzByXL70U6jYmKJeLxPtNm/z6ruu9/cNNwfRa4FSIPBtnbh0j3W
 5jb2TfOc3RGae+EZIpoGWehECoa8LHX+Br3ZI/ejOHiYrnRffMM6l/xX5PkKXQJ8Yz
 8l+cnBoRWqUaeQkmpFw10HdNAAjVq7ug3oCyEtbUMIqG7EdJs96NzG2JvYKOl44EUO
 2Jc6wDQxQ2wTpLnem+gJdTNJKQq3F8l5aI/id+7Um8m/YwjE7jWAjwES5/YzTQWTp3
 6lUwpNd72745GX8eJA3PnOBjUP+27+bdGbsmr/T7amyJbH6KBo7XXYBY4xjB4rI1v4
 GslR8HitCeyUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/ttm/tests: use KUNIT_ASSERT_EQ for critical
 error checks to   prevent kref underflow
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626145409.49370-1-vulab@iscas.ac.cn>
References: <20260626145409.49370-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:06:15 +0000
Message-Id: <20260626150616.356271F000E9@smtp.kernel.org>
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
- [Medium] Using KUNIT_ASSERT_EQ aborts the test function on failure and by=
passes required manual resource teardown.
- [Medium] Erroneous fix replacing KUNIT_EXPECT_EQ with KUNIT_ASSERT_EQ aft=
er ttm_bo_validate() causes a leaked BO reference and potential Use-After-F=
ree.
--

commit af379b6fc27176bd6e80498788a4a528ca8f7559
Author: WenTao Liang <vulab@iscas.ac.cn>
fix: drm/ttm/tests: use KUNIT_ASSERT_EQ for critical error checks to preven=
t kref underflow

Replace KUNIT_EXPECT_EQ with KUNIT_ASSERT_EQ in ttm_bo_validate test cases
where subsequent ttm_bo_fini would cause a kref underflow if the preceding
ttm_bo_init_reserved (or ttm_bo_validate) failed. When those functions fail
they already release their internal references, leaving the refcount at 0.
Continuing to ttm_bo_fini without aborting performs an extra kref_put.

Cc: stable@vger.kernel.org
Fixes: 8bd1ff5ddc7b ("drm/ttm/tests: Test simple BO creation and validation=
")

> Replace KUNIT_EXPECT_EQ with KUNIT_ASSERT_EQ in ttm_bo_validate test cases
> where subsequent ttm_bo_fini would cause a kref underflow if the preceding
> ttm_bo_init_reserved (or ttm_bo_validate) failed. When those functions fa=
il
> they already release their internal references, leaving the refcount at 0.

Is this description accurate regarding ttm_bo_validate()?

Looking at ttm_bo_validate(), it does not drop the BO reference on its error
paths. Only ttm_bo_init_reserved() does this, so a failure in
ttm_bo_validate() would leave the reference intact.

> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/g=
pu/drm/ttm/tests/ttm_bo_validate_test.c
> index 2db221f6fc3a1..7c4179f6349c5 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
[ ... ]
> @@ -249,7 +249,7 @@ static void ttm_bo_validate_basic(struct kunit *test)
>  	err =3D ttm_bo_init_reserved(priv->ttm_dev, bo, params->bo_type,
>  				   fst_placement, PAGE_SIZE, &ctx_init, NULL,
>  				   NULL, &dummy_ttm_bo_destroy);
> -	KUNIT_EXPECT_EQ(test, err, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Will this leak the mock managers on failure?

Because KUNIT_ASSERT_EQ() aborts the test function immediately upon failure,
if ttm_bo_init_reserved() fails here, execution skips the
ttm_mock_manager_fini() cleanup at the end of ttm_bo_validate_basic().

This could leave dangling mock managers in the global state.

This pattern is also present in ttm_bo_validate_same_placement(),
ttm_bo_validate_all_pinned_evict(), and ttm_bo_validate_allowed_only_evict(=
),
where manual cleanups and mock manager teardowns would also be skipped.

[ ... ]
> @@ -840,7 +840,7 @@ static void ttm_bo_validate_happy_evict(struct kunit =
*test)
>  	err =3D ttm_bo_validate(bo_val, placement, &ctx_val);
>  	ttm_bo_unreserve(bo_val);
> =20
> -	KUNIT_EXPECT_EQ(test, err, 0);
> +	KUNIT_ASSERT_EQ(test, err, 0);

[Severity: Medium]
Does this skip necessary cleanup and leak the buffer object?

As noted above, ttm_bo_validate() does not drop the BO reference on failure.
If it fails here, aborting the test skips the mandatory ttm_bo_fini() loops
at the end of ttm_bo_validate_happy_evict().

While the test array is freed by KUnit on test exit, the leaked elements
might still be referenced by the DRM device's VMA manager. This could
potentially cause a use-after-free when the device is destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626145409.4937=
0-1-vulab@iscas.ac.cn?part=3D1
