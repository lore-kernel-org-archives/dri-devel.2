Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D95C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C03C10E1E1;
	Sun,  5 Jul 2026 15:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RxIU9cS5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033510E1E1
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 15:47:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5E2161389;
 Sun,  5 Jul 2026 15:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA5B1F00A3A;
 Sun,  5 Jul 2026 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783266474;
 bh=6clcRuWzyG7PDsah/V8slA2DfijCLDtMK2kx/fwmH3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RxIU9cS5kTNidthC5LnJMiddVWILXiYYdahCzMbMDh7+TxSJPrEUR983HMgTL9pcK
 iqr3k/ITF5wLAFTvToVkaIQucPPKItE1m1Lk1w7g8MSD+LhkhRo57f1/ZtekDFvn+e
 wMrxb7kfi+/XxiD0+bJZ4TdZ0kpwx8Gl95Zgn4nDJOwBrQIRoMB40Om1GTjoU70LF+
 hbOeBmAEVrgQw1c8oNuWniNdVDV+Ho+AKQD+GTCY4+7s82rnPpL1OB+joHhv57m3dW
 D8s4EbfZSOQV+f+fjX7UH8z9lpeAaj66zByR/oiV4cFiogFUnFIDtiODwPpq2KzDON
 iqcNdFOYlQmVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add Novatek NT36536 panel driver
To: "Pengyu Luo" <mitltlatltl@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260705153515.46147-3-mitltlatltl@gmail.com>
References: <20260705153515.46147-1-mitltlatltl@gmail.com>
 <20260705153515.46147-3-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 15:47:53 +0000
Message-Id: <20260705154754.0DA5B1F00A3A@smtp.kernel.org>
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
- [Medium] Missing 120ms delay after MIPI_DCS_ENTER_SLEEP_MODE before asser=
ting reset and removing power.
- [Medium] The driver ignores transmission errors from DSC-related MIPI DSI=
 multi-context commands in `novatek_prepare()`, masking failures and skippi=
ng proper hardware cleanup.
- [Medium] The backlight update_status callback races with the panel unprep=
are path, allowing DCS commands to be sent to an unpowered panel.
- [Low] Missing dependency for DRM DSC helpers in Kconfig, leading to undef=
ined references at link time.
- [Low] Explicit invocation of `drm_panel_remove()` in the error path for a=
 panel registered with `devm_drm_panel_add()`.
--

commit 51663d35dbaba4a4aee3bdfad1a94da90787d8f6
Author: Pengyu Luo <mitltlatltl@gmail.com>
Subject: drm/panel: Add Novatek NT36536 panel driver

This commit adds a new driver for Novatek NT36536 display panels.
It specifically implements support for the CSOT PP8807HB1-1 dual-link 10-bit
panel used in the LENOVO Legion Y700 Gen4.

> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -620,6 +620,17 @@ config DRM_PANEL_NOVATEK_NT36523
>  	  around the Novatek NT36523 display controller, such as some
>  	  Boe panels used in Xiaomi Mi Pad 5 and 5 Pro tablets.
> =20
> +config DRM_PANEL_NOVATEK_NT36536
> +	tristate "Novatek NT36536 panel driver"
> +	depends on OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	select DRM_KMS_HELPER

[Severity: Low]
Does this Kconfig entry need to select DRM_DISPLAY_DSC_HELPER and=20
DRM_DISPLAY_HELPER? Building this driver on a configuration that does not=20
incidentally enable CONFIG_DRM_DISPLAY_DSC_HELPER could result in a build=20
failure due to an undefined reference to drm_dsc_pps_payload_pack().

> +	help
> +	  Say Y here if you want to enable support for Novatek NT36536-based
> +	  display panels, such as the one found in the LENOVO Legion Y700
> +	  Gen4.
> +
[ ... ]
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36536.c b/drivers/gpu/=
drm/panel/panel-novatek-nt36536.c
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36536.c
[ ... ]
> +static int novatek_prepare(struct drm_panel *panel)
> +{
[ ... ]
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
> +	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
> +	mipi_dsi_msleep(&dsi_ctx, 28);
> +
> +	return backlight_enable(ctx->backlight);

[Severity: Medium]
Should the accumulated error in dsi_ctx.accum_err be checked before returni=
ng?
If any of the DSC MIPI DSI commands fail, the error is recorded but never
evaluated by novatek_prepare(). Returning the result of backlight_enable()=
=20
directly could mask failures, skip proper hardware cleanup, and leave the=20
panel in a corrupted state.

> +}
> +
> +static int novatek_off(struct mipi_dsi_multi_context *dsi_ctx)
> +{
> +	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
> +
> +	return dsi_ctx->accum_err;
> +}
> +
> +static int novatek_unprepare(struct drm_panel *panel)
> +{
[ ... ]
> +	ret =3D novatek_off(&dsi_ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	regulator_bulk_disable(ARRAY_SIZE(novatek_supplies), ctx->supplies);

[Severity: Medium]
Should there be a delay before removing power? novatek_off() sends the
MIPI_DCS_ENTER_SLEEP_MODE command, but the regulators are disabled and the=
=20
reset GPIO is asserted immediately without waiting. Removing power immediat=
ely=20
after sending Sleep In can violate the MIPI DCS specification.

> +
> +	return 0;
> +}
[ ... ]
> +static int novatek_bl_update_status(struct backlight_device *bl)
> +{
> +	struct novatek *ctx =3D bl_get_data(bl);
> +	u16 brightness =3D backlight_get_brightness(bl);
> +
> +	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
> +							 brightness);

[Severity: Medium]
Could this DCS command be sent to an unpowered panel? A user-space write to
the backlight sysfs interface can trigger novatek_bl_update_status()
asynchronously. If this happens after novatek_unprepare() has disabled the=
=20
regulators and asserted reset, it could result in DSI host timeouts or=20
display controller lockups. Should there be a check to ensure the panel is=
=20
currently prepared?

> +}
[ ... ]
> +static int novatek_probe(struct mipi_dsi_device *dsi)
> +{
[ ... ]
> +	ret =3D devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add panel\n");
> +
> +	for (i =3D 0; i < num_dsi; i++) {
> +		ctx->dsi[i]->lanes =3D desc->lanes;
> +		ctx->dsi[i]->format =3D desc->format;
> +		ctx->dsi[i]->mode_flags =3D desc->mode_flags;
> +		ctx->dsi[i]->dsc =3D &ctx->dsc;
> +		ret =3D devm_mipi_dsi_attach(dev, ctx->dsi[i]);
> +		if (ret < 0) {
> +			drm_panel_remove(&ctx->panel);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to attach to DSI host\n");

[Severity: Low]
Is the manual drm_panel_remove() call necessary here? The panel was=20
registered using the managed API devm_drm_panel_add(), which automatically=
=20
handles cleanup. Calling drm_panel_remove() explicitly on the error path=20
could cause the devres framework to execute it a second time.

> +		}
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705153515.4614=
7-1-mitltlatltl@gmail.com?part=3D2
