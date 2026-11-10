Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C296B606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMkWyIN7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E773C10E039;
	Tue, 10 Nov 2026 16:50:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303EA10E5F8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:50:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 15E354504F;
 Tue, 10 Nov 2026 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECC51F008A5;
 Tue, 10 Nov 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794329438;
 bh=Gj80cEpUFU62uslEx6ZDNzSu655g76QPxINlJBB6oxA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=YMkWyIN7h5Ff+B5uR5X6Ez/gxe1pYzhmrzeVLVJ56O9dblviVZ/+C+zehkduBi/5G
 I8hnQ1mwC3qoCx1oww7sySm4gAdXE77yR4m2EI0ZKAU6Q9gtHaNv9H93B9Ptl1q8oM
 j68xCXCqs/rq2yzPPyWc15QC2VoBvz4tWhSZlaZ9isK1UFTSEHdjSg8kHwNp4foYuy
 Vfk8qiaPB3kXK2s+rf89aPsnXfWviLowLYkFHIhm4FfSUGDkSSmJuFxuJd//8+3OQk
 nf/a4wi76YoXHKrpsWhiRxnpDLIROAmP2qXkgLxZmZbtxBO3Q7ExZ6IV+oCR4QcM2M
 vHqZGK+gmIoYw==
Message-ID: <sashiko-outbox-207417@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 25/28] drm/panthor: Route HW component PM through
 access windows
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-26-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-26-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:50:37 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/panthor: missing panthor_sched_suspend() in
  panthor_aw_post_yield_work()
- [High] drm/panthor: race between panthor_aw_ensure_gpu_access() and
  post_yield_work
- [High] drm/panthor: endless AW yield-request ping-pong from
  panthor_aw_post_yield_work()
- [Medium] drm/panthor: panthor_device_resume() treats -EAGAIN as
  fast-reset failure
- [Medium] drm/panthor: __panthor_aw_suspend() leaves state as
  SUSPEND_PENDING
- [Medium] drm/panthor: unhandled -EAGAIN from panthor_aw_resume() on PM
  paths
--

commit 4fae2615b4ec401e9748b231f8ea063e488e1f9a
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Route HW component PM through access windows

This commit routes hardware component suspend and resume through the access
window layer when AW support is present, defers post-yield cleanup to a
workqueue, and updates panthor_device_resume_and_get() to ensure GPU access=
 is
granted before returning.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index 5ab1d44f0a22e..3b418c816d824 100644
> --- a/drivers/gpu/drm/panthor/panthor_aw.c
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
[ ... ]
> @@ -114,6 +117,66 @@ static int panthor_aw_state_wait(struct panthor_aw *=
aw,
>  	return panthor_aw_wait_cond(aw, atomic_read(&aw->state) =3D=3D target, =
timeout_ms);
>  }
> =20
> +static int panthor_aw_state_wait_transition(struct panthor_aw *aw, u32 t=
imeout_ms)
> +{
> +	return panthor_aw_wait_cond(
> +		aw,
> +		(atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_READY ||
> +		 atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_GPU_GRANTED),
> +		timeout_ms);
> +}
> +
> +static void panthor_aw_post_yield_work(struct work_struct *work)
> +{
> +	struct panthor_aw *aw =3D
> +		container_of(work, struct panthor_aw, post_yield_work);
> +	struct panthor_device *ptdev =3D aw->ptdev;
> +	struct device *dev =3D ptdev->base.dev;
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &aw->lock) {
> +		/* Something else has progressed the state to READY. */
> +		if (atomic_read(&aw->state) !=3D PANTHOR_AW_STATE_SUSPEND_PENDING)
> +			return;
> +	}

[Severity: Medium]
Does any other path ever transition aw->state from
PANTHOR_AW_STATE_SUSPEND_PENDING to PANTHOR_AW_STATE_READY?

When panthor_aw_suspend() runs after a WINDOW_CLOSED interrupt sets
PANTHOR_AW_STATE_SUSPEND_PENDING, it suspends the hardware components and
calls __panthor_aw_suspend(), which returns 0 on
PANTHOR_AW_STATE_SUSPEND_PENDING without updating aw->state:

drivers/gpu/drm/panthor/panthor_aw.c:__panthor_aw_suspend() {
	scoped_guard(spinlock_irqsave, &aw->lock) {
		switch (atomic_read(&aw->state)) {
		case PANTHOR_AW_STATE_READY:
			return 0;
		case PANTHOR_AW_STATE_SUSPEND_PENDING:
			return 0;
    ...
}

Because aw->state remains PANTHOR_AW_STATE_SUSPEND_PENDING after runtime
suspend finishes, panthor_aw_post_yield_work() does not exit early here and
calls panthor_sched_resume(), which schedules tick_work and wakes the
suspended GPU back up.  If system resume (pm_runtime_force_resume()) runs
before post_yield_work instead, panthor_aw_resume() sees
PANTHOR_AW_STATE_SUSPEND_PENDING and fails system resume with -EAGAIN.

> +
> +	/*
> +	 * Ensure in-progress resume is completed and prevent future RPM suspend
> +	 * to keep the clocks turned on when accessing HW registers.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_barrier(dev);
> +
> +	ret =3D panthor_device_suspend_hw_components(ptdev);
> +	if (ret)
> +		dev_warn(dev, "Failed to suspend hardware components.");

[Severity: High]
Doesn't panthor_aw_post_yield_work() need to suspend or unbind scheduler
groups before calling panthor_device_suspend_hw_components()?

Unlike panthor_device_suspend(), which calls panthor_sched_suspend() before
panthor_aw_suspend(), panthor_aw_post_yield_work() leaves groups bound in
sched->csg_slots[] with group->csg_id >=3D 0 while
panthor_device_suspend_hw_components() stops the MCU and calls
panthor_mmu_suspend().  panthor_mmu_suspend() disables all active address
spaces and calls panthor_vm_release_as_locked(), resetting vm->as.id =3D -1=
 and
vm->as.active_cnt =3D 0 on those still-bound groups.

On the next scheduler tick after hardware components resume, tick_ctx_apply=
()
sees group->csg_id >=3D 0 and skips group_bind_locked(), panthor_vm_active(=
),
and CSG programming, leaving the bound groups unmapped in the MMU and
unconfigured on the rebooted MCU.  When those groups are later unbound in
group_unbind_locked(), panthor_vm_idle() decrements vm->as.active_cnt from 0
(underflowing refcount_t) and hits drm_WARN_ON(&ptdev->base, vm->as.id =3D=
=3D -1).
In addition, if runtime suspend runs before the hardware components are
resumed again, panthor_device_suspend() will call panthor_sched_suspend()
while the MCU is stopped and the access window is closed.

> +
> +	scoped_guard(spinlock_irqsave, &aw->lock)
> +		panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
> +
> +	/*
> +	 * schedule an immediate tick to re-evaluate if there is any additional
> +	 * work. This will request access to the GPU again and if the driver has
> +	 * gone idle, it will yield GPU access via the runtime suspend path.
> +	 */
> +	panthor_sched_resume(ptdev);
> +
> +	pm_runtime_put_autosuspend(dev);
> +}

[Severity: High]
Can calling panthor_sched_resume() unconditionally here cause an endless
request/yield livelock between two idle access windows sharing a partition?

When AW0 is idle inside its 50ms autosuspend window and AW1 requests the GP=
U,
the arbiter issues PART_CMD_YIELD_IDLE and FW v2 closes AW0's window,
scheduling panthor_aw_post_yield_work() on AW0.  panthor_sched_resume() then
queues tick_work with delay 0, and tick_work() calls
panthor_device_resume_and_get() -> panthor_aw_ensure_gpu_access() ->
panthor_aw_request() before checking whether AW0 has any runnable groups.

Sending VM_ARB_GPU_REQUEST from idle AW0 causes the arbiter to issue
PART_CMD_YIELD_IDLE to AW1.  Once AW1 finishes its work and yields to AW0,
AW1's panthor_aw_post_yield_work() likewise requests the GPU back from AW0,
while AW0's tick_work() finds no runnable work and resets its 50ms
autosuspend timer via pm_runtime_put_autosuspend().  Both access windows can
then ping-pong GPU ownership and hardware component suspend/resume
indefinitely without ever reaching runtime autosuspend.

[ ... ]

> @@ -463,21 +538,41 @@ int panthor_aw_resume(struct panthor_device *ptdev)
>  	struct panthor_aw *aw =3D ptdev->aw;
>  	int ret;
> =20
> +	/* resume hw components directly if AW is not supported */
>  	if (!aw)
> -		return 0;
> +		return panthor_device_resume_hw_components(ptdev);
> =20
>  	panthor_aw_irq_resume(&aw->irq);
> =20
> +again:
>  	ret =3D panthor_aw_request(aw);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D panthor_device_resume_hw_components(ptdev);
>  	if (ret) {
> -		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
> +		/* Yield GPU access if HW components failed to resume */
> +		__panthor_aw_suspend(aw);
>  		goto err_out;
>  	}
> =20
> -	return 0;
> +	switch (atomic_read(&aw->state)) {
> +	case PANTHOR_AW_STATE_SUSPEND_PENDING:
> +		/*
> +		 * WINDOW_CLOSED won the race. Suspend components before the
> +		 * caller can disable clocks. post_yield_work will transition
> +		 * state to READY after this PM transition completes.
> +		 */
> +		panthor_device_suspend_hw_components(ptdev);
> +		ret =3D -EAGAIN;
> +		break;
> +	case PANTHOR_AW_STATE_GPU_GRANTED:
> +		return 0;
> +	default:
> +		goto again;
> +	}
> =20
>  err_out:
> -	panthor_aw_irq_suspend(&aw->irq);
>  	return ret;
>  }

[Severity: High]
Can panthor_aw_ensure_gpu_access() -> panthor_aw_resume() race with
panthor_aw_post_yield_work() when the device is already RPM_ACTIVE?

panthor_aw_post_yield_work() uses pm_runtime_barrier(dev) to wait for an
in-progress runtime resume, but panthor_device_resume_and_get() calls
panthor_aw_ensure_gpu_access() after pm_runtime_resume_and_get() has already
set the device to RPM_ACTIVE.  In that state pm_runtime_barrier(dev) returns
immediately, and nothing serializes panthor_aw_resume() against
panthor_aw_post_yield_work() or a second caller of
panthor_aw_ensure_gpu_access():

CPU0                              CPU1 (kworker / second caller)
panthor_aw_ensure_gpu_access()
  panthor_aw_resume()
    panthor_device_resume_hw_components()
    /* WINDOW_CLOSED sets SUSPEND_PENDING */
    switch (atomic_read(&aw->state))
    case PANTHOR_AW_STATE_SUSPEND_PENDING:
                                  panthor_aw_post_yield_work()
                                    pm_runtime_barrier() /* no-op */
                                    panthor_device_suspend_hw_components()
                                    panthor_aw_state_set(READY)
                                  panthor_aw_ensure_gpu_access()
                                    panthor_aw_resume()
                                      panthor_aw_request() /* GRANTED */
                                      panthor_device_resume_hw_components()
                                      return 0
      panthor_device_suspend_hw_components()
      <-- suspends FW/MMU/GPU/PWR while CPU1 is using the GPU

Alternatively, if WINDOW_CLOSED fires after panthor_aw_request() succeeds on
CPU0 but before CPU0 takes hw_component_lock in
panthor_device_resume_hw_components(), panthor_aw_post_yield_work() can fin=
ish
and set aw->state to PANTHOR_AW_STATE_READY first; CPU0 then resumes hardwa=
re
components while the window is closed, sees PANTHOR_AW_STATE_READY, and tak=
es
default: goto again without suspending them.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index ba5252c27410f..d1ef460577c99 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
[ ... ]
> @@ -577,15 +579,17 @@ int panthor_device_resume(struct device *dev)
>  			atomic_set(&ptdev->reset.pending, 0);
>  		}
> =20
> -		ret =3D panthor_device_resume_hw_components(ptdev);
> +		ret =3D panthor_aw_resume(ptdev);
>  		if (ret && ptdev->reset.fast) {
>  			drm_err(&ptdev->base, "Fast reset failed, trying a slow reset");
>  			ptdev->reset.fast =3D false;
> -			ret =3D panthor_device_resume_hw_components(ptdev);
> +			ret =3D panthor_aw_resume(ptdev);
>  		}

[Severity: Medium]
Does panthor_device_resume() treat -EAGAIN from panthor_aw_resume() as a
fast-reset failure?

When panthor_aw_resume() returns -EAGAIN because aw->state is
PANTHOR_AW_STATE_SUSPEND_PENDING, panthor_device_resume() logs a false fast
reset error, clears ptdev->reset.fast =3D false (forcing a full firmware re=
load
on the next resume), and immediately retries panthor_aw_resume() while the
device is still RPM_RESUMING and panthor_aw_post_yield_work() is still bloc=
ked
in pm_runtime_barrier(dev), so the retry is guaranteed to fail with -EAGAIN
as well.  Conversely, when panthor_device_resume_hw_components() is called
from panthor_aw_ensure_gpu_access() -> panthor_aw_resume() while the device
is already RPM_ACTIVE, there is no fallback to retry with
ptdev->reset.fast =3D false if a fast reset fails.

> =20
>  		if (!ret)
>  			panthor_sched_resume(ptdev);
> +		else
> +			panthor_aw_suspend(ptdev);
> =20
>  		drm_dev_exit(cookie);

[Severity: Medium]
What happens when panthor_device_resume() returns -EAGAIN to callers other
than panthor_device_resume_and_get()?

panthor_device_resume_and_get() catches -EAGAIN, waits with
panthor_aw_wait_transition_complete(), and retries, but
panthor_device_unplug() calls pm_runtime_get_sync() directly (triggering
drm_WARN_ON() and proceeding with unplug while suspended) and
panthor_device_system_resume() calls pm_runtime_force_resume() directly
(failing system resume and leaving the device suspended).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D25
