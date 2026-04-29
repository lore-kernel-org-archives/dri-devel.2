Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07399FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B4EB10EFBF;
	Wed, 29 Apr 2026 11:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vaWMHGd8";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A4810EFBB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:48:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C40DC1A1CE7;
 Wed, 29 Apr 2026 11:48:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 86C55601DF;
 Wed, 29 Apr 2026 11:48:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1D9841072824E; 
 Wed, 29 Apr 2026 13:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777463320; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NAr1kMTIhIkt5U+a0cZfT48BHAuxADVaU25o4IUMDEE=;
 b=vaWMHGd8d6HTFYAWZnAqAgbuI9L921J9mPJZpVt1p+fgsMmjm5jEgzXIoWoCIPGfp4GbJu
 A0EQVyYkVyoBV+6wnSHqQko9IZ01AC39MmLoxQ+57ihBOhsZ6cKzrUhDzB/s6Zq87Xr9Og
 3wzR7ABdt6cjrdzrLvEajEzJ0D55xxuvW2C0sE8FbKSk6NKSgnmMJ2E1p03MSz6Sb7rTYE
 HAYxK4Xi7/D5Eyt9A9Z8FLBIho60EBrTWYY/ff940tLL1tlkIp2N8MNXWvelm2wKWm8Ss+
 whZfXSx+QO6vGGH6H6IQfl0V/s0ScZT8opgLyGQEmOkvDaHME/jf6W0KscAiPw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:48:33 +0200
Message-Id: <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Cc: <stable@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Peter Senna Tschudin"
 <peter.senna@gmail.com>, "Ian Ray" <ian.ray@ge.com>, "Martyn Welch"
 <martyn.welch@collabora.co.uk>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Archit Taneja"
 <architt@codeaurora.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-3-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200622.325076-3-osama.abdelkader@gmail.com>
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

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> bridge before returning.
>
> Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> tied to the STDP4028 device while ge_b850v3_register() may complete from
> either I2C probe; devm would not unwind the bridge if the other client's
> probe fails.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix br=
idge initialization")

That commit only moved the bug to a slightly different location. The bug
was present even before, since commit fcfa0ddc18ed ("drm/bridge: Drivers
for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)"), so you should update
your Fixes line to point to it.


> Cc: stable@vger.kernel.org
> ---
> v3: add Fixes and Cc tags
> v2: IRQ failure path only (explicit drm_bridge_remove)
> ---
>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/d=
rivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index c9e6505cbd88..2d02cc69f237 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
>  		goto out;
>
>  	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> -
>  	ge_b850v3_lvds_ptr =3D NULL;
>  out:
>  	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> @@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
>  {
>  	struct i2c_client *stdp4028_i2c =3D ge_b850v3_lvds_ptr->stdp4028_i2c;
>  	struct device *dev =3D &stdp4028_i2c->dev;
> +	int ret;
>
>  	/* drm bridge initialization */
>  	ge_b850v3_lvds_ptr->bridge.ops =3D DRM_BRIDGE_OP_DETECT |
> @@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
>  	if (!stdp4028_i2c->irq)
>  		return 0;
>
> -	return devm_request_threaded_irq(&stdp4028_i2c->dev,
> -			stdp4028_i2c->irq, NULL,
> -			ge_b850v3_lvds_irq_handler,
> -			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> +	ret =3D devm_request_threaded_irq(&stdp4028_i2c->dev,
> +					stdp4028_i2c->irq, NULL,
> +					ge_b850v3_lvds_irq_handler,
> +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> +	if (ret)
> +		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);

Why not just using devm_drm_bridge_add() and keep everything else clean, as
you did in other patches in the series?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
