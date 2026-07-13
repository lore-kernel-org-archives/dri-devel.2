Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F831C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09DB10E259;
	Mon, 13 Jul 2026 12:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6/kZNeb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4E410E259
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:48:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E48A6004E;
 Mon, 13 Jul 2026 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D0A1F000E9;
 Mon, 13 Jul 2026 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946924;
 bh=9UXfmzJfyL3OZuqcoEEA5UZ7gPRrBxbPuUIb5Z7Ac/E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H6/kZNebaHFmW1x00rozEcTSt5DFYVfj6XNZsyHFE53LaiOK4tpVhIeMSbXM66HPc
 nuzYXwlzJ7Du0gYod4N8eaVcpqFGP+Q2+N46XuCz0aOqM5pX+8ShzShCOvbDq5jK2c
 71q35uzp3d7nskiBej8is+vm5OLe1W+CK4R1lp0nJ/P8P9QsOpfJJYp1ADtFRdpJnR
 e7DywdvoFGNo6bABZYRliZFZCfYkrDtnOWXzF/9K0VgjFhOgKVoncm3L9ugaTFkI2y
 3SKEj8kbROzdg3m6AJJ7Srvw1qphasHcTmFAguZ+4e+keH0yYNnkyC3lL8+/JLwe25
 sr4XNgmns5Tyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/19] media: meson: vdec: Correct atomic counter
 placement in dst_buf_done
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-15-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-15-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:48:43 +0000
Message-Id: <20260713124843.A6D0A1F000E9@smtp.kernel.org>
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

New issues:
- [Critical] The patch introduces an unhandled double decrement of `sess->e=
sparser_queued_bufs`, causing the atomic counter to underflow, corrupting s=
tream state evaluation, and deadlocking the driver.
- [High] Using `break` inside `scoped_guard` fails to exit the worker loop,=
 resulting in a 100% CPU infinite loop deadlock.
- [High] Returning 0 on `!vaddr` in `esparser_pad_start_code()` skips writi=
ng the mandatory start code pattern, leading to hardware out-of-bounds read=
s.
- [Medium] The commit message erroneously claims to relocate a decrement fr=
om the 'entry point' of the function, presenting a false premise for the ch=
ange.

Pre-existing issues:
- [High] Missing decrement of `esparser_queued_bufs` on error paths permane=
ntly leaks logical buffer slots.
--

--- Patch [14]: [PATCH v7 14/19] media: meson: vdec: Correct atomic counter=
 placement in dst_buf_done ---
commit 3bacd92d37472439ff6f7550b68eb503f9d760f0
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Correct atomic counter placement in dst_buf_done

This commit fixes an end-of-stream boundary condition by relocating
the atomic decrement helper to execute after state evaluation. It
aims to ensure accurate stream termination signaling.

> Previously, decrementing sess->esparser_queued_bufs at the entry point
> of the function corrupted the conditional checks for the final video
> frame.

[Severity: Medium]
Is this description accurate? Looking at the baseline code, dst_buf_done()
never contained an atomic decrement at its entry point or anywhere else
inside the function. The decrement only existed in the caller functions.

> diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/st=
aging/media/meson/vdec/vdec_helpers.c
> index f02c21d5a9c18..303236f0647c0 100644
> --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
> +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
> @@ -314,6 +314,9 @@ static void dst_buf_done(struct amvdec_session *sess,
>  	dev_dbg(dev, "Buffer %u done, ts =3D %llu, flags =3D %08X\n",
>  		vbuf->vb2_buf.index, timestamp, flags);
>  	vbuf->field =3D field;
> +
> +	atomic_dec(&sess->esparser_queued_bufs);
> +

[Severity: Critical]
Does this introduce a double decrement? Since the callers like
amvdec_dst_buf_done() and amvdec_dst_buf_done_offset() still contain their
original atomic_dec() calls, this new decrement causes the counter to
underflow.

When the counter becomes negative, the EOS condition
atomic_read(&sess->esparser_queued_bufs) <=3D 1 evaluates to true, which
can falsely trigger V4L2_EVENT_EOS on the wrong buffer and cause a
permanent -EAGAIN deadlock.

>  	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> =20
>  	/* Buffer done probably means the vififo got freed */


[Severity: High]
This is a pre-existing issue, but does the error path in amvdec_dst_buf_don=
e()
permanently leak logical buffer slots?

drivers/staging/media/meson/vdec/vdec_helpers.c:amvdec_dst_buf_done() {
        ...
        if (list_empty(&sess->timestamps)) {
                v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
                spin_unlock_irqrestore(&sess->ts_spinlock, flags);
                return;
        }
        ...
}

When list_empty() is true, the function returns early without decrementing
sess->esparser_queued_bufs. If this triggers enough times, the counter
artificially hits the max limit, preventing new buffers from being queued.


[Severity: High]
Does the break statement in esparser_queue_all_src() inadvertently cause an
infinite loop?

drivers/staging/media/meson/vdec/esparser.c:esparser_queue_all_src() {
        while (1) {
                scoped_guard(mutex, &sess->lock) {
                        ...
                        if (!vbuf)
                                break;
                        ...
                }
                ...
        }
}

Because scoped_guard() is implemented using an internal for-loop, calling
break here only exits the scoped_guard's internal scope, not the outer
while (1) loop. This causes the worker thread to permanently hang in an
infinite busy-wait loop.


[Severity: High]
Can the failure to propagate an error in esparser_pad_start_code() cause
hardware out-of-bounds reads?

drivers/staging/media/meson/vdec/esparser.c:esparser_pad_start_code() {
        ...
        if (!sess || READ_ONCE(sess->should_stop) || !sess->priv || !vaddr)
                return 0;
        ...
}

If a client provides an unmapped buffer, !vaddr is true and this returns 0,
skipping the mandatory 512-byte start code padding.

Its caller esparser_queue() ignores this and passes the physical address to
esparser_write_data(), which unconditionally adds 512 to the payload size.
Since the padding wasn't written, the hardware DMA engine reads past the
valid buffer boundary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D14
