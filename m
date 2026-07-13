Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F3EC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D1C10E967;
	Mon, 13 Jul 2026 12:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D++mAoLY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA2E10E5D0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:33:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 431376004E;
 Mon, 13 Jul 2026 12:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77CA1F000E9;
 Mon, 13 Jul 2026 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946010;
 bh=So1ngTMBKLWI40f71cpPAfkDGrA9phrdJHyTDXmsHAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D++mAoLYVRURLK8IbG+ipZJfm6mOQriEvpH9JAGwBiHIsBPaCLaGe794VVhnYzWNH
 +qVyOZtEWldYwCrZak6CfWOvWt9nKVyKlJtUnpXAUDuR4VUrmbDSgt6iOqHpq2n8+3
 Q66uXf6oW81pdRYafm3wsm5pMbdlIUMwQvXgEhL5vvsndl/OC93QsCBZDiu4tOsWjy
 sJtPJe9Qz9bI1ge+BX6pobBQ+WiKjyu2X14MIWX8x/RBPP3cJ6mEp+WNEZ1I5FYd4o
 JKvPfX+4SrczkcC+cipaub0D/DloLr38xX6WlFHtqgHTTxO8hAJjlosbxoAIRIX7bY
 n/71AkdoEdPMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/19] media: meson: vdec: Fix race condition by
 canceling work sync
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-7-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-7-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:33:29 +0000
Message-Id: <20260713123329.B77CA1F000E9@smtp.kernel.org>
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
- [High] Calling `cancel_work_sync(&sess->esparser_queue_work)` inside `vde=
c_stop_streaming()` introduces a guaranteed AB-BA deadlock during `VIDIOC_S=
TREAMOFF`.
- [High] `cancel_work_sync()` and `synchronize_irq()` are invoked before th=
e hardware is powered off, leaving a race window where late interrupts can =
schedule work on a soon-to-be-freed session.
- [High] `vdec_close()` unconditionally powers off shared hardware state an=
d clears the active session, allowing a rogue client to crash an ongoing de=
coding session.
- [Medium] The patch fails to remove the scheduling of `esparser_queue_work=
` during destination buffer completion, contradicting its own commit messag=
e.
--

--- Patch [6]: [PATCH v7 06/19] media: meson: vdec: Fix race condition by c=
anceling work sync ---
commit 9631e0314174ce9dbe778bf9146832ff6e5a0364
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix race condition by canceling work sync

This commit attempts to synchronize workqueue states during teardown to
eliminate race conditions. It adds synchronous cancellation of
esparser_queue_work in vdec_stop_streaming() and vdec_close().

Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel=
.org/

> Remove the scheduling of esparser queue work during destination buffer
> completion, as freeing the vififo is handled elsewhere.

[Severity: Medium]
Did this actually get removed? Looking at dst_buf_done() in vdec_helpers.c,
it still contains:

    /* Buffer done probably means the vififo got freed */
    schedule_work(&sess->esparser_queue_work);

This seems to contradict the commit message and means the workqueue is still
scheduled asynchronously during destination buffer completion.

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index 7689ffdb2e500..6fe9722577179 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -484,11 +484,15 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  			}
>  		}
> =20
> +		mutex_unlock(&core->lock);
>  		/* Synchronize and flush pending hardware interrupt service routines */
>  		synchronize_irq(core->vdec_irq);
>  		/* Ensure esparser ISR finishes executing */
>  		synchronize_irq(core->esparser_irq);
> =20
> +		cancel_work_sync(&sess->esparser_queue_work);

[Severity: High]
Can this cause a deadlock?

When userspace calls the streamoff ioctl, the v4l2 core acquires the queue
lock (&sess->lock) before calling this vdec_stop_streaming() callback.
Since cancel_work_sync() waits for the worker thread to finish, and the
worker esparser_queue_all_src() attempts to acquire mutex_lock(&sess->lock),
won't these threads wait on each other indefinitely if the worker is
already running?

[Severity: High]
Could this teardown ordering lead to a use-after-free?

Because cancel_work_sync() and synchronize_irq() are called before
vdec_poweroff() disables the hardware, the hardware is still active
and can generate interrupts. An interrupt could fire immediately after
cancel_work_sync() returns, causing dst_buf_done() to schedule the work
again. If the sess structure is subsequently freed, won't the newly
scheduled work dereference a freed pointer?

> +		mutex_lock(&core->lock);
> +
>  		vdec_poweroff(sess);
>  		vdec_free_canvas(sess);

[ ... ]

> @@ -999,6 +1003,8 @@ static int vdec_close(struct file *file)
>  	/* Ensure esparser ISR finishes executing */
>  	synchronize_irq(core->esparser_irq);
> =20
> +	cancel_work_sync(&sess->esparser_queue_work);

[Severity: High]
Does this have the same teardown ordering race as vdec_stop_streaming()?

The cancel_work_sync() call happens before vdec_poweroff(sess). If
the hardware generates a late interrupt, could the work be scheduled
again right before the session is freed?

> +
>  	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
>  		kthread_stop(sess->recycle_thread);
>  		sess->recycle_thread =3D NULL;

Later in vdec_close(), the hardware is powered down and the session is clea=
red:

    mutex_lock(&core->lock);

    vdec_poweroff(sess);
    vdec_free_canvas(sess);
    core->cur_sess =3D NULL;

[Severity: High]
Does this unconditionally terminate the hardware state of the active sessio=
n?

Because this lacks an if (core->cur_sess =3D=3D sess) check (which is safel=
y used
in vdec_stop_streaming), if a secondary client opens and immediately closes
the device node, won't it forcefully power off the hardware and clear the
session while the primary client is actively streaming?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D6
