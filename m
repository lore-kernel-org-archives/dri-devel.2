Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC0C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E4A10E7E5;
	Wed, 16 Sep 2026 07:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wdrxyjxt";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DDFD10E7E5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 07:50:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6AEB2C5CD5E;
 Wed, 16 Sep 2026 07:51:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8C3AE60337;
 Wed, 16 Sep 2026 07:50:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E66B11C7AFE8; 
 Wed, 16 Sep 2026 09:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789545039; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IP/VqCNL+/3lGkj7Q+GRZIqx0kF2RYLs0QLuZeve2Ok=;
 b=wdrxyjxtpv0j1qeKGZgnvoiR+rZ6vetF+ipVtqenTN5edPNYslgn1p5lAyfEu/oyFelFkK
 4MHjc3UG5zFhJpyhhyYfYS5Pf++jpct0NcP7afsYUKzJ/iYijmk9KizMi2M9HJheT2a1za
 fQjRKrmH++oN56y1A3X5mF3qH8d0OaQJmGedQyXq4Fb09D4PNqAfa/zVp8OahVwiwkaJyW
 +9IjfC9kYLjYj05hosxkX2NT3Eetc9lg6cVniphJhZknAke+IjQ1u7CZH014x2fSGoa0tQ
 pqJ6IOOZB6Cooillh9iiDxugEDMa+dQZvIdLnT7vA/0+ilckmV5+SwHV8Ok1Og==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 09:50:35 +0200
Message-Id: <DLGKRRWANR4E.1AG4LI99DCJ2F@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v5 4/4] drm/panel: simple: Use managed helpers in
 panel-simple
X-Mailer: aerc 0.22.0
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
 <20260915145935.60397-5-osama.abdelkader@gmail.com>
In-Reply-To: <20260915145935.60397-5-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello Osama,

On Tue Sep 15, 2026 at 4:59 PM CEST, Osama Abdelkader wrote:
> Use the managed panel add helper in panel-simple and drop the manual
> panel remove call from the remove path.
>
> Keep the MIPI DSI attach and detach manual, since panel-simple's
> remove callback also unprepares/disables the panel and releases the
> DDC adapter; deferring the detach to devm would run it after that
> cleanup instead of before, changing the teardown order.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Thanks for continuing the cleanup.

However there is still some confusion in how you are sending patch series:

 * You sent the patches to various recipients including mailing lists
   (which is OK), but did not send the cover letter to mailing lists. I got
   the cover and it only has me in To: and nobody in Cc:.

 * You sent two iterations the same day without an explanation; this is
   normally a confusing behaviour, which makes sense only rarely and for a
   very good reason which is clearly explained in reply to the previous
   revision (e.g. "sorry, this series is broken, ignore it, sending a fixed
   one very soon")

 * The panel-simple patch disappeared in v6, why? (see next question)

 * The Changelog for v6 (not visible on mailing lists) is overly verbose,
   so I didn't even try reading it. Please use oneliners or so. And in case
   you did, don't uncritically copy-paste AI slop. Think about your readers
   and te minimum info they need.

I think I already suggested using b4 to send your patches, which would
handle the mechanical aspects for you. It prevent issues like the first
bullet above.

Can you please send a v7 with the above fixed, as well as the changelog
made concise (including the v5 and v6 entries)? I'll be glad to review
that.

Kind regards,
Luca

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel=
/panel-simple.c
> index c95964ba25a9..02d21dde5766 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -737,7 +737,9 @@ static struct panel_simple *panel_simple_probe(struct=
 device *dev)
>  		goto disable_pm_runtime;
>  	}
>
> -	drm_panel_add(&panel->base);
> +	err =3D devm_drm_panel_add(dev, &panel->base);
> +	if (err)
> +		goto disable_pm_runtime;
>
>  	return panel;
>
> @@ -785,7 +787,6 @@ static void panel_simple_remove(struct device *dev)
>  {
>  	struct panel_simple *panel =3D dev_get_drvdata(dev);
>
> -	drm_panel_remove(&panel->base);
>  	panel_simple_shutdown(dev);
>
>  	pm_runtime_dont_use_autosuspend(dev);
> @@ -6540,7 +6541,6 @@ static int panel_simple_dsi_probe(struct mipi_dsi_d=
evice *dsi)
>  {
>  	const struct panel_desc_dsi *desc;
>  	struct panel_simple *panel;
> -	int err;
>
>  	panel =3D panel_simple_probe(&dsi->dev);
>  	if (IS_ERR(panel))
> @@ -6551,14 +6551,7 @@ static int panel_simple_dsi_probe(struct mipi_dsi_=
device *dsi)
>  	dsi->format =3D desc->format;
>  	dsi->lanes =3D desc->lanes;
>
> -	err =3D mipi_dsi_attach(dsi);
> -	if (err) {
> -		struct panel_simple *panel =3D mipi_dsi_get_drvdata(dsi);
> -
> -		drm_panel_remove(&panel->base);
> -	}
> -
> -	return err;
> +	return mipi_dsi_attach(dsi);
>  }
>
>  static void panel_simple_dsi_remove(struct mipi_dsi_device *dsi)





--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
