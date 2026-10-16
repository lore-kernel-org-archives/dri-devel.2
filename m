Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E8ECC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024B110E1FB;
	Fri, 16 Oct 2026 07:52:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8652910E1FB
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:52:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54FAC42DC3
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177411F000C4;
 Fri, 16 Oct 2026 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792137155;
 bh=zNuJeybEjq5Z0oP33CKb8VD2CTg8g5Z/IASC1pylSwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UsOcrKQ5me5+3Iido2u/MI9SpfNpKqIbxTFZV+0BZ5tVE6ScupnDTRn9h1L2nk2CZ
 UPvlIHl2lD1xar4rm0O9ChuGKYnrIz2axurb5IQPPro2cuFYy0Go8TImS7JIljbpwp
 KjuyEGTpxltbgr9dS7mwv2w+msig66BMVuhr48z+Bqwb2p77AByTtXADI8Vhb+rKg1
 PNgLGy3qDDiGssQl/hNUQG62PCzTxQkSoD2UqMeEseCqu9B6ZOcgFws3yi6kamRMbH
 cLveQnlpzat8QdGoVFt+2CbUYOxW3an30yUwpTW1fouHNkvl67SKt6ErNM4MWVI1fP
 /5f0vEpfVYDlw==
Message-ID: <sashiko-outbox-173975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/14] drm/tests: atomic: Add tests for
 drm_atomic_commit_fill_with_defaults()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261016-drm-reset-state-flag-v5-11-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
 <20261016-drm-reset-state-flag-v5-11-dad2d64b693b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:52:34 +0000
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
- [Medium] drm/tests: modeset lock leak on KUNIT_ASSERT failure
- [Medium] drm/tests: mock connector lacks atomic_create_state causing test=
 failure
- [Medium] drm/tests: plane is not enabled before reset in fill_with_defaul=
ts test
--

commit 181cb0103d707708bd4c194386205faf1d9fca47
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()

This commit adds KUnit test coverage for
drm_atomic_commit_fill_with_defaults() to ensure it properly resets CRTC,
plane, and connector states. The tests verify both the reset state and a
subsequent modeset commit sequence.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/te=
sts/drm_atomic_test.c
> index ea91bec6569e6..988ec5523147d 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_test.c
[ ... ]
> @@ -140,13 +140,137 @@ static struct kunit_case drm_atomic_get_connector_=
for_encoder_tests[] =3D {
>  /*
>   * Test that after enabling a CRTC, plane, and connector, filling with
>   * defaults produces a state where all objects are disabled: CRTC is
[ ... ]
> +static void drm_test_check_fill_with_defaults(struct kunit *test)
> +{
[ ... ]
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +retry_enable:
> +	ret =3D drm_kunit_helper_enable_crtc_connector(test, drm,
> +						     priv->crtc,
> +						     &priv->connector,
> +						     mode, &ctx);

[Severity: Medium]
The commit message states the test "enables a CRTC, plane, and connector",
but drm_kunit_helper_enable_crtc_connector() configures the CRTC and
connector without assigning a framebuffer or CRTC to the plane.

Since the plane is never actively enabled before the reset, does this test
only verify that an already-disabled plane remains disabled rather than
testing the teardown transition of an active plane?

> +	if (ret =3D=3D -EDEADLK) {
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_enable;
> +	}
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	state =3D drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +	ret =3D drm_atomic_commit_fill_with_defaults(state);

[Severity: Medium]
Will drm_atomic_commit_fill_with_defaults() unconditionally return
-EOPNOTSUPP here?

The mock connector initialized with drm_atomic_init_connector_funcs lacks
the .atomic_create_state hook. Since drm_atomic_commit_fill_with_defaults()
iterates over connectors and requires this hook, this seems like it will
unconditionally fail the test.

> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
If this assertion (or any subsequent KUNIT_ASSERT_*) fails, it forces an
immediate return from the function.=20

Since drm_modeset_acquire_init() and drm_kunit_helper_enable_crtc_connector=
()
acquired modeset locks, would an early return bypass
drm_modeset_drop_locks(&ctx) and leak the ww_mutexes and ww_acquire_ctx?

Should KUNIT_EXPECT_* macros combined with a cleanup goto label or KUnit
deferred actions be used instead of KUNIT_ASSERT_* to ensure locks are
released?

> +
> +	new_crtc_state =3D drm_atomic_get_new_crtc_state(state, priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_crtc_state);
[ ... ]
> +static void drm_test_check_fill_with_defaults_commit(struct kunit *test)
> +{
[ ... ]
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +retry_enable:
> +	ret =3D drm_kunit_helper_enable_crtc_connector(test, drm,
> +						     priv->crtc,
> +						     &priv->connector,
> +						     mode, &ctx);

[Severity: Medium]
Similar to the first test, this helper omits enabling the plane before
performing the reset round-trip. Could this leave the plane teardown
untested as well?

> +	if (ret =3D=3D -EDEADLK) {
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_enable;
> +	}
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	state =3D drm_kunit_helper_atomic_state_alloc(test, drm, &ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
> +
> +	ret =3D drm_atomic_commit_fill_with_defaults(state);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
As in the previous function, an assertion failure here would skip the
cleanup block at the end of the function. Can this leak the modeset locks
acquired above?

> +
> +	state->allow_modeset =3D true;
> +
> +	ret =3D drm_atomic_commit(state);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-drm-reset-=
state-flag-v5-0-dad2d64b693b@kernel.org?part=3D11
