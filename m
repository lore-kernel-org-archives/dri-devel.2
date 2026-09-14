Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93664C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD2D10ED2C;
	Mon, 14 Sep 2026 10:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IbVLXxdW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5ED10ED2C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:54:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEA4E60142;
 Mon, 14 Sep 2026 10:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421411F000FF;
 Mon, 14 Sep 2026 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789383289;
 bh=sibqfHzIcfBi0e3rcZ5ZvwIO3Q/1Xwy88FBdtNrKLew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IbVLXxdWV0Q758Ln8wN66bS/CyGfZUs+Hd62+vBF0tSkFXQGLv2ZAJN/ssspl3ctE
 qfUt8V+pvS/L4d/xrxkwvsg6Mam1QNiH7UuhEfWDXxVrk1WYBcoMIeU5zoRSwqNSxp
 rv/5VzOF+MqC+CYLcmIqU0qW5hUIsByaEAbGIUges77HHPaGBfRJbxdNq7Ym2/Vi4J
 7IvpNTEkbqN28W3cQZLrCLzRWtfWHKk5LxFmeQYYNCtY9KWvfW+bti6gw8nrGNZa52
 D35PIW50z3WZ81N8pavQROtGxjUWwvGMXAqyjqrgzKYByh2fklGyAAmyBsld5Z1rc5
 9pla9QaIPHF6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260914104019.492-1-jianping.li@oss.qualcomm.com>
References: <20260914104019.492-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 10:54:48 +0000
Message-Id: <20260914105449.421411F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free and prema=
ture SMMU unmapping due to missing reference counting for DMA handles.
- [Critical] Data Race in `fastrpc_put_args()` leading to a Double Free of =
`fastrpc_map` objects.

Pre-existing issues:
- [High] Permanent Memory and IOMMU Leak of DMA handle maps on invocation e=
rror paths.
--

commit de606379cd29bd912e7ec93a58384eaa07c8ecd6
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: avoid duplicate DMA mappings in fastrpc_create_maps()

This patch attempts to fix duplicate DMA mappings by not taking an extra
reference for DMA handle arguments (take_ref =3D false). It tags them with
FASTRPC_MAP_DMA_HANDLE, re-validates the map in fastrpc_get_args() before
use, and relies on fastrpc_put_args() to release these tagged maps when
the DSP returns the fd.

Link: https://lore.kernel.org/all/20260805060940.41414-1-jianping.li@oss.qu=
alcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca867..58f27e2713172 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1047,23 +1052,25 @@ static int fastrpc_create_maps(struct fastrpc_inv=
oke_ctx *ctx)
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
This is a pre-existing issue, but does fastrpc_create_maps() leak the DMA
handle maps on error paths?

If this function successfully creates a DMA handle map (where i >=3D
ctx->nbufs), but a subsequent step in fastrpc_internal_invoke() fails, the
cleanup path in fastrpc_context_free() is triggered.

fastrpc_context_free() only iterates up to nbufs:

    for (i =3D 0; i < ctx->nbufs; i++)
        fastrpc_map_put(ctx->maps[i]);

Since the cleanup loop ignores indices >=3D nbufs, and the invoke never
reaches the DSP to trigger fastrpc_put_args(), do these maps and their
SMMU mappings leak permanently?

>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
>  		}
> -
>  	}
> +
>  	return 0;
>  }

[ ... ]

> @@ -1195,6 +1202,16 @@ static int fastrpc_get_args(u32 kernel, struct fas=
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

[Severity: Critical]
Can this lockless dereference lead to a use-after-free regression?

Since fastrpc_create_maps() maps the DMA handle with take_ref =3D false,
the shared map's refcount remains 1. If a concurrent invocation completes
and executes fastrpc_put_args() exactly after fastrpc_map_lookup() drops
the lock but before ctx->maps[i]->dma_addr is evaluated, it will clear the
flag and free the map.

Would this result in a host kernel use-after-free and premature SMMU
unmapping when the unreferenced pointer is accessed?

>  			pages[i].size =3D ctx->maps[i]->size;
>  		}

[ ... ]

> @@ -1244,8 +1261,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_=
ctx *ctx,
>  	for (i =3D 0; i < FASTRPC_MAX_FDLIST; i++) {
>  		if (!fdlist[i])
>  			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> +		/*
> +		 * DMA handle maps are released when the DSP returns the corresponding=
 fd in
> +		 * fdlist. The DSP is expected to return a specific fd only once in fd=
list,
> +		 * so no two fastrpc_put_args() paths should clear the DMA_HANDLE flag=
 for
> +		 * the same map concurrently.
> +		 */
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
> +		    mmap->flags =3D=3D FASTRPC_MAP_DMA_HANDLE) {
> +			mmap->flags =3D 0;
>  			fastrpc_map_put(mmap);
> +		}

[Severity: Critical]
Does clearing mmap->flags outside a lock introduce a race condition leading
to a double free regression?

If userspace submits two concurrent invocations sharing the same fd, and
the DSP returns the fd in the fdlist of both, two threads executing
fastrpc_put_args() could look up the shared map locklessly.

Thread 1: evaluates mmap->flags =3D=3D FASTRPC_MAP_DMA_HANDLE as true
Thread 2: evaluates mmap->flags =3D=3D FASTRPC_MAP_DMA_HANDLE as true
Thread 1: clears flags and calls fastrpc_map_put() freeing the map
Thread 2: clears flags and calls fastrpc_map_put() on a freed pointer

Can this lead to host kernel heap corruption if triggered by concurrent
invokes?

>  	}
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914104019.492-=
1-jianping.li@oss.qualcomm.com?part=3D1
