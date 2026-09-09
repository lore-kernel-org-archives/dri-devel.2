Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DBFC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 19:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D706510E589;
	Wed,  9 Sep 2026 19:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SFmJk7Wt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C47410F261
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 19:26:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 395B5600CB;
 Wed,  9 Sep 2026 19:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24201F000FF;
 Wed,  9 Sep 2026 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788982013;
 bh=fqoqz2V1rDGICCd1wWLjrqUqtLi4Ako3KyJf/wxMtJY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SFmJk7WtMhDyRt4qaYNDrUkPil9y7xVnjsyOAyUEKF5vVqowqze+rHj6QZDqhFidU
 0THTBMBUDza+5QCCSTrRHGHg8BU6jXTGu+XUltDpMddgzpBUbSxFkedixdklo3klb4
 1OhWmCoAkIBpAiYGzeiXKBKM2X+0BRzofBDs3bvDcOstcSSqKkTyQOEj3wsyU9/+N6
 cDQ8JQQh5MN9QG5AgFSMcIvab7aVlj5zBa354NYkuz6uW6p/+Epy/XK0Ld1TYU6l8k
 HE14YsdB8e1qcklRnCvOeOLQ15rgUS3qwHZ9fm+PkZZTk8SdWdOTS98VhEfchrlEzS
 /i/DpEXhpH8/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: suspend the GPU for system sleep, not
 just runtime PM
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com>
References: <20260909-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 19:26:53 +0000
Message-Id: <20260909192653.C24201F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Delegating system suspend to pm_runtime_force_suspend causes syste=
m sleep to abort if the device is lost/unplugged.

Pre-existing issues:
- [Critical] Unkillable D-state deadlock when drm_dev_unplug() is called fr=
om within a drm_dev_enter() critical section.
- [High] Disabling a shared IRQ line during runtime suspend breaks other de=
vices on the same interrupt line.
- [High] Hardware registers are accessed in a shared IRQ handler without ve=
rifying the runtime PM state, causing spurious wakeups and infinite loops.
- [High] Failing to suspend leaves the GPU watchdog permanently disabled.
- [High] drm_dev_unplug() is called after device teardown, creating a Use-A=
fter-Free race window with userspace ioctls.
- [High] The watchdog worker is cancelled after device teardown, allowing i=
t to access freed firmware structures.
--

commit 957b9f18f16307577f7e0df349c4dedcef008a8d
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/imagination: suspend the GPU for system sleep, not just runtime PM

This commit addresses a system suspend bug where the GPU is not informed=20
of the suspend if it is runtime-active. By delegating system suspend to=20
the runtime PM force helpers, the GPU firmware is properly disabled=20
during system sleep.

>    The reset-path deadlock itself (drm_dev_unplug() waiting on an SRCU se=
ction
>    held by the ioctl that called pvr_power_reset()) is a separate problem=
 and
>    is not addressed here; this change only stops the system-sleep path fr=
om
>    triggering it.

[Severity: Critical]
This is a pre-existing issue, but the commit message acknowledges a deadlock
where drm_dev_unplug() blocks synchronously waiting for the SRCU lock held =
by
the caller, leaving the process in an unkillable D-state.

Can this still be triggered by local userspace submitting a job that hangs =
the
firmware or by an organic firmware hang?

If pvr_mmu_flush_exec() takes an SRCU read lock via drm_dev_enter(), and a
firmware lockup causes a flush timeout:

drivers/gpu/drm/imagination/pvr_mmu.c:pvr_mmu_flush_exec()
	err =3D pvr_power_reset(pvr_dev, true);

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_reset()
err_device_lost:
	drm_err(from_pvr_device(pvr_dev), "GPU device lost");
	pvr_device_lost(pvr_dev);

drivers/gpu/drm/imagination/pvr_device.c:pvr_device_lost()
	drm_dev_unplug(from_pvr_device(pvr_dev));

Will drm_dev_unplug() cause a deadlock by calling synchronize_srcu() to wait
for all drm_dev_enter() readers to exit, while the thread is waiting on its=
elf?

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index 5c965ef0274ff..23d353141589f 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> @@ -1517,6 +1517,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
> =20
>  static const struct dev_pm_ops pvr_pm_ops =3D {
>  	RUNTIME_PM_OPS(pvr_power_device_suspend, pvr_power_device_resume, pvr_p=
ower_device_idle)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)

[Severity: High]
Does delegating system suspend to pm_runtime_force_suspend() cause the syst=
em
sleep to abort if the device is lost or unplugged?

If the GPU crashes and is marked lost via drm_dev_unplug(), the PM core cal=
ls
the .suspend callback, which delegates to pvr_power_device_suspend():

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_device_suspend()
	if (!drm_dev_enter(drm_dev, &idx))
		return -EIO;

Since the device is unplugged, drm_dev_enter() fails, and the function retu=
rns
-EIO. Will this permanently break system suspend for the entire system until
reboot, since the PM core aborts system suspend if any device's .suspend
callback returns an error?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does disabling a shared IRQ =
line
during runtime suspend break other devices on the same interrupt line?

The driver registers its interrupt with IRQF_SHARED:

drivers/gpu/drm/imagination/pvr_device.c:pvr_device_irq_init()
				    IRQF_SHARED | IRQF_ONESHOT, "gpu", pvr_dev);

When the GPU enters runtime suspend organically:

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_fw_disable()
		/* This also waits for late processing of GPU or firmware IRQs in other c=
ores */
		disable_irq(pvr_dev->irq);

Will disabling a shared IRQ at the controller level silently stop other dev=
ices
on the same line from receiving interrupts, potentially breaking their
functionality or hanging the system? Should this use synchronize_irq() inst=
ead,
as mandated by the PM guidelines?

[Severity: High]
This is a pre-existing issue, but are hardware registers accessed in a shar=
ed
IRQ handler without verifying the runtime PM state, potentially causing spu=
rious
wakeups and infinite loops?

If another device on the shared interrupt line triggers an IRQ while the GP=
U is
in D3cold (powered off), the handler reads hardware registers:

drivers/gpu/drm/imagination/pvr_device.c:pvr_device_irq_handler()
	if (!pvr_fw_irq_pending(pvr_dev) && !safety_irq_pending)
		return IRQ_NONE; /* Spurious IRQ - ignore. */

	return IRQ_WAKE_THREAD;

drivers/gpu/drm/imagination/pvr_fw_meta.c:pvr_meta_irq_pending()
	return pvr_cr_read32(pvr_dev, ROGUE_CR_META_SP_MSLVIRQSTATUS) &
	       ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_EN;

On powered-off hardware, reads typically return 0xffffffff. Since this matc=
hes
the _EN bitmasks, will it falsely evaluate to true and return IRQ_WAKE_THRE=
AD,
leaving the threaded IRQ handler stuck in an infinite loop attempting to cl=
ear
non-existent interrupts? Should this check pm_runtime_get_if_active() before
accessing registers in shared handlers?

[Severity: High]
This isn't a bug introduced by this patch, but does failing to suspend leave
the GPU watchdog permanently disabled?

When the driver attempts runtime suspend:

drivers/gpu/drm/imagination/pvr_power.c:pvr_power_fw_disable()
		cancel_delayed_work_sync(&pvr_dev->watchdog.work);

		err =3D pvr_power_request_idle(pvr_dev);
		if (err)
			return err;

If the firmware idle request times out, it returns the error immediately. D=
oes
this leave the watchdog disabled without restarting it in the error path,
meaning a firmware hang will never be detected or recovered?

[Severity: High]
This is a pre-existing issue, but is drm_dev_unplug() called after device
teardown, creating a use-after-free race window with userspace ioctls?

drivers/gpu/drm/imagination/pvr_drv.c:pvr_remove()
	pvr_device_fini(pvr_dev);
	drm_dev_unplug(drm_dev);

If the device is unbound (e.g., via sysfs), pvr_device_fini() tears down
hardware state and frees structures. Because drm_dev_unplug() is only called
after teardown, drm_dev_enter() will still succeed inside concurrent ioctls.
Can this allow userspace ioctls to operate on freed firmware structures and
VM contexts?

[Severity: High]
This isn't a bug introduced by this patch, but is the async watchdog worker
cancelled after device teardown, allowing it to access freed firmware
structures?

drivers/gpu/drm/imagination/pvr_drv.c:pvr_remove()
	pvr_device_fini(pvr_dev);
	drm_dev_unplug(drm_dev);
	pvr_watchdog_fini(pvr_dev);

Because drm_dev_unplug() is ordered incorrectly, concurrent ioctls can cause
pm_runtime_suspend() to return -EAGAIN, leaving the device active.
pvr_device_fini() then frees firmware structures.

Since the watchdog delayed work is only cancelled later via
pvr_watchdog_fini(), if it fires in the meantime, can it access freed memor=
y?

drivers/gpu/drm/imagination/pvr_power.c:pvr_watchdog_kccb_stalled()
	u32 kccb_cmds_executed =3D pvr_dev->fw_dev.fwif_osdata->kccb_cmds_executed;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-rbrue-suez=
-upstreaming-pvr-suspend-gpu-system-sleep-v1-1-f45847bc951b@gmail.com?part=
=3D1
