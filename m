Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D82CD8CA8
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 00:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C854710E157;
	Mon, 15 Jun 2026 00:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FSSoE0Nb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B30110E157
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7E2343251;
 Mon, 15 Jun 2026 00:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D71F000E9;
 Mon, 15 Jun 2026 00:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781482682;
 bh=D0M6Ucn4o06rLjKqLhPXilHkISXTrNCsJAeIkz6Dk0o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FSSoE0NbVKD8FYDkOiD6TUB+u0URe5FE+w2ViPNTf/lkc4ZDu1Q9d8k48eYxuTMJV
 p0HaocCwEZipfl6mXpBXW/UueZcqraJ2jgx/RE1XXT6JEVgRMH0R9UgMSqXxxBg5Yl
 x5xJ31nYnnicfv0o2Qv2RB1PuYZ34I41KG2nFXV7ow7nuwU8Mj7a9sm62iAR1iXW+l
 ksiklASJVyOznujQ5cjpM0KnfPbmE5gqoaLIZ+eLLQ+/F9whqKr7s0gwfxuvb67A2Q
 KarNjbcTXcpyw7SfK72QFsgq8HSzQ6ISLF5WJ2a7AbVBLQGxWnsql4Mbm+8QYb8hm1
 eSXGoyX2+N7vA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm: panel: Add LG LH609QH1 Panel with SW49410
 controller
To: "Paul Sajna" <sajattack@postmarketos.org>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260614-judyln-panel-v3-1-07f4134441bd@postmarketos.org>
References: <20260614-judyln-panel-v3-1-07f4134441bd@postmarketos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:18:02 +0000
Message-Id: <20260615001802.982D71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing `drm_panel_remove()` in the `mipi_dsi_attach()` error path=
 causes a global list corruption and Use-After-Free.
- [High] DSI commands are sent while the panel is held in reset in `sw49410=
_panel_unprepare()`.
- [Medium] Misplaced `MIPI_DSI_MODE_LPM` flag manipulation around a softwar=
e memory packing function.
- [Medium] The panel is published to the system before its DSC configuratio=
n is fully initialized.
--

commit 1a6b069af275d9965692f4acaa02ebd1a8517da9
Author: Amir Dahan <system64fumo@tuta.io>
Subject: drm: panel: Add LG LH609QH1 Panel with SW49410 controller

This commit adds a new panel driver for the LG SW49410 controller used
in the LG G7 ThinQ. It configures the panel, sets up the DSI commands,
and initializes the DSC parameters.

> diff --git a/drivers/gpu/drm/panel/panel-lg-sw49410.c b/drivers/gpu/drm/p=
anel/panel-lg-sw49410.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lg-sw49410.c

[ ... ]

> +static int sw49410_panel_program(struct sw49410_panel *ctx)
> +{

[ ... ]

> +	ctx->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +
> +	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
> +
> +	ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);

[Severity: Medium]
Does this code incorrectly clear and restore the MIPI_DSI_MODE_LPM flag?

The drm_dsc_pps_payload_pack() function merely formats a local structure
in memory and performs no hardware DSI transactions, so manipulating DSI
hardware transmission flags around it seems unnecessary.

By restoring the flag immediately after packing, does it cause the
subsequent mipi_dsi_picture_parameter_set_multi() call to execute in Low
Power Mode rather than the intended High Speed mode?

[ ... ]

> +static int sw49410_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct sw49410_panel *ctx =3D to_sw49410_panel(panel);
> +
> +	gpiod_set_value(ctx->reset_gpio, 1);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
> +
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);

[Severity: High]
Is it intentional to assert the reset GPIO before sending the sleep
commands?

Because the display controller is held in hardware reset, it cannot receive
or process the display off and sleep commands, which could cause the DSI
host's transmissions to fail or time out.

Looking further down in this function, the reset GPIO is asserted a second
time, which suggests this first call might be misplaced.

[ ... ]

> +static int sw49410_panel_probe(struct mipi_dsi_device *dsi)
> +{

[ ... ]

> +	drm_panel_add(&ctx->panel);
> +
> +	/* This panel only supports DSC; unconditionally enable it */
> +	dsi->dsc =3D &ctx->dsc;
> +
> +	ctx->dsc.dsc_version_major =3D 1;
> +	ctx->dsc.dsc_version_minor =3D 1;

[Severity: Medium]
Could this cause a race condition where a concurrently probing display
driver reads uninitialized DSC settings?

Since drm_panel_add() makes the panel visible globally, another driver
could find it before the DSC parameters like slice_width and
bits_per_component are fully populated.

Should drm_panel_add() be called as the final step of initialization?

[ ... ]

> +	ctx->dsc.slice_count =3D 1440 / ctx->dsc.slice_width;
> +	ctx->dsc.bits_per_component =3D 8;
> +	ctx->dsc.bits_per_pixel =3D 8 << 4; /* 4 fractional bits */
> +	ctx->dsc.block_pred_enable =3D true;
> +
> +	return mipi_dsi_attach(dsi);
> +}

[Severity: High]
Does returning the error from mipi_dsi_attach() without calling
drm_panel_remove() leave a dangling pointer in the global panel list?

If mipi_dsi_attach() fails, the probe function returns the error directly.
Because the panel context is allocated via devm_drm_panel_alloc(), it will
be automatically freed by the driver core.

However, since drm_panel_add() was already called, this freed memory would
remain linked in the global DRM panel list, leading to a use-after-free
the next time the list is traversed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-judyln-pan=
el-v3-0-07f4134441bd@postmarketos.org?part=3D1
