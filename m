Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33735C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED6A10EFC9;
	Wed, 12 Aug 2026 13:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k1T8uBLq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA7110EFC9
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:18:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 878A360A92;
 Wed, 12 Aug 2026 13:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD6C1F00AC4;
 Wed, 12 Aug 2026 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540687;
 bh=j9MctcE4o3u35ozWX5v4EaXSGloOPKcWDwb/OHE+lNY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k1T8uBLqlzpMnyqDurp9SPh6WsMzKOjFWNZo6wr8ZGv9jgJN9f6kW8sXgXUPbSS3o
 YA4pcsZPvYlVKZwf8GmaqOGuwY9BoXM8QtL/jOZ/Va/J/4Vcj9ZsI4cn+WXeAOnUFX
 nJepfka83LY/qn4kIkaGi8m75nyzet+TScuqDBAJxMQn70Q3ScbUhtP0G1sb+SPGWJ
 Y8mpIWyX18lHeS0ZHOI45Lbm6CuaRkHw/41s5Qog+IVwznMG3vaaCZgTE4hCY0sZkn
 Svebc33h/4yd2z33f4MpAQGVB+YV5rbu639Qht8mpqWXcrI7i/XkH59qReA2Tu9p/C
 IYOPlhQTd3uRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] drm/panel: Use devm_mipi_dsi_attach in assorted
 panels
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812130429.16850-6-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <20260812130429.16850-6-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:18:06 +0000
Message-Id: <20260812131807.1DD6C1F00AC4@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Unused local variable 'dev' left behind after removing error handli=
ng.

Pre-existing issues:
- [High] Missing drm_panel_remove() on devm_mipi_dsi_attach() failure cause=
s Use-After-Free.
- [High] DCS commands sent over a detached DSI bus during st7701 cleanup.
--

--- Patch [6]: [PATCH v3 6/6] drm/panel: Use devm_mipi_dsi_attach in assort=
ed panels ---
commit 7405393b6171044f855c59f559f223d4f0b22c36
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panel: Use devm_mipi_dsi_attach in assorted panels

This commit converts multiple panel drivers to use the managed
devm_mipi_dsi_attach helper. It drops the corresponding manual detach
calls from the remove paths of these drivers.

> diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drive=
rs/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> index db006576d7046..63359416944fe 100644
> --- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> +++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
[ ... ]
> @@ -264,7 +264,7 @@ static int tm5p5_nt35596_probe(struct mipi_dsi_device=
 *dsi)
> =20
>  	drm_panel_add(&ctx->panel);
> =20
> -	ret =3D mipi_dsi_attach(dsi);
> +	ret =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
>  	if (ret < 0) {

[Severity: High]
This isn't a bug introduced by this patch, but if the attach fails here,
does this return the error code without calling drm_panel_remove()?

Because the panel struct was allocated using devm_drm_panel_alloc(), devres
will automatically free the memory upon probe failure. However, the panel
would remain linked in the global panel_list, which could cause a
use-after-free when the list is iterated.

This pattern appears to be present in multiple drivers modified in this
patch (like panel-lg-sw43408.c, panel-summit.c, and panel-tdo-tl070wsh30.c).

>  		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
>  		return ret;
>  	}

[ ... ]
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/=
drm/panel/panel-sitronix-st7701.c
> index f16e0de1ea606..b45e2e683fe9f 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
[ ... ]
> @@ -1347,7 +1347,7 @@ static int st7701_dsi_probe(struct mipi_dsi_device =
*dsi)
>  	dsi->format =3D st7701->desc->format;
>  	dsi->lanes =3D st7701->desc->lanes;
> =20
> -	err =3D mipi_dsi_attach(dsi);
> +	err =3D devm_mipi_dsi_attach(&dsi->dev, dsi);

[Severity: High]
This is a pre-existing issue, but does this lead to DCS commands being
sent over a detached DSI bus during cleanup?

The st7701_probe() function registers the st7701_cleanup() devres action
which eventually calls drm_panel_unprepare() and sends a sleep command.
Because devm_mipi_dsi_attach() is called after st7701_probe(), the detach
devres action is registered last.

Since devres executes in LIFO order, the bus will be detached before
st7701_cleanup() attempts to send the sleep command.

>  	if (err)
>  		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");

[ ... ]
> diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu=
/drm/panel/panel-synaptics-r63353.c
> index 3a74d48753d9c..ea3fbd0c8662e 100644
> --- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
> +++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
[ ... ]
> @@ -281,12 +281,6 @@ static void r63353_panel_remove(struct mipi_dsi_devi=
ce *dsi)
>  {
>  	struct r63353_panel *rpanel =3D mipi_dsi_get_drvdata(dsi);
>  	struct device *dev =3D &dsi->dev;
> -	int ret;
> -
> -	ret =3D mipi_dsi_detach(dsi);
> -	if (ret < 0)
> -		dev_err(dev, "Failed to detach from host (%d)\n", ret);
> -

[Severity: Low]
With the error logging removed, is the dev variable now unused and safe
to remove from r63353_panel_remove() to avoid a compiler warning?

>  	drm_panel_remove(&rpanel->base);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812130429.1685=
0-1-osama.abdelkader@gmail.com?part=3D6
