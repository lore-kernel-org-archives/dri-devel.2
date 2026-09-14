Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323B2C88E66
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 02:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E02910EAEE;
	Mon, 14 Sep 2026 02:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q1go0mfx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A5A10EAEE
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:25:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78A576108A;
 Mon, 14 Sep 2026 02:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8CD1F000FF;
 Mon, 14 Sep 2026 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789352735;
 bh=F8sPPTYhKZsR7xeNAT5McBX0yzNLgwzGoouGd1Hiwc4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q1go0mfxynyShUq7oNy882Rf4YLwrDI3QrG62J7pFflSRIDl08ZN7E1EyVM1ghSgO
 In/hQzH6tjIOiESTpmrmZKoI61+wCXW4nt1ZmcusPfXjZB0OWHiPgJOV6CgKc/x/Mx
 XvR8EtAU9xWWBImylNfHqSbVWq0DtvRIwTmTCXUulVg5oKG6yaDt2qu8IBjDIig4R6
 4W4ECSD0HBtEtdSDu3T915W8/bZ8leqg8BrqqchWHEzG6nWSBS0zkycUtvVVdPCOyJ
 7+f2qpit6KyVv6RFHT1ETYYNwy/X58WY2a4uYXgz7DB+F/oZkDH/KVxZN3KyW4VERR
 CjWVmiWAHazzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] drm/imagination: suspend the GPU for system
 sleep, not just runtime PM
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-4-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-4-674b907d0652@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 02:25:34 +0000
Message-Id: <20260914022535.1B8CD1F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] IRQ handler reads hardware registers without checking if the devic=
e is active, and the suspend path improperly uses `disable_irq()` on a shar=
ed interrupt line.
- [High] Missing restart of watchdog delayed work on error paths in device =
suspend leaves the GPU unmonitored.
- [High] Deadlock in `pvr_power_reset()` via `drm_dev_unplug()` waiting for=
 `drm_dev_enter()` SRCU read lock.
--

commit dd73407528e8930d154962b48e871046b334e51f
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/imagination: suspend the GPU for system sleep, not just runtime PM

This commit adds SYSTEM_SLEEP_PM_OPS to pvr_pm_ops to ensure the GPU gets
callbacks for system suspend and resume. Previously, only RUNTIME_PM_OPS
were defined, which left the driver in an inconsistent state on system
resume if the GPU was active during suspend, leading to timeouts and
deadlocks. By forcing runtime suspend/resume during system sleep, this
patch avoids that inconsistent state.

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 20b27a468327b..b7931f75832fc 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1527,6 +1527,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
> =20
>  static const struct dev_pm_ops pvr_pm_ops =3D {
>  	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_p=
ower_device_idle)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)

[Severity: High]
This isn't a bug introduced by this patch, but does invoking these suspend
and resume paths reveal an issue with shared interrupts?

When pvr_device_irq_init() registers the interrupt, it uses the IRQF_SHARED
flag. However, during the suspend sequence, pvr_power_fw_disable() executes:

    disable_irq(pvr_dev->irq);

Will calling disable_irq() on a shared interrupt line improperly mask it
for all other devices sharing that line, rendering them unusable?

Additionally, if the shared interrupt fires from another device while the G=
PU
is suspended, pvr_device_irq_handler() will execute and unconditionally
access hardware registers:

    if (pvr_dev->has_safety_events)
        safety_irq_pending =3D pvr_device_safety_irq_pending(pvr_dev);

Since there is no pm_runtime_get_if_active() check before this read, could
this result in a bus error crash when attempting to access a powered-down
device?

[Severity: High]
This is a pre-existing issue, but does pvr_power_fw_disable() fail to
restart the watchdog on error paths?

The suspend path synchronously cancels the watchdog delayed work:

    cancel_delayed_work_sync(&pvr_dev->watchdog.work);

If an early error occurs, such as a timeout in pvr_power_request_idle(),
the function bails out:

    err =3D pvr_power_request_idle(pvr_dev);
    if (err)
        return err;

Because the function returns early without requeuing the watchdog work, the
suspend operation aborts but leaves the watchdog permanently stopped. Might
this leave the GPU unmonitored and unable to recover from future hardware
hangs?

[Severity: High]
This is a pre-existing issue noted in the commit message as a separate bug,
but could a failure in the reset path lead to an SRCU deadlock?

When pvr_mmu_flush_exec() attempts to flush the MMU, it first enters the
SRCU read-side critical section:

    if (!drm_dev_enter(from_pvr_device(pvr_dev), &idx))

If the operation times out and the subsequent hardware reset attempt in
pvr_power_reset() fails, the driver initiates the device lost flow:

    pvr_device_lost(pvr_dev);

This function eventually calls drm_dev_unplug(). Since drm_dev_unplug()
blocks in synchronize_srcu() waiting for all drm_dev_enter() sections to
complete, won't this deadlock against the current thread which is still
holding the SRCU read lock?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com?part=
=3D4
