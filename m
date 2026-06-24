Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399BBCDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7539B10E0FB;
	Wed, 24 Jun 2026 19:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ovff4OMA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A428C10E0FB
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:39:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F1FC405A0;
 Wed, 24 Jun 2026 19:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A75A1F000E9;
 Wed, 24 Jun 2026 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782329981;
 bh=vmVzPjF4tUjBj724pVUzzq3C6uTqkzYiTsNeMd8aBrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ovff4OMAmfpSMHJzS+8GgtsnujBAUcu4H7YRCYlgXCH39Q2iIy8bSXHDS9dxl1fPJ
 2nla6qyYe9pjtun3ZrBnKRqzUX5utkVnN6q1hwC4L3N5mJg4tonLbu6x6ou2yXTUFw
 v5WpiTCL9pPXDJUp8QTcUPnLlk/JG8ljv7M2a+C+EwlU+qpW9X38MPeQqFCe1xMvUs
 wGU1wAsTHbATfP8+u0IReJ9VdIkwgVEBZDr3RikK3dSmivZx4LplJ8UNsDFeMCKNWd
 gNBaVIflkHHqpc8Axe8PpHViQpNdYCjGdC1lnRXvA6T7TZrIf8nJnuRjx4q8niu0ix
 UpwWf5myAusQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: drop invoke context on interrupted waits
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624192554.5172-1-alhouseenyousef@gmail.com>
References: <20260624192554.5172-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:39:40 +0000
Message-Id: <20260624193941.0A75A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The fastrpc driver is vulnerable to a use-after-free or double=
 free if the DSP sends multiple responses for the same context ID.
- [High] Iterating and modifying `fl->mmaps` and `cctx->invoke_interrupted_=
mmaps` without locks on the error path causes severe list corruption.
- [High] Buffers moved to `cctx->invoke_interrupted_mmaps` on `-ERESTARTSYS=
` are never freed, causing a permanent memory leak of DMA buffers and mappi=
ngs.
- [High] Pending contexts and their associated `fastrpc_user` structures ar=
e permanently leaked if the DSP crashes or the rpmsg channel is removed.
- [High] `fastrpc_invoke_send` accesses `cctx->rpdev->ept` without synchron=
ization, leading to a NULL pointer dereference if the rpmsg channel is remo=
ved concurrently.
- [High] `fastrpc_context_free` leaks `fastrpc_map` structures and dma-buf =
references for handle arguments.
- [Medium] The `ctx_idr` initialized for each channel context is never dest=
royed, leaking internal radix tree memory.
--

commit 987838af3ff819b971471dae5de97f93f9b3abb9
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: drop invoke context on interrupted waits

This patch modifies fastrpc_internal_invoke() to remove the context from the
pending list and drop the caller reference on all exits, including interrup=
ted
waits and timeouts. This ensures that contexts aren't pinned for the lifeti=
me
of the file when userspace is interrupted.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
>  	if (err =3D=3D -ERESTARTSYS) {
>  		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
[Severity: High]
This is a pre-existing issue, but does iterating and modifying fl->mmaps
without holding fl->lock race with concurrent mmap operations?

It appears another thread could be adding or removing mmaps concurrently us=
ing
spin_lock(&fl->lock), which might corrupt the list during this traversal.

>  			list_del(&buf->node);
>  			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
[Severity: High]
This is a pre-existing issue, but are the buffers moved to
cctx->invoke_interrupted_mmaps ever actually freed?

Looking at fastrpc_rpmsg_remove() in drivers/misc/fastrpc.c, the nodes are
deleted from the list during teardown, but fastrpc_buf_free() is never call=
ed
on them:

fastrpc_rpmsg_remove() {
    ...
    list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
        list_del(&buf->node);
    ...
}

Could this permanently leak the pinned DMA buffers and mapping structures if
userspace sends signals to interrupt an ongoing RPC invocation?

>  		}
>  	}
[ ... ]

While reviewing the context management in this driver, I noticed a few other
pre-existing issues:

[Severity: High]
This is a pre-existing issue, but how is the reference count for the remote
DSP handled if the channel is removed?

In fastrpc_invoke_send(), a reference is taken before sending the message:

fastrpc_invoke_send() {
    ...
    fastrpc_context_get(ctx);
    ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
    ...
}

If the DSP crashes and fastrpc_notify_users() wakes up waiters to abort:

fastrpc_notify_users() {
    ...
    ctx->retval =3D -EPIPE;
    complete(&ctx->work);
    ...
}

It doesn't seem to drop the reference count acquired for the remote DSP. Wi=
ll
this permanently pin the context and its associated fastrpc_user structures?


[Severity: Critical]
This is a pre-existing issue, but what happens if the remote DSP sends
multiple responses for the same context ID?

When a reply is received, fastrpc_rpmsg_callback() queues work:

fastrpc_rpmsg_callback() {
    ...
    schedule_work(&ctx->put_work);
    ...
}

Since the context is not removed from the IDR tree upon the first reply, a
duplicate response would queue put_work again. Could this artificially drop
the refcount to zero and lead to a use-after-free if the context is freed
while the original caller is still accessing it?


[Severity: High]
This is a pre-existing issue, but is cctx->rpdev adequately protected again=
st
concurrent removal?

During teardown, fastrpc_rpmsg_remove() clears the pointer:

fastrpc_rpmsg_remove() {
    ...
    spin_lock_irqsave(&cctx->lock, flags);
    cctx->rpdev =3D NULL;
    ...
}

However, fastrpc_invoke_send() accesses the endpoint without synchronizatio=
n:

fastrpc_invoke_send() {
    ...
    ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
    ...
}

Can this result in a NULL pointer dereference if the rpmsg channel is unbou=
nd
concurrently?


[Severity: Medium]
This is a pre-existing issue, but is the IDR tree properly cleaned up when
freeing the channel context?

fastrpc_channel_ctx_free() {
    ...
    kfree(cctx);
    ...
}

It frees the cctx structure without calling idr_destroy(&cctx->ctx_idr). Do=
es
this leave the internal radix tree memory allocated?


[Severity: High]
This is a pre-existing issue, but does fastrpc_context_free() fail to relea=
se
all dma-buf references for handle arguments?

fastrpc_context_free() {
    ...
    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);
    ...
}

The loop iterates up to ctx->nbufs. If userspace invokes an RPC call with
handle arguments where ctx->nscalars is greater than ctx->nbufs, does this
loop abandon the maps stored at the higher indices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624192554.5172=
-1-alhouseenyousef@gmail.com?part=3D1
