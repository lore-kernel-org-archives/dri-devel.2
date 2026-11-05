Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84393606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUOSOoEf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E862410FBBA;
	Thu,  5 Nov 2026 21:01:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA0310FBBA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:01:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D939412E7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDEB1F0089F;
 Thu,  5 Nov 2026 21:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793912485;
 bh=rO0i3NrMgavWgxJVRFrSQxTD0FzXBWXSMueWRZQ+Zss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MUOSOoEfy335QyLhb+OA+lVyzrqw7OjqdgwtV6mfd9r4YgyegSKWHzik9Bhmr4ZI6
 f4SLRoVYDwFIcKJA5CLd65fGoZ4PVD0UbGaw3yaQ+PoQSmjSUFm1ijrDSXMvd3Zhby
 DIyT2JV9EEBl+4/cUX6udMhSOUZxKQT+SbY0ufzhkz91VnKrTIrDNOiF2cLhCe8AS/
 fpbPV27umhsecij1Je0e87mi8hadOJE37PdNuuCPlJOCNj5bRRJhn31bNMkeELFv8/
 vEHxFwe68PosKiT/pR3Y5VxXgxVIAX/jPsVYPOwhDXIc0azAG/qxEsUfdKB0Mc36yn
 oVRvVEIOkEgiQ==
Message-ID: <sashiko-outbox-200176@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 57/83] drm/tests: drm_hdmi_state_helper_test:
 Switch to drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-57-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-57-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:01:24 +0000
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
- [Medium] drm/tests: error pointer dereference on __connector_hdmi_init() =
failure
--

commit f0f9a8e1f22f0d1c095eb10619c56e34cb056f4b
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: drm_hdmi_state_helper_test: Switch to drm_mode_config_create_ini=
tial_state

This commit replaces the call to drm_mode_config_reset() in
__connector_hdmi_init() with drm_mode_config_create_initial_state() to
initialize the KMS state for the HDMI connector state helper KUnit tests.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 336bb644cb7c9..99a0fa479704d 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> @@ -297,7 +297,9 @@ __connector_hdmi_init(struct kunit *test,
>  	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
>  	drm_connector_attach_encoder(conn, enc);
> =20
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		return ERR_PTR(ret);

[Severity: Medium]
If drm_mode_config_create_initial_state() fails here in
__connector_hdmi_init(), won't returning ERR_PTR(ret) cause the callers to
dereference an error pointer?

All the other initialization checks in __connector_hdmi_init() abort the te=
st
immediately via KUNIT_ASSERT_*() macros rather than returning an error
pointer:

drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:__connector_hdmi_init() {
	...
	ret =3D drmm_connector_hdmi_ini2(drm, conn,
				       "Vendor", "Product",
				       &dummy_connector_funcs,
				       hdmi_funcs,
				       DRM_MODE_CONNECTOR_HDMIA,
				       NULL,
				       formats,
				       max_bpc);
	KUNIT_ASSERT_EQ(test, ret, 0);
	...
}

Because __connector_hdmi_init() previously never returned an ERR_PTR, the t=
est
cases calling drm_kunit_helper_connector_hdmi_init() and
drm_kunit_helper_connector_hdmi_init_with_edid_funcs() (such as
drm_test_check_broadcast_rgb_crtc_mode_changed()) only check for NULL before
dereferencing priv:

	priv =3D drm_kunit_helper_connector_hdmi_init(test,
						    BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
						    8);
	KUNIT_ASSERT_NOT_NULL(test, priv);

	drm =3D &priv->drm;
	crtc =3D priv->crtc;

Should __connector_hdmi_init() use KUNIT_ASSERT_EQ(test, ret, 0) instead of
returning ERR_PTR(ret)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D57
