Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C04606A595
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMY1oCWI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058F610E696;
	Mon,  2 Nov 2026 17:32:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4BA10E696;
 Mon,  2 Nov 2026 17:32:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73A9F40B30;
 Mon,  2 Nov 2026 17:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286821F00A16;
 Mon,  2 Nov 2026 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793640739;
 bh=zOcmPUSHcxg1YU8snk6oeo+/v0T/WPyG3fA5tjjAvhk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kMY1oCWIdk7BfuuaP2hhKXWPfdaATne/N4ViVFHV87IAHnDMOk8OpTjcc4HCaFp48
 GmVyCQUvTMww20itQ5VcM0ZYyTKmJSRk8O81ImBc/eXnAItDTIlHHf5pXfM1C1goUj
 +4vZUZ+tK0pkhwB6UQxaGE5Wce23HE5q/1F6A0alrhgvJkPktUauHqo/o6+ObeyB8g
 y2EjgwItrhJSzgt3qJG6kixoY+/ZQtflDmYFTLcUI0qfqezlqqSv16N+B33CnWmGS6
 a6glbLUx8JlFpB+wimHPGLL2aan8l+jU1waGGzjm2344BFAKCQqNgScfnMHKVhE9u9
 mitHAKfKdEfIA==
Message-ID: <sashiko-outbox-193840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/15] drm/amd: add luminance property support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-3-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-3-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:32:18 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/amdgpu: broken atomic LUMINANCE support on non-atomic legacy d=
isplay
- [High] drm/amd/display: skipped backlight restore and setup when DRM_LUMI=
NANCE=3Dy
- [Medium] drm/amd/display: unconditional backlight programming blocks PSR/=
Replay
- [Low] drm/amd: Kconfig and link breakage when DRM_LUMINANCE=3Dy without b=
acklight
--

commit de26f6665aed29ccc412fe4be3f0737b06b98759
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd: add luminance property support

This commit adds support for the DRM LUMINANCE connector property on intern=
al
panels when CONFIG_DRM_LUMINANCE is enabled, bypassing sysfs backlight devi=
ce
registration and wiring connector luminance callbacks for Display Core and
legacy display paths.

> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 50305630f5335..7a6a049aa6e90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -20,7 +20,7 @@ config DRM_AMDGPU
>  	select I2C
>  	select I2C_ALGOBIT
>  	select CRC16
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	select INTERVAL_TREE
>  	select DRM_BUDDY
>  	select DRM_SUBALLOC_HELPER

[Severity: Low]
Does dropping select BACKLIGHT_CLASS_DEVICE when CONFIG_DRM_LUMINANCE is
enabled cause Kconfig dependency warnings and link errors when
CONFIG_BACKLIGHT_CLASS_DEVICE is disabled (or built as a module with
CONFIG_DRM_AMDGPU=3Dy)?

In drivers/gpu/drm/amd/amdgpu/Kconfig, config DRM_AMDGPU still unconditiona=
lly
selects ACPI_VIDEO when ACPI is enabled:

	# decidable, for the moment, to just select all of ACPI_VIDEO's
	# dependencies, which is fewer than you might think.
	select ACPI_VIDEO if ACPI

Because config ACPI_VIDEO in drivers/acpi/Kconfig depends on
BACKLIGHT_CLASS_DEVICE, enabling CONFIG_DRM_LUMINANCE=3Dy with CONFIG_ACPI=
=3Dy and
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn triggers an unmet direct dependency warni=
ng
for ACPI_VIDEO.

In addition, include/linux/backlight.h declares backlight_device_register(),
backlight_device_unregister(), and backlight_device_set_brightness() without
inline stubs when CONFIG_BACKLIGHT_CLASS_DEVICE is disabled, while amdgpu
still compiles direct references to those symbols:

- amdgpu_dm_register_backlight_device() in
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c is a non-stat=
ic
  function compiled unconditionally that calls backlight_device_register().
- amdgpu_dm_connector_destroy() in
  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c and
  amdgpu_atombios_encoder_fini_backlight() in
  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c call
  backlight_device_unregister() behind runtime pointer checks.
- amdgpu_atif_handler() in drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c calls
  backlight_device_set_brightness(atif->bd, req.backlight_level) behind a
  runtime check on atif->bd.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 92c98e999efe9..209a7a6c246db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -798,11 +798,31 @@ static int amdgpu_connector_set_lcd_property(struct=
 drm_connector *connector,
>  	return 0;
>  }
> =20
> +static void amdgpu_connector_set_luminance(const struct drm_connector_st=
ate *conn_state)
> +{
> +	struct drm_encoder *encoder =3D
> +		amdgpu_connector_best_single_encoder(conn_state->connector);
> +
> +	if (encoder)
> +		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder),
> +							    conn_state->luminance);
> +}
> +
> +static void amdgpu_connector_disable_luminance(const struct drm_connecto=
r_state *conn_state)
> +{
> +	struct drm_encoder *encoder =3D
> +		amdgpu_connector_best_single_encoder(conn_state->connector);
> +
> +	if (encoder)
> +		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder)=
, 0);
> +}
> =20
>  static const struct drm_connector_helper_funcs amdgpu_connector_lvds_hel=
per_funcs =3D {
>  	.get_modes =3D amdgpu_connector_lvds_get_modes,
>  	.mode_valid =3D amdgpu_connector_lvds_mode_valid,
>  	.best_encoder =3D amdgpu_connector_best_single_encoder,
> +	.set_luminance =3D amdgpu_connector_set_luminance,
> +	.disable_luminance =3D amdgpu_connector_disable_luminance,
>  };
> =20
>  static const struct drm_connector_funcs amdgpu_connector_lvds_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu=
/drm/amd/amdgpu/atombios_encoders.c
> index a1d05df0ac99b..dbff532ac1bcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -191,6 +191,21 @@ void amdgpu_atombios_encoder_init_backlight(struct a=
mdgpu_encoder *amdgpu_encode
>  		goto register_acpi_backlight;
>  	}
> =20
> +	dig =3D amdgpu_encoder->enc_priv;
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		unsigned int brightness;
> +
> +		brightness =3D amdgpu_atombios_encoder_get_backlight_level(amdgpu_enco=
der);
> +		if (drm_connector_attach_luminance_property(drm_connector, 0,
> +							    AMDGPU_MAX_BL_LEVEL,
> +							     brightness))
> +			return;
> +
> +		dig->backlight_level =3D brightness;
> +		dig->bl_dev =3D NULL;
> +		return;
> +	}

[Severity: High]
Can atomic LUMINANCE work on the legacy non-DC display path in
drivers/gpu/drm/amd/amdgpu/atombios_encoders.c and amdgpu_connectors.c?

Those files are used only when Display Core is not active, where
amdgpu_pci_probe() in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c clears
DRIVER_ATOMIC:

	if (!supports_atomic)
		ddev->driver_features &=3D ~DRIVER_ATOMIC;

On this legacy path, connectors do not implement atomic state callbacks
(.reset, .atomic_duplicate_state, .atomic_destroy_state), so
drm_connector->state is NULL, and modesets use legacy CRTC helpers
(drm_crtc_helper_set_config() and drm_helper_connector_dpms()).

Because drm_connector_attach_luminance_property() creates LUMINANCE with
DRM_MODE_PROP_ATOMIC, non-atomic drivers hide LUMINANCE from userspace, leg=
acy
property updates go through amdgpu_connector_set_lcd_property() (which igno=
res
everything except scaling_mode_property), and the legacy helpers never invo=
ke
drm_atomic_helper_commit_luminance_enables() or
drm_atomic_helper_commit_luminance_disables(). Skipping backlight_device_re=
gister()
in amdgpu_atombios_encoder_init_backlight() therefore leaves legacy panels
with no working brightness control when CONFIG_DRM_LUMINANCE=3Dy.

Even if atomic callbacks were reachable here, there are two additional issu=
es
in drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:

1. .set_luminance and .disable_luminance are only added to
   amdgpu_connector_lvds_helper_funcs and are missing from
   amdgpu_connector_dp_helper_funcs, which is used by DRM_MODE_CONNECTOR_eDP
   and DP-bridge LVDS connectors that also call
   amdgpu_atombios_encoder_init_backlight().
2. amdgpu_connector_disable_luminance() calls
   amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder), =
0),
   which overwrites dig->backlight_level =3D 0 and mmBIOS_SCRATCH_2 =3D 0,
   clobbering the saved brightness level used by
   amdgpu_atombios_encoder_setup_dig() on enable and by dce_v*_suspend().

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0ea45ab12119c..53ff9a55c3a8e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -5397,11 +5398,16 @@ static void amdgpu_dm_atomic_commit_tail(struct d=
rm_atomic_commit *state)
>  	/* Update audio instances for each connector. */
>  	amdgpu_dm_commit_audio(dev, state);
> =20
> -	/* restore the backlight level */
> -	for (i =3D 0; i < dm->num_of_edps; i++) {
> -		if (dm->backlight_dev[i] &&
> -		    (dm->actual_brightness[i] !=3D dm->brightness[i]))
> -			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		/* Apply brightness after the display pipeline is enabled. */
> +		drm_atomic_helper_commit_luminance_enables(state);
> +	} else {
> +		/* Restore the legacy backlight level. */
> +		for (i =3D 0; i < dm->num_of_edps; i++) {
> +			if (dm->backlight_dev[i] &&
> +			    dm->actual_brightness[i] !=3D dm->brightness[i])
> +				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
> +		}
>  	}

[Severity: Medium]
Unlike the !CONFIG_DRM_LUMINANCE branch, which checks
dm->actual_brightness[i] !=3D dm->brightness[i], doesn't calling
drm_atomic_helper_commit_luminance_enables(state) -> amdgpu_dm_set_luminanc=
e() ->
amdgpu_dm_backlight_set_level() here reprogram the backlight on every atomic
commit that includes an active eDP connector in state even when
state->luminance has not changed?

In amdgpu_dm_atomic_commit_tail(), drm_atomic_helper_commit_luminance_enabl=
es()
runs after amdgpu_dm_commit_planes(). Inside amdgpu_dm_backlight_set_level()
in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c, the driver
exits IPS, reprograms the backlight via mod_power_set_backlight_nits() or
mod_power_set_backlight_percent(), and disables PSR and Panel Replay until =
the
next plane flip:

	amdgpu_dm_psr_set_event(dm, stream, true,
		psr_event_hw_programming, true);
	amdgpu_dm_replay_set_event(dm, stream, true,
		replay_event_hw_programming, true);

Because amdgpu_dm_commit_planes() -> amdgpu_dm_enable_self_refresh() has
already run earlier in amdgpu_dm_atomic_commit_tail(), any commit that pulls
the active eDP connector into state without changing state->luminance (such=
 as
CRTC color management or VRR updates via drm_atomic_add_affected_connectors=
(),
ABM/HDR/scaling connector property updates, or compositor commits that incl=
ude
connector properties) will immediately re-assert psr_event_hw_programming a=
nd
replay_event_hw_programming and block PSR/Replay entry.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 0f664c658a127..0857354e7327e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c

[ ... ]

> @@ -657,6 +662,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_=
display_manager *dm,
>  {
>  	struct dc_link *link =3D aconnector->dc_link;
>  	int bl_idx =3D dm->num_of_edps;
> +	struct backlight_properties props =3D { 0 };
> +	struct amdgpu_dm_backlight_caps *caps;
> +	struct drm_connector *connector =3D &aconnector->base;
> +	int ret;
> =20
>  	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
>  	    link->type =3D=3D dc_connection_none)
> @@ -675,6 +684,19 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_=
display_manager *dm,
> =20
>  	amdgpu_dm_update_connector_ext_caps(aconnector);
> =20
> +	caps =3D &dm->backlight_caps[bl_idx];
> +	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() =
> 0,
> +				       !(amdgpu_dc_debug_mask &
> +					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
> +				       &props);
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		unsigned int max =3D props.max_brightness;
> +		unsigned int value =3D props.brightness;
> +
> +		ret =3D drm_connector_attach_luminance_property(connector, 0, max, val=
ue);
> +		drm_WARN_ON(adev_to_drm(dm->adev), ret);
> +	}
> +
>  	/* Offer ABM property when user didn't turn off by module parameter.
>  	 * OLED panels are included to support CACP (Content Adaptive
>  	 * Contrast and Power) feature via set_abm_level.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..f2c2a2e730d3e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -2038,7 +2039,8 @@ amdgpu_dm_connector_late_register(struct drm_connec=
tor *connector)
>  			return r;
>  	}
> =20
> -	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> +	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
> +		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);

[Severity: High]
When CONFIG_DRM_LUMINANCE is enabled, skipping
amdgpu_dm_register_backlight_device() leaves dm->backlight_dev[i] as NULL a=
nd
leaves dm->brightness[bl_idx] uninitialized (0) in
amdgpu_dm_setup_backlight_device(). Doesn't this break several backlight
restoration and initialization paths in Display Core?

Specifically:

1. In dm_resume() in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c, the
   GPU reset recovery branch (if (amdgpu_in_reset(adev))) does not go throu=
gh
   drm_atomic_helper_resume() or amdgpu_dm_atomic_commit_tail(), and instead
   restores panel brightness via:

		/* set the backlight after a reset */
		for (i =3D 0; i < dm->num_of_edps; i++) {
			if (dm->backlight_dev[i])
				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
		}

   Because dm->backlight_dev[i] is NULL (and dm->brightness[i] is 0 until a
   luminance commit occurs), panel brightness will not be restored after a =
GPU
   reset.

2. In amdgpu_dm_commit_streams() in
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c, after dc_commit_strea=
ms()
   is called, backlight restoration is likewise gated on dm->backlight_dev[=
i]:

	if (set_backlight_level) {
		for (i =3D 0; i < dm->num_of_edps; i++) {
			if (dm->backlight_dev[i])
				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
		}
	}

   If a modeset happens on an external display on another CRTC while the eDP
   connector is not part of the atomic commit state, neither
   amdgpu_dm_commit_streams() nor drm_atomic_helper_commit_luminance_enable=
s(state)
   will restore the eDP brightness.

3. Unlike amdgpu_dm_register_backlight_device(), amdgpu_dm_setup_backlight_=
device()
   does not check acpi_video_backlight_use_native() before attaching the
   LUMINANCE property, and skipping amdgpu_dm_register_backlight_device() a=
lso
   skips the acpi_video_register_backlight() fallback when native backlight
   control should not be used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D3
