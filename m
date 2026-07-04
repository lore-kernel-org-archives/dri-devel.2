Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F305C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5F710E5CE;
	Sat,  4 Jul 2026 08:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rfethyqa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742BD10E573
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:32:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B9B14146F;
 Sat,  4 Jul 2026 08:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E8E1F000E9;
 Sat,  4 Jul 2026 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783153942;
 bh=fKKY8Dv+JE/FoKt6Zujr7OX1zMQyY2k8p2lCacCAgpo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RfethyqamUPXELeomq/kv117OM19xYVon64YFsfwSCAp0tIoI4crg3YlEj4gj/u11
 OyhrR2Y1T8IxuCliawoZpn12DNVWKA0e+ml4fEAT2D+FkF1Zr3l1yUUzwAFgcvGt0y
 paNcFnIrdxGzq4RjKXr2LGvvJdWNWcPlsvWEaDzmmlf12RWjkAUL8l+ejtgloTDJFw
 elInqWdhFlDucUy0HWkPggXnj4AAqwakzdmNCyiFPT4NOQQ+uZvjLhCETnLU90BkYx
 7nCA16bow/ufS5KnmnniinEZcHD/6GVqHAKeZSDA7JJDhHU+rUtDZHeHJkOrghzc7r
 xvrz35R68kQeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for Raydium RM69220 DDIC
To: "Alexander Koskovich" <akoskovich@pm.me>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260704-asteroids-panel-support-v3-2-38dc92570579@pm.me>
References: <20260704-asteroids-panel-support-v3-0-38dc92570579@pm.me>
 <20260704-asteroids-panel-support-v3-2-38dc92570579@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 08:32:22 +0000
Message-Id: <20260704083222.91E8E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The panel reset GPIO is initialized to a de-asserted state during =
probe, violating power sequencing and potentially back-powering the display=
 controller.
- [Medium] The backlight update status function permanently clears the `MIP=
I_DSI_MODE_LPM` flag on error.
--

commit ff679a020d6cdcdc5214b83056b055c35077760d
Author: Alexander Koskovich <akoskovich@pm.me>

drm/panel: Add driver for Raydium RM69220 DDIC

This patch adds a new DRM panel driver for the Raydium RM69220 display driv=
er
IC, primarily supporting the BOE BF068MWM-TD0 panel.

> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69220.c b/drivers/gpu/=
drm/panel/panel-raydium-rm69220.c
> new file mode 100644
> index 0000000000000..4fa3036c4b5fb
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

[Severity: Medium]
If mipi_dsi_dcs_set_display_brightness_large() fails here, does this return
path leave MIPI_DSI_MODE_LPM permanently cleared? It seems this might cause
all subsequent DSI commands to be sent in High Speed mode.

> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
[ ... ]
> +static int raydium_rm69220_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev =3D &dsi->dev;
> +	struct raydium_rm69220 *ctx;
> +	int ret;
[ ... ]
> +	ret =3D devm_regulator_bulk_get_const(dev,
> +					    ARRAY_SIZE(raydium_rm69220_supplies),
> +					    raydium_rm69220_supplies,
> +					    &ctx->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

[Severity: High]
Does initializing the reset GPIO to GPIOD_OUT_LOW (logically de-asserted)
during probe risk back-powering the display controller? Since the panel's
power regulators are not enabled yet, could this drive current through the
internal ESD diodes into the unpowered rails?

> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704-asteroids-=
panel-support-v3-0-38dc92570579@pm.me?part=3D2
