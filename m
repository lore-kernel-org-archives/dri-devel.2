Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BD9CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B23B10FDEF;
	Wed, 14 Oct 2026 14:00:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE29911204D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 056C96021D;
 Wed, 14 Oct 2026 13:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923BC1F00A2F;
 Wed, 14 Oct 2026 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791986393;
 bh=qpFiGwVLgc7gB61+7nZKl3W3q3REI1gHwYJXB2r5caw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UmE3cYl9wpqm8O0EgoddV0uEWSx9LEqV6V3OrmKn4/q33B55NlFMJSkk20BSl/iK1
 k/ZbhPQXpv02Owr3txWX/6gMH44NAInBegdoQ4IY8mxAM1JzpMu1iwcEUTiGt98Lu7
 bnfbvQZp/xe4bXe7REkUnok2h1w16djveMat7TG2esKoj+yOu0jHUMRQff67VRROE2
 UhsI1Eykxp86F0U8jGce7W4fE1EuWVifcYOhRDRg8+Mx6sN3XoZJ0E9tP7q+uoA1i1
 MMp9VEGi18JSV/zqI9KtzGAoM6NfmFrdZsh4efW47mKOm9Ro10VhYKFa3So2pn3yXE
 AVRjI4VL+IrPw==
Message-ID: <sashiko-outbox-171394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/panel: raydium-rm68200: Use multi-context
 helpers for init sequence
To: "Hsieh Hung-En" <hungen3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014135028.1438841-4-hungen3108@gmail.com>
References: <20261014135028.1438841-1-hungen3108@gmail.com>
 <20261014135028.1438841-4-hungen3108@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 13:59:53 +0000
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
- [Medium] drm/panel: resource leak on rm68200_prepare() error path
--

commit 43be4887f342d01dc5322111059b764933197c3c
Author: Hsieh Hung-En <hungen3108@gmail.com>

drm/panel: raydium-rm68200: Use multi-context helpers for init sequence
   =20
The commit replaces the custom DCS write helpers with the multi-context
helpers mipi_dsi_dcs_write_seq_multi() and mipi_dsi_dcs_write_var_seq_multi=
().
It also shares the multi-context with prepare() so that errors are
propagated and subsequent commands are skipped after a failure.

> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/=
drm/panel/panel-raydium-rm68200.c
> index c535dc931903e..a01b2db55c7f0 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
[ ... ]
> @@ -273,21 +248,17 @@ static int rm68200_prepare(struct drm_panel *panel)
>  		msleep(100);
>  	}
> =20
> -	rm68200_init_sequence(ctx);
> +	rm68200_init_sequence(&dsi_ctx);
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
Does this code leak the regulator enable count?

rm68200_prepare() enables the ctx->supply regulator and configures
ctx->reset_gpio at the beginning of the function.

The patch changes the execution flow so that if any of the DCS commands fai=
l,
their error is recorded in dsi_ctx.accum_err. The function then returns
dsi_ctx.accum_err directly, without disabling the regulator or asserting the
reset GPIO.

If funcs->prepare() returns an error, the DRM panel framework does not mark
the panel as prepared and will never call funcs->unprepare() to clean up.

Consequently, the regulator enable count would be permanently unbalanced and
the hardware would remain partially powered. While this leak existed
previously for the sleep and display commands, this patch modifies the error
return paths and makes it significantly more likely to trigger by now
aborting on any initialization sequence error as well.

Could an error unwind path be added to clean up the regulator and GPIO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014135028.1438=
841-1-hungen3108@gmail.com?part=3D3
