Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC501C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BFB510EDB4;
	Tue, 11 Aug 2026 21:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j92YcCSj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3C0110EDB1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48815600E2;
 Tue, 11 Aug 2026 21:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB31F000E9;
 Tue, 11 Aug 2026 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485279;
 bh=ctXiLW80l8Os4W3MKogF70rC01u9/Iq5VCIQbsgYISI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j92YcCSjpgI2ZWnVuI7VU4ifde/N73TBLxonAKCw+HFEaebZuqtfFtfrr3/5yJPFS
 cZUuJJLPtHT+2vuEEh/63ePqXFSDCpdF99HgKr77Dz5RanqZA/LmNtRjCFWQysfaUs
 xewwhUjLppPjZ6gYV8Z1xep24RtylIN2wo+97DN0/16bQV+IBbSW51LZAjXhIyeWgV
 68CdwwVzJYCfEKnfyueavsC+ZVL6r6LFZXb0ES8bY/lDXPgrn0vG5EtGk9VPyV3eSK
 1gILFD8j42XqC0QTtOpAb4iwcMyttTFiHltS+773AWzQM5xnqNbJiU4xFkzd6gga0v
 7hKZfiuHPtAFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/11] drm/panfrost: Move all device power up and
 down into RPM callbacks
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-5-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-5-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:54:38 +0000
Message-Id: <20260811215438.D1DB31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Removing the explicit `pm_runtime_disable()` call in `panfrost_rem=
ove()` leaves PM runtime active while the driver tears down software struct=
ures and hardware abstractions. Because `devm_pm_runtime_enable()` postpone=
s disabling until after `remove()` returns, a concurrent sysfs write (e.g.,=
 `echo on > power/control`) can trigger `panfrost_device_runtime_resume()` =
on a partially destroyed device, causing use-after-free or null pointer der=
eferences.
- [High] The patch moves hardware teardown into `panfrost_device_runtime_su=
spend()` and relies on `pm_runtime_put_sync_suspend()` in `panfrost_try_sus=
pend_device()` to execute it during device removal. However, if the PM usag=
e count is > 0 (e.g., userspace held a sysfs power reference via `power/con=
trol =3D on`), the device will not actually suspend. The driver then procee=
ds to unconditionally unprepare clocks (`clk_unprepare()`) and regulators i=
n `panfrost_device_fini()`, even though they are still enabled and powering=
 active hardware.

Pre-existing issues:
- [High] In `panfrost_remove()`, the driver calls `pm_runtime_get_sync()` t=
o wake the hardware for teardown. If this fails, the hardware remains suspe=
nded (clocks and power domains off). The driver warns but unconditionally c=
ontinues to `panfrost_device_fini()`, which invokes `panfrost_jm_fini()` an=
d performs an MMIO write (`job_write(pfdev, JOB_INT_MASK, 0)`). Writing to =
unpowered/unclocked MMIO registers triggers a synchronous external abort on=
 ARM.
--

--- Patch [5]: [PATCH v5 05/11] drm/panfrost: Move all device power up and =
down into RPM callbacks ---
commit 01a89b3f3fd9da2c5ff706aa75efcef9f9333b91
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move all device power up and down into RPM callbacks

This commit moves all GPU enabling and disabling into runtime PM resume and
suspend callbacks to ensure the device is resumed before touching registers.
It also replaces explicit pm_runtime_disable() calls during module unload
with devres management.

> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -212,6 +258,127 @@ static int panfrost_pm_domain_init(struct panfrost_=
device *pfdev)
[ ... ]
> +void panfrost_try_suspend_device(struct panfrost_device *pfdev)
> +{
> +	pm_runtime_put_sync_suspend(pfdev->base.dev);

[Severity: High]
If userspace holds a power reference (for example, by setting power/control
to "on" via sysfs), the PM usage count will be greater than zero and the
device will not actually suspend here.

If the suspend silently aborts, the driver will proceed to
panfrost_device_fini() where panfrost_clk_fini() unconditionally calls
clk_unprepare():

panfrost_device_fini() ->
  panfrost_clk_fini()
    clk_unprepare(pfdev->bus_ace_clock);
    clk_unprepare(pfdev->bus_clock);
    clk_unprepare(pfdev->clock);

Does this leave the hardware abruptly deprived of prepared clocks and
regulators while it is still enabled?

> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -1015,10 +1015,9 @@ static void panfrost_remove(struct platform_device=
 *pdev)
> =20
>  	drm_dev_unregister(&pfdev->base);
> =20
> -	pm_runtime_get_sync(pfdev->base.dev);
> -	pm_runtime_disable(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
> +

[Severity: High]
This is a pre-existing issue, but if pm_runtime_get_sync() fails, the
hardware will remain suspended with its clocks and power domains off.

Because execution unconditionally continues to panfrost_device_fini(),
panfrost_jm_fini() will perform an MMIO write to JOB_INT_MASK:

panfrost_remove() ->
  panfrost_device_fini() ->
    panfrost_jm_fini()
       job_write(pfdev, JOB_INT_MASK, 0);

Writing to unpowered or unclocked MMIO registers usually triggers a
synchronous external abort on ARM. Should the teardown path be skipped or
handled differently if the resume fails?

>  	panfrost_device_fini(pfdev);
> -	pm_runtime_set_suspended(pfdev->base.dev);
>  }

[Severity: High]
Can removing the explicit pm_runtime_disable() call here cause a
use-after-free during teardown?

Since devm_pm_runtime_enable() postpones disabling PM runtime until after
the remove() function returns, PM runtime remains active while
panfrost_device_fini() destroys software structures and hardware abstractio=
ns.

Could a concurrent sysfs write (like echoing "on" to power/control) trigger
panfrost_device_runtime_resume() on a partially destroyed device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D5
