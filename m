Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F34606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PL+cwV2M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2001B10F0C4;
	Mon,  2 Nov 2026 18:00:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C973810F0A5;
 Mon,  2 Nov 2026 18:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8209F411BA;
 Mon,  2 Nov 2026 18:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA731F00A16;
 Mon,  2 Nov 2026 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793642430;
 bh=xfQXiR0waxNaVgKjR2iU+kFlkn7FoWk8VuMm344wi/g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PL+cwV2MxNmCokocZk8VeKqEYcDzYO3Rn1udgStGWcnmT8rArEneCRwOW8mfKEswv
 Nr1T+PrHET1byOf3dU+acZt1OUTmwhN+It3kSuUlvoI0vI56CbJEWZN4WwDDRQ5pBV
 KRI4vJzl1zPuhP7+JyoXuKnzhcotn2wzlQXhVavBXWOpdr3NIBFszAXI423jm3auHs
 //GSSwkJnV3/4/vJxDFrP4KoBGO954aP/kq0dlpkiFRyJs/3zaS2UFKD/otdnZa6UK
 GoiccULpRgCxKp0vMTCJqAOyj6RX/3seqUeMlB/Hh7jb1chkXY8usV/RjXX3k8GDBy
 uLAEGZSSy1o6g==
Message-ID: <sashiko-outbox-193892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/15] drm/amd/display: update KUnit luminance fixtures
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-5-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-5-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:00:29 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/amd/display: wrong connector_type IDA freed in setup_test_co=
nnector() user
- [Medium] drm/amd/display: link failure in backlight KUnit test when DRM_L=
UMINANCE=3Dy
--

commit 66d823079de9e4318719fbb2464a13997a1ae155
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/amd/display: update KUnit luminance fixtures

This commit updates the backlight KUnit test fixtures to initialize DRM mode
configuration, connector state, and the display manager lock so tests work
when the atomic LUMINANCE property is enabled.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backli=
ght_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c
> index b21850788f36f..8883010e8af9c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> @@ -41,12 +41,21 @@ static void setup_test_connector(struct kunit *test,
>  				 struct dm_backlight_connector_fixture *fixture,
>  				 int bl_idx, enum signal_type signal)
>  {
> -	fixture->adev =3D kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNE=
L);
> -	fixture->aconnector =3D kunit_kzalloc(test, sizeof(*fixture->aconnector=
), GFP_KERNEL);
> +	int ret;
> +
> +	fixture->adev =3D dm_kunit_alloc_adev(test);
> +	ret =3D drmm_mode_config_init(&fixture->adev->ddev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fixture->aconnector =3D dm_kunit_alloc_connector(test, fixture->adev, N=
ULL);
>  	fixture->link =3D kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNE=
L);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
> +	ret =3D drmm_connector_init(&fixture->adev->ddev,
> +				  &fixture->aconnector->base,
> +				  &dm_backlight_test_connector_funcs,
> +				  DRM_MODE_CONNECTOR_eDP, NULL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	drm_atomic_helper_connector_reset(&fixture->aconnector->base);

[Severity: Medium]
Does hardcoding DRM_MODE_CONNECTOR_eDP in setup_test_connector() corrupt or
leak the connector_type_id IDA when dm_test_should_create_sysfs_non_edp() r=
uns?

drmm_connector_init() -> drm_connector_init_and_add() ->
drm_connector_init_only() allocates connector->connector_type_id from
drm_connector_enum_list[DRM_MODE_CONNECTOR_eDP].ida and registers
drm_connector_cleanup_action() for managed teardown.

However, dm_test_should_create_sysfs_non_edp() mutates connector_type after
calling setup_test_connector():

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c:dm_t=
est_should_create_sysfs_non_edp() {
	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_HDMI_TYPE_A);
	fixture.aconnector->base.connector_type =3D DRM_MODE_CONNECTOR_HDMIA;
	...
}

When the test finishes and drm_connector_cleanup() runs:

drivers/gpu/drm/drm_connector.c:drm_connector_cleanup() {
	...
	ida_free(&drm_connector_enum_list[connector->connector_type].ida,
		 connector->connector_type_id);
	...
}

it frees connector_type_id back to the DRM_MODE_CONNECTOR_HDMIA IDA instead=
 of
DRM_MODE_CONNECTOR_eDP, triggering a warning in ida_free() (or freeing an
active HDMI-A ID) while leaking the eDP connector_type_id.

> @@ -483,12 +492,17 @@ static void dm_test_register_backlight_device_succe=
ss(struct kunit *test)
>  	struct dc_link *link =3D dm_kunit_alloc_link(test);
>  	struct drm_minor *primary;
>  	unsigned int max;
> +	int ret;
> +
> +	ret =3D drmm_mode_config_init(&adev->ddev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> =20
>  	setup_test_link_service(test, link);
>  	link->dc->link_srv->edp_get_backlight_level =3D dm_test_get_backlight_l=
evel_error;
>  	primary =3D kunit_kzalloc(test, sizeof(*primary), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, primary);
>  	adev->ddev.primary =3D primary;
> +	adev->dm.ddev =3D &adev->ddev;
>  	adev->dm.backlight_link[0] =3D link;

[Severity: Medium]
Can this test suite link when CONFIG_DRM_LUMINANCE=3Dy and
CONFIG_BACKLIGHT_CLASS_DEVICE is disabled?

With commit de26f6665aed ("drm/amd: add luminance property support"),
DRM_AMDGPU in drivers/gpu/drm/amd/amdgpu/Kconfig only selects
BACKLIGHT_CLASS_DEVICE when !DRM_LUMINANCE:

	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE

Neither DRM_AMD_DC_KUNIT_TEST in drivers/gpu/drm/amd/display/Kconfig nor
drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig enables
CONFIG_BACKLIGHT_CLASS_DEVICE.

However, dm_test_register_backlight_device_success() and
dm_test_unregister_backlight_device() in amdgpu_dm_backlight_test.c, as well
as amdgpu_dm_register_backlight_device() in amdgpu_dm_backlight.c, still
unconditionally call backlight_device_register() and
backlight_device_unregister():

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c:dm_t=
est_unregister_backlight_device() {
	backlight_device_unregister(data);
}

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c:amdgpu_dm_regis=
ter_backlight_device() {
	...
	dm->backlight_dev[aconnector->bl_idx] =3D
		backlight_device_register(bl_name, aconnector->base.kdev, dm,
					  &amdgpu_dm_backlight_ops, &props);
	...
}

Because include/linux/backlight.h does not provide inline stubs for
backlight_device_register() or backlight_device_unregister() when
CONFIG_BACKLIGHT_CLASS_DEVICE is disabled, won't building the KUnit tests (=
or
amdgpu) with CONFIG_DRM_LUMINANCE=3Dy and CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn=
 fail
at link time with undefined references to those symbols?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D5
