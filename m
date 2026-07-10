Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D9C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E28610E196;
	Fri, 10 Jul 2026 12:01:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmACL1t+";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E30410E196
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:01:55 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-84861fc51f5so664231b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:01:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783684915; cv=none;
 d=google.com; s=arc-20260327;
 b=MB3g+beAEGipKs9dLwPe7iLzoquvOAr+/uSz3sbRHYFRK3B6ckQf69RdsFpyxgzkzB
 NH7rxqRbqqXGZWIReE70ajsG9WLK+HDPikqzk1g6Vt29SnmQTis66CDoFQTeJr8npKyc
 U0piBmIVKEnflyQtD6tde2JWVcsLVKtmZUKpEJXvxekFFRPjHwXIVV47F74y+URojn/z
 lA3y9GUaaW8Aj3cy5gCiT5czt/RS8Kn08uxW7QtiiT7YlhYDKrtPwreAzWhVQ5yJNQVX
 3PJ1a3q463QHmZ8r9x4JFvdadYiOds/EYrdpNeXkuzP5w3yn6ylMpIIvGTcHb1hToEFS
 8wew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zGoLqLOhnoBT5eYxArK45AshFfp+PFQ1oZDYsxbY2CA=;
 fh=RkQTX7GI6dmOViQRpv7ZEfem8KwSwH9PoiwcC3C04dg=;
 b=DaPhL2acHLTqEPHIVAjlpKFRmMndQMhkdEquIzKI9vdkFGVbobbmFK8Y+jU65I5FKc
 TlsMFz22+Gr7hQfjsPRABV93DUirhxz88znC9RPiiH55IYrE9sT29CnPUF5ckIXGRrY/
 vyhsxar1vFQyO2y30kSe3uJJU5kIvJFnce86tDb0/mqLTQvPjHlZGig0Y2ILNxVG42sm
 iTZtMAUUeZYq/Fa+MKsAwOlQTLVU2bS2ZGjdNyT9cHRjF6hlCMOwt9teOzFt0uJ8BXg4
 T0Lgb37ofef9VJOgWpyoLuwXz4eB6jIylf5q+jzIbbnAexIjVaE1X/nzM5a/J6NRhRg3
 5mpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783684915; x=1784289715; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zGoLqLOhnoBT5eYxArK45AshFfp+PFQ1oZDYsxbY2CA=;
 b=JmACL1t+hdX4a1wMFaVBnnFwPq4sKQlrkVweLQ7qMnPCoPUWfhBsOEeRhAVFAlWjWg
 hD/xuLqZTEqyknpbt3fD/eDB5iu63Ph2UzCBelWbibsIoadbQY4izOnpV62Jw7dG/na6
 a5JqnM1h69dQ0D7OnzMYM/5Rv775aRXH8MZlBFK3or1GQXfqlxZ412/yni8jl20/FRS8
 zU3AHXCUD/hH0QErs5zRSGQ7382Eoq20FRNi+G1kx8CKgl6IzzAmTOh5l/kEW0rmcVx7
 up1zwmkZTXlRtFnU2MIIiujw9pzOsowPq3PArXx2DSi7HoJi6zOfSrwLGXGsSnUNNsEN
 p9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783684915; x=1784289715;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zGoLqLOhnoBT5eYxArK45AshFfp+PFQ1oZDYsxbY2CA=;
 b=LD5u45xksrlMXhbIhTCwg/fJjBQX2zEr+vSi92X9ReSUKXE7QbfIS754BCZmSZ/iLw
 0rq0C/o2uD7Blsgb4Xgo4q+RHJ29+b9f6xpWamgA9zTG6iXXDhhCr+K8glBSr4TouA39
 yLLWBZCsKye2AHR6z0Cgm9umRoJgFdM6sAYAyAtfLjDos4ZGLhWqA6ABszhLPGKZIJUs
 6XJplHU8dtC8gdvMnQW8AgzDO6SiFkNhyOEVm67iqIrLZIfnV9frcRDGbZF5+BQbGdPO
 rNOKKvVXi5qu9m5w8OlDfoqUwYuNSsaw6x23flEMsUk/qUAQM09L45ZjKbRwF4hs936U
 DWTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorEvvCpAiTv3U4cEYJVI0U/ptRQd2JHqEkHMBvPIykapCbpn61YdS3WKby0RGG3ooy60PqZP2lSWM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxregIO5YXUcz+PJbjH+ivlhKd+LYMaidQ6i1oIGWTEJziUYsaQ
 H8+Rg+sixieYPcCcY9YHbBsNvx+4Q6D5ypz9LKTLgxkWfyAbczQXLOyFZ2hk5mP1wk0Cib4EaUw
 RypVufOwpA+Z/4Q+c3OSAlYFNuYLbL7o=
X-Gm-Gg: AfdE7cnisj8xKS/G3vB/NIczylsT8UuvAJ1uII1FBXMC2aMF0i7qV3fv2bXuC1Va021
 HtyTriGsJ5lkcWEG8Sx7K3hTEyflYPBVLJeeumxHXyuwpCptdaI3tF4N1vvBBYiRxJkLGdSCDoC
 Du/x7wGm9DA4aPFEUmaWWZMEKLpw+Gq42+/lbLNFkOvJaAdR6VH1aNonvClv1ZKBfkBVch8VSOH
 FPkrkjdL/EK6UYFGHrg6AIdkZdu6758Kpgl6ggRZbf5Z5Za+ZW7zuS8QEwM2l92koX8IaRunr45
 8L7lFO0ubxeDnD3jsIV3/z7JT7Y=
X-Received: by 2002:a05:6a20:2d14:b0:3c0:9c19:6597 with SMTP id
 adf61e73a8af0-3c0bd1a1d7dmr13959642637.63.1783684914765; Fri, 10 Jul 2026
 05:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-etnaviv-reset-notification-v2-0-90cfebcf22a2@igalia.com>
 <20260710-etnaviv-reset-notification-v2-2-90cfebcf22a2@igalia.com>
 <fded212b216f1f4d3afa7465ae64aa9b96b80288.camel@pengutronix.de>
In-Reply-To: <fded212b216f1f4d3afa7465ae64aa9b96b80288.camel@pengutronix.de>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 10 Jul 2026 14:01:43 +0200
X-Gm-Features: AVVi8Ce0a6nv3oNDODzd3-WVwFjHf2yhuy7WRab1u9h0eEE57KHHpX4UY0QWoJ0
Message-ID: <CAH9NwWd7bvzOYrvdiU65qGjwdNjxPdjpiYO2POkQcjmc1kTQSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/etnaviv: Add GPU reset counters
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Lucas,

> >
> > The OpenGL and Vulkan robustness extensions let an application detect a
> > GPU reset and check if its own context caused it, so the application can
> > drop the broken context and build a new one. The kernel knows both
> > facts, but etnaviv has no way to report them to userspace.
> >
> > Add two counters and a RESET_QUERY ioctl that returns both in one call:
> > a per-GPU counter that counts every reset of that GPU, and a per-context
> > counter that only counts the resets this context was guilty of.
> > Userspace compares the counters with saved values: if the context
> > counter moved the context was guilty, if only the GPU counter moved the
> > context was an innocent victim.
> >
> > The GPU counter is per GPU core and not per device, so a hang on one
> > pipe does not look like an innocent reset to contexts that only use
> > another pipe.
> >
> > Bump the driver minor version so userspace can detect the feature.
> >
> > Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.c   | 27 ++++++++++++++++++++++++++-
> >  drivers/gpu/drm/etnaviv/etnaviv_drv.h   |  1 +
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.h   |  2 ++
> >  drivers/gpu/drm/etnaviv/etnaviv_sched.c |  3 +++
> >  include/uapi/drm/etnaviv_drm.h          | 19 ++++++++++++++++++-
> >  5 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > index a27ed014fb4e..a48698463fc1 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> > @@ -296,6 +296,30 @@ static int etnaviv_ioctl_get_param(struct drm_device *dev, void *data,
> >       return etnaviv_gpu_get_param(gpu, args->param, &args->value);
> >  }
> >
> > +static int etnaviv_ioctl_reset_query(struct drm_device *dev, void *data,
> > +             struct drm_file *file)
> > +{
> > +     struct etnaviv_drm_private *priv = dev->dev_private;
> > +     struct etnaviv_file_private *ctx = file->driver_priv;
> > +     struct drm_etnaviv_reset_query *args = data;
> > +     struct etnaviv_gpu *gpu;
> > +
> > +     if (args->flags)
> > +             return -EINVAL;
> > +
> > +     if (args->pipe >= ETNA_MAX_PIPES)
> > +             return -EINVAL;
> > +
> > +     gpu = priv->gpu[args->pipe];
> > +     if (!gpu)
> > +             return -ENXIO;
> > +
> > +     args->global_reset_counter = gpu->reset_counter;
> > +     args->context_reset_counter = ctx->reset_counter;
>
> Reading those values still has the chance to race with the timeout
> handler updating the values. Failure mode would be timeout handler
> running up until update of the global reset counter, then the readout
> passing back both values to userspace, timeout handler updating the
> context reset counter. Userspace would see a innocent context reset due
> to only the global counter moving, while in reality it was guilty
> context reset.
>
> I guess the easiest way to ensure atomic updates of both values would
> be to take the gpu mutex here and across the update of both values.
>

Right, that window exists and it reports exactly the wrong thing to
the guilty context. I now take the gpu lock across both increments in
the timeout handler and across the readout here, so the query can
never see the global counter move without the context counter.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
