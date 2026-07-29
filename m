Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E8CC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B3310EB00;
	Wed, 29 Jul 2026 08:38:03 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F03010EAF9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:38:02 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25CD5201D33;
 Wed, 29 Jul 2026 10:38:00 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1woznc-001r0g-05;
 Wed, 29 Jul 2026 10:38:00 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1woznb-000000004zg-3tT7;
 Wed, 29 Jul 2026 10:37:59 +0200
Message-ID: <aae0436c7594c3380786a319b053c12c9e685ccb.camel@pengutronix.de>
Subject: Re: [PATCH v4 05/13] drm/panfrost: Move all device power up and
 down into RPM callbacks
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,  Boris
 Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>,  Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Collabora
 Kernel Team <kernel@collabora.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Date: Wed, 29 Jul 2026 10:37:59 +0200
In-Reply-To: <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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

On Mi, 2026-07-29 at 03:54 +0100, Adri=C3=A1n Larumbe wrote:
> During device probe(), failure to do a PM get() will leave the usage_coun=
t
> set to 0, which is the value assigned at device creation time. That means
> when the autosuspend delay expires, runtime suspend callback won't be
> invoked, so the device will remain powered on forever.
>=20
> On top of that, failure to call PM put() during device unplug means
> Panfrost device's PM usage_count increases monotonically for every new
> module reload.
>=20
> The combined outcome of both of the above was that devfreq OPP transition
> notifications would be printed all the time, even when no jobs are being
> submitted. This quickly fills the kernel ring buffer with junk.
>=20
> Even direr than that was the fact MMU interrupts are only enabled when
> the device is reset, so after device probe() the very first job targeting
> the tiler heap BO would always time out, because the driver's PM runtime
> resume callback would not be invoked.
>=20
> Fix all that by moving all GPU enabling and disabling into RPM resume and
> suspend callbacks, and making sure we resume the device right before
> touching any HW registers. This is done in imitation of the Panthor model=
.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 375 +++++++++++++++++------=
------
>  drivers/gpu/drm/panfrost/panfrost_device.h |   9 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  10 +-
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    |   7 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c    |   7 +-
>  5 files changed, 237 insertions(+), 171 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 03905495aee2..a9d29d9ee22b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -34,6 +34,40 @@ static void panfrost_reset_fini(struct panfrost_device=
 *pfdev)
>  	reset_control_assert(pfdev->rstc);
>  }
> =20
> +static int panfrost_clk_enable(struct panfrost_device *pfdev)
> +{
> +	int err;
> +
> +	err =3D clk_enable(pfdev->clock);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_enable(pfdev->bus_clock);
> +	if (err)
> +		goto disable_clock;
> +
> +	err =3D clk_enable(pfdev->bus_ace_clock);
> +	if (err)
> +		goto disable_bus_clock;
> +
> +	return 0;
> +
> +disable_bus_clock:
> +	clk_disable(pfdev->bus_clock);
> +disable_clock:
> +	clk_disable(pfdev->clock);
> +
> +	return err;
> +}
> +
> +static void panfrost_clk_disable(struct panfrost_device *pfdev)
> +{
> +	clk_disable(pfdev->bus_ace_clock);
> +	clk_disable(pfdev->bus_clock);
> +	clk_disable(pfdev->clock);
> +	reset_control_assert(pfdev->rstc);
> +}

This asymmetry is weird. Why assert the reset control in
panfrost_clock_disable() but not deassert it in panfrost_clk_enable()?
It's also unexpected to have a function called _clk_disable do
something else.

> +
>  static int panfrost_clk_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> @@ -48,7 +82,7 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
>  	rate =3D clk_get_rate(pfdev->clock);
>  	dev_info(pfdev->base.dev, "clock rate =3D %lu\n", rate);
> =20
> -	err =3D clk_prepare_enable(pfdev->clock);
> +	err =3D clk_prepare(pfdev->clock);
>  	if (err)
>  		return err;
> =20
> @@ -57,44 +91,55 @@ static int panfrost_clk_init(struct panfrost_device *=
pfdev)
[...]
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> -	clk_disable_unprepare(pfdev->bus_ace_clock);
> -	clk_disable_unprepare(pfdev->bus_clock);
> -	clk_disable_unprepare(pfdev->clock);
> +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
> +		panfrost_clk_disable(pfdev);

So here you are effectively adding a reset_control_assert() that wasn't
there before. That seems to be intentional because you are removing the
call to panfrost_reset_fini() in panfrost_device_fini().

It's confusing though, panfrost_clk_fini() now cleans up things that
panfrost_clk_init() didn't set up.

> +
> +	clk_unprepare(pfdev->bus_ace_clock);
> +	clk_unprepare(pfdev->bus_clock);
> +	clk_unprepare(pfdev->clock);
>  }
> =20
>  static int panfrost_regulator_init(struct panfrost_device *pfdev)
> @@ -212,6 +257,133 @@ static int panfrost_pm_domain_init(struct panfrost_=
device *pfdev)
>  	return err;
>  }
> =20
> +static int panfrost_device_runtime_resume(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> +		ret =3D reset_control_deassert(pfdev->rstc);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D panfrost_clk_enable(pfdev);
> +		if (ret)
> +			goto err_clk;

Here we clearly deassert the reset and enable the clocks ...

> +	}
> +
> +	panfrost_device_reset(pfdev, true);
> +	panfrost_devfreq_resume(pfdev);
> +
> +	return 0;
> +
> +err_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> +		reset_control_assert(pfdev->rstc);
> +	return ret;
> +}
> +
> +static int panfrost_device_runtime_suspend(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +
> +	if (!panfrost_jm_is_idle(pfdev))
> +		return -EBUSY;
> +
> +	panfrost_devfreq_suspend(pfdev);
> +	panfrost_jm_suspend_irq(pfdev);
> +	panfrost_mmu_suspend_irq(pfdev);
> +	panfrost_gpu_suspend_irq(pfdev);
> +	panfrost_gpu_power_off(pfdev);
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> +		panfrost_clk_disable(pfdev);

... and here we don't seem to assert the reset, but secretly do.

> +
> +	return 0;
> +}
> +
> +static int panfrost_device_resume(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
> +		unsigned long freq =3D pfdev->pfdevfreq.fast_rate;
> +		struct dev_pm_opp *opp;
> +
> +		opp =3D dev_pm_opp_find_freq_ceil(dev, &freq);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +		dev_pm_opp_set_opp(dev, opp);
> +		dev_pm_opp_put(opp);
> +	}
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +		ret =3D clk_enable(pfdev->clock);
> +		if (ret)
> +			goto err_clk;
> +
> +		if (pfdev->bus_clock) {

Unnecessary check, clk_enable() handles NULL pointers.

> +			ret =3D clk_enable(pfdev->bus_clock);
> +			if (ret)
> +				goto err_bus_clk;
> +		}
> +	}
> +
> +	ret =3D pm_runtime_force_resume(dev);
> +	if (ret)
> +		goto err_resume;
> +
> +	return 0;
> +
> +err_resume:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)

Unnecessary check.

> +		clk_disable(pfdev->bus_clock);
> +err_bus_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> +		clk_disable(pfdev->clock);
> +err_clk:
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> +		dev_pm_opp_set_opp(dev, NULL);
> +	return ret;
> +}
> +
> +static int panfrost_device_suspend(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> +		if (pfdev->bus_clock)

Unnecessary check.

> +			clk_disable(pfdev->bus_clock);
> +
> +		clk_disable(pfdev->clock);
> +	}
> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> +		dev_pm_opp_set_opp(dev, NULL);
> +
> +	return 0;
> +}
> +
> +EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
> +	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime=
_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
> +};
> +
> +void panfrost_try_suspend_device(struct panfrost_device *pfdev)
> +{
> +	pm_runtime_put_sync_suspend(pfdev->base.dev);
> +
> +	/* If PM is disabled, we need to call the suspend handler manually. */
> +	if (!IS_ENABLED(CONFIG_PM))
> +		panfrost_device_runtime_suspend(pfdev->base.dev);
> +}
> +
>  int panfrost_device_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> @@ -265,10 +437,25 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
>  		goto out_regulator;
>  	}
> =20
> -	err =3D panfrost_gpu_init(pfdev);
> +	err =3D devm_pm_runtime_enable(pfdev->base.dev);
>  	if (err)
>  		goto out_regulator;
> =20
> +	err =3D pm_runtime_resume_and_get(pfdev->base.dev);
> +	if (err)
> +		goto out_regulator;
> +
> +	/* If PM is disabled, we need to call panfrost_device_runtime_resume() =
manually. */
> +	if (!IS_ENABLED(CONFIG_PM)) {
> +		err =3D panfrost_device_runtime_resume(pfdev->base.dev);
> +		if (err)
> +			goto out_regulator;
> +	}
> +
> +	err =3D panfrost_gpu_init(pfdev);
> +	if (err)
> +		goto out_rpm_put;
> +
>  	err =3D panfrost_mmu_init(pfdev);
>  	if (err)
>  		goto out_gpu;
> @@ -295,6 +482,8 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  	panfrost_mmu_fini(pfdev);
>  out_gpu:
>  	panfrost_gpu_fini(pfdev);
> +out_rpm_put:
> +	panfrost_try_suspend_device(pfdev);
>  out_regulator:
>  	panfrost_regulator_fini(pfdev);
>  out_devfreq:

Directly below this:

          panfrost_devfreq_fini(pfdev);                                    =
                                                                  =20
  out_clk:                                                                 =
                                                                  =20
          panfrost_clk_fini(pfdev);                                        =
                                                                  =20
  out_reset:                                                               =
                                                                  =20
          panfrost_reset_fini(pfdev);                                      =
                                                                  =20

_reset_fini is still called right after _clk_fini asserted the reset
control.

> @@ -313,12 +502,10 @@ void panfrost_device_fini(struct panfrost_device *p=
fdev)
>  	panfrost_gem_shrinker_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
>  	panfrost_jm_fini(pfdev);
> -	panfrost_mmu_fini(pfdev);
> -	panfrost_gpu_fini(pfdev);
> -	panfrost_devfreq_fini(pfdev);
> +	panfrost_try_suspend_device(pfdev);
>  	panfrost_regulator_fini(pfdev);
> +	panfrost_devfreq_fini(pfdev);
>  	panfrost_clk_fini(pfdev);
> -	panfrost_reset_fini(pfdev);

Here _reset_fini is dropped because _clk_fini  already asserted the
reset.

regards
Philipp
