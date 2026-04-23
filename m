Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D8FDEE48
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CB310F23C;
	Thu, 23 Apr 2026 20:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RdMvxIDm";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA27510F23C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:12:22 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so71884575e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776975141; x=1777579941; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F5AMv4bglIF0XOHNIgTCSUa8oAPcWQ+ne8bZUxu85CI=;
 b=RdMvxIDmDJ/rpKNRnHG+RRqA8dOU/X0gd+i1bv95Eb824//n0QDww+aCNABOeemzCp
 dzzuhGc4ftJWn31VB9WKLvUY4k3TGugGKeIIbw3UW4FI7cAVgvoo25N6HpkVyPF8vvHW
 3dI4EAd0GqjLiCRtyxdrk2NQxfLSq39SYMuNWUVyjxsBxWLmVdm3n10ttq8jyu3aiVXa
 cRkrBnkXISnj6/S9lNu6l4bsO0pTiiH9AnZRMRokYlSeKH4wjM2TgOgy1b5ZEUr51ST6
 NEYmxuWUxN075amyBVHWhv7/B7CJDXTjoY2989ZIlU5teFzfqzUx7wpZLgPf5zbovMKT
 D7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776975141; x=1777579941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5AMv4bglIF0XOHNIgTCSUa8oAPcWQ+ne8bZUxu85CI=;
 b=ZrttXFGF+fr1Z+8qfbLuPSuJhzXPe4VDljcyXtFwHl4OgWUHvVnCzQeeudhrS/Ez57
 XjoUseP9Jg3FfX33/Dcvh6bTYBW8ft5ld0KyGacsMM28e08tGSnS4Ip/dzGYuYoKLV9Y
 zOvc+nrcaEC5jZn4jq6cotA6F5Arboy8y9fPZyXd8EZjUfKL9Vak6Cxd2wXo1b8mV6uv
 WLsN2eYdgQMc8T1ZZQdcMleBastH6TXY4afLcoYQpbWdbDPfWFMUQnix8sqYINjY1UG4
 qe4FR9rtuEJbFHHaOeOvbO5+MRgC6i8P/NaMsfms6Ymw5fdMVSPGg6/MGEOnGJwf7FhW
 SA+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v0WeAkJgpXrKtRXMQoO8IsZN9ugf/iXmT9TrOMh1S1lsEHrwGMe8ws+YbAhgtAr6WEbO0YqstfTo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUd7XmrdYLd5WNpJpQMF7x1GkUC3PXq9Jo26cPu8HSPOSyGbKC
 GPw7tj0OfO/skN+3g3hEUQej1T4apybyBtbJnTwMfwk4c5nyUt06t3uP
X-Gm-Gg: AeBDiesZOHXhc8CeV/VqfELFrC5lJ1UKY9gJ0ZRcJ6wOgHuaLFb2lAyQxc8DKlUWuHK
 a+fhy0f3aZmYBKDmx6RkPUJv9+xS/3m/IbQl9i+djtohHfBozSShmt456KEb+ppqCbZpt8tHOtL
 A7bUmKrfH1JJZI+XOaRn5R4b/OQEowcbH0UiUpSCKPKuPMhlfVCDgLcQLvLZjFVdRB7+0wNjafC
 QwY3ZFZ5ZCQhoK3fqQfljfEIR7XUBxy0mYHTYNYgy4FDgH8gzh8zwvY807HIUg2N2VZ2esPJ5f+
 yKf1lcAXeJMXk9J2yyo6f/5yJ5ObYj4eG5licPQVrydYjrpqQbqa5u/uSmwZ/cOUJ3SkrD1HPB+
 GaX0apU6LLnn8QYfBSz1XKZOETmiuno3oD19UrsZ9abtAjrGirR67pebQbvXxUruWFI6G+P4Rln
 gSkDnX0/K2r0urZDEP/RhtqX/XDs8FoUdEY/ovszo+aJQq0H9l/TdTgkup7KoPBbyejaoE
X-Received: by 2002:a05:600c:797:b0:489:1a3a:9e45 with SMTP id
 5b1f17b1804b1-4891a3a9f38mr175552685e9.26.1776975141244; 
 Thu, 23 Apr 2026 13:12:21 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm270934595e9.12.2026.04.23.13.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 13:12:20 -0700 (PDT)
Date: Thu, 23 Apr 2026 22:12:17 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add
Message-ID: <aep9ISaiV4WxiLey@osama>
References: <20260414180518.160801-1-osama.abdelkader@gmail.com>
 <DI0E7J7AJB4N.O7NUKHIX3VX9@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI0E7J7AJB4N.O7NUKHIX3VX9@bootlin.com>
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

On Thu, Apr 23, 2026 at 10:31:27AM +0200, Luca Ceresoli wrote:
> On Tue Apr 14, 2026 at 8:05 PM CEST, Osama Abdelkader wrote:
> > Use devm_drm_bridge_add() so the bridge is released if probe fails after
> > registration, and drop drm_bridge_remove() from DSI remove.
> >
> > v2: devm_drm_bridge_add instead of drm_bridge_add + manual remove paths
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/chipone-icn6211.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > index 5bee10c64265..4bc98c45f65f 100644
> > --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> > +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > @@ -5,6 +5,7 @@
> >   */
> >
> >  #include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_bridge.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_mipi_dsi.h>
> > @@ -730,12 +731,11 @@ static int chipone_dsi_probe(struct mipi_dsi_device *dsi)
> >
> >  	mipi_dsi_set_drvdata(dsi, icn);
> >
> > -	drm_bridge_add(&icn->bridge);
> > -
> > -	ret = chipone_dsi_attach(icn);
> > +	ret = devm_drm_bridge_add(dev, &icn->bridge);
> >  	if (ret)
> > -		drm_bridge_remove(&icn->bridge);
> > +		return ret;
> >
> > +	ret = chipone_dsi_attach(icn);
> >  	return ret;
> >  }
> 
> This patch is doing two different things. This one is a code improvement...
> 
> > @@ -758,20 +758,17 @@ static int chipone_i2c_probe(struct i2c_client *client)
> >  	dev_set_drvdata(dev, icn);
> >  	i2c_set_clientdata(client, icn);
> >
> > -	drm_bridge_add(&icn->bridge);
> > +	ret = devm_drm_bridge_add(dev, &icn->bridge);
> > +	if (ret)
> > +		return ret;
> >
> >  	ret = chipone_dsi_host_attach(icn);
> > -	if (ret)
> > -		drm_bridge_remove(&icn->bridge);
> >  	return ret;
> >  }
> 
> ...and this one is a bigfix. So they should be different patches, the fix
> having Fixes + Cc stable (with fixes being before other patches in the
> series).
>

Thanks for the review, done in v3.
Best regards,
Osama
 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
