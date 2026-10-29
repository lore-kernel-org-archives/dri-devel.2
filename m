Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1837A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Irb/vML0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B338112035;
	Thu, 29 Oct 2026 08:04:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A0210E0E7
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:03:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C149601E4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277E51F01825;
 Thu, 29 Oct 2026 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260987;
 bh=G0sl9IHCRLdPJGG5Y7Edyboh+cqko7m++FjjzWH+BUQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Irb/vML0db5XN73zbXIUM50z+USnRF5UUqzrvH74yYbzdffWide/mL72xTmaSDqdX
 +NrAqxFKcIFRSnA+T6KG7hrKf/Wf+ouas3H7KUePhLPg8AE+y5S9mANRIaVal4qOQB
 IfC/MNn0aKwb6OzLZ+lf12EqrZnsWJb7XHCYkXbbvUUgEYOvKT6GOsSL59V6GP60qJ
 TFrCzoZLj10pJgyQMwlWK5zRXhypA9oCFg61LfgtvgNXLWMLZ/IqcZk7RIdddDhefs
 b6fFHMHCEIuz/pLBhZcWS3HRSOWlSGGA9jMwAa1kCNr32Ozb/ZwayoI4TKqoJgV3sO
 BTdM+UFN5HLUA==
Message-ID: <sashiko-outbox-188936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 25/34] drm/tests: Add tests for the atomic state readout
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-25-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-25-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:03:06 +0000
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
- [Medium] drm/tests: state leaks in drm_atomic_sro_compare KUnit tests
- [Low] drm/tests: call to unexported drm_atomic_sro_state_get_device()
--

commit f4486adadf6731a0cd596ded17489fc32e1af61a
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: Add tests for the atomic state readout

This commit adds a KUnit test suite for the DRM atomic state readout
infrastructure, covering the drm_atomic_sro_state container API, state
readout helpers, state comparison helpers, and initial state creation.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c b/driv=
ers/gpu/drm/tests/drm_atomic_state_readout_test.c
> new file mode 100644
> index 0000000000000..ada512f7b32bb
> --- /dev/null
> +++ b/drivers/gpu/drm/tests/drm_atomic_state_readout_test.c

[ ... ]

> +static void drm_test_sro_state_alloc_free(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_atomic_sro_state *sro_state;
> +
> +	sro_state =3D drm_atomic_sro_state_alloc(&priv->drm);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sro_state);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, drm_atomic_sro_state_get_device(sro_state),
> +			    &priv->drm);

[Severity: Low]
Will building with CONFIG_DRM_KUNIT_TEST=3Dm fail at modpost here?

In drivers/gpu/drm/drm_atomic_state_readout.c,
drm_atomic_sro_state_get_device() is defined without EXPORT_SYMBOL(),
unlike the other drm_atomic_sro_* functions:

drivers/gpu/drm/drm_atomic_state_readout.c:
struct drm_device *
drm_atomic_sro_state_get_device(struct drm_atomic_sro_state *state)
{
	return state->dev;
}

When drm_atomic_state_readout_test is built as a module under
CONFIG_DRM_KUNIT_TEST=3Dm, calling drm_atomic_sro_state_get_device() from
drm_test_sro_state_alloc_free() results in an undefined symbol error.

> +
> +	drm_atomic_sro_state_free(sro_state);
> +}

[ ... ]

> +static void drm_test_sro_compare_plane_identical(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_plane_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	state1 =3D priv->plane->funcs->atomic_create_state(priv->plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D priv->plane->funcs->atomic_create_state(priv->plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	identical =3D drm_atomic_helper_plane_compare_state(priv->plane, p,
> +							  state1, state2);
> +	KUNIT_EXPECT_TRUE(test, identical);
> +}
> +
> +/*
> + * Test that plane states differing by a single field compare as
> + * different, and that the mismatching field is reported through the
> + * printer.
> + */
> +static void drm_test_sro_compare_plane_mismatch(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_plane_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	state1 =3D priv->plane->funcs->atomic_create_state(priv->plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D priv->plane->funcs->atomic_create_state(priv->plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	state2->crtc =3D priv->crtc;
> +
> +	identical =3D drm_atomic_helper_plane_compare_state(priv->plane, p,
> +							  state1, state2);
> +	KUNIT_EXPECT_FALSE(test, identical);
> +}
> +
> +/*
> + * Test that two identical active CRTC states compare as equal.
> + */
> +static void drm_test_sro_compare_crtc_identical(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_crtc_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	state1 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	state1->enable =3D true;
> +	state1->active =3D true;
> +	state2->enable =3D true;
> +	state2->active =3D true;
> +
> +	identical =3D drm_atomic_helper_crtc_compare_state(priv->crtc, p,
> +							 state1, state2);
> +	KUNIT_EXPECT_TRUE(test, identical);
> +}
> +
> +/*
> + * Test that two inactive CRTCs compare as equal even though their
> + * modes differ: the modes are meaningless while inactive and must not
> + * be compared.
> + */
> +static void drm_test_sro_compare_crtc_inactive(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_display_mode *mode1, *mode2;
> +	struct drm_crtc_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	state1 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	/* Two different but valid modes */
> +	mode1 =3D drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 16);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode1);
> +
> +	mode2 =3D drm_kunit_display_mode_from_cea_vic(test, &priv->drm, 4);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mode2);
> +
> +	/*
> +	 * Both CRTCs are inactive: the modes are meaningless and must
> +	 * not be compared.
> +	 */
> +	drm_mode_copy(&state1->mode, mode1);
> +	drm_mode_copy(&state2->mode, mode2);
> +
> +	identical =3D drm_atomic_helper_crtc_compare_state(priv->crtc, p,
> +							 state1, state2);
> +	KUNIT_EXPECT_TRUE(test, identical);
> +}
> +
> +/*
> + * Test that an active CRTC and an inactive one compare as different.
> + */
> +static void drm_test_sro_compare_crtc_active_mismatch(struct kunit *test)
> +{
> +	struct sro_test_priv *priv =3D mock_device_with_sro_create(test);
> +	struct drm_crtc_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	state1 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D priv->crtc->funcs->atomic_create_state(priv->crtc);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	state1->enable =3D true;
> +	state1->active =3D true;
> +
> +	identical =3D drm_atomic_helper_crtc_compare_state(priv->crtc, p,
> +							 state1, state2);
> +	KUNIT_EXPECT_FALSE(test, identical);
> +}
> +
> +/*
> + * Test that two identical connector states compare as equal.
> + */
> +static void drm_test_sro_compare_connector_identical(struct kunit *test)
> +{
> +	struct drm_connector *connector;
> +	struct sro_test_priv *priv;
> +	struct drm_connector_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	priv =3D mock_device_with_sro_create(test);
> +	connector =3D &priv->connector;
> +
> +	state1 =3D connector->funcs->atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D connector->funcs->atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	identical =3D
> +		drm_atomic_helper_connector_compare_state(connector, p,
> +							  state1, state2);
> +	KUNIT_EXPECT_TRUE(test, identical);
> +}
> +
> +/*
> + * Test that connector states whose CRTCs differ compare as different.
> + */
> +static void drm_test_sro_compare_connector_mismatch(struct kunit *test)
> +{
> +	struct drm_connector *connector;
> +	struct sro_test_priv *priv;
> +	struct drm_connector_state *state1, *state2;
> +	struct drm_printer *p;
> +	bool identical;
> +
> +	p =3D drm_kunit_helper_printer(test, LOGLEVEL_ERR);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +
> +	priv =3D mock_device_with_sro_create(test);
> +	connector =3D &priv->connector;
> +
> +	state1 =3D connector->funcs->atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state1);
> +
> +	state2 =3D connector->funcs->atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state2);
> +
> +	state2->crtc =3D priv->crtc;
> +
> +	identical =3D
> +		drm_atomic_helper_connector_compare_state(connector, p,
> +							  state1, state2);
> +	KUNIT_EXPECT_FALSE(test, identical);
> +}

[Severity: Medium]
Do these seven plane, CRTC, and connector comparison tests leak state1 and
state2?

In drm_test_sro_compare_plane_identical(),
drm_test_sro_compare_plane_mismatch(),
drm_test_sro_compare_crtc_identical(),
drm_test_sro_compare_crtc_inactive(),
drm_test_sro_compare_crtc_active_mismatch(),
drm_test_sro_compare_connector_identical(), and
drm_test_sro_compare_connector_mismatch(), state1 and state2 are allocated
via ->atomic_create_state() (using unmanaged kzalloc_obj()) and are not
installed on the objects or in a drm_atomic_sro_state container. Unlike
drm_test_sro_compare_bridge_identical() and
drm_test_sro_compare_bridge_mismatch() below, these tests return without
calling ->atomic_destroy_state() on state1 and state2.

Also, in drm_test_sro_compare_connector_mismatch(), state2->crtc is set
to priv->crtc without taking a connector reference via
drm_connector_get(connector). When destroying state2 via
connector->funcs->atomic_destroy_state(connector, state2),
__drm_atomic_helper_connector_destroy_state() will call
drm_connector_put(state->connector) because state2->crtc is non-NULL, so
either drm_connector_get(connector) should be called when setting
state2->crtc or state2->crtc should be cleared before destroying state2.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D25
