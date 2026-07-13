Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D2C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A902510E5B9;
	Mon, 13 Jul 2026 12:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fpmLs3+q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D0B10E5B9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:38:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D46C41B15;
 Mon, 13 Jul 2026 12:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7BE1F00A3A;
 Mon, 13 Jul 2026 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946283;
 bh=cA1yaA6sEa8uFS7G+v67FepW2YBQwUnLfdEu2CTbOIU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fpmLs3+qtmsd3LF4ThqmYXsxHX6+DsU1U/CZjEbX5tXap50NBDxpWyeF49ORsTJsk
 ROyRf6ovNpV+I9LiIJTAvKzci8S18hP32n9q1fH1Jvk39ls/HSKX8dPJoh4KGuZphU
 Vbq2DfsXkME4Ea4AWzpJODMbzuq9KYY/knlWmImBK7L7icYw1j4slg4WmMUlQ0xDTr
 4Hd3Syhbg1eC3ywpQ/1UHPDLu+fm2/bpzNbo2t60RdJVg/klJKmXhnT18tKqZOijIw
 CoQTXtq3uahtHNSaw8PuDFi/OpzkqP3/LNrAoEVDBJKejE8GWt10/YqAqvyteheBXR
 DvZGCFTH49njQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/19] media: meson: vdec: Fix STREAMON / STREAMOFF
 race conditions and session teardown
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713120840.17427-3-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:38:02 +0000
Message-Id: <20260713123803.3F7BE1F00A3A@smtp.kernel.org>
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
- [High] The vdec_recycle_thread is conditionally skipped from being stoppe=
d but its resources are unconditionally freed during a partial STREAMOFF, l=
eading to Use-After-Free and list corruption.
- [High] Failing start_streaming with -EBUSY permanently leaks streamon fla=
gs, causing state inconsistency and cross-session hardware corruption.

Pre-existing issues:
- [High] The return value of `kthread_run()` is not checked, leading to a k=
ernel crash when `kthread_stop()` is called on an `ERR_PTR`.
- [High] vdec_reset_timestamps accesses the timestamps list without holding=
 ts_spinlock, leading to list corruption.
- [High] Missing cancel_work_sync for esparser_queue_work causes UAF and un=
clocked register access.
--

--- Patch [2]: [PATCH v7 02/19] media: meson: vdec: Fix STREAMON / STREAMOF=
F race conditions and session teardown ---
commit c8f8b26e4a120933b5b1d329b3cc6e97ea21778d
Author: Anand Moon <linux.amoon@gmail.com>
Subject: media: meson: vdec: Fix STREAMON / STREAMOFF race conditions and s=
ession teardown

This commit addresses race conditions during concurrent STREAMON / STREAMOFF
calls and dynamic resolution changes. It restructures initialization paths,
error handling, and state tracking to prevent hardware state corruption.

Closes: https://lore.kernel.org/all/20260530100841.9CEBA1F00893@smtp.kernel=
.org/

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c

[ ... ]

> @@ -308,9 +303,29 @@ static int vdec_start_streaming(struct vb2_queue *q,=
 unsigned int count)
>  	}
> =20
>  	if (sess->status =3D=3D STATUS_RUNNING ||
> -	    sess->status =3D=3D STATUS_NEEDS_RESUME ||
> -	    sess->status =3D=3D STATUS_INIT)
> +	    sess->status =3D=3D STATUS_NEEDS_RESUME)
>  		return 0;
> =20
> +	/*
> +	 * Secure the core hardware lock before checking availability
> +	 * and updating session states to prevent STREAMON race conditions.
> +	 */
> +	mutex_lock(&core->lock);
> +	if (core->cur_sess && core->cur_sess !=3D sess) {
> +		ret =3D -EBUSY;
> +		mutex_unlock(&core->lock);
> +		goto err_unlock_no_hw;
> +	}

[Severity: High]
If we jump to err_unlock_no_hw here, doesn't it bypass the
err_cleanup_session label that clears the streamon flags?

If session B calls VIDIOC_STREAMON on its OUTPUT queue and hits this path,
sess->streamon_out will remain 1.

Could a subsequent VIDIOC_QBUF from session B cause vdec_vb2_buf_queue to
schedule esparser_queue_work, potentially overwriting the active hardware
registers of the current session?

[ ... ]

>  	sess->sequence_cap =3D 0;
>  	sess->sequence_out =3D 0;
> +
>  	if (vdec_codec_needs_recycle(sess))
>  		sess->recycle_thread =3D kthread_run(vdec_recycle_thread, sess,
>  						   "vdec_recycle");

[Severity: High]
This is a pre-existing issue, but does this code properly handle thread
creation failure?

If kthread_run fails due to memory constraints, it returns an ERR_PTR.
Later in vdec_stop_streaming, this pointer is passed unconditionally to
kthread_stop.

Could this cause a kernel panic when kthread_stop attempts to dereference
the ERR_PTR?

> -	sess->status =3D STATUS_INIT;
> -	core->cur_sess =3D sess;
>  	schedule_work(&sess->esparser_queue_work);
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does closing the file descriptor safely
clean up the workqueue scheduled here?

When the client queues a buffer and then closes the file descriptor,
vdec_close destroys mutexes and frees the amvdec_session memory via kfree
without cancelling the pending esparser_queue_work.

When the workqueue executes vdec_esparser_queue_work, could it access the
freed session memory and attempt to take a destroyed mutex?

[ ... ]

> @@ -399,30 +424,13 @@ static void vdec_stop_streaming(struct vb2_queue *q)

[ ... ]

> +	if (full_cleanup) {
> +		if ((q->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
> +		     !sess->streamon_out) && vdec_codec_needs_recycle(sess)) {
> +			kthread_stop(sess->recycle_thread);
> +		}
> +
> +		vdec_poweroff(sess);

[Severity: High]
If a userspace client starts streaming on both queues and then calls
VIDIOC_STREAMOFF on the CAPTURE queue, the newly added condition evaluating
q->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE or !sess->streamon_out
will evaluate to false, skipping kthread_stop.

Since full_cleanup is true, the code proceeds to tear down resources via
vdec_reset_bufs_recycle and kfree of sess->priv.

Could this lead to a use-after-free or list corruption if the recycle thread
continues executing while its backing resources are freed?

> +		vdec_free_canvas(sess);
> +
> +		if (sess->vififo_vaddr) {
> +			dma_free_coherent(sess->core->dev, sess->vififo_size,
> +					  sess->vififo_vaddr, sess->vififo_paddr);
> +			sess->vififo_vaddr =3D NULL;
> +			sess->vififo_paddr =3D 0;
> +		}
> +
> +		vdec_reset_timestamps(sess);

[Severity: High]
This is a pre-existing issue, but does vdec_reset_timestamps safely access
the timestamps list here?

The function iterates and frees elements of the sess->timestamps list
without holding ts_spinlock.

If a concurrent threaded ISR executes amvdec_dst_buf_done_idx and calls
amvdec_remove_ts, it will acquire ts_spinlock and attempt to remove an
element.

Could this race condition lead to linked list corruption and use-after-free?

> +		vdec_reset_bufs_recycle(sess);
> +		core->cur_sess =3D NULL;
> +
> +		kfree(sess->priv);
> +		sess->priv =3D NULL;
> +	} else {
> +		if (sess->status =3D=3D STATUS_NEEDS_RESUME)
> +			sess->changed_format =3D 0;
> +	}
> +	mutex_unlock(&core->lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D2
