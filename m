Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43D606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQ+2pzo8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146F3112685;
	Thu, 22 Oct 2026 14:04:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D50EE112685
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:04:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B7434082F
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589491F000C1;
 Thu, 22 Oct 2026 14:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792677888;
 bh=qNdlxnFsA1LbLcnID2YVkI915nB3eWo5NKU7BIfrXE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WQ+2pzo8+3g4whplXo0VDgT0uwfXhPwrqST2L9Ee/VhEg07fAbDvK5CCt0s+VaIgF
 g4C6fVwLaj33AQ59YOGEhguaNdqgMo23DxNANQ4t5qbnJ+I8s49K1rsh87acdTN4vK
 YUsFrwp73mWuGSHJjJFo8sr+7xH6HXjg+y69PtRJZVaFAt54WtmBRI9QWXtA2s557T
 lJdB1p/5+o1pPihy7j4id7cD2Z3y6mx7lwzeG6eVbsdhR9Z8u+7nCMCUz5ONSfijyo
 6JkpS9BE8rZB4E/DdkETuTkk0V4OSs1PNlS74PEs8OddFoMLibVVGxqdvDd+BWp0YP
 z9wbcRchDZSxQ==
Message-ID: <sashiko-outbox-181607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/15] drm/tests: atomic: Add tests for
 drm_atomic_commit_fill_with_defaults()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-reset-state-flag-v6-12-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
 <20261022-drm-reset-state-flag-v6-12-f36d640b7e76@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:04:47 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/tests: missing atomic_create_state in drm_atomic_init_connec=
tor_funcs
- [Medium] drm/tests: unhandled -EDEADLK in drm_atomic_commit_fill_with_def=
aults() tests
--

commit a5d738f6495a7d615ad4a76c37ce118ede4516ab
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: atomic: Add tests for drm_atomic_commit_fill_with_defaults()

This commit adds two KUnit tests for drm_atomic_commit_fill_with_defaults()
to verify resetting an enabled CRTC, plane, and connector back to their
disabled state and committing the default-filled state.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/te=
sts/drm_atomic_test.c
> index ea91bec6569e6..52db445b4eadb 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_test.c
> @@ -140,13 +140,150 @@ static struct kunit_case drm_atomic_get_connector_=
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
> +	ret =3D drm_atomic_commit_fill_with_defaults(NULL, state);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
Will drm_atomic_commit_fill_with_defaults() always return -EOPNOTSUPP here
and in drm_test_check_fill_with_defaults_commit() below?

create_device() initializes priv->connector with
drm_atomic_init_connector_funcs in drivers/gpu/drm/tests/drm_atomic_test.c:

    static const struct drm_connector_funcs drm_atomic_init_connector_funcs=
 =3D {
            .atomic_destroy_state   =3D drm_atomic_helper_connector_destroy=
_state,
            .atomic_duplicate_state =3D drm_atomic_helper_connector_duplica=
te_state,
            .reset                  =3D drm_atomic_helper_connector_reset,
    };

Because .atomic_create_state is not set on drm_atomic_init_connector_funcs,
drm_atomic_commit_fill_with_defaults() in drivers/gpu/drm/drm_atomic.c locks
the plane, CRTC, and connection_mutex into state->acquire_ctx, and then hit=
s:

    if (!connector->funcs->atomic_create_state) {
            drm_connector_list_iter_end(&conn_iter);
            return -EOPNOTSUPP;
    }

KUNIT_ASSERT_EQ(test, ret, 0) then aborts the test before
drm_modeset_drop_locks(&ctx) and drm_modeset_acquire_fini(&ctx) can run,
leaving those modeset locks held on the stack-allocated ctx when drmm
teardown runs drm_modeset_lock_fini().

Should drm_atomic_init_connector_funcs wire up .atomic_create_state to
drm_atomic_helper_connector_create_state?

> +
> +	new_crtc_state =3D drm_atomic_get_new_crtc_state(state, priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_crtc_state);
> +	KUNIT_EXPECT_FALSE(test, new_crtc_state->enable);
> +	KUNIT_EXPECT_FALSE(test, new_crtc_state->active);
> +
> +	new_plane_state =3D drm_atomic_get_new_plane_state(state, priv->plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_plane_state);
> +	KUNIT_EXPECT_NULL(test, new_plane_state->crtc);
> +	KUNIT_EXPECT_NULL(test, new_plane_state->fb);
> +
> +	new_conn_state =3D drm_atomic_get_new_connector_state(state, &priv->con=
nector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, new_conn_state);
> +	KUNIT_EXPECT_NULL(test, new_conn_state->crtc);
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}
> +
> +/*
> + * Test that after enabling a CRTC and connector, fill_with_defaults
> + * produces a state that can be successfully committed.
> + *
> + * This is done without any lease, so all objects are reset.
> + *
> + * The plane is not explicitly enabled with a framebuffer, so this
> + * validates that fill_with_defaults produces a consistent disabled
> + * state rather than testing an active plane teardown.
> + */
> +static void drm_test_check_fill_with_defaults_commit(struct kunit *test)
> +{
[ ... ]
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
> +	ret =3D drm_atomic_commit_fill_with_defaults(NULL, state);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	state->allow_modeset =3D true;
> +
> +	ret =3D drm_atomic_commit(state);
> +	KUNIT_EXPECT_EQ(test, ret, 0);

[Severity: Medium]
Can drm_atomic_commit_fill_with_defaults() (both here and in
drm_test_check_fill_with_defaults()) and drm_atomic_commit() fail with
-EDEADLK when CONFIG_DEBUG_WW_MUTEX_SLOWPATH is enabled?

drm_kunit_helper_enable_crtc_connector() only locks
drm->mode_config.connection_mutex and priv->crtc->mutex on ctx, leaving
priv->plane->mutex unlocked. When drm_atomic_commit_fill_with_defaults() is
subsequently called with the same ctx, it acquires priv->plane->mutex for t=
he
first time:

    drm_for_each_plane(plane, dev) {
            ...
            ret =3D drm_modeset_lock(&plane->mutex, commit->acquire_ctx);
            if (ret)
                    return ret;

Under CONFIG_DEBUG_WW_MUTEX_SLOWPATH, acquiring a new ww_mutex on an acquire
context that already holds locks injects -EDEADLK when the context's
deadlock_inject_countdown reaches zero. Without a retry loop calling
drm_atomic_commit_clear(state) and drm_modeset_backoff(&ctx), will
KUNIT_ASSERT_EQ(test, ret, 0) fail spuriously and abort with ctx.contended
and held locks still active?

> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-reset-=
state-flag-v6-0-f36d640b7e76@kernel.org?part=3D12
