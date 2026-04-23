Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C2F99351
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847E310E320;
	Thu, 23 Apr 2026 08:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="E0tZqGBc";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A16410E320
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:31:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D9D0C4E42AC7;
 Thu, 23 Apr 2026 08:31:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE74960495;
 Thu, 23 Apr 2026 08:31:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 91A1710460BA6; 
 Thu, 23 Apr 2026 10:31:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776933092; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=RH8/2fxW0OPYCJcoyX4cmm7ZVjUZ3kdYqayMC/Rivk0=;
 b=E0tZqGBcmHLM1PY0iMgG7W1bo5M9AY9+TRASLmsZE7WONKiFDlQWdQlGQQnWG2vZ3dx71P
 JgvckPHt7ZzNdaDF+cT5swW1nut2rt+mU3nUB741UXRHxIy9IBWcwNcySAahUt3opFdJz0
 MY/DiDqqVpiwsRzJ5ys2Yja8kiPmIaNvDpcAY1M7wsJlPewFA9ljz7qLqxQnnzluafdAZs
 8kET+EPrF2YduXgfrxnoolhGBPaJ0gV75INqWVqpvevtVXaKseWqaAhDP6XZmU2BxLGIR2
 vH8NfbbwphvyssK1EGYe/zkAmm1yw7L5GE96poffVM/ySLoiHzyIRIbJ/ssG2g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 10:31:27 +0200
Message-Id: <DI0E7J7AJB4N.O7NUKHIX3VX9@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260414180518.160801-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260414180518.160801-1-osama.abdelkader@gmail.com>
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

On Tue Apr 14, 2026 at 8:05 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop drm_bridge_remove() from DSI remove.
>
> v2: devm_drm_bridge_add instead of drm_bridge_add + manual remove paths
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/bridge/chipone-icn6211.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/b=
ridge/chipone-icn6211.c
> index 5bee10c64265..4bc98c45f65f 100644
> --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_mipi_dsi.h>
> @@ -730,12 +731,11 @@ static int chipone_dsi_probe(struct mipi_dsi_device=
 *dsi)
>
>  	mipi_dsi_set_drvdata(dsi, icn);
>
> -	drm_bridge_add(&icn->bridge);
> -
> -	ret =3D chipone_dsi_attach(icn);
> +	ret =3D devm_drm_bridge_add(dev, &icn->bridge);
>  	if (ret)
> -		drm_bridge_remove(&icn->bridge);
> +		return ret;
>
> +	ret =3D chipone_dsi_attach(icn);
>  	return ret;
>  }

This patch is doing two different things. This one is a code improvement...

> @@ -758,20 +758,17 @@ static int chipone_i2c_probe(struct i2c_client *cli=
ent)
>  	dev_set_drvdata(dev, icn);
>  	i2c_set_clientdata(client, icn);
>
> -	drm_bridge_add(&icn->bridge);
> +	ret =3D devm_drm_bridge_add(dev, &icn->bridge);
> +	if (ret)
> +		return ret;
>
>  	ret =3D chipone_dsi_host_attach(icn);
> -	if (ret)
> -		drm_bridge_remove(&icn->bridge);
>  	return ret;
>  }

...and this one is a bigfix. So they should be different patches, the fix
having Fixes + Cc stable (with fixes being before other patches in the
series).

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
