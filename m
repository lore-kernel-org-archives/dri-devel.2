Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29720606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9zNs0PI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C5E10F181;
	Mon,  2 Nov 2026 19:13:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F295410F181;
 Mon,  2 Nov 2026 19:13:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9394640483;
 Mon,  2 Nov 2026 19:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F701F00A1A;
 Mon,  2 Nov 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793646816;
 bh=mVwW46Ix1pPjk3S+qYIOpucX+dYUOfIBWRE/ULS6t2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C9zNs0PIdwv99boHjA5RQ+A10sQ/qOeHFqZJLOXy2/Z10CvsKtQSAst8v85h6Su5M
 OVK/jkq76vk3TyYkC+Saymx1l40s/HwzYZhvelnsT/F+Cq0XLhe+EAorsmwubc4Hf6
 hb1BqxnBRZBV1J05v9T2DNQYMlqgFlGlzPBHenKUJF1+QUWSfyKLNdn3fPCgt1Dp6i
 jJx/TJY+ic9Eam5r1cQ6S4gWmeJWWw2oKhuzIacgViWm0NIlusuHQdTjAbw9PLsJ+p
 BgPdSqviBW/+1ZscSbUkF06gpx7Q5Jpy/Km5y84F4rB9YnctXfYdXezFXSgMUEDq2y
 zZXA99cTgqeQw==
Message-ID: <sashiko-outbox-193983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/15] drm/radeon: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-12-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-12-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:13:35 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/radeon: unreachable atomic LUMINANCE property on non-atomic KM=
S driver
- [High] drm/radeon: legacy LVDS backlight ignored and panel turned off in =
radeon_legacy_lvds_update()
- [High] drm/radeon: missing luminance callbacks in radeon_dp_connector_hel=
per_funcs
- [Medium] drm/radeon: Kconfig unmet dependency and link error with DRM_LUM=
INANCE
- [Medium] drm/radeon: ACPI ATIF brightness events ignored when dig->bl_dev=
 is NULL
- [Medium] drm/radeon: memory leak of backlight_priv when LCD encoder links=
 to multiple connectors
--

commit d872f715df68798d7e323e8f154d8558d421e434
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/radeon: add connector luminance support

This commit adds support for exposing Radeon panel brightness through the
connector LUMINANCE property when CONFIG_DRM_LUMINANCE is enabled, reusing
the AtomBIOS and legacy hardware programming paths while keeping the
backlight class interface otherwise.

> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kcon=
fig
> index 3cd70aef770e1..2ccad1f2f8cee 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -17,7 +17,7 @@ config DRM_RADEON
>  	select SND_HDA_COMPONENT if SND_HDA_CORE
>  	select POWER_SUPPLY
>  	select HWMON
> -	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
>  	select INTERVAL_TREE
>  	select I2C
>  	select I2C_ALGOBIT

[Severity: Medium]
Can making BACKLIGHT_CLASS_DEVICE conditional on !DRM_LUMINANCE cause an
unmet Kconfig dependency and linker failures when CONFIG_DRM_LUMINANCE=3Dy,
CONFIG_ACPI=3Dy, and CONFIG_BACKLIGHT_CLASS_DEVICE is disabled (or modular
with built-in DRM_RADEON)?

Just below in drivers/gpu/drm/radeon/Kconfig, DRM_RADEON still
unconditionally selects ACPI_VIDEO:

	# radeon depends on ACPI_VIDEO when ACPI is enabled, for select to work
	# ACPI_VIDEO's dependencies must also be selected.
	select INPUT if ACPI
	select ACPI_VIDEO if ACPI

In drivers/acpi/Kconfig, ACPI_VIDEO depends on BACKLIGHT_CLASS_DEVICE:

config ACPI_VIDEO
	tristate "Video"
	depends on BACKLIGHT_CLASS_DEVICE

In addition, radeon_atif_handler() in drivers/gpu/drm/radeon/radeon_acpi.c
unconditionally calls backlight_force_update(), which has no inline stub in
include/linux/backlight.h when CONFIG_BACKLIGHT_CLASS_DEVICE is disabled:

	if (rdev->is_atom_bios) {
		struct radeon_encoder_atom_dig *dig =3D enc->enc_priv;
		backlight_force_update(dig->bl_dev,
				       BACKLIGHT_UPDATE_HOTKEY);
	} else {
		struct radeon_encoder_lvds *dig =3D enc->enc_priv;
		backlight_force_update(dig->bl_dev,
				       BACKLIGHT_UPDATE_HOTKEY);
	}

> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 5b9c72bf40994..e6f762625bf1a 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -227,6 +227,27 @@ void radeon_atom_backlight_init(struct radeon_encode=
r *radeon_encoder,
>  	memset(&props, 0, sizeof(props));
>  	props.max_brightness =3D RADEON_MAX_BL_LEVEL;
>  	props.type =3D BACKLIGHT_RAW;
> +	pdata->encoder =3D radeon_encoder;
> +	pdata->atom =3D true;
> +	radeon_encoder->backlight_priv =3D pdata;

[Severity: Medium]
Can this leak the struct radeon_backlight_privdata allocation in pdata
when an encoder with ATOM_DEVICE_LCD_SUPPORT is shared across multiple
connectors?

In radeon_add_atom_encoder() and radeon_add_legacy_encoder(), encoders
sharing the same encoder_enum combine their device bitmasks via
radeon_encoder->devices |=3D supported_device. When
radeon_link_encoder_connector() in drivers/gpu/drm/radeon/radeon_encoders.c
links encoders and connectors, it checks radeon_encoder->devices rather
than radeon_connector->devices:

	if (radeon_encoder->devices & radeon_connector->devices) {
		drm_connector_attach_encoder(connector, encoder);
		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT))
			radeon_encoder_add_backlight(radeon_encoder, connector);
	}

When radeon_encoder_add_backlight() is invoked a second time for the same
radeon_encoder (both here in radeon_atom_backlight_init() and in
radeon_legacy_backlight_init()), radeon_encoder->backlight_priv is
overwritten with the newly allocated pdata. With CONFIG_DRM_LUMINANCE
enabled, drm_connector_attach_luminance_property() succeeds on the second
connector and leaks the first pdata allocation (or if registration fails
and jumps to error:, radeon_encoder->backlight_priv is cleared to NULL
without freeing or preserving the first allocation).

> +
> +	dig =3D radeon_encoder->enc_priv;
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		props.brightness =3D atombios_get_backlight_level(radeon_encoder);
> +		if (!props.brightness)
> +			props.brightness =3D RADEON_MAX_BL_LEVEL;
> +
> +		if (drm_connector_attach_luminance_property(drm_connector, 0,
> +							    props.max_brightness,
> +							     props.brightness))
> +			goto error;
> +
> +		atombios_set_backlight_level(radeon_encoder, props.brightness);
> +		dig->bl_dev =3D NULL;
> +		rdev->mode_info.bl_encoder =3D radeon_encoder;
> +		return;
> +	}

[Severity: High]
How can userspace access or update the LUMINANCE property on radeon when
radeon is a non-atomic KMS driver?

In drivers/gpu/drm/radeon/radeon_drv.c, kms_driver does not advertise
DRIVER_ATOMIC:

	.driver_features =3D
	    DRIVER_GEM | DRIVER_RENDER | DRIVER_MODESET,

However, drm_connector_attach_luminance_property() creates the LUMINANCE
property with DRM_MODE_PROP_ATOMIC:

	property =3D drm_property_create_range(connector->dev, DRM_MODE_PROP_ATOMI=
C,
					     "LUMINANCE", min, max);

Because DRIVER_ATOMIC is not set:
1. drm_setclientcap() rejects DRM_CLIENT_CAP_ATOMIC, so
   drm_mode_object_get_properties() hides DRM_MODE_PROP_ATOMIC properties
   from userspace.
2. Legacy property updates go through drm_mode_obj_set_property_ioctl() ->
   set_property_legacy() -> radeon_lvds_set_property(), which ignores
   everything except scaling_mode_property.
3. radeon_set_luminance() and radeon_disable_luminance() are only invoked
   by drm_atomic_helper_commit_luminance_enables() and
   drm_atomic_helper_commit_luminance_disables(), which radeon never calls.

Since radeon_atom_backlight_init() and radeon_legacy_backlight_init()
return early before backlight_device_register() when CONFIG_DRM_LUMINANCE
is enabled (and set rdev->mode_info.bl_encoder, which also prevents the
acpi_video_register_backlight() fallback in radeon_encoder_add_backlight()),
won't this leave panels with no working brightness control interface?

[Severity: Medium]
Also, when dig->bl_dev is set to NULL here (and in
radeon_legacy_backlight_init()), won't ACPI ATIF panel brightness events
stop working?

In drivers/gpu/drm/radeon/radeon_acpi.c, radeon_acpi_init() locates
atif->encoder_for_bl by checking dig->bl_dev:

	if (rdev->is_atom_bios) {
		struct radeon_encoder_atom_dig *dig =3D enc->enc_priv;
		if (dig->bl_dev) {
			target =3D enc;
			break;
		}
	} else {
		struct radeon_encoder_lvds *dig =3D enc->enc_priv;
		if (dig->bl_dev) {
			target =3D enc;
			break;
		}
	}

When dig->bl_dev is NULL, atif->encoder_for_bl remains NULL and
radeon_atif_handler() ignores ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST events.

[ ... ]

> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index 16b048f58c9be..655361407b819 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c

[ ... ]

> @@ -931,11 +932,44 @@ static int radeon_lvds_set_property(struct drm_conn=
ector *connector,
>  	return 0;
>  }
> =20
> +static void radeon_set_luminance(const struct drm_connector_state *conn_=
state)
> +{
> +	struct drm_encoder *encoder =3D radeon_best_single_encoder(conn_state->=
connector);
> +	struct radeon_encoder *radeon_encoder;
> +	struct radeon_backlight_privdata *pdata;
> +	u8 level =3D conn_state->luminance;
> +
> +	if (!encoder)
> +		return;
> +
> +	radeon_encoder =3D to_radeon_encoder(encoder);
> +	pdata =3D radeon_encoder->backlight_priv;
> +	if (!pdata)
> +		return;
> +
> +	if (pdata->atom) {
> +		atombios_set_backlight_level(radeon_encoder, level);
> +	} else {
> +		if (pdata->negative)
> +			level =3D RADEON_MAX_BL_LEVEL - level;
> +		radeon_legacy_set_backlight_level(radeon_encoder, level);
> +	}
> +}
> +
> +static void radeon_disable_luminance(const struct drm_connector_state *c=
onn_state)
> +{
> +	struct drm_connector_state state =3D *conn_state;
> +
> +	state.luminance =3D 0;
> +	radeon_set_luminance(&state);
> +}
> =20
>  static const struct drm_connector_helper_funcs radeon_lvds_connector_hel=
per_funcs =3D {
>  	.get_modes =3D radeon_lvds_get_modes,
>  	.mode_valid =3D radeon_lvds_mode_valid,
>  	.best_encoder =3D radeon_best_single_encoder,
> +	.set_luminance =3D radeon_set_luminance,
> +	.disable_luminance =3D radeon_disable_luminance,
>  };

[Severity: High]
Are .set_luminance and .disable_luminance also needed in
radeon_dp_connector_helper_funcs?

In radeon_add_atom_connector(), native DRM_MODE_CONNECTOR_eDP connectors
and DP-bridge (TRAVIS/NUTMEG) DRM_MODE_CONNECTOR_LVDS/eDP connectors use
radeon_dp_connector_helper_funcs:

	drm_connector_init_with_ddc(dev, &radeon_connector->base,
				    &radeon_edp_connector_funcs,
				    connector_type,
				    ddc);
	drm_connector_helper_add(&radeon_connector->base, &radeon_dp_connector_hel=
per_funcs);

Their encoders have ATOM_DEVICE_LCD_SUPPORT set, so
radeon_link_encoder_connector() -> radeon_encoder_add_backlight() ->
radeon_atom_backlight_init() attaches the LUMINANCE property to those
connectors, but radeon_dp_connector_helper_funcs does not wire up
.set_luminance or .disable_luminance (and on DP-bridge connectors,
radeon_dvi_encoder() rather than radeon_best_single_encoder() selects the
encoder with enc_priv).

> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gp=
u/drm/radeon/radeon_legacy_encoders.c
> index 1f82e2b57f5d5..96b0dfd8e3521 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c

[ ... ]

> @@ -441,6 +434,36 @@ void radeon_legacy_backlight_init(struct radeon_enco=
der *radeon_encoder,
>  #endif
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		props.brightness =3D pdata->negative ?
> +			RADEON_MAX_BL_LEVEL - backlight_level : backlight_level;
> +		if (drm_connector_attach_luminance_property(drm_connector, 0,
> +							    props.max_brightness,
> +							     props.brightness))
> +			goto error;
> +
> +		if (rdev->is_atom_bios) {
> +			struct radeon_encoder_atom_dig *lvds =3D radeon_encoder->enc_priv;
> +
> +			lvds->bl_dev =3D NULL;
> +		} else {
> +			struct radeon_encoder_lvds *lvds =3D radeon_encoder->enc_priv;
> +
> +			lvds->bl_dev =3D NULL;
> +		}
> +		rdev->mode_info.bl_encoder =3D radeon_encoder;
> +		return;
> +	}

[Severity: High]
When lvds->bl_dev is set to NULL here without initializing
lvds->backlight_level, won't radeon_legacy_lvds_update() ignore brightness
updates and radeon_legacy_set_backlight_level() power off the panel?

In radeon_legacy_lvds_update(), lvds->backlight_level is only used if
lvds->bl_dev is non-NULL:

	if (radeon_encoder->enc_priv) {
		if (rdev->is_atom_bios) {
			struct radeon_encoder_atom_dig *lvds =3D radeon_encoder->enc_priv;
			panel_pwr_delay =3D lvds->panel_pwr_delay;
			if (lvds->bl_dev)
				backlight_level =3D lvds->backlight_level;
		} else {
			struct radeon_encoder_lvds *lvds =3D radeon_encoder->enc_priv;
			panel_pwr_delay =3D lvds->panel_pwr_delay;
			if (lvds->bl_dev)
				backlight_level =3D lvds->backlight_level;
		}
	}

Furthermore, radeon_legacy_set_backlight_level() checks the previous value
of lvds->backlight_level before updating it:

	if (radeon_encoder->enc_priv) {
		if (rdev->is_atom_bios) {
			struct radeon_encoder_atom_dig *lvds =3D radeon_encoder->enc_priv;
			if (lvds->backlight_level > 0)
				dpms_mode =3D lvds->dpms_mode;
			else
				dpms_mode =3D DRM_MODE_DPMS_OFF;
			lvds->backlight_level =3D level;
		} else {
			struct radeon_encoder_lvds *lvds =3D radeon_encoder->enc_priv;
			if (lvds->backlight_level > 0)
				dpms_mode =3D lvds->dpms_mode;
			else
				dpms_mode =3D DRM_MODE_DPMS_OFF;
			lvds->backlight_level =3D level;
		}
	}

	radeon_legacy_lvds_update(&radeon_encoder->base, dpms_mode);

Because lvds->backlight_level starts at 0 (or becomes 0 when maximum
brightness is set on a pdata->negative panel where
level =3D RADEON_MAX_BL_LEVEL - level), radeon_legacy_set_backlight_level()
will pass DRM_MODE_DPMS_OFF to radeon_legacy_lvds_update().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D12
