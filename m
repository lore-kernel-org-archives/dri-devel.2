Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F6C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B579810E2C9;
	Thu,  2 Jul 2026 09:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLh4SkpK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1206A10E2C9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:51:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7807C60122;
 Thu,  2 Jul 2026 09:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B01F00A3A;
 Thu,  2 Jul 2026 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782985884;
 bh=BLkxOlRGq6e0nx77zhS8+swIaGWbcDYB2PxoNZ/HSZk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mLh4SkpKNjg5JAu9u444PWjv8a5FJPIluOu02Q540Hl+EYekKlzBPfS/QWVAE5OzI
 qH1PTKt5y3ujF6lrcmSqgbDQ3FOSSe/h+3QuEIlwq/yHg4Vz7U9TZ9Vq/ZafseV9y7
 8XXinOnggRRdhQScismsc7hHPcApoFYhw8r/DVsV8H4nxBJRwTmiGP2Dfoa20HPyDj
 QTB9gCaJqrCQoHiBILBIJGfZVz4r2eowag29yYiuvKAUc1VDHXw8ZqoG02fVJVBcfn
 PX7QxFxsVemw5SxK43mv4LZAXCCWT7roa89b4UHHMZ1fG/ui/076SxCE/hEYj7/MM+
 U41OcEOC7A+4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/panel: Enable DSC for Visionox VTDR6130 panel
To: "Neil Armstrong" <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-topic-sm8x50-vtdr6130-dsc-v3-1-db881a3fc026@linaro.org>
References: <20260702-topic-sm8x50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org>
 <20260702-topic-sm8x50-vtdr6130-dsc-v3-1-db881a3fc026@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:51:23 +0000
Message-Id: <20260702095124.033B01F00A3A@smtp.kernel.org>
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
- [High] Dangling pointer `dsi->dsc` causes a Use-After-Free if the panel i=
s unbound or fails to probe.
- [Low] Typo in Kconfig keyword (`selecy` instead of `select`) causes Kconf=
ig syntax errors and unmet dependencies.
--

commit e86a9d725d9bec9f842cd9809e7110af265ae958
Author: Jun Nie <jun.nie@linaro.org>
Subject: drm/panel: Enable DSC for Visionox VTDR6130 panel

This commit enables display compression (DSC v1.2) for the 1080x2400 Vision=
ox
VTDR6130 AMOLED DSI panel. It configures the DSC parameters during probe and
sends the PPS payload when turning on the display.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index c0cc2bb4a3eb7..d4e6535f35957 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -1352,6 +1352,8 @@ config DRM_PANEL_VISIONOX_VTDR6130
>  	depends on OF
>  	depends on DRM_MIPI_DSI
>  	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_DISPLAY_DSC_HELPER
> +	selecy DRM_DISPLAY_HELPER

[Severity: Low]
This isn't a bug, but is there a typo here with "selecy" instead of "select=
"?
This will cause a Kconfig syntax error and leave dependencies unmet.

[ ... ]

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index 97a79411e1ecd..0cdcdbbc766da 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c

[ ... ]

> @@ -269,6 +277,16 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_d=
evice *dsi)
>  	ctx->dsi =3D dsi;
>  	mipi_dsi_set_drvdata(dsi, ctx);
> =20
> +	ctx->dsc.dsc_version_major =3D 0x1;
> +	ctx->dsc.dsc_version_minor =3D 0x2;
> +	ctx->dsc.slice_height =3D 40;
> +	ctx->dsc.slice_width =3D 540;
> +	ctx->dsc.slice_count =3D 2;
> +	ctx->dsc.bits_per_component =3D 8;
> +	ctx->dsc.bits_per_pixel =3D 8 << 4;
> +	ctx->dsc.block_pred_enable =3D true;
> +
> +	dsi->dsc =3D &ctx->dsc;

[Severity: High]
Does this code leave a dangling pointer if the probe function fails later o=
r=20
if the driver is unbound?

In visionox_vtdr6130_probe(), dsi->dsc is assigned to &ctx->dsc, where ctx
is allocated using devm_drm_panel_alloc(). If devm_drm_panel_add() or
devm_mipi_dsi_attach() fail later in the probe function, or if the panel
driver is unbound via sysfs, devres will automatically free ctx.

However, since the mipi_dsi_device outlives the panel driver binding, dsi->=
dsc
is never cleared and becomes a dangling pointer. If the DSI subsystem or ho=
st
driver attempts to use it, it could result in a use-after-free.

Should dsi->dsc be explicitly cleared in the probe error paths and in a
driver remove callback?

>  	dsi->lanes =3D 4;
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
>  	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-topic-sm8x=
50-vtdr6130-dsc-v3-0-db881a3fc026@linaro.org?part=3D1
