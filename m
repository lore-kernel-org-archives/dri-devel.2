Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D95C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D823510E758;
	Mon, 13 Jul 2026 06:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mwofq7MZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FC110E758
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9236E40521;
 Mon, 13 Jul 2026 06:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621C81F00A3D;
 Mon, 13 Jul 2026 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922430;
 bh=ZYs3jvy6ixleHAJLLWgrcUaNFuzhdXGpHzAckJdc1LE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mwofq7MZXhnfPKNg7L206lYv8zgZGogRmuLqGY8kZwPZu+pAhBJf2Pd8OLi23XKkh
 MhEA7kHmC3AOYqiLGO+wCav7JIDDzWgmtX5tDOtm5JsisYakOPf1wj5MU1gARSqKDa
 Us0JyCWlFLpy8a2EsXtfUID38HNLcONG08zoMcsbWD4RJdbc/KBhq+wKRRYcx5Szn1
 A7TcDasij0TL1+PpEUqStL5PZeLbGYsneS5u7zRwKhnnfTfHivh4+hJ4jIH4Tpp58r
 j9FddpHrCc9Qg6SJZ8BWI8593vXsjn6R4fGr8MNzQp6757WNwN23WBU0LFOBrMePOE
 s0bZyRo3b+/8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: drop channel context ref on failed open
To: raoxu <raoxu@uniontech.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <DD9C99F155919095+20260713054350.3170620-1-raoxu@uniontech.com>
References: <DD9C99F155919095+20260713054350.3170620-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 06:00:30 +0000
Message-Id: <20260713060030.621C81F00A3D@smtp.kernel.org>
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
- [Critical] Integer overflow in `fastrpc_get_payload_size` leads to a mass=
ive kernel heap buffer overflow during metadata initialization.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition and lockles=
s access to `cctx->rpdev` can lead to NULL pointer dereferences when `fastr=
pc_rpmsg_remove()` runs concurrently.
- [High] Exported DMA buffers retain a pointer to the `fastrpc_user` object=
 (`buf->fl`) without holding a reference, causing a use-after-free if the f=
astrpc device is closed before the DMA buffer.
- [High] Missing locking and reference counting in `fastrpc_req_munmap` lea=
ds to concurrent use-after-free and double-free vulnerabilities.
- [High] Missing reference counting during list traversal in `fastrpc_req_m=
em_unmap_impl` leads to use-after-free.
- [High] The kernel blindly trusts the untrusted DSP to supply a list of FD=
s for unmapping, allowing a malicious DSP payload to force use-after-free c=
onditions.
--

--- Patch [1]: [PATCH] misc: fastrpc: drop channel context ref on failed op=
en ---
commit f86e434afd2dbbcb5bb07286bb0b83dad48769a0
Author: Xu Rao <raoxu@uniontech.com>

misc: fastrpc: drop channel context ref on failed open

This patch drops the channel-context reference on the failed-open path
before freeing the partially initialized fastrpc_user. This prevents
permanently pinning the channel context if session allocation fails.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1671,6 +1671,7 @@ static int fastrpc_device_open(struct inode *inode,=
 struct file *filp)
>  	fl->sctx =3D fastrpc_session_alloc(fl);
>  	if (!fl->sctx) {
>  		dev_err(&cctx->rpdev->dev, "No session available\n");
> +		fastrpc_channel_ctx_put(cctx);
>  		mutex_destroy(&fl->mutex);
>  		kfree(fl);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential race condition. In fastrpc_internal_invoke(), the code
performs a lockless check of rpdev:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (!fl->cctx->rpdev)
        return -EPIPE;
    ...
}

Concurrently, if the device unbinds, fastrpc_rpmsg_remove() sets this to
NULL:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    cctx->rpdev =3D NULL;
    ...
}

The ioctl thread then unconditionally accesses it in fastrpc_invoke_send():

drivers/misc/fastrpc.c:fastrpc_invoke_send() {
    ...
    ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
    ...
}

Could this lead to a NULL pointer dereference if the device unbinds while
an ioctl is in progress?

[Severity: High]
This is a pre-existing issue, but I have a question about DMA buffer
allocation. When exporting a buffer, the allocation function sets the fl
pointer but does not elevate the reference count:

drivers/misc/fastrpc.c:fastrpc_dmabuf_alloc() {
    ...
    err =3D fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, &buf);
    ...
}

If the application closes the fastrpc device first, the fastrpc_user object
is freed. Later, closing the DMA buffer triggers the cleanup callback which
dereferences the freed object:

drivers/misc/fastrpc.c:fastrpc_buf_free() {
    ...
    fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr)
    ...
}

Does this cause a use-after-free if the device file descriptor is closed
before the exported DMA buffer?

[Severity: Critical]
This isn't a bug introduced by this patch, but does the payload size
calculation have an integer overflow? In fastrpc_get_payload_size(), lengths
are accumulated:

drivers/misc/fastrpc.c:fastrpc_get_payload_size() {
    ...
    size +=3D (ctx->olaps[oix].mend - ctx->olaps[oix].mstart);
    ...
}

If a user provides large lengths, could this 64-bit sum wrap around to a
small positive value? The undersized buffer would then be populated using
the larger nscalars count:

drivers/misc/fastrpc.c:fastrpc_get_args() {
    ...
    list =3D fastrpc_invoke_buf_start(rpra, ctx->nscalars);
    pages =3D fastrpc_phy_page_start(list, ctx->nscalars);
    ...
}

Can this lead to a heap buffer overflow during metadata initialization?

[Severity: High]
This is a pre-existing issue, but there appears to be a concurrency problem
during unmapping. In fastrpc_req_munmap(), the lock is dropped without
removing the buffer from the list or taking a reference:

drivers/misc/fastrpc.c:fastrpc_req_munmap() {
    ...
    spin_unlock(&fl->lock);
    ...
}

The implementation then unconditionally deletes and frees the buffer:

drivers/misc/fastrpc.c:fastrpc_req_munmap_impl() {
    ...
    list_del(&buf->node);
    spin_unlock(&fl->lock);
    fastrpc_buf_free(buf);
    ...
}

If two threads concurrently call the munmap ioctl with the same arguments,
could they both find the same buffer and cause list corruption and a
double-free?

[Severity: High]
This isn't a bug introduced by this patch, but a similar reference counting
issue seems to exist in fastrpc_req_mem_unmap_impl(). After finding the map,
the lock is dropped without elevating the reference count:

drivers/misc/fastrpc.c:fastrpc_req_mem_unmap_impl() {
    ...
    spin_unlock(&fl->lock);
    ...
}

The code then accesses map fields and drops a reference it never acquired:

drivers/misc/fastrpc.c:fastrpc_req_mem_unmap_impl() {
    ...
    req_msg.len =3D map->len;
    ...
    fastrpc_map_put(map);
    ...
}

Does this allow concurrent threads to drop the reference count multiple
times, leading to a use-after-free?

[Severity: High]
This is a pre-existing issue, but does the kernel blindly trust file
descriptors provided by the DSP? In fastrpc_put_args(), it reads an array of
FDs from shared memory and arbitrarily drops their references:

drivers/misc/fastrpc.c:fastrpc_put_args() {
    ...
    if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
        fastrpc_map_put(mmap);
    ...
}

Because the lookup is done without taking a reference, the put operation
lowers the active refcount. Can a malicious DSP payload supply arbitrary
active file descriptors and force the kernel to drop their references,
causing a use-after-free for actively used maps?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/DD9C99F155919095+20=
260713054350.3170620-1-raoxu@uniontech.com?part=3D1
