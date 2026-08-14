Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21769C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 18:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E87D10E582;
	Fri, 14 Aug 2026 18:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z7FFKB6Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8A510E582
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 18:26:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00B76600AF;
 Fri, 14 Aug 2026 18:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE811F000E9;
 Fri, 14 Aug 2026 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786732002;
 bh=yqVBX9HcgDDXUNOOTVy5kUaTr4zgNKKoIzW6AFhVYZk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z7FFKB6QkTx5qVYEyx9lt1G8MOZzyb5WbQh/QpnGqSwQmeWgZHseDvobF/2RLGWSy
 lOdYQJsLSjvjRhO7Nk8wKiLOFzEDPjPsCZcJTFR14lfaSkBPEioovVcZztIbYp/QzP
 bvspLd0U/DGb+SuFW1pnhJYyBiVw6bFkz6X23xdGEy9I1TSeqGULgkZh+EVQCYsilk
 4qrEufdR1cK5GKUszDwEpQcGvBrOzfDVDi++rXO44c+s3x0ussx+pk5VBiNEMCAkVP
 U7jq5Zlo8LCSP2WOKwaxbFT0eM1qAg185Le2VGFGPTVqpHXFuhaD92W5omMGgT1ORs
 hrEXEj0UQ20gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/panel: visionox-vtdr6130: Add Retroid Pocket 6
 panel
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260814-rp6-panel-v1-4-111c1aeccf0f@gmail.com>
References: <20260814-rp6-panel-v1-0-111c1aeccf0f@gmail.com>
 <20260814-rp6-panel-v1-4-111c1aeccf0f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:26:41 +0000
Message-Id: <20260814182642.5BE811F000E9@smtp.kernel.org>
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
- [Medium] The panel initialization sequence uses a byte-swapped magic numb=
er (`0xff07`) to set display brightness, exploiting the little-endian behav=
ior of `mipi_dsi_dcs_set_display_brightness_multi` to send a big-endian seq=
uence.
--

--- Patch [4]: [PATCH 4/4] drm/panel: visionox-vtdr6130: Add Retroid Pocket=
 6 panel ---
commit 2ba31f55071d4cfd213a7bfcbe0e2720a74312ac
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel

This commit adds support for the 1080x1920 panel used in the Retroid
Pocket 6 handheld console.

> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gp=
u/drm/panel/panel-visionox-vtdr6130.c
> index 805c9846c2a0b..5c826f95ec478 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c

[ ... ]

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
Is this intentionally passing a byte-swapped magic number (0xff07) to
compensate for mipi_dsi_dcs_set_display_brightness_multi() sending the
brightness value LSB-first?

The DCS specification requires the brightness parameter to be MSB-first. By
passing 0xff07, it appears this code intentionally sends 0x07 followed by
0xff so the panel receives 0x07ff (2047) MSB-first.

If the core helper is ever corrected to comply with the DCS specification,
this sequence will send 0xff followed by 0x07, which the panel will interpr=
et
as 0xff07 (65287), drastically exceeding the intended brightness.

Should this instead send the raw bytes explicitly using
mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
0x07, 0xff) to avoid depending on the helper's current endianness behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-rp6-panel-=
v1-0-111c1aeccf0f@gmail.com?part=3D4
