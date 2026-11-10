Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DFB606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJmztAOS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052D710E063;
	Tue, 10 Nov 2026 16:20:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA02B10E063
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:20:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F53940AF3;
 Tue, 10 Nov 2026 16:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A531F0089F;
 Tue, 10 Nov 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327641;
 bh=QcguJj1+l/XVuCR/LuPfp0/Y0DAkP2/rIQwy7GtLwlE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=NJmztAOSW5GPtGFvl75T+v+6wLJ2iKjGNRKtBXKFVpqaEuk++mpZUXMyVKrymR+tZ
 JS0e9mKAzYtVX50SRf9AhaQf0YwyMubUbiBWbOAqf2qqkTIo488BgtM6r0atINuia3
 ICIcCGei58HEyrm25taTWbihEyXI7Y0764G2SCl5UmU8Y6RqpmW+EcgxDlq7SN6ff6
 a+ajKHeJghgFt5MzHE3VvZnmx6NyicDKD/uyqIKURGROTG8+XDkuU8mUTYuzdiZAqd
 mBcbRJEI+VE2b7lmvhCV7gc1G9eYqnESuc+CI2Azx8cKIU3CoSmWCoojRC7LTfskK3
 VdRo9O8XZSlfQ==
Message-ID: <sashiko-outbox-207356@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/28] drm/panthor: Add access-window support
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-23-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-23-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:20:40 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/panthor: uncanceled msg_retry_work in panthor_aw_suspend()
  and resume
- [Medium] drm/panthor: zero-delay workqueue busy loop in
  panthor_aw_msg_retry_work()
- [Medium] drm/panthor: unhandled INIT and GPU_REQUEST states in
  __panthor_aw_suspend()
- [Medium] drm/panthor: unhandled YIELDING timeout and INIT wait in
  panthor_aw
- [Low] drm/panthor: unchecked version in panthor_aw_handshake_handle()
  resend path
--

commit 2a64ca6e72bd954e55857187b10a1459415f36df
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add access-window support

This commit adds the VM-side access-window component for Mali v15 GPUs to
negotiate the AM message protocol, request and yield GPU access from the
arbiter, and defer reading hardware information until GPU access is
granted.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> new file mode 100644
> index 0000000000000..5ab1d44f0a22e
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
> @@ -0,0 +1,498 @@

[ ... ]

> +static void panthor_aw_msg_retry_work(struct work_struct *work)
> +{
> +	struct panthor_aw *aw =3D
> +		container_of(work, struct panthor_aw, msg_retry_work);
> +	struct panthor_am_msg *msg =3D &aw->msg;
> +	int ret;
> +
> +	ret =3D panthor_am_msg_retry(msg);
> +	if (ret =3D=3D -EINVAL)
> +		drm_warn(&aw->ptdev->base, "Send FIFO unexpectedly empty");
> +
> +	if (ret =3D=3D -EBUSY || ret =3D=3D -EAGAIN)
> +		queue_work(aw->wq, &aw->msg_retry_work);
> +}

[Severity: Medium]
Does panthor_aw_msg_retry_work() spin in a zero-delay workqueue loop when
panthor_am_msg_retry() returns -EBUSY?

When a second message is sent before the arbiter consumes the first from
AM_OUTGOING_MESSAGE, panthor_am_msg_send() queues it in msg->send_fifo and
schedules aw->msg_retry_work.  As long as AM_OUTGOING_MESSAGE_STATUS stays
non-zero, panthor_am_msg_retry() returns -EBUSY and the worker immediately
re-queues itself onto aw->wq without any backoff or bound, pegging a
kworker at 100% CPU polling MMIO registers (unlike rg_retry_messages() in
panthor_resource_group.c, which uses delayed_work).

> +
> +static void panthor_aw_send_msg(struct panthor_aw *aw, u64 message)
> +{
> +	struct panthor_device *ptdev =3D aw->ptdev;
> +	int ret;
> +
> +	ret =3D panthor_am_msg_send(&aw->msg, message);
> +	if (ret =3D=3D -ENOSPC)
> +		drm_err(&ptdev->base, "Send FIFO is full");
> +
> +	if (ret =3D=3D -EBUSY) {
> +		drm_dbg(&ptdev->base, "Pending messages, scheduling retry work");
> +		queue_work(aw->wq, &aw->msg_retry_work);
> +	}
> +}
> +
> +static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 messa=
ge)
> +{
> +	struct panthor_device *ptdev =3D aw->ptdev;
> +	bool acked =3D AM_MSG_ACK_GET(message);
> +	u8 version =3D AM_MSG_VERSION_GET(message);
> +	u8 reply_version =3D AM_MSG_CURRENT_VERSION;
> +	int ret;
> +
> +	ret =3D panthor_am_msg_version_validate(&aw->msg, version, acked,
> +					      &reply_version);
> +	if (ret =3D=3D -EOPNOTSUPP)
> +		drm_warn(&ptdev->base,
> +			 "Msg protocol version less than minimum supported (%u < %u)",
> +			 version, AM_MSG_MIN_SUPPORTED_VERSION);
> +
> +	if (!acked) {
> +		u64 reply =3D VM_ARB_INIT_MAKE(1, reply_version);
> +
> +		panthor_aw_send_msg(aw, reply);
> +
> +		guard(spinlock_irqsave)(&aw->lock);
> +
> +		/*
> +		 * If state is GPU_REQUEST, arbiter previously completed
> +		 * handshake, New INIT could mean that the arbiter was restarted
> +		 * and we need to resend GPU_REQUEST.
> +		 */
> +		if (atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_GPU_REQUEST) {
> +			panthor_aw_send_msg(aw, VM_ARB_GPU_REQUEST);
> +			return;
> +		}
> +	}

[Severity: Low]
Can this resend VM_ARB_GPU_REQUEST to an incompatible arbiter if the
arbiter restarts with an unsupported protocol version while aw->state is
PANTHOR_AW_STATE_GPU_REQUEST?

Even when panthor_am_msg_version_validate() returns -EOPNOTSUPP, the
!acked branch still sends VM_ARB_GPU_REQUEST and returns early, leaving
panthor_aw_request() waiting for the 5-second timeout instead of
transitioning to PANTHOR_AW_STATE_READY so it can fail immediately with
-EOPNOTSUPP.  Also, panthor_am_msg_version_validate() returns -EOPNOTSUPP
when acked is true and version > AM_MSG_CURRENT_VERSION, so the warning
above can log that version is less than AM_MSG_MIN_SUPPORTED_VERSION when
it is actually greater than AM_MSG_CURRENT_VERSION.

[ ... ]

> +	ret =3D panthor_aw_wait_cond(aw, atomic_read(&aw->state) !=3D state, ti=
meout_ms);
> +	if (ret) {
> +		scoped_guard(spinlock_irqsave, &aw->lock) {
> +			switch (atomic_read(&aw->state)) {
> +			case PANTHOR_AW_STATE_GPU_GRANTED:
> +				return 0;
> +			case PANTHOR_AW_STATE_GPU_REQUEST:
> +				panthor_aw_state_set(aw, PANTHOR_AW_STATE_READY);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		return ret;
> +	}
> +
> +	goto again;
> +}

[Severity: Medium]
Can aw->state become permanently wedged in PANTHOR_AW_STATE_YIELDING if
waiting for the window to close times out?

If __panthor_aw_suspend() times out waiting for PANTHOR_AW_STATE_READY (or
if WINDOW_IRQ_WINDOW_OPENED arrives just after panthor_aw_request() times
out in panthor_aw_resume() and transitions READY -> YIELDING), the caller
suspends the AW IRQ while aw->state is PANTHOR_AW_STATE_YIELDING.  If the
hardware window finishes closing while the IRQ is masked, no
WINDOW_IRQ_WINDOW_CLOSED interrupt fires on the next resume, and because
neither __panthor_aw_suspend() nor panthor_aw_request() checks
!panthor_aw_is_open(aw) or resets PANTHOR_AW_STATE_YIELDING to
PANTHOR_AW_STATE_READY on timeout, every subsequent panthor_aw_request()
call times out waiting on PANTHOR_AW_STATE_YIELDING.

> +
> +static int __panthor_aw_suspend(struct panthor_aw *aw)
> +{
> +	scoped_guard(spinlock_irqsave, &aw->lock) {
> +		switch (atomic_read(&aw->state)) {
> +		case PANTHOR_AW_STATE_READY:
> +			return 0;
> +		case PANTHOR_AW_STATE_SUSPEND_PENDING:
> +			return 0;
> +		case PANTHOR_AW_STATE_GPU_GRANTED:
> +			panthor_aw_state_set(aw, PANTHOR_AW_STATE_YIELDING);
> +			panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return panthor_aw_state_wait(aw, PANTHOR_AW_STATE_READY,
> +				     PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
> +}

[Severity: Medium]
What happens in __panthor_aw_suspend() when aw->state is
PANTHOR_AW_STATE_INIT or PANTHOR_AW_STATE_GPU_REQUEST?

If the initial handshake in panthor_aw_init() -> panthor_aw_request()
times out, aw->state is still PANTHOR_AW_STATE_INIT when
panthor_aw_unplug() calls __panthor_aw_suspend(), which hits default and
blocks for another 5 seconds waiting for PANTHOR_AW_STATE_READY.  If
__panthor_aw_suspend() is called while in PANTHOR_AW_STATE_GPU_REQUEST, it
leaves the state as PANTHOR_AW_STATE_GPU_REQUEST while waiting for
PANTHOR_AW_STATE_READY, so a concurrent WINDOW_IRQ_WINDOW_OPENED will
transition it to PANTHOR_AW_STATE_GPU_GRANTED instead of yielding and
cause suspend to time out with the window left open.

[ ... ]

> +int panthor_aw_resume(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +	int ret;
> +
> +	if (!aw)
> +		return 0;
> +
> +	panthor_aw_irq_resume(&aw->irq);
> +
> +	ret =3D panthor_aw_request(aw);
> +	if (ret) {
> +		drm_warn(&ptdev->base, "Timedout waiting for GPU to be granted");
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	panthor_aw_irq_suspend(&aw->irq);
> +	return ret;
> +}
> +
> +int panthor_aw_suspend(struct panthor_device *ptdev)
> +{
> +	struct panthor_aw *aw =3D ptdev->aw;
> +	int ret =3D 0;
> +
> +	/* suspend hw components directly if AW is not supported */
> +	if (!aw)
> +		return 0;
> +
> +	ret =3D __panthor_aw_suspend(aw);
> +
> +	panthor_aw_irq_suspend(&aw->irq);
> +
> +	return ret;
> +}

[Severity: High]
Can aw->msg_retry_work run after panthor_aw_suspend() or the error path of
panthor_aw_resume() returns and the caller disables the GPU clocks?

CPU0                                  kworker
panthor_device_suspend()
  ...
  panthor_aw_suspend()
    __panthor_aw_suspend()
      panthor_aw_send_msg()
        queue_work(..., &msg_retry_work)
    panthor_aw_irq_suspend()
  clk_disable_unprepare(ptdev->clks.core)
                                      panthor_aw_msg_retry_work()
                                        panthor_am_msg_retry()
                                          gpu_read(msg->iomem, ...)
                                            <-- unclocked MMIO access

Unlike panthor_aw_unplug(), neither panthor_aw_suspend() nor the err_out
path of panthor_aw_resume() cancels aw->msg_retry_work, and
panthor_aw_msg_retry_work() does not hold a runtime PM reference, so it
can read and write msg->iomem after the clocks are turned off and trigger
a synchronous external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D22
