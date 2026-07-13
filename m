Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A906BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3B210E5C3;
	Mon, 13 Jul 2026 12:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H5Haj0WH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E53B10E5C3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:32:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C64456004E;
 Mon, 13 Jul 2026 12:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4172B1F000E9;
 Mon, 13 Jul 2026 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783945948;
 bh=dW75QfnLqOtsZkfIoVxbjcFvye9KNi4ujoDy3+7dhfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5Haj0WHOANsHBtzte03AjnHlVpGzZauYPzFyo4Txa1trxHhG4Vnnr/1yR1pzlHe1
 szGZCsyLK6JzQGGIFbPIXtrPsG+tVdYyOzflgcKfw9YWLJou8Spymk2+Mq7R939ao6
 AKW2BhBQVXC+QgpQV1zxOdTvayJt+yXzxS+9JPf1hvPj0X6Bnx7ickzembX9CXLSsM
 Qk6/mns+M8g71AkkKYt5GOe1qWyKeoBxYI6eTnRRMAEDxtSSfLOeYpzI1yuBW8cBIf
 VDTZ6UKq2XdpYSQWM/E5lM7Ct5M7IrnFXOmGiekETrjE5z2+RTPEdQDJKQunghga9r
 QkndrZXF1ClTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/19] media: meson: vdec: Fix lifecycle leaks and
 race conditions in recycle_thread
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-4-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-4-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:32:27 +0000
Message-Id: <20260713123228.4172B1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] vdec_close() frees session memory before releasing the V4L2 M2=
M context, triggering a NULL pointer dereference during queue teardown.
- [Critical] Unconditional execution of vdec_poweroff() and clearing of cor=
e->cur_sess in vdec_close() causes Data Abort panics and cross-session corr=
uption.
- [Critical] Unconditional execution of vdec_poweroff() in vdec_close() lea=
ds to a double free of codec DMA allocations.
- [High] vdec_close() prematurely frees session context and DMA buffers wit=
hout canceling background workqueues, causing Use-After-Free and DMA corrup=
tion.

Pre-existing issues:
- [High] Flawed logic in vdec_stop_streaming() orphans the recycle thread, =
leading to Use-After-Free during partial STREAMOFF.
- [Medium] The err_poweroff unwinding path in vdec_start_streaming() leaks =
sess->priv and associated codec assets.
--

--- Patch [3]: [PATCH v7 03/19] media: meson: vdec: Fix lifecycle leaks and=
 race conditions in recycle_thread ---
commit 41dac138c8515aa623b248b4a110d8a7802b604b
Author: Anand Moon <linux.amoon@gmail.com>
Subject: media: meson: vdec: Fix lifecycle leaks and race conditions in rec=
ycle_thread

This patch validates the kthread_run return status during recycling thread
initialization to prevent memory leaks. It also ensures the thread is safely
stopped in both vdec_stop_streaming and vdec_close to prevent kernel panics
during teardown.

Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel=
.org/

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/medi=
a/meson/vdec/vdec.c
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
[ ... ]
@@ -353,13 +357,23 @@ static int vdec_start_streaming(struct vb2_queue *q, =
unsigned int count)
>  	schedule_work(&sess->esparser_queue_work);
>  	return 0;
> =20
>  err_poweroff:
>  	vdec_poweroff(sess);
>  	vdec_free_canvas(sess);
>  	vdec_reset_timestamps(sess);
>  	vdec_reset_bufs_recycle(sess);

[Severity: Medium]
This is a pre-existing issue, but does the err_poweroff unwinding path leak
sess->priv?

If kthread_run() fails, execution jumps to the err_poweroff label which
unwinds various hardware states but misses calling kfree(sess->priv).
When the application retries VIDIOC_STREAMON, the codec's start routine
unconditionally allocates a new structure over sess->priv, permanently
stranding the previous allocation.

>  err_free_vififo:
>  	if (sess->vififo_vaddr) {
>  		dma_free_coherent(sess->core->dev, sess->vififo_size,
[ ... ]
@@ -464,7 +478,10 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  	if (full_cleanup) {
>  		if ((q->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
>  		     !sess->streamon_out) && vdec_codec_needs_recycle(sess)) {

[Severity: High]
This is a pre-existing issue, but does this logic orphan the recycle thread
leading to a use-after-free during partial STREAMOFF?

If userspace invokes VIDIOC_STREAMOFF exclusively on the capture queue
while the output queue remains active, this condition evaluates to false,
bypassing the kthread_stop() call.

Because old_status =3D=3D STATUS_RUNNING, full_cleanup evaluates to true,
proceeding to dismantle the session context and free sess->priv.
The orphaned recycle thread may concurrently awaken and attempt to access
this freed memory.

> -			kthread_stop(sess->recycle_thread);
> +			if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
> +				kthread_stop(sess->recycle_thread);
> +				sess->recycle_thread =3D NULL;
> +			}
>  		}
[ ... ]
@@ -970,6 +987,31 @@ static int vdec_open(struct file *file)
>  static int vdec_close(struct file *file)
>  {
>  	struct amvdec_session *sess =3D file_to_amvdec_session(file);
> +	struct amvdec_core *core =3D sess->core;
> +
> +	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
> +		kthread_stop(sess->recycle_thread);
> +		sess->recycle_thread =3D NULL;
> +	}
> +
> +	mutex_lock(&core->lock);
> +
> +	vdec_poweroff(sess);
> +	vdec_free_canvas(sess);
> +	core->cur_sess =3D NULL;

[Severity: Critical]
Can this unconditional invocation of vdec_poweroff() and clearing of
core->cur_sess cause Data Abort panics and cross-session corruption?

If userspace opens two instances (FDs), starts streaming on instance A
(acquiring hardware ownership), and then closes instance B:

vdec_close() for instance B will unconditionally call vdec_poweroff(sess)
and clear core->cur_sess, without verifying if instance B actually owns the
hardware.

This forces clock disablements while instance A is actively decoding. When
the hardware for instance A fires an interrupt, vdec_isr() will dereference
core->cur_sess, which was just wrongfully set to NULL, causing a panic.

[Severity: Critical]
Will this unconditional vdec_poweroff() call also lead to a double free of
codec DMA allocations?

If userspace cleanly shuts down streaming via VIDIOC_STREAMOFF,
vdec_stop_streaming() executes vdec_poweroff(). This invokes the codec
stop callback (like codec_h264_stop) which frees memory buffers but does
not set their pointers to NULL.

When userspace subsequently calls close(), vdec_close() calls
vdec_poweroff() again. The codec stop routine will execute a second time,
passing the same non-NULL pointers to dma_free_coherent() resulting in a
catastrophic double-free.

> +
> +	if (sess->vififo_vaddr) {
> +		dma_free_coherent(core->dev, sess->vififo_size,
> +				  sess->vififo_vaddr, sess->vififo_paddr);
> +		sess->vififo_vaddr =3D NULL;
> +		sess->vififo_paddr =3D 0;
> +	}
> +	vdec_reset_timestamps(sess);
> +	vdec_reset_bufs_recycle(sess);
> +	kfree(sess->priv);

[Severity: High]
Should we call cancel_work_sync(&sess->esparser_queue_work) before freeing
the session context and DMA buffers here?

If vdec_close() is called while the background workqueue is actively
processing frames, the DMA buffer (sess->vififo_vaddr) and session
structure (sess->priv) are immediately freed.

The concurrently executing workqueue continues its operation inside
esparser_queue(), dereferencing the freed sess->priv pointer and
instructing the hardware to perform DMA transfers into the freshly freed
physical address, potentially causing severe memory corruption.

> +	sess->priv =3D NULL;
> +
> +	mutex_unlock(&core->lock);
> =20
>  	v4l2_m2m_ctx_release(sess->m2m_ctx);

[Severity: Critical]
Does this sequence trigger a NULL pointer dereference during queue teardown?

If a user closes the file descriptor without calling VIDIOC_STREAMOFF,
vdec_close() will free sess->priv and set it to NULL.

Immediately after, it calls v4l2_m2m_ctx_release(), which triggers
vdec_stop_streaming(). Since sess->status is still STATUS_RUNNING, the
driver will execute codec_ops->drain(sess).

The codec's drain function unconditionally dereferences sess->priv, which
was just set to NULL, causing an immediate panic.

>  	v4l2_fh_del(&sess->fh, file);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D3
