Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF7606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DQpJjgqJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8CF10F91E;
	Tue,  3 Nov 2026 23:13:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C4110E43E;
 Tue,  3 Nov 2026 23:13:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0B6C60A8D;
 Tue,  3 Nov 2026 23:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C0D1F000C1;
 Tue,  3 Nov 2026 23:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793747602;
 bh=WD2ZOTwHLORa4F+F/G5TkGfBZLzyIQggXxweJGqipwA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DQpJjgqJwe5F4tl/tkKrlXgsf0g6AoVFJV4FRJ9KMYUxx/kjqa9GBZGDU1W/cU99X
 LFhWlo/HKI3/tOb3lZWHP8tU3QDKI7URH+crWSXb/A2l7v0EEq9fdgdnEH4wEtD1Py
 kwXp9IoZKUpc2u+5WlEsCJW0yMqKKfC0uTn+Yid3Jdw/ZVC3uMzjg5PGMgsqUId3t4
 cMyiNUZp/nb59Lm5CayQ+WmAmlPF0ywtABgYjQARH9S/wQ00LHku1fnF/SwYYcSDt6
 BOEwdWa2JnLNd63hnUkziw2hk8GOOs0e8TbedkFGI4+nyWSSnDqXDg6t/9ldsG/hud
 vSOBxJ7MbOdBg==
Message-ID: <sashiko-outbox-196185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/12] drm/amd: add luminance property support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103-superm1-backlight-property-v11-4-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-4-00cce7b2ba22@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:13:21 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/amd/display: stale brightness restored in amdgpu_dm_commit_s=
treams()
- [Medium] drm/amd/display: race and PSR exit in amdgpu_dm_backlight_restor=
e()
- [Medium] drm/amd/display: zero actual_brightness collision in amdgpu_dm_s=
et_luminance()
--

commit 1f2beac3090b1487d1ed83a29307a7bc88af9241
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd: add luminance property support

This commit exposes the DRM LUMINANCE connector property for internal panels
when CONFIG_DRM_LUMINANCE is enabled and applies connector luminance updates
through Display Core backlight helpers and atomic commit callbacks.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 56fca4e22df8d..2a9ddd1dc6f70 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -4802,12 +4799,8 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>  	 * level. (the dm->brightness is the correct panel level)
>  	 * So we set the backlight level with dm->brightness value after set mo=
de
>  	 */
> -	if (set_backlight_level) {
> -		for (i =3D 0; i < dm->num_of_edps; i++) {
> -			if (dm->backlight_dev[i])
> -				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> -		}
> -	}
> +	if (set_backlight_level)
> +		amdgpu_dm_backlight_restore(dm);
>  }
> =20
>  STATIC_IFN_KUNIT void
> @@ -5413,6 +5406,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm=
_atomic_commit *state)
>  	/* Update audio instances for each connector. */
>  	amdgpu_dm_commit_audio(dev, state);
> =20
> +	/* Apply connector luminance after the display pipeline is enabled. */
> +	drm_atomic_helper_commit_luminance_enables(state);
> +
>  	/* restore the backlight level */
>  	for (i =3D 0; i < dm->num_of_edps; i++) {
>  		if (dm->backlight_dev[i] &&

[Severity: Medium]
When a connector is controlled via the LUMINANCE property, dm->brightness[]=
 is
only updated when drm_atomic_helper_commit_luminance_enables() calls
amdgpu_dm_set_luminance() near the end of amdgpu_dm_atomic_commit_tail().

If userspace updates LUMINANCE while the connector is inactive
(!new_conn_state->crtc or !new_crtc_state->active), or updates LUMINANCE in
the same atomic commit as a modeset, dm->brightness[bl_idx] still holds the
previous level when amdgpu_dm_commit_streams() runs earlier in
amdgpu_dm_atomic_commit_tail():

amdgpu_dm_atomic_commit_tail()
  amdgpu_dm_commit_streams()
    amdgpu_dm_backlight_restore()
      amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i])
  amdgpu_dm_mod_power_setup_streams()
  amdgpu_dm_commit_planes()
  ...
  drm_atomic_helper_commit_luminance_enables()
    amdgpu_dm_set_luminance()
      amdgpu_dm_backlight_set_level(dm, bl_idx, state->luminance)

Because drm_atomic_helper_update_legacy_modeset_state() has already set
aconnector->base.encoder and dc_commit_streams() has committed the stream,
amdgpu_dm_backlight_restore() programs the panel hardware,
dm->power_module->bl_state, and the ATOMBIOS scratch register with the stale
dm->brightness[i] value before planes are committed, and then
drm_atomic_helper_commit_luminance_enables() reprograms the hardware a seco=
nd
time with state->luminance.

Furthermore, if a LUMINANCE change was committed while the connector was
inactive and a later modeset exits self-refresh
(old_crtc_state->self_refresh_active is true while old_conn_state->luminanc=
e =3D=3D
new_conn_state->luminance), drm_atomic_helper_commit_luminance_enables() sk=
ips
calling set_luminance, leaving the panel permanently at the stale
dm->brightness[i] level applied by amdgpu_dm_backlight_restore().

Should amdgpu_dm_commit_streams() avoid restoring stale dm->brightness[] for
luminance-controlled connectors, or should dm->brightness[] be synced from =
the
connector state before amdgpu_dm_backlight_restore() runs?

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 0f664c658a127..f61e69bbdf69f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c

[ ... ]

> @@ -675,6 +684,30 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_=
display_manager *dm,
> =20
>  	amdgpu_dm_update_connector_ext_caps(aconnector);
> =20
> +	/*
> +	 * The property must exist before the device is registered. If ACPI
> +	 * video should handle the backlight, leave it to
> +	 * amdgpu_dm_register_backlight_device() to register the fallback.
> +	 */
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && acpi_video_backlight_use_native=
()) {
> +		caps =3D &dm->backlight_caps[bl_idx];
> +		amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied()=
 > 0,
> +					       !(amdgpu_dc_debug_mask &
> +						 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
> +					       &props);
> +		/* Start from the level the hardware is actually at */
> +		ret =3D amdgpu_dm_backlight_get_level(dm, bl_idx);
> +		if (ret >=3D 0 && ret <=3D props.max_brightness)
> +			props.brightness =3D ret;
> +		ret =3D drm_connector_attach_luminance_property(connector, 0,
> +							      props.max_brightness,
> +							      props.brightness);
> +		if (!drm_WARN_ON(adev_to_drm(dm->adev), ret)) {
> +			dm->brightness[bl_idx] =3D props.brightness;
> +			dm->luminance[bl_idx] =3D true;
> +		}
> +	}
> +
>  	/* Offer ABM property when user didn't turn off by module parameter.
>  	 * OLED panels are included to support CACP (Content Adaptive
>  	 * Contrast and Power) feature via set_abm_level.
> @@ -686,6 +719,45 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_=
display_manager *dm,
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
> =20
> +void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
> +{
> +	struct amdgpu_dm_connector *aconnector =3D
> +		to_amdgpu_dm_connector(state->connector);
> +	struct amdgpu_display_manager *dm =3D
> +		&drm_to_adev(state->connector->dev)->dm;
> +
> +	int bl_idx =3D aconnector->bl_idx;
> +
> +	if (bl_idx < 0)
> +		return;
> +
> +	/* Skip if already applied, e.g. by amdgpu_dm_backlight_restore(). */
> +	if (dm->brightness[bl_idx] =3D=3D state->luminance &&
> +	    dm->actual_brightness[bl_idx] =3D=3D state->luminance)
> +		return;
> +
> +	amdgpu_dm_backlight_set_level(dm, bl_idx, state->luminance);
> +}

[Severity: Medium]
Can amdgpu_dm_set_luminance() silently skip programming the hardware when
state->luminance is 0?

In amdgpu_dm_setup_backlight_device(), drm_connector_attach_luminance_prope=
rty()
registers 0 as the minimum valid luminance level, and dm->actual_brightness=
[]
starts at 0 (unlike amdgpu_dm_register_backlight_device(), which seeds
dm->actual_brightness[bl_idx] from the hardware level). In addition,
amdgpu_dm_backlight_set_level() uses dm->actual_brightness[bl_idx] =3D 0 as=
 the
sentinel indicating that brightness was not applied while the connector had=
 no
encoder:

		/* if connector is off, save the brightness for next time it's on */
		if (!aconnector->base.encoder) {
			dm->brightness[bl_idx] =3D user_brightness;
			dm->actual_brightness[bl_idx] =3D 0;
			return;
		}

If dm->brightness[bl_idx] is 0 and dm->actual_brightness[bl_idx] is 0 (for
instance, after saving brightness 0 while the connector was disabled, or if=
 a
prior amdgpu_dm_backlight_set_level(dm, bl_idx, 0) returned early or failed
with rc =3D=3D false), then calling amdgpu_dm_set_luminance() with
state->luminance =3D=3D 0 sees:

	if (dm->brightness[bl_idx] =3D=3D state->luminance &&
	    dm->actual_brightness[bl_idx] =3D=3D state->luminance)
		return;

and returns early without applying minimum brightness to the panel.

Also, in amdgpu_dm_atomic_commit_tail(), the fallback loop that retries
unapplied brightness levels only checks dm->backlight_dev[i]:

	/* restore the backlight level */
	for (i =3D 0; i < dm->num_of_edps; i++) {
		if (dm->backlight_dev[i] &&
		    (dm->actual_brightness[i] !=3D dm->brightness[i]))
			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
	}

Should dm->actual_brightness[] track whether a level has been applied witho=
ut
colliding with valid luminance 0, and should the retry loop in
amdgpu_dm_atomic_commit_tail() also cover dm->luminance[i]?

> +
> +/**
> + * amdgpu_dm_backlight_restore - reprogram the cached backlight levels
> + * @dm: display manager
> + *
> + * Display Core may reset the panel brightness when committing streams, =
so
> + * reapply the cached level of every panel whose backlight is controlled=
 by
> + * the driver, either through a backlight class device or through the
> + * connector LUMINANCE property.
> + */
> +void amdgpu_dm_backlight_restore(struct amdgpu_display_manager *dm)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < dm->num_of_edps; i++) {
> +		if (dm->backlight_dev[i] || dm->luminance[i])
> +			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +	}
> +}

[Severity: Medium]
Could calling amdgpu_dm_backlight_restore() from amdgpu_dm_commit_streams()=
 on
every stream commit cause a race with concurrent luminance updates and trig=
ger
unnecessary PSR/Replay/IPS exits on unaffected eDP panels?

First, when a non-blocking modeset commit runs on an external display CRTC,
do_aquire_global_lock() locks all modeset locks during atomic_check but does
not add unmodified CRTCs (such as an active eDP CRTC) to the atomic state.
Once drm_atomic_helper_swap_state() finishes and locks are dropped, a subse=
quent
fast atomic commit updating LUMINANCE on the eDP connector drops
dm->atomic_obj in amdgpu_dm_atomic_check() and runs amdgpu_dm_atomic_commit=
_tail()
concurrently:

CPU 0 (external CRTC modeset)           CPU 1 (eDP fast luminance commit)
amdgpu_dm_commit_streams()              drm_atomic_helper_commit_luminance_=
enables()
  amdgpu_dm_backlight_restore()           amdgpu_dm_set_luminance()
    reads old dm->brightness[0]             amdgpu_dm_backlight_set_level(n=
ew)
    amdgpu_dm_backlight_set_level(old)        dm->brightness[0] =3D new
      dm->brightness[0] =3D old                 dm->actual_brightness[0] =
=3D new
      overwrites hw & actual_brightness

Because nothing serializes dm->brightness[] and dm->actual_brightness[] acr=
oss
these two commits, CPU 0 can overwrite the panel brightness back to the old
level after CPU 1 has programmed the new luminance, leaving hardware bright=
ness
out of sync with connector->state->luminance.

Second, whenever an external monitor undergoes a modeset while the eDP pane=
l is
idle in PSR, Replay, or IPS with unchanged luminance,
amdgpu_dm_commit_streams() sets set_backlight_level =3D true and calls
amdgpu_dm_backlight_restore(), which unconditionally calls
amdgpu_dm_backlight_set_level() on all eDP panels. That exits IPS and latch=
es
psr_event_hw_programming and replay_event_hw_programming on the eDP stream,
which is not cleared because the eDP CRTC has no plane commit in the state =
to
run amdgpu_dm_enable_self_refresh().

Could amdgpu_dm_commit_streams() only restore backlight for eDP streams that
actually underwent a modeset in that commit, or let
drm_atomic_helper_commit_luminance_enables() handle luminance-controlled
connectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-ba=
cklight-property-v11-0-00cce7b2ba22@kernel.org?part=3D4
