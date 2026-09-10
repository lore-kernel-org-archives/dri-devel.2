Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC70EC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0949710F369;
	Thu, 10 Sep 2026 08:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bSPOkJ7X";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F199910E268;
 Thu, 10 Sep 2026 08:23:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35A53600C8;
 Thu, 10 Sep 2026 08:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED0E1F000FF;
 Thu, 10 Sep 2026 08:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789028612;
 bh=06iaFjrDTtz5vxdHYD8lRVtKh/ebrJbiKm14MgNOKSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bSPOkJ7X/Avt5H4ceFbrvQgXFeLLwijp0hDB7tFN/l6/j7JtjDmwl/Q+rekWFNpaS
 Wf+TMJVdUokSb80nNaZhGVlSfg/kID4J8lAG0rx+jhSSO6TVU666b4xwPkNJXszsWa
 vZgU6K8VxPgV9uwyAmIbyICEfT5VuCL1asDGeQb6+LPUmbGxLO9y69BxLcWepgzIsO
 ztrlKKKhbZoCzRj+ianvqagfBRnCsEKEokikgksRnjHC5cNdQ26v/vxJFy/0skGikd
 ygPSmeEmfF14Y4REbkR3cgjygXApbvP6BoVlAzT2yOdOqNMBcB/x015d4lXx2NWQIr
 BFGBs1EVKT1pA==
Date: Thu, 10 Sep 2026 10:23:29 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Krzysztof Karas <krzysztof.karas@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm: Unwind drm device registration upon error
Message-ID: <aqHmZGkTlO9dcfmE@zenone.zhora.eu>
References: <20260827143447.99553-1-krzysztof.niemiec@intel.com>
 <20260827143447.99553-2-krzysztof.niemiec@intel.com>
 <apC_eePJyeGnVQTG@zenone.zhora.eu>
 <apf2bCiuKcmcRHUT@kniemiec-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apf2bCiuKcmcRHUT@kniemiec-mobl1>
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

Hi Krzysztof,

> > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > index e51ed959da89..b98e8af6f1c1 100644
> > > --- a/drivers/gpu/drm/drm_drv.c
> > > +++ b/drivers/gpu/drm/drm_drv.c
> > > @@ -1140,6 +1140,8 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
> > >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> > >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
> > >  	drm_minor_unregister(dev, DRM_MINOR_RENDER);
> > > +	drm_debugfs_dev_fini(dev);
> > 
> > I think sashiko is right here, this should be removed.
> > 
> > > +	dev->registered = false;
> > 
> > dev->registered = false should be set at the very beginning,
> > maybe something like this:
> 
> Why? Is .unload() supposed to expect dev->registered = false? I've seen
> that moving the flag around might(?) make a bit of a mess (e0f32f78e51b),
> and before this patch .unload() is being called with registered = true.
> So changing it at the beginning of the unwind might mess up drivers that
> rely on it, but it will make no difference for drivers that don't, so
> I'd rather keep it this way. Unless we make explicit guarantees that
> .unload() will be called with ->registered = false, in the middle of the
> call to drm_dev_register().

that's what happens in drm_dev_unregister() and that's not a
random choice. If you grep for "dev->registered", you will see
that it's in the unload path and it can warn if it's true.

Of course this does not affect all the drivers, like i915, but
others might get upset.

Andi
