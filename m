Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68170CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76810F443;
	Thu, 30 Apr 2026 20:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlj+tV+B";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E414610F443
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 20:02:07 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so11845835e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777579326; x=1778184126; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=35CpLK8dF17epUVO+7XXTbPPO+g9vsXIfv1w96oRvMw=;
 b=mlj+tV+BFP0T/a6Nk1YJfFJMfz++JvjwPEsYw/kN9FzyDJM2U7YruvR/6GhVojxs4P
 Hxaup/dVas7x5P1oca7v8+nL36KiMl03EuV7l3jLO3RhEnwLzVUOhjSbOR9+p1Ci94xa
 XUM/u5pxKtrvwTV2UrB4MW2s3PbuG13+krghnE8e0HkZ1bNQcmi5NNP4VkEvPNpLom7G
 1NYEKR3RpHMtQ9NpgCcEaYOB0cdM4w4qzKDiE6m4fr6sSxPyI+/5BQoyrRdjMoJJlVRS
 Jq49nogFNE7D9sMoi9Xl6YWM5K0WHnWsP/JO3U30Y6F3lgJdnJBr1TGMsiOHi/RykJrJ
 sHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777579326; x=1778184126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35CpLK8dF17epUVO+7XXTbPPO+g9vsXIfv1w96oRvMw=;
 b=fLOrFIwVar87fAnyWXAhDBWwxm/I7+F1YFKE6lpaI4z9l+9hI/TRsBCQCV0G5If6Xy
 NR5V9tBmU8YCjW+6VFNaXPZkhEfgyVMcjMt6P382CtR4ScJFGsIsQH9ydTe/JQA6Z3AO
 IySNL4RJntmjk1nUdethnLZRrHI+iUNg4daVpuLFerB3/lqpGP2lqqg9vFYhBwqdOgCR
 CGx87hJo9Y7L5zdixpz/cpvsYL5W3iwrXqbmUNopctYLsHPtDITGN+7SCdWGt7LnPdL+
 E6+faoff8iuRB4acUZDiOXSwVlnYGmEfu1NYLU3cwaugZvRPOZqYPEwmjxQI7i8HLR/J
 mH2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zsg2qsFTf885FUzoAcalGeGo2b3RCNz+yVmVf7wXfozurlu1J30ujWg+9puZcCLO7Pg6zxqJy0TM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzK+bLCN0EZ3NZUpoSYuIA9ToQY+dQS7QIZTnF41RtP737q1ttl
 HB7r/SGr5J6ID+fqVsCmwoWfZ3mBDIJ5DXQXntXzZc4k3HDEiSPcxNg1
X-Gm-Gg: AeBDiesfJZ+xjXVEL6No8oLMTjqnrzbCZ06kx4vMtRCV2mROuHvXBkjM6Gvw1zBfUbj
 QSYmLXrQql3bnByn9k3YY22wAA0gGp5UM4gEQJiNpR787A+yO1Kd4/GIF1Btus8W/lo13qBSa4p
 yNnyVUUJzh1LOjBFFFXta3CcgpuRUtZywAKNSY0AogtuRkDPMKstMrIznCxrKm/g+ZMEjJUOY3r
 xQDlKERtF/uJR6yOJP9RkXJpEsMWkQTqbdwbYeR+fy1ryZEDZQqbOKuXCcTX7E3sx8MFIRqG2O/
 BoRL1WiyPLP0HMu0O6682kKfKsON2LfuKKqNUg3lLIn5jb87tRowpXqqmC53QDQVJ8ymmtjjHVM
 FcTM6YqNdbZALyaGI9cqtvHG3ElosfgqgfPg32J+aoFAaAkNgObL71qC2cqVHqHArPxxx20fzLf
 LbsLj1JlAjWVSi5zvOZkzzXM6JIRSneES6lTLQscOXMKnWoiMg65SlT4SSUb4aDp1ZH2Mq
X-Received: by 2002:a05:600c:c174:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-48a83d66ba9mr71345655e9.3.1777579326206; 
 Thu, 30 Apr 2026 13:02:06 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb72184sm1003145e9.32.2026.04.30.13.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:02:04 -0700 (PDT)
Date: Thu, 30 Apr 2026 22:02:02 +0200
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
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
Message-ID: <afO1OhM1M073okcY@osama>
References: <20260423200546.324187-1-osama.abdelkader@gmail.com>
 <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5LZNZ4KRZM.11GRLUOTX256S@bootlin.com>
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

Hi Luca,

On Wed, Apr 29, 2026 at 01:40:39PM +0200, Luca Ceresoli wrote:
> On Thu Apr 23, 2026 at 10:05 PM CEST, Osama Abdelkader wrote:
> > Use devm_drm_bridge_add() so the bridge is released if probe fails after
> > registration, and drop drm_bridge_remove() in chipone_i2c_probe.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
> > Cc: stable@vger.kernel.org
> > ---
> > v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
> >     and add Fixes and Cc tags
> > v2: devm_drm_bridge_add instead of drm_bridge_add
> > ---
> >
> >  drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > index 5bee10c64265..4d76e1bd5e78 100644
> > --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> > +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > @@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *client)
> >  	dev_set_drvdata(dev, icn);
> >  	i2c_set_clientdata(client, icn);
> >
> > -	drm_bridge_add(&icn->bridge);
> > -
> > -	ret = chipone_dsi_host_attach(icn);
> > +	ret = devm_drm_bridge_add(dev, &icn->bridge);
> >  	if (ret)
> > -		drm_bridge_remove(&icn->bridge);
> > -	return ret;
> > +		return ret;
> > +
> > +	return chipone_dsi_host_attach(icn);
> > +
> >  }
> >
> >  static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
> 
> This patch does not apply. Is it messed up with patch 2/2?
> 

The file was changed on upstream in the meanwhile, so I refreshed my patch.

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
