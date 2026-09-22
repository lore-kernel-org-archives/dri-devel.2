Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC13C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1609310EC53;
	Tue, 22 Sep 2026 10:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O9/UJF9R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA7110EC53;
 Tue, 22 Sep 2026 10:31:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B34D960DE3;
 Tue, 22 Sep 2026 10:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDD61F000FF;
 Tue, 22 Sep 2026 10:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790073087;
 bh=7gEj3uM7qEMqcb189GqaSuXN0M7/tLGHFCxOWArHQsI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O9/UJF9RTSLkUUi+CJYEKiGKxeTkWCKM2KJC8nRjQ0MKwLY/bFYc4TA+2GuefFaxo
 oCMH0I/bQPpEaiJpbnDnBQIP4fb+q/9UQRLPIVRZyd0jxbbxS40P+7QMh6HhsZyMrI
 XvojYPHtikasVpjA/bm8t+6tby/b26PkXXUcS4rg7b2LgfLG4eltLrMb1CGq0dzH+S
 6lG+L0fENB+kXURmA0QeP7gZ6ubr2hJs3+twDeTLey2OslZVcoa87mWmy+KqiqTVRE
 KhJ/aw5m0F43yo5Y9mj/WLZk/dB8vTDhHTS1gEqrgEcJyLBhQ5LX+2EnZxdg0kboMv
 w8PtSB1KMH6vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] drm/xe: Isolate a wedged device before
 notifying userspace
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260922101721.1583542-12-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
 <20260922101721.1583542-12-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:31:26 +0000
Message-Id: <20260922103127.3FDD61F000FF@smtp.kernel.org>
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
- [High] drm/xe: TOCTOU race in xe_display_register leaves display active w=
ithout IRQs
- [High] drm/xe: double suspend of display hardware due to wedge during PM
--

commit f1762c4030fdcf19e70d9970658fdb7e79d5019c
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Isolate a wedged device before notifying userspace

A permanently wedged device must stop interrupt and DMA activity before
userspace is notified that recovery is required. The commit runs the
sleepable isolation steps from the wedge worker.

> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe=
/display/xe_display.c
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -150,21 +150,27 @@ void xe_display_register(struct xe_device *xe)
>  {
>  	struct intel_display *display =3D xe->display;
> =20
> -	if (!xe->info.probe_display)
> +	if (!xe->info.probe_display || xe->display_registered)
>  		return;
> =20
>  	intel_display_driver_register(display);
>  	intel_display_driver_runtime_pm_enable(display);
> +
> +	xe->display_registered =3D true;

[Severity: High]
Could the async wedge worker race with the display probe thread here?

The display is registered without any locking to prevent concurrent
isolation by the async wedge worker.

>  }
> =20
>  void xe_display_unregister(struct xe_device *xe)
>  {
>  	struct intel_display *display =3D xe->display;
> =20
> -	if (!xe->info.probe_display)
> +	if (!xe->info.probe_display || !xe->display_registered)
>  		return;

[Severity: High]
The wedge worker reads xe->display_registered unprotected and returns early
if registration is still in progress in the probe thread.

[ ... ]
> @@ -172,7 +178,8 @@ void xe_display_shutdown(struct xe_device *xe)
>  {
>  	struct intel_display *display =3D xe->display;
> =20
> -	if (!xe->info.probe_display)
> +	if (!xe->info.probe_display || !xe->display_registered ||
> +	    xe->display_shutdown)
>  		return;
> =20
>  	intel_display_driver_shutdown(display);
> @@ -180,6 +187,8 @@ void xe_display_shutdown(struct xe_device *xe)
>  	intel_opregion_suspend(display, PCI_D3cold);
> =20
>  	intel_dmc_suspend(display);
> +
> +	xe->display_shutdown =3D true;
>  }

[Severity: High]
When a synchronous wedge worker calls xe_device_wedged_isolate() during
suspend, it executes xe_display_shutdown().

Since xe->display_shutdown is false, it proceeds to call
intel_dmc_suspend(), intel_opregion_suspend(), and
intel_display_driver_shutdown() a second time. Could this cause a wakeref
underflow and unbalanced runtime PM state for the display hardware?

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
[ ... ]
> +static void xe_device_wedged_isolate(struct xe_device *xe)
> +{
[ ... ]
> +	/* Shut down display hardware before stopping device access. */
> +	xe_display_shutdown(xe);
> +	xe_display_unregister(xe);
> +
> +	/* Stop interrupt and DMA activity before changing mappings. */
> +	xe_irq_suspend(xe);
> +	pci_clear_master(to_pci_dev(xe->drm.dev));

[Severity: High]
If the device wedges asynchronously during device probe, could the wedge
worker miss the display unregistration because xe->display_registered is not
yet true, but then continue to disable hardware access?

If the probe thread then proceeds to complete xe_display_register(), the
display remains registered and exposed to userspace, but the device has its
interrupts and DMA (PCI master) permanently disabled. This could cause
userspace modesets and page flips to time out and hang since VBLANK
interrupts will never fire.

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -1325,19 +1325,38 @@ static int xe_pci_suspend(struct device *dev)
>  {
[ ... ]
> +	} else {
> +		err =3D xe_pm_suspend(xe);
> +		xe_device_io_put(io_idx);
> +
> +		if (xe_device_wedged(xe)) {
> +			wait_for_completion(&xe->wedged.prepared);
> +			flush_work(&xe->wedged.work);
> +		} else if (err) {
> +			return err;
> +		}
> +	}

[Severity: High]
Can a wedge during suspend cause a double suspend of the display hardware?

If a wedge event occurs during xe_pm_suspend(), the display has already been
suspended via xe_display_pm_suspend(). Since xe_pm_suspend() does not set
the xe->display_shutdown flag, this flush_work() will execute the wedge
worker synchronously, resulting in xe_display_shutdown() suspending the
hardware again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101721.1583=
542-1-arvind.yadav@intel.com?part=3D11
