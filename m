Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A950C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFE010EA23;
	Tue, 22 Sep 2026 21:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4S/gFp6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5585510EA23
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:06:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74E7260142;
 Tue, 22 Sep 2026 21:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0261F000FF;
 Tue, 22 Sep 2026 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111200;
 bh=SawxEJsqReR23SrcUAaQHjmJim4Snx/dILUJozoXvHA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k4S/gFp6qM+315QGNjan4FkGs/faUVX2cpIklW8zMpX/+FhO+BJPwZMFcTQ0QqMvN
 nKl1aknCAC0Gx7vHLX9NW1Xi3/Si3qqzyR1z6DHgssf8zqG7dLWKQ2MQCGNXHHuwiT
 Jhyn20ePaGmt+l0XkoKv6bBVHk4Lw2Dyw0C29kbtBwoIR831pQIVptg9aayccxazJu
 2lKsf8HlBPlzAakSqh3grmBurAtqxMcFfEMIQmqR6zC9Rd5oSGsr8SMhcufSvb5X4w
 ofqfy3viJwpjhgK8heZnjZPNtnHTEr0YCwgnqlTm8M0LhywkIFz+5jgvM/wxvoNs+8
 bDGhgRW/Lj3Bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 24/27] drm/panthor: Route HW component PM through
 access windows
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-25-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-25-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:06:39 +0000
Message-Id: <20260922210640.0D0261F000FF@smtp.kernel.org>
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
- [High] panthor: panthor_device_resume() incorrectly propagates -EAGAIN on=
 AW race
- [High] panthor: post-yield worker accesses hardware with clocks disabled =
during system suspend
- [High] panthor: hardware fails to re-initialize on system resume if suspe=
nded while GPU_STOPPED
- [Medium] panthor: hardware components skip graceful teardown on runtime s=
uspend race
- [Medium] panthor: pm_runtime_put_noidle() in post_yield_work stalls autos=
uspend indefinitely
--

commit 8aa28a6a344b704e733c2685619e190f808b85d0
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Route HW component PM through access windows

This commit makes access-window resume and suspend own GPU access when AW
support is present, while keeping the direct HW component PM path for older
GPUs. It also handles WINDOW_CLOSED and arbiter restart events and defers
post-yield cleanup to a workqueue context.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index 40122bb4b83af..4fcfb3ad05073 100644
> --- a/drivers/gpu/drm/panthor/panthor_aw.c
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c

[ ... ]

> @@ -118,6 +121,52 @@ static int panthor_aw_state_wait_transition(struct p=
anthor_aw *aw, u32 timeout_m
>  		timeout_ms);
>  }
> =20
> +static void panthor_aw_post_yield_work(struct work_struct *work)
> +{
> +	struct panthor_aw *aw =3D
> +		container_of(work, struct panthor_aw, post_yield_work);
> +	struct panthor_device *ptdev =3D aw->ptdev;
> +	struct device *dev =3D ptdev->base.dev;
> +	int ret;
> +
> +	/* Something else has progressed the state to READY. */
> +	if (atomic_read(&aw->state) !=3D PANTHOR_AW_STATE_GPU_STOPPED)
> +		return;
> +
> +	/*
> +	 * Ensure in-progress resume is completed and prevent future RPM suspend
> +	 * to keep the clocks turned on when accessing HW registers.
> +	 */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_barrier(dev);
> +
> +	ret =3D panthor_device_suspend_hw_components(ptdev);

[Severity: Medium]
If a WINDOW_CLOSED event queues panthor_aw_post_yield_work() and races with=
 a
runtime suspend, could this skip the graceful hardware teardown?

Since panthor_aw_suspend() skips panthor_device_suspend_hw_components() when
the state is PANTHOR_AW_STATE_GPU_STOPPED, the clocks would be disabled and
the device becomes RPM_SUSPENDED. When this worker executes,
pm_runtime_get_noresume() does not wake the device. Will
panthor_device_suspend_hw_components() then see pm_runtime_suspended() as
true and skip the teardown entirely, leaving caches and firmware improperly
halted?

[Severity: High]
Could this worker also access hardware registers with clocks disabled durin=
g a
system suspend?

If a system suspend races with this worker, panthor_device_suspend() could =
call
panthor_aw_suspend(), which skips the teardown due to the GPU_STOPPED state.
Clocks are then disabled, but since system PM leaves the runtime status as
RPM_ACTIVE, panthor_device_suspend_hw_components() might proceed to access
hardware registers without clocks, potentially causing a bus fault.

> +	if (ret)
> +		dev_warn(dev, "Failed to suspend hardware components.");
> +
> +	panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
> +
> +	/*
> +	 * schedule an immediate tick to re-evaluate if there is any additional
> +	 * work. This will request access to the GPU again and if the driver has
> +	 * gone idle, it will yield GPU access via the runtime suspend path.
> +	 */
> +	panthor_sched_resume(ptdev);
> +
> +	pm_runtime_put_noidle(dev);

[Severity: Medium]
Does pm_runtime_put_noidle() drop the PM reference without re-arming the
autosuspend timer?

If the autosuspend timer fires while the temporary reference is held in this
function, the suspend aborts due to a non-zero usage count. Using
pm_runtime_put_noidle() drops the usage count but does not queue an idle
notification. Could this leave the device actively powered on indefinitely
until another explicit PM transition occurs?

> +}

[ ... ]

> @@ -396,20 +531,45 @@ int panthor_aw_suspend(struct panthor_device *ptdev)
> =20
>  	/* suspend hw components directly if AW is not supported */
>  	if (!aw)
> -		return 0;
> +		return panthor_device_suspend_hw_components(ptdev);
> =20
>  	if (atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_READY)
>  		goto out_irq_suspend;
> =20
> +	if (atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_GPU_GRANTED) {
> +		ret =3D panthor_device_suspend_hw_components(ptdev);
> +		if (ret)
> +			goto out_irq_suspend;
> +	}
> +
>  	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
> -		PANTHOR_AW_STATE_GPU_STOPPED))
> +		PANTHOR_AW_STATE_STOPPED_IDLE)) {

[Severity: High]
If a system suspend occurs while aw->state is PANTHOR_AW_STATE_GPU_STOPPED,
could this fail to re-initialize the hardware on resume?

Since this skips panthor_device_suspend_hw_components(), the
ptdev->pm.hw_component_state remains PANTHOR_DEVICE_PM_STATE_ACTIVE.
During system resume, panthor_device_resume_hw_components() will check if t=
he
state is ACTIVE and immediately return 0. Does this leave the firmware, MMU,
and GPU uninitialized after losing power in S3?

>  		ret =3D panthor_aw_yield(aw);

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 2ccd8ad6318d1..ea35c5e1d87b4 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c

[ ... ]

> @@ -577,11 +577,11 @@ int panthor_device_resume(struct device *dev)
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

[Severity: High]
Does panthor_device_resume() incorrectly propagate -EAGAIN on an AW race?

If a WINDOW_CLOSED event races with a runtime PM resume, panthor_aw_resume()
observes PANTHOR_AW_STATE_GPU_STOPPED and returns -EAGAIN. Propagating this
directly to the PM core here causes the runtime resume to fail entirely.

[ ... ]

> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 42c5052ac83b9..59bc48d05eb1e 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h

[ ... ]

> @@ -466,8 +467,18 @@ static inline int panthor_device_resume_and_get(stru=
ct panthor_device *ptdev)
>  	 * succeeded. Given resume errors are not expected, this is probably
>  	 * something we can live with.
>  	 */
> -	if (ret && atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) =3D=3D 1)
> -		pm_runtime_set_suspended(ptdev->base.dev);
> +	if (ret) {
> +		if (atomic_cmpxchg(&ptdev->pm.recovery_needed, 1, 0) =3D=3D 1)
> +			pm_runtime_set_suspended(ptdev->base.dev);
> +
> +		return ret;
> +	}
> +
> +	ret =3D panthor_aw_ensure_gpu_access(ptdev);

[Severity: High]
Does this early bailout bypass the intended retry logic?

Because panthor_device_resume() propagates the -EAGAIN failure directly,
the initial pm_runtime_resume_and_get() call fails and populates ret. Retur=
ning
ret here completely bypasses the panthor_aw_ensure_gpu_access() retry loop =
that
was specifically designed to handle the -EAGAIN state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D24
