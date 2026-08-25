Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BCC61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9127A10E206;
	Tue, 25 Aug 2026 16:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Kqk0P/I0";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE50310E206
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 16:30:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 55E794E413AC;
 Tue, 25 Aug 2026 16:30:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 162DA604C4;
 Tue, 25 Aug 2026 16:30:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5EBEF11C78249; 
 Tue, 25 Aug 2026 18:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787675451; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=m1ciE4mYdhWnn2uJ9Ax82y7IDLWdKdWZPrLVFii7Ef8=;
 b=Kqk0P/I0+CTDCRJPMRSOKaDnJkdBQEfUhNwMffJabez8+kA093HDVf1eLdcGHZOcz8Mtiw
 mxWKa829Bxr725bfRw/87lhii2v91yf2R+nBn/jDm7yx8JpeCv5bm/MR5k6QqzEBbh1jWf
 /8jvvj3xx23SfOMkdy5HS3K2WLjAWhBAg0QMeyQG2QkCHV3d/dPl+3RmetOf0wTxfQ9aoZ
 dwwJz6AsYbL9fKVYNe7xn124NEruqet4XnA7ZahoVfD358nBsl5u1CBpYrUF/3LLlqBY0b
 4TW90bDdi8NnXkaHhFp+Ojh3HG9ul/1YRAHqRoyi5mXwAmmErO7NCJ9Ohz918Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:30:34 +0200
Message-Id: <DKY61WY891FQ.2FRJCHV9RY9WA@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Joel Selvaraj"
 <jo@jsfamily.in>, "Icenowy Zheng" <icenowy@aosc.io>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Casey Connolly" <casey.connolly@linaro.org>, "Michael Tretter"
 <m.tretter@pengutronix.de>, =?utf-8?q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>, "Purism Kernel Team" <kernel@puri.sm>, "Ondrej Jirman"
 <megi@xff.cz>, "Sasha Finkelstein" <k@chaosmail.tech>, "Janne Grunau"
 <j@jannau.net>, "Michael Trimarchi" <michael@amarulasolutions.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <asahi@lists.linux.dev>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 6/6] drm/panel: Use managed helpers in assorted panels
X-Mailer: aerc 0.22.0
References: <20260812155401.96968-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812155401.96968-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 5:53 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in assorted
> panel drivers and drop the corresponding manual detach and panel remove
> calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v4:
> - use devm_drm_panel_add instead of drm_panel_add.
>
>  drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 20 +++--------
>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 20 +++--------
>  drivers/gpu/drm/panel/panel-dsi-cm.c          | 15 ++++-----
>  drivers/gpu/drm/panel/panel-ebbg-ft8719.c     | 20 +++--------
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 20 +++--------
>  drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c | 19 +++--------
>  drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 19 +++--------
>  drivers/gpu/drm/panel/panel-hydis-hv101hd1.c  | 24 +++-----------
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 33 +++----------------
>  drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 19 +++--------
>  drivers/gpu/drm/panel/panel-khadas-ts050.c    | 23 +++----------
>  drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c    | 30 ++-----------=
----
>  drivers/gpu/drm/panel/panel-lg-sw43408.c      | 22 ++++---------
>  drivers/gpu/drm/panel/panel-lincolntech-lcd197.c  | 20 ++---------
>  drivers/gpu/drm/panel/panel-lxd-m9189a.c      | 24 +++-----------
>  drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c  | 16 +++------
>  drivers/gpu/drm/panel/panel-newvision-nv3051d.c   | 22 +++----------
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c  | 16 +++------
>  drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c    | 23 +++----------
>  drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c  | 31 ++-----------=
----
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c  | 19 +++--------
>  drivers/gpu/drm/panel/panel-simple.c          | 22 ++++---------

I think due to its relevance, panel-simple should be a patch on its
own. But see below too.

...

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
> @@ -6551,24 +6552,15 @@ static int panel_simple_dsi_probe(struct mipi_dsi=
_device *dsi)
>  	dsi->format =3D desc->format;
>  	dsi->lanes =3D desc->lanes;
>
> -	err =3D mipi_dsi_attach(dsi);
> -	if (err) {
> -		struct panel_simple *panel =3D mipi_dsi_get_drvdata(dsi);
> -
> -		drm_panel_remove(&panel->base);
> -	}
> +	err =3D devm_mipi_dsi_attach(&dsi->dev, dsi);
> +	if (err)
> +		return err;
>
> -	return err;
> +	return 0;
>  }
>
>  static void panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
>  {
> -	int err;
> -
> -	err =3D mipi_dsi_detach(dsi);
> -	if (err < 0)
> -		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> -
>  	panel_simple_remove(&dsi->dev);
>  }

You are changing the removal order here, with potential risk.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
