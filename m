Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61640C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76F810EE7D;
	Tue, 22 Sep 2026 21:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BT2SjDkO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17B510EE7D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:05:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EE0F60142;
 Tue, 22 Sep 2026 21:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5D01F000FF;
 Tue, 22 Sep 2026 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111143;
 bh=lM9FHv2u7RM1t/sDPmlRFrtu9VJ72KbQQjfznSZSKf4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BT2SjDkOW3Kdd24l8hWlXpxawihR0lBOJ8UcLlb68TVVsX44aaArgX/b7KtKSB4DS
 O04QWWRhGIvkqQkuqtLpdO7wRfm5NztFMmHaF7uRxbAwyRPTr/MO0EHVN0S3DWNBjz
 p7R5D5epuoUHV1+3cR2IekUEN8g+hRVt4wuLYWJJ+E9Gi+cEk5mnfInxqnFAtROCgQ
 30WIDF/TB2+oNNQ0CZMSTj9GDEcB2cDQbgry/NSKrHItFQwTCb94sNthq0LQYFq7I9
 yiKE0t0VMM7ZEC+DytLgw9Nzi4P0cv/vihaWuq9GzpWNI7YlJeawx8Oso6lgmSBI1L
 iWtWhoVD7c9LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 22/27] drm/panthor: Add access-window support
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-23-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-23-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:05:42 +0000
Message-Id: <20260922210542.CB5D01F000FF@smtp.kernel.org>
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
- [High] drm/panthor: missing AW IRQ cleanup in panthor_device_init() error=
 path
- [High] drm/panthor: background msg_retry_work runs concurrently with susp=
end
- [Medium] workqueue: 100% CPU busy loop in panthor_aw_msg_retry_work
- [Medium] drm/panthor: 5-second stall during device unplug due to disabled=
 AW IRQs
- [Medium] drm/panthor: dropped AM messages cause 5-second timeout stalls
- [Low] drm/panthor: ignored -EOPNOTSUPP in AW handshake leads to unsupport=
ed protocol usage
--

commit 3a133f64881fd3095e93885e724b739d725e86af
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add access-window support

Add the VM-side access-window component for v15 GPUs. The new code
handles AM message handshakes, requests GPU access from the arbiter,
waits for the window-open interrupt, and yields access on suspend.
Split panthor_hw_init into bind device and initialize gpu_info after
panthor_aw has ensured GPU access.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index 0000000000000..848fd64eb51b5
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
[ ... ]
> @@ -118,17 +118,16 @@ static void panthor_aw_msg_retry_work(struct work_s=
truct *work)
>  	struct panthor_aw *aw =3D
>  		container_of(work, struct panthor_aw, msg_retry_work);
>  	struct panthor_am_msg *msg =3D &aw->msg;
>  	int ret;
> =20
>  	ret =3D panthor_am_msg_retry(msg);
>  	if (ret =3D=3D -EINVAL)
>  		drm_warn(&aw->ptdev->base, "Send FIFO unexpectedly empty");
> =20
>  	if (ret =3D=3D -EBUSY || ret =3D=3D -EAGAIN)
>  		queue_work(aw->wq, &aw->msg_retry_work);

[Severity: Medium]
Will this cause a busy loop pegging a CPU core? If panthor_am_msg_retry()=20
returns -EBUSY (because the hardware AM_OUTGOING_MESSAGE FIFO is not empty)=
,=20
the workqueue immediately re-queues itself without any delay. Should this u=
se
queue_delayed_work() or an interrupt-driven mechanism to back off while
hardware processes the request?

>  }
> =20
>  static void panthor_aw_send_msg(struct panthor_aw *aw, u64 message)
>  {
>  	struct panthor_device *ptdev =3D aw->ptdev;
>  	int ret;
> =20
>  	ret =3D panthor_am_msg_send(&aw->msg, message);
>  	if (ret =3D=3D -ENOSPC)
>  		drm_err(&ptdev->base, "Send FIFO is full");

[Severity: Medium]
Should we handle this error instead of silently swallowing it? If the FIFO =
is
full, the request is never buffered or dispatched, meaning callers will=20
unnecessarily stall for 5 seconds waiting for a state transition response t=
hat
will never arrive.

> =20
>  	if (ret =3D=3D -EBUSY) {
>  		drm_dbg(&ptdev->base, "Pending messages, scheduling retry work");
>  		queue_work(aw->wq, &aw->msg_retry_work);
>  	}
>  }
> =20
>  static void panthor_aw_handshake_handle(struct panthor_aw *aw, u64 messa=
ge)
>  {
>  	struct panthor_device *ptdev =3D aw->ptdev;
>  	bool acked =3D AM_MSG_ACK_GET(message);
>  	u8 version =3D AM_MSG_VERSION_GET(message);
>  	int ret;
> =20
>  	ret =3D panthor_am_msg_version_validate(&aw->msg, version);
>  	if (ret =3D=3D -EOPNOTSUPP)
>  		drm_warn(&ptdev->base,
>  			 "Msg protocol version less than minimum supported (%u < %u)",
>  			 version, AM_MSG_MIN_SUPPORTED_VERSION);

[Severity: Low]
Is it safe to ignore the -EOPNOTSUPP error and continue? Operating with an
unsupported firmware protocol version may cause undefined behavior or firmw=
are
crashes. Should the code explicitly fail the initialization rather than
assuming it is safe to interact with an incompatible Arbiter version?

> =20
>  	if (!acked) {
>  		u64 reply =3D VM_ARB_INIT_MAKE(1, aw->msg.version);
> =20
>  		panthor_aw_send_msg(aw, reply);
[ ... ]
> @@ -303,17 +302,15 @@ int panthor_aw_init(struct panthor_device *ptdev)
> =20
>  	ret =3D panthor_request_aw_irq(ptdev, &aw->irq, irq, WINDOW_IRQ_MASK,
>  				     aw->iomem + WINDOW_INT_BASE);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D panthor_aw_request(aw);
>  	if (ret)
>  		return ret;

[Severity: High]
Does this error path leak the active AW IRQ state? If panthor_aw_request()=
=20
fails, we return without unwinding the active IRQ or pending work queue.=20

In panthor_device_init(), if this function returns an error, we jump direct=
ly
to err_rpm_put, bypassing panthor_aw_unplug():

drivers/gpu/drm/panthor/panthor_device.c:panthor_device_init() {
    ...
	ret =3D panthor_aw_init(ptdev);
	if (ret)
		goto err_rpm_put;
    ...
}

Leaving a shared hardware IRQ unmasked while the device may be partially=20
initialized or powered off could cause kernel panics, such as bus errors on=
=20
MMIO access in the handler.

> =20
>  	return 0;
>  }
> =20
>  void panthor_aw_unplug(struct panthor_device *ptdev)
>  {
>  	struct panthor_aw *aw =3D ptdev->aw;
> =20
>  	if (!aw)
>  		return;
> =20
>  	disable_work_sync(&aw->msg_retry_work);
> =20
>  	panthor_aw_irq_suspend(&aw->irq);

[Severity: Medium]
Will this sequence cause a 5-second stall during device unplug?=20

In panthor_device_unplug(), panthor_aw_unplug() is called before
pm_runtime_put_sync_suspend():

drivers/gpu/drm/panthor/panthor_device.c:panthor_device_unplug() {
    ...
	panthor_aw_unplug(ptdev);

	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
	pm_runtime_put_sync_suspend(ptdev->base.dev);
    ...
}

panthor_aw_unplug() disables and masks the AW IRQ. Then, the PM suspend pat=
h=20
calls panthor_aw_suspend() which uses panthor_aw_state_wait() to wait for a=
n=20
interrupt-driven state transition to READY. Since the IRQ is masked before=
=20
the suspend yield happens, the completion interrupt is never handled,=20
guaranteeing a full 5-second timeout stall.

>  }
> =20
>  int panthor_aw_resume(struct panthor_device *ptdev)
[ ... ]
> @@ -333,16 +332,15 @@ int panthor_aw_suspend(struct panthor_device *ptdev)
> =20
>  	if (atomic_read(&aw->state) =3D=3D PANTHOR_AW_STATE_READY)
>  		goto out_irq_suspend;
> =20
>  	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_GRANTED,
>  		PANTHOR_AW_STATE_GPU_STOPPED))
>  		ret =3D panthor_aw_yield(aw);
>  	else
>  		ret =3D panthor_aw_state_wait(
>  			aw, PANTHOR_AW_STATE_READY,
>  			PANTHOR_AW_STATE_TRANSITION_TIMEOUT_MS);
> =20
>  out_irq_suspend:
>  	panthor_aw_irq_suspend(&aw->irq);
>  	return ret;

[Severity: High]
Does this exit path omit flushing or canceling the background work? If a
message is sent just before or during device suspend, msg_retry_work could =
be
queued.=20

Unlike in panthor_aw_unplug(), panthor_aw_suspend() does not call=20
disable_work_sync(&aw->msg_retry_work) before the device transitions to a=20
suspended state. Since aw->wq is not allocated with WQ_FREEZABLE, the work
can run after the device's clocks and power domains are disabled, and
accessing powered-off MMIO registers would cause a bus error (kernel panic).

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D22
