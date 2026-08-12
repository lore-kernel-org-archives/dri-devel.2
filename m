Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFADC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A766710EF07;
	Wed, 12 Aug 2026 09:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="quorEFpT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A386010EF07
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786525666;
 bh=CHcsdL5tNKGMVduCAXuuU+3D72PiJpOvC/nlpy8aYk8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=quorEFpTS1ieqQJLy3URTSohyCgMP/Semp2Ohtdxjd1UYlK5zkBRVxagpY4eKlOCa
 FQZfn1FieKUj4BxpMum1305pHDROUzZI31OF1/bdvxhkcf4FQghzr+iVb18J7N3eXy
 JFtXGZW1byx0is1TCN48a90TdnboSZxvqTd2PxnIEJKkiHw2sD1HP+sCoRXYqHQd3T
 vm5UTZkJgaOmh6lD4JJjCVx0lka7u+EzS9rnhVuIl/CCQzKyAje7kYGYJwrZTZOJhO
 S3lWprPhcHQp3R45yjJlp1D9FJnwvaufoEbWnQpBmrX6NlZFMGCX8sn7QA+A8rtCl2
 yD1YhraXkzg0A==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7251817E0E3F;
 Wed, 12 Aug 2026 11:07:45 +0200 (CEST)
Date: Wed, 12 Aug 2026 11:07:40 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, "Marty E. Plummer"
 <hanetzer@startmail.com>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt
 <eric@anholt.net>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 05/11] drm/panfrost: Move all device power up and
 down into RPM callbacks
Message-ID: <20260812110740.2f709052@fedora-21.home>
In-Reply-To: <20260811-claude-fixes-v5-5-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-5-3d692c9e98c2@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 11 Aug 2026 22:42:14 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> During device probe(), failure to do a PM get() will leave the usage_count
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
> touching any HW registers. This is done in imitation of the Panthor model.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> Fixes: 635430797d3f ("drm/panfrost: Rework runtime PM initialization")
> Fixes: 876b15d2c88d ("drm/panfrost: Fix module unload")
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 389 ++++++++++++++++-------=
------
>  drivers/gpu/drm/panfrost/panfrost_device.h |   8 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  11 +-
>  drivers/gpu/drm/panfrost/panfrost_gpu.c    |   9 +-
>  drivers/gpu/drm/panfrost/panfrost_gpu.h    |   1 -
>  drivers/gpu/drm/panfrost/panfrost_job.c    |   7 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.c    |   9 +-
>  drivers/gpu/drm/panfrost/panfrost_mmu.h    |   1 -
>  8 files changed, 236 insertions(+), 199 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 74992deb0b3a..52f4b8c6a05f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -26,11 +26,46 @@ static int panfrost_reset_init(struct panfrost_device=
 *pfdev)
>  		return PTR_ERR(pfdev->rstc);
>  	}
> =20
> -	return reset_control_deassert(pfdev->rstc);
> +	return 0;
>  }
> =20
> -static void panfrost_reset_fini(struct panfrost_device *pfdev)
> +static int panfrost_clk_enable_deassert_reset(struct panfrost_device *pf=
dev)
>  {
> +	int err;
> +
> +	err =3D reset_control_deassert(pfdev->rstc);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_enable(pfdev->clock);

I'd go for clk_prepare_enable() (and disable_unprepare() in
clk_disable_assert_reset()), just so you don't end up with a
prepare count lower than your enable count if the rpm get/put
section is covering the clk_fini() one. Note that the extra
prepare is cheap (just a refcnt increment since the clk has
been prepared already in clk_init()).

> +	if (err)
> +		goto assert_reset;
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
> +assert_reset:
> +	reset_control_assert(pfdev->rstc);
> +
> +	return err;
> +}
> +
> +static void panfrost_clk_disable_assert_reset(struct panfrost_device *pf=
dev)
> +{
> +	clk_disable(pfdev->bus_ace_clock);
> +	clk_disable(pfdev->bus_clock);
> +	clk_disable(pfdev->clock);
>  	reset_control_assert(pfdev->rstc);
>  }
> =20
> @@ -48,7 +83,7 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
>  	rate =3D clk_get_rate(pfdev->clock);
>  	dev_info(pfdev->base.dev, "clock rate =3D %lu\n", rate);
> =20
> -	err =3D clk_prepare_enable(pfdev->clock);
> +	err =3D clk_prepare(pfdev->clock);
>  	if (err)
>  		return err;
> =20
> @@ -57,44 +92,55 @@ static int panfrost_clk_init(struct panfrost_device *=
pfdev)
>  		dev_err(pfdev->base.dev, "get bus_clock failed %ld\n",
>  			PTR_ERR(pfdev->bus_clock));
>  		err =3D PTR_ERR(pfdev->bus_clock);
> -		goto disable_clock;
> +		goto unprepare_clock;
>  	}
> =20
>  	if (pfdev->bus_clock) {
>  		rate =3D clk_get_rate(pfdev->bus_clock);
>  		dev_info(pfdev->base.dev, "bus_clock rate =3D %lu\n", rate);
> =20
> -		err =3D clk_prepare_enable(pfdev->bus_clock);
> +		err =3D clk_prepare(pfdev->bus_clock);
>  		if (err)
> -			goto disable_clock;
> +			goto unprepare_clock;
>  	}
> =20
>  	pfdev->bus_ace_clock =3D devm_clk_get_optional(pfdev->base.dev, "bus_ac=
e");
>  	if (IS_ERR(pfdev->bus_ace_clock)) {
>  		err =3D PTR_ERR(pfdev->bus_ace_clock);
>  		dev_err(pfdev->base.dev, "get bus_ace_clock failed %d\n", err);
> -		goto disable_bus_clock;
> +		goto unprepare_bus_clock;
>  	}
> =20
> -	err =3D clk_prepare_enable(pfdev->bus_ace_clock);
> +	err =3D clk_prepare(pfdev->bus_ace_clock);
>  	if (err)
> -		goto disable_bus_clock;
> +		goto unprepare_bus_clock;
> +
> +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT))) {
> +		err =3D panfrost_clk_enable_deassert_reset(pfdev);
> +		if (err)
> +			goto unprepare_bus_ace_clock;
> +	}
> =20
>  	return 0;
> =20
> -disable_bus_clock:
> -	clk_disable_unprepare(pfdev->bus_clock);
> -disable_clock:
> -	clk_disable_unprepare(pfdev->clock);
> +unprepare_bus_ace_clock:
> +	clk_unprepare(pfdev->bus_ace_clock);
> +unprepare_bus_clock:
> +	clk_unprepare(pfdev->bus_clock);
> +unprepare_clock:
> +	clk_unprepare(pfdev->clock);
> =20
>  	return err;
>  }
> =20
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> -	clk_disable_unprepare(pfdev->bus_ace_clock);
> -	clk_disable_unprepare(pfdev->bus_clock);
> -	clk_disable_unprepare(pfdev->clock);
> +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
> +		panfrost_clk_disable_assert_reset(pfdev);
> +
> +	clk_unprepare(pfdev->bus_ace_clock);
> +	clk_unprepare(pfdev->bus_clock);
> +	clk_unprepare(pfdev->clock);
>  }
> =20
>  static int panfrost_regulator_init(struct panfrost_device *pfdev)
> @@ -212,6 +258,127 @@ static int panfrost_pm_domain_init(struct panfrost_=
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
> +		ret =3D panfrost_clk_enable_deassert_reset(pfdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	panfrost_devfreq_resume(pfdev);
> +
> +	if (panfrost_device_started(pfdev))
> +		panfrost_device_reset(pfdev, true);
> +
> +	return 0;
> +}
> +
> +static int panfrost_device_runtime_suspend(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +
> +	if (panfrost_device_started(pfdev) &&
> +	    !panfrost_jm_is_idle(pfdev))

Uh, if this is being called and JM is not idle, there's a serious issue
that needs fixing (JM should hold a PM ref when it's active). It probably
deserves a WARN_ON()

> +		return -EBUSY;
> +
> +	panfrost_jm_suspend_irq(pfdev);
> +	panfrost_mmu_suspend_irq(pfdev);
> +	panfrost_gpu_suspend_irq(pfdev);
> +	panfrost_gpu_power_off(pfdev);
> +	panfrost_devfreq_suspend(pfdev);

I've seen extra checks added to panfrost_gpu_suspend_irq() to cover
for some early suspend call. What I think we should do instead is
skip those sub-component calls if the device is not fully initialized
(panfrost_device_started() =3D=3D true). And then, in the _fini() helpers,
you make sure to suspend/disable stuff, so that, if they're called
in from the device_init() error path, things are undone as the should
without relying on the runtime PM stuff for that.

> +
> +	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> +		panfrost_clk_disable_assert_reset(pfdev);
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

I'm not too sure it's wise to combine the two things in the same
helper. pm_runtime_put_sync_suspend() is the helper you call when
you're done interacting with the HW in some code section and want it to
enter suspend if there's no other users left.

The conditional !PM panfrost_device_runtime_suspend() call is supposed
to be in the device_remove() path in pair with the conditional
panfrost_device_runtime_resume() that exists in the probe() path.

> +}
> +
>  int panfrost_device_init(struct panfrost_device *pfdev)
>  {
>  	int err;
> @@ -242,7 +409,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  	err =3D panfrost_clk_init(pfdev);
>  	if (err) {
>  		dev_err(pfdev->base.dev, "clk init failed %d\n", err);
> -		goto out_reset;
> +		goto out_pm_domain;
>  	}
> =20
>  	err =3D panfrost_devfreq_init(pfdev);
> @@ -265,60 +432,70 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
>  		goto out_regulator;
>  	}
> =20
> -	err =3D panfrost_gpu_init(pfdev);
> +	err =3D devm_pm_runtime_enable(pfdev->base.dev);
>  	if (err)
>  		goto out_regulator;
> =20
> -	err =3D panfrost_mmu_init(pfdev);
> +	err =3D pm_runtime_resume_and_get(pfdev->base.dev);

I don't see a pm_runtime_put to go with that runtime_get in the
device_init() function. To me, it looks like this keeps the device
active until the device_fini() function is called, which is not what we
want.

>  	if (err)
> -		goto out_gpu;
> +		goto out_regulator;
> =20
> -	err =3D panfrost_jm_init(pfdev);
> +	/* If PM is disabled, we need to call panfrost_device_runtime_resume() =
manually. */
> +	if (!IS_ENABLED(CONFIG_PM)) {
> +		err =3D panfrost_device_runtime_resume(pfdev->base.dev);
> +		if (err)
> +			goto out_regulator;
> +	}
> +
> +	err =3D panfrost_gpu_init(pfdev);
>  	if (err)
> -		goto out_mmu;
> +		goto out_rpm_put;
> +
> +	err =3D panfrost_mmu_init(pfdev);
> +	if (err)
> +		goto out_rpm_put;
> =20
>  	err =3D panfrost_perfcnt_init(pfdev);
>  	if (err)
> -		goto out_job;
> +		goto out_rpm_put;
> =20
>  	err =3D panfrost_gem_init(pfdev);
>  	if (err)
>  		goto out_perfcnt;
> =20
> +	err =3D panfrost_jm_init(pfdev);
> +	if (err)
> +		goto out_gem;
> +
>  	return 0;
> =20
> +out_gem:
> +	panfrost_gem_fini(pfdev);
>  out_perfcnt:
>  	panfrost_perfcnt_fini(pfdev);
> -out_job:
> -	panfrost_jm_fini(pfdev);
> -out_mmu:
> -	panfrost_mmu_fini(pfdev);
> -out_gpu:
> -	panfrost_gpu_fini(pfdev);
> +out_rpm_put:
> +	panfrost_try_suspend_device(pfdev);
>  out_regulator:
>  	panfrost_regulator_fini(pfdev);
>  out_devfreq:
>  	panfrost_devfreq_fini(pfdev);
>  out_clk:
>  	panfrost_clk_fini(pfdev);
> -out_reset:
> -	panfrost_reset_fini(pfdev);
>  out_pm_domain:
>  	panfrost_pm_domain_fini(pfdev);
>  	return err;
>  }
> =20
> -void panfrost_device_fini(struct panfrost_device *pfdev)
> +void
> +panfrost_device_fini(struct panfrost_device *pfdev)
>  {

There should be pm_runtime_resume_and_get() here...

> +	panfrost_jm_fini(pfdev);
>  	panfrost_gem_fini(pfdev);
>  	panfrost_perfcnt_fini(pfdev);
> -	panfrost_jm_fini(pfdev);
> -	panfrost_mmu_fini(pfdev);
> -	panfrost_gpu_fini(pfdev);
> -	panfrost_devfreq_fini(pfdev);

... and a pm_runtime_put_sync() here. We can probably even used a

	scoped_cond_guard(pm_runtime_active_try_enabled,
			  /* FIXME: can't resume fallback */,
			  pfdev->base.dev) {
	}

	/* If PM is disabled, we need to call the suspend handler manually. */
	if (!IS_ENABLED(CONFIG_PM))
		panfrost_device_runtime_suspend(pfdev->base.dev);

> +	panfrost_try_suspend_device(pfdev);
>  	panfrost_regulator_fini(pfdev);
> +	panfrost_devfreq_fini(pfdev);
>  	panfrost_clk_fini(pfdev);
> -	panfrost_reset_fini(pfdev);
>  	panfrost_pm_domain_fini(pfdev);
>  }
> =20
> @@ -425,147 +602,9 @@ bool panfrost_exception_needs_reset(const struct pa=
nfrost_device *pfdev,
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int)
>  {
>  	panfrost_gpu_soft_reset(pfdev);
> -
>  	panfrost_gpu_power_on(pfdev);
>  	panfrost_mmu_reset(pfdev);
> -

Looks like unrelated cosmetic changes.

>  	panfrost_jm_reset_interrupts(pfdev);
>  	if (enable_job_int)
>  		panfrost_jm_enable_interrupts(pfdev);
>  }
> -
> -static int panfrost_device_runtime_resume(struct device *dev)
> -{
> -	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> -	int ret;
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> -		ret =3D reset_control_deassert(pfdev->rstc);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D clk_enable(pfdev->clock);
> -		if (ret)
> -			goto err_clk;
> -
> -		ret =3D clk_enable(pfdev->bus_clock);
> -		if (ret)
> -			goto err_bus_clk;
> -
> -		ret =3D clk_enable(pfdev->bus_ace_clock);
> -		if (ret)
> -			goto err_bus_ace_clk;
> -	}
> -
> -	panfrost_device_reset(pfdev, true);
> -	panfrost_devfreq_resume(pfdev);
> -
> -	return 0;
> -
> -err_bus_ace_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		clk_disable(pfdev->bus_clock);
> -err_bus_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		clk_disable(pfdev->clock);
> -err_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT))
> -		reset_control_assert(pfdev->rstc);
> -	return ret;
> -}
> -
> -static int panfrost_device_runtime_suspend(struct device *dev)
> -{
> -	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> -
> -	if (!panfrost_jm_is_idle(pfdev))
> -		return -EBUSY;
> -
> -	panfrost_devfreq_suspend(pfdev);
> -	panfrost_jm_suspend_irq(pfdev);
> -	panfrost_mmu_suspend_irq(pfdev);
> -	panfrost_gpu_suspend_irq(pfdev);
> -	panfrost_gpu_power_off(pfdev);
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> -		clk_disable(pfdev->bus_ace_clock);
> -		clk_disable(pfdev->bus_clock);
> -		clk_disable(pfdev->clock);
> -		reset_control_assert(pfdev->rstc);
> -	}
> -
> -	return 0;
> -}
> -
> -static int panfrost_device_resume(struct device *dev)
> -{
> -	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> -	int ret;
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
> -		unsigned long freq =3D pfdev->pfdevfreq.fast_rate;
> -		struct dev_pm_opp *opp;
> -
> -		opp =3D dev_pm_opp_find_freq_ceil(dev, &freq);
> -		if (IS_ERR(opp))
> -			return PTR_ERR(opp);
> -		dev_pm_opp_set_opp(dev, opp);
> -		dev_pm_opp_put(opp);
> -	}
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		ret =3D clk_enable(pfdev->clock);
> -		if (ret)
> -			goto err_clk;
> -
> -		if (pfdev->bus_clock) {
> -			ret =3D clk_enable(pfdev->bus_clock);
> -			if (ret)
> -				goto err_bus_clk;
> -		}
> -	}
> -
> -	ret =3D pm_runtime_force_resume(dev);
> -	if (ret)
> -		goto err_resume;
> -
> -	return 0;
> -
> -err_resume:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
> -		clk_disable(pfdev->bus_clock);
> -err_bus_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
> -		clk_disable(pfdev->clock);
> -err_clk:
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> -		dev_pm_opp_set_opp(dev, NULL);
> -	return ret;
> -}
> -
> -static int panfrost_device_suspend(struct device *dev)
> -{
> -	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret =3D pm_runtime_force_suspend(dev);
> -	if (ret)
> -		return ret;
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
> -		if (pfdev->bus_clock)
> -			clk_disable(pfdev->bus_clock);
> -
> -		clk_disable(pfdev->clock);
> -	}
> -
> -	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
> -		dev_pm_opp_set_opp(dev, NULL);
> -
> -	return 0;
> -}
> -
> -EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
> -	RUNTIME_PM_OPS(panfrost_device_runtime_suspend, panfrost_device_runtime=
_resume, NULL)
> -	SYSTEM_SLEEP_PM_OPS(panfrost_device_suspend, panfrost_device_resume)
> -};
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm=
/panfrost/panfrost_device.h
> index ec55c136b1b6..0fd33bc5b86f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -253,6 +253,8 @@ int panfrost_device_init(struct panfrost_device *pfde=
v);
>  void panfrost_device_fini(struct panfrost_device *pfdev);
>  void panfrost_device_reset(struct panfrost_device *pfdev, bool enable_jo=
b_int);
> =20
> +void panfrost_try_suspend_device(struct panfrost_device *pfdev);
> +
>  extern const struct dev_pm_ops panfrost_pm_ops;
> =20
>  enum drm_panfrost_exception_type {
> @@ -342,4 +344,10 @@ panfrost_device_schedule_reset(struct panfrost_devic=
e *pfdev)
>  	queue_work(pfdev->reset.wq, &pfdev->reset.work);
>  }
> =20
> +static inline bool
> +panfrost_device_started(struct panfrost_device *pfdev)
> +{
> +	return pfdev->js;
> +}
> +
>  #endif
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 331a3bd5b98c..8410de95e364 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -988,9 +988,6 @@ static int panfrost_probe(struct platform_device *pde=
v)
>  		goto err_out0;
>  	}
> =20
> -	pm_runtime_set_active(pfdev->base.dev);
> -	pm_runtime_mark_last_busy(pfdev->base.dev);
> -	pm_runtime_enable(pfdev->base.dev);
>  	pm_runtime_set_autosuspend_delay(pfdev->base.dev, 50); /* ~3 frames */
>  	pm_runtime_use_autosuspend(pfdev->base.dev);

I'd recommend moving those to panfrost_device_init(), since this is were
the rest of the PM related initialization happens.

> =20
> @@ -1002,13 +999,12 @@ static int panfrost_probe(struct platform_device *=
pdev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);

Oh, so here is the runtime_put_autosuspend() I was looking for
in panfrost_device_init().

> =20
>  	return 0;
> =20
>  err_out1:
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
>  err_out0:
>  	return err;
>  }
> @@ -1019,10 +1015,9 @@ static void panfrost_remove(struct platform_device=
 *pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);

And here's the pm_runtime_get() that was missing in panthor_device_fini().
Let's move anything PM related to device_{init,fini}() to clarify things.

Also, we probably want a resume_and_get() instead of get_sync(), and some
fallback in case the resume fails (though I'm not too sure what the fallback
could be).

> +
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);

I assume this is now handled by the action registered by
devm_pm_runtime_enable().

>  }
> =20
>  static ssize_t profiling_show(struct device *dev,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gpu.c
> index 7d555e63e21a..0a3a68b561c9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -509,7 +509,9 @@ void panfrost_gpu_suspend_irq(struct panfrost_device =
*pfdev)
>  	set_bit(PANFROST_COMP_BIT_GPU, pfdev->is_suspended);
> =20
>  	gpu_write(pfdev, GPU_INT_MASK, 0);
> -	synchronize_irq(pfdev->gpu_irq);
> +
> +	if (pfdev->gpu_irq > 0)
> +		synchronize_irq(pfdev->gpu_irq);

As mentioned above, I don't think panfrost_gpu_suspend_irq() should be call=
ed
before panthor_gpu_init() (applies to all xxx_suspend_irq() helpers actuall=
y),
and that's something to address at the RPM implementation level (skip those
when the device is not yet initialized/started).
