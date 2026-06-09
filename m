Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C3CCD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B8D10E06A;
	Tue,  9 Jun 2026 03:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F7OaqcR7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2104310E06A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:18:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEF21418E7;
 Tue,  9 Jun 2026 03:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44571F00893;
 Tue,  9 Jun 2026 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780975091;
 bh=Cu0/Bay43OSm6o/pchVYDcYqFjYpyjRghoofTC+YB2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F7OaqcR7voKqGZf1U132+iG2O1DvdfEtTLcNLYKqsDM9MkUSs6tSW0ncvNKHkeQxi
 9H6qOXoBVHDUXXfBaeHAdhenUw2OKpQoFZmhAPxAGdrAdXqOkBKvKhpZ5C3kT2MZ4W
 lGGNXLegTofF0zQxbVc+9nhuhzXrrfkrSHist6HnUIUzYEtnHgiZB6yK7KxHWsYjmw
 vuT78QxXNlX3MSYAo9UWl7fyCWVfpE4Qj3SMQn/rF0QSWLFeDU++yX8+8LU0CgYNbD
 Y/4hgQWQdGeFrlE6DBC4sft5x8S6U/2euZEDYOJQ8ylTT3MfetjwDaHFx1MwN6kmDu
 NWyd/IWnbbJSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Allow fastrpc_buf_free() to
 accept NULL
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609025938.457-5-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-5-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:18:11 +0000
Message-Id: <20260609031811.A44571F00893@smtp.kernel.org>
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
- [Critical] Exported DMA buffers outlive their fastrpc_user context, leadi=
ng to a Use-After-Free on dmabuf operations.
- [Critical] In `fastrpc_req_mmap()`, if `copy_to_user()` fails, the alloca=
ted buffer is freed via `fastrpc_req_munmap_impl()`, but its node is never =
removed from `fl->mmaps`.
- [Critical] Timeouts in kernel RPCs cause DMA buffers to be freed while th=
e DSP is still actively using them.
- [High] Interrupted mmaps are unlinked but their memory is never freed dur=
ing `fastrpc_rpmsg_remove()`.
- [High] Invocation contexts leak references to attached maps for handles, =
allowing unbounded resource accumulation.
- [High] Failure to restore hypervisor memory permissions in `fastrpc_req_m=
unmap_impl` for remote heap allocations.
--

commit c345df439255945e9c8c222e251d798521775ff6
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Allow fastrpc_buf_free() to accept NULL

Make fastrpc_buf_free() a no-op when passed a NULL pointer, allowing
callers to avoid open-coded NULL checks.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1942e74535e52..b4912b443b982 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -424,6 +424,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl=
, int fd,
> =20
>  static void fastrpc_buf_free(struct fastrpc_buf *buf)
>  {
> +	if (!buf)
> +		return;
> +
>  	dma_free_coherent(buf->dev, buf->size, buf->virt,
>  			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));

[Severity: Critical]
This is a pre-existing issue, but does fastrpc_buf_free() have a
use-after-free risk when called from the dmabuf release path?

If a user closes the fastrpc device descriptor but keeps the DMA-BUF file
descriptor open, the fastrpc_user (fl) context is freed. When the DMA-BUF
is later released, it calls fastrpc_buf_free(), which dereferences
buf->fl->cctx here to calculate the DMA address.

Since fastrpc_dmabuf_alloc() doesn't take a reference on the fastrpc_user
when exporting the DMA-BUF, can this lead to memory corruption?

[Severity: High]
This isn't a bug introduced by this patch, but does fastrpc_buf_free()
safely handle buffers mapped with ADSP_MMAP_REMOTE_HEAP_ADDR?

When fastrpc_req_mmap() maps a remote heap buffer, it uses
qcom_scm_assign_mem() to grant access to the DSP VM. During unmapping,
fastrpc_req_munmap_impl() calls fastrpc_buf_free() directly.

Will handing this restricted memory back to the kernel's allocator without
first calling qcom_scm_assign_mem() to restore ownership to the HLOS lead
to a hypervisor fault when the kernel tries to use the memory?

[Severity: Critical]
This is a pre-existing issue, but does calling fastrpc_buf_free() on
timeout lead to memory corruption by the DSP?

When fastrpc_internal_invoke() times out, callers like fastrpc_req_mmap()
and fastrpc_init_create_process() treat it as a failure and immediately
call fastrpc_buf_free(buf) to release the kernel memory.

Since there is no mechanism to cancel the pending request on the DSP, won't
the DSP continue processing and access the freed DMA memory, potentially
corrupting memory that has been reallocated by the system?

>  	kfree(buf);
>  }
> @@ -516,8 +519,7 @@ static void fastrpc_user_free(struct kref *ref)
>  	struct fastrpc_map *map, *m;
>  	struct fastrpc_buf *buf, *b;
> =20
> -	if (fl->init_mem)
> -		fastrpc_buf_free(fl->init_mem);
> +	fastrpc_buf_free(fl->init_mem);
> =20
>  	list_for_each_entry_safe(ctx, n, &fl->pending, node) {

[Severity: Critical]
This isn't a bug introduced by this patch, but does fastrpc_user_free()
risk a use-after-free and double free when cleaning up fl->mmaps?

In fastrpc_req_mmap(), if copy_to_user() fails, the code jumps to
err_assign and calls fastrpc_req_munmap_impl(). This unmaps and frees the
buffer using fastrpc_buf_free(), but leaves its node in the fl->mmaps
list.

When fastrpc_user_free() later loops over fl->mmaps, will it attempt to
access and free this already-freed buffer?

[Severity: High]
This is a pre-existing issue, but does fastrpc_rpmsg_remove() leak
interrupted mmaps when tearing down the channel?

When an invocation returns -ERESTARTSYS, mapped buffers are moved from
fl->mmaps to cctx->invoke_interrupted_mmaps. During fastrpc_rpmsg_remove(),
the elements are unlinked:

    list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
        list_del(&buf->node);

Does skipping the fastrpc_buf_free(buf) call here cause a permanent leak
of the fastrpc_buf and its associated DMA/SMMU memory allocations?

>  		list_del(&ctx->node);
> @@ -562,8 +564,7 @@ static void fastrpc_context_free(struct kref *ref)
>  	for (i =3D 0; i < ctx->nbufs; i++)
>  		fastrpc_map_put(ctx->maps[i]);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does fastrpc_context_free()
leak references to attached maps for handles?

In fastrpc_create_maps(), the ctx->maps array is populated for all
nscalars. For indices >=3D nbufs (handles), fastrpc_map_attach() creates
a new map and adds it to fl->maps.

Since this cleanup loop only iterates up to ctx->nbufs, does it fail to
drop the references for the remaining handle maps in ctx->maps, causing
unbounded accumulation in fl->maps?

> -	if (ctx->buf)
> -		fastrpc_buf_free(ctx->buf);
> +	fastrpc_buf_free(ctx->buf);
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609025938.457-=
1-jianping.li@oss.qualcomm.com?part=3D4
