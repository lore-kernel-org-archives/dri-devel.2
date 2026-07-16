Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC172C4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AC710E771;
	Thu, 16 Jul 2026 11:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SolPE8l1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C6910E771
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:46:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADE0F43B5E;
 Thu, 16 Jul 2026 11:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BC81F00A3A;
 Thu, 16 Jul 2026 11:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784202368;
 bh=QepbY5hYliYSH01Bzmzaw8qajKJGyeNfz1usQypRCyc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SolPE8l1EUR+U0AEErwVtl5z280y31TFBzOgRTiY7T7qq/xsDKBQgxYrWU+g+cOxW
 DOV2CnZmFBRmF935vb0deiUKXoquKIZUD3iUZsuiiSHslvt011urrDOoQVqyO/hvOC
 879r3ABTImk8vAzIFo/xQ+ftE9H1EdgHQ8WM2VRiOKLYD65Cr0u0VcDBG18II/pWfn
 M9hgoVI/93sxxK36MTinUdfdYHUlcj8jfWdLrE5lTfJkzhieFohR9W7bPBz7kxrPHn
 qahrQlBXHq2gyVbCGP6UlvJAUcSQ8vTwyUXdZU2+XO1tR8+8Hrug5+gUDgYRBEgxbQ
 bumVWvqoU3VZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260716113254.570-1-jianping.li@oss.qualcomm.com>
References: <20260716113254.570-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 11:46:07 +0000
Message-Id: <20260716114608.64BC81F00A3A@smtp.kernel.org>
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
- [Critical] A data race when clearing `mmap->flags` in `fastrpc_put_args()=
` allows multiple concurrent threads to double-free a shared DMA handle map.
- [High] A time-of-check to time-of-use (TOCTOU) race condition in `fastrpc=
_get_args()` leads to a Use-After-Free read of a `fastrpc_map` object.
- [High] Bypassing reference counting for shared DMA handles leads to prema=
ture destruction of IOMMU mappings and DSP SMMU faults.

Pre-existing issues:
- [Critical] `fastrpc_req_mem_unmap_impl()` accesses and frees a map withou=
t holding a reference or lock, leading to Use-After-Free and Double-Free on=
 concurrent unmap requests.
- [Critical] A compromised or malicious DSP can force the host kernel to co=
py arbitrary kernel memory to userspace by modifying the shared `rpra` buff=
er.
--

--- Patch [1]: [PATCH v2] misc: fastrpc: avoid duplicate DMA mappings in fa=
strpc_create_maps() ---
commit e27fd6a362ab035d376548e127d0d378dd957590
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: avoid duplicate DMA mappings in fastrpc_create_maps()

This patch attempts to prevent duplicate DMA mappings by skipping extra
references for DMA handles and tagging them with FASTRPC_MAP_DMA_HANDLE.
It adds re-validation of borrowed maps in fastrpc_get_args() and modifies
fastrpc_put_args() to only release maps tagged with this new flag.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..12c82072236b2 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -999,23 +1001,25 @@ static int fastrpc_create_maps(struct fastrpc_invo=
ke_ctx *ctx)
>  	int i, err;
> =20
>  	for (i =3D 0; i < ctx->nscalars; ++i) {
> +		bool take_ref =3D i < ctx->nbufs;
> +		int mflags =3D 0;
> =20
>  		if (ctx->args[i].fd =3D=3D 0 || ctx->args[i].fd =3D=3D -1 ||
>  		    ctx->args[i].length =3D=3D 0)
>  			continue;
> =20
> -		if (i < ctx->nbufs)
> -			err =3D fastrpc_map_create(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> -		else
> -			err =3D fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +		/* Set the DMA handle mapping flag for DMA handles */
> +		if (i >=3D ctx->nbufs)
> +			mflags =3D FASTRPC_MAP_DMA_HANDLE;
> +
> +		err =3D fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].leng=
th,
> +					 ctx->args[i].attr, &ctx->maps[i], take_ref, mflags);

[Severity: High]
Does bypassing reference counting (take_ref =3D false) for shared DMA handl=
es
lead to premature destruction of IOMMU mappings in
drivers/misc/fastrpc.c:fastrpc_create_maps()?

If two concurrent threads pass the same fd to the DSP, they share the map w=
ith
a single reference count. When the first thread finishes and frees the map,
could this destroy the IOMMU mapping while the DSP is still actively using =
it
for the second thread, causing an SMMU fault?

>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
>  		}
>  	}

[ ... ]

> @@ -1143,6 +1147,16 @@ static int fastrpc_get_args(u32 kernel, struct fas=
trpc_invoke_ctx *ctx)
>  		list[i].num =3D ctx->args[i].length ? 1 : 0;
>  		list[i].pgidx =3D i;
>  		if (ctx->maps[i]) {
> +			/* It is possible that map is created with
> +			 * mflags FASTRPC_MAP_DMA_HANDLE and take_ref
> +			 * is false. Check if map still exists or is
> +			 * being freed as take_ref is false
> +			 */
> +			if (fastrpc_map_lookup(ctx->fl, ctx->args[i].fd,
> +					       &ctx->maps[i], false)) {
> +				ctx->maps[i] =3D NULL;
> +				return -EINVAL;
> +			}
>  			pages[i].addr =3D ctx->maps[i]->dma_addr;

[Severity: High]
Is there a time-of-check to time-of-use race condition here in
drivers/misc/fastrpc.c:fastrpc_get_args()?

Because fastrpc_map_lookup() is called with take_ref =3D false, it sets
ctx->maps[i] inside a spinlock but returns without incrementing the referen=
ce
count. If a concurrent thread drops the final reference and frees the map
immediately after the lock is released, does the subsequent dereference of
ctx->maps[i]->dma_addr result in a use-after-free read?

>  			pages[i].size =3D ctx->maps[i]->size;
>  		}

[ ... ]

In drivers/misc/fastrpc.c:fastrpc_put_args(), earlier in the function:

	for (i =3D inbufs; i < ctx->nbufs; ++i) {
		if (!ctx->maps[i]) {
			void *src =3D (void *)(uintptr_t)rpra[i].buf.pv;
			void *dst =3D (void *)(uintptr_t)ctx->args[i].ptr;
			u64 len =3D rpra[i].buf.len;

			if (!kernel) {
				if (copy_to_user((void __user *)dst, src, len)) {

[Severity: Critical]
This is a pre-existing issue, but can a compromised DSP force the host kern=
el
to copy arbitrary kernel memory to userspace here?

The src pointer (rpra[i].buf.pv) and len are read directly from DSP-modifia=
ble
shared memory without validation. If the kernel does not verify that these
values match the original bounds allocated for the RPC, could the DSP overw=
rite
them to point to arbitrary kernel memory addresses and leak sensitive data?

> @@ -1199,8 +1213,13 @@ static int fastrpc_put_args(struct fastrpc_invoke_=
ctx *ctx,
>  	for (i =3D 0; i < FASTRPC_MAX_FDLIST; i++) {
>  		if (!fdlist[i])
>  			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> +		/* Validate the map flags for DMA handles and skip freeing map if inva=
lid */
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
> +		    mmap->flags =3D=3D FASTRPC_MAP_DMA_HANDLE) {
> +			/* Allow DMA handle maps to free only once */
> +			mmap->flags =3D 0;

[Severity: Critical]
Does clearing mmap->flags here introduce a data race in
drivers/misc/fastrpc.c:fastrpc_put_args()?

The test and subsequent modification of mmap->flags are performed completely
locklessly. If two concurrent threads process the same file descriptor retu=
rned
by the DSP, could both threads evaluate the flag check as true simultaneous=
ly,
clear the flag, and call fastrpc_map_put(mmap), resulting in a double-free?

>  			fastrpc_map_put(mmap);
> +		}
>  	}
> =20
>  	return ret;

[ ... ]

In drivers/misc/fastrpc.c:fastrpc_req_mem_unmap_impl():

	spin_lock(&fl->lock);
	list_for_each_entry_safe(iter, m, &fl->maps, node) {
		if ((req->fd < 0 || iter->fd =3D=3D req->fd) && (iter->raddr =3D=3D req->=
vaddr)) {
			map =3D iter;
			break;
		}
	}
	spin_unlock(&fl->lock);
	...
	fastrpc_map_put(map);

[Severity: Critical]
This is a pre-existing issue, but does fastrpc_req_mem_unmap_impl() access =
and
free a map without holding a reference or lock?

When searching for a map under fl->lock, the function breaks out of the loop
and drops the lock without incrementing the reference count via fastrpc_map=
_get().
If two concurrent threads call the unmap ioctl for the same virtual address,
could both threads find the map, drop the lock, and subsequently call
fastrpc_map_put() causing a double-free and use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716113254.570-=
1-jianping.li@oss.qualcomm.com?part=3D1
