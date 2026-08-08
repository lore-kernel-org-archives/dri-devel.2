Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6508AC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 19:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8601210E03F;
	Sat,  8 Aug 2026 19:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SkANJnE3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5FA10E03F
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 19:16:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09004600B1;
 Sat,  8 Aug 2026 19:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A811F000E9;
 Sat,  8 Aug 2026 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786216581;
 bh=1LmS4K9yHEjXMug7q5I5LoqiYrVPNZDYbVB2Zbvt+5o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SkANJnE36StCiQJPd2TAkuighZah7D78RyrY/0Fgam2fWD/wI8OJIrLJCi9xX1c1r
 Bohz/FlnGMgcrfif8+WZYQOyWZq4WZwj8ADMNkUAkk9QeRQYOw1mk+TRLKKIuSGpwY
 Y6Ee+tkXiU+ktpWUoEARQ53qA5QnAG7t+aBCgwpPSK62gtaRsnUNucCC3SWVfigh6r
 uL8gbCiQmucSbpDuHDc8vEyDfTHBaQoNRYSxu1d0tQ6Fsx4jEUWiljXlPWeMLCVPZu
 eXDRd03mazNlDSvx0vNyA9Yi1X1LUJ6qFhmU2LNUhMMTIRwBlh4xiRP1/CduQ/LTCi
 OiGQ4HZuvtvJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/panel: add Ilitek ILI7836A panel driver
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260808-ili7836a-v1-2-07a7becc5636@gmail.com>
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
 <20260808-ili7836a-v1-2-07a7becc5636@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:16:20 +0000
Message-Id: <20260808191621.71A811F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unbalanced panel operations due to missing .enable callback
- [High] Unsafe backlight DSI transmissions without panel power state valid=
ation
- [High] Data race on `dsi->mode_flags` between backlight updates and panel=
 state changes
- [Medium] Early return in backlight update callback leaks DSI mode state
- [Medium] The get_modes callback ignores descriptor physical attributes an=
d multiple modes
--

--- Patch [2]: [PATCH 2/2] drm/panel: add Ilitek ILI7836A panel driver ---
commit 1ef963af27698ad0874d830a6b469bf1d540bc0b
Author: Aaron Kling <webgeek1234@gmail.com>
Subject: drm/panel: add Ilitek ILI7836A panel driver

This commit introduces a new DRM panel driver for the Ilitek ILI7836A DDIC,
initially supporting the Retroid Pocket Nova panel.

> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili7836a.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
[ ... ]
> +static int ili7836a_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	struct ili7836a_panel *ctx =3D to_ili7836a_panel(panel);
> +
> +	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->modes=
);
> +}

[Severity: Medium]
Does this ignore the physical dimensions and color depth defined in nova_de=
sc?

The descriptor explicitly defines width_mm, height_mm, and bpc, but
drm_connector_helper_get_modes_fixed() only extracts a single fixed mode wi=
thout
populating the connector's physical size or color format information.
Additionally, the num_modes property in the descriptor appears to be ignore=
d.

> +static enum drm_panel_orientation ili7836a_get_orientation(struct drm_pa=
nel *panel)
> +{
> +	struct ili7836a_panel *ctx =3D to_ili7836a_panel(panel);
> +
> +	return ctx->orientation;
> +}
> +
> +static const struct drm_panel_funcs ili7836a_panel_funcs =3D {
> +	.prepare =3D ili7836a_prepare,
> +	.unprepare =3D ili7836a_unprepare,
> +	.disable =3D ili7836a_disable,
> +	.get_modes =3D ili7836a_get_modes,
> +	.get_orientation =3D ili7836a_get_orientation,
> +};

[Severity: High]
Will this leave the panel permanently black after certain display power
management transitions?

The driver implements the .disable callback which sends DCS sleep commands,
but it omits the corresponding .enable callback. Since drm_panel_enable()
will be a no-op, the panel may remain in sleep mode without a full power
cycle.

> +
> +static int ili7836a_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);

[Severity: High]
Can this cause DSI host transmission timeouts if called while the panel is
powered down?

The backlight device is accessible via sysfs independently of the panel's D=
RM
state. Writing to the brightness attribute while the panel regulators are
disabled would execute DCS writes on an unpowered DSI bus.

[Severity: High]
Is there a data race on dsi->mode_flags here?

Backlight updates can execute concurrently via sysfs while the DRM subsystem
invokes panel enable/disable operations. Since the mode_flags bitmask is
modified using non-atomic bitwise operations, a read-modify-write race
could occur between this function and the DRM ioctl paths:

ili7836a_on() {
    ...
    ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
}

ili7836a_disable() {
    ...
    ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
}

> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
If mipi_dsi_dcs_set_display_brightness_large() fails, does this early return
permanently clear the MIPI_DSI_MODE_LPM bit?

The error path exits before restoring the mode_flags, which might disrupt
subsequent DSI communication.

> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-ili7836a-v=
1-0-07a7becc5636@gmail.com?part=3D2
