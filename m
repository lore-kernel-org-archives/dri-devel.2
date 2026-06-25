Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA79CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08ED610F21A;
	Thu, 25 Jun 2026 10:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X+/yVpI3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C7710F21A
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:06:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 349CF60018;
 Thu, 25 Jun 2026 10:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BB1F000E9;
 Thu, 25 Jun 2026 10:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381982;
 bh=wDx7VnNb9TwiEzh1I0hofjBMo3BIoABVbcEaea2lsZo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X+/yVpI3829kVWKGyFavLHkST91/L7o0+1wOGby8XwBlhKCpgBHiI6UT+jiTw/bOX
 Fv+5eXNHWlxOfXDzBDO9VWXxp4Senj58X6cFHWTXZVPOyF7A3AqB4OTzB2KHef/Irx
 jZlhjJepy/ZyLorx5kS69sYSJ7xJoRwibk0ryesK3+3W29rdweXjf05vY+RbLfeWP1
 L9BD67nXc7rvGVpq549p+dx5WlGiDL4sXimS7Wfczzl+4DPWLYlZxXduKcJdOZjHGy
 pToSgog5AfHnQdccZHdkED3Qvf7gL//i/sEn4rcPPJikGi/ZXKnX3vR/7OiEBeUbrA
 0jOgwTdDQFAVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/16] drm/panthor: Don't update
 might_have_idle_groups in process_idle_event_locked()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v5-11-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
 <20260625-panthor-signal-from-irq-v5-11-8836a74e0ef9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:06:22 +0000
Message-Id: <20260625100622.AC8BB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The panthor scheduler acquires `queue->fence_ctx.lock` using `spin=
_lock()` instead of `spin_lock_irqsave()`, violating the `dma_fence` lockin=
g rules and risking a deadlock against hardware interrupts.
--

commit 3ecce8ed069220d684864af5f10bd10ad0ae008b
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't update might_have_idle_groups in process_idle_event_lock=
ed()

By scheduling an immediate tick, we already force idleness re-evaluation,
which gives the scheduler the opportunity to evict idle groups
and schedule onces that have jobs pending.

> and schedule onces that have jobs pending.

[Severity: Low]
This isn't a bug, but there appears to be a typo (onces instead of ones)
in the commit message.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 237f6a75e624c..a5dfb1beafff8 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1734,8 +1734,6 @@ static void csg_slot_process_idle_event_locked(stru=
ct panthor_device *ptdev, u32
> =20
>  	lockdep_assert_held(&sched->lock);
> =20
> -	sched->might_have_idle_groups =3D true;
> -

[Severity: High]
This is a pre-existing issue, but looking at panthor_sched.c,
queue->fence_ctx.lock is acquired using plain spin_lock() in multiple
functions:

queue_suspend_timeout()
queue_resume_timeout()
cs_slot_process_fault_event_locked()
queue_check_job_completion()
group_term_post_processing()
queue_run_job()

For example, in queue_check_job_completion():

    spin_lock(&queue->fence_ctx.lock);
    ...

This lock is used as the dma_fence lock for the job's done_fence. Since
dma_fence objects can be shared with other subsystems (like KMS display
drivers), they may be accessed from hardirq context (such as a VBLANK
interrupt calling dma_fence_is_signaled() or dma_fence_add_callback(),
which attempt to acquire the fence lock).

If a hardware interrupt occurs on the same CPU while the panthor driver
holds this lock with interrupts enabled, could the interrupt handler spin
forever attempting to acquire the lock, causing a deadlock?

Should these acquisitions be updated to use spin_lock_irqsave() to comply
with dma_fence locking rules?

>  	/* Schedule a tick so we can evict idle groups and schedule non-idle
>  	 * ones. This will also update runtime PM and devfreq busy/idle states,
>  	 * so the device can lower its frequency or get suspended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=3D11
