Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697C606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2yK2usz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81A810E317;
	Thu,  5 Nov 2026 18:03:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4106910E317
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:03:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F211643E6A;
 Thu,  5 Nov 2026 18:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DE71F00A22;
 Thu,  5 Nov 2026 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793901814;
 bh=oznmppvWic9WbH6tW/nUXpKQRRUkc4+2r8Z0Y57f93U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l2yK2usz8Ph+QY4Ls0lCN0dwemR9kzSHLbnSv1Rt5egGEVWo6t2kV3ENrE1gaot0Q
 gPXoA4oRaPZfKkrm6RjARsH1EzRZXghAaL7uzgiyjh+t9TJCSMSLTaZo86EIYg1ujm
 MJn9J/7S8xlGQj5kgfTe+AI0Nl1TTVca/9c7vKSAWi+UE9BHyjrzIZg7PEgIv/gtGF
 LhPk7U71ZR1im4e9nilJhaMu93zHR4ocGRiNK5Az72E8PpNNwIbZBOAM0wLAAVuGsw
 JuodqorXsEaCb5O97mPSWBxnrh1RKQ51DaLp37KwiNaWO0L4ESbNM0IjWZ224uqy8y
 tyQ8ju9oO/jag==
Message-ID: <sashiko-outbox-199684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/27] drm/tests: hdmi: Add tests for
 vrr_display_{min,max} properties
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-27-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-27-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:03:34 +0000
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
- [Medium] drm/tests: WARN_ON() in VRR limit tests via drm_object_property_=
get_value()
--

commit 1a4f6d1ae4304b42e44e6989719d4059e858153e
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/tests: hdmi: Add tests for vrr_display_{min,max} properties

This commit attaches the vrr_display_min and vrr_display_max properties to
the KUnit HDMI state helper test connector and adds two tests verifying
drm_connector_hdmi_update_vrr_limits().

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 95a922e7f2515..3f94133b20b10 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c

[ ... ]

> @@ -3675,6 +3678,88 @@ static void drm_test_check_hdmi_vrr_flush_vsync(st=
ruct kunit *test)
>  			crtc_state->vrr_state.max_vtotal);
>  }
> =20
> +/*
> + * Check that on a VRR-capable sink, the HDMI VRR limits helper sets the
> + * display_min/display_max connector properties to the right values.
> + */
> +static void drm_test_check_hdmi_vrr_display_limits(struct kunit *test)
> +{
> +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> +	struct drm_display_mode *preferred;
> +	struct drm_connector *conn;
> +	u64 disp_min, disp_max;
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
> +
> +	preferred =3D find_preferred_mode(conn);
> +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> +
> +	ret =3D drm_connector_hdmi_update_vrr_limits(conn, preferred);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret =3D drm_object_property_get_value(&conn->base, conn->vrr_display_mi=
n_property,
> +					    &disp_min);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret =3D drm_object_property_get_value(&conn->base, conn->vrr_display_ma=
x_property,
> +					    &disp_max);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, disp_min, 30);
> +	KUNIT_EXPECT_EQ(test, disp_max, 120);
> +}
> +
> +/*
> + * Check that on a non-VRR-capable sink, the HDMI VRR limits helper sets=
 the
> + * display_min/display_max connector properties to 0.
> + */
> +static void drm_test_check_hdmi_vrr_display_limits_zero(struct kunit *te=
st)
> +{
> +	struct drm_atomic_helper_connector_hdmi_priv *priv;
> +	struct drm_display_mode *preferred;
> +	struct drm_connector *conn;
> +	u64 disp_min, disp_max;
> +	int ret;
> +
> +	priv =3D drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
> +				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
> +				8,
> +				&dummy_connector_hdmi_funcs,
> +				test_edid_hdmi_4k_rgb_yuv420_dc_max_340mhz);
> +	KUNIT_ASSERT_NOT_NULL(test, priv);
> +
> +	conn =3D &priv->connector;
> +	KUNIT_ASSERT_TRUE(test, conn->display_info.is_hdmi);
> +	KUNIT_ASSERT_FALSE(test, conn->display_info.hdmi.vrr_cap.supported);
> +
> +	preferred =3D find_preferred_mode(conn);
> +	KUNIT_ASSERT_NOT_NULL(test, preferred);
> +
> +	ret =3D drm_connector_hdmi_update_vrr_limits(conn, preferred);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret =3D drm_object_property_get_value(&conn->base, conn->vrr_display_mi=
n_property,
> +					    &disp_min);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret =3D drm_object_property_get_value(&conn->base, conn->vrr_display_ma=
x_property,
> +					    &disp_max);

[Severity: Medium]
Will calling drm_object_property_get_value() in
drm_test_check_hdmi_vrr_display_limits() and
drm_test_check_hdmi_vrr_display_limits_zero() trigger a WARN_ON() when
running these tests?

Both tests initialize the test DRM device through
drm_kunit_helper_connector_hdmi_init_with_edid_funcs() ->
__connector_hdmi_init(), which allocates the device with DRIVER_ATOMIC:

drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:__connector_hdmi_init() {
	...
	priv =3D drm_kunit_helper_alloc_drm_device(test, dev,
						 struct drm_atomic_helper_connector_hdmi_priv, drm,
						 DRIVER_MODESET | DRIVER_ATOMIC);
	...
}

Unlike drm_object_property_set_value(), drm_object_property_get_value() does
not exempt DRM_MODE_PROP_IMMUTABLE properties and unconditionally warns on
atomic devices:

drivers/gpu/drm/drm_mode_object.c:
int drm_object_property_get_value(struct drm_mode_object *obj,
				  struct drm_property *property, uint64_t *val)
{
	WARN_ON(drm_drv_uses_atomic_modeset(property->dev));

	return __drm_object_property_get_value(obj, property, val);
}

Since vrr_display_min_property and vrr_display_max_property are created with
DRM_MODE_PROP_IMMUTABLE, should both tests use
drm_object_immutable_property_get_value() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D27
