Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B91C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1FE710E95B;
	Tue, 25 Aug 2026 08:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NE0RKJaU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E439B10E958
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD17243237
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE91F00ADF;
 Tue, 25 Aug 2026 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787645438;
 bh=kda4egYi+HJ8ZUWi/6v+5yJ7Z+Z70ZaG3K4+NDbDqpI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NE0RKJaUQ6n+tJILeoBBvzrkn/qDib07adLIu+uphLpvp8DubN+zvBZsDFggAgWRn
 69+bml/mi800S/mD4l3W8sGAZuetzB4E9Flu71f+/34tZyafXpzXOiIzepeQ2eahBU
 WgmouX5aNl/5qxHMCiqhKgb3Q6SZ11lyxdFsaLVIF3fKyGLkJehqln/Q2MBuJ9mrpx
 jEXcV0v4r9EodhWspphUyUgFpP9AGCNOg05Py2O7dHk58ih4xTN/tkE8kitHSSSxyj
 cXOdbhfcEvf7Tj9mPhhLE3D8V3kJfOJsWUJWYwRnZZ3V2aFxTgDetWXZI2yEUhC1zL
 z5znHz5/eN6/w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/12] drm/fabric: add mutation KUnit tests
To: "Konstantin Sinyuk" <ksinyuk@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <56ac95cbe4dfdfec86f4828bd59e4b3539b9bb39.1787552412.git.ksinyuk@kernel.org>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <56ac95cbe4dfdfec86f4828bd59e4b3539b9bb39.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 08:10:38 +0000
Message-Id: <20260825081038.8AAE91F00ADF@smtp.kernel.org>
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
- [Medium] Uninitialized pointer in test timeout path causes kernel panic d=
uring cleanup
--

--- Patch [11]: [RFC PATCH 11/12] drm/fabric: add mutation KUnit tests ---
commit 4053deb9cc41982c0c7a86f0e14eb969bfd85f18
Author: Konstantin Sinyuk <ksinyuk@kernel.org>

drm/fabric: add mutation KUnit tests

This commit adds KUnit coverage for the drm_fabric object model and
topology-mutation paths. It tests various endpoint and port mutation scenar=
ios,
including concurrent mutations, orphan attach/detach, and error paths.

> diff --git a/drivers/gpu/drm/fabric/drm_fabric_test.c b/drivers/gpu/drm/f=
abric/drm_fabric_test.c
> index 863b7cf690689..d2c88d1837375 100644
> --- a/drivers/gpu/drm/fabric/drm_fabric_test.c
> +++ b/drivers/gpu/drm/fabric/drm_fabric_test.c
[ ... ]
> +static void drm_fabric_test_attach_register_collision(struct kunit *test)
> +{
[ ... ]
> +	/* B then proceeds and must fail: X is now owned by A. */
> +	KUNIT_EXPECT_GT(test,
> +			wait_for_completion_timeout(&l4->reg_done, msecs_to_jiffies(5000)),
> +			0);
> +	if (!IS_ERR(l4->reg_ep)) {
> +		KUNIT_ASSERT_EQ(test, 0,
> +				kunit_add_action_or_reset(test,
> +							  fabrictest_unregister_endpoint,
> +							  l4->reg_ep));
> +		KUNIT_FAIL(test, "racing registration unexpectedly succeeded");
> +		return;
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, PTR_ERR(l4->reg_ep), -EEXIST);
> +}

[Severity: Medium]
If the registration thread stalls and wait_for_completion_timeout() times o=
ut
(returning 0), l4->reg_ep will remain NULL since l4 was allocated with
kunit_kzalloc().

Because IS_ERR(NULL) evaluates to false, wouldn't this execution path enter
the if block and pass NULL to fabrictest_unregister_endpoint() during clean=
up?

This would lead to a NULL pointer dereference and a kernel panic when
drm_fabric_endpoint_unregister() attempts to access the pointer.

Should this check use IS_ERR_OR_NULL(l4->reg_ep) instead, or should l4->reg=
_ep
be initialized to an error pointer before the thread is spawned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787552412.gi=
t.ksinyuk@kernel.org?part=3D11
