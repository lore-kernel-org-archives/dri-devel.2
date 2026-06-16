Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00675CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5666210E861;
	Tue, 16 Jun 2026 20:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ghv1pScj";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBEC10E861
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 20:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781641080; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jXS7m2mRItTBfh1bSCJmwSG8JqcVIPfds8FiTX4bkkEmwAesdCu/+SlH2YOIYLrrOwdF041ufy+fJhN023SycUxBvqMMWu+ch2l/ZKFoka58US008KAheeoDa1Q6Ijjl62bH5+wFoJjTJuAl7JvyR+SMe3K6WF6GCKPtt7LoJ5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781641080;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7i/i/rfSGAKD4jv6l+xF2KCC9w4D3tojuR0zfnb0cds=; 
 b=Xem0T5Sn813FH1cYEp5zFHQLP7yZFd3e3NdGrHZJuCO9PuNOVq3s6adAH0lEvEabGfqYhtMiVfqmMYxqc7aKBuh3TB1jCVCKq74tGYriIDplykGjh5HlOZbFITBMxNYo5SffyZN/NjwrFY7Sp/8H9SV239LM/bgouu+cwMW1Hps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781641080; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=7i/i/rfSGAKD4jv6l+xF2KCC9w4D3tojuR0zfnb0cds=;
 b=Ghv1pScjFioZd5ijyXqzQuz9wafZ4WbconutIrGr1uWODgsC9SomzqDykkkbkjX2
 wgVFTzhIKObrRBardycnpKyjVcmMOwEV7amEMHBdl/aE/xqrT4Cx6kmjyGCM50H2cbe
 gjeON8CwOdn/q38fzNhbmMY6ViNmXnmtofhUTkE8=
Received: by mx.zohomail.com with SMTPS id 1781641079082910.101149085434;
 Tue, 16 Jun 2026 13:17:59 -0700 (PDT)
Date: Tue, 16 Jun 2026 21:17:53 +0100
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
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
Message-ID: <ajGpN5x-SnC9y6pa@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
 <20260604203631.20e76f5f@fedora-2.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604203631.20e76f5f@fedora-2.home>
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

On 04.06.2026 20:36, Boris Brezillon wrote:
> On Thu, 04 Jun 2026 18:35:25 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > During device probe(), failure to do a PM get() will leave the usage_count
> > set to 0, which is the value assigned at device creation time. That means
> > when the autosuspend delay expires, runtime suspend callback won't be
> > invoked, so the device will remain powered on forever.
> > 
> > On top of that, failure to call PM put() during device unplug means
> > Panfrost device's PM usage_count increases monotonically for every new
> > module reload.
> > 
> > The combined outcome of both of the above was that devfreq OPP transition
> > notifications would be printed all the time, even when no jobs are being
> > submitted. This quickly fills the kernel ring buffer with junk.
> > 
> > Even direr than that was the fact MMU interrupts are only enabled when
> > the device is reset, so after device probe() the very first job targeting
> > the tiler heap BO would always time out, because the driver's PM runtime
> > resume callback would not be invoked.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 2d4b6aa95c66..545fbf2c8d0c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -989,6 +989,7 @@ static int panfrost_probe(struct platform_device *pdev)
> >  	pm_runtime_set_active(pfdev->base.dev);
> >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> >  	pm_runtime_enable(pfdev->base.dev);
> > +	pm_runtime_get_noresume(pfdev->base.dev);
> >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> >  
> > @@ -1000,10 +1001,12 @@ static int panfrost_probe(struct platform_device *pdev)
> >  	if (err < 0)
> >  		goto err_out1;
> >  
> > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> >  
> >  	return 0;
> >  
> >  err_out1:
> > +	pm_runtime_put_noidle(pfdev->base.dev);
> 
> Do we really need this get_noresume/put_noidle dance, can't use call
> pm_runtime_dont_use_autosuspend() instead like is done in panthor, or
> is panthor broken too?

We need get_noresume() because after panfrost_device_init(), the device is powered
up but that is not reflected in the device's PM refcnt. Then pm_runtime_put_autosuspend()
will decrement the refcnt back to 0 and let the autosuspend window expire before
suspending the device, unless someone starts using it immediately.

pm_runtime_dont_use_autosuspend() is not mandatory if we manually call pm_runtime_disable()
at device unplug time or when probe() fails. pm_runtime_use_autosuspend()'s docs say:

pm_runtime_use_autosuspend - Allow autosuspend to be used for a device.
@dev: Target device.
Allow the runtime PM autosuspend mechanism to be used for @dev whenever
requested (or "autosuspend" will be handled as direct runtime-suspend for
it).
NOTE: It's important to undo this with pm_runtime_dont_use_autosuspend()
at driver exit time unless your driver initially enabled pm_runtime
with devm_pm_runtime_enable() (which handles it for you).

Panthor uses devm_pm_runtime_enable(), which makes me suspect perhaps it doesn't need
to explicitly call pm_runtime_dont_use_autosuspend().

Panthor also manages PM refcnt fine at driver probe(), inside panthor_device_init():

``` c
ret = pm_runtime_resume_and_get(ptdev->base.dev);
if (ret)
	return ret;

/* If PM is disabled, we need to call panthor_device_resume() manually. */
if (!IS_ENABLED(CONFIG_PM)) {
	ret = panthor_device_resume(ptdev->base.dev);
	if (ret)
		return ret;
}
```

If we want a similar thing in Panfrost, then we should move all clock and devfreq enablement
into panfrost_device_runtime_resume() and do pm_runtime_resume_and_get() right before
panfrost_gpu_init().

> >  	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> >  	pm_runtime_set_suspended(pfdev->base.dev);
> > @@ -1018,8 +1021,9 @@ static void panfrost_remove(struct platform_device *pdev)
> >  	drm_dev_unregister(&pfdev->base);
> >  
> >  	pm_runtime_get_sync(pfdev->base.dev);
> > -	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> > +	pm_runtime_put_noidle(pfdev->base.dev);
> > +	pm_runtime_disable(pfdev->base.dev);
> >  	pm_runtime_set_suspended(pfdev->base.dev);
> >  }
> >  
> > 

Adrian Larumbe
