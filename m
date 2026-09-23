Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B45C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CFA10F1BF;
	Wed, 23 Sep 2026 20:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="knbAFSdY";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889B710F12E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790196393; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C1P64JmQdnZ7KTsE5DWlaCZCRVwMf8WDZu3L+Z/v1Icp3TXPRINQ+Y3MWb3FcvcPsUckvoErI+QU7s0me6UFdP/ApPrwEjO2APwJwlk2jXSX6TrIzCwoZOVvxRePTpf/RxYIg+YssOVBqu+Gnr3+I7jFdhNAZYjzaHw8nhn1udE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790196393;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dI1IRPaXAKV6euhKlFcYS2M7qRMLjuoyrJ5Z0Fdu1Jk=; 
 b=ZSDVxc68qbmd/Md8dSaCpObns3FsAB43J8/OSCqhSNwXKP9Tymy7LNrkk16YuOWDd54o6n7ioryJaB/uF9x5pZq1AzCbUR7+Iiwk+R3IaFk4GJ7L2idurZTwzC8RcGZnk4UXa9bPH5c0ILNBNhIPLCRYcR1ENfMYuUj5yWUubH0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790196393; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=dI1IRPaXAKV6euhKlFcYS2M7qRMLjuoyrJ5Z0Fdu1Jk=;
 b=knbAFSdY4muvskO60BsJDyIdfF2q0TUsTsTvcGM2BYJmjuTTylVnMmBcM7YNeOkF
 aJoWXSUx4T+zbiC386j7PIwHzuH/kcWH7hn5QduKa+uqECN5e9x8zHNAd/Bu3a5kHwk
 BRRDYqfCfObB31/gYYaEVAfwXwfS7SgyTwymXrTg=
Received: by smtp.zohomail.com with SMTPS id 179019639108973.72346704231336;
 Wed, 23 Sep 2026 13:46:31 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:46:25 +0100
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
Subject: Re: [PATCH v9 06/16] drm/panfrost: Fix PM refcnt and autosuspend
 issues at device probe/remove
Message-ID: <arQ6dUZniIpdVnFq@sobremesa>
References: <20260914112237.70dedb9c@fedora-21.home>
 <arGhZayS8zH4y-61@sobremesa>
 <20260923100049.6c127f3a@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923100049.6c127f3a@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.183.46
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

On 23.09.2026 10:00, Boris Brezillon wrote:
> On Tue, 22 Sep 2026 20:51:48 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > On 14.09.2026 11:22, Boris Brezillon wrote:
> > > On Sat, 12 Sep 2026 00:28:07 +0100
> > > Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> > >   
> > > > During device probe(), failure to do a PM get() will leave the usage_count
> > > > set to 0, which is the value assigned at device creation time. That means
> > > > when the autosuspend delay expires, runtime suspend callback won't be
> > > > invoked, so the device will remain powered on forever.
> > > > 
> > > > On top of that, failure to call PM put() during device unplug means
> > > > Panfrost device's PM usage_count increases monotonically for every new
> > > > module reload.
> > > > 
> > > > The outcome of both of the above meant that:
> > > > 
> > > > - Devfreq OPP transition notifications would be printed all the time,
> > > >   even when no jobs are being submitted. This quickly fills the kernel
> > > >   ring buffer with junk.
> > > > - Because MMU interrupts are only enabled when the device is reset,
> > > >   the very first job targeting the tiler heap BO after device probe()
> > > >   would always time out, since the driver's PM runtime resume callback
> > > >   would not be invoked.
> > > > 
> > > > To fix the above:
> > > > - Manually adjust the PM refcnt at device probe and removal time.
> > > > - Ensure pm_runtime_dont_use_autosuspend is called in the wind-down path.
> > > > - Call pm_runtime_put_autosuspend() when device is ready to accept jobs
> > > > - Move pm_runtime_set_suspended() before panfrost_device_fini() so that
> > > >   resource unwinding happens in the opposite order as initialisation.
> > > > 
> > > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > > > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > > > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > > > ---
> > > >  drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > index 55fc22e8d4d4..a3eff77add55 100644
> > > > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > > > @@ -854,6 +854,7 @@ static int panfrost_probe(struct platform_device *pdev)
> > > >  
> > > >  	pm_runtime_set_active(pfdev->base.dev);
> > > >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> > > > +	pm_runtime_get_noresume(pfdev->base.dev);
> > > >  	pm_runtime_enable(pfdev->base.dev);
> > > >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> > > >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> > > > @@ -866,13 +867,16 @@ static int panfrost_probe(struct platform_device *pdev)
> > > >  	if (err < 0)
> > > >  		goto err_out1;
> > > >  
> > > > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> > > >  
> > > >  	return 0;
> > > >  
> > > >  err_out1:
> > > > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > > >  	pm_runtime_disable(pfdev->base.dev);
> > > > -	panfrost_device_fini(pfdev);
> > > > +	pm_runtime_put_noidle(pfdev->base.dev);
> > > >  	pm_runtime_set_suspended(pfdev->base.dev);
> > > > +	panfrost_device_fini(pfdev);  
> > > 
> > > Not an issue per-se, because put_noidle() is a NOP, but I think it'd be
> > > easier to reason about with this order:
> > > 
> > > 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > >   	pm_runtime_disable(pfdev->base.dev);
> > > 	panfrost_device_fini(pfdev);
> > >   	pm_runtime_set_suspended(pfdev->base.dev);
> > > 	pm_runtime_put_noidle(pfdev->base.dev);
> > > 
> > > This makes it clear that panfrost_device_fini() assumes the device is
> > > resumed when it's called and suspended when it returns.  
> > 
> > Your suggestion feels more natural, which makes me wonder why I decided to move
> > panfrost_device_fini() to the end of the block. 
> > 
> > IIRC we chatted about where to place pm_runtime_put_noidle() and pm_runtime_set_suspended()
> > in panfrost_device_init() when one of the subsystem initialisations failed. My intuition
> > had been to leave them until the very bottom of it, in imitation of what you hinted here,
> > but then it'd go against the notion that winding down must be done in the opposite order
> > as initialisation. And so because panfrost_device_init() happens before all the pm_runtime_*
> > incantations, I thought panfrost_device_fini() should be placed at the end in the error
> > and driver remove paths.
> > 
> > That said, I think a more intuitive init order would be one that imitates what happens in
> > Panthor when runtime PM is enabled:
> > 
> > 	/* First thing done in pm_runtime_resume_and_get -> pm_runtime_get_active -> __pm_runtime_resume */
> > 	pm_runtime_get_noresume(pfdev->base.dev);
> 
> Panthor is a bit different in that it doesn't use noresume/noidle() at
> all. What it does instead is teach the resume/suspend hooks about the
> uninitialized device use case, and it skips some operations when a
> resume/suspend() is done on an uninitialized dev. Panfrost, on the other
> hand, just assumes that clks are enabled manually before any of the
> subsystem _init() helpers are called. TLDR; this
> pm_runtime_get_noresume() can be moved after all the _init() without
> any downsides, and it keeps all PM related-init in just one place,
> which I find neat.
> 
> > 	
> > 	/* Now come subsystem initialisations */
> > 	panfrost_gpu_init(pfdev);
> > 	panfrost_mmu_init(pfdev);
> > 	panfrost_jm_init(pfdev);
> > 	panfrost_perfcnt_init(pfdev);
> > 	panfrost_gem_init(pfdev);
> > 	
> > 	/* __pm_runtime_resume -> rpm_resume first invokes the resume callback and then
> > 	 * updates runtime status to RPM_ACTIVE. */
> > 	pm_runtime_set_active(pfdev->base.dev);
> > 	
> > 	pm_runtime_enable(ptdev->base.dev);
> >         pm_runtime_mark_last_busy(pfdev->base.dev);
> > 	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> > 	pm_runtime_use_autosuspend(pfdev->base.dev);
> > 
> > And then in the error and device remove path would be almost just like you suggest.
> > 
> >         pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > 	pm_runtime_disable(pfdev->base.dev);
> > 	pm_runtime_put_noidle(pfdev->base.dev);
> > 	panfrost_device_fini(pfdev);
> > 	pm_runtime_set_suspended(pfdev->base.dev);
> > 
> > The only difference is that pm_runtime_put_noidle() happens before device_fini
> > because that's the same order as in __pm_runtime_suspend().
> 
> I really think we should keep the init/fini order consisten, so
> put_noidle() should be after the _fini() calls. But as I said above,
> I'd probably have get_noresume() called after all the _init() functions
> instead, since we can afford it in Panfrost, and it helps keeping all
> the PM-related calls in just one block.
> 
> > 
> > However, that means in the commit where I move all DRM initialisation into
> > panfrost_device_init(), in order to keep things consistent, I should move
> > pm_runtime_set_suspended() to the very end of the error path.
> 
> It probably doesn't matter much actually, because as soon as
> pm_runtime_disable() is called, nothing can change the RPM state
> anymore. So maybe scratch all of my comments, and we stick to what you
> had. It's just a transition state anyway, so, as long as it doesn't
> regress the probe/remove logic, it's probably fine.

I think I'll leave it the way it is and then add a comment that explains
why the manual adjustment of PM references and status. 

> > 
> > > >  err_out0:
> > > >  	return err;
> > > >  }
> > > > @@ -884,9 +888,11 @@ static void panfrost_remove(struct platform_device *pdev)
> > > >  	drm_dev_unregister(&pfdev->base);
> > > >  
> > > >  	pm_runtime_get_sync(pfdev->base.dev);
> > > > +	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > > > +	pm_runtime_put_noidle(pfdev->base.dev);
> > > >  	pm_runtime_disable(pfdev->base.dev);  
> > > 
> > > Let's keep the order consistent with the probe path:
> > > 
> > > 	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
> > > 	pm_runtime_disable(pfdev->base.dev);
> > > 	panfrost_device_fini(pfdev);
> > > 	pm_runtime_set_suspended(pfdev->base.dev);
> > > 	pm_runtime_put_noidle(pfdev->base.dev);
> > > 
> > > I also think this deserves comments to explain the noresume/noidle
> > > dance (device_init/fini take care of clks internally, and when they
> > > return the device is resumed/suspended, so all we have to is update the
> > > state, and acquire a ref).  
> > 
> > I don't mind doing this, but I think the fact we're calling noresume/noidle
> > functions already implies device power-up is being handled manually rather
> > by having RPM invoke resume and suspend callbacks behind the scenes, so
> > we've no choice other than adjusting PM user counter and status ourselves.
> 
> Fair enough.

Adrian Larumbe
