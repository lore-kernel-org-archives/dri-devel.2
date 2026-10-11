Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7E5CA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACA910E237;
	Sun, 11 Oct 2026 12:04:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K8Ycmk5V";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F1710E237
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 12:04:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49A4F4128B;
 Sun, 11 Oct 2026 12:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216F1F0089C;
 Sun, 11 Oct 2026 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791720276;
 bh=+6X75983Jhxd5TuPC2cPCEOCJ+Bg55ldHZ0/k66h+AQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K8Ycmk5VidjLgZVAnZ5Or8u1in8NTXTOf9Af2+zcTGwNROycrbWix4ILChWxVXyj+
 sJTvad6W7whtvsQ2i4zOVuOP0tN8EK14RMxNUYhpLGUvT02vAKiAEa/ydxWtW1idJT
 KN1c59RmJg+ATZFrHL5/7wnGgO1Wp3T/MK3DOkg+pd/ZWv4lYvRy8AZXk4gdhIx4Ff
 L2nYEovmtGcQrPU6csirzAb2pZdRp0T73wD9Eo9BxQXEaV4N8r7B4VjtJy7XeCqexo
 IVmEPymoiB4fP4q4ugOBtSOnW+LWExQ8W5PFHgAcD6CDOuV4Wpf3m27momSfXuLsHj
 S+EwKXn0nD1Zw==
Message-ID: <sashiko-outbox-167211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] drm/panel: novatek-nt36672a: Add Tianma panel
 for Xiaomi Mi A2
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261011-nt36672a-panels-v3-7-9ea238627f8a@minlexx.ru>
References: <20261011-nt36672a-panels-v3-0-9ea238627f8a@minlexx.ru>
 <20261011-nt36672a-panels-v3-7-9ea238627f8a@minlexx.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:04:35 +0000
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
- [Medium] drm/panel: nt36672a: regulator leak in nt36672a_panel_prepare() =
error path
--

commit 55c52ad322748f420246cd3fb678326e61c47140
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

    drm/panel: novatek-nt36672a: Add Tianma panel for Xiaomi Mi A2
   =20
    Add support for Tianma TL060FVXS16-00 video mode panel based on
    Novatek NT36672A, used in Xiaomi Mi A2 smartphone (xiaomi-jasmine).
    It shares some code with already supported panel in this driver
    for xiaomi-lavender, so we can reuse the same panel deinit function.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index d356348d39608..48dff2279b0e9 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
[ ... ]
> @@ -552,6 +575,39 @@ static const struct nt36672a_panel_desc tianmaplus_e=
7t_tulip_panel_desc =3D {
>  	.send_deinit_cmds =3D lavender_tulip_deinit_cmds,
>  };
> =20
> +static const struct drm_display_mode tianma_jasmine_panel_default_mode =
=3D {
[ ... ]
> +static const struct nt36672a_panel_desc tianma_jasmine_panel_desc =3D {
> +	.display_mode =3D &tianma_jasmine_panel_default_mode,
> +
> +	.width_mm =3D 68,
> +	.height_mm =3D 136,
> +
> +	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +	.format =3D MIPI_DSI_FMT_RGB888,
> +	.lanes =3D 4,
> +	.send_init_cmds =3D tianma_jasmine_init_cmds,

[Severity: Medium]
If sending the initialization commands fails in nt36672a_panel_prepare(), d=
oes
this code leak the regulator resources?

Looking at nt36672a_panel_prepare(), it calls nt36672a_panel_power_on() whi=
ch
enables the regulators, and then calls send_init_cmds():

drivers/gpu/drm/panel/panel-novatek-nt36672a.c:nt36672a_panel_prepare() {
	...
	dsi_ctx.accum_err =3D nt36672a_panel_power_on(pinfo);

	/* send init cmds */
	if (pinfo->desc->send_init_cmds)
		pinfo->desc->send_init_cmds(&dsi_ctx);

	if (dsi_ctx.accum_err < 0)
		gpiod_set_value(pinfo->reset_gpio, 0);

	return dsi_ctx.accum_err;
}

If send_init_cmds() fails, the error path returns early without calling
nt36672a_panel_power_off() or regulator_bulk_disable().

Furthermore, because drm_panel_prepare() sees a failure, it does not set
panel->prepared =3D true. Consequently, any future call to drm_panel_unprep=
are()
will return early and skip calling the panel's .unprepare function, leaving
the regulators (vddio, vddpos, vddneg) permanently enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-nt36672a-p=
anels-v3-0-9ea238627f8a@minlexx.ru?part=3D7
