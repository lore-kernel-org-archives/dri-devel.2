Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05204C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DC710EE79;
	Tue, 22 Sep 2026 21:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FpKc75Pz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFE6410EE79
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:00:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BEA442B45;
 Tue, 22 Sep 2026 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394441F00893;
 Tue, 22 Sep 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110822;
 bh=sFoIp37twcuEhp6x+vfJpAnzoOlHMAqj5Sod2/SOvWw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FpKc75Pzr+r/uswOSDdRXqHtHymhZFJsdJiC1oMlMJExj5yIom1lL8Gs/VERzf9mG
 HBdv3IhjkOzI6iqXIuY6IpYkn6XeM6rpBF6PjIVdtkli9vLetOmcoizwbEFxxfQ+63
 RYKJj+jagHTH0cR7pV9qoHStD7bS00SluxFhQmTL0vfKy5uXP3yGOEFouj3+LXWt4G
 +ncx+JNuoMOycvpBjRYsgUzP0byRJPWK+C2hQd/7O9j1cLoCiwnruAfNsfoUc1C+YK
 y8jPE62sT6dLWYaNRj3tGbRlBd08ajECCmpecrb9+N6UQhclV/uTM4EQwZEBkc5Xzn
 D0AxfU9TxMyaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/27] drm/panthor: Add arbitration scheduler
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-17-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-17-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:00:21 +0000
Message-Id: <20260922210022.394441F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] workqueue: infinite loop in reset_work on hardware unresponsiveness
- [High] timers: use-after-free due to timer re-arming by reset_work during=
 teardown
- [High] timers: use-after-free due to missing IRQ teardown in remove error=
 path
- [Medium] pm: incomplete error rollback in panthor_arbitration_sched_suspe=
nd()
- [Medium] probe: missing NULL check for devm_kasprintf() return
- [Medium] time: truncation of 64-bit module parameters in msecs_to_jiffies=
()
--

commit 48cf2a79eb3e38b7bf9c8fdb322edaecd8d1e020
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add arbitration scheduler

Add a per-partition arbitration scheduler that queues access-window GPU
requests, grants the active window, asks it to stop when its lease
expires, and force-closes it if it does not yield in time.

Track grant, stop and close deadlines with hrtimers so scheduler
progress remains bounded. Use scheduler reset work to recover from
unrecoverable arbitration errors and stale timeout state.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.=
c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> index a1068a2c78f1a..2d0c8d95f1abd 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
> @@ -56,6 +57,13 @@ static int panthor_arbitration_runtime_suspend(struct =
device *dev)
>  	struct panthor_arbitration *adev =3D dev_get_drvdata(dev);
>  	int ret =3D 0;
> =20
> +	if (adev->tearing_down)
> +		return 0;
> +
> +	ret =3D panthor_arbitration_sched_suspend(adev);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
Does returning early here leave the state partially broken?

In panthor_arbitration_sched_suspend(), if panthor_arbitration_sched_stop()
fails for scheduler N, the loop returns an error. Schedulers 0 to N-1 keep
the ARB_SCHED_DISABLE_PM flag. Propagating the error to the PM core here
means it considers the device active and won't call the resume path, which
permanently disables the successful schedulers from scheduling new access
windows.

>  	ret =3D panthor_resource_group_suspend(adev);
>  	if (ret)
>  		return ret;

[ ... ]

> @@ -151,15 +185,20 @@ static void panthor_arbitration_remove(struct platf=
orm_device *pdev)
>  		dev_warn(adev->dev, "failed to resume during remove: %d", ret);
> =20
>  	of_platform_depopulate(adev->dev);
> -	panthor_resource_group_cancel_work(adev);
> =20
>  	if (ret >=3D 0) {
> +		adev->tearing_down =3D true;
> +
> +		panthor_arbitration_sched_term(adev);
> +		panthor_resource_group_cancel_work(adev);
>  		panthor_resource_group_term(adev);
>  		panthor_partition_control_term(adev);
> -		pm_runtime_put_noidle(adev->dev);
> +		pm_runtime_put_sync_suspend(adev->dev);
> +	} else {
> +		panthor_arbitration_sched_cancel(adev);
> +		panthor_resource_group_cancel_work(adev);
> +		pm_runtime_set_suspended(adev->dev);
>  	}

[Severity: High]
Does this error path leave hardware interrupts registered and active?

If pm_runtime_resume_and_get() fails, the error path is taken, but it misses
calling panthor_partition_control_term() or panthor_resource_group_term().

A late shared interrupt could trigger the handler and invoke
panthor_arbitration_sched_on_idle(). Because the scheduler's phase is not
reset in panthor_arbitration_sched_cancel(), it can proceed to
arb_sched_close_locked() which re-arms the timer on a soon-to-be-freed
object, leading to a use-after-free.

> -
> -	pm_runtime_set_suspended(adev->dev);
>  }
> =20
>  static const struct dev_pm_ops panthor_arbitration_pm_ops =3D {
> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sche=
d.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> new file mode 100644
> index 0000000000000..41f06af92ce0c
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c

[ ... ]

> +/* This method is not IRQ safe as it sleeps. */
> +static int arb_sched_wait_phase(struct panthor_arbitration_sched *sched,
> +				enum arbitration_sched_phase phase,
> +				u64 timeout_ms)
> +{
> +	if (!wait_event_timeout(
> +		    sched->waitqueue, arb_sched_phase_reached(sched, phase),
> +		    msecs_to_jiffies(timeout_ms))) {

[Severity: Medium]
Will this truncate the 64-bit timeout values?

The module parameters request_timeout and yield_timeout are defined as u64.
In arb_sched_wait_phase(), their sum is passed to msecs_to_jiffies(), which
takes an unsigned int. If userspace sets excessively large timeouts, the
value could truncate silently, resulting in an unexpectedly short or zero
timeout.

> +
> +		if (!arb_sched_phase_reached(sched, phase))
> +			return -ETIMEDOUT;
> +	}

[ ... ]

> +static int __arb_sched_close_locked(struct panthor_arbitration_sched *sc=
hed)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&sched->lock);
> +
> +	ret =3D panthor_arbitration_on_close(to_adev(sched), sched->active_aw_i=
d);
> +	if (ret < 0) {
> +		dev_err(sched->dev, "%s: Failed to close AW%u", sched->name,
> +			sched->active_aw_id);
> +
> +		arb_sched_queue_work(sched, &sched->reset_work);
> +	}

[Severity: High]
Can this cause an infinite loop in the workqueue?

If the hardware becomes unresponsive and panthor_arbitration_on_close()
persistently returns an error, __arb_sched_close_locked() queues reset_work=
.=20

The reset_work executes arb_sched_force_close_locked(), which recursively
attempts __arb_sched_close_locked(). This fails again and re-queues
reset_work ad infinitum.

> +
> +	return ret;
> +}
> +
> +static void arb_sched_close_locked(struct panthor_arbitration_sched *sch=
ed)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&sched->lock);
> +
> +	ret =3D __arb_sched_close_locked(sched);
> +	if (!ret) {
> +		sched->close_timer.epoch =3D sched->epoch;
> +		hrtimer_start(&sched->close_timer.timer,
> +			      ms_to_ktime(yield_timeout), HRTIMER_MODE_REL);
> +	} else if (ret > 0) {

[Severity: High]
Is it safe to unconditionally re-arm the timer here?

During panthor_arbitration_sched_stop(), all timers are cancelled and
flush_workqueue() is called. If a reset_work is pending, it executes and
calls arb_sched_close_locked(), which re-arms the close_timer unconditional=
ly.

Without checking if a teardown is in progress (such as checking for
ARB_SCHED_DISABLE_TERM), this can lead to a use-after-free when the re-armed
hrtimer expires and its callback executes on a freed object.

[ ... ]

> +static int arbitration_sched_init(struct panthor_arbitration *adev, int =
i)
> +{
> +	struct device *dev =3D adev->dev;
> +	struct panthor_arbitration_sched *sched;
> +
> +	sched =3D devm_kzalloc(dev, sizeof(*sched), GFP_KERNEL);
> +	if (!sched)
> +		return -ENOMEM;
> +
> +	sched->name =3D devm_kasprintf(dev, GFP_KERNEL, "sched%d", i);
> +	sched->dev =3D dev;
> +
> +	sched->wq =3D devm_alloc_ordered_workqueue(dev, "%s-wq", 0, sched->name=
);

[Severity: Medium]
Could devm_kasprintf() return NULL here?

If memory allocation fails, sched->name will be NULL. It is immediately
passed to devm_alloc_ordered_workqueue() which will dereference it for
string formatting, leading to a kernel crash.

> +	if (!sched->wq)
> +		return -ENOMEM;

[ ... ]

> +int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev)
> +{
> +	for (int i =3D 0; i < AM_ARB_MAX_PC_COUNT; i++) {
> +		struct panthor_arbitration_sched *sched =3D adev->sched[i];
> +		int ret;
> +
> +		if (!sched)
> +			continue;
> +
> +		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
> +		ret =3D panthor_arbitration_sched_stop(sched);
> +		if (ret) {
> +			panthor_arbitration_sched_disable_clear(
> +				sched, ARB_SCHED_DISABLE_PM);
> +			return ret;
> +		}

[Severity: Medium]
Does this properly roll back the state of previously processed schedulers?

If panthor_arbitration_sched_stop() fails for scheduler N, the loop returns
an error. Schedulers 0 to N-1 will remain permanently disabled because
ARB_SCHED_DISABLE_PM is not cleared for them.

> +	}
> +
> +	return 0;
> +}

[ ... ]

> +int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sch=
ed)
> +{
> +	int ret;
> +
> +	arb_sched_request_stop(sched);
> +
> +	/*
> +	 * Provisionally waiting for up to 2x yield_timeout, but path may
> +	 * include time taken for panthor_arbitration_on_grant() to complete
> +	 * if sched_request_stop() is called while in the GRANTING state.
> +	 *
> +	 * Realistically, if granting takes more than yield_timeout, HW is in
> +	 * bad state either way. Best continue and stop the scheduler.
> +	 */
> +	ret =3D arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
> +				   request_timeout + yield_timeout);
> +	if (ret)
> +		arb_sched_force_close(sched);
> +
> +	/* Should no longer have any further activity. Cancel timer. */
> +	hrtimer_cancel(&sched->grant_timer.timer);
> +	hrtimer_cancel(&sched->stop_timer.timer);
> +	hrtimer_cancel(&sched->close_timer.timer);
> +	flush_workqueue(sched->wq);

[Severity: High]
Will this hang indefinitely if reset_work is trapped in a re-queuing loop?

As noted earlier, if the hardware becomes unresponsive,
__arb_sched_close_locked() queues reset_work which recursively fails and
re-queues itself. This unthrottled infinite loop will block
flush_workqueue() indefinitely during system suspend or driver removal.

> +
> +	scoped_guard(spinlock_irqsave, &sched->lock)
> +		if (sched->phase =3D=3D ARB_SCHED_PHASE_IDLE)
> +			return 0;
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D16
