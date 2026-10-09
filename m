Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A074CA6018
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C7B112083;
	Fri,  9 Oct 2026 11:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="opnZqri0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B226D112083
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:43:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B8D74402E;
 Fri,  9 Oct 2026 11:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313F21F00893;
 Fri,  9 Oct 2026 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791546193;
 bh=ETZZbHSsbkFSWgkr1arGQcDGv4upEM79ITnCnEUyM2w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=opnZqri0RB9Rok9FaYkwq4v8TQs8meYHdnvzcBZ+56Pc4M/89xRFgoUxZq8aEAXF3
 BkK/+lzCsp2DQ36H95o7hlViMogjLBI6AFzIqe2qW1nPz+5HeiqJkxU1QlRSom/dl0
 0jNGhZ95x23U1wzgNTJZzW9mjDQ8OsV15rziE/8FseVcnl4rDZFb2oWEkLM1MV/iVr
 SSt9ni92YnhdHzCG4XbmwcXRnxUof3CmQ8XQNURMGLBLmtTbJw/u9CRDgdWiXCrRSw
 GMLvc+E3+CgHkUPO1gkvUPYJRTRECLIqClOdLZvvGH+q5d0NsItMdbKa+gQW3Qjkrj
 qDt+ru8uMMlsg==
Message-ID: <sashiko-outbox-165407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] drm/panel: Add driver for Novatek NT37705 panel
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261009-fp6-panel-v4-2-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
 <20261009-fp6-panel-v4-2-7c3819664778@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:43:12 +0000
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
- [High] drm/panel: missing error cleanup in nt37705_prepare() leaks regula=
tors
- [High] drm/panel: nt37705: data race and DSI timeout in backlight sysfs
- [Medium] drm/panel: dsi->mode_flags mutated and not restored on error in =
nt37705_bl_update_status()
- [Medium] drm/panel: invalid payload for 0-parameter DCS commands
- [Medium] drm/panel: nt37705: missing panel.prepared check in backlight up=
date_status
--

commit a437b7eca971b2adefff7488ccaf50028c00b068
Author: Luca Weiss <luca.weiss@fairphone.com>
drm/panel: Add driver for Novatek NT37705 panel

This commit adds support for the 2484x1116 AMOLED panel from BOE
(BJ631JHM-T71-D900) bundled with a NT37705 driver IC, as found on the
Fairphone 6 smartphone.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37705.c b/drivers/gpu/=
drm/panel/panel-novatek-nt37705.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt37705.c
> @@ -0,0 +1,396 @@
[ ... ]
> +static int nt37705_on(struct nt37705_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
[ ... ]
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_TEAR_ON);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
> +				     0x20);
> +	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x045b);
> +	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x09b3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_GAMMA_CURVE, 0x00);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0xbb0d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x04);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0xfe0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x01, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0x03, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91,
> +				     0x89, 0x28, 0x00, 0x0c, 0xd2, 0x00, 0x02,
> +				     0x2f, 0x01, 0x18, 0x00, 0x07, 0x09, 0x75,
> +				     0x08, 0x34, 0x10, 0xf0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_ON, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 22);

[Severity: Medium]
The driver issues several MIPI DCS commands that require zero parameters,
such as MIPI_DCS_EXIT_SLEEP_MODE (0x11) and MIPI_DCS_SET_DISPLAY_ON (0x29).
However, passing 0x00 as an argument to mipi_dsi_dcs_write_seq_multi()
creates a 2-byte array ({ cmd, 0x00 }). This triggers a DCS Short Write
with 1 parameter (Data Type 0x15) instead of a 0-parameter write (Data Type
0x05).=20

Similarly, earlier in this sequence, MIPI_DCS_SET_TEAR_ON takes 1 parameter=
=20
but is called with no parameters.

Could this cause strict DSI sinks to reject these malformed packets and fail
panel initialization?

> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37705_off(struct nt37705_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_OFF, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_ENTER_SLEEP_MODE, 0x00);
> +	mipi_dsi_msleep(&dsi_ctx, 120);

[Severity: Medium]
As mentioned above, MIPI_DCS_SET_DISPLAY_OFF and MIPI_DCS_ENTER_SLEEP_MODE
are also 0-parameter commands being given a 0x00 payload, creating an
incorrect DCS short write length.

> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37705_prepare(struct drm_panel *panel)
> +{
> +	struct nt37705_panel *ctx =3D to_nt37705_panel(panel);
> +	struct device *dev =3D &ctx->dsi->dev;
> +	struct drm_dsc_picture_parameter_set pps;
> +	int ret;
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(nt37705_supplies), ctx->suppli=
es);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	nt37705_reset(ctx);
> +
> +	ret =3D nt37705_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +		regulator_bulk_disable(ARRAY_SIZE(nt37705_supplies), ctx->supplies);
> +		return ret;
> +	}
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +
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

[Severity: High]
If mipi_dsi_picture_parameter_set() or mipi_dsi_compression_mode() fails
here, the function returns immediately. Earlier in this function, the
regulators are enabled and the reset GPIO is toggled. Should these error
paths also assert the reset GPIO and call regulator_bulk_disable() like
the error path for nt37705_on() does?

Since the prepare callback failed, the DRM core will not call
drm_panel_unprepare(), which leaves a permanent regulator imbalance and the
panel powered on in an inconsistent state.

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
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}

[Severity: High]
This function modifies dsi->mode_flags using non-atomic bitwise operations
without taking a lock. Since userspace can write to the sysfs brightness
node at any time, could this race with a DRM modeset where nt37705_on() or
nt37705_off() also modify the panel state? Concurrent execution could
corrupt dsi->mode_flags and lose flags like MIPI_DSI_MODE_NO_EOT_PACKET set
during probe.

[Severity: Medium]
When the panel is disabled and unprepared, its regulators are turned off.
If a write occurs to the sysfs backlight node while the panel is unprepared,
is it safe to unconditionally issue a DSI transmission via
mipi_dsi_dcs_set_display_brightness_large()?

Sending DSI DCS commands to a powered-off panel usually causes the DSI bus
to hang or timeout. Should this function check if ctx->panel.prepared is
true before attempting to communicate with the panel?

[Severity: Medium]
If mipi_dsi_dcs_set_display_brightness_large() fails, the function
returns early. Doesn't this leave the MIPI_DSI_MODE_LPM flag permanently
cleared?=20

Also, on success, it unconditionally forces the MIPI_DSI_MODE_LPM flag on,
even if it wasn't originally set. This might corrupt the panel's mode flags
and cause subsequent commands to incorrectly use or omit Low Power Mode.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-fp6-panel-=
v4-0-7c3819664778@fairphone.com?part=3D2
