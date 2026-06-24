Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6783CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 397FB10E0F1;
	Wed, 24 Jun 2026 19:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oVN5/8Jw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F3410E0F1
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:39:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C56A600C3;
 Wed, 24 Jun 2026 19:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A81A1F000E9;
 Wed, 24 Jun 2026 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782329954;
 bh=w7MHz1Bra5F35k98MM70yfJdceswq7kd3ZtLANuselc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oVN5/8JwiyPmWSRdamK3hIgCgahY6NEXt3Z1KLD1BHiEGAKxW1f4Ch+pYwnlp+HMf
 RGKggUgMqBvA3IegwT+ej1rynWJD9Nj5dKgezFWnGoFE9kISgN1F8+8B/RkB7jkqa5
 ptELaqBs39S6Dxlj0znpYaYtxh5wy8Ev0xNMRILPVMZ/BRJjlYNzpN9P4j3jit/XOD
 YPAjfMhFgj1JGumj6wU+nKGiYv77dPCXFFEfcryH402/X7t4Ec/FrW19bf6FTm5ZfM
 asCMLqieyppFzQHmwQwLpkxrgydtxF7ssSmUFEHgCVM1NEWf3y/AOjZ222LNhUwen/
 04Kw/GjCSIp8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: reject overflowing invoke payload sizes
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624192225.4508-1-alhouseenyousef@gmail.com>
References: <20260624192225.4508-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:39:13 +0000
Message-Id: <20260624193914.2A81A1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Incomplete Integer Overflow Mitigation in Payload Size Calcula=
tion
- [High] Memory leak of fastrpc_map and dma_buf references for handle argum=
ents
- [High] Fatal double-free and Use-After-Free in fastrpc_map_attach error p=
aths
--

commit a690f181cf4241d027f4e7ef1ae4948e3ce1e15b
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: reject overflowing invoke payload sizes

This patch adds overflow checks to fastrpc_get_payload_size() to prevent
undersized buffer allocations during invoke argument serialization. It retu=
rns
an error if the payload size calculation overflows or exceeds SIZE_MAX.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..226ae91617c05 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -972,7 +972,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invok=
e_ctx *ctx)
>  	return size;
>  }
> =20
> -static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int =
metalen)
> +static int fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int =
metalen,
> +				    u64 *out_size)
>  {
>  	u64 size =3D 0;
>  	int oix;
> @@ -982,15 +983,22 @@ static u64 fastrpc_get_payload_size(struct fastrpc_=
invoke_ctx *ctx, int metalen)
>  		int i =3D ctx->olaps[oix].raix;
> =20
>  		if (ctx->args[i].fd =3D=3D 0 || ctx->args[i].fd =3D=3D -1) {
> +			u64 len =3D ctx->olaps[oix].mend -
> +				  ctx->olaps[oix].mstart;
> =20
>  			if (ctx->olaps[oix].offset =3D=3D 0)
>  				size =3D ALIGN(size, FASTRPC_ALIGN);
> =20
> -			size +=3D (ctx->olaps[oix].mend - ctx->olaps[oix].mstart);
> +			if (check_add_overflow(size, len, &size))
> +				return -EOVERFLOW;

[Severity: Critical]
This is a pre-existing issue, but does ALIGN(size, FASTRPC_ALIGN) silently
wrap around to 0 if size is near U64_MAX?

If size wraps to 0, check_add_overflow(size, len, &size) will not detect an
overflow.

Could this lead to an undersized allocation where fastrpc_get_args() later
writes out-of-bounds when initializing metadata structures like rpra, list,
and pages?

>  		}
>  	}
> =20
> -	return size;
> +	if (size > SIZE_MAX)
> +		return -EOVERFLOW;
> +
> +	*out_size =3D size;
> +	return 0;
>  }
> =20
>  static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)

[Severity: High]
This isn't a bug introduced by this patch, but does fastrpc_context_free()
leak maps and dma_buf references created for handle arguments?

fastrpc_create_maps() creates maps for all arguments up to ctx->nscalars,
which includes handle arguments where i >=3D ctx->nbufs.

However, the teardown loop in fastrpc_context_free() only iterates up
to ctx->nbufs:

fastrpc_context_free() {
	...
	for (i =3D 0; i < ctx->nbufs; i++)
		fastrpc_map_put(ctx->maps[i]);
	...
}

Are the maps for i >=3D ctx->nbufs left attached to the fastrpc_user list
indefinitely, allowing a user-space process to continuously leak memory per
invoke?


[Severity: High]
This is a pre-existing issue, but can fastrpc_map_attach() trigger a
double-free in its error handling paths?

If an error occurs after map->table has been assigned, the error path
explicitly detaches and puts the dma_buf:

fastrpc_map_attach() {
    ...
map_err:
	dma_buf_detach(map->buf, map->attach);
attach_err:
	dma_buf_put(map->buf);
get_err:
	fastrpc_map_put(map);
    ...
}

However, fastrpc_map_put() eventually calls fastrpc_free_map(), which repea=
ts
the detach and put operations on the same pointers because map->table is se=
t:

fastrpc_free_map() {
    ...
	if (map->table) {
		...
		dma_buf_detach(map->buf, map->attach);
		dma_buf_put(map->buf);
	}
    ...
}

Could this double-put cause a reference count underflow and a use-after-free
of the DMA buffer?

> @@ -1043,7 +1051,9 @@ static int fastrpc_get_args(u32 kernel, struct fast=
rpc_invoke_ctx *ctx)
> =20
>  	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
>  	metalen =3D fastrpc_get_meta_size(ctx);
> -	pkt_size =3D fastrpc_get_payload_size(ctx, metalen);
> +	err =3D fastrpc_get_payload_size(ctx, metalen, &pkt_size);
> +	if (err)
> +		return err;
> =20
>  	err =3D fastrpc_create_maps(ctx);
>  	if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624192225.4508=
-1-alhouseenyousef@gmail.com?part=3D1
