Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B2DC531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B7910E61A;
	Fri, 24 Jul 2026 00:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iUAMnGCt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A5A510E61A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:11:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0FA2600AD;
 Fri, 24 Jul 2026 00:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A25D1F000E9;
 Fri, 24 Jul 2026 00:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784851863;
 bh=5jBBAHi0PnRb8VGVDSKTGs1mzV+3mL7+uriwByUHtLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iUAMnGCtfb9w3NG0fo/Ol675Txf3iBnQ63nJx9h6zh1o5uJOODL5oL0rmrwliaNRr
 8GLjnuHek7cldY9ioluK0zVisRm+C3QDfioCtjTB0/NjvqIHOWMDyMcrfmFHMw6wba
 +SW97A1cSD/b3HkTp3HxJjPjNwhBfPwMOfYb5xsfB+Fr9Eq9GvhOVewqGX04SqOtxq
 7vOW3vQLa3AYTfsPirmRqW5cdO4alplsvzILoxdLhLay+bzkJjRA4GoDimUAOqg7rA
 s9orXnNkqwyRG9/M1KpHf0TC/s6whLaRZYymOOYAWl8n2GpiWVOmzXAG1zKUmyWqhG
 E5K5etWdQJVCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] drm/panfrost: Move all device power up and
 down into RPM callbacks
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-5-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-5-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:11:02 +0000
Message-Id: <20260724001103.3A25D1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unconditional access to uninitialized subsystem states causes =
a NULL pointer dereference on early init failures.
- [Critical] Hardware MMIO registers are accessed after PM domains and regu=
lators are detached, causing a system fault.
- [High] Double free/cleanup underflow of clocks and resets on early initia=
lization failure.
- [High] Clock prepare counts are leaked and never cleaned up during module=
 unload.
- [Medium] Typo in panfrost_clk_init error path causes double unprepare of =
bus_clock and leaks bus_ace_clock.
--

--- Patch [5]: [PATCH v3 05/13] drm/panfrost: Move all device power up and =
down into RPM callbacks ---
commit 79a6eca5bba776aeb8e6557364e0049b9f9eebb5
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move all device power up and down into RPM callbacks

This commit moves the GPU enablement and disablement into runtime PM
resume and suspend callbacks. It is designed to prevent the device from
remaining powered on forever if probe fails and to prevent devfreq OPP
transition notifications from filling the kernel ring buffer.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -88,14 +109,21 @@ static int panfrost_clk_init(struct panfrost_device =
*pfdev)

[ ... ]

> -	err =3D clk_prepare_enable(pfdev->bus_ace_clock);
> +	err =3D clk_prepare(pfdev->bus_ace_clock);
>  	if (err)
> -		goto disable_bus_clock;
> +		goto unprepare_bus_clock;
> +
> +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT))) {
> +		err =3D panfrost_clk_enable(pfdev);
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
> +	clk_unprepare(pfdev->bus_clock);
> +unprepare_bus_clock:
> +	clk_unprepare(pfdev->bus_clock);

[Severity: Medium]
Is there a typo in this error path?=20

If clock enablement fails, the code jumps here, but it looks like
clk_unprepare(pfdev->bus_clock) is called twice under both labels, and
bus_ace_clock is left prepared.

[ ... ]

> @@ -212,6 +251,143 @@ static int panfrost_pm_domain_init(struct panfrost_=
device *pfdev)
>  	return err;
>  }
> =20
> +static int panfrost_device_runtime_resume(struct device *dev)

[ ... ]

> +static int panfrost_device_runtime_suspend(struct device *dev)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +
> +	if (!panfrost_jm_is_idle(pfdev))
> +		return -EBUSY;

[Severity: Critical]
Does this cause a NULL pointer dereference on early initialization failures?

If panfrost_gpu_init() or panfrost_mmu_init() fails during probe, the
error unwinding path calls panfrost_try_suspend_device(), which
synchronously invokes this callback.

At this point, panfrost_jm_init() hasn't run yet, so pfdev->js is NULL.
The unconditional call to panfrost_jm_is_idle(pfdev) dereferences
pfdev->js without checking for NULL.

> +
> +	panfrost_devfreq_suspend(pfdev);
> +	panfrost_jm_suspend_irq(pfdev);
> +	panfrost_mmu_suspend_irq(pfdev);
> +	panfrost_gpu_suspend_irq(pfdev);
> +	panfrost_gpu_power_off(pfdev);
> +
> +	if (panfrost_device_is_initialized(pfdev) &&
> +	    pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> +		clk_disable(pfdev->bus_ace_clock);
> +		clk_disable(pfdev->bus_clock);
> +		clk_disable(pfdev->clock);
> +		reset_control_assert(pfdev->rstc);
> +	}
> +
> +	if (!panfrost_device_is_initialized(pfdev)) {
> +		panfrost_clk_fini(pfdev);
> +		reset_control_assert(pfdev->rstc);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Can this lead to a clock prepare count leak on module unload?

During a clean module unload, panfrost_device_is_initialized() is true
since pfdev->js is still allocated. This means panfrost_clk_fini() will
be skipped here.=20

Since panfrost_clk_fini() was removed from panfrost_device_fini() in this
patch, it looks like the clocks are never disabled or unprepared during
driver removal.

[ ... ]

> @@ -295,6 +486,8 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  	panfrost_mmu_fini(pfdev);
>  out_gpu:
>  	panfrost_gpu_fini(pfdev);
> +out_rpm_put:
> +	panfrost_try_suspend_device(pfdev);
>  out_regulator:
>  	panfrost_regulator_fini(pfdev);

[Severity: High]
Does this cause a double free and clock prepare underflow?

If panfrost_device_init() fails early, the out_rpm_put label calls
panfrost_try_suspend_device(pfdev). The suspend callback explicitly calls
panfrost_clk_fini(pfdev) and reset_control_assert(pfdev->rstc).

Execution then falls through the error ladder to out_clk and out_reset,
calling panfrost_clk_fini(pfdev) and panfrost_reset_fini(pfdev) again.

[ ... ]

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1002,13 +1000,13 @@ static int panfrost_probe(struct platform_device =
*pdev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  	return 0;
> =20
>  err_out1:
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
> +	panfrost_try_suspend_device(pfdev);
>  err_out0:
>  	return err;
>  }

[Severity: Critical]
Does this write to hardware MMIO registers after the device is powered off?

Here, panfrost_device_fini(pfdev) runs first and detaches PM domains and
regulators, physically powering off the GPU.

Then panfrost_try_suspend_device(pfdev) runs. It invokes
panfrost_device_runtime_suspend(), which calls panfrost_gpu_power_off()
and writes to MMIO registers like SHADER_PWROFF_LO.

Writing to unpowered hardware registers can trigger a synchronous external
abort or system lockup.

> @@ -1019,10 +1017,11 @@ static void panfrost_remove(struct platform_devic=
e *pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
> +
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
> +
> +	panfrost_try_suspend_device(pfdev);
>  }

[Severity: Critical]
This appears to have the same teardown ordering issue mentioned above.

panfrost_device_fini() powers down the PM domains before
panfrost_try_suspend_device() writes to the unpowered MMIO registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D5
