Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED6AC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E7D10E5B8;
	Mon, 13 Jul 2026 12:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fZE+7puU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3336410E5B8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:54:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3A8D411BD;
 Mon, 13 Jul 2026 12:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1031F00A3D;
 Mon, 13 Jul 2026 12:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947283;
 bh=qzX7WoC3qvXqkDe9glXp9hxIbPF/2xEOQoFZ6eRB9qs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fZE+7puUdRkn6rpP0JIKN9WXG1RbYZ0sW4PDWjzDFhdhJ3KQzBCw4bSUVk/z+pdU9
 hVsC6TfBJwiR/RZ0Hqw17gEwTG4zaidOh9QsZfFeRVe2kFafhlqn5ib8KqwQccqHq/
 5V5ZP41yFKzYa2ojGxp3s9HFIzq6h6AOZz3Z4BgnrcqV7814vPl6vO7p+38Sl0EDYK
 KUggPuGJMi5ppmwmbvFTIqFpE1QH6iO7V9yg0SO3duZODwtz/5ygqKl+AFUfBWJL2D
 55kTz59aKrEbQgdq08DeT8ayJ5nXJpJ2nRzEbZOY+zdfjJkdcDBCNM20w+z3zciHqj
 6dLpoZqNgM+eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/19] media: meson: vdec: Coordinate m2m task
 execution inside async loop
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-13-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-13-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:54:43 +0000
Message-Id: <20260713125443.7F1031F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] An AB-BA deadlock occurs between the V4L2 `VIDIOC_STREAMOFF` i=
octl and the workqueue worker `esparser_queue_all_src` over `sess->lock`.
- [Critical] A recursive mutex self-deadlock occurs because `core->lock` is=
 manually acquired inside functions already protected by the V4L2 core.
- [High] The `esparser_queue_all_src` workqueue thread enters a 100% CPU in=
finite busy-loop on empty queues, end-of-stream buffers, or hardware FIFO f=
ull conditions.
- [High] The V4L2 M2M framework permanently stalls due to a leaked job cont=
ext when `esparser_queue_all_src` exits early or hits loop break conditions=
 without calling `v4l2_m2m_job_finish()`.
- [High] Closing any secondary file descriptor unconditionally clears `core=
->cur_sess`, stripping hardware ownership from the active session and causi=
ng permanent DMA memory leaks.

Pre-existing issues:
- [Critical] An unconditional out-of-bounds heap write occurs when padding =
artificially small, user-controlled buffers in `esparser_pad_start_code()`.
- [Critical] An integer overflow during VP9 sub-frame length parsing allows=
 attackers to bypass size boundaries and trigger an out-of-bounds `memmove`=
 copy.
--

--- Patch [12]: [PATCH v7 12/19] media: meson: vdec: Coordinate m2m task ex=
ecution inside async loop ---
commit 8f8ffb4492573d6d82ee209ecb382a9f5fbed9e4
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Coordinate m2m task execution inside async loop

This commit introduces proper V4L2 Memory-to-Memory (m2m) scheduler pipelin=
e=20
tracking by handling job finalisation inside the asynchronous esparser=20
workqueue. It defers the scheduling call to v4l2_m2m_job_finish() to execut=
e=20
within the worker routine.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> index b9f36fef4be12..939b239c2af47 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
[ ... ]
> @@ -437,6 +438,9 @@ void esparser_queue_all_src(struct work_struct *work)
>  			else
>  				v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> =20
> +			/* Safely notify the V4L2 core sub-framework */
> +			v4l2_m2m_job_finish(core->m2m_dev, sess->m2m_ctx);
> +
>  			/* Set tracking flag indicating transaction completion */
>  			processed_frame =3D true;
>  		}

[Severity: High]
Does this worker thread run into an infinite busy-loop on empty queues or=20
end-of-stream buffers?

In esparser_queue_all_src(), the code uses a scoped_guard for the lock:

	while (1) {
		...
		scoped_guard(mutex, &sess->lock) {
			if (!vbuf)
				break;
		}
	}

Since scoped_guard expands into a hidden for-loop, the break statement only=
=20
exits the scoped_guard's loop, not the outer while (1) loop. This could tra=
p=20
execution indefinitely, consuming 100% CPU when the queue is empty, hits an=
=20
EOS buffer, or the hardware FIFO is full.

[Severity: High]
Could the V4L2 M2M job context permanently leak if the session shuts down?

Looking at esparser_queue_all_src():

	scoped_guard(mutex, &sess->lock) {
		/* Safe atomic tracking check: exit loop if session is shutting down */
		if (READ_ONCE(sess->should_stop))
			return;

Returning early directly bypasses the newly added v4l2_m2m_job_finish() cal=
l.
This could permanently hang the V4L2 memory-to-memory framework because it=
=20
considers the device busy forever, preventing further decoding jobs.

[Severity: Critical]
Is there a risk of an AB-BA deadlock between the V4L2 VIDIOC_STREAMOFF ioct=
l=20
and the workqueue worker?

The V4L2 core framework acquires sess->lock during VIDIOC_STREAMOFF and the=
n=20
calls vdec_stop_streaming(), which waits for the active worker thread:

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
	...
	cancel_work_sync(&sess->esparser_queue_work);
}

Concurrently, the worker thread esparser_queue_all_src spins up and blocks=
=20
attempting to acquire the identical sess->lock:

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
	...
	scoped_guard(mutex, &sess->lock) {
}

This sequence would entirely deadlock the system when stopping the video st=
ream.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index 0eb39aa6014ee..b3e1d99e8889f 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -149,6 +149,17 @@ vdec_queue_recycle(struct amvdec_session *sess, stru=
ct vb2_buffer *vb)
>  static void vdec_m2m_device_run(void *priv)
>  {
>  	struct amvdec_session *sess =3D priv;
> +	struct amvdec_core *core =3D sess->core;
> +
> +	if (READ_ONCE(sess->should_stop)) {
> +		v4l2_m2m_job_finish(core->m2m_dev, sess->m2m_ctx);
> +		return;
> +	}
> +
> +	mutex_lock(&core->lock);
> +	if (!core->cur_sess)
> +		core->cur_sess =3D sess;
> +	mutex_unlock(&core->lock);
> =20
>  	schedule_work(&sess->esparser_queue_work);
>  }

[Severity: Critical]
Will acquiring core->lock manually here and in vdec_start_streaming result=
=20
in a recursive mutex self-deadlock?

Because vdev->queue is intentionally left NULL for M2M devices, the V4L2 co=
re=20
ioctl wrapper unconditionally acquires vdev->lock (which is mapped to=20
&core->lock) before delegating execution to the ioctl implementations.

The underlying driver callback vdec_start_streaming then attempts to manual=
ly=20
acquire it again:

drivers/staging/media/meson/vdec/vdec.c:vdec_start_streaming() {
	...
	mutex_lock(&core->lock);
	if (core->cur_sess && core->cur_sess !=3D sess) {
}

This would immediately self-deadlock the kernel thread processing=20
VIDIOC_STREAMON or VIDIOC_STREAMOFF.

[Severity: High]
Does closing a secondary file descriptor unintentionally strip hardware=20
ownership from the active session?

In vdec_close(), the state modification is placed outside the active sessio=
n=20
check block:

drivers/staging/media/meson/vdec/vdec.c:vdec_close() {
	...
	/* Safely clear hardware ownership since we were confirmed as the owner */
	smp_store_release(&core->cur_sess, NULL);
}

If a user-space process opens the video node twice, streams on the first=20
session, and then closes the second session, this clears core->cur_sess=20
unconditionally. This destroys the ownership state of the active session,=20
bypassing its cleanup sequence and permanently leaking DMA buffers and canv=
ases.

[Severity: Critical]
This is a pre-existing issue, but can esparser_pad_start_code() cause an=20
out-of-bounds heap write when handling artificially small buffers?

If userspace negotiates a small sizeimage and queues a tiny buffer, the pad=
ding=20
function computes pad_size based on ESPARSER_MIN_PACKET_SIZE and executes=20
a memset before verifying the vb2_plane_size:

drivers/staging/media/meson/vdec/esparser.c:esparser_pad_start_code() {
	...
		pad_size =3D ESPARSER_MIN_PACKET_SIZE - payload_size;
		memset(vaddr + payload_size, 0, pad_size);
	}

	if ((payload_size + pad_size + SEARCH_PATTERN_LEN) >
						vb2_plane_size(vb, 0)) {
}

This could allow a local user to overwrite memory with zeroes by passing a=
=20
payload_size of 0, resulting in a 4096-byte memset.

[Severity: Critical]
This is a pre-existing issue, but might an integer overflow in=20
vp9_update_header() allow attackers to trigger an out-of-bounds memmove?

The parser reconstructs frame lengths by bit-shifting byte payloads:

drivers/staging/media/meson/vdec/esparser.c:vp9_update_header() {
	...
				frame_size[cur_frame] |=3D
					(dp[mag_ptr] << (cur_mag * 8));
}

If dp[mag_ptr] is >=3D 128 and cur_mag is 3, the unsigned 8-bit value promo=
tes=20
to an int and shifts into the sign bit, resulting in a large negative integ=
er.

Later, this negative frame_size is passed to memmove():

drivers/staging/media/meson/vdec/esparser.c:vp9_update_header() {
	...
		memmove(fdata + VP9_HEADER_SIZE, old_framedata, framesize);
}

The negative framesize implicitly converts to a massive size_t, which could=
=20
corrupt arbitrary kernel memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D12
