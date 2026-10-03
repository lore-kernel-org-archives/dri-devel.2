Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB44CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA3410E00B;
	Sat,  3 Oct 2026 01:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d/9ob2gJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7481810E00B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:33:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3516260AAF;
 Sat,  3 Oct 2026 01:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F901F00893;
 Sat,  3 Oct 2026 01:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991185;
 bh=xZfHElmJMJd+nwKyFY2kPG+X90/wuGqqhPFoMj7e7+I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d/9ob2gJTZsWXd6szLJqpLS8Mu1/QDGzZoNQEBFYDtawRlarqsSnU9uiWJRD1PKF5
 RAz6BhXMplMtMhDenDg4R5UfrD0MXPG8U1bKxka3UCTXYcZxKeIaBslqcYFI3sPcpG
 9AKYorELZmA361S/pVwQj7RCVm3xfWihsQEoSJGB5dGKBZwsuRYYwo8i/G5mBNpY0q
 EHwsUwQK+ukNN0eSGxvBP/1sLoxvW9HgL6ZfqU59drM1kuv3XmDYB8lNr7KENNqH6h
 vfDmU/XQyrRuKiAyihkadTczZ2c7nXTA3DGghE4i4fLjgR4wC2CKKphO7jgEn9pXR6
 hmUi3zMZ2MMaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] drm/panel: Add driver for Novatek NT37705 panel
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261002-fp6-panel-v3-2-4b80f83bc936@fairphone.com>
References: <20261002-fp6-panel-v3-0-4b80f83bc936@fairphone.com>
 <20261002-fp6-panel-v3-2-4b80f83bc936@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:05 +0000
Message-Id: <20261003013305.A8F901F00893@smtp.kernel.org>
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
- [High] drm/panel: resource leak in nt37705_prepare() error path
- [High] drm/panel: unsafe DSI access from backlight sysfs when panel is un=
powered
- [Medium] drm/panel: race condition and state corruption in backlight sysf=
s handler
- [Medium] drm/panel: DCS protocol violation sending extra parameters
- [Medium] drm/panel: premature exposure via devm_drm_panel_add() before DS=
C init
--

commit 512ec900afa4de1ceeb7c942bc90e389f2a7b45d
Author: Luca Weiss <luca.weiss@fairphone.com>

    drm/panel: Add driver for Novatek NT37705 panel
   =20
    Add support for the 2484x1116 AMOLED panel from BOE (BJ631JHM-T71-D900)
    bundled with a NT37705 driver IC, as found on the Fairphone (Gen. 6)
    smartphone.
   =20
    The panel can also be configured in 10-bit (RGB101010) mode, however
    currently it's configured in 8-bit (RGB888) since there's some issues in
    the Qualcomm DPU driver when driving this panel in 10-bit.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37705.c b/drivers/gpu/=
drm/panel/panel-novatek-nt37705.c
> new file mode 100644
> index 0000000000000..3cf092a1f360d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37705.c
[ ... ]
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 22);
> +
> +	return dsi_ctx.accum_err;
> +}

[Severity: Medium]
Does this code send extra parameters for zero-parameter DCS commands?

The DCS specification defines MIPI_DCS_EXIT_SLEEP_MODE (0x11) and
MIPI_DCS_SET_DISPLAY_ON (0x29) as zero-parameter commands. By appending a
0x00 argument here, the DSI core will send a DCS Short Write with 1
parameter (Data Type 0x15) instead of a DCS Short Write with 0 parameters
(Data Type 0x05).

Could this protocol violation cause the panel or DSI host to reject the
command?

> +static int nt37705_off(struct nt37705_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 120);

[Severity: Medium]
Similarly, MIPI_DCS_SET_DISPLAY_OFF (0x28) and MIPI_DCS_ENTER_SLEEP_MODE
(0x10) are also zero-parameter commands.

Should the trailing 0x00 parameter byte be removed to prevent DCS protocol
violations here as well?

[ ... ]
> +	ret =3D mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D mipi_dsi_compression_mode(ctx->dsi, true);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable compression mode: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(28); /* TODO: Is this panel-dependent? */
> +
> +	return 0;
> +}

[Severity: High]
Does this code leak the enabled regulators and leave the reset GPIO asserted
on these error paths?

If either mipi_dsi_picture_parameter_set() or mipi_dsi_compression_mode()
fails, the function returns immediately. Since the DRM framework does not
invoke unprepare() when prepare() returns an error, this skips the
regulator_bulk_disable() cleanup.

This could cause a permanent resource leak and leave the hardware powered on
in an inconsistent state.

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
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}

[Severity: Medium]
Are these non-atomic bitwise operations on dsi->mode_flags safe from race
conditions?

This sysfs handler can execute concurrently with DRM modeset operations
(such as nt37705_on()) which also modify dsi->mode_flags, potentially
causing a data race and state corruption.

Additionally, if mipi_dsi_dcs_set_display_brightness_large() fails, the
function returns early without restoring MIPI_DSI_MODE_LPM.

Could this permanently corrupt the DSI mode flags for all subsequent
sequences?

[Severity: High]
Is it safe to issue DCS writes here without verifying if the panel is
currently powered on?

The backlight sysfs node is registered in nt37705_probe() before the DSI
device is attached:

    ctx->panel.backlight =3D nt37705_create_backlight(dsi);
    ...
    return devm_mipi_dsi_attach(dev, dsi);

If userspace writes to the brightness node while the screen is off
(regulators disabled, reset asserted) or before the driver finishes
probing, it forces a DCS write to an unpowered or unattached DSI bus.

Could this cause DSI transmission timeouts or wedge the host controller?

[ ... ]
> +	ctx->panel.backlight =3D nt37705_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	ret =3D devm_drm_panel_add(dev, &ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	/* This panel only supports DSC; unconditionally enable it */
> +	dsi->dsc =3D &ctx->dsc;
> +
> +	ctx->dsc.dsc_version_major =3D 1;
> +	ctx->dsc.dsc_version_minor =3D 1;
> +
> +	/* TODO: Pass slice_per_pkt =3D 2 */
> +	ctx->dsc.slice_height =3D 12;
> +	ctx->dsc.slice_width =3D 558;

[Severity: Medium]
Is it safe to publish the panel to the system before its structural setup is
complete?

devm_drm_panel_add() is called here, immediately exposing the panel to DRM
bridge consumers. However, critical DSC configuration fields (like dsi->dsc,
slice_height, and slice_width) are initialized after this call.

If a consumer binds concurrently, could it acquire the panel and invoke
drm_panel_prepare(), triggering drm_dsc_pps_payload_pack() on uninitialized
or zeroed DSC parameters, leading to malformed payload generation or divisi=
on
by zero panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-fp6-panel-=
v3-0-4b80f83bc936@fairphone.com?part=3D2
