Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8610FC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBFB710F8A9;
	Fri, 25 Sep 2026 07:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PuKZ7Y9p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE1E10F8A9
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:16:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D332C6022E;
 Fri, 25 Sep 2026 07:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6271F000FF;
 Fri, 25 Sep 2026 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790320604;
 bh=tUkg9tA3npVFf8AnFIQzW6/fXHsJXe77OD/IPfdh5W8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PuKZ7Y9pBOo+2xZwTTJUf4eQg9X06MNfuSCd8f06JO+Yh6KzM8CYVlrvw/FElW+h/
 aCCaSJAYoh5jA0+rvcx/wfe1AXYzAJGqpF5oQ1q+ZRXEhrcdMzj7BJSoayYjtF7+Uf
 WeT7sFiHPVszGdYVKXUIyGrcdup3ZCXXXp4+LCrAFjdz0iythbgy1+lokrmy81rdz6
 IOYpbqkkInShgVhUi3Tf0cUY3b9LVOcFQIwIGSUQvfpquwkPMh0upaJHWcFR74Royv
 UlZoMU3wl0U8et/rTCywy5v+PhJ/N+svNk+6T9KWTa3Z3dNjv4l9W/Im2AwIasyV4D
 Hwb4Rh01KdyUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] drm/panel: visionox-vtdr6130: Add Retroid Pocket
 6 panel
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260925-rp6-panel-v2-4-19c425e523de@gmail.com>
References: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
 <20260925-rp6-panel-v2-4-19c425e523de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:16:43 +0000
Message-Id: <20260925071644.3B6271F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/panel: API misuse by passing byte-swapped brightness value
--

commit fdce0322736a51a627625ddf135b072aa86e11bd
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel

Add support for the 1080x1920 panel used in the Retroid Pocket 6.

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index 278f5acc2d661..d0db128cda819 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c

[ ... ]

> @@ -60,6 +60,82 @@ static void visionox_vtdr6130_reset(struct visionox_vt=
dr6130 *ctx)
>  	usleep_range(10000, 11000);
>  }
> =20
> +static int retroidpocket_rp6_on(struct visionox_vtdr6130 *ctx)
> +{
> +	struct mipi_dsi_device *dsi =3D ctx->dsi;
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +	struct drm_dsc_picture_parameter_set pps;
> +
> +	dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x01);
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx,
> +				     MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
> +	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0xff07);

[Severity: Medium]
Is this intentionally passing a byte-swapped value (0xff07) to work around
the core helper's LSB-first transmission?

The mipi_dsi_dcs_set_display_brightness_multi API expects a logical
brightness value, not a pre-swapped payload. If the core helper is ever
updated to correctly follow the DCS spec and transmit MSB-first, could this
panel silently break and apply a brightness of 65287 instead of the intended
0x07ff (2047)?

> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rp6-panel-=
v2-0-19c425e523de@gmail.com?part=3D4
