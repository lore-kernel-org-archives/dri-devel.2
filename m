Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DEDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD2810E5BB;
	Mon, 13 Jul 2026 12:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rwp1xDM+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA3110E5BB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:42:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAA3F434ED;
 Mon, 13 Jul 2026 12:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE331F000E9;
 Mon, 13 Jul 2026 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946555;
 bh=Wx7oiArxQ0vNgschEOJbP2Q3vCsNxXvegFU4jYy34Qw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rwp1xDM+Jn0t2iN17uXVq8mR90HeGNKEk2Y3peG4mh+VZortZemdftLjsKbsgzWzX
 Dt/kSHzcplbpejgZKk4D6FuhXdoJef4hssbH2hO4PN5xgE3y2/PRjvGC4yx5+zCcL3
 5x2cKjbV7w9XYapezyFhg4znysTyMDl9IqpQxzrEu865IAKLVf7BdYCJErBTyAKkVd
 NzLpmt28Y/BLmQSrCI/+blTqn2E9CvnirUpOs0BdOJBvG+h8m0wHlhoHvFSjcZ+pPw
 mjy42B6K4RKjQrxop0pNI+6+kfsY/B0Uj4sVm2lGrO+X90Jre2leRgkJ1IUwjP/BUf
 JQA9IInmK8acw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/19] media: meson: vdec: Fix concurrent execution
 races and unsafe teardown
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-9-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-9-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:42:34 +0000
Message-Id: <20260713124235.7BE331F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unconditional nullification of `core->cur_sess` in `vdec_close=
()` allows concurrent sessions to clobber hardware ownership, triggering in=
terrupt storms and severe memory leaks.
- [High] AB-BA deadlock between `vdec_stop_streaming()` and `esparser_queue=
_all_src()` workqueue due to `cancel_work_sync()`.
- [High] Inverted loop logic in `esparser_queue_all_src()` causes infinite =
CPU busy-wait on hardware backpressure and premature exit on success.
- [Medium] Memory leak of `sess->priv` on the newly added `vdec_start_strea=
ming()` error path.
--

--- Patch [8]: [PATCH v7 08/19] media: meson: vdec: Fix concurrent executio=
n races and unsafe teardown ---
commit 4587e6bbd091d6645be624dc185c0fadded8649b
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix concurrent execution races and unsafe teardown

Address data races involving 'should_stop' and prevent multi-session
hardware clobbering by enforcing atomic tracking and strict owner
validation during device teardown.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> index e5d3d817b9b2b..959673742e699 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -379,7 +379,7 @@ void esparser_queue_all_src(struct work_struct *work)
> =20
>  		scoped_guard(mutex, &sess->lock) {
>  			/* Safe atomic tracking check: exit loop if session is shutting down =
*/
> -			if (sess->should_stop)
> +			if (READ_ONCE(sess->should_stop))
>  				return;

[Severity: High]
Could the workqueue get stuck in an infinite loop due to how scoped_guard
expands?

Because scoped_guard(mutex, &sess->lock) expands to a for loop, if the
inner code hits an empty queue or -EAGAIN and calls break, it will only
exit the scoped_guard loop, leaving processed_frame as false.

The code then evaluates if (processed_frame) break; which fails, executes
cond_resched(), and loops the outer while (1) infinitely.

Conversely, if a frame is successfully processed (processed_frame is true),
does the loop break entirely, causing the workqueue to exit after processing
just a single frame?

[ ... ]

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index 6fe9722577179..83a9b1238972a 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c

[ ... ]

> @@ -388,10 +392,12 @@ static int vdec_start_streaming(struct vb2_queue *q=
, unsigned int count)
>  		sess->streamon_cap =3D 0;
> =20
>  	mutex_lock(&core->lock);
> -	if (core->cur_sess =3D=3D sess)
> -		core->cur_sess =3D NULL;
> -	if (sess->status !=3D STATUS_NEEDS_RESUME)
> -		sess->status =3D STATUS_STOPPED;
> +	if (core->cur_sess =3D=3D sess) {
> +		/* Safely clear hardware ownership since we were confirmed as the owne=
r */
> +		smp_store_release(&core->cur_sess, NULL);
> +		if (sess->status !=3D STATUS_NEEDS_RESUME)
> +			sess->status =3D STATUS_STOPPED;
> +	}
>  	mutex_unlock(&core->lock);
>  err_unlock_no_hw:

[Severity: Medium]
Is there a memory leak of sess->priv on the error paths in
vdec_start_streaming()?

If vdec_poweron() succeeds (which dynamically allocates sess->priv), but
a later step like kthread_run() fails, the code jumps to err_poweroff.
While the hardware state and vififo_vaddr are rolled back, kfree(sess->priv)
appears to be missing.

If VIDIOC_STREAMON repeatedly fails, could this leak kernel memory?

[ ... ]

> @@ -493,26 +502,33 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  		cancel_work_sync(&sess->esparser_queue_work);

[Severity: High]
Can this cause an AB-BA deadlock between the V4L2 core and the workqueue?

When userspace calls VIDIOC_STREAMOFF, the V4L2 core acquires the queue lock
(sess->lock), then calls vdec_stop_streaming(), which calls
cancel_work_sync() here.

Meanwhile, the esparser_queue_all_src() workqueue loop uses
scoped_guard(mutex, &sess->lock) to acquire the exact same lock. If the
workqueue is active, it will block waiting for sess->lock, while
vdec_stop_streaming() blocks indefinitely waiting for the workqueue to exit.

>  		mutex_lock(&core->lock);
> =20
> -		vdec_poweroff(sess);
> -		vdec_free_canvas(sess);

[ ... ]

> @@ -1012,21 +1031,30 @@ static int vdec_close(struct file *file)

[ ... ]

>  	kfree(sess->priv);
>  	sess->priv =3D NULL;
> =20
> +	/* Unconditionally set our local status to stopped */
> +	sess->status =3D STATUS_STOPPED;
> +	/* Safely clear hardware ownership since we were confirmed as the owner=
 */
> +	smp_store_release(&core->cur_sess, NULL);
> +

[Severity: Critical]
Does this unconditionally clear the hardware ownership, even if this session
doesn't own it?

If session A is streaming and session B is closed, vdec_close() for session
B will execute smp_store_release(&core->cur_sess, NULL) outside of the
if (core->cur_sess =3D=3D sess) check.

If core->cur_sess becomes NULL while session A's hardware is active, could
the next hardware interrupt trigger vdec_isr() which sees !core->cur_sess
and returns IRQ_HANDLED without clearing the hardware interrupt status?

Since the interrupt is level-triggered, could this result in an immediate
interrupt storm that hangs the CPU, and permanently leak session A's
vififo_vaddr DMA buffers when session A is eventually closed?

>  	mutex_unlock(&core->lock);
> =20
>  	v4l2_m2m_ctx_release(sess->m2m_ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D8
