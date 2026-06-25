Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EEBCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFA910E4B6;
	Thu, 25 Jun 2026 07:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kU7kRgmu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4311E10E4B6
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:58:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A76EF60217;
 Thu, 25 Jun 2026 07:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D35C1F000E9;
 Thu, 25 Jun 2026 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782374331;
 bh=4ZrYmmth+coZY9ZvsDMOqVl5Od8nrxZAGi7twiYD4ss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kU7kRgmugZhedqz7dUUT0WHbkZaixMuSJxJfurrJnMmQzgmlrHhjzDDORezb9wEmb
 5cA1mQJlG2dN4mq99Aiey0BCfAd6wL/fHUuwinf7qCxVE9jS2hIyYCOpNJ4Rb4n6nA
 m50qCmaKj0jp/s+bCN9BUtD1aZuXnBTSGl410JFEL+6JC/7TTqgksHx8YTjhQr46Hx
 BuW+B7vlAvaLj/WZLoEv/O0bnozTneoWTsMDLpJA/cJvuhsI2BQAZ1eKEDCL+UONxJ
 A9gzCC63ygXed3xKIo39M89DGgM/Xnm+GkO+io6O01wdrP0dziRB7h6CT/XmqQtxLg
 gJNBrs9zJS6Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/14] drm/panthor: Don't update
 might_have_idle_groups in process_idle_event_locked()
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-panthor-signal-from-irq-v4-9-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
 <20260625-panthor-signal-from-irq-v4-9-3d2908912afa@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 07:58:50 +0000
Message-Id: <20260625075851.2D35C1F000E9@smtp.kernel.org>
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
- [Medium] Removal of might_have_idle_groups assignment allows timer overwr=
ite and causes scheduling latency
--

commit 20736cbfef7751426397d8de52c511bb5bfb6181
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Don't update might_have_idle_groups in process_idle_event_lock=
ed()

By scheduling an immediate tick, we already force idleness re-evaluation,
which gives the scheduler the opportunity to evict idle groups
and schedule onces that have jobs pending.

> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/pa=
nthor/panthor_sched.c
> index 1caa803c28508..99381b71dd589 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1734,8 +1734,6 @@ static void csg_slot_process_idle_event_locked(stru=
ct panthor_device *ptdev, u32
> =20
>  	lockdep_assert_held(&sched->lock);
> =20
> -	sched->might_have_idle_groups =3D true;
> -
[Severity: Medium]
Does removing this flag assignment allow an immediate tick to be overwritte=
n?

When a group becomes idle, this function queues a 0-delay tick. If a new job
is submitted to an inactive group before the workqueue runs the tick,
group_schedule_locked() is called.

Without the might_have_idle_groups flag set, group_schedule_locked() will
bypass its early return:

drivers/gpu/drm/panthor/panthor_sched.c:group_schedule_locked() {
	...
	if (sched->might_have_idle_groups) {
		sched_queue_delayed_work(sched, tick, 0);
		return;
	}
	...
	sched_resume_tick(ptdev);
}

This calls sched_resume_tick(), which computes a new delay based on
sched->resched_target and calls sched_queue_delayed_work(). Since this uses
mod_delayed_work(), it can overwrite the previously queued 0-delay tick wit=
h a
delay of up to 10ms.

Could this delay the eviction of the idle group and introduce a scheduling
latency spike?

>  	/* Schedule a tick so we can evict idle groups and schedule non-idle
>  	 * ones. This will also update runtime PM and devfreq busy/idle states,
>  	 * so the device can lower its frequency or get suspended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-panthor-si=
gnal-from-irq-v4-0-3d2908912afa@collabora.com?part=3D9
