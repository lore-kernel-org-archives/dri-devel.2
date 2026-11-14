Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAA606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQORYvsi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CAF10E285;
	Sat, 14 Nov 2026 18:22:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E8610E285
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:22:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DE63605D1;
 Sat, 14 Nov 2026 18:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2631F000C5;
 Sat, 14 Nov 2026 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680550;
 bh=eTH2jNA7Gf5G/Xt/ge1Ub9VQFg9L1rIQlphwreHr08E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iQORYvsiNvjwPyaf+our55/deK5SPybRPkVUgIpzfcWDG/UvMg8lhnB/mQA+lcxhW
 bLZpP8f52pf2UWUOsuS6G3bogen7PfjZz1XIRNU/62IGAqD7D2kuZZ3NezOAxYl9Mb
 nwZqpTQqaW5PAPhpKdrqe++T65R2NTO2I78tk/2LgJUIaDyqlJB3GGFLhpByDobSih
 rmBq56Fn0f4MgzpD22yh9cSc5Tmpng9PTbWU3/oyRrOCYnXRLHMNRGkPF9ev7rBqgk
 46fuQKIe7OXEZU2NNivLofMLFOd5zmjFBc1X00b/990it5QhNcMhHNRhyt4+jIcfmp
 t+ax6TKYAhcSQ==
Message-ID: <sashiko-outbox-214899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/25] drm/tests: hdmi: Verify SCDC resync on hotplug
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-22-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-22-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:22:30 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DIET_1,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tests: hdmi: missing scrambler enable in
  sync_scdc_test_init()
--

commit ad6b966d9b68c01d91b4a1ff13528d634475ed1e
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: hdmi: Verify SCDC resync on hotplug

This commit adds KUnit tests for SCDC scrambling resynchronization across
drm_connector_hdmi_sync_scdc(), drm_atomic_helper_connector_hdmi_hotplug(),
and drm_atomic_helper_connector_hdmi_force_ctx().

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 46654d8fa45cf..f17ccbf52bb18 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
[ ... ]
> @@ -315,6 +316,8 @@ static void test_encoder_atomic_enable(struct drm_enc=
oder *encoder,
>  		encoder_to_priv(encoder);
>  	int ret;
> =20
> +	priv->encoder_enable_count++;
> +
>  	ret =3D drm_atomic_helper_connector_hdmi_update_infoframes(&priv->conne=
ctor, state);
>  	if (ret)
>  		priv->hdmi_update_failures++;
> @@ -4789,12 +4792,321 @@ static struct kunit_suite drm_atomic_helper_conn=
ector_hdmi_scrambling_test_suite
[ ... ]
> +static struct drm_atomic_helper_connector_hdmi_priv *
> +sync_scdc_test_init(struct kunit *test,
> +		    const struct drm_connector_hdmi_funcs *hdmi_funcs,
> +		    u8 vic, struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> +	struct drm_display_mode *mode;
> +	int ret;
> +
> +	priv =3D drm_kunit_helper_connector_hdmi_init_with_scdc(test, hdmi_func=
s,
> +				test_edid_hdmi_4k_rgb_yuv420_dc_max_600mhz);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	drm_encoder_helper_add(&priv->encoder, &test_encoder_helper_funcs);
> +
> +	mode =3D drm_kunit_display_mode_from_cea_vic(test, &priv->drm, vic);
> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +
> +	drm_modeset_acquire_init(ctx, 0);
> +
> +retry_conn_enable:
> +	ret =3D drm_kunit_helper_enable_crtc_connector(test, &priv->drm,
> +						     priv->crtc,
> +						     &priv->connector,
> +						     mode, ctx);
> +	if (ret =3D=3D -EDEADLK) {
> +		ret =3D drm_modeset_backoff(ctx);
> +		if (!ret)
> +			goto retry_conn_enable;
> +	}
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	KUNIT_ASSERT_EQ(test, priv->encoder_enable_count, 1);
> +
> +	return priv;
> +}

[Severity: Medium]
Does sync_scdc_test_init() leave priv->connector.hdmi.scrambler_enabled as
false when enabling a mode that requires scrambling?

Enabling the CRTC sets priv->connector.state->hdmi.scrambler_needed during
atomic check and invokes test_encoder_atomic_enable(), which updates
infoframes but never calls drm_connector_hdmi_enable_scrambling().
drm_connector_hdmi_sync_scdc() checks scrambler_enabled before inspecting
SCDC state:

drivers/gpu/drm/display/drm_hdmi_helper.c:drm_connector_hdmi_sync_scdc() {
	...
	if (!drm_connector_hdmi_scrambler_supported(connector) ||
	    !READ_ONCE(hdmi->scrambler_enabled))
		return 0;
	...
}

Because scrambler_enabled remains false, drm_connector_hdmi_sync_scdc()
returns 0 immediately without reading SCDC_TMDS_CONFIG over DDC or resetting
the CRTC, causing the subtests that expect a CRTC reset or DDC error to fail
their KUnit assertions and the remaining subtests to pass without exercising
SCDC reads.  Calling drm_connector_hdmi_enable_scrambling() from
test_encoder_atomic_enable() (or in sync_scdc_test_init() after enabling the
CRTC) would populate scrambler_enabled as expected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D22
