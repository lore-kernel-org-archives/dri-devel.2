Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F67BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A92410E551;
	Mon, 13 Jul 2026 05:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ScJeTJNk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C03A510E54C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:37:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A57760018;
 Mon, 13 Jul 2026 05:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6371F000E9;
 Mon, 13 Jul 2026 05:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783921047;
 bh=Sj2VBksojtUm013vrglosf48q9qrA3CKKcqMcU706/A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ScJeTJNk1pD+RdynhVr8qNAW//IojBtbGVCTFhWq/oqpBVsB4q00jGmPVuOZt88cx
 R7NeLDJySaTrA/HcR9gNU03GkJghW64kIu7AqTE8fi45VeZrNzH5+sufCWvSvAXABc
 TY/QggZ26279lKvvejbtvS8gB7ef3Z6vKkIxW2jHlAaApi7qdtr5rOss/PUJVNs9he
 VT+IVChDEeG8w1FvMeQFfPKqRdL14CiAGStbVftlDiHZr/UcA7PWNwCovHCV8Ksx9g
 KgnL8+PW1IlN4IL/QV1y9Agx85UNZa96rkbaD71oKPOb6O7iUUw60SgVhFiIfES9Yw
 9jqIK94CnsrdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/4] misc: fastrpc: Expand context ID mask for DSP
 polling mode support
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713052236.3033744-4-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
 <20260713052236.3033744-4-ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:37:27 +0000
Message-Id: <20260713053727.AB6371F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Circular reference between fastrpc_user and fastrpc_invoke_ctx lea=
ds to permanent memory leak on interrupted invokes
- [High] IDR lookup without reference count acquisition in fastrpc_rpmsg_ca=
llback leads to Use-After-Free
- [High] DMA buffers moved to invoke_interrupted_mmaps are permanently leak=
ed
- [High] DSP's reference count on fastrpc_invoke_ctx is never dropped durin=
g rpmsg device removal
- [High] fastrpc_invoke_ctx is exposed to IDR before its refcount is initia=
lized
--

--- Patch [3]: [PATCH v13 3/4] misc: fastrpc: Expand context ID mask for DS=
P polling mode support ---
commit 3f54bd616159b6758a0a91f71a64fbcdf225579a
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Expand context ID mask for DSP polling mode support

Current FastRPC context uses a 12-bit mask for context ID and PD type.
This expands it to a 16-bit layout for DSP polling mode support, ensuring
the async mode bit doesn't overlap with odd context IDs.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 41c2ec0bc6281..78bd5b8f67f85 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -38,7 +38,7 @@
>  #define FASTRPC_CTX_MAX (256)
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> -#define FASTRPC_CTXID_MASK GENMASK(11, 4)
> +#define FASTRPC_CTXID_MASK GENMASK(15, 8)

[Severity: High]
This isn't a bug introduced by this patch, but seeing the context ID mask
update prompted me to look at how the IDR handles contexts, and I noticed a
potential circular reference.

Looking at fastrpc_internal_invoke(), if an RPC invoke is interrupted
(-ERESTARTSYS) or times out, it skips dropping the context's initial refere=
nce
and leaves it in fl->pending indefinitely:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (err =3D=3D -ERESTARTSYS) {
    ...
}

However, ctx holds a strong reference to the fastrpc_user object (fl) creat=
ed
in fastrpc_context_alloc():

drivers/misc/fastrpc.c:fastrpc_context_alloc() {
    ...
    /* Take a reference to user, released in fastrpc_context_free() */
    fastrpc_user_get(user);
    ...
}

Does this create a circular reference where fl's refcount can never reach 0,
meaning fastrpc_user_free() is never called to clean up the abandoned conte=
xts?

Can this be triggered by userspace sending a signal to a waiting thread?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential Use-After-Free
race condition regarding the context IDR.

In fastrpc_rpmsg_callback(), the context is retrieved without acquiring a
reference count (e.g., using kref_get_unless_zero) before dropping the lock:

drivers/misc/fastrpc.c:fastrpc_rpmsg_callback() {
    ...
    spin_lock_irqsave(&cctx->lock, flags);
    ctx =3D idr_find(&cctx->ctx_idr, ctxid);
    spin_unlock_irqrestore(&cctx->lock, flags);
    ...
}

If the context's refcount concurrently reaches zero, fastrpc_context_free()=
 is
called, but the object is removed from the IDR relatively late, after freei=
ng
buffers:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
    spin_lock_irqsave(&cctx->lock, flags);
    idr_remove(&cctx->ctx_idr, FIELD_GET(FASTRPC_CTXID_MASK, ctx->ctxid));
    spin_unlock_irqrestore(&cctx->lock, flags);
    ...
}

Is there a wide race window here where a duplicate or delayed DSP response
could find the context in the IDR, and then write to ctx->retval or schedul=
e a
work item on the freed object?

[Severity: High]
This isn't a bug introduced by this patch, but do the DMA buffers moved to
invoke_interrupted_mmaps get permanently leaked?

When fastrpc_internal_invoke() is interrupted by a signal, buffers are moved
to the interrupted list:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
            list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
    ...
}

But when the DSP channel is closed or crashes, fastrpc_rpmsg_remove() itera=
tes
over this list and removes the nodes without calling fastrpc_buf_free():

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
        list_del(&buf->node);
    ...
}

Are these memory map buffers deliberately dropped, or is this leaking the
underlying kernel DMA memory?

[Severity: High]
This is a pre-existing issue, but is the DSP's outstanding reference count =
on
fastrpc_invoke_ctx ever dropped during rpmsg device removal?

If the DSP crashes and fastrpc_rpmsg_remove() runs, it unblocks waiting thr=
eads
by setting -EPIPE and signaling completions:

drivers/misc/fastrpc.c:fastrpc_notify_users() {
    ...
        ctx->retval =3D -EPIPE;
        complete(&ctx->work);
    ...
}

Previously, fastrpc_invoke_send() acquired a strong reference on ctx on
behalf of the DSP, which is normally dropped by fastrpc_rpmsg_callback() wh=
en
the DSP replies.

Does setting the completion here without dropping that reference leave the
contexts with a non-zero refcount forever?

[Severity: High]
This isn't a bug introduced by this patch, but could fastrpc_invoke_ctx be
exposed to the IDR before its refcount is initialized?

In fastrpc_context_alloc(), the ctx is inserted into the IDR and the lock is
dropped before initializing the refcount:

drivers/misc/fastrpc.c:fastrpc_context_alloc() {
    ...
    spin_unlock_irqrestore(&cctx->lock, flags);

    kref_init(&ctx->refcount);
    ...
}

Could a compromised DSP send a duplicate response matching this newly recyc=
led
ID, triggering fastrpc_rpmsg_callback() to look up the ID, schedule put_wor=
k,
and decrement the uninitialized zero refcount (from kzalloc) before the
allocation thread initializes it to 1?

>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713052236.3033=
744-1-ekansh.gupta@oss.qualcomm.com?part=3D3
