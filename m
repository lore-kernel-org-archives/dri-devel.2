Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16F9C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048DB10F12C;
	Thu,  2 Jul 2026 02:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CbImxct8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA1310E406
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 02:33:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0318E43884;
 Thu,  2 Jul 2026 02:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832A11F000E9;
 Thu,  2 Jul 2026 02:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782959624;
 bh=jIQ+9wMH9usJ+zTsCFnxyrfR6AyaC9dFoEbFEFNDAOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CbImxct8LPUMyEg6GP7gNM28PHnRobf/ReTHQglAss9csK+fbm3xGKIFtfMD295fR
 ghNCChT5JgPv2ELEwgbu/YmwgdkuOWc1lxBParw5zFTWdpI+g7K9APRyBjDLM8now7
 gloeTWssLAd72m6UOK61WViD2h349WDvMcr8N3GO0ZMcm2xnStiC1EuYpI4k0C7HtC
 YhvlxQYBlXeAXLZ5e9pu6/MdJSB0VDO4yjJgr/lVQPlSmGSOc/g5xUj7MoLRU8/XBD
 lCA81O4e3xOJKjxl480iXo6E7rmX56D3A39b9N0zlcKa84O0qQpO9aACp7OafE9Hdt
 xQG0k/0a4KU5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
To: "Eddie Lin" <eddie.lin@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
References: <20260701-fastrpc-cctx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:33:42 +0000
Message-Id: <20260702023344.832A11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA buffers moved to `invoke_interrupted_mmaps` are permanently le=
aked.
- [High] Premature exposure of the misc device in probe allows uninitialize=
d access, Use-After-Free, and Double Free.
- [High] Concurrent device removal causes a NULL pointer dereference in `fa=
strpc_invoke_send`.
- [High] Potential Use-After-Free of `cctx->remote_heap` after `fastrpc_rpm=
sg_remove` frees it.
- [High] Maps allocated for handle arguments are never freed during context=
 teardown.
- [High] Memory assigned to the DSP hypervisor is returned to the Linux pag=
e allocator without restoring permissions, causing an XPU fault.
- [High] A double free of dmabuf attachments and refcount underflow of `dma=
_buf` occurs in the error path of `fastrpc_map_attach`.
- [Medium] Double allocation of `remote_heap` due to missing synchronizatio=
n.
- [Medium] The channel context refcount is leaked in the error path of `fas=
trpc_device_open`.
--

commit 7b667747a11655158ab5dcea5700acfc6656da6d
Author: Eddie Lin <eddie.lin@oss.qualcomm.com>

misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
   =20
The 'ctx_idr' is initialized but never destroyed when
the channel context is freed, leading to a memory leak.
Add idr_destroy() to properly clean up the IDR resources.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..1a35380a1557a 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
> =20
>  	cctx =3D container_of(ref, struct fastrpc_channel_ctx, refcount);
> =20
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the driver permanently
leak dma buffers moved to invoke_interrupted_mmaps?

In fastrpc_internal_invoke(), buffers are moved to the interrupted list to
prevent them from being freed while the dsp is active:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
    ...
}

However, during device teardown in fastrpc_rpmsg_remove(), the list nodes
are unlinked but the associated memory appears to be abandoned, without
calling fastrpc_buf_free():

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
        list_del(&buf->node);
    ...
}

Could a user space program exhaust system dma memory by repeatedly triggeri=
ng
signals during invocation?

[Severity: High]
This is a pre-existing issue, but does the premature exposure of the misc
device in probe allow uninitialized access or a use-after-free?

In fastrpc_rpmsg_probe(), the misc device is registered before the subseque=
nt
kref_init(&data->refcount) is called:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
    err =3D fastrpc_device_register(rdev, data, true, domain);
    ...
}

If probe subsequently fails, the structure is freed unconditionally without
checking if an open file has taken a reference to it:

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
    kfree(data);
    ...
}

Could a racing userspace open access the uninitialized refcount via
fastrpc_device_open() and continue to issue ioctls against freed memory if
probe aborts?

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent device removal
cause a null pointer dereference?

In fastrpc_invoke_send(), the cctx->rpdev pointer is dereferenced without
holding locks:

drivers/misc/fastrpc.c:fastrpc_invoke_send() {
    ...
    ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
    ...
}

Concurrently, fastrpc_rpmsg_remove() sets cctx->rpdev to null while ioctls
might still be running:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    cctx->rpdev =3D NULL;
    ...
}

Could this cause a kernel panic if user space ioctls run concurrently with a
device unbind or module unload event?

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free of
cctx->remote_heap?

In fastrpc_rpmsg_remove(), the buffer is freed but leaves cctx->remote_heap
as a dangling pointer:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    if (cctx->remote_heap)
        fastrpc_buf_free(cctx->remote_heap);
    ...
}

Lingering open file descriptors can execute
fastrpc_init_create_static_process(), pass the !fl->cctx->remote_heap check,
and dereference the dangling pointer's fields:

drivers/misc/fastrpc.c:fastrpc_init_create_static_process() {
    ...
    pages[0].addr =3D fl->cctx->remote_heap->dma_addr;
    ...
}

Could userspace intentionally hold an open file descriptor after the device
is removed to trigger memory corruption?

[Severity: Medium]
This isn't a bug introduced by this patch, but does missing synchronization
lead to a double allocation of remote_heap?

In fastrpc_init_create_static_process(), the check and allocation are
unsynchronized:

drivers/misc/fastrpc.c:fastrpc_init_create_static_process() {
    ...
    if (!fl->cctx->remote_heap) {
        err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
                                        &fl->cctx->remote_heap);
    ...
}

Can multiple concurrent threads pass the condition and allocate memory
simultaneously, leaking the dma buffer?

[Severity: High]
This is a pre-existing issue, but are maps allocated for handle arguments
abandoned during context teardown?

In fastrpc_create_maps(), maps for handle arguments are created up to
ctx->nscalars (where indices >=3D nbufs represent handle arguments):

drivers/misc/fastrpc.c:fastrpc_create_maps() {
    ...
    else
        err =3D fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
                                 ctx->args[i].length, ctx->args[i].attr,
                                 &ctx->maps[i]);
    ...
}

However, in fastrpc_context_free(), the cleanup loop terminates early at
nbufs instead of nscalars, leaving the attached map pointers:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);
    ...
}

Can userspace continually leak map structures and dma_buf references by
providing handle arguments?

[Severity: High]
This isn't a bug introduced by this patch, but is memory assigned to the
dsp hypervisor returned to the Linux page allocator without restoring
permissions?

In fastrpc_rpmsg_remove(), the remote_heap buffer is freed without reclaimi=
ng
scm permissions:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    if (cctx->remote_heap)
        fastrpc_buf_free(cctx->remote_heap);
    ...
}

Similarly, in fastrpc_req_munmap_impl(), mapped user buffers are freed
without reclaiming scm permissions:

drivers/misc/fastrpc.c:fastrpc_req_munmap_impl() {
    ...
    fastrpc_buf_free(buf);
    ...
}

Will returning memory with stale xpu protections to the system page allocat=
or
cause a system crash via hypervisor access control exceptions?

[Severity: High]
This is a pre-existing issue, but does a double free of dmabuf attachments
and a refcount underflow occur in the error path of fastrpc_map_attach()?

The error path performs manual detach and put operations before handing off
to the standard cleanup function which repeats them since map->table was le=
ft
non-null:

drivers/misc/fastrpc.c:fastrpc_map_attach() {
    ...
map_err:
    dma_buf_detach(map->buf, map->attach);
attach_err:
    dma_buf_put(map->buf);
get_err:
    fastrpc_map_put(map);
    ...
}

If an error occurs after map->table is populated, fastrpc_free_map() execut=
es
its teardown logic and repeats the same dma_buf_detach() and dma_buf_put()
calls on the same pointers.

Does this lead to memory corruption?

[Severity: Medium]
This isn't a bug introduced by this patch, but is the channel context
refcount leaked in the error path of fastrpc_device_open()?

The error path exits early without dropping the cctx reference:

drivers/misc/fastrpc.c:fastrpc_device_open() {
    ...
    if (!fl->sctx) {
        dev_err(&cctx->rpdev->dev, "No session available\n");
        mutex_destroy(&fl->mutex);
        kfree(fl);

        return -EBUSY;
    }
    ...
}

If fastrpc_session_alloc() fails, does the function forget to call
fastrpc_channel_ctx_put() to balance the fastrpc_channel_ctx_get() called
earlier, allowing a user to exhaust the session count and leak references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-fastrpc-cc=
tx-cleanup-v3-1-3a73c2e4ce1a@oss.qualcomm.com?part=3D1
