Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C921606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cxnpx6oN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36B910F7F9;
	Tue, 10 Nov 2026 16:05:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067FC10F7FB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4602263A60;
 Tue, 10 Nov 2026 16:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D252D1F0089F;
 Tue, 10 Nov 2026 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326706;
 bh=8wd+h6aB5ur+J77j9+LZ/vU2Fb6MNlG4R6ywzaayETg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Cxnpx6oN+JJhUj0JqvbNgpTOQXVTmIcE956D02pToPraqgUfehulM4ZrGUuROxJA9
 MOX9n+83F/4TBvD0256z2Z0I1lsq5y+dkrDgRRaKR0/iXN06lGtRaj7je8+s8gh0tl
 bs4FAc/wcVwIuhf4YmVyUmRwZRZWfvMSKJMeLH1uY9KHAcHA+D53cocFH2pb/5k8ly
 XVzFO7tXaIwQ+R4aZ7kf3TaWmkwZX2eCtvID7BsarF0OaqTHnXiq2cd9Q7eMCPvBZk
 Yd6JIRQOwDo5BNT+ubVnw4OaMgPVLFfAh7wKoozkdk/pyrLZ4XeBHER/odyPqVgOLd
 iQLXc00WKxsrg==
Message-ID: <sashiko-outbox-207339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/28] drm/panthor: Add arbitration scheduler
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-18-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-18-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:05:05 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/panthor: infinite reset loop in arb_sched_reset_work() on
  close failure
- [High] drm/panthor: dropped GPU request in
  panthor_arbitration_sched_on_request()
- [Medium] drm/panthor: unbounded retry loop in arb_sched_retry_work()
  on -EAGAIN
- [Medium] drm/panthor: timer re-armed by flush_workqueue() during
  scheduler stop
--

commit 3de6cc524258ad93c9b3ccfc5bc67b23efebd6b2
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add arbitration scheduler

This commit adds a per-partition arbitration scheduler that queues GPU
requests from access windows, grants access in turn, and uses hrtimers and
workqueues to manage timeslices, yields, force-closes, and error recovery.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sche=
d.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
> new file mode 100644
> index 0000000000000..23768739e9ef5
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
[ ... ]
> +static int __arb_sched_close_locked(struct panthor_arbitration_sched *sc=
hed)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&sched->lock);
> +
> +	ret =3D panthor_arbitration_on_close(to_adev(sched), sched->id);
> +	if (ret =3D=3D -EAGAIN) {
> +		arb_sched_queue_retry_work(sched, PANTHOR_ARB_WORK_CLOSE);
> +	} else if (ret < 0) {
> +		dev_err(sched->dev, "%s: Failed to close AW%u. %d", sched->name,
> +			sched->active_aw_id, ret);
> +
> +		arb_sched_queue_work(sched, &sched->reset_work);
> +	}
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
> +	}
> +}
[ ... ]
> +static void arb_sched_reset_work(struct work_struct *work)
> +{
> +	struct panthor_arbitration_work *w =3D to_work(work);
> +	struct panthor_arbitration_sched *sched =3D
> +		container_of(w, struct panthor_arbitration_sched, reset_work);
> +
> +	guard(spinlock_irqsave)(&sched->lock);
> +	if (sched->epoch !=3D w->epoch)
> +		return;
> +
> +	if (sched->active_aw_id !=3D w->aw_id)
> +		return;
> +
> +	dev_warn(sched->dev, "%s: scheduler reset. active_aw=3D%u",
> +			sched->name, sched->active_aw_id);
> +
> +	arb_sched_force_close_locked(sched);
> +}

[Severity: High]
Can arb_sched_reset_work() enter an infinite reset loop when closing an
access window fails or times out?

__arb_sched_close_locked() and panthor_arbitration_sched_on_close_timeout()
queue sched->reset_work to recover from close errors and close timeouts.
However, arb_sched_reset_work() does not retire the lease or advance
sched->epoch (note that arb_sched_on_stopped_locked() has an unused forward
declaration at the top of the file); it only calls
arb_sched_force_close_locked() -> arb_sched_close_locked().

If panthor_arbitration_on_close() returns a negative error other than
-EAGAIN, __arb_sched_close_locked() immediately re-queues sched->reset_work
in a tight loop on sched->wq, hanging flush_workqueue() during suspend or
teardown.  If panthor_arbitration_on_close() returns 0 when close_timer has
already timed out, arb_sched_close_locked() simply re-arms close_timer,
which expires and queues sched->reset_work again, wedging the scheduler in
ARB_SCHED_PHASE_LOST and starving all queued access windows.

> +static void arb_sched_retry_work(struct work_struct *work)
> +{
> +	struct panthor_arbitration_work *w =3D to_work(work);
> +	struct panthor_arbitration_sched *sched =3D
> +		container_of(w, struct panthor_arbitration_sched, retry_work);
> +	DECLARE_BITMAP(work_tmp, PANTHOR_ARB_WORK_COUNT);
> +
> +	guard(spinlock_irqsave)(&sched->lock);
> +	if (bitmap_empty(sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT))
> +		return;
> +
> +	bitmap_copy(work_tmp, sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT=
);
> +	bitmap_zero(sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT);
> +
> +	if (sched->epoch !=3D w->epoch || sched->active_aw_id !=3D w->aw_id)
> +		return;
> +
> +	switch (sched->phase) {
> +	case ARB_SCHED_PHASE_STOPPING:
> +		if (test_bit(PANTHOR_ARB_WORK_STOP, work_tmp))
> +			arb_sched_stop_locked(sched);
> +		break;
> +	case ARB_SCHED_PHASE_CLOSING:
> +	case ARB_SCHED_PHASE_LOST:
> +		if (test_bit(PANTHOR_ARB_WORK_CLOSE, work_tmp))
> +			arb_sched_close_locked(sched);
> +		break;
> +	default:
> +		break;
> +	}
> +}

[Severity: Medium]
Can arb_sched_retry_work() spin indefinitely on sched->wq if
panthor_arbitration_on_stop() or panthor_arbitration_on_close() continues to
return -EAGAIN?

When __arb_sched_stop_locked() or __arb_sched_close_locked() gets -EAGAIN,
stop_timer and close_timer are not started, and sched->retry_work is queued
immediately with no delay or retry limit.  If the partition remains in a
state that returns -EAGAIN, arb_sched_retry_work() clears pending_retry_work
and re-queues itself in an unthrottled busy loop with no running timer to
force recovery, which also prevents flush_workqueue(sched->wq) from
completing in panthor_arbitration_sched_stop().

[ ... ]
> +int panthor_arbitration_sched_on_request(struct panthor_arbitration_sche=
d *sched, u8 aw_id)
> +{
> +	guard(spinlock_irqsave)(&sched->lock);
> +
> +	if (aw_id >=3D AM_ARB_MAX_AW_COUNT)
> +		return -EINVAL;
> +
> +	if (test_bit(aw_id, sched->queued_mask) ||
> +	    (sched->active_aw_id =3D=3D aw_id &&
> +	     sched->phase !=3D ARB_SCHED_PHASE_STOPPING)) {
> +		dev_warn(sched->dev, "%s: AW%u already in request queue.",
> +			 sched->name, aw_id);
> +		return -EEXIST;
> +	}

[Severity: High]
Does panthor_arbitration_sched_on_request() drop valid GPU requests that
arrive while the active access window is closing?

When the active access window yields via panthor_arbitration_sched_on_idle()
(or is force-closed), sched->phase moves to ARB_SCHED_PHASE_CLOSING (or
ARB_SCHED_PHASE_LOST) while sched->active_aw_id remains set until the
partition reset completes and calls panthor_arbitration_sched_on_stopped().
Because the duplicate check only exempts ARB_SCHED_PHASE_STOPPING, a new
request from that access window during ARB_SCHED_PHASE_CLOSING or
ARB_SCHED_PHASE_LOST is rejected with -EEXIST and never queued, leaving the
access window unscheduled once panthor_arbitration_sched_on_stopped() clears
active_aw_id.

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
> +				   panthor_arbitration_stop_timeout(sched));
> +	if (ret) {
> +		/*
> +		 * TODO: handle the timeout here by escalating the error when
> +		 * reset escalation is supported.
> +		 */
> +		ret =3D arb_sched_force_close(sched);
> +	}
> +
> +	/* Should no longer have any further activity. Cancel timer. */
> +	hrtimer_cancel(&sched->grant_timer.timer);
> +	hrtimer_cancel(&sched->stop_timer.timer);
> +	hrtimer_cancel(&sched->close_timer.timer);
> +	flush_workqueue(sched->wq);

[Severity: Medium]
Can flush_workqueue(sched->wq) re-arm stop_timer or close_timer after the
timers have already been cancelled?

hrtimer_cancel() runs before flush_workqueue(sched->wq).  If
sched->reset_work or sched->retry_work is pending (for example, queued by
panthor_arbitration_sched_on_close_timeout() during arb_sched_force_close()=
),
flushing sched->wq runs arb_sched_reset_work() or arb_sched_retry_work(),
which calls arb_sched_close_locked() or arb_sched_stop_locked() and starts
close_timer or stop_timer again, leaving an active hrtimer after
panthor_arbitration_sched_stop() returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D17
