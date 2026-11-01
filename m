Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF857606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqfU/CS1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3787610EAE0;
	Sun,  1 Nov 2026 23:02:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A8F10EAE0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:02:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99FF1605CE;
 Sun,  1 Nov 2026 23:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C1F1F0093A;
 Sun,  1 Nov 2026 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574144;
 bh=6PwMFUmhaILC+NBm41ccvHNc0QHtPTy24ex2VrIKZ6g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NqfU/CS115RAxld7vBhCxlUft9WtFW4ROmQ3iT8RxDMhdO5D5dERzDaHRy2e99ax8
 AwMykD9eeQFSLbO7cvVCrPg46YmklbkQnDq7aXk5DGmG94Hvg7GL7gW5CtrTa8Yk7m
 GQW7mopLl4+rl4Vz955jnSitV41yklWv+J4CM9+74q7oh07hYgyjTubcQNLkv26xXr
 yUvdFXI0oEcenHosjONMKVjrZMVFBy/BaSfbg56rpN98IaUfNX4gdcu59G23UwDBCc
 T9MSalBmioI7i7UcWTIEXihG+dr9/Dz5HDDneCpopJ0NL4f0MCEnzHFH/3XmtdmmQb
 YgJ8379gFAwtw==
Message-ID: <sashiko-outbox-192749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/25] accel/qda: Add poll mode for invocation
 completion
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-25-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-25-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 23:02:23 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] accel/qda: missing memory ordering on ctx->retval and ctx->is_work=
_done
- [High] accel/qda: UAF and teardown race in qda_fastrpc_flush_pending()
--

commit ff1bb82ba9e7f31a0c10a5ce3a19f4029819ffbf
Author: Ekansh Gupta <ekangupt@qti.qualcomm.com>

accel/qda: Add poll mode for invocation completion

This commit adds per-session completion polling support for dynamically
loaded module invocations in a user PD via DRM_IOCTL_QDA_SET_OPTION and
FASTRPC_IOCTL_SET_OPTION. It reserves a poll word at the end of the
invocation metadata buffer and busy-waits on it before falling back to
the interrupt-based RPMsg response.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 6044cfad53e96..0617bb4842b52 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c

[ ... ]

> @@ -598,6 +604,54 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invok=
e_ctx *ctx, struct qda_msg *
>  	return 0;
>  }
> =20
> +static u32 qda_fastrpc_read_poll_addr(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	dma_rmb();
> +
> +	return READ_ONCE(*ctx->poll_addr);
> +}
> +
> +/*
> + * Busy-wait for the DSP to write QDA_FASTRPC_POLL_RESPONSE into the pol=
l word,
> + * which saves the interrupt and scheduling latency of waiting for the r=
pmsg
> + * response. The response still arrives afterwards and drops the referen=
ce
> + * qda_rpmsg_send_msg() took for it as usual.
> + *
> + * Return: 0 if the invocation completed, negative error code if it has =
not
> + * answered within QDA_FASTRPC_POLL_MAX_TIMEOUT_US
> + */
> +static int qda_fastrpc_poll_for_rsp(struct qda_fastrpc_invoke_ctx *ctx)
> +{
> +	u32 val;
> +	int err;
> +
> +	err =3D read_poll_timeout_atomic(qda_fastrpc_read_poll_addr, val,
> +				       val =3D=3D QDA_FASTRPC_POLL_RESPONSE ||
> +				       READ_ONCE(ctx->is_work_done),
> +				       1, QDA_FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
> +	if (err)
> +		return err;
> +
> +	/* The rpmsg path records its own status, so only the poll path's is se=
t here */
> +	if (val =3D=3D QDA_FASTRPC_POLL_RESPONSE) {
> +		WRITE_ONCE(ctx->is_work_done, true);
> +		ctx->retval =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qda_fastrpc_wait_for_completion(struct qda_fastrpc_invoke_ctx=
 *ctx)
> +{
> +	if (ctx->is_polled && !qda_fastrpc_poll_for_rsp(ctx))
> +		return 0;
> +
> +	/* Polling timed out, so fall back to waiting for the rpmsg response */
> +	ctx->is_polled =3D false;
> +
> +	return qda_rpmsg_wait_for_rsp(ctx);
> +}

[Severity: High]
Can a polled invocation observe ctx->is_work_done =3D=3D true before the st=
ore
to ctx->retval is visible, or race on ctx->retval between the poll and RPMsg
paths?

In qda_fastrpc_context_alloc(), ctx->retval is initialized to -1. When
qda_rpmsg_cb() or qda_fastrpc_flush_pending() completes an invocation, it
writes ctx->retval with a plain store and then sets ctx->is_work_done with
WRITE_ONCE():

    ctx->retval =3D resp_msg->retval;
    WRITE_ONCE(ctx->is_work_done, true);
    complete(&ctx->work);

If read_poll_timeout_atomic() in qda_fastrpc_poll_for_rsp() exits because
READ_ONCE(ctx->is_work_done) became true while val !=3D QDA_FASTRPC_POLL_RE=
SPONSE,
qda_fastrpc_poll_for_rsp() returns 0 and qda_fastrpc_wait_for_completion()
returns 0 immediately without calling qda_rpmsg_wait_for_rsp(ctx), skipping
wait_for_completion_interruptible(&ctx->work).

Because wait_for_completion_interruptible(&ctx->work) is bypassed and there
is no release-acquire ordering between writing ctx->retval and setting
ctx->is_work_done (the dma_rmb() in qda_fastrpc_invoke_common() only orders
reads on the polling CPU, not the two stores on the CPU running
qda_rpmsg_cb() or qda_fastrpc_flush_pending()), couldn't the polling CPU re=
ad
the stale initial ctx->retval =3D=3D -1 (-EPERM) in qda_fastrpc_invoke_comm=
on()?

Also, neither qda_rpmsg_cb() nor qda_fastrpc_flush_pending() checks
ctx->is_work_done before writing ctx->retval, so when
qda_fastrpc_poll_for_rsp() sees val =3D=3D QDA_FASTRPC_POLL_RESPONSE and se=
ts
ctx->retval =3D 0, a concurrent qda_rpmsg_cb() or qda_fastrpc_flush_pending=
()
will still write ctx->retval without synchronization against the polling
thread's write or its subsequent read in qda_fastrpc_invoke_common(). Should
the writers and reader use smp_store_release() and smp_load_acquire() (or
atomic state transition) to order and arbitrate updates to ctx->retval?

> @@ -617,6 +671,7 @@ void qda_fastrpc_flush_pending(struct qda_dev *qdev)
> =20
>  	xa_for_each(&qdev->ctx_xa, idx, ctx) {
>  		ctx->retval =3D -EPIPE;
> +		WRITE_ONCE(ctx->is_work_done, true);
>  		complete(&ctx->work);
>  		kref_put(&ctx->refcount, qda_fastrpc_context_free);
>  	}

[Severity: High]
Does qda_fastrpc_flush_pending() risk a use-after-free or premature device
teardown when polled invocations are in flight or have recently completed?

There appear to be two teardown races when qda_rpmsg_remove() runs:

    drm_dev_unplug(&qdev->drm_dev);
    qdev->rpdev =3D NULL;
    qda_fastrpc_flush_pending(qdev);
    qda_cb_unpopulate(qdev);
    qda_deinit_device(qdev);

First, when a polled invocation finishes via qda_fastrpc_poll_for_rsp(), the
calling thread returns from qda_fastrpc_invoke() and drops its reference via
kref_put(&ctx->refcount, qda_fastrpc_context_free), leaving ctx in
qdev->ctx_xa with refcount =3D=3D 1 until the RPMsg reply arrives. When
qda_rpmsg_cb() later receives that reply, it schedules ctx->put_work to drop
the final reference from process context, because ctx is only erased from
qdev->ctx_xa inside qda_fastrpc_context_free(). If qda_rpmsg_remove() runs
after qda_rpmsg_cb() schedules ctx->put_work but before
qda_fastrpc_context_put_wq() executes, qda_fastrpc_flush_pending() will find
ctx still in qdev->ctx_xa and drop its refcount to 0, freeing ctx while
ctx->put_work is still pending on system_wq.

Second, qda_fastrpc_poll_for_rsp() runs outside drm_dev_enter(). If a thread
is actively polling in qda_fastrpc_poll_for_rsp() when qda_rpmsg_remove()
runs, qda_fastrpc_flush_pending() sets ctx->is_work_done =3D true and drops=
 the
RPMsg reference (decrementing refcount from 2 to 1), and qda_rpmsg_remove()
immediately proceeds to qda_cb_unpopulate(qdev) and qda_deinit_device(qdev)
without waiting for the polling thread to exit and drop its final reference.
When the polling thread subsequently runs qda_fastrpc_context_free(), won't
it call xa_erase() on the destroyed qdev->ctx_xa and free DMA buffers again=
st
the destroyed context-bank platform devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D25
