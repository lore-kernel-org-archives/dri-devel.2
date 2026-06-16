Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7976DCD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3EA10E665;
	Tue, 16 Jun 2026 19:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GeNCVNxJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DB210E665
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 19:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781639305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OwQmF6a0MBQulcy9vsdQV2YD+kMRaIVrNR12C1u/kVUl+XnalMOYATNh4nr7KlYsxU7GizDfV11L2/YOOSSx99VhJg3aLah8y/5OezWdWoRiOrCr1qR/L+irJIzZXfx48H3FwQUT2cR+Z/PCaPCiVB+KCDv95wscDyJBG+wGt2c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781639305;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=P1zqWBMiSEg6eraAaC2x1b5nQhRS3dgZDM0hA0HtxG4=; 
 b=oC3kp1DQP9zt+D3UF12BRE/cF8R0CR4G6e3zdR3GqzVRd9ImiHfDISqAz//BNZ14+kATB/IJLyyJ7aoKwVTJl0itjIIlt+zFptz8O4ByQ4cMVdMcasx2z2O2QKJOI0XdBumuaIQKHsHFPYh0gunT6IIv7a43vfc05IGHyrPXbiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781639305; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=P1zqWBMiSEg6eraAaC2x1b5nQhRS3dgZDM0hA0HtxG4=;
 b=GeNCVNxJGhNFUq+DyjVjlauK6xYcx+SPN/Ez/D/O1HOW22g9Sq8HnB7RH0dmaLa2
 OXr/WaysOCMG009+b1tjciFnbCcRH0KCGnn/mtbtAXYqFCIhzA6fLCG0RnFsED4zpLS
 7M35XDT+nrH5wiM4LFiho4ZxLzrweaOXENXaIMFs=
Received: by mx.zohomail.com with SMTPS id 1781639304959241.30848604580262;
 Tue, 16 Jun 2026 12:48:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 20:48:19 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
Message-ID: <ajGicH-AkZlDAtEd@sobremesa>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
 <57571cae-dac7-4550-a634-c2889a961c7b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57571cae-dac7-4550-a634-c2889a961c7b@arm.com>
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

On 05.06.2026 11:48, Steven Price wrote:
> On 04/06/2026 18:35, Adrián Larumbe wrote:
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
> >  	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> 
> Sashiko is concerned that dropping the usage count before
> pm_runtime_disable() could cause things to turn off too early, and I
> have to agree it sounds like it could be a problem:
> 
> Sashiko wrote:
> > Does dropping the usage count before pm_runtime_disable() create a race
> > condition where the suspend callback can run and disable clocks before
> > hardware shutdown?
> > Because the usage count is dropped early, a concurrent PM event could trigger
> > the suspend callback, disabling clocks. Then, panfrost_device_fini() calls
> > panfrost_gpu_fini() which writes to MMIO registers. Could writing to
> > unclocked registers on ARM SoCs cause fatal bus errors or panics?

I think this could be an issue if the device were already registered and someone
could drive the pm resume and then suspend sequence through an ioctl, but because
this is an error path and yet the device was never made available, I can't imagine
how this could happen.

Maybe if the panfrost device had any children devices, and when one of them did a
put autosuspend, the refcnt would be propagdated back to Panfrost and then trigger
the scenario described by shashiko.

However, I've just realised it's alright to call pm_runtime_put_noidle() even after
pm_runtime_disable(). Seems that the latter just prevents any further suspends or
resumes on the PM device, but we're still in control of the refcnt, so moving
pm_runtime_put_noidle() right after panfrost_device_fini() should be fine.

> Sashiko also suggests we might have some other (partially pre-existing)
> issues here.
> 
> https://sashiko.dev/#/patchset/20260604-claude-fixes-v2-0-57c6bd4c1655%40collabora.com

I'll look into all the pre-existing issues and write fixes for the next patch series revision.

> Thanks,
> Steve
> 
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
