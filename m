Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4A606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxCEGMCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80F410EAC3;
	Sun,  1 Nov 2026 22:42:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB7D10EAC3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 22:41:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B406601FF;
 Sun,  1 Nov 2026 22:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DCF1F000C1;
 Sun,  1 Nov 2026 22:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793572918;
 bh=iF4EbNo6a+cNnpPyLaLu018OT+eESeVbu4ZV5pbRZ7o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HxCEGMCkL0bRJhyw228kzesQXD/GrSKnL0H/+RAqC5gjed1uhdN3B7nongC8E3C7f
 laqvlgHQytzviSqYQZuKG4IIYXR8ZvsucbZOeiPVoReALxzupyQCkmSAGiAID0l6VX
 hB2ulH30cnDvf2BAVml9xoSPQ2VVFM8qiZXJaGC1kLDMC4Hc0Bz6F2GpzJASp//RJ7
 Hg823WvOzQpl1TnPR5uXtyMr9Bn595VJTqrEful00ee3NmLaf8dzZQdUg8ostHt4ft
 xU74Hg+pch2ztU0PNoXWgZ+x7nGvHaW/HoYU1r2jWpRB/RLEzoy/uNJDkxlOAhLPaV
 3zUfzr6iZhiBQ==
Message-ID: <sashiko-outbox-192726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/25] accel/qda: Add the invocation ioctl and
 teardown on unplug
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261102-v4-v4-13-88f2f24a5f0b@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-13-88f2f24a5f0b@qti.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 22:41:57 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] accel/qda: unconditional kref_put() in qda_fastrpc_flush_pendi=
ng()
- [Critical] accel/qda: premature teardown in qda_rpmsg_remove() while ctxs=
 active
- [Critical] accel/qda: missing init handle check in qda_fastrpc_prepare_ar=
gs_invoke()
- [Critical] accel/qda: missing bounds check and union misuse in process_dm=
a_handle()
- [Medium] accel/qda: handle list leak on DSP error in qda_fastrpc_invoke_c=
ommon()
--

commit 9e89a77ec2ad7f5231cb9a9e8fb15165b01e374a
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

accel/qda: Add the invocation ioctl and teardown on unplug

This commit adds the DRM_IOCTL_QDA_REMOTE_INVOKE ioctl to allocate an
invocation context, prepare arguments, pack and send the payload over
RPMsg, and wait for the DSP response. It also adds
qda_fastrpc_flush_pending() to fail and wake pending invocations when
the RPMsg device is removed.

> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fast=
rpc.c
> index 2971f2f9461fc..3a1959e2c53ee 100644
> --- a/drivers/accel/qda/qda_fastrpc.c
> +++ b/drivers/accel/qda/qda_fastrpc.c
> @@ -10,6 +10,7 @@
>  #include "qda_drv.h"
>  #include "qda_fastrpc.h"
>  #include "qda_gem.h"
> +#include "qda_rpmsg.h"
> =20
>  /*
>   * The caller owns the returned reference and must drop it with
> @@ -484,6 +485,72 @@ int qda_fastrpc_invoke_pack(struct qda_fastrpc_invok=
e_ctx *ctx, struct qda_msg *
>  	return 0;
>  }
> =20
> +/**
> + * qda_fastrpc_flush_pending() - Fail every invocation still in flight
> + * @qdev: Device whose invocations should be failed
> + *
> + * The DSP has gone away and will never answer, so stand in for the resp=
onse
> + * handler: wake each waiter with an error and drop the reference the se=
nd
> + * path took for that handler. Each waiter then tears its invocation dow=
n,
> + * releasing the buffers it holds.
> + *
> + * Must run after drm_dev_unplug() has drained the response handler, so =
this
> + * is the only path completing an invocation.
> + */
> +void qda_fastrpc_flush_pending(struct qda_dev *qdev)
> +{
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	unsigned long idx;
> +
> +	xa_for_each(&qdev->ctx_xa, idx, ctx) {
> +		ctx->retval =3D -EPIPE;
> +		complete(&ctx->work);
> +		kref_put(&ctx->refcount, qda_fastrpc_context_free);
> +	}
> +}

[Severity: Critical]
Can qda_fastrpc_flush_pending() drop a reference that was never taken (or w=
as
already queued to be dropped), causing a reference count underflow and
use-after-free of struct qda_fastrpc_invoke_ctx?

In qda_fastrpc_invoke(), qda_fastrpc_context_alloc() initializes
ctx->refcount to 1 and immediately inserts ctx into qdev->ctx_xa before
qda_fastrpc_prepare_args(), qda_fastrpc_invoke_pack(), and
qda_rpmsg_send_msg() run:

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_alloc() {
	...
	kref_init(&ctx->refcount);
	...
	ret =3D xa_alloc(&qdev->ctx_xa, &id, ctx, XA_LIMIT(1, QDA_FASTRPC_CTXID_MA=
X),
		       GFP_KERNEL);
}

Because drm_ioctl() only checks drm_dev_is_unplugged() at entry and does not
hold a drm_dev_enter() read lock across qda_ioctl_invoke(), drm_dev_unplug()
in qda_rpmsg_remove() does not wait for in-flight qda_fastrpc_invoke() call=
s.
The second reference for the response handler is only acquired inside
qda_rpmsg_send_msg() if drm_dev_enter() succeeds, qdev->rpdev is non-NULL,
and rpmsg_send() succeeds:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_send_msg() {
	if (!drm_dev_enter(&qdev->drm_dev, &idx))
		return -ENODEV;

	if (!qdev->rpdev) {
		ret =3D -ENODEV;
		goto out_exit;
	}

	kref_get(&ctx->refcount);

	ret =3D rpmsg_send(qdev->rpdev->ept, &msg->fastrpc, sizeof(msg->fastrpc));
	if (ret) {
		drm_err_ratelimited(&qdev->drm_dev, "Failed to send rpmsg: %d\n", ret);
		kref_put(&ctx->refcount, qda_fastrpc_context_free);
	}
}

Similarly, if qda_rpmsg_cb() handled a response just before unplug, it
schedules ctx->put_work to drop the response reference asynchronously while
ctx remains in qdev->ctx_xa until qda_fastrpc_context_free() runs:

drivers/accel/qda/qda_rpmsg.c:qda_rpmsg_cb() {
	...
	ctx->retval =3D resp_msg->retval;
	complete(&ctx->work);
	schedule_work(&ctx->put_work);
}

When qda_fastrpc_flush_pending() iterates qdev->ctx_xa unlocked and
unconditionally calls kref_put(&ctx->refcount, qda_fastrpc_context_free), it
drops the caller's or worker's reference in both windows, freeing ctx while
qda_fastrpc_invoke() or qda_fastrpc_context_put_wq() is still using it. In
addition, because xa_for_each() runs without locking or pinning ctx, a
concurrent caller or put_work worker can free ctx right after xa_for_each()
loads the pointer, causing qda_fastrpc_flush_pending() to write ctx->retval
and call complete() and kref_put() on freed memory.

> +
> +/**
> + * qda_fastrpc_invoke_common() - Shared tail of a FastRPC invocation
> + * @qdev: Device to invoke on
> + * @ctx: Invocation whose arguments are already prepared
> + *
> + * Packs the invocation into a message, sends it, waits for the DSP, and=
 acts
> + * on the answer. Common to the accel UAPI and the legacy shim, once eac=
h has
> + * prepared ctx->args and ctx->gem_objs by its own means.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int qda_fastrpc_invoke_common(struct qda_dev *qdev, struct qda_fastrpc_i=
nvoke_ctx *ctx)
> +{
> +	struct qda_msg msg =3D {};
> +	int err;
> +
> +	err =3D qda_fastrpc_invoke_pack(ctx, &msg);
> +	if (err)
> +		return err;

[Severity: Critical]
When qda_fastrpc_invoke_common() calls qda_fastrpc_invoke_pack() ->
qda_fastrpc_get_args() -> process_dma_handle() for handle arguments
(i >=3D ctx->nbufs), can user space forge DSP DMA handle descriptors or tri=
gger
out-of-bounds DSP memory accesses?

In process_dma_handle():

drivers/accel/qda/qda_fastrpc.c:process_dma_handle() {
	if (!ctx->args[i].handle) {
		rpra[i].buf.addr =3D ctx->args[i].offset;
		rpra[i].buf.len =3D ctx->args[i].length;
		return 0;
	}
	...
	/* The DSP-facing offset and length fields are 32-bit by wire format */
	rpra[i].dma.handle =3D ctx->args[i].handle;
	rpra[i].dma.len =3D (u32)ctx->args[i].length;
	rpra[i].dma.offset =3D (u32)ctx->args[i].offset;
}

First, rpra[i] is a union qda_remote_arg, which the DSP interprets as struct
qda_remote_dmahandle dma (s32 handle; u32 offset; u32 len;) for handle
arguments (i >=3D ctx->nbufs). When ctx->args[i].handle is 0, writing the
64-bit ctx->args[i].offset into rpra[i].buf.addr aliases rpra[i].dma.handle
with the lower 32 bits and rpra[i].dma.offset with the upper 32 bits,
allowing user space to inject an arbitrary non-zero DSP handle and offset
while bypassing get_gem_obj_from_handle() validation.

Second, when ctx->args[i].handle is non-zero, process_dma_handle() looks up
gem_obj via get_gem_obj_from_handle(), but unlike process_msg_buffer(), it
never verifies that ctx->args[i].offset and ctx->args[i].length fit within
to_qda_gem_obj(gem_obj)->size (or within u32 before truncating them to
rpra[i].dma.offset and rpra[i].dma.len).

> +
> +	err =3D qda_rpmsg_send_msg(qdev, &msg);
> +	if (err)
> +		return err;
> +
> +	err =3D qda_rpmsg_wait_for_rsp(ctx);
> +	if (err)
> +		return err;
> +
> +	/* Ensure the results written by the DSP are visible before reading */
> +	dma_rmb();
> +
> +	err =3D ctx->retval;
> +	if (err) {
> +		drm_dbg_driver(&qdev->drm_dev, "DSP returned status %d\n", ctx->retval=
);
> +		return err;
> +	}
> +
> +	qda_fastrpc_cleanup_handlelist(ctx);
> +
> +	return 0;
> +}

[Severity: Medium]
Does returning early when ctx->retval is non-zero in
qda_fastrpc_invoke_common() leak the GEM handles listed in the DSP's respon=
se
handle list?

When a remote DSP invocation fails with a non-zero status code, the DSP
framework can still populate the handle release list in the payload buffer
(as addressed in drivers/misc/fastrpc.c by commit 1c8093591d1e ("misc:
fastrpc: Clean buffers on remote invocation failures")). Returning before
qda_fastrpc_cleanup_handlelist(ctx) leaves those GEM handles open in
ctx->session->file.

[ ... ]

> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
> index b11743ab791e7..e9f4151e344af 100644
> --- a/drivers/accel/qda/qda_ioctl.c
> +++ b/drivers/accel/qda/qda_ioctl.c
> @@ -6,6 +6,7 @@
>  #include <drm/drm_gem.h>
>  #include <drm/qda_accel.h>
>  #include "qda_drv.h"
> +#include "qda_fastrpc.h"
>  #include "qda_gem.h"
>  #include "qda_ioctl.h"
> =20
> @@ -73,3 +74,38 @@ int qda_ioctl_gem_mmap_offset(struct drm_device *dev, =
void *data, struct drm_fil
> =20
>  	return drm_gem_dumb_map_offset(file_priv, dev, args->handle, &args->off=
set);
>  }
> +
> +static int qda_fastrpc_invoke(void *data, struct qda_session *session)
> +{
> +	struct qda_dev *qdev =3D session->qda_dev;
> +	struct qda_fastrpc_invoke_ctx *ctx;
> +	int err;
> +
> +	ctx =3D qda_fastrpc_context_alloc(qdev);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	err =3D qda_fastrpc_prepare_args(ctx, session, data);
> +	if (err)
> +		goto out_put;
> +
> +	err =3D qda_fastrpc_invoke_common(qdev, ctx);

[Severity: Critical]
Should qda_fastrpc_invoke() or qda_fastrpc_prepare_args_invoke() reject
user-space invocations targeting handle 1 (QDA_FASTRPC_INIT_HANDLE)?

In qda_fastrpc_prepare_args() -> qda_fastrpc_prepare_args_invoke():

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_prepare_args_invoke() {
	...
	ctx->handle =3D invoke_args->handle;
	ctx->sc =3D invoke_args->sc;
}

In the FastRPC protocol, handle 1 is reserved for kernel-issued process and
protection domain management calls. Unlike fastrpc_internal_invoke() in
drivers/misc/fastrpc.c, which rejects user-space calls with handle =3D=3D
FASTRPC_INIT_HANDLE with -EPERM (CVE-2019-2308), DRM_IOCTL_QDA_REMOTE_INVOKE
allows unprivileged user space to invoke handle 1 directly.

[ ... ]

> diff --git a/drivers/accel/qda/qda_rpmsg.c b/drivers/accel/qda/qda_rpmsg.c
> index 43b56ab3f0128..7e58df3eb2e17 100644
> --- a/drivers/accel/qda/qda_rpmsg.c
> +++ b/drivers/accel/qda/qda_rpmsg.c
> @@ -160,6 +160,7 @@ static void qda_rpmsg_remove(struct rpmsg_device *rpd=
ev)
>  	 */
>  	drm_dev_unplug(&qdev->drm_dev);
>  	qdev->rpdev =3D NULL;
> +	qda_fastrpc_flush_pending(qdev);
>  	qda_cb_unpopulate(qdev);
>  	qda_deinit_device(qdev);
>  }

[Severity: Critical]
Does qda_rpmsg_remove() tear down qdev->cb_devs, qdev->iommu_mgr, and
qdev->ctx_xa while woken invocations and pending ctx->put_work items are
still using them?

When an invocation is waiting in qda_rpmsg_wait_for_rsp(), ctx->refcount is=
 2
(one held by the caller in qda_fastrpc_invoke() and one taken by
qda_rpmsg_send_msg()). Calling qda_fastrpc_flush_pending() wakes the waiter
and drops one reference, reducing ctx->refcount to 1, while ctx remains in
qdev->ctx_xa until the woken caller thread (or a pending ctx->put_work
worker) runs qda_fastrpc_context_free():

drivers/accel/qda/qda_fastrpc.c:qda_fastrpc_context_free() {
	...
	xa_erase(&ctx->qdev->ctx_xa, FIELD_GET(QDA_FASTRPC_CTXID_MASK, ctx->ctxid)=
);
	...
	if (ctx->msg_gem_obj)
		qda_session_msg_buf_put(ctx->session, &ctx->msg_gem_obj->base);

	if (ctx->session)
		qda_session_put(ctx->session);
	...
}

Because qda_rpmsg_remove() immediately proceeds to qda_cb_unpopulate(qdev)
and qda_deinit_device(qdev) without waiting for in-flight invocations or
flushing pending ctx->put_work items:

1. qda_cb_unpopulate() destroys and frees the child context-bank platform
devices via of_platform_device_destroy(&entry->pdev->dev, NULL) while GEM
objects held by active invocations and sessions still reference
&entry->pdev->dev via gem_obj->iommu_dev->dev, leading to a use-after-free =
in
qda_dma_free() when dma_free_coherent() runs.

2. qda_deinit_device() calls qda_memory_manager_exit(qdev->iommu_mgr) and
xa_destroy(&qdev->ctx_xa) while contexts are still present in qdev->ctx_xa;
when woken threads or ctx->put_work workers subsequently execute
qda_fastrpc_context_free(), they call xa_erase() on the destroyed XArray.

3. If an interrupted caller already returned and closed its DRM file while
ctx->put_work is still queued (since neither qda_session nor
qda_fastrpc_invoke_ctx holds a drm_dev_get() reference on qdev->drm_dev),
finishing qda_rpmsg_remove() allows devm to release qdev before
qda_fastrpc_context_put_wq() runs qda_fastrpc_context_free() and dereferenc=
es
ctx->qdev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-v4-v4-0-88=
f2f24a5f0b@qti.qualcomm.com?part=3D13
