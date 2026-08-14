Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E63C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0CEF10E19F;
	Fri, 14 Aug 2026 18:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ieNPjSqF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D69810E02D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:23:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F36E60008;
 Fri, 14 Aug 2026 18:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FE71F000E9;
 Fri, 14 Aug 2026 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786731831;
 bh=v/9/facacx+hskzuw9utqeypEqoV31pAm6TbXvndcSg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ieNPjSqFbNYKQkGCXxL0ykEpEZTeA8DmMPkQ7DuuP4MvBd/2oKxmuhkYALiefEi+y
 P5xRBI7cYhxlLi7CgYzXEUfdNvXwDJ1DSphsDYzngIAStV3zoOjl+WSOWMAbDyhDL+
 oxHsXfDlBUrub8VRNLByWZZhiF5fdZzwpYDtV8UzlrZtYhdzo4qvDbhy/QUEQr5JnH
 HudhyuJgpBIGl1C1q40QGY6obp1G8LdzRSaD3nAT9YUly1sL+CnChORJOA9J/dhORd
 FKxuyBlwYtUEwwkTsjTz4j+kIELKMqcRLJEq6yJRj81XpDtWe7E8hfUUYCruH1LpKP
 a3kfF3CkoG8oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/panel: visionox-vtdr6130: Modularize panel config
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260814-rp6-panel-v1-3-111c1aeccf0f@gmail.com>
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-3-111c1aeccf0f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:23:50 +0000
Message-Id: <20260814182350.98FE71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Medium] Incomplete multi-mode support: `num_modes` is ignored in `vision=
ox_vtdr6130_get_modes`.
- [Medium] Physical dimensions (`width_mm` and `height_mm`) are no longer p=
opulated on the duplicated `drm_display_mode`.
- [Medium] Casting the return value of `of_device_get_match_data()` discard=
s `const`, leaving the descriptor and its function pointers in writable mem=
ory.
- [Low] Newly added fields `connector` and `bpc` are completely unused.
- [Low] Missing NULL check for the optional `init_sequence` function pointe=
r.
- [Low] The panel descriptor provides a custom `init_sequence` but lacks a =
corresponding `off_sequence`.
--

--- Patch [3]: [PATCH 3/4] drm/panel: visionox-vtdr6130: Modularize panel c=
onfig ---
commit 4c3c6a745daceb0c973dc23c581b4254bee31bfc
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: visionox-vtdr6130: Modularize panel config

This commit modularizes the visionox-vtdr6130 panel driver by introducing
a descriptor structure to hold panel-specific configurations. This prepares
the driver to support multiple panels sharing the same display driver IC.

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -19,11 +19,28 @@
> =20
>  struct visionox_vtdr6130 {
>  	struct drm_panel panel;
> -	struct drm_dsc_config dsc;
> +	struct drm_connector *connector;

[Severity: Low]
Is this connector field used anywhere else in the driver? It appears to be
declared but never utilized.

>  	struct mipi_dsi_device *dsi;
>  	struct gpio_desc *reset_gpio;
>  	struct regulator_bulk_data *supplies;
>  	enum drm_panel_orientation orientation;
> +	struct visionox_vtdr6130_desc *desc;
> +};
> +
> +struct visionox_vtdr6130_desc {
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +
> +	unsigned int bpc;

[Severity: Low]
Similar to the connector field above, is this bpc field intended for a
future patch? It is defined and initialized later but doesn't seem to be
used in the current code.

> +	unsigned int lanes;
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +
> +	const struct drm_display_mode *modes;
> +	unsigned int num_modes;
> +	int (*init_sequence)(struct visionox_vtdr6130 *ctx);
> +
> +	struct drm_dsc_config dsc;
>  };

[ ... ]

> @@ -162,7 +179,7 @@ static int visionox_vtdr6130_prepare(struct drm_panel=
 *panel)
> =20
>  	visionox_vtdr6130_reset(ctx);
> =20
> -	ret =3D visionox_vtdr6130_on(ctx);
> +	ret =3D ctx->desc->init_sequence(ctx);

[Severity: Low]
Could this cause a null pointer dereference if a future panel omits the
init_sequence callback?

Should there be a check before calling it, similar to:

	if (ctx->desc->init_sequence)
		ret =3D ctx->desc->init_sequence(ctx);

[Severity: Low]
This isn't a bug, but should the power-off sequence be abstracted as well?

Currently, visionox_vtdr6130_prepare() uses the abstracted init_sequence(),
but visionox_vtdr6130_unprepare() still relies on a hardcoded call to
visionox_vtdr6130_off().

[ ... ]

> -static const struct drm_display_mode visionox_vtdr6130_mode =3D {
> -	.clock =3D (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
[ ... ]
> -	.vtotal =3D 2400 + 20 + 2 + 18,
> -	.width_mm =3D 71,
> -	.height_mm =3D 157,
> +static const struct drm_display_mode visionox_vtdr6130_modes[] =3D {
> +	{
> +		.clock =3D (1080 + 20 + 2 + 20) * (2400 + 20 + 2 + 18) * 144 / 1000,
[ ... ]
> +		.vtotal =3D 2400 + 20 + 2 + 18,
> +	},
> +};

[Severity: Medium]
Because width_mm and height_mm were moved out of the drm_display_mode struct
definition and into the descriptor, will the duplicated mode end up with 0 =
for
its physical dimensions?

Userspace compositors might rely on these values inside the mode object to
calculate DPI.

> +static struct visionox_vtdr6130_desc visionox_vtdr6130_panel_desc =3D {

[Severity: Medium]
Should this descriptor be declared as const?

Since it contains a function pointer (init_sequence), keeping it in writable
memory provides a potential target for control-flow hijacking.

> +	.modes =3D visionox_vtdr6130_modes,
> +	.num_modes =3D ARRAY_SIZE(visionox_vtdr6130_modes),
[ ... ]
>  static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
>  				       struct drm_connector *connector)
>  {
> +	struct visionox_vtdr6130 *ctx =3D to_visionox_vtdr6130(panel);
>  	struct drm_display_mode *mode;
> =20
> -	mode =3D drm_mode_duplicate(connector->dev, &visionox_vtdr6130_mode);
> +	mode =3D drm_mode_duplicate(connector->dev, ctx->desc->modes);

[Severity: Medium]
Does this logic fully support multiple modes?

It looks like it only duplicates the first mode in the ctx->desc->modes
array, completely ignoring the ctx->desc->num_modes field. If a future panel
adds multiple modes, only the first one would be exposed to userspace here.

[ ... ]

> @@ -284,23 +325,17 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_=
device *dsi)
>  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>  				     "Failed to get reset-gpios\n");
> =20
> +	ctx->desc =3D (struct visionox_vtdr6130_desc *)of_device_get_match_data=
(dev);

[Severity: Medium]
Does casting the return value of of_device_get_match_data() discard the
const qualifier?

This API returns a const void *, which matches the suggestion to make the
descriptor struct const above.

> +	if (!ctx->desc)
> +		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-rp6-panel-=
v1-0-111c1aeccf0f@gmail.com?part=3D3
