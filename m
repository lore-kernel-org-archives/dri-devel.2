Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA14CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8B111201A;
	Wed, 14 Oct 2026 13:59:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFA711201A
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:59:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CEDAB409B7;
 Wed, 14 Oct 2026 13:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880B61F00A30;
 Wed, 14 Oct 2026 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791986342;
 bh=8bHpkCEI04uNIGwJz7JE3TxYpE/6no/otX8UXR3dFeI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ag3UfxCzQoTtCXnLYDh+l1DKDIJd7MxSdK+S8y1cHuLxbTfgt4mMFkJsJWdOGQbg3
 GsAuCANcGmu9a9Q/d+tfX7xsBswKX9ke30hdmTEBhkh6xe4DcbXObIlcKc/uNNTNMc
 hGH6gEUBt8N2sM0WAqWOycWGGNYKfRYUzAZMVynQ1qb9PdMjcYsdiA4dYU8lr7PRtK
 G/Y9sGvx5+ZMf2Ns7RJrPIAqkCImZVsDMZuhSrJipEhhN+SMdQ8SlQ5Qjlm0HkPxRM
 C0U6ErbA1UscmIZJV4XeaWHcGAHdFJicAkxIBYFL6LUFGaoG/Tmk9hME2kNg6c7nnO
 2E7aoJJScPqBg==
Message-ID: <sashiko-outbox-171393@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi()
 functions
To: "Hsieh Hung-En" <hungen3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014135028.1438841-3-hungen3108@gmail.com>
References: <20261014135028.1438841-1-hungen3108@gmail.com>
 <20261014135028.1438841-3-hungen3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:59:02 +0000
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
- [Medium] drm/panel: resource leak in rm68200_prepare() on error path
--

commit c6e53b42c5c0d14746a1b84a032e5221f6e17711
Author: Hsieh Hung-En <hungen3108@gmail.com>

drm/panel: raydium-rm68200: Use mipi_dsi_*_multi() functions

This patch replaces the deprecated MIPI DSI DCS helpers with their multi
variants in the raydium-rm68200 panel driver. It utilizes mipi_dsi_msleep to
skip delays after failed commands and defers error return to the end of the
prepare sequence.

> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/=
drm/panel/panel-raydium-rm68200.c
> index c535dc931903e..971d075bb0601 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c

[ ... ]

> @@ -258,6 +256,7 @@ static int rm68200_prepare(struct drm_panel *panel)
>  {
>  	struct rm68200 *ctx =3D panel_to_rm68200(panel);
>  	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>  	int ret;
> =20
>  	ret =3D regulator_enable(ctx->supply);

[ ... ]

>  	rm68200_init_sequence(ctx);
> =20
> -	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret)
> -		return ret;
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> =20
> -	msleep(125);
> +	mipi_dsi_msleep(&dsi_ctx, 125);
> =20
> -	ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret)
> -		return ret;
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> =20
> -	msleep(20);
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> =20
> -	return 0;
> +	return dsi_ctx.accum_err;

[Severity: Medium]
Does this error path leak the regulator reference and leave the reset GPIO
asserted?

If a DCS command fails during rm68200_prepare(), the function returns
dsi_ctx.accum_err. Because drm_panel_prepare() in the DRM core does not set
panel->prepared =3D true on failure, subsequent calls to drm_panel_unprepar=
e()
return early without executing rm68200_unprepare().

If that happens, is there anything to disable ctx->supply or reset the
GPIO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014135028.1438=
841-1-hungen3108@gmail.com?part=3D2
