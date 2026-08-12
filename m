Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E8EC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F63110E3AB;
	Wed, 12 Aug 2026 01:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ON1zWjq7";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9735610E3AB
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 01:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786497347; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jwm6FfqUjiam6ew0QjnrfO0PbeHtEWJrelRRIOU5dULkFE18BX6t5mCpMC90zeBxzNzCGtep8x24HWgmVhYS0ez2np1c38N9PTxCEasTEL7FSU2EHPqPMtjiJfuAdFbejUyl2FEEI2PD0r8tSx0FWNHrTbulnsmPJQX12w75Vxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786497347;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Dm3+HgIpf5VvTbYZyAahKPM47XxMgKX9Mle8ZusGOpo=; 
 b=ltUb5w5c/siQSSiqM36ZyQpIv0CHsKbq+zEhVy5fkNN6W8O02ZAue0kHoydjIDwSNSY+fR0kX23VIne5fuscP0u6Ee6PGY2ZmlfwssRW7/sW9/XwXuGT8WW+r6HD5rSqOvFNdJsxXIxQl6Nf96uyt8fBEzEERkTBmKInQlyAO4M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786497347; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=Dm3+HgIpf5VvTbYZyAahKPM47XxMgKX9Mle8ZusGOpo=;
 b=ON1zWjq7z+e1uxXEOV4KA1vDzJ+c0IUoSY8osB235z3uV3iPnrIA+5ZK+LNLql2l
 sKnpG5CTmLDEAgOhzuI7ce278ZtE8e0BQ4lzgyZQp7QK1KQsbpY+Z5seLNts9bGVQ4K
 H1i/p6dUl7j6B88wXPALrp9MYbYTNCPWj0kO0/38=
Received: by mx.zohomail.com with SMTPS id 1786497345496126.68169845097657;
 Tue, 11 Aug 2026 18:15:45 -0700 (PDT)
Date: Wed, 12 Aug 2026 02:15:39 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
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
Subject: Re: [PATCH v4 05/13] drm/panfrost: Move all device power up and down
 into RPM callbacks
Message-ID: <anvHD9ukxqI1IOss@sobremesa>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
 <aae0436c7594c3380786a319b053c12c9e685ccb.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aae0436c7594c3380786a319b053c12c9e685ccb.camel@pengutronix.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/286.485.37
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

Hi Philipp,

On 29.07.2026 10:37, Philipp Zabel wrote:
> On Mi, 2026-07-29 at 03:54 +0100, Adrián Larumbe wrote:
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
> > Fix all that by moving all GPU enabling and disabling into RPM resume and
> > suspend callbacks, and making sure we resume the device right before
> > touching any HW registers. This is done in imitation of the Panthor model.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> > Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 375 +++++++++++++++++------------
> >  drivers/gpu/drm/panfrost/panfrost_device.h |   9 +
> >  drivers/gpu/drm/panfrost/panfrost_drv.c    |  10 +-
> >  drivers/gpu/drm/panfrost/panfrost_gpu.c    |   7 +-
> >  drivers/gpu/drm/panfrost/panfrost_job.c    |   7 +-
> >  5 files changed, 237 insertions(+), 171 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index 03905495aee2..a9d29d9ee22b 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -34,6 +34,40 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
> >  	reset_control_assert(pfdev->rstc);
> >  }
> >  
> > +static int panfrost_clk_enable(struct panfrost_device *pfdev)
> > +{
> > +	int err;
> > +
> > +	err = clk_enable(pfdev->clock);
> > +	if (err)
> > +		return err;
> > +
> > +	err = clk_enable(pfdev->bus_clock);
> > +	if (err)
> > +		goto disable_clock;
> > +
> > +	err = clk_enable(pfdev->bus_ace_clock);
> > +	if (err)
> > +		goto disable_bus_clock;
> > +
> > +	return 0;
> > +
> > +disable_bus_clock:
> > +	clk_disable(pfdev->bus_clock);
> > +disable_clock:
> > +	clk_disable(pfdev->clock);
> > +
> > +	return err;
> > +}
> > +
> > +static void panfrost_clk_disable(struct panfrost_device *pfdev)
> > +{
> > +	clk_disable(pfdev->bus_ace_clock);
> > +	clk_disable(pfdev->bus_clock);
> > +	clk_disable(pfdev->clock);
> > +	reset_control_assert(pfdev->rstc);
> > +}
> 
> This asymmetry is weird. Why assert the reset control in
> panfrost_clock_disable() but not deassert it in panfrost_clk_enable()?
> It's also unexpected to have a function called _clk_disable do
> something else.

You're right about this. In a newer revision, I've made sure to deassert the reset
control in panfrost_clk_enable() and enable in panfrost_clock_disable().
I've also renamed both functions so that they reflect their handling of the reset
control, besides managing the clocks.

> > +
> >  static int panfrost_clk_init(struct panfrost_device *pfdev)
> >  {
> >  	int err;
> > @@ -48,7 +82,7 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
> >  	rate = clk_get_rate(pfdev->clock);
> >  	dev_info(pfdev->base.dev, "clock rate = %lu\n", rate);
> >  
> > -	err = clk_prepare_enable(pfdev->clock);
> > +	err = clk_prepare(pfdev->clock);
> >  	if (err)
> >  		return err;
> >  
> > @@ -57,44 +91,55 @@ static int panfrost_clk_init(struct panfrost_device *pfdev)
> [...]
> >  static void panfrost_clk_fini(struct panfrost_device *pfdev)
> >  {
> > -	clk_disable_unprepare(pfdev->bus_ace_clock);
> > -	clk_disable_unprepare(pfdev->bus_clock);
> > -	clk_disable_unprepare(pfdev->clock);
> > +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
> > +		panfrost_clk_disable(pfdev);
> 
> So here you are effectively adding a reset_control_assert() that wasn't
> there before. That seems to be intentional because you are removing the
> call to panfrost_reset_fini() in panfrost_device_fini().
> 
> It's confusing though, panfrost_clk_fini() now cleans up things that
> panfrost_clk_init() didn't set up.

Yes, I agree, it looks extremely confusing. As I said above, I've moved all assert
control into the clock disable and enable functions, because they're always meant
to happen in tandem.

> > +
> > +	clk_unprepare(pfdev->bus_ace_clock);
> > +	clk_unprepare(pfdev->bus_clock);
> > +	clk_unprepare(pfdev->clock);
> >  }
> >  
> >  static int panfrost_regulator_init(struct panfrost_device *pfdev)
> > @@ -212,6 +257,133 @@ static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
> >  	return err;
> >  }
> >  
> > +static int panfrost_device_runtime_resume(struct device *dev)
> > +{
> > +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> > +		ret = reset_control_deassert(pfdev->rstc);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = panfrost_clk_enable(pfdev);
> > +		if (ret)
> > +			goto err_clk;
> 
> Here we clearly deassert the reset and enable the clocks ...
> 
> > +	}
> > +
> > +	panfrost_device_reset(pfdev, true);
> > +	panfrost_devfreq_resume(pfdev);
> > +
> > +	return 0;
> > +
> > +err_clk:
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> > +		reset_control_assert(pfdev->rstc);
> > +	return ret;
> > +}
> > +
> > +static int panfrost_device_runtime_suspend(struct device *dev)
> > +{
> > +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > +
> > +	if (!panfrost_jm_is_idle(pfdev))
> > +		return -EBUSY;
> > +
> > +	panfrost_devfreq_suspend(pfdev);
> > +	panfrost_jm_suspend_irq(pfdev);
> > +	panfrost_mmu_suspend_irq(pfdev);
> > +	panfrost_gpu_suspend_irq(pfdev);
> > +	panfrost_gpu_power_off(pfdev);
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> > +		panfrost_clk_disable(pfdev);
> 
> ... and here we don't seem to assert the reset, but secretly do.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int panfrost_device_resume(struct device *dev)
> > +{
> > +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
> > +		unsigned long freq = pfdev->pfdevfreq.fast_rate;
> > +		struct dev_pm_opp *opp;
> > +
> > +		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> > +		if (IS_ERR(opp))
> > +			return PTR_ERR(opp);
> > +		dev_pm_opp_set_opp(dev, opp);
> > +		dev_pm_opp_put(opp);
> > +	}
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> > +		ret = clk_enable(pfdev->clock);
> > +		if (ret)
> > +			goto err_clk;
> > +
> > +		if (pfdev->bus_clock) {
> 
> Unnecessary check, clk_enable() handles NULL pointers.

This code I had to shuffle around so that I could call the runtime resume and suspend functions
from panfrost_device_init() and panfrost_device_fini() when the kernel wasn't built with CONFIG_PM.
That means those unnecessary checks were already there. I've decided to postpone their removal until
a next patch series to avoid doing too many things here, but I'll take care of it eventually.

> > +			ret = clk_enable(pfdev->bus_clock);
> > +			if (ret)
> > +				goto err_bus_clk;
> > +		}
> > +	}
> > +
> > +	ret = pm_runtime_force_resume(dev);
> > +	if (ret)
> > +		goto err_resume;
> > +
> > +	return 0;
> > +
> > +err_resume:
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> 
> Unnecessary check.
> 
> > +		clk_disable(pfdev->bus_clock);
> > +err_bus_clk:
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> > +		clk_disable(pfdev->clock);
> > +err_clk:
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> > +		dev_pm_opp_set_opp(dev, NULL);
> > +	return ret;
> > +}
> > +
> > +static int panfrost_device_suspend(struct device *dev)
> > +{
> > +	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = pm_runtime_force_suspend(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> > +		if (pfdev->bus_clock)
> 
> Unnecessary check.
> 
> > +			clk_disable(pfdev->bus_clock);
> > +
> > +		clk_disable(pfdev->clock);
> > +	}
> > +
> > +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> > +		dev_pm_opp_set_opp(dev, NULL);
> > +
> > +	return 0;
> > +}
> > +
> > +EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
> > +	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
> > +	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
> > +};
> > +
> > +void panfrost_try_suspend_device(struct panfrost_device *pfdev)
> > +{
> > +	pm_runtime_put_sync_suspend(pfdev->base.dev);
> > +
> > +	/* If PM is disabled, we need to call the suspend handler manually. */
> > +	if (!IS_ENABLED(CONFIG_PM))
> > +		panfrost_device_runtime_suspend(pfdev->base.dev);
> > +}
> > +
> >  int panfrost_device_init(struct panfrost_device *pfdev)
> >  {
> >  	int err;
> > @@ -265,10 +437,25 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  		goto out_regulator;
> >  	}
> >  
> > -	err = panfrost_gpu_init(pfdev);
> > +	err = devm_pm_runtime_enable(pfdev->base.dev);
> >  	if (err)
> >  		goto out_regulator;
> >  
> > +	err = pm_runtime_resume_and_get(pfdev->base.dev);
> > +	if (err)
> > +		goto out_regulator;
> > +
> > +	/* If PM is disabled, we need to call panfrost_device_runtime_resume() manually. */
> > +	if (!IS_ENABLED(CONFIG_PM)) {
> > +		err = panfrost_device_runtime_resume(pfdev->base.dev);
> > +		if (err)
> > +			goto out_regulator;
> > +	}
> > +
> > +	err = panfrost_gpu_init(pfdev);
> > +	if (err)
> > +		goto out_rpm_put;
> > +
> >  	err = panfrost_mmu_init(pfdev);
> >  	if (err)
> >  		goto out_gpu;
> > @@ -295,6 +482,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
> >  	panfrost_mmu_fini(pfdev);
> >  out_gpu:
> >  	panfrost_gpu_fini(pfdev);
> > +out_rpm_put:
> > +	panfrost_try_suspend_device(pfdev);
> >  out_regulator:
> >  	panfrost_regulator_fini(pfdev);
> >  out_devfreq:
> 
> Directly below this:
> 
>           panfrost_devfreq_fini(pfdev);                                                                                                       
>   out_clk:                                                                                                                                    
>           panfrost_clk_fini(pfdev);                                                                                                           
>   out_reset:                                                                                                                                  
>           panfrost_reset_fini(pfdev);                                                                                                         
> 
> _reset_fini is still called right after _clk_fini asserted the reset
> control.

Acked. Dealt with this in v5.

> > @@ -313,12 +502,10 @@ void panfrost_device_fini(struct panfrost_device *pfdev)
> >  	panfrost_gem_shrinker_fini(pfdev);
> >  	panfrost_perfcnt_fini(pfdev);
> >  	panfrost_jm_fini(pfdev);
> > -	panfrost_mmu_fini(pfdev);
> > -	panfrost_gpu_fini(pfdev);
> > -	panfrost_devfreq_fini(pfdev);
> > +	panfrost_try_suspend_device(pfdev);
> >  	panfrost_regulator_fini(pfdev);
> > +	panfrost_devfreq_fini(pfdev);
> >  	panfrost_clk_fini(pfdev);
> > -	panfrost_reset_fini(pfdev);
> 
> Here _reset_fini is dropped because _clk_fini  already asserted the
> reset.
> 
> regards
> Philipp

Thanks a lot for the review,
Adrian Larumbe
