Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9037606A33A
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lEijznAB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CDF10E5EB;
	Mon,  2 Nov 2026 19:22:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BC210E158;
 Mon,  2 Nov 2026 19:22:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C8D740BDC;
 Mon,  2 Nov 2026 19:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E91F00A16;
 Mon,  2 Nov 2026 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793647365;
 bh=wXFdz4rCKaUy03+yF3E+PKzgPxmyFUgtjd8xEb9PvlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lEijznAB/vvttmFCr8agtP+lPkrc2v9lf3QNemF5UJ0xYsnaDvJHpnSAKkrpOs1fQ
 SEoUhzPtjAZc6doRSb40x3G5d7URUXQSFIG+bFQ824O32e2XijbNrQJuMWDvKRaV3a
 7Ko4gY3UzjLgv9z59OnPWOFAscJB03I5tcf00HW7opgQTqqJkhGs5hjSmwAOkYtdCb
 QcmlwbxATBvu5T47E1pZwUo71Q940iKZoJIC0AIzMX2a2mn3EjARGdMydfinGwhP3a
 7i+S1xpntugZA8HWHYTtzMyhXQF4VvgnY6vmtHbcx+0vDE2VFkpMNzRAcw4666eGhB
 CngIlyenhJObw==
Message-ID: <sashiko-outbox-193998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/15] drm/gma500: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-13-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-13-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:22:44 +0000
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
- [High] drm/gma500: unreachable atomic luminance support in gma_backlight_=
init()
- [High] drm/gma500: gma_connector_disable_luminance() permanently disables=
 backlight
- [Medium] drm/gma500: Kconfig unmet dependency and backlight link errors i=
n backlight.c
--

commit 44c343eaada226f65e1091fb750905e2745ab610
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/gma500: add connector luminance support

This commit exposes panel brightness on gma500 through the connector
luminance property when drm luminance support is enabled, routing updates
through existing platform backlight operations.

> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kcon=
fig
> index dc4c566388192..08871a8f6fa22 100644
> --- a/drivers/gpu/drm/gma500/Kconfig
> +++ b/drivers/gpu/drm/gma500/Kconfig
> @@ -9,7 +9,7 @@ config DRM_GMA500
>  	select I2C_ALGOBIT
>  	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
>  	select ACPI_VIDEO if ACPI
> -	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
>  	select INPUT if ACPI
>  	select ACPI_WMI if ACPI
>  	help
> diff --git a/drivers/gpu/drm/gma500/backlight.c b/drivers/gpu/drm/gma500/=
backlight.c
> index c8f1716a12d52..4bb39fba04539 100644
> --- a/drivers/gpu/drm/gma500/backlight.c
> +++ b/drivers/gpu/drm/gma500/backlight.c

[ ... ]

> @@ -73,10 +72,9 @@ static const struct backlight_ops gma_backlight_ops __=
maybe_unused =3D {
>  	.update_status  =3D gma_backlight_update_status,
>  };
> =20
> -int gma_backlight_init(struct drm_device *dev)
> +int gma_backlight_init(struct drm_device *dev, struct drm_connector *con=
nector)
>  {
>  	struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);
> -	struct backlight_properties props __maybe_unused =3D {};
>  	int ret;
> =20
>  	dev_priv->backlight_enabled =3D true;
> @@ -92,28 +90,43 @@ int gma_backlight_init(struct drm_device *dev)
>  		return 0;
>  	}
> =20
> -#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
> -	props.brightness =3D dev_priv->backlight_level;
> -	props.max_brightness =3D PSB_MAX_BRIGHTNESS;
> -	props.type =3D BACKLIGHT_RAW;
> +	if (IS_ENABLED(CONFIG_DRM_LUMINANCE))
> +		return drm_connector_attach_luminance_property(connector, 0,
> +							 PSB_MAX_BRIGHTNESS,
> +							 dev_priv->backlight_level);

[Severity: High]
Does attaching the luminance property and returning early in
psb_driver_load() -> gma_backlight_init() leave panel brightness completely
uncontrollable when drm luminance is enabled?

In drivers/gpu/drm/gma500/psb_drv.c, the driver does not support atomic
modesetting:

    static const struct drm_driver driver =3D {
        .driver_features =3D DRIVER_MODESET | DRIVER_GEM,

However, drm_connector_attach_luminance_property() creates the property with
the atomic flag:

    property =3D drm_property_create_range(connector->dev, DRM_MODE_PROP_AT=
OMIC,
                                         "LUMINANCE", min, max);

Because gma500 does not advertise atomic support, drm_setclientcap() rejects
atomic client capability requests and file_priv->atomic is always false, so
drm_mode_object_get_properties() hides the property from userspace.

In addition, legacy property updates via drm_mode_obj_set_property_ioctl() =
->
set_property_legacy() dispatch to psb_intel_lvds_set_property() or
cdv_intel_lvds_set_property(), neither of which handles the luminance
property, and the atomic commit helpers that invoke
gma_connector_set_luminance() and gma_connector_disable_luminance() are nev=
er
called by this driver.

Since gma_backlight_init() also skips backlight_device_register() on this
path, is there any way for userspace to adjust panel brightness when drm
luminance is enabled?

> +
> +	{
> +		struct backlight_properties props =3D {};
> =20
> -	dev_priv->backlight_device =3D
> -		backlight_device_register(dev_priv->ops->backlight_name,
> -					  dev->dev, dev,
> -					  &gma_backlight_ops, &props);
> -	if (IS_ERR(dev_priv->backlight_device))
> -		return PTR_ERR(dev_priv->backlight_device);
> -#endif
> +		props.brightness =3D dev_priv->backlight_level;
> +		props.max_brightness =3D PSB_MAX_BRIGHTNESS;
> +		props.type =3D BACKLIGHT_RAW;
> +
> +		dev_priv->backlight_device =3D
> +			backlight_device_register(dev_priv->ops->backlight_name,
> +						  dev->dev, dev,
> +						  &gma_backlight_ops, &props);
> +		if (IS_ERR(dev_priv->backlight_device))
> +			return PTR_ERR(dev_priv->backlight_device);
> +	}
> =20
>  	return 0;
>  }
> =20
> +void gma_connector_set_luminance(const struct drm_connector_state *conn_=
state)
> +{
> +	gma_backlight_set(conn_state->connector->dev, conn_state->luminance);
> +}
> +
> +void gma_connector_disable_luminance(const struct drm_connector_state *c=
onn_state)
> +{
> +	gma_backlight_disable(conn_state->connector->dev);
> +}

[Severity: High]
Once gma_connector_disable_luminance() has been called, will subsequent cal=
ls
to gma_connector_set_luminance() fail to turn the backlight back on?

In drivers/gpu/drm/gma500/backlight.c, gma_connector_disable_luminance()
calls gma_backlight_disable(), which clears dev_priv->backlight_enabled:

    void gma_backlight_disable(struct drm_device *dev)
    {
        struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);

        dev_priv->backlight_enabled =3D false;
        dev_priv->ops->backlight_set(dev, 0);
    }

When gma_connector_set_luminance() is later called to restore or change the
brightness, it calls gma_backlight_set(), which only updates the hardware if
dev_priv->backlight_enabled is true:

    void gma_backlight_set(struct drm_device *dev, int v)
    {
        struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);

        dev_priv->backlight_level =3D v;
        if (dev_priv->backlight_enabled)
            dev_priv->ops->backlight_set(dev, v);
    }

Since nothing in gma_connector_set_luminance() or the encoder enable paths
sets dev_priv->backlight_enabled back to true (or calls
gma_backlight_enable()), won't the panel backlight remain permanently off
after the first disable?

> +
>  void gma_backlight_exit(struct drm_device *dev)
>  {
> -#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  	struct drm_psb_private *dev_priv =3D to_drm_psb_private(dev);
> =20
>  	if (dev_priv->backlight_device)
>  		backlight_device_unregister(dev_priv->backlight_device);
> -#endif
>  }

[Severity: Medium]
Can removing the preprocessor guards in gma_backlight_init() and
gma_backlight_exit() while dropping the backlight class selection in
drivers/gpu/drm/gma500/Kconfig cause unmet dependency warnings and link
failures?

First, in drivers/gpu/drm/gma500/Kconfig:

    select ACPI_VIDEO if ACPI
    select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE

Because acpi video in drivers/acpi/Kconfig depends on the backlight class
device, enabling acpi and drm luminance while the backlight class device is
disabled selects acpi video without its direct dependency.

Second, include/linux/backlight.h does not provide inline stubs for
backlight_device_register() or backlight_device_unregister() when the
backlight class device is disabled.

In gma_backlight_exit(), the call to backlight_device_unregister() is only
guarded by a runtime check on dev_priv->backlight_device, so the compiler
still emits an undefined reference to backlight_device_unregister() when the
backlight class device is disabled.

Similarly, if acpi and drm luminance are both disabled (or if gma500 is
built-in while the backlight class device is built as a module),
gma_backlight_init() and gma_backlight_exit() will fail to link against both
backlight_device_register() and backlight_device_unregister().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D13
