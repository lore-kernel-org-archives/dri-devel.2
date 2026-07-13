Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00403C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53AE710E157;
	Mon, 13 Jul 2026 12:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g7fmdrZX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0429810E157
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:48:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49AF06004E;
 Mon, 13 Jul 2026 12:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC0B1F000E9;
 Mon, 13 Jul 2026 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946881;
 bh=yS6cqai81MZRPE6OCCwIza4Fd5I5d/G28zqBICqaExg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g7fmdrZXSX39Xn6SHGhZu3WcUNJzVgaKNqrtRDoiI0/Ya6xK0hOhzoDmskGKIYiaL
 t51FLIY10kAdgbISoDYuK9AagkgxtA9KovHfsTfjqRHKnbCuu5cs0pOzTXuL0sNeXt
 KOheIpy3b8wXZmrz6bEfWmiaIB9TAnH+AoAWs7mQ1bkP+F4diDsHglV2cWCq3J5/yw
 b8iO30ku1MP/WM2dAB5k/tq2FycbAejohGfTH8QuiI50e002tcS7VlWAxnHgd/nzpi
 Vd5mYkwmGwkTS4crLRlGI6Mo8dNAwRgx8HJdsTFZTTU1bqxIoPzYrnO1GsXfHAGUNa
 4BeWVvNQpNKLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/19] media: meson: vdec: Update core m2m stream
 state during transitions
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-12-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-12-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:48:00 +0000
Message-Id: <20260713124800.BDC0B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `vdec_start_streaming` flushes BOTH M2M source a=
nd destination buffer queues, causing buffers of an already-streaming queue=
 to be silently stranded.
- [High] The teardown sequence in `vdec_stop_streaming` calls `synchronize_=
irq()` before stopping the hardware, leaving a race window for a Use-After-=
Free in the interrupt handler.
- [High] Active DMA buffers are returned to the videobuf2 framework before =
the hardware is stopped, potentially causing memory corruption or IOMMU fau=
lts.
--

--- Patch [11]: [PATCH v7 11/19] media: meson: vdec: Update core m2m stream=
 state during transitions ---
commit 8309f1636cfcc48cc67621545812af232aebc2dd
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Update core m2m stream state during transitions

Explicitly update the V4L2 core Memory-to-Memory (m2m) framework's
internal streaming states when initiating or terminating streaming on
the device queues.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -299,6 +299,8 @@ static int vdec_start_streaming(struct vb2_queue *q, =
unsigned int count)
>  	else
>  		sess->streamon_cap =3D 1;
> =20
> +	v4l2_m2m_update_start_streaming_state(sess->m2m_ctx, q);
> +
>  	if (!sess->streamon_out)
>  		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
vdec_start_streaming() mistakenly strand buffers if one queue fails to star=
t?

If the CAPTURE queue starts successfully, but the OUTPUT queue fails to sta=
rt
due to the hardware being busy, the error path flushes both queues:

drivers/staging/media/meson/vdec/vdec.c:vdec_start_streaming() {
    ...
err_unlock_no_hw:
	while ((buf =3D v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
	while ((buf =3D v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
    ...
}

Because the CAPTURE queue is actively streaming, wouldn't returning these
buffers with VB2_BUF_STATE_QUEUED cause the vb2 core to leave them in the
queued list without putting them on the done list, permanently freezing
the userspace application?

[ ... ]

> @@ -529,6 +531,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  			sess->changed_format =3D 0;
>  	}
> =20
> +	v4l2_m2m_update_stop_streaming_state(sess->m2m_ctx, q);
> +
>  	mutex_unlock(&core->lock);
>  }

[Severity: High]
This is a pre-existing issue, but does vdec_stop_streaming() return active
DMA buffers to the videobuf2 framework before the hardware is stopped?

When flushing buffers, it immediately returns them to the V4L2 core:

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
    ...
	/* flush buffers to kill background workqueue thread */
	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
		while ((buf =3D v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
		sess->streamon_out =3D 0;
	} else {
    ...
}

If the vb2 framework unmaps these buffers while the hardware is still runni=
ng
and writing to physical memory, can this cause DMA memory corruption or IOM=
MU
faults before vdec_poweroff() is finally called later in the function?


[Severity: High]
This is a pre-existing issue, but does the teardown sequence in
vdec_stop_streaming() leave a race window for a use-after-free?

The synchronization happens before the hardware is halted:

drivers/staging/media/meson/vdec/vdec.c:vdec_stop_streaming() {
    ...
		/* Synchronize and flush pending hardware interrupt service routines */
		synchronize_irq(core->vdec_irq);
		/* Ensure esparser ISR finishes executing */
		synchronize_irq(core->esparser_irq);

		cancel_work_sync(&sess->esparser_queue_work);
		mutex_lock(&core->lock);

		if (core->cur_sess =3D=3D sess) {
			vdec_poweroff(sess);
            ...
			kfree(sess->priv);
    ...
}

If a new hardware interrupt fires immediately after the synchronization
completes, and vdec_stop_streaming() proceeds to free sess->priv,
could the concurrent ISR access the freed session data?

drivers/staging/media/meson/vdec/vdec.c:vdec_isr() {
    ...
	/* Secure an atomic acquire snapshot to protect against concurrent teardow=
n */
	sess =3D smp_load_acquire(&core->cur_sess);
	if (!sess)
		return IRQ_HANDLED;

	sess->last_irq_jiffies =3D get_jiffies_64();

	return sess->fmt_out->codec_ops->isr(sess);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D11
