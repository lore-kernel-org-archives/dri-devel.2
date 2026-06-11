Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A57CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ABAE10E781;
	Thu, 11 Jun 2026 09:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AiPadoYV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAC510E781
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:41:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F8D5444EC;
 Thu, 11 Jun 2026 09:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463D51F00893;
 Thu, 11 Jun 2026 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781170899;
 bh=qyfbkf6zF2AbxFQO+wQBKOzV/dbC8xta1A6w9OFHwYA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AiPadoYVTeKbj92m+F7DFF4VE4SGwfPfHRm/13pj2DnElGaT6Ayt7Ft08gorVazV0
 mECrU5oQPQXNpiaNZv0V9oGsdhsGF/hEPaMAcLSnlIuXzrw9L5kwmQEmO428w0kDWT
 to+R99MA/S1VzeTvCUeMvBoMPbR9eutoh0YV0inCpz5jS9KYd+smwfvLQgSEWw/kwg
 /LtrBUcY4im2ZMUeoYjPLslTvauFmxtxzo+q4i2dbC1tgWK9nEEPmx5An6Tr4MtOYr
 dC7e6Qh1x/D6ND256m+1UcqPoyZC6gAqzms49JitvLolKO7pM1BCcX1XJvjf3v+RlW
 xtgP32sZt2MxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
To: "Eddie Lin" <eddie.lin@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
References: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 09:41:38 +0000
Message-Id: <20260611094139.463D51F00893@smtp.kernel.org>
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
- [Critical] Processing duplicate DSP responses for the same context ID cau=
ses refcount underflow and Use-After-Free of the `fastrpc_invoke_ctx`.
- [Critical] Concurrent user calls to unmap ioctls on the same mapping allo=
w multiple threads to operate on the same object without locking, leading t=
o UAF and Double-Free.
- [Critical] A malicious DSP can artificially underflow the reference count=
 of DMA maps by placing duplicate or arbitrary file descriptors in `fdlist`.
- [Critical] Unvalidated `rpra[i].buf.pv` and `rpra[i].buf.len` from shared=
 DSP memory allow arbitrary kernel memory read or overflow.
- [High] Race condition exposing device to userspace before driver initiali=
zation is complete.
- [High] A circular reference permanently leaks `fastrpc_user`, `fastrpc_in=
voke_ctx`, and `fastrpc_channel_ctx` if an invocation times out or is inter=
rupted.
- [High] DMA buffers moved to `invoke_interrupted_mmaps` are never freed, a=
nd list manipulations race without locks.
- [High] Pending invocation contexts and their associated memory mappings a=
re leaked permanently when the rpmsg channel is removed.
- [High] fastrpc_device_open leaks cctx reference when fastrpc_session_allo=
c fails.
--

commit f4af01238585672316982b98df7fba26c048be45
Author: Eddie Lin <eddie.lin@oss.qualcomm.com>

misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free

This commit fixes a memory leak in the fastrpc driver by adding a call to
idr_destroy() in fastrpc_channel_ctx_free(). It ensures that idr resources
are properly cleaned up when the channel context is freed.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f6..7727850e9240d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
> =20
>  	cctx =3D container_of(ref, struct fastrpc_channel_ctx, refcount);
> =20
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_rpmsg_probe()
> 	err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
> 	if (err)
> 		goto err_free_data;
> 	...
> 	kref_init(&data->refcount);

[Severity: High]
This is a pre-existing issue, but does this race condition expose the
device to userspace before driver initialization is complete?

In fastrpc_rpmsg_probe(), fastrpc_device_register() is called before
essential structures like data->refcount, data->lock, and data->ctx_idr
are initialized.

A malicious or early userspace process could immediately open the device,
triggering fastrpc_channel_ctx_get() which performs a kref_get() on an
uninitialized refcount.

When probe continues, it calls kref_init(), unconditionally forcing the
refcount to 1. If userspace then closes the file, the refcount decrements
to 0 and fastrpc_channel_ctx_free() is called, prematurely freeing the
active context while the device is still fully registered.

Additionally, on the probe error path, kfree(data) is called without
respecting early opened file descriptors. Can this sequence cause a
use-after-free for future users?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_internal_invoke()
> 	if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
> 		spin_lock(&fl->lock);
> 		list_del(&ctx->node);
> 		spin_unlock(&fl->lock);
> 		fastrpc_context_put(ctx);
> 	}

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak
the fastrpc_user, fastrpc_invoke_ctx, and fastrpc_channel_ctx objects if
an invocation times out or is interrupted?

If wait_for_completion() returns -ERESTARTSYS or -ETIMEDOUT, this code
explicitly skips calling fastrpc_context_put(). Because the context is
never freed, its reference to the user is never dropped.

When the application closes the file descriptor, the user refcount remains
greater than zero.

Does this prevent fastrpc_user_free() from running to clean up the pending
list, permanently leaking the circular dependency?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_internal_invoke()
> 	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> 		list_del(&buf->node);
> 		list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> 	}

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_rpmsg_remove()
> 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
> 		list_del(&buf->node);

[Severity: High]
This is a pre-existing issue, but are the dma buffers moved to
invoke_interrupted_mmaps ever freed, and do list manipulations race
without locks?

When fastrpc_internal_invoke() is interrupted, it iterates over all user
mmaps, unlinks them, and moves them to invoke_interrupted_mmaps. This
manipulation appears to happen without holding fl->lock or cctx->lock.

When the channel is removed in fastrpc_rpmsg_remove(), the code
iterates over invoke_interrupted_mmaps and unlinks nodes without ever
calling fastrpc_buf_free().

Does this result in a permanent memory leak of all user dma buffers that
were mapped when an interruption occurred?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_rpmsg_callback()
> 	schedule_work(&ctx->put_work);

[Severity: Critical]
This is a pre-existing issue, but does processing duplicate remote processor
responses for the same context ID cause a refcount underflow?

In fastrpc_rpmsg_callback(), the context is looked up by ctxid using
idr_find(). The callback immediately schedules ctx->put_work without
verifying if a response has already been processed.

If a compromised or faulty remote processor sends multiple responses with
the same ctxid, schedule_work() can be called multiple times. Because
process_one_work() clears the pending flag before executing, the work
can be re-queued and executed multiple times.

Each execution drops a reference via fastrpc_context_put(), leading to
a refcount underflow. Could this cause a use-after-free when the user
thread or subsequent operations access the freed context?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_notify_users()
> 	ctx->retval =3D -EPIPE;
> 	complete(&ctx->work);

[Severity: High]
This is a pre-existing issue, but are pending invocation contexts and their
associated memory mappings permanently leaked when the rpmsg channel is
removed?

When sending a message to the remote processor, fastrpc_invoke_send() takes
an extra reference on the fastrpc_invoke_ctx specifically to keep it alive
for the asynchronous response. Normally, fastrpc_rpmsg_callback() drops thi=
s.

If the remote processor crashes or the rpmsg channel goes away,
fastrpc_rpmsg_remove() completes ctx->work with an error. This unblocks the
waiting user threads, which drop their original reference and return to
userspace.

Because the channel is gone, the callback will never run, and the extra
reference taken by fastrpc_invoke_send() is never dropped. Does this mean
the fastrpc_invoke_ctx and all its associated buffers leak forever?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_req_munmap()
> 	spin_lock(&fl->lock);
> 	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
> 		if ((iter->raddr =3D=3D req.vaddrout) && (iter->size =3D=3D req.size)) {
> 			buf =3D iter;
> 			break;
> 		}
> 	}
> 	spin_unlock(&fl->lock);

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_req_mem_unmap_impl()
> 	spin_unlock(&fl->lock);

[Severity: Critical]
This is a pre-existing issue, but do concurrent user calls to unmap ioctls
on the same mapping allow multiple threads to operate on the same object
without locking?

In fastrpc_req_mem_unmap_impl() and fastrpc_req_munmap(), the driver looks
up the mapping object from a list while holding fl->lock. Once found, it
unlocks the spinlock without taking a reference count or removing the
object from the list.

Two concurrent unmap ioctls on the same file descriptor and address will
both find the same object, drop the lock, and race through the rest of
the function.

Both threads could attempt to free it via fastrpc_map_put() or
fastrpc_buf_free(). Can this result in a use-after-free followed by a
double-free and list corruption?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_put_args()
> 	if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> 		fastrpc_map_put(mmap);

[Severity: Critical]
This is a pre-existing issue, but can a malicious remote processor
artificially underflow the reference count of dma maps by placing duplicate
or arbitrary file descriptors in fdlist?

The kernel processes an array of file descriptors written by the remote
processor into a shared dma buffer. For each non-zero fd, the kernel looks
up the corresponding map and directly calls fastrpc_map_put() to drop a
reference.

If the remote processor populates fdlist with the same fd multiple times,
the kernel will perform multiple unchecked fastrpc_map_put() calls.

Could this decrement the refcount below expected values and free the map
prematurely while the kernel or user still uses it, causing a
use-after-free?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_device_open()
> 	if (!fl->sctx) {
> 		dev_err(&cctx->rpdev->dev, "No session available\n");
> 		mutex_destroy(&fl->mutex);
> 		kfree(fl);
>=20
> 		return -EBUSY;
> 	}

[Severity: High]
This is a pre-existing issue, but does fastrpc_device_open() leak the
cctx reference when fastrpc_session_alloc() fails?

The channel context reference is acquired via fastrpc_channel_ctx_get().
If fastrpc_session_alloc() fails, the code jumps into an error path that
destroys the mutex and frees fl, but returns -EBUSY without dropping
the cctx reference.

Does this inflate the refcount permanently, meaning the channel context
and its idr will never be freed when the device is unbound?

[ ... ]

> drivers/misc/fastrpc.c:fastrpc_put_args()
> 	void *src =3D (void *)(uintptr_t)rpra[i].buf.pv;
> 	void *dst =3D (void *)(uintptr_t)ctx->args[i].ptr;
> 	u64 len =3D rpra[i].buf.len;
>=20
> 	if (!kernel) {
> 		if (copy_to_user((void __user *)dst, src, len)) {

[Severity: Critical]
This is a pre-existing issue, but do unvalidated rpra[i].buf.pv and
rpra[i].buf.len from shared memory allow arbitrary kernel memory reads
or overflows?

The source pointer and length are read directly from rpra[i].buf, which
resides in a shared dma buffer. The remote processor has full write access
to this buffer.

The host driver does not appear to validate that the length is bounded
by the originally trusted ctx->args[i].length or that pv points within
the legitimate dma bounds.

Since these untrusted values are passed to copy_to_user() or memcpy(),
can a malicious remote processor use this to leak arbitrary kernel memory
to user space or cause a kernel buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-fastrpc-cc=
tx-cleanup-v1-1-28097444116c@oss.qualcomm.com?part=3D1
