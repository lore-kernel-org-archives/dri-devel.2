Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CEB606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjK1HEHF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0AA10E95C;
	Thu,  5 Nov 2026 17:57:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779EB10E95C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:57:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1ECA841FA6;
 Thu,  5 Nov 2026 17:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0471F000C1;
 Thu,  5 Nov 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793901450;
 bh=CCsaeqQtsCv2KXduGFOqCi4LO7Oi3QPtkaGy/oYmsoQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gjK1HEHF7vLqJXABfVmWV4ytKzptuFIc4myenJGwMCibyENdhhRTxhX9YjDTHnONV
 1c1epdnCUj/yQBiOhT5aizB7DmqbiATrhR6v/KC6ulhzDyH463NjuEr3UIsd6X/5P0
 5p7q/EGvDdcsvWxy0bgKZFMcHR8STkK3EqCoe/RMgbzat94tdyIkwcrgerfOpn0usd
 BH+iWuP5lYatr5meEn2CZP4IxWaWsMmCm9J2/Il6bOZK7mjv6Uyu1VIlS1qU2ZiWjX
 O37fdbiTAFzNQ753t+j91daxCEnqwUBzQTtq9TG8eYl/ZrTqyIAdmn/QTI+6YKB17U
 muycHwtcMLt1g==
Message-ID: <sashiko-outbox-199674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/27] drm/tests: hdmi: Add Fixed/Constrained rate
 VRR tests
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-23-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-23-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:57:29 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/tests: double ctx cleanup in drm_test_check_hdmi_vrr_target_=
rate_fail()
--

commit 75a8664a7bf8d42311eb56958c313fafe87f6d41
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: hdmi: Add Fixed/Constrained rate VRR tests

This commit adds KUnit tests for HDMI VRR fixed and constrained target rate=
s,
including CinemaVRR and invalid target rate checks.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 09ce304210892..7da26b3713d8c 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -3673,10 +3673,396 @@ static void drm_test_check_hdmi_vrr_flush_vsync(=
struct kunit *test)

[ ... ]

> +static void drm_test_check_hdmi_vrr_target_rate_fail(struct kunit *test)
> +{
> +	const struct vrr_target_error_params *params =3D test->param_value;
> +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_display_mode *preferred;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_atomic_commit *state;
> +	struct drm_connector *conn;
> +	int ret;
> +
> +	priv =3D drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
> +				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
> +				8,
> +				&dummy_connector_hdmi_funcs,
> +				test_edid_hdmi_vrr);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	conn =3D &priv->connector;
> +	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
> +	KUNIT_ASSERT_TRUE(test, conn->display_info.hdmi.vrr_cap.supported);
> +	KUNIT_ASSERT_LT(test, 24, conn->display_info.hdmi.vrr_cap.vrr_min);
> +
> +	preferred =3D find_preferred_mode(conn);
> +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> +
> +	guard(modeset_lock)(&ctx);
> +
> +	allocate_state_for_vrr_test(test, priv, &ctx, preferred, &state);
> +
> +retry:
> +	prepare_state_for_vrr_test(test, priv, &ctx, state, &crtc_state);
> +
> +	/*
> +	 * Allow individual test parameters to play with the CinemaVRR flag
> +	 * without needing to bring their own modified EDID.
> +	 */
> +	conn->display_info.hdmi.vrr_cap.cinema_vrr =3D params->cinema_vrr_overr=
ide;
> +
> +	crtc_state->vrr_enabled =3D true;
> +	crtc_state->vrr_state.vrr_min_n =3D params->vrr_min_n;
> +	crtc_state->vrr_state.vrr_min_d =3D params->vrr_min_d;
> +	crtc_state->vrr_state.vrr_max_n =3D params->vrr_max_n;
> +	crtc_state->vrr_state.vrr_max_d =3D params->vrr_max_d;
> +
> +	ret =3D drm_atomic_commit(state);
> +	if (ret =3D=3D -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret =3D drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry;
> +	}
> +	KUNIT_EXPECT_LT(test, ret, 0);
> +
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +}

[Severity: Medium]
Since guard(modeset_lock)(&ctx) is used earlier in
drm_test_check_hdmi_vrr_target_rate_fail(), drop_fini_modeset(&ctx) will
automatically run when the function exits:

static void drop_fini_modeset(struct drm_modeset_acquire_ctx *ctx)
{
	drm_modeset_drop_locks(ctx);
	drm_modeset_acquire_fini(ctx);
}

DEFINE_GUARD(modeset_lock, struct drm_modeset_acquire_ctx *,
	     drm_modeset_acquire_init(_T, 0), drop_fini_modeset(_T));

Won't calling drm_modeset_drop_locks(&ctx) and drm_modeset_acquire_fini(&ct=
x)
explicitly at the end of the function cause ctx to be finalized twice via
ww_acquire_fini(), triggering lockdep or DEBUG_WW_MUTEXES warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D23
