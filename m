Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A2606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLLG6Jy8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB64210E0CB;
	Mon,  2 Nov 2026 19:49:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8395F10E0FE;
 Mon,  2 Nov 2026 19:49:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FDB943930;
 Mon,  2 Nov 2026 19:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D905F1F00A17;
 Mon,  2 Nov 2026 19:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793648979;
 bh=m1Frm5PKuaSJfdXknwPx3XPhwyoFaTHg/OQQbyhw1Mk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DLLG6Jy8IW7WEzDfBuaA5gmZQ8mwH0TDykVSjpPkygqRRHznzQcpkEPX9I2Tpu6hW
 p9eg4AjlV0oug5XmdpdMwGC6FYlMdagbVsZVpl4M93jJgy+6A5j6nrby42aPA1vN5x
 xfhxa+oPznMugYYYUad6gHx5srXPjonsp5qdw/Xgd3XzwEVpX7hLscGXP/Of1kZnZT
 tOcj7ZpPNCN/7r3s7EiNrMJ2HL1Cx5SDGzCjm3dOwMmYa1//VWr/EHmu1ogSkfyRTt
 UxUTE8g6/tUHSxjPJhHA5ZidUKF6JbT9oO9F8xqAT2hpdGn+nqB+WGULZu1VbBfE5V
 fhJCkiPucNWqQ==
Message-ID: <sashiko-outbox-194023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/15] drm/solomon: add SSD130x connector luminance
 support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-15-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-15-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:49:38 +0000
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
- [High] drm/solomon: vmlinux link failure when BACKLIGHT_CLASS_DEVICE=3Dm
- [High] drm/solomon: contrast state desynchronization in ssd130x_set_lumin=
ance_value()
- [High] drm/solomon: unsynchronized command writes in ssd130x_set_luminanc=
e_value()
- [Medium] drm/solomon: broken Kconfig dependency for BACKLIGHT_CLASS_DEVIC=
E and DRM_LUMINANCE
- [Low] drm/solomon: duplicated contrast dispatch in ssd130xfb_bl_ops
--

commit bcc978ec95ba4732042537500fdd7f79b00e0743
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/solomon: add SSD130x connector luminance support

This commit exposes SSD130x display contrast through the DRM connector
LUMINANCE property when DRM_LUMINANCE is enabled, while guarding the legacy
backlight class registration with BACKLIGHT_CLASS_DEVICE and updating the
Kconfig dependencies.

> diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kc=
onfig
> index 400a6cab3a671..76852246eb9c2 100644
> --- a/drivers/gpu/drm/solomon/Kconfig
> +++ b/drivers/gpu/drm/solomon/Kconfig
> @@ -1,7 +1,7 @@
>  config DRM_SSD130X
>  	tristate "DRM support for Solomon SSD13xx OLED displays"
>  	depends on DRM && MMU
> -	select BACKLIGHT_CLASS_DEVICE
> +	depends on DRM_LUMINANCE || BACKLIGHT_CLASS_DEVICE =3D y || !BACKLIGHT_=
CLASS_DEVICE
>  	select DRM_CLIENT_SELECTION
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_KMS_HELPER

[Severity: High]
Can this Kconfig dependency cause a vmlinux link failure when
CONFIG_DRM_LUMINANCE=3Dy, CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm, and
CONFIG_DRM_SSD130X=3Dy?

Because DRM_LUMINANCE is a bool symbol and BACKLIGHT_CLASS_DEVICE is a
tristate symbol, when DRM_LUMINANCE=3Dy and BACKLIGHT_CLASS_DEVICE=3Dm, the
disjunction evaluates to max(y, n, m) =3D y, which allows DRM_SSD130X to be
built-in (y).

However, ssd130x_probe() in drivers/gpu/drm/solomon/ssd130x.c guards the ca=
ll
to devm_backlight_device_register() with #if
IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE), which evaluates to 1 when
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm. Built-in ssd130x.o will then call
devm_backlight_device_register() from the loadable module backlight.ko (whi=
ch
has no inline stub in include/linux/backlight.h), failing to link vmlinux.

[Severity: Medium]
Does replacing select BACKLIGHT_CLASS_DEVICE with this dependency also caus=
e a
regression when both CONFIG_DRM_LUMINANCE=3Dn and
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn?

When both options are disabled, !BACKLIGHT_CLASS_DEVICE evaluates to y,
allowing DRM_SSD130X to build with neither /sys/class/backlight nor the
connector LUMINANCE property enabled, leaving the display with no contrast
control interface at all.

In addition, on SSD132X_FAMILY panels, ssd132x_init() hardcodes
SSD13XX_CONTRAST to 0x80 and previously relied on backlight_enable() in
ssd132x_encoder_atomic_enable() to program ssd130x->contrast (127). When bo=
th
options are disabled, neither backlight_enable() nor
drm_atomic_helper_commit_luminance_enables() runs to apply ssd130x->contras=
t.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index ee43cf0da8792..aaf2b194273ba 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c

[ ... ]

> @@ -1980,8 +1985,44 @@ static int ssd130x_connector_get_modes(struct drm_=
connector *connector)
>  	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
>  }
> =20
> +static int ssd130x_set_luminance_value(struct ssd130x_device *ssd130x,
> +				       unsigned int luminance)
> +{
> +	int ret;
> +
> +	ssd130x->contrast =3D luminance;
> +
> +	switch (ssd130x->device_info->family_id) {
> +	case SSD133X_FAMILY:
> +		return ssd133x_set_contrast(ssd130x, luminance);
> +	case SSD135X_FAMILY:
> +		return ssd135x_set_contrast(ssd130x, luminance);
> +	default:
> +		ret =3D ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
> +		if (ret < 0)
> +			return ret;
> +		return ssd130x_write_cmd(ssd130x, 1, luminance);
> +	}
> +}
> +
> +static void ssd130x_connector_set_luminance(const struct drm_connector_s=
tate *conn_state)
> +{
> +	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(conn_state->connector=
->dev);
> +
> +	ssd130x_set_luminance_value(ssd130x, conn_state->luminance);
> +}
> +
> +static void ssd130x_connector_disable_luminance(const struct drm_connect=
or_state *conn_state)
> +{
> +	struct ssd130x_device *ssd130x =3D drm_to_ssd130x(conn_state->connector=
->dev);
> +
> +	ssd130x_set_luminance_value(ssd130x, 0);
> +}

[Severity: High]
Can concurrent DRM atomic commits and sysfs backlight writes interleave the
multi-byte command writes in ssd130x_set_luminance_value()?

When both CONFIG_DRM_LUMINANCE and CONFIG_BACKLIGHT_CLASS_DEVICE are enable=
d,
sysfs backlight updates invoke ssd130x_update_bl(), ssd133x_update_bl(), or
ssd135x_update_bl() under bdev->update_lock, whereas DRM atomic commits inv=
oke
ssd130x_connector_set_luminance() and ssd130x_connector_disable_luminance()
from drm_atomic_helper_commit_tail() without holding bdev->update_lock or a=
ny
shared driver lock.

In ssd130x_set_luminance_value(), ssd130x->contrast is updated without lock=
ing,
and on SSD130X_FAMILY and SSD132X_FAMILY the contrast update is sent as two
separate ssd130x_write_cmd() calls (and ssd133x_set_contrast() similarly is=
sues
multiple separate regmap writes):

	ret =3D ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
	if (ret < 0)
		return ret;
	return ssd130x_write_cmd(ssd130x, 1, luminance);

If a sysfs backlight write and a DRM atomic luminance update race between
those two regmap_write() calls, the second thread will send SSD13XX_CONTRAST
(0x81) before the first thread sends its parameter byte. Wouldn't the OLED
controller consume 0x81 as the contrast parameter for the first command, and
then interpret both threads' subsequent luminance parameter bytes as arbitr=
ary
SSD13XX_COMMAND opcodes (such as 0xae SSD13XX_DISPLAY_OFF, 0xa0/0xa1 segment
remap, or 0xc0/0xc8 COM scan direction)?

[Severity: High]
Does exposing both ssd130x->bl_dev and the connector LUMINANCE property at =
the
same time desynchronize contrast state across atomic commits and display
disable/enable cycles?

In ssd130x_probe() and ssd130x_init_modeset(), the driver registers
ssd130x->bl_dev whenever IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) is true =
and
also attaches the LUMINANCE property whenever IS_ENABLED(CONFIG_DRM_LUMINAN=
CE)
is true, unlike drivers that only register a legacy backlight device when
DRM_LUMINANCE is not used:

1. ssd130x_connector_set_luminance() updates ssd130x->contrast via
ssd130x_set_luminance_value() without updating
ssd130x->bl_dev->props.brightness, while ssd130x_update_bl(),
ssd133x_update_bl(), and ssd135x_update_bl() update ssd130x->contrast from
bl_dev->props.brightness without updating connector->state->luminance. If
brightness is changed via /sys/class/backlight, any subsequent atomic commit
including the active connector runs
drm_atomic_helper_commit_luminance_enables() and overwrites the hardware
contrast back to conn_state->luminance.

2. When disabling the display, drm_atomic_helper_commit_luminance_disables()
calls ssd130x_connector_disable_luminance() ->
ssd130x_set_luminance_value(ssd130x, 0), which clobbers ssd130x->contrast to
0, and ssd130x_encoder_atomic_disable() then calls
backlight_disable(ssd130x->bl_dev), writing contrast 0 a second time.

3. When re-enabling the display, ssd130x_encoder_atomic_enable() (and its
ssd132x, ssd133x, and ssd135x counterparts) runs before
drm_atomic_helper_commit_luminance_enables(): ssd130x_init(), ssd133x_init(=
),
and ssd135x_init() first initialize the panel with the clobbered
ssd130x->contrast (0) prior to SSD13XX_DISPLAY_ON; next,
backlight_enable(ssd130x->bl_dev) programs the stale bl_dev->props.brightne=
ss
while the display is on; and finally
drm_atomic_helper_commit_luminance_enables() calls
ssd130x_connector_set_luminance() to program conn_state->luminance.

4. If ssd130x_power_on() or ssd130x_init() fails in
ssd130x_encoder_atomic_enable() (or its ssd132x, ssd133x, or ssd135x varian=
ts)
and powers off vcc_reg, drm_atomic_helper_commit_modeset_enables() still ca=
lls
drm_atomic_helper_commit_luminance_enables() ->
ssd130x_connector_set_luminance(), issuing contrast commands over I2C/SPI to
an unpowered controller.

[ ... ]

> @@ -2015,23 +2056,13 @@ static const struct drm_driver ssd130x_drm_driver=
 =3D {
>  	.fops			=3D &ssd130x_fops,
>  };
> =20
> +#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  static int ssd130x_update_bl(struct backlight_device *bdev)
>  {
>  	struct ssd130x_device *ssd130x =3D bl_get_data(bdev);
> -	int brightness =3D backlight_get_brightness(bdev);
> -	int ret;
> -
> -	ssd130x->contrast =3D brightness;
> -
> -	ret =3D ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
> -	if (ret < 0)
> -		return ret;
> =20
> -	ret =3D ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
> +	return ssd130x_set_luminance_value(ssd130x,
> +					  backlight_get_brightness(bdev));
>  }
> =20
>  static int ssd133x_update_bl(struct backlight_device *bdev)
> @@ -2066,6 +2097,7 @@ static const struct backlight_ops ssd130xfb_bl_ops[=
] =3D {
>  		.update_status	=3D ssd135x_update_bl,
>  	},
>  };
> +#endif

[Severity: Low]
This isn't a bug, but since ssd130x_update_bl() now delegates to
ssd130x_set_luminance_value(), which already switches on
ssd130x->device_info->family_id and dispatches to ssd133x_set_contrast() and
ssd135x_set_contrast(), could ssd133x_update_bl(), ssd135x_update_bl(), and=
 the
per-family ssd130xfb_bl_ops[] array be dropped in favor of a single
backlight_ops struct using ssd130x_update_bl()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D15
