Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C9AC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D0410E31A;
	Thu, 16 Jul 2026 17:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aoMC+Qd8";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 797C110E31A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 17:09:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id ACF47C2B9D6;
 Thu, 16 Jul 2026 17:09:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0F86B6035F;
 Thu, 16 Jul 2026 17:09:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3629E11BD3D27; 
 Thu, 16 Jul 2026 19:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784221748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=athdqcsoQXwS2d0D/Za30Y4KtbUbBG7ZgM8ivAaVLFc=;
 b=aoMC+Qd8YFn+M5txmi1HS0zHGNsle13KATqdZfJBH+C89VMIk4c9bHA/VKynxEqS2R5nWI
 nL+uJBkqtGK1dGRRpmU6wg2KgE1wdKzu9XE9G5BHBrRaNVmAO4lEIC9LWPOgiAXJkAd8rt
 1o6YcbuD6iRMx8wFpr6xmdcAbOn7b2JmkbCOglv7IhTR5qLt+0Eg/DXEUn+VEW0QQlr4Mf
 JhOMO3YvLknAvJ1NpS5xjyS7eT+MYCAQPdJeq2ri2PW9MFGw5gjSKq0UaffSeM2Dndq32a
 OxSw0qZDTLG/fcgNHJJJ0z4U4hEoyfNCEPtCYPi/lurk7uI/gxZFroSB1Pg/eA==
Date: Thu, 16 Jul 2026 19:09:01 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Linus Walleij
 <linusw@kernel.org>, Frieder Schrempf <frieder.schrempf@kontron.de>, Marek
 Vasut <marex@denx.de>, Esben Haabendal <esben@geanix.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Message-ID: <20260716190901.29f44aea@bootlin.com>
In-Reply-To: <178421534408.28815.5022512273977369395.b4-review@b4>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-2-ebc4c3fe29b6@geanix.com>
 <178421534408.28815.5022512273977369395.b4-review@b4>
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

Hi Luca, Esben,

On Thu, 16 Jul 2026 17:22:24 +0200
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> On Wed, 15 Jul 2026 15:10:32 +0200, Esben Haabendal <esben@geanix.com> wrote:
> 
> Hi Esben,
> 
> +Cc Hervé
> 
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > index b4b220eee790..7e73035d7798 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -419,11 +419,12 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
> >  	ret = sn65dsi83_reset_pipe(ctx);
> >  	if (ret) {
> >  		dev_err(ctx->dev, "reset pipe failed %pe\n", ERR_PTR(ret));
> > -		return;
> > +		goto err_exit;
> >  	}  
> 
> This looked like a nasty bug! But it is not, out of pure luck. As sashiko
> noticed:
> 
>  | sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
>  |
>  | [Severity: High]
>  | This isn't a bug introduced by this patch, but is this error handling block
>  | actually dead code?
>  |
>  | Looking at sn65dsi83_reset_pipe(), it appears to unconditionally return 0,
>  | even if drm_bridge_helper_reset_crtc() returns an error like -EINVAL or
>  | -ENOMEM:
> 
> So perhaps we should just remove the dead code, and also make
> sn65dsi83_reset_pipe() return void.
> 

I would keep an error code from sn65dsi83_reset_pipe() but change its code
from
---- 8< ----
retry:
	err = drm_bridge_helper_reset_crtc(&sn65dsi83->bridge, &ctx);
	if (err == -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	}

	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);

	return 0;
---- 8< ----

to 

---- 8< ----
retry:
	err = drm_bridge_helper_reset_crtc(&sn65dsi83->bridge, &ctx);
	if (err == -EDEADLK) {
		drm_modeset_backoff(&ctx);
		goto retry;
	}

	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);

	return err;
---- 8< ----

Indeed, if drm_bridge_helper_reset_crtc() fails, we can consider that
sn65dsi83_reset_pipe() fails.

With that done, Esben's modification is still relevant (i.e. goto err_exit
on failure).

Best regards,
Hervé
