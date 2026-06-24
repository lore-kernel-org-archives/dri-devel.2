Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACD5CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA9410E0E2;
	Wed, 24 Jun 2026 18:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F9a0soq6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5D710E0E2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 18:00:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 649324074B;
 Wed, 24 Jun 2026 18:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256871F000E9;
 Wed, 24 Jun 2026 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782324039;
 bh=TojP5aZhgq4h5n6WyWN7mbPcgecv3v3oIctG7adxRIA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F9a0soq6iByt8Uy+OgbVDG0VyWIuVBIUuxiSYS6T7UV/lMXvrTYf1BiwkoqYH9cfN
 Huwx4PtjzSYUwH4jpNqDCCGIEwxldKRUIDV6yy0wC9+lxS/PtL+uPvhhYJhcAxnWaY
 yE463XqxqCvt3kPF+VkD613RFtkMmsF6139YeZ91mXiqukVB8MVC+U6avpu5kUioo3
 oYFzDd5tfl6Wj8eEG2KgNnqvt9hVVOEG7QchaN0M3f+04NGIxoRsBUaHp3np7WxGu+
 Y6p8tPk9EBwxiFX+qHeqVVn1ijNuKU/nBcKbr2ybXkaVGod79Ao1Ivfih8v0twxsZ9
 5J9p33eMHc5iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: reject overflowing invoke buffer ranges
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624174410.6074-1-alhouseenyousef@gmail.com>
References: <20260624174410.6074-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 18:00:38 +0000
Message-Id: <20260624180039.256871F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The kernel trusts pointer and length values read directly from=
 the DSP-shared DMA buffer, allowing an arbitrary kernel read/write vulnera=
bility.
- [High] Context is published to the IDR before its refcount is initialized=
, allowing a concurrent DSP callback to trigger a Use-After-Free.
- [High] `cctx->rpdev` is read locklessly after an initial check, leading t=
o a NULL pointer dereference if `fastrpc_rpmsg_remove` runs concurrently.
- [High] Integer truncation of `mlen` breaks buffer serialization and leads=
 to DMA memory corruption.
--

commit 00821efcac58f87521dc0b1c609d5329a9afc752
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: reject overflowing invoke buffer ranges

This commit adds an overflow check to fastrpc_get_buff_overlaps(). It
verifies that adding the buffer length to its start address does not
overflow, returning -EOVERFLOW if it does. This prevents the use of
wrapped end addresses that could misstate payload sizes or feed invalid
ranges into invoke metadata.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..ba4ade8747833 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -675,7 +681,13 @@ static struct fastrpc_invoke_ctx *fastrpc_context_al=
loc(
>  			return ERR_PTR(-ENOMEM);
>  		}
>  		ctx->args =3D args;
> -		fastrpc_get_buff_overlaps(ctx);
> +		ret =3D fastrpc_get_buff_overlaps(ctx);
> +		if (ret) {
> +			kfree(ctx->olaps);
> +			kfree(ctx->maps);
> +			kfree(ctx);
> +			return ERR_PTR(ret);
> +		}
>  	}
> =20
>  	/* Released in fastrpc_context_put() */

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying
fastrpc_context_alloc(), could the context be published to the IDR
before it is fully initialized?

Further down in this function, the context is published:

	ret =3D idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
			       FASTRPC_CTX_MAX, GFP_ATOMIC);

But the reference count is initialized later:

	kref_init(&ctx->refcount);

If an asynchronous callback like fastrpc_rpmsg_callback() retrieves this
newly published context from the IDR and drops its reference, could it
free the context before kref_init() executes, leading to a
use-after-free?


[Severity: High]
This is a pre-existing issue, but looking at fastrpc_internal_invoke(),
is there a lockless check that could lead to a NULL pointer dereference?

	if (!fl->cctx->rpdev)
		return -EPIPE;

If this check passes, and a concurrent device unbind clears the pointer
in fastrpc_rpmsg_remove() under a spinlock:

	spin_lock_irqsave(&cctx->lock, flags);
	cctx->rpdev =3D NULL;
	...
	spin_unlock_irqrestore(&cctx->lock, flags);

Could the invocation thread then dereference the NULL pointer when it
calls fastrpc_invoke_send()?

	ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));


[Severity: Critical]
This is a pre-existing issue, but does fastrpc_put_args() trust pointers
and lengths read directly from the DSP-shared DMA buffer without
validation?

In fastrpc_put_args():

			void *src =3D (void *)(uintptr_t)rpra[i].buf.pv;
			void *dst =3D (void *)(uintptr_t)ctx->args[i].ptr;
			u64 len =3D rpra[i].buf.len;

			if (!kernel) {
				if (copy_to_user((void __user *)dst, src, len)) {

If a compromised DSP supplies arbitrary addresses in this shared region,
could this result in an arbitrary kernel read or write?


[Severity: High]
This is a pre-existing issue, but does fastrpc_get_args() truncate the
64-bit overlap size into a 32-bit signed integer?

	for (oix =3D 0; oix < ctx->nbufs; ++oix) {
		int mlen;
		...
			mlen =3D ctx->olaps[oix].mend - ctx->olaps[oix].mstart;

			if (rlen < mlen)
				goto bail;

			rpra[i].buf.pv =3D args - ctx->olaps[oix].offset;
			...
			args =3D args + mlen;

If the overlap exceeds 2GB, mlen could truncate to a negative value or a
small positive value. Could this cause unsigned promotion to erroneously
reject the buffer, or fail to advance the payload pointer sufficiently,
overwriting subsequent buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624174410.6074=
-1-alhouseenyousef@gmail.com?part=3D1
