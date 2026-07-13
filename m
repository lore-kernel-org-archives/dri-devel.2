Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439BDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A909110E5C0;
	Mon, 13 Jul 2026 12:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zkp2yEE9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF63710E5C0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:55:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C25DA43C30;
 Mon, 13 Jul 2026 12:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4E91F000E9;
 Mon, 13 Jul 2026 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783947310;
 bh=6xBAIfGUbxPLmgHkxAU+wWWFPgYDU3FyB6AIPEj+xN4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zkp2yEE9mXfWj3kJbenz6aEZfWiXARsI6bltW83hym3SgfwbsNsbq8xlzEKivfkXq
 pfFcoNtJVmu+TYNZ6VmgfQ7S6RSqW9XnpWwlnsQ5oWEWDoMUHn9TixWZ54qzxvpPDN
 dNFNkqOrvfoooKPpxl2LZb6K4i3pP/3MybbQ9Pf5FZ/QrH5g+Co+ffZfc9yT5M2Tji
 xYYsC1wr8gZ9A0MgBW7rFv+kUEwwiyqYb50Bm5+RnA/iqjEzLFewRsXmtjxga928NV
 /z0Zv9Z+T2ueRpM5G5tIp+FNqU1S2gnBp/ak5tOBy8e+gtyLNNKIEWmFW605gIaoru
 HtTbtyO4auL9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/19] media: meson: vdec: Fix race conditions in job
 abort sequence
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-14-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-14-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:55:09 +0000
Message-Id: <20260713125510.5D4E91F000E9@smtp.kernel.org>
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
- [Critical] Clearing the active session pointer while the hardware is stil=
l running causes unacknowledged interrupts and a CPU-locking interrupt stor=
m.
- [High] Premature clearing of the active session pointer in job_abort bypa=
sses hardware teardown and resource cleanup, causing severe memory and reso=
urce leaks.
- [High] AB-BA lock inversion deadlock between VIDIOC_STREAMOFF and the esp=
arser_queue_work worker thread.
- [High] Releasing session ownership without stopping the hardware allows c=
oncurrent DMA overwrites and hardware state corruption.
- [High] Infinite loop inside esparser_queue_all_src() causing 100% CPU loc=
kup when the queue is empty.
--

--- Patch [13]: [PATCH v7 13/19] media: meson: vdec: Fix race conditions in=
 job abort sequence ---
commit bc32f101c548ab648eb44ae46f9cc2ea72d4c339
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix race conditions in job abort sequence

Implement proper cleanup inside vdec_m2m_job_abort to safely stop
the hardware job sequence during a streaming abort or teardown.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index b3e1d99e8889f..ac86a9c4febff 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -167,6 +167,17 @@ static void vdec_m2m_device_run(void *priv)
>  static void vdec_m2m_job_abort(void *priv)
>  {
>  	struct amvdec_session *sess =3D priv;
> +	struct amvdec_core *core =3D sess->core;
> +
> +	WRITE_ONCE(sess->should_stop, 1);
> +
> +	cancel_work_sync(&sess->esparser_queue_work);

[Severity: High]
Does this introduce an AB-BA deadlock with VIDIOC_STREAMOFF?

The V4L2 core acquires the queue lock (sess->lock) during VIDIOC_STREAMOFF
and calls vdec_m2m_job_abort(), which blocks here indefinitely waiting for
the worker.=20

Meanwhile, the worker thread unconditionally attempts to acquire sess->lock
in esparser_queue_all_src():

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
    ...
    scoped_guard(mutex, &sess->lock) {
    ...
}

> +
> +	mutex_lock(&core->lock);
> +	if (core->cur_sess =3D=3D sess)
> +		/* Safely clear hardware ownership since we were confirmed as the owne=
r */
> +		smp_store_release(&core->cur_sess, NULL);

[Severity: High]
Does clearing cur_sess here prematurely bypass hardware teardown?

During a normal VIDIOC_STREAMOFF, vdec_m2m_job_abort() is called before
the stop_streaming hook. If cur_sess is cleared here, the later teardown
in vdec_stop_streaming() will skip powering off the hardware and freeing
the DMA buffer (vififo_size) because core->cur_sess =3D=3D sess evaluates to
false:

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
    ...
    if (core->cur_sess =3D=3D sess) {
        vdec_poweroff(sess);
        vdec_free_canvas(sess);
    ...
}

[Severity: Critical]
Can this cause an interrupt storm and CPU lockup?

Since the physical hardware isn't stopped, it may complete its active task
and assert a level-triggered interrupt.=20

The ISR checks cur_sess, reads NULL, and immediately returns IRQ_HANDLED
without acknowledging or clearing the hardware register:

drivers/staging/media/meson/vdec/vdec.c:vdec_isr() {
    ...
    if (!sess)
        return IRQ_HANDLED;
    ...
}

Will this cause the unacknowledged interrupt to immediately fire again,
locking up the CPU?

[Severity: High]
Could this allow concurrent DMA overwrites and hardware state corruption?

By clearing core->cur_sess here, the V4L2 framework considers the hardware
idle and can schedule a new session.=20

Since the hardware is actually still running, a newly scheduled session
might blindly overwrite the active hardware's registers in esparser_queue(),
corrupting the ongoing DMA operations:

drivers/staging/media/meson/vdec/esparser.c:esparser_queue() {
    ...
    amvdec_write_parser(core, PARSER_VIDEO_START_PTR, payload_paddr);
    ...
}

> +	mutex_unlock(&core->lock);
> =20
>  	v4l2_m2m_job_finish(sess->core->m2m_dev, sess->m2m_ctx);
>  }

[Severity: High]
Does the esparser_queue_all_src() worker have an infinite loop?

When looking into the interaction with esparser_queue_work, the outer
loop in esparser_queue_all_src() appears to never terminate when the
queue is empty:

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
    while (1) {
        struct vb2_v4l2_buffer *vbuf =3D NULL;
        bool processed_frame =3D false;
        ...
        scoped_guard(mutex, &sess->lock) {
            ...
            vbuf =3D v4l2_m2m_next_src_buf(sess->m2m_ctx);
            if (!vbuf)
                break;
            ...
        }
        ...
    }
}

Since scoped_guard is implemented as a hidden for-loop, the break
statement only exits the scoped_guard's internal loop, not the outer
while(1) loop.=20

Because processed_frame remains false, the code calls cond_resched() and
spins indefinitely. Could this cause a 100% CPU lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D13
