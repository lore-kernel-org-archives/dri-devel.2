Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B10CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E71B10E0FD;
	Wed, 24 Jun 2026 19:41:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZYplya1/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8847C10E0FD
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:41:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F77941A36;
 Wed, 24 Jun 2026 19:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269161F000E9;
 Wed, 24 Jun 2026 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782330063;
 bh=6od0YbyGD4/8Wlo2Tr+MeHi7I1O4uX8cyY5u3Q7dkT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZYplya1/nfoKbB/tKN5JDKh87A0UaZtO2Kg+6nFFRVRlrteWgVUpZTcF8oVXq3632
 vu94A/oc6I+V66sCycBQsHPzKjyq4L7F9hvM6Du+6MiPfVw83SPJtP9DBuvCB6AYTf
 8+H37xFtUQVqtNAb803BXKunzSxeXJh7cU91crpFHWNxdu3EMhyGH5O45KqLo9bSgI
 Ha0Ni3lValCvgNj2518J1iydFgTwYp5yPwVng7QXO8As36Qp7fVg8TAuN/MY/fichM
 56+kuNG84C1VPdofI69dgY5mBxjQjGSjnUcEK36Wn2ax8hWQcdnX8LVjSdJA3xAoBx
 doG7i4snN+r2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: exclude mapped buffers from inline overlaps
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624192309.4723-1-alhouseenyousef@gmail.com>
References: <20260624192309.4723-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:41:02 +0000
Message-Id: <20260624194103.269161F000E9@smtp.kernel.org>
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
- [Critical] Integer truncation in `__fastrpc_buf_alloc` allows out-of-boun=
ds DMA access.
- [Critical] Use-After-Free and Double Free in `fastrpc_map_attach` error p=
ath.
- [Critical] Integer truncation of `mlen` allows kernel buffer overflow via=
 `copy_from_user`.
- [High] Memory leak of `struct fastrpc_map` for handles during context cle=
anup.
- [High] Circular reference leak when `fastrpc_internal_invoke` is interrup=
ted.
--

commit a1f9ba556dd9f43a1a5e5fbad752e8ca90d62449
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: misc: fastrpc: exclude mapped buffers from inline overlaps

This commit modifies fastrpc_get_buff_overlaps() to ignore mapped buffers w=
hen
computing overlap offsets. It ensures that only buffers without a file
descriptor are serialized into the inline DMA payload. This prevents the
serializer from deriving negative offsets and writing to unreserved memory.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..79b428addf062 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does passing the 64-bit buf->size to the=
=20
size_t argument of dma_alloc_coherent() result in truncation on 32-bit=20
architectures?

drivers/misc/fastrpc.c:__fastrpc_buf_alloc() {
    ...
    buf->virt =3D dma_alloc_coherent(dev, buf->size, &buf->dma_addr, GFP_KE=
RNEL);
    ...
}

Could this cause an out-of-bounds DMA access when the untruncated 64-bit si=
ze=20
is sent to the DSP here?

drivers/misc/fastrpc.c:fastrpc_invoke_send() {
    ...
    msg->size =3D roundup(ctx->msg_sz, PAGE_SIZE);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this allocation lack a corresponding=
=20
cleanup path for handles?

drivers/misc/fastrpc.c:fastrpc_create_maps() {
    ...
    else
        err =3D fastrpc_map_attach(ctx->fl, ctx->args[i].fd, ctx->args[i].l=
ength, ctx->args[i].attr, &ctx->maps[i]);
    ...
}

The cleanup loop in fastrpc_context_free() terminates prematurely at ctx->n=
bufs:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);
    ...
}

Does this fail to drop references for mappings populated up to ctx->nscalar=
s,=20
resulting in a memory leak of struct fastrpc_map?

[Severity: High]
This is a pre-existing issue, but does this create a circular reference if =
the=20
context is not freed?

drivers/misc/fastrpc.c:fastrpc_context_alloc() {
    ...
    /* Take a reference to user, released in fastrpc_context_free() */
    fastrpc_user_get(user);
    ...
}

Looking at the error path for -ERESTARTSYS, it bypasses context cleanup:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
        spin_lock(&fl->lock);
        list_del(&ctx->node);
        spin_unlock(&fl->lock);
        fastrpc_context_put(ctx);
    }
    ...
}

If interrupted, does this strand the context with its elevated refcount and=
 leak=20
the fastrpc_invoke_ctx and fastrpc_user resources?

[Severity: Critical]
This is a pre-existing issue, but the error path manually detaches and puts=
 the=20
buffer, then drops the map reference:

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

Does fastrpc_free_map() then execute its own cleanup block because map->tab=
le=20
is non-NULL?

drivers/misc/fastrpc.c:fastrpc_free_map() {
    ...
    if (map->table) {
        // ...
        dma_buf_unmap_attachment_unlocked(map->attach, map->table, DMA_BIDI=
RECTIONAL);
        dma_buf_detach(map->buf, map->attach);
        dma_buf_put(map->buf);
    }
    ...
}

Could this lead to a use-after-free and double free of the dma_buf_attachme=
nt?

[Severity: Critical]
This is a pre-existing issue, but does assigning the 64-bit difference to t=
he=20
32-bit int mlen silently truncate the value?

drivers/misc/fastrpc.c:fastrpc_get_args() {
    ...
    for (oix =3D 0; oix < ctx->nbufs; ++oix) {
        int mlen;
        // ...
        mlen =3D ctx->olaps[oix].mend - ctx->olaps[oix].mstart;
    ...
}

Can this truncation cause validation checks to fail and pointer arithmetic =
to=20
underflow, allowing an out-of-bounds write during copy_from_user?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624192309.4723=
-1-alhouseenyousef@gmail.com?part=3D1
