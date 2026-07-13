Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBAAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B5D10E550;
	Mon, 13 Jul 2026 05:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cMfD4Ogd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B36A10E550
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A539743885;
 Mon, 13 Jul 2026 05:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614671F00ADF;
 Mon, 13 Jul 2026 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783921053;
 bh=eqFgyyKBSaS/V5Vt1oSRFckxJIyWTMdq3T7WXSFjMfk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cMfD4OgdagxBCvWF7vjCdTSc0ZAMqlwIE4f+NzQsZE9bL//TEB/t0FmXK6DWHpE79
 Y23AYW6MPdwWeNesQoSC5LkQZVGmucvA3X9huIpxfSUyrGsy8X2f7tWX2QuGpSHxX8
 +xF8v1kqa6ZMIDFQnUN515y0fuZTp0wIyxYdkF1h9+tP49sM12WTpdCT8OLtB7otSw
 tAxgKwUz2ZgZNq9XgT72nQWoC5haqXQ/owY3TXn06/oqGkCHn8ZLhglozwghJxoC/q
 O5p6kDFsTliz3YoZMEZtU/XHp+ggMRLwg3xGVRrbKx4/QQ2kCp5/NeQ6nP/yoVxs0+
 cUpHhYHbrsPqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/4] misc: fastrpc: Replace hardcoded ctxid mask
 with GENMASK
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713052236.3033744-3-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
 <20260713052236.3033744-3-ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:37:33 +0000
Message-Id: <20260713053733.614671F00ADF@smtp.kernel.org>
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
- [Low] The patch uses `FIELD_PREP` and `FIELD_GET` macros which are define=
d in `<linux/bitfield.h>`, but incorrectly includes `<linux/bitops.h>` inst=
ead.

Pre-existing issues:
- [Critical] Circular reference in `fastrpc_internal_invoke` leaks contexts=
, DMA memory, and IDR slots on `-ERESTARTSYS`, leading to a system-wide Den=
ial of Service.
- [High] Failure in `copy_to_user` during `fastrpc_req_mmap` leaves a freed=
 buffer on the `fl->mmaps` list.
- [High] Concurrent allocations of `fl->cctx->remote_heap` lack locking, le=
ading to UAF and memory leaks.
- [High] fastrpc_rpmsg_callback dereferences ctx without taking a reference=
, leading to a race condition and UAF.
--

--- Patch [2]: [PATCH v13 2/4] misc: fastrpc: Replace hardcoded ctxid mask =
with GENMASK ---
commit e84380d211cbe45ae646449f6efb6a5a3e342fcc
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Replace hardcoded ctxid mask with GENMASK

The commit replaces the hardcoded 0xFF0 mask with GENMASK(11, 4) for context
ID extraction to follow bitfield conventions. It uses FIELD_PREP and FIELD_=
GET
macros instead of manual shifts.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 02c2765e1188c..41c2ec0bc6281 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -23,6 +23,7 @@
>  #include <uapi/misc/fastrpc.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>

[Severity: Low]
Should this code include <linux/bitfield.h> instead of <linux/bitops.h>?

The FIELD_PREP and FIELD_GET macros are defined in <linux/bitfield.h>. Not
including the proper header may cause compilation failures on architectures
that do not transitively include it.

[ ... ]

> @@ -2547,7 +2548,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_devi=
ce *rpdev, void *data,
>  	if (!cctx)
>  		return -ENODEV;
> =20
> -	ctxid =3D ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> +	ctxid =3D FIELD_GET(FASTRPC_CTXID_MASK, rsp->ctx);
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	ctx =3D idr_find(&cctx->ctx_idr, ctxid);

[Severity: High]
This isn't a bug introduced by this patch, but could fastrpc_rpmsg_callback=
()=20
dereference ctx without taking a reference here?

If a duplicate or late response is received, the first reply schedules
ctx->put_work which invokes fastrpc_context_free(). If a second reply's
IDR lookup occurs right before fastrpc_context_free() removes it from the
IDR, it might yield a pointer that gets freed immediately after the lock
is dropped:

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
	complete(&ctx->work);
    ...
}

Writing to ctx->retval and calling complete() would then operate on freed m=
emory.
Should kref_get_unless_zero() be used before dropping the lock?

[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a circular reference
regression on -ERESTARTSYS in fastrpc_internal_invoke()?

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
	if (kernel) {
		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
			err =3D -ETIMEDOUT;
	} else {
		err =3D wait_for_completion_interruptible(&ctx->work);
	}

	if (err)
		goto bail;
    ...
bail:
	if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
		/* We are done with this compute context */
		spin_lock(&fl->lock);
		list_del(&ctx->node);
		spin_unlock(&fl->lock);
		fastrpc_context_put(ctx);
	}
    ...
}

If a user interrupts FASTRPC_IOCTL_INVOKE with a signal, err becomes=20
-ERESTARTSYS. The context is left on fl->pending without calling
fastrpc_context_put(ctx). Since ctx holds a reference to fl, fl->refcount
will never reach 0 on device close, permanently leaking contexts and DMA
memory. Can this be used to exhaust IDR slots?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but what happens in
fastrpc_req_mmap() if copy_to_user() fails after the buffer is added to
fl->mmaps?

drivers/misc/fastrpc.c:fastrpc_req_mmap() {
    ...
	spin_lock(&fl->lock);
	list_add_tail(&buf->node, &fl->mmaps);
	spin_unlock(&fl->lock);

	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
		err =3D -EFAULT;
		goto err_assign;
	}
    ...
err_assign:
	fastrpc_req_munmap_impl(fl, buf);

	return err;
}

The fastrpc_req_munmap_impl() function frees the buffer, but it remains lin=
ked
on fl->mmaps. When the user closes the device, fastrpc_user_free() iterates
over fl->mmaps and could double-free this buffer. Should the buffer be remo=
ved
from the list before returning?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but are concurrent allocations of
remote_heap safely handled in fastrpc_init_create_static_process()?

drivers/misc/fastrpc.c:fastrpc_init_create_static_process() {
    ...
	if (!fl->cctx->remote_heap) {
		err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
						&fl->cctx->remote_heap);
		if (err)
			goto err_name;
    ...
}

If two threads concurrently call FASTRPC_IOCTL_INIT_CREATE_STATIC, both mig=
ht=20
observe !fl->cctx->remote_heap as true and call fastrpc_remote_heap_alloc()=
,=20
overwriting the shared pointer and leaking the first allocation. Could this=
=20
also lead to a use-after-free if one thread branches to err_map and frees=20
fl->cctx->remote_heap while the other thread is using it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713052236.3033=
744-1-ekansh.gupta@oss.qualcomm.com?part=3D2
