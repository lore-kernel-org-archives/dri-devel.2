Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C24CCD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0891210F45C;
	Thu, 30 Apr 2026 20:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqF3JH49";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE3B10F45B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 20:00:41 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488d2079582so14354095e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777579240; x=1778184040; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v0+yTsXt/PCHfrBu1YrbRJLXz84iGqApbjKG4zjSc2I=;
 b=kqF3JH495U4Dhx7iBBH9GkWQrX5DKlipYAe6ZAdoNjF9AYL813UYgM9o2RCTCRYQjt
 FNleLpLxqNOlPK7ghUfsoAef9IhGetaWkX5Kov48gJhTubcRLBQY5OsiExk3aAQnqF4l
 5ZXGyThbUNEjfRGpQJfellyjPh/hNMUNsZrtfrY1HOkAdOlKAEtf2Z5z0klLdJCTz601
 YocGaf0SXnkDWMQmxWUigCkwpGqg0kyUP0RipJ9rMW109Eit2VEExDH2dLC8M7KMmYvp
 8QHWF0c3L6tiwIbYE7y2XfnNhvGGTle19HdoEx5n/2LXY6nCt4TwcaidIzFLd3ydqGUN
 fMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777579240; x=1778184040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0+yTsXt/PCHfrBu1YrbRJLXz84iGqApbjKG4zjSc2I=;
 b=BELxFyUM5KTpH3/V4681ATP6+svc3AS4XXEITW30d2GQz0dukZ2S8yB7f3uEqwnbwD
 jHww+PGqMFQkzCGRWZ4mYwC6hs1/Kdj/0B/c/JIbcpsF3ULf1oAAjxEYTbixUtZghCI7
 gABiUUVg8Ip5tSDuAGKhQAXVSpU2DYhCtEa5GFBjz8RvVSlUKGB9fgpn1tSJ4Dtm9eKf
 6bTdpTUF389CzrpwL59MMqzP14EKK8NUvvjj53xrhWKrg2w2eFDTZ8Q8Xv7CcgIZ52b4
 vybA/dvrnYtKRKmkqgnlOKMJO2X+ILaFayz/bAaXDcMD52e7YU0X5yk+0A+y5yPCk12g
 xoOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IWKBZEpOZwwPwYohc1HltCzYd3tKXQc4ddOR8LhyS3NEmSzNRyNp8zaNlfnAcaLJ69S00JPXCT3E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCKdfDuQWNFW42630bp2QeknQmOgKrlMIdfvysLeLVUDHbxar4
 w9oQNfgCufOEz8TDQ/UNvQ3uhPDVfL+T7o76OjurJUF3YpqoayV12D8f
X-Gm-Gg: AeBDievJo+BdaGsEMmDU55UQIxmSKAwqdlrV403uZsKTPrhhhIu/H+PYp3ygJpAONRQ
 2vk8uG7Xb89yq61BgFWR/UwQ8d2o4bW2idg2AXViQx343bUjZWrGC+e7Vqb3qJo5vftk5c8uise
 AU4lxHijwM4e7Q3NdPtUA2+EdDZkX5KGLnMTDrHi2dbG0TPay/dWY81LyZaNcdFcoehMYwOx0Dj
 YmnhMqLKClYK6rCziFlbSX5OgSXa4FLmtD8mKavR1vonF7vIPAL4biucUsNqR7dKI5V300n0ezD
 kEDWh3hfwrXBuY/3YgPND0erIbWhWizwpELvXTpJAB087vFRJV42qOtMQbfLXNo86iOLxuSyL9t
 0N0/+N1BwzECI6yMq+nf7SAxaWecHtIIMo21KTjpvFfUtViSv+cp7GLcomgDdAGUBxxWXpS/K6k
 I1ffO9cc/nN0J9XXL10OhgI1J9fQ7ZKEpY7qhl56mRX3CZ1JMexx1fiTlazTcHmAb9FBkl
X-Received: by 2002:a05:600c:8b22:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-48a844582c3mr75430765e9.23.1777579240148; 
 Thu, 30 Apr 2026 13:00:40 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8ebb3dc1sm3019145e9.14.2026.04.30.13.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:00:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 22:00:37 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-ID: <afO05Q3tPgifoqvz@osama>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-3-osama.abdelkader@gmail.com>
 <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
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

Hello Luca,

On Wed, Apr 29, 2026 at 01:48:33PM +0200, Luca Ceresoli wrote:
> On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> > If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> > bridge before returning.
> >
> > Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> > tied to the STDP4028 device while ge_b850v3_register() may complete from
> > either I2C probe; devm would not unwind the bridge if the other client's
> > probe fails.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix bridge initialization")
> 
> That commit only moved the bug to a slightly different location. The bug
> was present even before, since commit fcfa0ddc18ed ("drm/bridge: Drivers
> for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)"), so you should update
> your Fixes line to point to it.

Updated in v4, thanks.

> 
> 
> > Cc: stable@vger.kernel.org
> > ---
> > v3: add Fixes and Cc tags
> > v2: IRQ failure path only (explicit drm_bridge_remove)
> > ---
> >  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index c9e6505cbd88..2d02cc69f237 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
> >  		goto out;
> >
> >  	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> > -
> >  	ge_b850v3_lvds_ptr = NULL;
> >  out:
> >  	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> > @@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
> >  {
> >  	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
> >  	struct device *dev = &stdp4028_i2c->dev;
> > +	int ret;
> >
> >  	/* drm bridge initialization */
> >  	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > @@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
> >  	if (!stdp4028_i2c->irq)
> >  		return 0;
> >
> > -	return devm_request_threaded_irq(&stdp4028_i2c->dev,
> > -			stdp4028_i2c->irq, NULL,
> > -			ge_b850v3_lvds_irq_handler,
> > -			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > -			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> > +	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
> > +					stdp4028_i2c->irq, NULL,
> > +					ge_b850v3_lvds_irq_handler,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> > +	if (ret)
> > +		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> 
> Why not just using devm_drm_bridge_add() and keep everything else clean, as
> you did in other patches in the series?

Because registration is tied to the STDP4028 device while ge_b850v3_register()
may complete from either I2C probe; so devm would not unwind the bridge if the 
other client's probe fails.

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
