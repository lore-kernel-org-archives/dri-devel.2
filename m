Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC2C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCC510EDD7;
	Wed, 12 Aug 2026 01:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YCXZocIn";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C9C10E3D2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 01:29:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786498133; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KjXXWW8a+aJARVSiI1hCGtNANVhbZkCeTg5S8rHhu5FIKB8EH8Be+eHW7ddOnGH8LkKKnB0VcfEAwPqfoBTOUCqZbsyN2mH/BWFpbPDsEo1Gf9Nr8JYtw0tetPrD7Zymi5cTueMCi+YIGmTFNbJaNzdj5Hc2kNWMzM4RRfzQDYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786498133;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DssE8b96pTISY+kYa5mpwnBEoQFmDZ4O7MnhqoaQ6DE=; 
 b=d9j1sw4frnKTD0SlLHbsXAlCUJZbGzXBKRRACHBCg+3+cv1kDJ6S0uMsT0kKEv+bX7fFswTYDYB9tq1q1yqo5vGR7WGlH1q9+1AemdHL5q/i2/OJjasmg8DXVUuEoTVZzBNPIZOaiN4qT/y4fQTOn0M1zFJc5nVuglBe6YZJ9cM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786498133; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=DssE8b96pTISY+kYa5mpwnBEoQFmDZ4O7MnhqoaQ6DE=;
 b=YCXZocIngb6ntKAQl/OExRzt9v8P8epQ/EuT2d+21CH11AwaEz9/EgZbyHxkRo1J
 Bey29pUrhnWuDCFrKzvnDnoW4KrWHt6nzfsa5cYb4zzmFEkXjdp1PBNZrLIexTNg1dv
 hdV7+h675+bT2//S9MqhaXGumFhpLeyShu8bPWzI=
Received: by mx.zohomail.com with SMTPS id 1786498132263683.8799376285317;
 Tue, 11 Aug 2026 18:28:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 02:28:45 +0100
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
 Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 05/13] drm/panfrost: Move all device power up and down
 into RPM callbacks
Message-ID: <anvKKRQIeMcB97Jg@sobremesa>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
 <728e28e9-1dcb-4923-85e9-e91ca81d5b58@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <728e28e9-1dcb-4923-85e9-e91ca81d5b58@arm.com>
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

Hi Steven,

On 30.07.2026 11:40, Steven Price wrote:
> On 29/07/2026 03:54, Adrián Larumbe wrote:
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
> >  		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
> >  			PTR_ERR(pfdev->bus_clock));
> >  		err = PTR_ERR(pfdev->bus_clock);
> > -		goto disable_clock;
> > +		goto unprepare_clock;
> >  	}
> >  
> >  	if (pfdev->bus_clock) {
> >  		rate = clk_get_rate(pfdev->bus_clock);
> >  		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
> >  
> > -		err = clk_prepare_enable(pfdev->bus_clock);
> > +		err = clk_prepare(pfdev->bus_clock);
> >  		if (err)
> > -			goto disable_clock;
> > +			goto unprepare_clock;
> >  	}
> >  
> >  	pfdev->bus_ace_clock = devm_clk_get_optional(pfdev->base.dev, "bus_ace");
> >  	if (IS_ERR(pfdev->bus_ace_clock)) {
> >  		err = PTR_ERR(pfdev->bus_ace_clock);
> >  		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
> > -		goto disable_bus_clock;
> > +		goto unprepare_bus_clock;
> >  	}
> >  
> > -	err = clk_prepare_enable(pfdev->bus_ace_clock);
> > +	err = clk_prepare(pfdev->bus_ace_clock);
> >  	if (err)
> > -		goto disable_bus_clock;
> > +		goto unprepare_bus_clock;
> > +
> > +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT))) {
> > +		err = panfrost_clk_enable(pfdev);
> > +		if (err)
> > +			goto unprepare_bus_ace_clock;
> > +	}
> >  
> >  	return 0;
> >  
> > -disable_bus_clock:
> > -	clk_disable_unprepare(pfdev->bus_clock);
> > -disable_clock:
> > -	clk_disable_unprepare(pfdev->clock);
> > +unprepare_bus_ace_clock:
> > +	clk_unprepare(pfdev->bus_ace_clock);
> > +unprepare_bus_clock:
> > +	clk_unprepare(pfdev->bus_clock);
> > +unprepare_clock:
> > +	clk_unprepare(pfdev->clock);
> >  
> >  	return err;
> >  }
> >  
> >  static void panfrost_clk_fini(struct panfrost_device *pfdev)
> >  {
> > -	clk_disable_unprepare(pfdev->bus_ace_clock);
> > -	clk_disable_unprepare(pfdev->bus_clock);
> > -	clk_disable_unprepare(pfdev->clock);
> > +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
> > +		panfrost_clk_disable(pfdev);
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
> 
> We need the call to panfrost_gpu_init_features() (made by
> panfrost_gpu_init()) before powering up the GPU with
> panfrost_gpu_power_on() (which will now be getting called by the RPM
> callbacks). I think what you've got will attempt to power up the GPU
> with no cores (because the core masks haven't yet been discovered).
> Things will probably work because a suspend/resume cycle afterwards will
> 'fix' things, but this relies on that suspend/resume cycle happening.

I spent some time thinking how to avoid the apparent chicken-and-egg problem of needing
gpu features in order to start the gpu, but also needing the clocks enabled so that I could
poke feature registers. In the end, I left the same gpu_init sequence as before, but
implemented runtime_resume the Panthor way, ie, only when the device is fully initialised
the whole gpu reset sequence takes place in PM resume.

> Thanks,
> Steve
> 
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
> >  	panfrost_pm_domain_fini(pfdev);
> >  }
> >  
> > @@ -424,148 +611,20 @@ bool panfrost_exception_needs_reset(const struct panfrost_device *pfdev,
> >  
> >  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int)
> >  {
> > -	panfrost_gpu_soft_reset(pfdev);
> > -
> > -	panfrost_gpu_power_on(pfdev);
> > -	panfrost_mmu_reset(pfdev);
> > -
> > -	panfrost_jm_reset_interrupts(pfdev);
> > -	if (enable_job_int)
> > -		panfrost_jm_enable_interrupts(pfdev);
> > -}
> > -
> > -static int panfrost_device_runtime_resume(struct device *dev)
> > -{
> > -	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> > -		ret = reset_control_deassert(pfdev->rstc);
> > -		if (ret)
> > -			return ret;
> > -
> > -		ret = clk_enable(pfdev->clock);
> > -		if (ret)
> > -			goto err_clk;
> > -
> > -		ret = clk_enable(pfdev->bus_clock);
> > -		if (ret)
> > -			goto err_bus_clk;
> > -
> > -		ret = clk_enable(pfdev->bus_ace_clock);
> > -		if (ret)
> > -			goto err_bus_ace_clk;
> > -	}
> > -
> > -	panfrost_device_reset(pfdev, true);
> > -	panfrost_devfreq_resume(pfdev);
> > -
> > -	return 0;
> > -
> > -err_bus_ace_clk:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> > -		clk_disable(pfdev->bus_clock);
> > -err_bus_clk:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> > -		clk_disable(pfdev->clock);
> > -err_clk:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> > -		reset_control_assert(pfdev->rstc);
> > -	return ret;
> > -}
> > -
> > -static int panfrost_device_runtime_suspend(struct device *dev)
> > -{
> > -	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > -
> > -	if (!panfrost_jm_is_idle(pfdev))
> > -		return -EBUSY;
> > -
> > -	panfrost_devfreq_suspend(pfdev);
> > -	panfrost_jm_suspend_irq(pfdev);
> > -	panfrost_mmu_suspend_irq(pfdev);
> > -	panfrost_gpu_suspend_irq(pfdev);
> > -	panfrost_gpu_power_off(pfdev);
> > -
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> > -		clk_disable(pfdev->bus_ace_clock);
> > -		clk_disable(pfdev->bus_clock);
> > -		clk_disable(pfdev->clock);
> > -		reset_control_assert(pfdev->rstc);
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static int panfrost_device_resume(struct device *dev)
> > -{
> > -	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
> > -		unsigned long freq = pfdev->pfdevfreq.fast_rate;
> > -		struct dev_pm_opp *opp;
> > -
> > -		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> > -		if (IS_ERR(opp))
> > -			return PTR_ERR(opp);
> > -		dev_pm_opp_set_opp(dev, opp);
> > -		dev_pm_opp_put(opp);
> > -	}
> > -
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> > -		ret = clk_enable(pfdev->clock);
> > -		if (ret)
> > -			goto err_clk;
> > -
> > -		if (pfdev->bus_clock) {
> > -			ret = clk_enable(pfdev->bus_clock);
> > -			if (ret)
> > -				goto err_bus_clk;
> > -		}
> > -	}
> > -
> > -	ret = pm_runtime_force_resume(dev);
> > -	if (ret)
> > -		goto err_resume;
> > -
> > -	return 0;
> > -
> > -err_resume:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> > -		clk_disable(pfdev->bus_clock);
> > -err_bus_clk:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> > -		clk_disable(pfdev->clock);
> > -err_clk:
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> > -		dev_pm_opp_set_opp(dev, NULL);
> > -	return ret;
> > -}
> > -
> > -static int panfrost_device_suspend(struct device *dev)
> > -{
> > -	struct panfrost_device *pfdev = dev_get_drvdata(dev);
> >  	int ret;
> >  
> > -	ret = pm_runtime_force_suspend(dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> > -		if (pfdev->bus_clock)
> > -			clk_disable(pfdev->bus_clock);
> > +	/* Do the actual device reset */
> > +	ret = panfrost_gpu_soft_reset(pfdev);
> > +	panfrost_gpu_power_on(pfdev);
> >  
> > -		clk_disable(pfdev->clock);
> > +	/* Post-reset */
> > +	if (panfrost_device_started(pfdev)) {
> > +		panfrost_mmu_reset(pfdev);
> > +		panfrost_jm_reset_interrupts(pfdev);
> > +		if (enable_job_int)
> > +			panfrost_jm_enable_interrupts(pfdev);
> >  	}
> >  
> > -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> > -		dev_pm_opp_set_opp(dev, NULL);
> > -
> > -	return 0;
> > +	if (!panfrost_device_started(pfdev) && !ret)
> > +		pfdev->gpu_started = true;
> >  }
> > -
> > -EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
> > -	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime_resume, NULL)
> > -	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
> > -};
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> > index ec55c136b1b6..eeca57efcbec 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -142,6 +142,7 @@ struct panfrost_device {
> >  	/* pm_domains for devices with more than one. */
> >  	struct device *pm_domain_devs[MAX_PM_DOMAINS];
> >  	struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> > +	bool gpu_started;
> >  	bool coherent;
> >  
> >  	struct panfrost_features features;
> > @@ -253,6 +254,8 @@ int panfrost_device_init(struct panfrost_device *pfdev);
> >  void panfrost_device_fini(struct panfrost_device *pfdev);
> >  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_job_int);
> >  
> > +void panfrost_try_suspend_device(struct panfrost_device *pfdev);
> > +
> >  extern const struct dev_pm_ops panfrost_pm_ops;
> >  
> >  enum drm_panfrost_exception_type {
> > @@ -342,4 +345,10 @@ panfrost_device_schedule_reset(struct panfrost_device *pfdev)
> >  	queue_work(pfdev->reset.wq, &pfdev->reset.work);
> >  }
> >  
> > +static inline bool
> > +panfrost_device_started(struct panfrost_device *pfdev)
> > +{
> > +	return pfdev->gpu_started;
> > +}
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 331a3bd5b98c..27f4c4b217f5 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -988,9 +988,7 @@ static int panfrost_probe(struct platform_device *pdev)
> >  		goto err_out0;
> >  	}
> >  
> > -	pm_runtime_set_active(pfdev->base.dev);
> >  	pm_runtime_mark_last_busy(pfdev->base.dev);
> > -	pm_runtime_enable(pfdev->base.dev);
> >  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
> >  	pm_runtime_use_autosuspend(pfdev->base.dev);
> >  
> > @@ -1002,13 +1000,12 @@ static int panfrost_probe(struct platform_device *pdev)
> >  	if (err < 0)
> >  		goto err_out1;
> >  
> > +	pm_runtime_put_autosuspend(pfdev->base.dev);
> >  
> >  	return 0;
> >  
> >  err_out1:
> > -	pm_runtime_disable(pfdev->base.dev);
> >  	panfrost_device_fini(pfdev);
> > -	pm_runtime_set_suspended(pfdev->base.dev);
> >  err_out0:
> >  	return err;
> >  }
> > @@ -1019,10 +1016,9 @@ static void panfrost_remove(struct platform_device *pdev)
> >  
> >  	drm_dev_unregister(&pfdev->base);
> >  
> > -	pm_runtime_get_sync(pfdev->base.dev);
> > -	pm_runtime_disable(pfdev->base.dev);
> > +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
> > +
> >  	panfrost_device_fini(pfdev);
> > -	pm_runtime_set_suspended(pfdev->base.dev);
> >  }
> >  
> >  static ssize_t profiling_show(struct device *dev,
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > index 7d555e63e21a..416964282138 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > @@ -516,9 +516,8 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
> >  {
> >  	int err;
> >  
> > -	err = panfrost_gpu_soft_reset(pfdev);
> > -	if (err)
> > -		return err;
> > +	if (!panfrost_device_started(pfdev))
> > +		return -ETIMEDOUT;
> >  
> >  	err = panfrost_gpu_init_features(pfdev);
> >  	if (err)
> > @@ -543,8 +542,6 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
> >  		return err;
> >  	}
> >  
> > -	panfrost_gpu_power_on(pfdev);
> > -
> >  	return 0;
> >  }
> >  
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> > index 2d12b83e900a..35ff5b0f0013 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> > @@ -446,7 +446,9 @@ void panfrost_jm_suspend_irq(struct panfrost_device *pfdev)
> >  	set_bit(PANFROST_COMP_BIT_JOB, pfdev->is_suspended);
> >  
> >  	job_write(pfdev, JOB_INT_MASK, 0);
> > -	synchronize_irq(pfdev->js->irq);
> > +
> > +	if (pfdev->js)
> > +		synchronize_irq(pfdev->js->irq);
> >  }
> >  
> >  static void panfrost_job_handle_err(struct panfrost_device *pfdev,
> > @@ -971,6 +973,9 @@ int panfrost_jm_is_idle(struct panfrost_device *pfdev)
> >  	struct panfrost_job_slot *js = pfdev->js;
> >  	int i;
> >  
> > +	if (!js)
> > +		return true;
> > +
> >  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> >  		/* If there are any jobs in the HW queue, we're not idle */
> >  		if (atomic_read(&js->queue[i].sched.credit_count))
> > 

Adrian Larumbe
