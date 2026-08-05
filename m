Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D4C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 06:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9D410ECE3;
	Wed,  5 Aug 2026 06:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FljSuZ6Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07CFF10ECE3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 06:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F6C94008D;
 Wed,  5 Aug 2026 06:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0481F000E9;
 Wed,  5 Aug 2026 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785910973;
 bh=qY7ldQ5SMZWi5lrpHoFFFZgWpcrZgEAqO3ikRy1/z3M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FljSuZ6QUZ7RhNug2FyiHq0ZJEqcM6vFyK3gaBjuAA4ioZcqBOPPBlXGKy+72jJjH
 hpzO0DU9r3TOlCphZeslrARmxF10rB6Nc8K+U50qBxjLJ38AWC+lwUp+q/zUCY7yld
 Cpf8zcwL3hwBXaOIC4/6uTe3x+ckJji6jlefneIVdgyl0vb/4p9ejhtCI7rRAr1oCN
 Ju4cUeUrAA5jBsXfdSrdVfwxVAOkl6tpSvnJ3HpcsFs4WiX+qXJ7Vd+YRXR/gMq20n
 gzxOM4waIXqELsdk/V/DeCmReM9TXrOP5EZUxHacW+sMhshBHhwTRu7zWTRupT/3Gw
 MQBevZahn5l0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
References: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 06:22:52 +0000
Message-Id: <20260805062253.4D0481F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Sharing DMA handle maps without taking a reference allows one =
invocation to unmap the memory while a concurrent invocation is still activ=
ely using it on the DSP, leading to IOMMU faults.
- [High] A Time-Of-Check to Time-Of-Use (TOCTOU) race condition in `fastrpc=
_get_args()` allows a concurrent thread to free a borrowed DMA handle map, =
leading to a Host-Side Use-After-Free.
- [High] A lockless Read-Modify-Write sequence on `mmap->flags` in `fastrpc=
_put_args()` creates a data race that can be exploited to double-free a DMA=
 handle map.

Pre-existing issues:
- [High] DMA handle maps created during argument processing are permanently=
 leaked if the fastrpc invocation fails on error paths or is interrupted by=
 a signal.
--

--- Patch [1]: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in fa=
strpc_create_maps() ---
commit 518577268f37fc91e27676af4609f0c0fa3363fc
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: avoid duplicate DMA mappings in fastrpc_create_maps()

This patch changes DMA handle mappings to not take an extra reference
count and tags them with FASTRPC_MAP_DMA_HANDLE. It re-validates the map in
fastrpc_get_args() and modifies fastrpc_put_args() to only release maps
flagged as FASTRPC_MAP_DMA_HANDLE to avoid duplicate mappings.

Patch [v2]: https://lore.kernel.org/all/20260716113254.570-1-jianping.li@os=
s.qualcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..59bf33cbed5af 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> [ ... ]
> @@ -999,23 +1001,25 @@ static int fastrpc_create_maps(struct fastrpc_invo=
ke_ctx *ctx)
>  	int i, err;
> =20
>  	for (i =3D 0; i < ctx->nscalars; ++i) {
> +		bool take_ref =3D i < ctx->nbufs;

[Severity: Critical]
By setting take_ref to false for DMA handles, does this allow concurrent
invocations to share a map without incrementing its reference count?

If one invocation finishes and drops the only reference in fastrpc_put_args=
(),
won't the SMMU mapping be torn down while another concurrent invocation is
still actively using it on the DSP?

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
This is a pre-existing issue, but does this code permanently leak DMA
handles if an error occurs after map creation?

If an error happens or a signal interrupts the process, the cleanup path
fastrpc_context_free() intentionally omits freeing maps where
i >=3D ctx->nbufs:

drivers/misc/fastrpc.c:fastrpc_context_free() {
	...
	for (i =3D 0; i < ctx->nbufs; i++)
		fastrpc_map_put(ctx->maps[i]);
	...
}

Can an unprivileged user intentionally provide invalid arguments (e.g., bad
payload size) to trigger a failure after map creation, causing an unbounded
memory leak of orphaned DMA handles?

>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
>  		}
> -
>  	}
> +
>  	return 0;
>  }
> [ ... ]
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
Is there a race condition between looking up the map and dereferencing it?

Since fastrpc_map_lookup() is called with take_ref =3D false, it locklessly
returns a pointer to the shared map without holding a reference. Could a
concurrent thread finish its invocation and free this shared map before
pages[i].addr =3D ctx->maps[i]->dma_addr is evaluated, resulting in a host-=
side
use-after-free?

> +			pages[i].size =3D ctx->maps[i]->size;
>  		}
> [ ... ]
> @@ -1199,8 +1213,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_=
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

[Severity: High]
Does the lockless check of mmap->flags allow a double-free if concurrent
invocations share the same fd?

If two concurrent threads from the same user process share the same DMA
handle fd, they share the same map object. When both invocations finish, th=
ey
could execute fastrpc_put_args() concurrently.

If they reach this check at the same time, couldn't they both evaluate
mmap->flags =3D=3D FASTRPC_MAP_DMA_HANDLE as true, clear the flag, and call
fastrpc_map_put() twice on the same map?

>  	}
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805060940.4141=
4-1-jianping.li@oss.qualcomm.com?part=3D1
