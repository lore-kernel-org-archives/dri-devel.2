Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1725C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B2F10E38C;
	Thu, 16 Jul 2026 15:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kvEn2KwC";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 505E510E38C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:22:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 901C34E40DDC;
 Thu, 16 Jul 2026 15:22:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6065D602B8;
 Thu, 16 Jul 2026 15:22:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 83FE511BD3D1C; 
 Thu, 16 Jul 2026 17:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784215353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=F0nhEu/wdZXoP896SlQh6px+prChDpXnNp0IKL6hZak=;
 b=kvEn2KwCVumamiTFB0RBInLUV20l7gvEjKWXZA7kJkPAgAdlBdj0HYGmVwsMgbIr9R5HBe
 /l2+iQycCZdsFNGcMWnYcdhV7MDYrmjdUoLD866I3/vjca8eEAktRoeNFtYh1lOB14ejk4
 AZMU5L0XRYdG96tdtD6B9licuhag3WHprcNXz/p0nq7sxvfF1aauXbfRUDC8RPuy4F0iyF
 RgziSbZyDdROUoukEzisJWySyJ4yKQpC1TDcPyPhDD+eWla3RocIQSOdS0nRlcNCZ4zuIV
 a0a8UkKzUD2bOUzvALiiMvZEk9ngpFvGZG/XX/dm8okA6GMRZFlHKkOqd1x+Ig==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
Date: Thu, 16 Jul 2026 17:22:24 +0200
Message-Id: <178421534408.28815.5022512273977369395.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Wed, 15 Jul 2026 15:10:32 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

+Cc Hervé

>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index b4b220eee790..7e73035d7798 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
>  	ret = sn65dsi83_reset_pipe(ctx);
>  	if (ret) {
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> +		goto err_exit;
>  	}

This looked like a nasty bug! But it is not, out of pure luck. As sashiko
noticed:

 | sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
 |
 | [Severity: High]
 | This isn't a bug introduced by this patch, but is this error handling block
 | actually dead code?
 |
 | Looking at sn65dsi83_reset_pipe(), it appears to unconditionally return 0,
 | even if drm_bridge_helper_reset_crtc() returns an error like -EINVAL or
 | -ENOMEM:

So perhaps we should just remove the dead code, and also make
sn65dsi83_reset_pipe() return void.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

