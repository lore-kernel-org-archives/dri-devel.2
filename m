Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F95FCD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FF411AA73;
	Fri,  5 Jun 2026 18:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eTV1JzEA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C11B11AA73
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:44:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D7814321F;
 Fri,  5 Jun 2026 18:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879341F00898;
 Fri,  5 Jun 2026 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780685056;
 bh=oFhLD9vOWjoOCdFleEscPaEuQ9oYMs1ixaa4B9Qqgl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eTV1JzEAZBKsnM+ZWPIV9a1g6cyOhuFqeHA9QxHshpuq+Opr0+VYr8sqn+RJstfWd
 1Uo/0z5ReSJyQmusERN80K1UgkRks8pTFR8xCMsQs1+yyrBEXDTkbDNrvG/RJT1F2b
 TMXcu2fgqRnwEml2G05Gx4aQ4K+jvdHqqGKu1Pcf9WftzOyl/qZ+XMql8xl1+UFNJS
 KmBV+ietUfQLr/agmMj+iYKpifGIw1KdmsudU75Gb4vdsKjabDVrTon94aWOQLV582
 f0qOsZwGS6S+lINQifExg5XConFHJpzV4hbkVs4SvD0VWAFgD+KbSOaC2Rl6TDO7mw
 7ro4qLaD+XwwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
To: "Alexander Koskovich" <akoskovich@pm.me>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260605-asteroids-panel-support-v2-2-44b96c6eca91@pm.me>
References: <20260605-asteroids-panel-support-v2-2-44b96c6eca91@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:44:15 +0000
Message-Id: <20260605184415.879341F00898@smtp.kernel.org>
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
- [High] The reset GPIO is requested with `GPIOD_OUT_LOW`, which deasserts =
it and can backpower the unpowered panel.
- [High] The backlight callback modifies `dsi->mode_flags` without locking =
and permanently corrupts the state if the DSI transfer fails.
- [Low] The macro `MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT` is undefined in the=
 kernel, causing a build failure.
--

commit 3b5fdc2d207db00cc147a18d14281a4361ece19b
Author: Alexander Koskovich <akoskovich@pm.me>

drm/panel: Add driver for Raydium RM69220 DDIC

Add a panel driver for Raydium RM69220 DDIC based displays such as the
BOE BF068MWM-TD0 found in the Nothing Phone (3a).

> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69220.c b/drivers/gpu/=
drm/panel/panel-raydium-rm69220.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm69220.c

[ ... ]

> +static int raydium_rm69220_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}

[Severity: High]
Does this error path permanently corrupt the DSI mode flags?

If mipi_dsi_dcs_set_display_brightness_large() fails, the function returns
early without restoring MIPI_DSI_MODE_LPM. Userspace can trigger this easily
by writing to the backlight sysfs node while the display is powered off,
which will cause a transfer timeout. All future DSI initialization commands
will then incorrectly be sent in high-speed mode, preventing the panel from
turning back on until the system is rebooted.

[ ... ]

> +static int raydium_rm69220_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct raydium_rm69220 *ctx;
> +	int ret;

[ ... ]

> +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");

[Severity: High]
Is GPIOD_OUT_LOW the correct initialization here?

Because the reset pin is typically active-low, a logical 0 translates to
driving the physical pin HIGH. This happens at probe time before the
regulators are enabled, which can drive voltage into the panel's reset pin
while its power supplies are off. This forward-biases the panel's ESD
protection diodes, leaking current into the power plane and potentially
causing hardware damage. Should this be initialized to GPIOD_OUT_HIGH to
hold it safely in reset (0V) until power is applied?

> +
> +	ctx->dsi =3D dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes =3D 4;
> +	dsi->format =3D MIPI_DSI_FMT_RGB101010;
> +	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> +			  MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
> +			  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;

[Severity: Low]
Will this compile correctly?

The macro MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT appears to be undefined in the
upstream kernel, possibly a leftover from a vendor tree. Compiling this
driver will likely result in an undeclared identifier error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-asteroids-=
panel-support-v2-0-44b96c6eca91@pm.me?part=3D2
