Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125D5CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E5310EFB5;
	Wed, 17 Jun 2026 11:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NJq1A3hY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BF810EFB5
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5959A43729;
 Wed, 17 Jun 2026 11:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203EC1F00A3D;
 Wed, 17 Jun 2026 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695700;
 bh=hjboUhwy6sTkxM0HLdHybz+KAFQg3UL3BqLbQeYsqNA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NJq1A3hYYmNjt5PZi3tZdSrDR7x7qcg0mGy67LR6Nz7XC2LYdJ2afiVWGsGqM3x7Z
 UiuF8KHJJS2xlBKPtY9JgkZXGswVCmCrpM1D1OrptPKGQXASa+5djS8k9tcdyW1p8t
 CaZ/r+AahT0WlNUgUAYIQvDacc49kMjfwjB3IxFfAu5c3IEkV82S+zduYk+PpzMFAm
 rUU3XnmNDNQPWt+qKosRKq2OMGhZrPLU0VcujGTlaoFTO6Z3XiAwjn8G4fb9jMhy0l
 LFnLx3WNRyuj2RtVIhBMwxOiUQhn/JcdtUYqr1kQw91Saason79dFRlJclUkI7g9FJ
 GrNHPIB6dfBcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: "Eddie Lin" <eddie.lin@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
References: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 11:28:19 +0000
Message-Id: <20260617112820.203EC1F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Early misc device registration in probe exposes uninitialized =
context data to userspace, leading to NULL pointer dereferences and a Use-A=
fter-Free on error paths.
- [High] Permanent memory leak of `fastrpc_buf` structures and DMA buffers =
when the rpmsg device is removed.
- [High] Users holding an open file descriptor can trigger Use-After-Free a=
nd NULL pointer dereferences after the rpmsg device is removed.
- [High] Refcount leak of the channel context (`cctx`) in the `fastrpc_devi=
ce_open()` error path.
- [High] Use-After-Free vulnerability in `fastrpc_rpmsg_callback()` due to =
accessing a `fastrpc_invoke_ctx` object without holding a reference count.
- [High] Concurrent execution of FASTRPC_IOCTL_INIT_CREATE_STATIC leads to =
memory leaks and Use-After-Free vulnerabilities.
--

commit 89c91d7772abf19a9b1d5b7c02132aeec834f50a
Author: Eddie Lin <eddie.lin@oss.qualcomm.com>

misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

The 'ctx_idr' is initialized but never destroyed when the channel context is
freed, leading to a memory leak. This commit adds idr_destroy() to properly
clean up the IDR resources.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a3..b93267ac30757 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -484,6 +484,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
> =20
>  	cctx =3D container_of(ref, struct fastrpc_channel_ctx, refcount);
> =20
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }

[Severity: Critical]
This is a pre-existing issue, but does the early misc device registration in
fastrpc_rpmsg_probe() expose uninitialized context data to userspace?

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
	...
	err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
	if (err)
		goto err_free_data;
	...
	kref_init(&data->refcount);
	...
}

The device is registered with the misc subsystem and accessible by userspace
before essential context variables are initialized. A concurrent open() will
access zeroed memory, resulting in crashes.

Also, on the error path:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
	...
err_deregister_fdev:
	if (data->fdevice)
		misc_deregister(&data->fdevice->miscdev);
...
err_free_data:
	kfree(data);
	return err;
}

The data context is unconditionally freed without checking if any userspace
process successfully opened it. misc_deregister() does not revoke existing =
open
file descriptors, so any concurrently opened FD will retain a dangling poin=
ter
to the freed context, leading to a Use-After-Free.

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_remove() permanently l=
eak
fastrpc_buf structures and DMA buffers?

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
	...
	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
		list_del(&buf->node);
	...
}

The elements are removed from the interrupted mmaps list but never actually
freed. It completely fails to call fastrpc_buf_free(buf), which permanently
leaks both the struct fastrpc_buf and its associated coherent DMA allocatio=
ns
every time an interrupted channel is torn down.

[Severity: High]
This is a pre-existing issue, but can users holding an open file descriptor
trigger Use-After-Free and NULL pointer dereferences after the rpmsg device=
 is
removed?

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
	...
	if (cctx->remote_heap)
		fastrpc_buf_free(cctx->remote_heap);
	...
}

The remote heap buffer is freed, but the pointer cctx->remote_heap is not s=
et
to NULL, leaving a dangling pointer.

Additionally, in fastrpc_remote_heap_alloc():

drivers/misc/fastrpc.c:fastrpc_remote_heap_alloc() {
	...
	struct device *rdev =3D &fl->cctx->rpdev->dev;
	...
}

If userspace triggers an allocation after rpmsg_remove sets cctx->rpdev =3D=
 NULL,
this computes an invalid pointer leading to a NULL pointer dereference.

[Severity: High]
This is a pre-existing issue, but is there a refcount leak of the channel
context in the fastrpc_device_open() error path?

drivers/misc/fastrpc.c:fastrpc_device_open() {
	...
	fl->sctx =3D fastrpc_session_alloc(fl);
	if (!fl->sctx) {
		dev_err(&cctx->rpdev->dev, "No session available\n");
		mutex_destroy(&fl->mutex);
		kfree(fl);

		return -EBUSY;
	}
	...
}

The error path fails to drop the reference acquired by
fastrpc_channel_ctx_get(cctx), leaking the context's refcount permanently.
Since the open() syscall fails, the release file operation will never execu=
te,
preventing the cctx object from ever being freed.

[Severity: High]
This is a pre-existing issue, but is there a Use-After-Free vulnerability in
fastrpc_rpmsg_callback() due to accessing a fastrpc_invoke_ctx object witho=
ut
holding a reference count?

drivers/misc/fastrpc.c:fastrpc_rpmsg_callback() {
	...
	spin_lock_irqsave(&cctx->lock, flags);
	ctx =3D idr_find(&cctx->ctx_idr, ctxid);
	spin_unlock_irqrestore(&cctx->lock, flags);

	if (!ctx) {
		dev_err(&rpdev->dev, "No context ID matches response\n");
		return -ENOENT;
	}

	ctx->retval =3D rsp->retval;
	...
}

The lock is released without elevating the reference count of ctx. A concur=
rent
close can free ctx before ctx->retval is written, resulting in a Use-After-=
Free
write to a freed work structure.

[Severity: High]
This is a pre-existing issue, but does concurrent execution of
FASTRPC_IOCTL_INIT_CREATE_STATIC lead to memory leaks and Use-After-Free
vulnerabilities?

drivers/misc/fastrpc.c:fastrpc_init_create_static_process() {
	...
	if (!fl->cctx->remote_heap) {
		err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
						&fl->cctx->remote_heap);
	}
	...
}

The check and subsequent allocation of the shared remote_heap is performed
without holding any locks, allowing race conditions between concurrent ioct=
ls.
This causes multiple DMA allocations where subsequent threads overwrite
fl->cctx->remote_heap, permanently leaking the previously allocated memory.

Also, on the error path:

drivers/misc/fastrpc.c:fastrpc_init_create_static_process() {
	...
err_map:
	fastrpc_buf_free(fl->cctx->remote_heap);
	fl->cctx->remote_heap =3D NULL;
	...
}

In the error path, the shared heap is freed and nulled. If another thread is
concurrently using it, this leads to a Use-After-Free or dereferencing a NU=
LL
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-fastrpc-cc=
tx-cleanup-v2-1-be87c021114a@oss.qualcomm.com?part=3D1
