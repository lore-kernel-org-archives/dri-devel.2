Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E419C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0268F10ED84;
	Wed, 19 Aug 2026 09:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="IiF/qXlu";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F9F10ED84
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:33:08 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 033B21A1730;
 Wed, 19 Aug 2026 09:33:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B53A75FF42;
 Wed, 19 Aug 2026 09:33:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0EC1B11C715B7; 
 Wed, 19 Aug 2026 11:32:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787131981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/J+2MYz8g8O18uMEI9fVj2SUHU+9gRW2v5KuunkJoXQ=;
 b=IiF/qXluNvYqTqO8j7kY3HeKbKYfEcgraO0wBT2XY00EB6UHbVHebizB1sXCnLEzGPhD5L
 WLZImu7N/6mAK6O5xAhRiMZH9MjxZwr1Etlb4s9GrZeRhUAlDC8aDAqEW2zrwaJXfblhrk
 vwPSV04hZ+jopaZhSXrb1kTjOGdu51Q4BUtGX+3ZVcsSFce82m1FWK5kRZCNrOb3xVT9MZ
 vZWbvfftEGoQB9y0mrGfXb7zDSAsIy+M/qcV7E9Zwg/78RN+MZ2yrXaPqpzSxe4bsFGPUU
 43RK12wviPhhm0nmOFyHy8kuqNs0OQo97DF90d0ORYQGkD6DFsb/nCp8e2Wchw==
Date: Wed, 19 Aug 2026 11:32:53 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Message-ID: <20260819113253.5d602b2d@bootlin.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
 <20260810-ti-sn65dsi83-fixes-v4-1-ae9c95c8d162@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Esben,

On Mon, 10 Aug 2026 09:19:40 +0200
Esben Haabendal <esben@geanix.com> wrote:

> The error handling of sn65dsi83_reset_pipe() failure in
> sn65dsi83_reset_work() has been a bit strange all the time, missing both
> enable_irq() and drm_bridge_exit() in case of failure. But since
> sn65dsi83_reset_pipe() have never been failing (always returning 0), it has
> not caused any problems.
> 
> As we are going to change sn65dsi83_reset_pipe() to return error values in
> case of failure, we need to fix this.
> 
> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 42b451432bbb..0ccfff401b2a 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -417,10 +417,9 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
>  
>  	/* Reset the pipe */
>  	ret = sn65dsi83_reset_pipe(ctx);
> -	if (ret) {
> +	if (ret)
>  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> -		return;
> -	}
> +
>  	if (ctx->irq)
>  		enable_irq(ctx->irq);
>  
> 

In this v4, enable_irq() is called even if we cannot reset the pipe. I know that
sn65dsi83_reset_pipe() always returns 0 (and this will be change) but we have to
take care here.

If the pipe cannot be reset, the sn65dsi83 component could be in a state where
it can force the interrupt line. This was the reason the irq is disabled
  https://elixir.bootlin.com/linux/v7.2/source/drivers/gpu/drm/bridge/ti-sn65dsi83.c#L455

Best regards,
Hervé
