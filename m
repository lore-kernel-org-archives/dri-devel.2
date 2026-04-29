Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACEAFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADCB10EFB2;
	Wed, 29 Apr 2026 11:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MY4x65lp";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7130310EFB2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:40:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0DCAEC5EF22;
 Wed, 29 Apr 2026 11:41:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EC72A601DF;
 Wed, 29 Apr 2026 11:40:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9559010729C05; 
 Wed, 29 Apr 2026 13:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777462844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Nxrz0cgWctqJlCSw2ayGmz8ggago1U3Xvv/tXD/4dxQ=;
 b=MY4x65lpEtQO4FmzwnmwaK27cI5ixpQraQfOx7BbrdQA+0SFxZzFiz+xOmT8YYQlvSiiQb
 /Qos3U/b4T7Fu+zkS4YpicDtIxa7cssuxTMqfoAoJNrp4znUVriG2qRz0mP/hrp+x1INmz
 Cn4M/FuuXYECa3v6OS29hHhhACezDVU3WuG0S+Oo3CLS1yqOCu4f26YzKk555dhCUBTVXL
 hclYXNOeLJipQT5Vd5zVBs16a+tmwAJlG23eu3MWdF3wHuaauyt/E8NqZYat3fChK9138D
 cmGiHzdoxHppe7DPlCoSSsSENUxGpwkAciM2FMlip2pYcs1i76x8dX03s/jxtA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:40:39 +0200
Message-Id: <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Marek Vasut"
 <marex@denx.de>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
X-Mailer: aerc 0.20.1
References: <20260423200546.324187-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200546.324187-1-osama.abdelkader@gmail.com>
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

On Thu Apr 23, 2026 at 10:05 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop drm_bridge_remove() in chipone_i2c_probe.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support=
")
> Cc: stable@vger.kernel.org
> ---
> v3: split the patch into two, one for i2c probe (bugfix) and one for dsi =
probe,
>     and add Fixes and Cc tags
> v2: devm_drm_bridge_add instead of drm_bridge_add
> ---
>
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> index 5bee10c64265..4d76e1bd5e78 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *cli=
ent)
>  	dev_set_drvdata(dev, icn);
>  	i2c_set_clientdata(client, icn);
>
> -	drm_bridge_add(&icn->bridge);
> -
> -	ret =3D chipone_dsi_host_attach(icn);
> +	ret =3D devm_drm_bridge_add(dev, &icn->bridge);
>  	if (ret)
> -		drm_bridge_remove(&icn->bridge);
> -	return ret;
> +		return ret;
> +
> +	return chipone_dsi_host_attach(icn);
> +
>  }
>
>  static void chipone_dsi_remove(struct mipi_dsi_device *dsi)

This patch does not apply. Is it messed up with patch 2/2?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
