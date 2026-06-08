Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCE0CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2530210F722;
	Mon,  8 Jun 2026 16:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kTjXo7Fg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622A910F722
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9F72601E6;
 Mon,  8 Jun 2026 16:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBAA1F00893;
 Mon,  8 Jun 2026 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936767;
 bh=ICG6hewedWOwG5e8SNGz6l8qRIMctSufBqI583I7OFo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kTjXo7FgmR9YFGBIWzzL4n0lyvDCtVNSqLtKTKxtqZyppWyafLx4Xqx7VZ7B+Vzoq
 TBSbdCO02v66BnwVDOIF1aVQIy3IuEtvjI7DJxz/lBsVjmofPr+dVqRymMs/APz0Kl
 vDWfmNd573qHT1N2jC5bQTWryhFdoZrlBza1Y/4MvrNHux1Dy5XyX64mX/SBDRUSeD
 JEPuPzgRdQ6oPpatqCkQi7D4mmry7/MG8ueiKWRCW5iEP/k0eS3J1Q04yv8n6cZ/eE
 HMNMmeU1DHdit0bICVfSAWkja5WvAmK9ypGtNTNDG61S3mFlH/Qo25TXXPxsLDn53d
 5JDxRwamTFHpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/panel: himax-hx83121a: pass the panel pointer
 when creating BL
To: "Icenowy Zheng" <zhengxingda@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260608162622.403713-2-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-2-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:39:26 +0000
Message-Id: <20260608163927.3EBAA1F00893@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing device link to secondary DSI host can lead to Use-After-Fr=
ee if the host driver is unbound.
- [High] The backlight device is exposed to userspace before the DSI device=
 is attached to the host, allowing premature DCS transfers.
- [High] Unprotected MIPI DSI hardware access due to missing backlight disa=
ble allows DCS commands to a powered-off panel.
--

commit 4b6dd00d8fec3ba9b10693589e0413bbbce2ec2f
Author: Icenowy Zheng <zhengxingda@iscas.ac.cn>

drm/panel: himax-hx83121a: pass the panel pointer when creating BL

This commit modifies the backlight creation function to accept the entire
panel context instead of just the DSI device. This prepares the driver for
future backlight powering on/off support.

> diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/d=
rm/panel/panel-himax-hx83121a.c
> index bed79aa06f46a..1a7e0125bced8 100644
> --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> @@ -193,10 +193,11 @@ static const struct drm_panel_funcs himax_panel_fun=
cs =3D {
> =20
>  static int himax_bl_update_status(struct backlight_device *bl)
>  {
> -	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	struct himax *ctx =3D bl_get_data(bl);
>  	u16 brightness =3D backlight_get_brightness(bl);
>  	/* TODO: brightness to raw map table */
> -	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
> +							 brightness);

[Severity: High]
This isn't a bug introduced by this patch, but does this function leave the
MIPI DSI hardware vulnerable to unprotected access?

Because ctx->backlight is not assigned to ctx->panel.backlight during
probe, the DRM core does not automatically manage its state. In
himax_unprepare(), the panel's regulators are disabled and the reset GPIO
is asserted, but there is no corresponding backlight_disable() call.

If userspace writes to the backlight sysfs interface after the panel is
powered off, this function will unconditionally send DCS commands via
mipi_dsi_dcs_set_display_brightness_large() to the off panel. This
typically causes the MIPI DSI host to experience transfer timeouts and
potential hardware errors.

[ ... ]

> @@ -646,7 +647,7 @@ static int himax_probe(struct mipi_dsi_device *dsi)
>  	ctx->panel.prepare_prev_first =3D true;
> =20
>  	if (desc->has_dcs_backlight) {
> -		ctx->backlight =3D himax_create_backlight(to_primary_dsi(ctx));
> +		ctx->backlight =3D himax_create_backlight(ctx);

[Severity: High]
This is a pre-existing issue, but does himax_create_backlight() expose the
device to userspace too early?

In himax_probe(), this registers the backlight device and immediately expos=
es
its sysfs interface. However, this happens before devm_mipi_dsi_attach() is
called later in the probe routine.

If userspace writes to the brightness attribute in this window,
himax_bl_update_status() could send DCS commands over the MIPI DSI bus
before the hardware is actually attached to the host, which could result in
transfers on uninitialized hardware.

[Severity: High]
This is also a pre-existing issue, but does himax_probe() need to establish
a device link to the secondary DSI host?

Earlier in himax_probe(), the secondary DSI host is looked up and the
device is created:

    dsi1_host =3D of_find_mipi_dsi_host_by_node(dsi1);
    ...
    ctx->dsi[1] =3D devm_mipi_dsi_device_register_full(dev, dsi1_host, &dsi=
_info);

Without establishing a device link (e.g., using device_link_add()) to
ensure proper driver unbind synchronization, if the secondary DSI host driv=
er
is unbound, its mipi_dsi_host and the associated DSI device are unregistered
and freed.

Since the panel driver remains bound and retains ctx->dsi[1], a subsequent
DCS command or modeset could access this freed memory, leading to a
use-after-free.

>  		if (IS_ERR(ctx->backlight))
>  			return dev_err_probe(dev, PTR_ERR(ctx->backlight),
>  					     "Failed to create backlight\n");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608162622.4037=
13-1-zhengxingda@iscas.ac.cn?part=3D2
