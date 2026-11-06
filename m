Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501E606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HJM5fR/s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2E0112DAE;
	Fri,  6 Nov 2026 13:44:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B464710E107
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6706F435CC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D481F008A4;
 Fri,  6 Nov 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793972656;
 bh=kbV98MR3subs+zpPDryV4tAuJJ93EP8V5zXnZXDFgWU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HJM5fR/s+J+WYxhcVuQQ3KnqdpFwuZVcp/RzgSuWoaFp8P8AYxwjXnVSANrZonwHN
 ctYewpmVpXaU0Csxtjr/Pws/CJTpgOFRDSJC6BCn6c0f+Hf1qolUfYC3FHBr1emiNQ
 +2JESGvxUSU4FmQTaPpAjC+KvDL/J4Mn3exAGURcLGqfFoRuX/YaA7r74w5NNCfzk3
 dZc+PAPifPX+aEjEJvSEgk48CWzP9+NS+yvRNKnScuKgntKHLkhegWlQAiPz3hCP48
 NNbFYS73ci8f3mYE9oyZAz07sKhIrV0LRSyC7ZlWow3NpKJ2dlcthlX0ybYMahpKVk
 eOh8/UQ0HHsXg==
Message-ID: <sashiko-outbox-201489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 28/39] drm/tests: Add tests for the atomic state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-28-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-28-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:44:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/tests: missing -EDEADLK backoff in atomic readout KUnit
  tests
- [Low] drm/tests: unchecked init calls in mock_device_create()
--

commit 012e80f1472ac3f4ff4d9e75c5b23df0a05d93bd
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: Add tests for the atomic state readout

This commit adds KUnit test suites for the DRM atomic state readout
infrastructure, covering state containers, readout and state comparison
helpers, readout modes, and initial state creation.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c b/driv=
ers/gpu/drm/tests/drm_atomic_state_readout_test.c
> new file mode 100644
> index 0000000000000..f2bc6d52c5b22
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c

[ ... ]

> +static struct sro_test_priv *
> +mock_device_create(struct kunit *test,
> +		   const struct drm_mode_config_funcs *mode_config_funcs,
> +		   const struct drm_mode_config_helper_funcs *helper_funcs,
> +		   const struct drm_plane_funcs *plane_funcs,
> +		   const struct drm_crtc_funcs *crtc_funcs,
> +		   const struct drm_connector_funcs *connector_funcs)
> +{

[ ... ]

> +	drm_atomic_private_obj_init(drm, &priv->private_obj,
> +				    "test private obj",
> +				    &mock_private_obj_with_sro_funcs);
> +	kunit_add_action_or_reset(test, mock_private_obj_fini,
> +				  &priv->private_obj);
> +
> +	return priv;
> +}

[Severity: Low]
Should mock_device_create() assert the return values of
drm_atomic_private_obj_init() and kunit_add_action_or_reset() with
KUNIT_ASSERT_EQ(test, ret, 0)?  If either fails, priv->private_obj is left
off drm->mode_config.privobj_list (or torn down with a dangling state
pointer), so drm_atomic_sro_state_alloc() allocates state->private_objs as
ZERO_SIZE_PTR and drm_atomic_sro_set_private_obj_state() dereferences it.

[ ... ]

> +static void drm_test_sro_readout_no_modeset(struct kunit *test)
> +{

[ ... ]

> +	/* A commit with a different configuration needs a modeset. */
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +retry:
> +	commit =3D drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
> +
> +	crtc_state =3D drm_atomic_get_crtc_state(commit, priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> +
> +	mode =3D drm_kunit_display_mode_from_cea_vic(test, &priv->drm,
> +						   SRO_TEST_OTHER_MODE_VIC);
> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +
> +	ret =3D drm_atomic_set_mode_for_crtc(crtc_state, mode);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	commit->allow_modeset =3D true;
> +
> +	ret =3D drm_atomic_check_only(commit);
> +	if (ret =3D=3D -EDEADLK)
> +		goto backoff;
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_TRUE(test, crtc_state->mode_changed);
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +
> +	return;
> +
> +backoff:
> +	drm_atomic_commit_clear(commit);
> +	drm_modeset_backoff(&ctx);
> +	goto retry;
> +}
> +
> +/*
> + * Test that blanking a pipeline isn't reported as a mismatch. A DPMS
> + * off commit only clears drm_crtc_state.active and leaves the
> + * connector bound to its CRTC, while the hardware readout of a
> + * disabled pipeline reports an unbound connector: the two states
> + * differ, but there is nothing to compare for a pipeline that doesn't
> + * drive a picture anymore.
> + */
> +static void drm_test_sro_readout_and_compare_blanked(struct kunit *test)
> +{
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_connector_state *conn_state;
> +	struct drm_atomic_commit *commit;
> +	struct sro_test_priv *priv;
> +	struct drm_crtc_state *crtc_state;
> +	bool identical;
> +	int ret;
> +
> +	priv =3D mock_device_with_sro_create(test);
> +
> +	/* Install the mock hardware state, with the pipeline enabled */
> +	ret =3D drm_atomic_helper_sro_readout_state(&priv->drm);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +	commit =3D drm_kunit_helper_atomic_state_alloc(test, &priv->drm, &ctx);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, commit);
> +
> +	crtc_state =3D drm_atomic_get_crtc_state(commit, priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
> +
> +	conn_state =3D drm_atomic_get_connector_state(commit, &priv->connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);

[Severity: Medium]
Can drm_atomic_get_connector_state() return ERR_PTR(-EDEADLK) here when
CONFIG_DEBUG_WW_MUTEX_SLOWPATH is enabled?

drm_atomic_get_crtc_state() acquires priv->crtc->mutex as the first lock in
ctx, and drm_atomic_get_connector_state() then acquires connection_mutex as
the second lock, where ww_mutex_deadlock_injection() can inject -EDEADLK.
Without a backoff retry loop, KUNIT_ASSERT_NOT_ERR_OR_NULL(test,
conn_state) aborts the test before drm_modeset_drop_locks() and
drm_modeset_acquire_fini() run, leaving priv->crtc->mutex locked during
device teardown.

In drm_test_sro_readout_no_modeset() above, after drm_modeset_backoff(&ctx)
locks the contended lock, drm_atomic_get_crtc_state() becomes the second
lock acquisition in ctx and can likewise return ERR_PTR(-EDEADLK), and the
retry label also reallocates commit and mode on each backoff iteration even
though backoff clears commit with drm_atomic_commit_clear().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D28
