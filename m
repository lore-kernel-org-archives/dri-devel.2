Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D938C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D290C10E11A;
	Wed, 19 Aug 2026 09:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aBvpiCw1";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D08710E11A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:36:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 19B254E412BC;
 Wed, 19 Aug 2026 09:36:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA5775FF42;
 Wed, 19 Aug 2026 09:36:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6183711C75549; 
 Wed, 19 Aug 2026 11:36:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787132174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=A/xkCgha8hwURYD4JLDAys/B3Rx8Yg7BIQ8wcjbJ8pA=;
 b=aBvpiCw1ob+oCjwxCmm+OR1N8ofj/xI5b4XVzCKGGbngDdvamdczTbSMEu7X8ztCigmDhm
 s2UlWvtNO1vFr+OOmMPbZKlF0NkqeJYVo3/ggwcwkKlSJHVRL6V3bDt7Y8dzlrYqXDxo4r
 HbcOAZb4sDz90JiC2zetjIc/bWju9ub4afYRngYVK2np5gdh4vTqW3+Y4u4Q78Xq7/v6fd
 yov9yJOX4Hn9g4DbwDH8brDYaavwdpKlG6m0NyThj40/WfcPWbdz2O1tgwRM6VSFZAoFki
 MQ2BPR1ptAuZn6oxdmHyPupXkUgzFJS4czdUYKYi9/woDA4x8xFRo8VxLmrzMg==
Date: Wed, 19 Aug 2026 11:36:09 +0200
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
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
Message-ID: <20260819113609.2a8bc92b@bootlin.com>
In-Reply-To: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
References: <20260810-ti-sn65dsi83-fixes-v4-0-ae9c95c8d162@geanix.com>
 <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
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

On Mon, 10 Aug 2026 09:19:41 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.
> 
> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 0ccfff401b2a..475224c5a5d8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -403,7 +403,7 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
>  
> -	return 0;
> +	return err;
>  }
>  
>  static void sn65dsi83_reset_work(struct work_struct *ws)
> 

I have sent my 'Reviewed-by' too late on the v3. Sorry about that.

Here it is for this v4.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
