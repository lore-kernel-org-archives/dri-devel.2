Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA78606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehLOq77s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE90112732;
	Fri, 30 Oct 2026 10:39:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 578F7112732
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:39:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04AAE43A8A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB1C1F00A18;
 Fri, 30 Oct 2026 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356782;
 bh=Nm7CfFzNaSpyTI8c+HfoFsC0wk5vMUeu0Nw6x+o1kR4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ehLOq77sD4iDItx/bgt76D5ZdJBb6+kQPBN1TLcrFUZNBCLVmVdgZ8lAidDb6oejZ
 ckmEenYcvKB5XHykjTAE0D4DyjMHDuNqtG/kfGhRgI89g/R6PGN9UXVbR9dfya77jh
 bYtnXgQto/DY6zrrVaCdMKbHN2hXhU+QXVgRny8fj+1G+DLKwrV9AeY7K+1Mf2doLP
 raL6RtzwGGpjmKDBCaMaFrO7glC93+Sy2PLKAyuX2BgIJRTt2xfL12jvM3UWQdxNqe
 fwgmNKBZI+J77ODFiPvOmveuTXxX1HW0c2GcwbTkIX3BAdfU2pSV9KJx5p4/8imb8c
 FDeK8Vtx0F56w==
Message-ID: <sashiko-outbox-190855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/16] drm/tests: atomic: Add tests for
 drm_atomic_commit_fill_with_defaults()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-drm-reset-state-flag-v7-13-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
 <20261030-drm-reset-state-flag-v7-13-4e55eaeae683@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:39:42 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/tests: missing atomic_create_state in drm_atomic_init_connec=
tor_funcs
- [Low] drm/tests: commit message does not match added tests in drm_atomic_=
test.c
--

commit 0885e84f724b909721af519687158e094325a32c
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()

This commit adds a KUnit test suite in drivers/gpu/drm/tests/drm_atomic_tes=
t.c
to exercise drm_atomic_commit_fill_with_defaults().

>     drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults=
()
>    =20
>     drm_atomic_commit_fill_with_defaults() is used by the
>     DRM_MODE_ATOMIC_RESET flag to bring all objects back to their pristine
>     state. However, it has no dedicated test coverage.
>    =20
>     Add two tests that verify the reset cycle. The first enables a CRTC,
>     plane, and connector, then calls drm_atomic_commit_fill_with_defaults=
()
>     and verifies all objects return to their disabled state: CRTC inactiv=
e,
>     plane disabled with no framebuffer, and connector unbound. The second
>     goes further and commits the default-filled state to verify the
>     init -> enable -> reset -> commit sequence completes without errors.
>    =20
>     Suggested-by: Daniel Stone <daniel@fooishbar.org>
>     Signed-off-by: Maxime Ripard <mripard@kernel.org>

[Severity: Low]
This isn't a bug, but does the commit message match the tests added by this
patch?

The commit message states that two tests are added and that the first test
enables a CRTC, plane, and connector. However, drm_atomic_fill_with_default=
s_tests
adds four test cases (also including drm_test_check_fill_with_defaults_colo=
r_mgmt
and drm_test_check_fill_with_defaults_no_modeset), and as noted in the comm=
ent
above drm_test_check_fill_with_defaults(), the test only enables the CRTC a=
nd
connector via drm_kunit_helper_enable_crtc_connector() without enabling the
plane.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/te=
sts/drm_atomic_test.c
> index ea91bec6569e6..e8f18b8f6361e 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_test.c

[ ... ]

> @@ -140,13 +141,321 @@ static struct kunit_case drm_atomic_get_connector_=
for_encoder_tests[] =3D {
>  	{ }
>  };
> =20
> -
>  static struct kunit_suite drm_atomic_get_connector_for_encoder_test_suit=
e =3D {
>  	.name =3D "drm_test_atomic_get_connector_for_encoder",
>  	.test_cases =3D drm_atomic_get_connector_for_encoder_tests,
>  };
> =20
> -kunit_test_suite(drm_atomic_get_connector_for_encoder_test_suite);
> +/*
> + * Test that after enabling a CRTC and connector, filling with defaults
> + * produces a state where all objects are disabled: CRTC is inactive,
> + * plane is disabled, and connector is unbound.
> + *
> + * This is done without any lease, so all objects are expected to be
> + * reset.
> + *
> + * The plane is not explicitly enabled with a framebuffer here, so
> + * this validates that fill_with_defaults produces a consistent
> + * disabled state rather than testing an active plane teardown.
> + */
> +static void drm_test_check_fill_with_defaults(struct kunit *test)
> +{
> +	struct drm_atomic_test_priv *priv;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_connector_state *new_conn_state;
> +	struct drm_crtc_state *new_crtc_state;
> +	struct drm_plane_state *new_plane_state;
> +	struct drm_atomic_commit *state;
> +	struct drm_display_mode *mode;
> +	struct drm_device *drm;
> +	int ret;
> +
> +	priv =3D create_device(test);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv);
> +
> +	drm =3D &priv->drm;
> +
> +	mode =3D drm_kunit_display_mode_from_cea_vic(test, drm, 16);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode);
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +retry_enable:
> +	ret =3D drm_kunit_helper_enable_crtc_connector(test, drm,
> +						     priv->crtc,
> +						     &priv->connector,
> +						     mode, &ctx);
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
> +retry_fill:
> +	ret =3D drm_atomic_commit_fill_with_defaults(NULL, state);
> +	if (ret =3D=3D -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry_fill;
> +	}
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
As reported by Sashiko on v6 [1], won't drm_atomic_commit_fill_with_default=
s()
fail with -EOPNOTSUPP in all four tests here?

Each test calls create_device(), which initializes priv->connector with
drm_atomic_init_connector_funcs:

drivers/gpu/drm/tests/drm_atomic_test.c:
static const struct drm_connector_funcs drm_atomic_init_connector_funcs =3D=
 {
	.atomic_destroy_state	=3D drm_atomic_helper_connector_destroy_state,
	.atomic_duplicate_state	=3D drm_atomic_helper_connector_duplicate_state,
	.reset			=3D drm_atomic_helper_connector_reset,
};

Because .atomic_create_state is left NULL on drm_atomic_init_connector_func=
s,
drm_atomic_commit_fill_with_defaults() acquires the modeset locks on
state->acquire_ctx and then returns -EOPNOTSUPP when iterating over connect=
ors:

drivers/gpu/drm/drm_atomic.c:drm_atomic_commit_fill_with_defaults()
		if (!connector->funcs->atomic_create_state) {
			drm_connector_list_iter_end(&conn_iter);
			return -EOPNOTSUPP;
		}

This causes KUNIT_ASSERT_EQ(test, ret, 0) in drm_test_check_fill_with_defau=
lts(),
drm_test_check_fill_with_defaults_commit(),
drm_test_check_fill_with_defaults_color_mgmt(), and
drm_test_check_fill_with_defaults_no_modeset() to fail and abort the test
before drm_modeset_drop_locks(&ctx) and drm_modeset_acquire_fini(&ctx) are
reached, leaving the acquired modeset locks linked to the stack-allocated c=
tx
during KUnit device teardown.

Should drm_atomic_init_connector_funcs set .atomic_create_state to
drm_atomic_helper_connector_create_state?

[1] https://lore.kernel.org/r/20261022-drm-reset-state-flag-v6-12-f36d640b7=
e76@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-drm-reset-=
state-flag-v7-0-4e55eaeae683@kernel.org?part=3D13
