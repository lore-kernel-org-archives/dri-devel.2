Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA5AC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC11210F291;
	Wed,  2 Sep 2026 15:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="I9ueizmN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AAF810F291
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788363513; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FDECfZcHqChbNWONRZUuvX17kXnV/ISbiwnPVczXZai+/NeOWh8f9ERvWJFxFwpx0wjM3lR7R2nillDSLrAjkG6phSqmOQdYJJUVY+YGkf5vy1c4qnEDDpdeOi2scM3OEwvxxzLuTfxwVRu4CTzlNUZjRLA20OdhIoSiE+hNyQk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788363513;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=b7/tuXGv+XifNfRR85GU3v12h5Bk9fWAXOC4mGSb/VE=; 
 b=Nu7maI9DBb31bx7jbPdlPVIE/iXDzPQ4zGcW+voFJHkiqeeFDQBn4jpQOm+TTs+/9lCxQ3MpM4RZL9YLjgCASBS9stKQyJA1hf/lBMmpvWDSsHas6ws4QSvbIMWqxXJ9YwBm/GwdwKu4KGhxtMGd686TBhPokKThjvYYD/gOqgY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788363513; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=b7/tuXGv+XifNfRR85GU3v12h5Bk9fWAXOC4mGSb/VE=;
 b=I9ueizmNJTEjRq39nYWoS3qVjdEawBtGLopoHtieZ3oAAKeMPrmUC5DCssnk9IUC
 Wemv5jcNsXflGfxzlc65Y7EvqsFgwTJmDrlrB5fAqsMKNvXwMjQEsbUc/LkUZ+pYZvw
 pWq5vS1h/2YEWhAAgCi1JD4HIEHGEk8wWqsnrI3k=
Received: by mx.zohomail.com with SMTPS id 1788363511003811.5139964342504;
 Wed, 2 Sep 2026 08:38:31 -0700 (PDT)
Date: Wed, 2 Sep 2026 16:38:25 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v7 02/17] drm/panfrost: Move all DRM device
 initialisation into device_init()
Message-ID: <aphC0QRm5MricnRp@sobremesa>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-2-72a13b2c125d@collabora.com>
 <20260901134951.1e1d7fda@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901134951.1e1d7fda@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.352.18
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

On 01.09.2026 13:49, Boris Brezillon wrote:
> On Fri, 28 Aug 2026 21:56:42 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Ideally the probe() function will do as little as possible, and all device
> > initialisation and registration should happen inside the panfrost device
> > subsystem, just like it's done in Panthor. This also simplifies resource
> > unwinding in the error path.
> > 
> > Do the same thing for DRM driver remove, as in, sweep most of the action
> > into panfrost_device_fini(), just like we did for device probe.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 33 ++++++++++++++++++++++
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    | 44 +-----------------------------
> >  2 files changed, 34 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 05c40d5a20b5..d2d2830f11a7 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <drm/drm_drv.h>
> >  
> >  #include "panfrost_device.h"
> >  #include "panfrost_devfreq.h"
> > @@ -216,6 +217,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  {
> >  	int err;
> >  
> > +	pfdev->comp = of_device_get_match_data(pfdev->base.dev);
> > +	if (!pfdev->comp)
> > +		return -ENODEV;
> > +
> > +	pfdev->coherent = device_get_dma_attr(pfdev->base.dev) == DEV_DMA_COHERENT;
> > +
> > +	mutex_init(&pfdev->shrinker_lock);
> > +	INIT_LIST_HEAD(&pfdev->shrinker_list);
> > +
> >  	mutex_init(&pfdev->sched_lock);
> >  	INIT_LIST_HEAD(&pfdev->as_lru_list);
> >  
> > @@ -284,8 +294,25 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	if (err)
> >  		goto out_perfcnt;
> >  
> > +	pm_runtime_set_active(pfdev->base.dev);
> > +	pm_runtime_mark_last_busy(pfdev->base.dev);
> > +	pm_runtime_enable(pfdev->base.dev);
> > +	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> > +	pm_runtime_use_autosuspend(pfdev->base.dev);
> > +
> > +	/*
> > +	 * Register the DRM device with the core and the connectors with
> > +	 * sysfs
> > +	 */
> > +	err = drm_dev_register(&pfdev->base, 0);
> > +	if (err < 0)
> > +		goto out_devreg;
> > +
> >  	return 0;
> >  
> > +out_devreg:
> 
> Not a huge fan of labels that describe where this is jumped from instead
> of what is done under the label (that gets particularly confusing when
> you start multiple locations jumping to the same label). So I'd suggest
> renaming that one err_disable_rpm.

Will rename in the next revision.

> > +	pm_runtime_disable(pfdev->base.dev);
> 
> I think you need a pm_runtime_dont_use_autosuspend() call before
> pm_runtime_disable().
> 
> > +	panfrost_gem_fini(pfdev);
> >  out_perfcnt:
> >  	panfrost_perfcnt_fini(pfdev);
> >  out_job:
> > @@ -304,11 +331,15 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	panfrost_reset_fini(pfdev);
> >  out_pm_domain:
> >  	panfrost_pm_domain_fini(pfdev);
> > +	pm_runtime_set_suspended(pfdev->base.dev);
> 
> Do we have a good reason for not flagging the device suspended just
> after the pm_runtime_disable() call in the error path? I mean, sure
> it's not truly suspended until the clks/regulators have been turned
> off, but it also wasn't suspended the before the initial
> pm_runtime_set_active() call, and I like the idea of undoing things in
> reverse init order.

That was my thought when I put it at the end, although since we manually
manage device power down here rather than going through the RPM runtime
suspend callback, I guess it makes no difference.

> but it also wasn't suspended the before the initial pm_runtime_set_active() call

I think devices begin their lifetime with power.runtime_status set to RPM_SUSPENDED:
drivers/base/power/runtime.c::pm_runtime_init

> >  	return err;
> >  }
> >  
> >  void panfrost_device_fini(struct panfrost_device *pfdev)
> >  {
> > +	pm_runtime_get_sync(pfdev->base.dev);
> 
> 	pm_runtime_dont_use_autosuspend();
> 
> I see it fixed in patch 9, just like a few other issues that are made
> more apparent by this code motion change. I guess it's fine but it
> confused me, so it might be worth mentioning in the commit message.
> 
> 
> > +	pm_runtime_disable(pfdev->base.dev);
> > +
> >  	panfrost_gem_fini(pfdev);
> >  	panfrost_perfcnt_fini(pfdev);
> >  	panfrost_jm_fini(pfdev);
> > @@ -319,6 +350,8 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
> >  	panfrost_clk_fini(pfdev);
> >  	panfrost_reset_fini(pfdev);
> >  	panfrost_pm_domain_fini(pfdev);
> > +
> > +	pm_runtime_set_suspended(pfdev->base.dev);
> 
> Fixed in patch 9, but the RPM ref you acquire at the beginning of the
> function is never returned, so you end up with an unbalanced get/put.
> This is a pre-existing issue, I know, this catches the eye of the
> reviewer so we better mention that existing issues around PM are
> preserved and will be fixed later.

Maybe I should apply those fixes first and then rebase this patch in top of them?

> >  }
> >  
> >  #define PANFROST_EXCEPTION(id) \
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 9882a3ede75f..80996e311a9d 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -964,7 +964,6 @@ MODULE_PARM_DESC(transparent_hugepage, "Use a dedicated tmpfs mount point with T
> >  static int panfrost_probe(struct platform_device *pdev)
> >  {
> >  	struct panfrost_device *pfdev;
> > -	int err;
> >  
> >  	pfdev = devm_drm_dev_alloc(&pdev->dev, &panfrost_drm_driver,
> >  				   struct panfrost_device, base);
> > @@ -973,45 +972,7 @@ static int panfrost_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, pfdev);
> >  
> > -	pfdev->comp = of_device_get_match_data(&pdev->dev);
> > -	if (!pfdev->comp)
> > -		return -ENODEV;
> > -
> > -	pfdev->coherent = device_get_dma_attr(&pdev->dev) == DEV_DMA_COHERENT;
> > -
> > -	mutex_init(&pfdev->shrinker_lock);
> > -	INIT_LIST_HEAD(&pfdev->shrinker_list);
> > -
> > -	err = panfrost_device_init(pfdev);
> > -	if (err) {
> > -		if (err != -EPROBE_DEFER)
> > -			dev_err(&pdev->dev, "Fatal error during GPU init\n");
> > -		goto err_out0;
> > -	}
> > -
> > -	pm_runtime_set_active(pfdev->base.dev);
> > -	pm_runtime_mark_last_busy(pfdev->base.dev);
> > -	pm_runtime_enable(pfdev->base.dev);
> > -	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> > -	pm_runtime_use_autosuspend(pfdev->base.dev);
> > -
> > -	/*
> > -	 * Register the DRM device with the core and the connectors with
> > -	 * sysfs
> > -	 */
> > -	err = drm_dev_register(&pfdev->base, 0);
> > -	if (err < 0)
> > -		goto err_out1;
> > -
> > -
> > -	return 0;
> > -
> > -err_out1:
> > -	pm_runtime_disable(pfdev->base.dev);
> > -	panfrost_device_fini(pfdev);
> > -	pm_runtime_set_suspended(pfdev->base.dev);
> > -err_out0:
> > -	return err;
> > +	return panfrost_device_init(pfdev);
> >  }
> >  
> >  static void panfrost_remove(struct platform_device *pdev)
> > @@ -1020,10 +981,7 @@ static void panfrost_remove(struct platform_device *pdev)
> >  
> >  	drm_dev_unregister(&pfdev->base);
> >  
> > -	pm_runtime_get_sync(pfdev->base.dev);
> > -	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> > -	pm_runtime_set_suspended(pfdev->base.dev);
> >  }
> >  
> >  static ssize_t profiling_show(struct device *dev,
> > 

Adrian Larumbe
