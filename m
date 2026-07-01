Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F82DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6D6810EEF7;
	Wed,  1 Jul 2026 11:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dHQywz4h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E2F10EEF7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:24:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0F2F4346C;
 Wed,  1 Jul 2026 11:24:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6481F00A3A;
 Wed,  1 Jul 2026 11:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782905071;
 bh=nanPuof1c8ymSBvvlFLauqbhi+CTDhvUl1IyT6FPRyY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dHQywz4hQKASSkiPLgjGgq3knIjP1bssZsbSAC9ND+j8U5TZ+9ZLYBeWea3mE2t6n
 ynK84DGJe1GBxqmAuxfkEB7uN096QcinQjQKH95g7gvKnYQu52mIb/B0OBe43cSNde
 Jo1x/KVk96ZESdiEn9Ry+2KWCyrC784wGZGmexFs+GBtQY3OMKdv+Ze9QPcHK7N9Xy
 UbNHlpdu02/YN+9cMd+CkR+zw00ffkvyCRRoqbQQ+2/KtrLqMIYaJVB0r4QOi73vFK
 0ESQnpDEf6yhVbOoMtOwPRtxAYoaxmTC6Z4EW/9VJdEyweMKSkykMEkzvR7yl9s7X2
 5jmWBNs86W5kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/panel: add Ilitek ILI7807S panel driver
To: "Arpit Saini" <arpit.saini@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-ili7807s-v4-2-c7d76d4780a5@oss.qualcomm.com>
References: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
 <20260701-ili7807s-v4-2-c7d76d4780a5@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:24:30 +0000
Message-Id: <20260701112431.3F6481F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Conflicting MIPI DCS brightness functions send payload with mismat=
ched endianness
- [High] Incorrect devres registration order causes DSI to detach before pa=
nel teardown
- [High] Unconditional DSI hardware access in backlight update callback whi=
le panel is unpowered
- [Medium] Hardcoded brightness in initialization sequence desynchronizes p=
hysical and logical state
--

commit 225e11adf3557eed6e400ee38411cadcbb543985
Author: Arpit Saini <arpit.saini@oss.qualcomm.com>
Subject: drm/panel: add Ilitek ILI7807S panel driver

Add a DRM panel driver for the DLC DLC0697 1080x1920@60Hz MIPI DSI panel ba=
sed
on the Ilitek ILI7807S display controller.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili7807s.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7807s.c
[ ... ]
> +static void dlc0697_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
> +{
[ ... ]
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x78, 0x07, 0x00);
> +	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS,=
 0x09, 0x99);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0=
x24);
> +	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x01);
> +	mipi_dsi_dcs_set_display_brightness_multi(dsi_ctx, 0x1fff);

[Severity: Medium]
Will hardcoding the brightness to 0x1fff during initialization cause the
screen to flash at maximum brightness on system resume?

The brightness will remain maxed out until the subsequent enable path trigg=
ers
a backlight update. Does it make sense to restore the user's configured
brightness level from the backlight device here instead?

[Severity: High]
Does the panel hardware expect the 16-bit brightness payload in Little Endi=
an
or Big Endian byte order?

This initialization sequence uses mipi_dsi_dcs_set_display_brightness_multi=
(),
which sends a Little Endian payload. However, the backlight update callback
ili7807s_bl_update_status() uses mipi_dsi_dcs_set_display_brightness_large(=
),
which sends a Big Endian payload:

ili7807s_bl_update_status() {
    ...
    ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
}

Since these serialize the value with opposite endianness, one of these paths
might send a corrupted value to the hardware, potentially causing incorrect
backlight levels or initialization failures.

[ ... ]
> +static int ili7807s_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);

[Severity: High]
Can a userspace process writing to the backlight sysfs brightness attribute
cause a DSI host timeout if the panel is currently asleep?

The backlight device is registered in ili7807s_probe() and exposed to users=
pace
asynchronously from the display pipeline state. Because ili7807s_bl_update_=
status()
transmits DCS commands without checking if the panel is actually powered on
(for example, by checking a prepared flag), attempting to communicate over =
the
DSI bus while unpowered can cause the host controller to wait indefinitely.

[ ... ]
> +static int ili7807s_probe(struct mipi_dsi_device *dsi)
> +{
[ ... ]
> +	ret =3D devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add panel\n");
> +
> +	return devm_mipi_dsi_attach(dev, dsi);
> +}

[Severity: High]
Could the devres registration order here cause DSI transmission errors duri=
ng
driver unbind?

Since devres actions execute in LIFO order, devm_mipi_dsi_attach() will be
undone (detaching the DSI device) before devm_drm_panel_add() is undone.
When the DRM subsystem subsequently tears down the display pipeline and
invokes the panel's unprepare callback, the DCS commands sent to power down
the panel will fail because the DSI device is no longer attached to the hos=
t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-ili7807s-v=
4-0-c7d76d4780a5@oss.qualcomm.com?part=3D2
