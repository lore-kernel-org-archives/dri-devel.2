Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520F4606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HY3RwoEk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8F01127F1;
	Thu, 19 Nov 2026 23:53:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D58FB10E8C4;
 Thu, 19 Nov 2026 23:52:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4A1960D15;
 Thu, 19 Nov 2026 23:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470F01F000C6;
 Thu, 19 Nov 2026 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795132377;
 bh=yPlEoirQwo+sW4T3/89p+lafxASWsrn1vq6yh2S649E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HY3RwoEkPqLTILcVt8A1mGwPBfRTuyoqG0gbtDSmQGhXPByfiBbFC87YyMGnQqhup
 JAEutZ+uuy1k3FFET97vn4gBM/A7/jSwSn7aZoiIeYdwlT43PfQGSVMtAQwpt9gKId
 WqsSfEZGmZJztnNaIYfOM8M/quCpYP2lJpcVjGuuRVbmWAHLdawyud/nqbAEl2AJv+
 Bc1YSbNRpufGIMjhzsjhBTiN8Ol/U8jspbot3aaKES+2T0XEw3T/UJxFtV8NeyxQFn
 ojJoPuHHDxF8e9dsMoFsolpWzapqLwLP0j+EzTkYCRDFSC//Tya+kTQaw5LZ74gZ3D
 eZRsP49AjdbEw==
Message-ID: <sashiko-outbox-224220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/12] drm/amd: add luminance property support
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261119-superm1-backlight-property-v12-4-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-4-89d5217d3618@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 23:52:56 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amd/display: brightness race in
  amdgpu_dm_atomic_commit_tail()
- [Low] drm/amd/display: duplicate drmm_mode_config_init() in backlight
  KUnit tests
--

commit 846a4ea0302b706193f324593664f491fbb89bfe
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd: add luminance property support

This commit exposes the DRM LUMINANCE connector property for internal
panels when CONFIG_DRM_LUMINANCE is enabled and updates the backlight
KUnit fixtures.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 56fca4e22df8d..8b5dde608266a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -5188,6 +5189,13 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_commit *state)
>  		amdgpu_dm_commit_streams(state, dc_state);
>  	}
> =20
> +	/*
> +	 * Apply connector luminance now that the streams are committed. Display
> +	 * Core resets the panel brightness when it enables a stream, and the
> +	 * helper reprograms LUMINANCE panels after a modeset.
> +	 */
> +	drm_atomic_helper_commit_luminance_enables(state);
> +
>  	amdgpu_dm_update_hdcp(state);
> =20
>  	/* Handle connector state changes */
> @@ -5415,8 +5423,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_commit *state)
> =20
>  	/* restore the backlight level */
>  	for (i =3D 0; i < dm->num_of_edps; i++) {
> -		if (dm->backlight_dev[i] &&
> -		    (dm->actual_brightness[i] !=3D dm->brightness[i]))
> +		if ((dm->backlight_dev[i] || dm->luminance[i]) &&
> +		    dm->actual_brightness[i] !=3D dm->brightness[i])
>  			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>  	}
> =20

[Severity: Medium]
Can the unlocked retry loop at the end of amdgpu_dm_atomic_commit_tail()
race with a concurrent luminance commit and overwrite a newer brightness
level with a stale one?

Fast atomic updates on disjoint CRTCs run amdgpu_dm_atomic_commit_tail()
concurrently without taking the global dm.atomic_obj lock.  Inside
amdgpu_dm_backlight_set_level(), dm->brightness[bl_idx] is updated before
acquiring dm->dc_lock, while dm->actual_brightness[bl_idx] is updated only
after releasing dm->dc_lock:

CPU0 (eDP panel commit)           CPU1 (other CRTC commit)
amdgpu_dm_atomic_commit_tail()
  ...
  amdgpu_dm_backlight_set_level(..., B1)
    dm->brightness[0] =3D B1;
    mutex_lock(&dm->dc_lock);
                                  amdgpu_dm_atomic_commit_tail()
                                    /* actual_brightness[0] !=3D B1 */
                                    val =3D dm->brightness[0]; /* B1 */
    ...
    mutex_unlock(&dm->dc_lock);
    dm->actual_brightness[0] =3D B1;

/* next luminance commit B2 on CPU0 */
amdgpu_dm_atomic_commit_tail()
  ...
  amdgpu_dm_backlight_set_level(..., B2)
    dm->brightness[0] =3D B2;
    ...
    dm->actual_brightness[0] =3D B2;
                                    amdgpu_dm_backlight_set_level(..., B1)
                                      dm->brightness[0] =3D B1;
                                        <-- overwrites B2 with stale B1

This leaves the panel hardware brightness and dm->brightness[0] out of
sync with connector->state->luminance.  In addition, when CPU1 runs
amdgpu_dm_backlight_set_level() after CPU0 has already finished
amdgpu_dm_commit_planes(), it re-asserts psr_event_hw_programming and
replay_event_hw_programming with no subsequent plane flip to clear them,
keeping PSR and Replay disabled until a later flip.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backli=
ght_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c
> index 8fc1c2f997688..c33c121a19b25 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> @@ -37,16 +37,39 @@ static const struct drm_connector_funcs dm_backlight_=
test_connector_funcs =3D {
[ ... ]
>  static void setup_test_connector(struct kunit *test,
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
[ ... ]
> @@ -483,12 +506,17 @@ static void dm_test_register_backlight_device_succe=
ss(struct kunit *test)
>  	struct dc_link *link =3D dm_kunit_alloc_link(test);
>  	struct drm_minor *primary;
>  	unsigned int max;
> +	int ret;
> +
> +	ret =3D drmm_mode_config_init(&adev->ddev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Low]
Does calling drmm_mode_config_init() in setup_test_connector() and
dm_test_register_backlight_device_success() reinitialize mode_config a
second time and leak the standard DRM properties?

dm_kunit_alloc_adev() allocates the DRM device through
__drm_kunit_helper_alloc_drm_device() ->
__drm_kunit_helper_alloc_drm_device_with_driver(), which already calls
drmm_mode_config_init() when DRIVER_MODESET is set.  Calling
drmm_mode_config_init() again overwrites mode_config.property_list and
mode_config.object_idr in place, leaking the standard properties allocated
by the first call and registering a second drm_mode_config_init_release
cleanup action.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-superm1-ba=
cklight-property-v12-0-89d5217d3618@amd.com?part=3D4
