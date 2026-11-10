Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E7606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIfRscum
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06CDD10E087;
	Tue, 10 Nov 2026 16:44:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C35310E087
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:44:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23DE341FC5;
 Tue, 10 Nov 2026 16:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1891F0089F;
 Tue, 10 Nov 2026 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794329064;
 bh=kzL1CALYE4D4LxTCjVLy3uXvlxOGnX9cArbphv5kmw0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=GIfRscumPFUomUDHbJa+LmJuXnSX8ZvGFDJ5i2xre+OhlIUngOtDJ3HqnssEw6lCW
 dhJS9+qLRNZBm0IijFdYTLJ7H6QsoxTpJ2UBWJk2s2gYVyDP2LXj7WD3XhsEvWLFsd
 XDRLWQsIleMHh3Pc7aOrPb/bcNTiP5IJKIblzhp+hPsYItaLi8XOu5JkJHROPjJHSz
 T/4mXo+Ikq1P1u/W7TjoqD/HRprB2NNXl4IEFfsO9mS7XrMsvtA6fG0zdBDaJ6F3xK
 i6RRET2xN5z962B4kW69lESErP4H+bwiTyvUj2nesEmZvxjnzkiuyxp15Mcnj6DzxG
 iCUR2YsRtP3mg==
Message-ID: <sashiko-outbox-207405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/28] drm/panthor: Prevent missed post-yield cleanup
 due to reset
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-28-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-28-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:44:23 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/panthor: panthor_sched_pre_reset() runs before
  panthor_aw_pre_reset()
- [High] drm/panthor: lost slow reset in panthor_device_reset_work() on
  AW loss
- [High] drm/panthor: race between panthor_device_reset_work() and AW HW
  component PM
- [Medium] drm/panthor: panthor_aw_post_reset() sets GPU_GRANTED before
  checking window
- [Medium] drm/panthor: panthor_pwr_reset_soft() fails before GPU access
  check
- [Medium] drm/panthor: panthor_pwr_reset() leaves
  PWR_IRQ_RESET_COMPLETED set on timeout
- [Medium] drm/panthor: unhandled AW reset events in
  panthor_gpu_suspend()
--

commit 04a925f0f5b623c17e694b1b19489978a653cb56
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Prevent missed post-yield cleanup due to reset

This commit adds a PANTHOR_AW_STATE_RESET_ACTIVE state to ignore
reset-induced access-window events during GPU resets and schedule
post-yield cleanup afterward if the hardware window closed.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index f344a2aa32979..f7fcf51c2c632 100644
> --- a/drivers/gpu/drm/panthor/panthor_aw.c
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
[ ... ]
> @@ -637,5 +644,46 @@ bool panthor_aw_has_gpu_access(struct panthor_device=
 *ptdev)
[ ... ]
> +int panthor_aw_pre_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +
> +	if (!aw)
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&aw->lock);
> +
> +	if (!panthor_aw_state_try_set(ptdev->aw, PANTHOR_AW_STATE_GPU_GRANTED,
> +				      PANTHOR_AW_STATE_RESET_ACTIVE))
> +		return -EAGAIN;
> +
> +	return 0;
> +}

[Severity: High]
Can panthor_device_reset_work() race with panthor_device_resume_hw_componen=
ts()
when an access window is re-granted while runtime PM is active?

When an access window yields while ptdev->pm.state is
PANTHOR_DEVICE_PM_STATE_ACTIVE, panthor_aw_post_yield_work() suspends the
hardware components under ptdev->pm.hw_component_lock while ptdev->pm.state
stays active.  On the next panthor_aw_resume(), panthor_aw_request() sets
aw->state to PANTHOR_AW_STATE_GPU_GRANTED before
panthor_device_resume_hw_components() acquires ptdev->pm.hw_component_lock:

kworker (reset.work)              caller (panthor_aw_resume)
                                  panthor_aw_request()
                                    <hardirq>
                                      panthor_aw_handle_window_opened()
                                        aw->state =3D GPU_GRANTED
panthor_device_reset_work()
  panthor_aw_pre_reset()
    aw->state =3D RESET_ACTIVE
  panthor_mmu_pre_reset()
                                  panthor_device_resume_hw_components()
                                    panthor_gpu_resume()
                                    panthor_mmu_resume()
  panthor_hw_soft_reset()
  panthor_mmu_post_reset()          panthor_fw_resume()  <-- concurrent res=
et/resume

Because neither panthor_device_reset_work() nor panthor_aw_pre_reset()
synchronizes with ptdev->pm.hw_component_lock or checks
ptdev->pm.hw_component_state, the reset worker can reset the GPU, MMU, and
firmware while panthor_device_resume_hw_components() is concurrently
resuming them, corrupting ptdev->mmu->as.alloc_mask and causing firmware
boot failure that triggers panthor_device_unplug().

> +
> +void panthor_aw_post_reset(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +
> +	if (!aw)
> +		return;
> +
> +	guard(spinlock_irqsave)(&aw->lock);
> +
> +	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_RESET_ACTIVE,
> +				 PANTHOR_AW_STATE_GPU_GRANTED);
> +
> +	if (!panthor_aw_is_open(aw))
> +		panthor_aw_schedule_post_yield_work(aw);
> +}

[Severity: Medium]
If the hardware access window closed during the reset, does calling
panthor_aw_state_try_set() before panthor_aw_is_open() briefly expose a
false PANTHOR_AW_STATE_GPU_GRANTED state and wake aw->waitqueue?

panthor_aw_state_try_set() sets aw->state to PANTHOR_AW_STATE_GPU_GRANTED
and calls wake_up_all(&aw->waitqueue) before panthor_aw_is_open() checks
WINDOW_STATUS and transitions aw->state to PANTHOR_AW_STATE_SUSPEND_PENDING.
Lockless readers such as panthor_aw_has_gpu_access(), panthor_aw_resume(),
and panthor_aw_state_wait_transition() do not take aw->lock, so they can
observe PANTHOR_AW_STATE_GPU_GRANTED and proceed as if GPU access were held
even though the window is closed.

In addition, when panthor_aw_post_reset() transitions aw->state to
PANTHOR_AW_STATE_SUSPEND_PENDING, any pending WINDOW_CLOSED interrupt that
fires afterward will hit the default branch in
panthor_aw_handle_window_closed() and warn "Unexpected WINDOW_CLOSED
received" because PANTHOR_AW_STATE_SUSPEND_PENDING is not handled there
(unlike in panthor_aw_handle_window_opened()).

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index d1ef460577c99..d4a67277fe6fa 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -140,14 +140,27 @@ static void panthor_device_reset_work(struct work_s=
truct *work)
>  		return;
> =20
>  	panthor_sched_pre_reset(ptdev);
> +	if (panthor_aw_pre_reset(ptdev) =3D=3D -EAGAIN) {
> +		atomic_set(&ptdev->reset.pending, 0);
> +		panthor_sched_post_reset(ptdev, false);
> +		goto out_dev_exit;
> +	}

[Severity: High]
Should panthor_aw_pre_reset() run before panthor_sched_pre_reset()?

panthor_aw_post_yield_work() suspends hardware components without calling
panthor_sched_suspend(), so user groups remain bound to CSG slots while the
access window is closed.  When panthor_sched_pre_reset() runs before
panthor_aw_pre_reset() has verified PANTHOR_AW_STATE_GPU_GRANTED,
panthor_sched_suspend() rings CSF_GLB_DOORBELL_ID over the closed window and
waits in panthor_fw_csg_wait_acks() -> panthor_fw_wait_acks(), which does
not check panthor_aw_has_gpu_access().  Every bound CSG times out on
CSG_STATE_SUSPEND, escalates to CSG_STATE_TERMINATE, and marks innocent user
groups asPANTHOR_CS_GROUP_TERMINATED.  Furthermore, if
panthor_aw_post_yield_work() already ran panthor_mmu_suspend() (which resets
vm->as.active_cnt to 0 via panthor_vm_release_as_locked()), unbinding those
groups in panthor_sched_suspend() calls panthor_vm_idle() and underflows
vm->as.active_cnt.

Even when aw->state starts in PANTHOR_AW_STATE_GPU_GRANTED, running
panthor_sched_pre_reset() before transitioning to
PANTHOR_AW_STATE_RESET_ACTIVE means a WINDOW_CLOSED event arriving while
CSGs are suspending will schedule post_yield_work concurrently with the
reset.

>  	panthor_fw_pre_reset(ptdev, true);
>  	panthor_mmu_pre_reset(ptdev);
> +
>  	panthor_hw_soft_reset(ptdev);

[Severity: Medium]
Does panthor_gpu_suspend() also need PANTHOR_AW_STATE_RESET_ACTIVE
protection when it calls panthor_hw_soft_reset()?

drivers/gpu/drm/panthor/panthor_gpu.c:panthor_gpu_suspend() {
    ...
	if (!ptdev->reset.fast)
		panthor_hw_soft_reset(ptdev);
	else
		panthor_hw_l2_power_off(ptdev);

	panthor_gpu_irq_suspend(ptdev);
}

When panthor_aw_suspend() (or the error path of panthor_aw_resume()) calls
panthor_device_suspend_hw_components() after a failed MCU halt or slow-reset
boot failure, panthor_gpu_suspend() executes panthor_hw_soft_reset() while
aw->state is still PANTHOR_AW_STATE_GPU_GRANTED.  The reset-induced
WINDOW_CLOSED interrupt transitions aw->state to
PANTHOR_AW_STATE_SUSPEND_PENDING and queues post_yield_work, so the
subsequent __panthor_aw_suspend() sees PANTHOR_AW_STATE_SUSPEND_PENDING and
returns 0 without sending VM_ARB_GPU_STOPPED, leaving the hardware window
open and the arbiter out of sync with aw->state once post_yield_work sets
PANTHOR_AW_STATE_READY.

> +
>  	panthor_hw_l2_power_on(ptdev);
>  	panthor_mmu_post_reset(ptdev);
>  	ret =3D panthor_fw_post_reset(ptdev);
> +	if (ret && !panthor_aw_has_gpu_access(ptdev))
> +		ret =3D 0;
> +
> +	panthor_aw_post_reset(ptdev);
>  	atomic_set(&ptdev->reset.pending, 0);

[Severity: High]
When a reset is aborted at panthor_aw_pre_reset() or loses GPU access before
panthor_fw_post_reset() completes, does clearing ptdev->reset.pending cause
the next resume to skip a required slow reset?

When the access window closes, panthor_aw_post_yield_work() runs
panthor_fw_suspend() -> panthor_fw_pre_reset(ptdev, false):

drivers/gpu/drm/panthor/panthor_fw.c:panthor_fw_pre_reset() {
    ...
	ptdev->reset.fast =3D false;

	if (!on_hang) {
		panthor_fw_halt_mcu(ptdev);
		if (!panthor_fw_wait_mcu_halted(ptdev))
			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
		else
			ptdev->reset.fast =3D true;
	}
    ...
}

Because panthor_fw_mcu_halted() returns true whenever
!panthor_aw_has_gpu_access(ptdev), panthor_fw_pre_reset(ptdev, false) sets
ptdev->reset.fast =3D true even though the MCU was never cleanly halted (or
failed to boot during panthor_fw_post_reset()).  With ptdev->reset.pending
also cleared to 0 here and in the -EAGAIN branch above, the subsequent
panthor_aw_resume() or panthor_device_resume() performs a fast reset instead
of reloading the firmware sections.

> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index 66a2c54b070dc..eef400c4bc6fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -113,6 +113,9 @@ static int panthor_pwr_reset(struct panthor_device *p=
tdev, u32 reset_cmd)
>  		if (reset_pending(ptdev)) {
>  			drm_WARN(&ptdev->base, 1, "Reset already pending");
>  		} else {
> +			if (!panthor_aw_has_gpu_access(ptdev))
> +				return 0;
> +
>  			ptdev->pwr->pending_reqs |=3D PWR_IRQ_RESET_COMPLETED;
>  			gpu_write(pwr->irq.iomem, INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
>  			panthor_pwr_write_command(ptdev, reset_cmd, 0);

[Severity: Medium]
Can panthor_pwr_reset() reach this panthor_aw_has_gpu_access() check when
the access window is already closed?

Its caller panthor_pwr_reset_soft() reads PWR_STATUS first:

drivers/gpu/drm/panthor/panthor_pwr.c:panthor_pwr_reset_soft() {
    ...
	if (!(gpu_read64(pwr->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
		drm_err(&ptdev->base, "RESET_SOFT not allowed");
		return -EOPNOTSUPP;
	}

	return panthor_pwr_reset(ptdev, PWR_COMMAND_RESET_SOFT);
}

When GPU access is lost, gpu_read64(pwr->iomem, PWR_STATUS) reads 0 over the
closed window, so panthor_pwr_reset_soft() logs a false "RESET_SOFT not
allowed" error and returns -EOPNOTSUPP before calling panthor_pwr_reset().
panthor_pwr_l2_power_on(), called right after panthor_hw_soft_reset() in
panthor_device_reset_work(), similarly reads PWR_STATUS as 0 without
checking panthor_aw_has_gpu_access() and logs a false "Power on L2 domain
not allowed" warning.

> @@ -622,5 +625,9 @@ void panthor_pwr_resume(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return;
> =20
> +	/* clear any pending resets on resume to prevent blocking future resets=
 */
> +	scoped_guard(spinlock_irqsave, &ptdev->pwr->reqs_lock)
> +		ptdev->pwr->pending_reqs &=3D ~PWR_IRQ_RESET_COMPLETED;
> +
>  	panthor_irq_resume(&ptdev->pwr->irq);
>  }

[Severity: Medium]
Should panthor_pwr_reset() also clear PWR_IRQ_RESET_COMPLETED before
returning -ETIMEDOUT?

drivers/gpu/drm/panthor/panthor_pwr.c:panthor_pwr_reset() {
    ...
	if (!wait_event_timeout(ptdev->pwr->reqs_acked, !reset_pending(ptdev),
				msecs_to_jiffies(PWR_RESET_TIMEOUT_MS))) {
		guard(spinlock_irqsave)(&ptdev->pwr->reqs_lock);

		if (reset_pending(ptdev) && !reset_irq_raised(ptdev) &&
		    panthor_aw_has_gpu_access(ptdev)) {
			drm_err(&ptdev->base, "RESET timed out (0x%x)", reset_cmd);
			return -ETIMEDOUT;
		}

		ptdev->pwr->pending_reqs &=3D ~PWR_IRQ_RESET_COMPLETED;
	}
}

If the access window closes during panthor_pwr_reset() (aborting the
hardware reset) and re-opens before the 500ms wait_event_timeout() expires,
panthor_aw_has_gpu_access() is true both in panthor_pwr_reset() and in
panthor_aw_post_reset().  panthor_pwr_reset() returns -ETIMEDOUT without
clearing PWR_IRQ_RESET_COMPLETED, and panthor_aw_post_reset() sees the open
window and does not schedule post_yield_work, so panthor_pwr_resume() never
runs and future panthor_pwr_reset() calls hit drm_WARN("Reset already
pending") without issuing the reset command.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D27
