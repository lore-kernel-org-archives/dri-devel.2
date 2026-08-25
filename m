Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D316BC61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D98510E1F7;
	Tue, 25 Aug 2026 16:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UxLfDG96";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCF710E1F7
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 16:00:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 1594B4E413AD;
 Tue, 25 Aug 2026 16:00:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DC98E604C4;
 Tue, 25 Aug 2026 16:00:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F3AF511C7A5E3; 
 Tue, 25 Aug 2026 18:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787673606; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JFeQ5T9/BX+B7tlzsjnMiemUB98ifmrtHOEH0mf0wPI=;
 b=UxLfDG96sxM64DJ2M1/3yXiyZAHXX6DkQaULXVKIZ0+cM06kgHsemurX9Cjicoc9Z1/Pel
 z5KKgIIxxdVVaOeKs6lduTgJF/qi3/oug1AZ9X19aijabHjamjKMepP/K+iKPyocKykYcG
 TmAApzZbxzuc/udzUnm3TpRUfxGWzH9jOs6Z7jURSjlEEcSsJxX82BhuTNTs7eV7ewQ7uI
 ZwwzFjtJ5SILkbcX0gnS8GFStnr/4UHKU6jWA3Ftr1C4FApI2/4bI34sGKxGmrTbhbm5Mc
 2+92qDREr7T+eQJY+1DCWq4zRol++ESq67Cz5iZKp99PgkyeNM5+xKbH/tnotw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 17:59:56 +0200
Message-Id: <DKY5EGQY76J8.QI8G5V87V6X1@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>,
 <luca.ceresoli@bootlin.com>, "Linus Walleij" <linusw@kernel.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Cristian
 Cozzolino" <cristian_ci@protonmail.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Robert
 Chiras" <robert.chiras@nxp.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 3/6] drm/panel: Use managed helpers in Novatek and
 Raydium panels
X-Mailer: aerc 0.22.0
References: <20260812145910.69509-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260812145910.69509-1-osama.abdelkader@gmail.com>
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

On Wed Aug 12, 2026 at 4:59 PM CEST, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in Novatek and
> Raydium panel drivers and drop the corresponding manual detach and panel
> remove calls from remove paths.
>
> Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

...

> --- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
> @@ -1173,13 +1173,11 @@ static int nt35510_probe(struct mipi_dsi_device *=
dsi)
>  		nt->panel.backlight =3D bl;
>  	}
>
> -	drm_panel_add(&nt->panel);
> -
> -	ret =3D mipi_dsi_attach(dsi);
> -	if (ret < 0)
> -		drm_panel_remove(&nt->panel);
> +	ret =3D devm_drm_panel_add(dev, &nt->panel);
> +	if (ret)
> +		return ret;
>
> -	return 0;
> +	return devm_mipi_dsi_attach(dev, dsi);
>  }
>
>  static void nt35510_remove(struct mipi_dsi_device *dsi)
> @@ -1187,13 +1185,10 @@ static void nt35510_remove(struct mipi_dsi_device=
 *dsi)
>  	struct nt35510 *nt =3D mipi_dsi_get_drvdata(dsi);
>  	int ret;
>
> -	mipi_dsi_detach(dsi);
>  	/* Power off */
>  	ret =3D nt35510_power_off(nt);
>  	if (ret)
>  		dev_err(&dsi->dev, "Failed to power off\n");
> -
> -	drm_panel_remove(&nt->panel);
>  }

This will change the removal sequence, from

  mipi_dsi_detach, nt35510_power_off, drm_panel_remove

to

  nt35510_power_off, mipi_dsi_detach, drm_panel_remove

Can this create issues? In a doubt, we shouldn't change the sequence.

Adding an explicit devm action to call nt35510_power_off in the correct
sequence is a possible way out. But perhaps it's safer and simpler if you
just change drm_panel_remove() to devm, not mipi_dsi_attach().

The rest of the patch LGTM.

> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -428,9 +428,7 @@ static int nt36672a_panel_add(struct nt36672a_panel *=
pinfo)

Looking at this driver, the code split between nt36672a_panel_probe() and
nt36672a_panel_add() appears very arbitrary. Definitely unrelated to your
patch however, just thinking out loud, no need to change your patch about
this.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
