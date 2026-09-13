Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8588C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D365C10E095;
	Sun, 13 Sep 2026 13:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WTTEPDgH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D4610E095
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 476FB40507;
 Sun, 13 Sep 2026 13:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0036E1F000FF;
 Sun, 13 Sep 2026 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789306297;
 bh=eYcLJpqhPTr6Ayny677rIzD2va/v1FnYWf3JeitSvJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WTTEPDgHISj/8oeU9ZQKOHNAdZCvUOj3HmISyfbCZaJ9E0Lyzu9AD3wAFVqiMJ1Nz
 PykYVsuhuDsDQxVIxh3QdcE80szFgVTBvDdZiozTAMjDm7oHHK78JSVP1uUomgvyjf
 cYh2vCHrz5U+4f5YumOO++WE3dhJWryjMxgmKyoSSlctvwoz2ExKXhIjZKwCUyQRbG
 9b3xt5GLOOJUXLklv8tTsipwK3IRdtV6hTQMClxmg9vcCore2tDNVRnJtXfClt1sk5
 KZsXD7dHHae6obds8UTMWJBgZS4ha0sZk5Yqumz4RYsvqG3QUCy6U0wC2vnSdEPXfs
 ngnBsCmHpKVtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: novatek-nt35950: fix potential
 use-after-free on attach failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913131849.1561742-1-lgs201920130244@gmail.com>
References: <20260913131849.1561742-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:31:36 +0000
Message-Id: <20260913133137.0036E1F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] Panel is published globally before initialization is complete, exp=
osing a race condition that leads to Use-After-Free of DSI devices and devm=
-managed resources if an error occurs.
--

commit 06a7a4ea81475e17e3e167d525f0a49d30e5896a
Author: Guangshuo Li <lgs201920130244@gmail.com>
   =20
drm/panel: novatek-nt35950: fix potential use-after-free on attach failure
   =20
This commit attempts to fix a potential use-after-free issue by detaching
DSI hosts and removing the panel from the DRM panel registry if
mipi_dsi_attach() fails during probe.

> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/=
drm/panel/panel-novatek-nt35950.c
> index 94aa6489d99fc..8edd0aa363cec 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -514,12 +514,19 @@ static int nt35950_probe(struct mipi_dsi_device *ds=
i)
> =20
>  		ret =3D mipi_dsi_attach(nt->dsi[i]);
>  		if (ret < 0) {
> -			/* If we fail to attach to either host, we're done */
> +			dev_err_probe(dev, ret,
> +				      "Cannot attach to DSI%d host.\n", i);
> +
> +			/* Detach from all previously attached DSI hosts */
> +			while (i--)
> +				mipi_dsi_detach(nt->dsi[i]);
> +
>  			if (num_dsis =3D=3D 2)
>  				mipi_dsi_device_unregister(nt->dsi[1]);
> =20
> -			return dev_err_probe(dev, ret,
> -					     "Cannot attach to DSI%d host.\n", i);
> +			drm_panel_remove(&nt->panel);
> +
> +			return ret;

[Severity: High]
This is a pre-existing issue, but does this still leave a race condition si=
nce
the panel is published globally before mipi_dsi_attach() is called?

Earlier in nt35950_probe(), the panel is published globally:

	drm_panel_add(&nt->panel);

If a concurrent thread (like a display controller) discovers the panel via
of_drm_find_panel() and acquires a reference, and then mipi_dsi_attach()
fails, this error path executes:

	if (num_dsis =3D=3D 2)
		mipi_dsi_device_unregister(nt->dsi[1]);

	drm_panel_remove(&nt->panel);

The concurrent thread will keep the panel structure alive. If that thread
subsequently initiates a display modeset, it will call drm_panel_prepare()
which invokes nt35950_on() and dereferences the now-freed secondary DSI
device:

	nt->dsi[1]->mode_flags |=3D MIPI_DSI_MODE_LPM;

Could drm_panel_add() be moved to the very end of the probe function, after
all initializations (including mipi_dsi_attach) have successfully completed?

>  		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913131849.1561=
742-1-lgs201920130244@gmail.com?part=3D1
