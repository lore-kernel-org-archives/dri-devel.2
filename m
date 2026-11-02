Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0129606A330
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4K33PMX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D40210F1B7;
	Mon,  2 Nov 2026 19:31:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29AC310F1B3;
 Mon,  2 Nov 2026 19:31:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E19B442E3D;
 Mon,  2 Nov 2026 19:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894E21F00A16;
 Mon,  2 Nov 2026 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793647871;
 bh=YiO9MyvBYbe/Nku3IG5LwDkKVWLo+MtyhCLyE6mgVKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d4K33PMX/6dHle2VnfC4WRAOpPccZvO5s9RAIC+ABpeSM+6nh7MADQTFCImW9/MSp
 J3Vbvju4n2+2KwVPSRBE5Xlhna0D8wwvxO6Q5eOT0r7RAyNy151nbSCE4V9naXA9A7
 bUnBUPqRQRPr6sd+tG8R7SzzdDyseIU11OxnwQ91l6wuWQegV3pkki2Yq5gTSJAeSn
 6GAIbHzO93GmXhj0G+ubwKnIpTEtCbkTHDt/C3jq7SkELZ6uUV87NJud3Fqq4GDG/5
 t15aTkuYTflQIeX6iawjmtOOMaJ8RWgXgiHoFe9212Hd+TXQR568yXjlBDMcQAy4VY
 G17iAaEj5YeGQ==
Message-ID: <sashiko-outbox-194008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/15] drm/bridge: add PS8622 connector luminance
 support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-14-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-14-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 19:31:11 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/bridge: ps8622: ps8622_send_config() checks bl instead of lumi=
nance ops
- [Medium] drm/bridge: ps8622: Kconfig and remove() break link without back=
light class
- [Medium] drm/bridge: ps8622: ps8622_set_luminance() writes I2C when bridg=
e disabled
--

commit 1f704624e2ea918bbeb4f431e2e749044116d3f0
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/bridge: add PS8622 connector luminance support

This commit adds bridge luminance support to the Parade PS8622 driver when
CONFIG_DRM_LUMINANCE is enabled, while retaining the backlight class device
registration otherwise.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index c7da6b02d7b6b..d27e9b2485fd6 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -278,7 +278,7 @@ config DRM_PARADE_PS8622
>  	depends on OF
>  	select DRM_PANEL_BRIDGE
>  	select DRM_KMS_HELPER
> -	select BACKLIGHT_CLASS_DEVICE
> +	depends on DRM_LUMINANCE || BACKLIGHT_CLASS_DEVICE =3D y || !BACKLIGHT_=
CLASS_DEVICE
>  	help
>  	  Parade eDP-LVDS bridge chip driver.

[Severity: Medium]
Can this Kconfig dependency cause linker failures when
CONFIG_BACKLIGHT_CLASS_DEVICE is disabled or built as a module?

When CONFIG_DRM_LUMINANCE=3Dn and CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn, the
!BACKLIGHT_CLASS_DEVICE term evaluates to true, allowing
CONFIG_DRM_PARADE_PS8622 to be enabled. In that configuration,
ps8622_probe() and ps8622_remove() call backlight_device_register() and
backlight_device_unregister(), which do not have inline stubs in
include/linux/backlight.h when CONFIG_BACKLIGHT_CLASS_DEVICE=3Dn.

Furthermore, when CONFIG_DRM_LUMINANCE=3Dy and CONFIG_BACKLIGHT_CLASS_DEVIC=
E=3Dn
(or CONFIG_DRM_PARADE_PS8622=3Dy and CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm),
ps8622_remove() only guards backlight_device_unregister(ps8622->bl) with a
runtime check on ps8622->bl rather than a compile-time
!IS_ENABLED(CONFIG_DRM_LUMINANCE) check:

drivers/gpu/drm/bridge/parade-ps8622.c:ps8622_remove() {
	...
	if (ps8622->bl)
		backlight_device_unregister(ps8622->bl);
	drm_bridge_remove(&ps8622->bridge);
}

Because ps8622->bl is not a compile-time constant, the call to
backlight_device_unregister() is not eliminated and fails to link. Also,
when CONFIG_DRM_LUMINANCE=3Dn and CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm, this
expression evaluates to n and prevents building DRM_PARADE_PS8622=3Dm.

> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bri=
dge/parade-ps8622.c
> index 3a2ec482037df..229d9d7218c4e 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c

[ ... ]

> @@ -276,7 +277,7 @@ static int ps8622_send_config(struct ps8622_bridge *p=
s8622)
> =20
>  		/* FFh for 100% brightness, 0h for 0% brightness */
>  		err =3D ps8622_set(cl, 0x01, 0xa7,
> -				ps8622->bl->props.brightness);
> +				ps8622->brightness);
>  		if (err)
>  			goto error;
>  	} else {

[Severity: High]
When CONFIG_DRM_LUMINANCE is enabled, will ps8622_send_config() ever reach
this branch?

In ps8622_probe(), when use-external-pwm is not set and
CONFIG_DRM_LUMINANCE is enabled, the driver sets DRM_BRIDGE_OP_LUMINANCE on
ps8622->bridge.ops instead of calling backlight_device_register(), leaving
ps8622->bl as NULL.

However, ps8622_pre_enable() -> ps8622_send_config() still checks
ps8622->bl to choose between internal and external PWM:

drivers/gpu/drm/bridge/parade-ps8622.c:ps8622_send_config() {
	...
	if (ps8622->bl) {
		/* DPCD720, internal PWM */
		err =3D ps8622_set(cl, 0x01, 0xa5, 0xa0);
		if (err)
			goto error;

		/* FFh for 100% brightness, 0h for 0% brightness */
		err =3D ps8622_set(cl, 0x01, 0xa7,
				ps8622->brightness);
		if (err)
			goto error;
	} else {
		/* DPCD720, external PWM */
		err =3D ps8622_set(cl, 0x01, 0xa5, 0x80);
		if (err)
			goto error;
	}
	...
}

Because ps8622->bl is NULL, won't ps8622_send_config() always take the else
branch, configure register 0x01:0xa5 for external PWM (0x80) instead of
internal PWM (0xa0), and skip programming the initial brightness into
register 0x01:0xa7?

> @@ -324,6 +325,8 @@ static int ps8622_backlight_update(struct backlight_d=
evice *bl)
>  	struct ps8622_bridge *ps8622 =3D dev_get_drvdata(&bl->dev);
>  	int ret, brightness =3D backlight_get_brightness(bl);
> =20
> +	ps8622->brightness =3D brightness;
> +
>  	if (!ps8622->enabled)
>  		return -EINVAL;
> =20
> @@ -332,6 +335,15 @@ static int ps8622_backlight_update(struct backlight_=
device *bl)
>  	return ret;
>  }
> =20
> +static void ps8622_set_luminance(struct drm_bridge *bridge,
> +				 unsigned int luminance)
> +{
> +	struct ps8622_bridge *ps8622 =3D bridge_to_ps8622(bridge);
> +
> +	ps8622->brightness =3D luminance;
> +	ps8622_set(ps8622->client, 0x01, 0xa7, luminance);
> +}

[Severity: Medium]
Should ps8622_set_luminance() check ps8622->enabled before calling
ps8622_set(), just like ps8622_backlight_update() does right above it?

If ps8622_send_config() fails during ps8622_pre_enable(), ps8622->enabled
remains false while drm_atomic_helper_commit_modeset_enables() still calls:

  drm_atomic_helper_commit_luminance_enables()
    -> drm_bridge_connector_set_luminance()
      -> ps8622_set_luminance()

Similarly, if a CRTC transitions from self-refresh (where
ps8622_post_disable() has already set ps8622->enabled =3D false, disabled
v12, and asserted gpio_slp and gpio_rst) to disabled, disable_outputs()
calls:

  drm_atomic_helper_commit_luminance_disables()
    -> drm_bridge_connector_disable_luminance()
      -> ps8622_set_luminance()

Wouldn't calling ps8622_set(ps8622->client, 0x01, 0xa7, luminance) when
!ps8622->enabled attempt an I2C write while the bridge is powered down and
in reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D14
