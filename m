Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E129DC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E3810EA6C;
	Wed, 29 Jul 2026 03:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g8gewvvF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A8210EA6C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:08:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28E2B43D38;
 Wed, 29 Jul 2026 03:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24011F000E9;
 Wed, 29 Jul 2026 03:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294532;
 bh=ACIhgJZSCInkRGRjYUjvxBDBvb+6clc4g9y0fqQaMEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g8gewvvFzZ6/9UFE/8n5dpC7vQo1Zh7bYqAzwn/5b5JIq7ZYzmtSkIZAnUAbRzyZt
 Xod4rQOa8rTXJvNtTep+nZ62uyB5GKUaIDFMkOK6CjG+00Y6E/3jtY7Yi4OJC8N2Q8
 bez9sGz00XrFq3hI4te22t+KcnCOaqgpxH6iopigb6KGP0uoIHF8qXI5QUHLq7lZGB
 Bmcsz7eCfi3kW0AlCAo7vUEsPt92dj0omgGlG//97o9YeOmWxhK5jZx7vRm8KADwO4
 J2JLQtRLUkDm33K0s8Xa1rvLH8ufEo6eqm47vtUYU7DgvqXemCDIZckWG00ucNYuz+
 cBieN9CJR8eIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/13] drm/panfrost: Move all device power up and
 down into RPM callbacks
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-5-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:08:51 +0000
Message-Id: <20260729030851.B24011F000E9@smtp.kernel.org>
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
- [Critical] GPU cores remain unpowered after probe due to uninitialized fe=
ature masks during the initial RPM resume.
- [High] Driver unbind leaves hardware active and violates PM guidelines, r=
isking Use-After-Free and clock API violations.
- [High] Error paths in probe trigger RPM suspend callbacks that call `sync=
hronize_irq()` on uninitialized or negative IRQ numbers.
- [Low] Duplicate hardware teardown in `panfrost_device_init` error path.
- [Low] Unbalanced reset control assertion in probe error path.
--

--- Patch [5]: [PATCH v4 05/13] drm/panfrost: Move all device power up and =
down into RPM callbacks ---
commit 0a032cad0321fa83e882812bf23789897712f899
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Move all device power up and down into RPM callbacks

This patch moves all GPU enabling and disabling into runtime PM resume and
suspend callbacks. It aims to fix issues where the device remains powered on
forever due to usage count mismatches during probe failures or module unloa=
ds.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 03905495aee2d..a9d29d9ee22bb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -48,7 +82,7 @@ static int panfrost_clk_init(struct panfrost_device *pf=
dev)
[ ... ]
>  static void panfrost_clk_fini(struct panfrost_device *pfdev)
>  {
> -	clk_disable_unprepare(pfdev->bus_ace_clock);
> -	clk_disable_unprepare(pfdev->bus_clock);
> -	clk_disable_unprepare(pfdev->clock);
> +	if (!(pfdev->comp->pm_features & BIT(GPU_PM_RT)))
> +		panfrost_clk_disable(pfdev);

[Severity: Low]
Can this lead to an unbalanced reset control assertion in the probe error p=
ath?

When panfrost_clk_fini() is called during the out_clk error path in
panfrost_device_init(), it calls panfrost_clk_disable(), which asserts
pfdev->rstc.=20

The error path then falls through to out_reset, which calls
panfrost_reset_fini(). This asserts the exact same reset control a second
time, which can trigger a kernel warning from the reset controller subsystem
due to unbalanced assertion counts.

[ ... ]
> @@ -265,10 +437,25 @@ int panfrost_device_init(struct panfrost_device *pf=
dev)
[ ... ]
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
> -	err =3D panfrost_gpu_init(pfdev);
> +	err =3D panfrost_gpu_init(pfdev);

[Severity: Critical]
Does this sequence leave the GPU cores unpowered?

When pm_runtime_resume_and_get() triggers the runtime resume callback
(panfrost_device_runtime_resume()), it calls panfrost_gpu_power_on(). Howev=
er,
this happens before panfrost_gpu_init() has initialized pfdev->features.

Because pfdev->features is uninitialized at this point, it is entirely zero.

Consequently, panfrost_gpu_power_on() will write 0 to the power-on registers
(L2_PWRON_LO, etc.), which fails to power on the cores.

[ ... ]
> @@ -295,6 +482,8 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
>  	panfrost_mmu_fini(pfdev);
>  out_gpu:
>  	panfrost_gpu_fini(pfdev);
> +out_rpm_put:
> +	panfrost_try_suspend_device(pfdev);

[Severity: Low]
Does this error path duplicate hardware teardown?

If initialization fails after MMU init, the code jumps to out_mmu, manually
calling panfrost_mmu_fini() and panfrost_gpu_fini(). It then falls through
to out_rpm_put and calls panfrost_try_suspend_device().

This triggers the RPM suspend callback, which unconditionally calls
panfrost_mmu_suspend_irq(), panfrost_gpu_suspend_irq(), and
panfrost_gpu_power_off() a second time.

[Severity: High]
Can this error path trigger an out-of-bounds access in the IRQ descriptor t=
ree?

If panfrost_device_init() fails early (e.g., inside panfrost_gpu_init()),
the error path jumps to out_rpm_put and forces a runtime suspend. This
unconditionally executes panfrost_mmu_suspend_irq() and
panfrost_gpu_suspend_irq().

Because initialization failed early, pfdev->mmu_irq is 0, and if
platform_get_irq_byname() failed, pfdev->gpu_irq contains a negative error
code.

Passing these uninitialized or negative values to synchronize_irq()
can cause undefined behavior or synchronize unrelated system interrupts.

>  out_regulator:
>  	panfrost_regulator_fini(pfdev);
[ ... ]
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 331a3bd5b98cb..27f4c4b217f5b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
[ ... ]
> @@ -1019,10 +1016,9 @@ static void panfrost_remove(struct platform_device=
 *pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
> +
>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
>  }

[Severity: High]
Does this driver unbind sequence risk leaving the hardware active?

By removing pm_runtime_disable(), the teardown relies on
panfrost_try_suspend_device() (called inside panfrost_device_fini) to suspe=
nd
the device.

However, if panfrost_jm_is_idle() returns false, or if a userspace process
holds the PM usage count > 0 via sysfs power/control, the RPM suspend callb=
ack
is never executed.

In this scenario, panfrost_device_fini() proceeds to unconditionally free
resources and unprepare clocks while they are still enabled and the GPU is
still active.

This risks clock API violations and unhandled interrupt storms since the
hardware was never powered off or masked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D5
