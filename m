Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628AC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079C110F8AB;
	Fri, 25 Sep 2026 07:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UVUkYEoK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B353810F8AB
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:15:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3E806022E;
 Fri, 25 Sep 2026 07:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569431F000FF;
 Fri, 25 Sep 2026 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790320540;
 bh=BS5CvGl2mdx4ImA8fJhT4GB/OCWxg8My9AT64GxQcys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UVUkYEoKdv4OdrN16HJ+70sWe21hfI4W520QivcjDV/YD4GZceHkcYbFl+GzdFbth
 GIKl5T4+tlpnr+viloyRn+PMrbN88POxeTczS0pLTTpYEA51Zv/SexiepvIeQQawqh
 St2OQ3tz6U+v1gV71XHizyMGiYeZahEN8rxe9D2xEcPptVL9XgshNh3ZYMw771oE5/
 bqkhfGD14sdoNHpm4aeW7wE4REGz1AsGNpt/sMorrG7U+v9YDQK2DOp56S5rMStR/U
 /WeWhC/Tw7JTN8II3Dvd6LhRcKSdwxxmQtIamGUSgEzbPlV3OsHjieltNbJa4Q9I6a
 pmrcmmTiy+pvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] drm/panel: visionox-vtdr6130: Modularize panel
 config
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260925-rp6-panel-v2-3-19c425e523de@gmail.com>
References: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
 <20260925-rp6-panel-v2-3-19c425e523de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:15:39 +0000
Message-Id: <20260925071540.569431F000FF@smtp.kernel.org>
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
- [High] drm/panel: shared global state mutation in DSC config
- [Medium] drm/panel: ignores num_modes and drops all but first display mode
- [Low] drm/panel: unused bpc field in panel descriptor
--

commit 9e3a1ea8fd3c45699472995a794b6b527ce2a3ff
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: visionox-vtdr6130: Modularize panel config
   =20
The vtdr6130 is a DDIC, a common chip that is used by multiple panels.
Prepare the driver for more panels.

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index b66d6c7128c75..278f5acc2d661 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
[ ... ]
> @@ -200,24 +213,48 @@ static int visionox_vtdr6130_unprepare(struct drm_p=
anel *panel)
[ ... ]
> +static struct visionox_vtdr6130_desc visionox_vtdr6130_panel_desc =3D {
> +	.modes =3D visionox_vtdr6130_modes,
> +	.num_modes =3D ARRAY_SIZE(visionox_vtdr6130_modes),
> +	.bpc =3D 8,

[Severity: Low]
Does this code forget to propagate the bpc field? It looks like this field
is initialized here but never assigned to connector->display_info.bpc in the
visionox_vtdr6130_get_modes() callback.

> +	.lanes =3D 4,
> +	.format =3D MIPI_DSI_FMT_RGB888,
> +	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> +		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.init_sequence =3D visionox_vtdr6130_on,
> +	.dsc =3D {
> +		.dsc_version_major =3D 0x1,
> +		.dsc_version_minor =3D 0x2,
> +		.slice_height =3D 40,
> +		.slice_width =3D 540,
> +		.slice_count =3D 2,
> +		.bits_per_component =3D 8,
> +		.bits_per_pixel =3D 8 << 4,
> +		.block_pred_enable =3D true,
> +	},
>  };
> =20
>  static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
>  				       struct drm_connector *connector)
>  {
> +	struct visionox_vtdr6130 *ctx =3D to_visionox_vtdr6130(panel);
>  	struct drm_display_mode *mode;
> =20
> -	mode =3D drm_mode_duplicate(connector->dev, &visionox_vtdr6130_mode);
> +	mode =3D drm_mode_duplicate(connector->dev, ctx->desc->modes);

[Severity: Medium]
Will this silently drop display modes if the panel has more than one?
Calling drm_mode_duplicate() directly on ctx->desc->modes without a loop
ignores ctx->desc->num_modes, which means only the first mode in the array
gets registered.

>  	if (!mode)
>  		return -ENOMEM;
> =20
[ ... ]
> @@ -321,17 +358,11 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_=
device *dsi)
>  		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>  				     "Failed to get reset-gpios\n");
> =20
> +	ctx->desc =3D (struct visionox_vtdr6130_desc *)of_device_get_match_data=
(dev);

[Severity: High]
Does casting away const from of_device_get_match_data() create a risk of
global state corruption?

By embedding the dsc configuration in a static global struct and pointing
dsi->dsc to it:

	dsi->dsc =3D &ctx->desc->dsc;

it gets passed to the DSI host controller. Later, the
drm_dsc_compute_rc_parameters() function mutates dsi->dsc in-place.
Because it's a shared global struct, this can lead to data races and
corruption if multiple panels exist.

Should the dsc config be copied into per-instance data instead, and the
descriptor be made static const?

> +	if (!ctx->desc)
> +		return -ENODEV;
> +
>  	ctx->dsi =3D dsi;
>  	mipi_dsi_set_drvdata(dsi, ctx);
> =20
> -	ctx->dsc.dsc_version_major =3D 0x1;
> -	ctx->dsc.dsc_version_minor =3D 0x2;
> -	ctx->dsc.slice_height =3D 40;
> -	ctx->dsc.slice_width =3D 540;
> -	ctx->dsc.slice_count =3D 2;
> -	ctx->dsc.bits_per_component =3D 8;
> -	ctx->dsc.bits_per_pixel =3D 8 << 4;
> -	ctx->dsc.block_pred_enable =3D true;
> -
> -	dsi->dsc =3D &ctx->dsc;
> -	dsi->lanes =3D 4;
> -	dsi->format =3D MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
> -			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	dsi->dsc =3D &ctx->desc->dsc;
> +	dsi->lanes =3D ctx->desc->lanes;
> +	dsi->format =3D ctx->desc->format;
> +	dsi->mode_flags =3D ctx->desc->mode_flags;
>  	ctx->panel.prepare_prev_first =3D true;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rp6-panel-=
v2-0-19c425e523de@gmail.com?part=3D3
