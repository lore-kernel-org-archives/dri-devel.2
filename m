Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D18CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE4D10E19A;
	Thu,  4 Jun 2026 17:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cljl/VDY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E2910E19A
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:50:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FE5F60052;
 Thu,  4 Jun 2026 17:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09181F00893;
 Thu,  4 Jun 2026 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780595450;
 bh=MWzlz5Sr/G29hfG9hhCZdbU+uqlyw7pEBZH6yMeJ6Gc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cljl/VDYoKms4oKFCQQGFMLZgnd2qhns36HA2NPjg/6+6mF8Z+aOyEG8i0ig4jY8A
 aWdsab5m1I6szqum9lmo4x3XxLK65+TJ0Nhiyo3TaQQtOo2cHSnCIpT35LmNzRO0Bm
 QOSKrI+F4NacSfuwdMmQl8JDcTYOx/a0khX87wfMaNUqVyDus05yZObEeQUdCRRnoY
 A6Eymd1heEUu44bcYxzIsNlkoOOdJAnp3sW1HRBHltlltyndt1ststp0/LC7RDoY9A
 eavVjJ+/38eylrxaye9WVNt3wlUVF4krEDq8IYKa7e+obqmNpzAdo4beHnXPDoIDyY
 8U9gFnNYsYC0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] drm/panfrost: Fix PM usage_count mishandling
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-6-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:50:50 +0000
Message-Id: <20260604175050.A09181F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Reordering PM teardown in device removal and probe error paths cre=
ates race conditions (UAF/kernel panics) and violates PM domain rules.

Pre-existing issues:
- [High] Improper DRM device unplug allows subsequent ioctls to access free=
d driver resources, causing Use-After-Free.
--

commit 385821af932c300aa013c14b13508c8e9cf10f64
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Fix PM usage_count mishandling

This commit addresses a PM usage_count mishandling issue during device probe
and unplug. It adds balanced PM get/put calls to prevent devices from
staying powered on indefinitely or triggering constant devfreq OPP transiti=
on
notifications.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 2d4b6aa95c66d..545fbf2c8d0cb 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c

[ ... ]

> @@ -1000,10 +1001,12 @@ static int panfrost_probe(struct platform_device =
*pdev)
>  	if (err < 0)
>  		goto err_out1;
> =20
> +	pm_runtime_put_autosuspend(pfdev->base.dev);
> =20
>  	return 0;
> =20
>  err_out1:
> +	pm_runtime_put_noidle(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does dropping the usage count before pm_runtime_disable() create a race
condition where the suspend callback can run and disable clocks before
hardware shutdown?

Because the usage count is dropped early, a concurrent PM event could trigg=
er
the suspend callback, disabling clocks. Then, panfrost_device_fini() calls
panfrost_gpu_fini() which writes to MMIO registers. Could writing to
unclocked registers on ARM SoCs cause fatal bus errors or panics?

>  	pm_runtime_set_suspended(pfdev->base.dev);

[ ... ]

> @@ -1018,8 +1021,9 @@ static void panfrost_remove(struct platform_device =
*pdev)
>  	drm_dev_unregister(&pfdev->base);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This is a pre-existing issue, but does using drm_dev_unregister() instead of
drm_dev_unplug() allow subsequent ioctls to access freed driver resources?

Because drm_dev_unregister() removes the device from sysfs but does not set
the dev->unplugged flag, the DRM core (drm_ioctl_kernel) does not block
ioctls from userspace processes that already hold an open file descriptor.

Since panfrost_remove() proceeds to call panfrost_device_fini() which
destroys critical structures (job manager, MMU contexts, shrinker lists) and
powers down hardware, could a user issuing an ioctl during or after driver
unbind via sysfs access freed structures and unmapped MMIO regions, resulti=
ng
in a use-after-free?

> =20
>  	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
>  	panfrost_device_fini(pfdev);
> +	pm_runtime_put_noidle(pfdev->base.dev);
> +	pm_runtime_disable(pfdev->base.dev);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does placing pm_runtime_put_noidle() and pm_runtime_disable() after
panfrost_device_fini() create a window where runtime PM can access freed
structures?

pm_runtime_put_noidle() drops the PM usage count to 0. At this point, a
concurrent PM event (e.g., userspace writing to /sys/.../power/control) can
trigger panfrost_device_runtime_suspend() before pm_runtime_disable()
executes.

Since panfrost_device_fini() has already destroyed driver structures like t=
he
job manager, would the suspend callback access freed memory (like checking
panfrost_jm_is_idle), causing a use-after-free?

>  	pm_runtime_set_suspended(pfdev->base.dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-claude-fix=
es-v2-0-57c6bd4c1655@collabora.com?part=3D6
