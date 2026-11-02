Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50247606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1wXMSFK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C5810E4EE;
	Mon,  2 Nov 2026 18:49:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8753810F172;
 Mon,  2 Nov 2026 18:49:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE4D64386F;
 Mon,  2 Nov 2026 18:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49761F00A16;
 Mon,  2 Nov 2026 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793645381;
 bh=Yf1BIOB5aSPQn4d8PhmXXznuVmgGlbcpp+eVeGVrd9s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N1wXMSFKjdf34rvtOH8l7V9f5OiNcllWAUC2Ak0S9oFwokrQT/wnNfqRcIYKSCMJB
 P3HDEC8Bx6JGplqmO6fXCZKrg9KwQ76xYZxgLrt325lH2Ci3GQM1ifyo6npgQYolkc
 IRV2sPCfoymyT3kq/7oUH8Lp1/Gh9jeJIsaOoiVxQWOg6I4svNBOqGO4puKdE/MczM
 jOhoHz9BZWWQ/a1T+arGaJ69kYnxXU2ri+i3JMwWmdQymDIlAvqVDLzhdM52rzMGPG
 lq8zfvPHtayyD8Yl0xykZg3Pk/6ekv1fYxwP7eBPjQyWM11KTwm31slpVbsPbC9ITD
 Qyc14LRsUmZkw==
Message-ID: <sashiko-outbox-193966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/15] drm/nouveau: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-10-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-10-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:49:41 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/nouveau: missing luminance commit calls in nv50_disp_atomic_co=
mmit_tail()
- [High] drm/nouveau: WARN_ON attaching luminance prop in nouveau_backlight=
_init()
- [High] drm/nouveau: atomic luminance property unusable on non-atomic NV40=
 KMS
- [Medium] drm/nouveau: stale brightness in nv50_sor_atomic_enable() on eDP=
 modeset
- [Low] drm/nouveau: unmet BACKLIGHT_CLASS_DEVICE dependency for ACPI_VIDEO
--

commit 5d2c149e206a77b8a0aa35e6607301d35db8ef5b
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/nouveau: add connector luminance support

This commit exposes Nouveau panel brightness through the connector LUMINANCE
property when CONFIG_DRM_LUMINANCE is enabled, reusing the NV40, NV50, and
DPCD backlight hardware paths while keeping the backlight class device
interface when CONFIG_DRM_LUMINANCE is disabled.

> diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kc=
onfig
> index 3b5757aed9c84..2dcb7c5344f48 100644
> --- a/drivers/gpu/drm/nouveau/Kconfig
> +++ b/drivers/gpu/drm/nouveau/Kconfig
> @@ -17,13 +17,13 @@ config DRM_NOUVEAU
>  	select DRM_SCHED
>  	select I2C
>  	select I2C_ALGOBIT
> -	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
> +	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT && !DRM_LUMINANCE
>  	select X86_PLATFORM_DEVICES if ACPI && X86
>  	select ACPI_WMI if ACPI && X86
>  	select MXM_WMI if ACPI && X86
>  	select POWER_SUPPLY
>  	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
> -	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
> +	select BACKLIGHT_CLASS_DEVICE if ACPI && X86 && !DRM_LUMINANCE
>  	select INPUT if ACPI && X86
>  	select THERMAL if ACPI && X86
>  	select ACPI_VIDEO if ACPI && X86

[Severity: Low]
Does conditioning BACKLIGHT_CLASS_DEVICE on !DRM_LUMINANCE cause an unmet
Kconfig dependency for ACPI_VIDEO when CONFIG_DRM_LUMINANCE is enabled and
nothing else selects BACKLIGHT_CLASS_DEVICE?

In drivers/acpi/Kconfig, ACPI_VIDEO depends on BACKLIGHT_CLASS_DEVICE:

config ACPI_VIDEO
	tristate "Video"
	depends on BACKLIGHT_CLASS_DEVICE

Because DRM_NOUVEAU still unconditionally selects ACPI_VIDEO if ACPI && X86
(and nouveau_backlight_init() still falls back to
nouveau_acpi_video_register_backlight() under fail_alloc), enabling
CONFIG_DRM_LUMINANCE with CONFIG_BACKLIGHT_CLASS_DEVICE disabled produces an
unmet direct dependency warning for ACPI_VIDEO and link failures in
drivers/acpi/acpi_video.o for backlight_device_register() and
backlight_device_unregister().

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index e91130f93db67..79be7900a0794 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1838,7 +1838,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder,=
 struct drm_atomic_commit *st
>  		backlight =3D nv_connector->backlight;
>  		if (backlight && backlight->uses_dpcd)
>  			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
> -						 backlight->dev->props.brightness);
> +						 backlight->brightness);

[Severity: Medium]
When CONFIG_DRM_LUMINANCE is disabled, won't passing backlight->brightness
here in nv50_sor_atomic_enable() reset an eDP panel's brightness to its
initial boot-time value on subsequent modesets, DPMS wakeups, or resume?

backlight->brightness is initialized once in nouveau_backlight_init(),
whereas user brightness updates through /sys/class/backlight call
nv50_edp_set_brightness() in drivers/gpu/drm/nouveau/nouveau_backlight.c:

static int
nv50_edp_set_brightness(struct backlight_device *bd)
{
	...
	if (crtc->state->active)
		ret =3D drm_edp_backlight_set_level(aux, &nv_bl->edp_info, bd->props.brig=
htness);
	...
}

Because nv50_edp_set_brightness() never updates nv_bl->brightness from
bd->props.brightness, nv50_sor_atomic_enable() will pass the stale initial
backlight->brightness value to drm_edp_backlight_enable().

> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/dr=
m/nouveau/nouveau_backlight.c
> index da1ee24a2531d..fefcfa8c2a3a9 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c

[ ... ]

> @@ -317,10 +327,13 @@ nouveau_backlight_init(struct drm_connector *connec=
tor)
>  	bl =3D kzalloc_obj(*bl);
>  	if (!bl)
>  		return -ENOMEM;
> +	bl->id =3D -1;
> +	bl->encoder =3D nv_encoder;
> =20
>  	switch (device->info.family) {
>  	case NV_DEVICE_INFO_V0_CURIE:
>  		ret =3D nv40_backlight_init(nv_encoder, &props, &ops);
> +		bl->uses_nv40 =3D true;
>  		break;

[Severity: High]
Can the LUMINANCE property work on NV40 (NV_DEVICE_INFO_V0_CURIE) or when
Nouveau is booted with atomic modesetting disabled (nouveau.atomic=3D0)?

NV40 uses the legacy dispnv04 display engine, where nouveau_drm_device_new()
selects driver_legacy_kms without DRIVER_ATOMIC and nv04_display_create() in
drivers/gpu/drm/nouveau/dispnv04/disp.c explicitly clears DRIVER_ATOMIC:

	/* Pre-nv50 doesn't support atomic, so don't expose the ioctls */
	dev->driver_features &=3D ~DRIVER_ATOMIC;

However, drm_connector_attach_luminance_property() creates the LUMINANCE
property with DRM_MODE_PROP_ATOMIC. On non-atomic drivers, atomic client
capability is rejected, DRM_MODE_PROP_ATOMIC properties are hidden from
drm_mode_object_get_properties(), and legacy property updates via
nouveau_connector_set_property() -> nouveau_conn_atomic_set_property() reje=
ct
the property with -EINVAL without calling nouveau_backlight_set_luminance().

Should nouveau_backlight_init() also check
drm_drv_uses_atomic_modeset(connector->dev) before using the LUMINANCE
property instead of registering the backlight class device?

>  	case NV_DEVICE_INFO_V0_TESLA:
>  	case NV_DEVICE_INFO_V0_FERMI:
> @@ -349,26 +362,39 @@ nouveau_backlight_init(struct drm_connector *connec=
tor)
>  		goto fail_alloc;
>  	}
> =20
> -	if (!nouveau_get_backlight_name(backlight_name, bl)) {
> -		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight inte=
rface\n");
> -		goto fail_alloc;
> -	}
> -
>  	props.type =3D BACKLIGHT_RAW;
> -	bl->dev =3D backlight_device_register(backlight_name, connector->kdev,
> -					    nv_encoder, ops, &props);
> -	if (IS_ERR(bl->dev)) {
> -		if (bl->id >=3D 0)
> -			ida_free(&bl_ida, bl->id);
> -		ret =3D PTR_ERR(bl->dev);
> -		goto fail_alloc;
> +	bl->brightness =3D props.brightness;
> +	bl->max_brightness =3D props.max_brightness;
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
> +		ret =3D drm_connector_attach_luminance_property(connector, 0, props.ma=
x_brightness,
> +							      props.brightness);
> +		if (ret)
> +			goto fail_alloc;

[Severity: High]
Won't calling drm_connector_attach_luminance_property() here in
nouveau_backlight_init() trigger a WARN_ON in __drm_mode_object_add() on
every internal panel registration?

nouveau_backlight_init() is called from nouveau_connector_late_register(),
which runs during drm_dev_register() -> drm_modeset_register_all() ->
drm_connector_register() after drm_dev_register() has already registered the
DRM minor device nodes and set dev->registered =3D true:

nouveau_connector_late_register()
  -> nouveau_backlight_init()
    -> drm_connector_attach_luminance_property()
      -> drm_property_create_range()
        -> drm_property_create()
          -> drm_mode_object_add()
            -> __drm_mode_object_add()

In drivers/gpu/drm/drm_mode_object.c:__drm_mode_object_add():

	WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);

Because DRM_MODE_OBJECT_PROPERTY objects have no obj_free_cb and
dev->registered is already true in late_register, this triggers the WARN_ON
and mutates dev->mode_config.property_list, connector->base.properties, and
connector->state->luminance without locking after the DRM device has been
exposed to userspace.

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index cc3caf8de64b0..56ee579ea7909 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1225,6 +1225,8 @@ nouveau_connector_helper_funcs =3D {
>  	.mode_valid =3D nouveau_connector_mode_valid,
>  	.best_encoder =3D nouveau_connector_best_encoder,
>  	.atomic_check =3D nouveau_connector_atomic_check,
> +	.set_luminance =3D nouveau_backlight_set_luminance,
> +	.disable_luminance =3D nouveau_backlight_disable_luminance,
>  };

[Severity: High]
Are nouveau_backlight_set_luminance() and
nouveau_backlight_disable_luminance() ever invoked during atomic commits in
Nouveau?

In drivers/gpu/drm/drm_atomic_helper.c, the .disable_luminance and
.set_luminance connector helper callbacks are called from
drm_atomic_helper_commit_luminance_disables() and
drm_atomic_helper_commit_luminance_enables() (or via
drm_atomic_helper_commit_modeset_disables() and
drm_atomic_helper_commit_modeset_enables()).

However, Nouveau's NV50+ display driver in
drivers/gpu/drm/nouveau/dispnv50/disp.c implements its own atomic commit pa=
th
in nv50_disp_atomic_commit() -> nv50_disp_atomic_commit_tail(), which
disables and enables heads, planes, and outputs directly without calling
drm_atomic_helper_commit_modeset_disables(),
drm_atomic_helper_commit_modeset_enables(),
drm_atomic_helper_commit_luminance_disables(), or
drm_atomic_helper_commit_luminance_enables().

Without calling those helpers in nv50_disp_atomic_commit_tail(), won't
updates to the LUMINANCE connector property be silently ignored by the
hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D10
