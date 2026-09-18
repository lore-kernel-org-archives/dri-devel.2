Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2201BC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BC510E100;
	Fri, 18 Sep 2026 14:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k6DOMWPf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B095910E100
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:58:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7413240067;
 Fri, 18 Sep 2026 14:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C31F000FF;
 Fri, 18 Sep 2026 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789743520;
 bh=xhWMCl3OIfIy8+66BHuEFBdt6pFum38XtJWnKUOpPLg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k6DOMWPfeyxA/imgLdJSn2NgLu6t3jVOvHZkqy44/VakrulhMDmNGkCdj7sXtICyj
 VhkaHCHbtezgA5N8n6xd2gBqlOp6nB3uaink9UTxTgT1TYh6X5iQW+XTL4lQ9IYlaK
 E4k2WePwnIQ8oiAKIudBut1th8bkjFjOahTFad6q4ZDSJib5mF7NyWfUnOQH6XCHFi
 XXe+QDQHqcGpOOctgnZIAZfH0RHBlWWeA61GFy2XMBBSOSVlBkU03nolBVGRwn0xI/
 kciolR2jzqd1lKhZb/QQAWQwLZll1MoJFDM5Er1j0yJcO9H0TiT62ExG/96VNB02Tr
 tjS8XweOOPHPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for Novatek NT37705 panel
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:58:39 +0000
Message-Id: <20260918145840.0A1C31F000FF@smtp.kernel.org>
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
- [High] drm/panel: resource leak on DSI command failure in prepare
- [High] drm/panel: Use-After-Free of dangling dsi->dsc pointer
- [Medium] drm/panel: unpowered device access in backlight update
- [Medium] drm/panel: state corruption of mode_flags on error path
- [Medium] drm/panel: protocol violation via malformed DCS commands
--

commit 8f6434d0603fb1133d406bd15a56e3de3bcce821
Author: Luca Weiss <luca.weiss@fairphone.com>

drm/panel: Add driver for Novatek NT37705 panel
   =20
Add support for the 2484x1116 AMOLED panel from BOE (BJ631JHM-T71-D900)
bundled with a NT37705 driver IC, as found on the Fairphone (Gen. 6)
smartphone.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37705.c b/drivers/gpu/=
drm/panel/panel-novatek-nt37705.c
> index 0000000000000..27bd8072ccd1b
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37705.c
> @@ -0,0 +1,413 @@
[ ... ]
> +static int nt37705_on(struct nt37705_panel *ctx)
> +{
[ ... ]
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x00);

[Severity: Medium]
Are these standard zero-parameter DCS commands (Exit Sleep Mode 0x11,
Display On 0x29) intended to be transmitted with an extra 0x00 padding
byte?=20

This creates a 1-parameter short write instead of a 0-parameter short
write, which violates the MIPI DCS specification and could cause panel
controller misbehavior.

> +	mipi_dsi_msleep(&dsi_ctx, 22);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37705_off(struct nt37705_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x00);

[Severity: Medium]
Similarly, do these zero-parameter DCS commands (Display Off 0x28, Enter
Sleep Mode 0x10) need the extra 0x00 padding byte?

> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37705_prepare(struct drm_panel *panel)
> +{
[ ... ]
> +	ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> +		return ret;

[Severity: High]
Does this early return leak resources?=20

If mipi_dsi_picture_parameter_set() fails, the function returns directly
instead of jumping to a cleanup block to disable the regulators and assert
the reset GPIO, preventing subsequent recovery or clean shutdown of the
panel.

> +	}
> +
> +	ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable compression mode: %d\n", ret);
> +		return ret;

[Severity: High]
Similarly, does this early return also bypass resource cleanup?

> +	}
> +
> +	msleep(28); /* TODO: Is this panel-dependent? */
> +
> +	return 0;
> +}
[ ... ]
> +static int nt37705_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	ret =3D mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);

[Severity: Medium]
What happens if userspace modifies the sysfs brightness attribute when the
display is suspended or turned off?=20

This function appears to unconditionally initiate DSI transactions without
checking the panel's power state, which could lead to DSI bus timeouts and
potential system sluggishness depending on the DSI host implementation.

> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
If mipi_dsi_dcs_set_display_brightness_large() fails, we take this early
return path. Does this permanently disable the MIPI_DSI_MODE_LPM flag for
the DSI device?=20

If so, subsequent commands might be transmitted in the wrong mode,
potentially breaking display functionality.

> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
[ ... ]
> +static int nt37705_probe(struct mipi_dsi_device *dsi)
> +{
[ ... ]
> +	/* This panel only supports DSC; unconditionally enable it */
> +	dsi->dsc =3D &ctx->dsc;

[Severity: High]
Will this lead to a Use-After-Free on driver unbind?=20

Here we assign a pointer into the devres-managed ctx allocation to the
longer-lived mipi_dsi_device struct.

[ ... ]
> +static void nt37705_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct nt37705_panel *ctx =3D mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret =3D mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->panel);
> +}

[Severity: High]
When nt37705_remove() completes, ctx is freed by devres, leaving dsi->dsc
as a dangling pointer.=20

If the DSI host accesses dsi->dsc afterwards, this could cause a UAF.
Should dsi->dsc be set to NULL here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-fp6-panel-=
v2-0-6695c4008920@fairphone.com?part=3D2
