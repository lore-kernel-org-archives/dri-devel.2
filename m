Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B374CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B6810E043;
	Mon, 22 Jun 2026 04:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mD678PY8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713C210E043
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EA5760051;
 Mon, 22 Jun 2026 04:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308FA1F000E9;
 Mon, 22 Jun 2026 04:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782102526;
 bh=hEgmUQqQqgKYz5xSc7e2slAVJ52ZMQyMnQOFNeW9+cg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mD678PY8CjcREBz7kLFUecPDI5xlyhqX+dVQu6o6dcyqDjHM5NIMZsQrZAbUgv4tU
 FKZq7w7vJ9xcNEoUdiNGxV0ZTITJBG6SjGbog/9qKRYEVCpFnf06GrziJByYrAqZtJ
 mzZjnHH7sLQqNCPrZz7T3SLnhSTE89bYj+lWE3CTU3G9s3hZKpoptwGoKs04po9Doi
 n7SFghD35U08yHtm2Kdxy6JnTUGNK2PQqNT037b49k5hHPMq4TskYBTo+bMHEggeZd
 c2idwe4fLubrfEIglOnXT3TE71RsFEaBHgGt5gn6/e8zPDHInyMP5ihRZeGduQ+QVt
 Oq2fhZd6B3qfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622021207.14764-4-zenghongling@kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <20260622021207.14764-4-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:28:45 +0000
Message-Id: <20260622042846.308FA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Silently dropping oversized GSP RPC messages and reporting false s=
uccess.
--

commit c03df51ffa049e6fe56eec7d75137d404fe0855b
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
   =20
This commit cleans up error checking by using IS_ERR() instead of=20
WARN_ON(IS_ERR_OR_NULL()) after nvkm_gsp_rpc_get() calls, matching=20
the actual return value contract.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c b/dr=
ivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> @@ -35,7 +35,7 @@ r535_gsp_rpc_rm_free(struct nvkm_gsp_object *object)
>  		   client->object.handle, object->handle);
> =20
>  	rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_FREE, sizeof(*rpc));
> -	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
> +	if (WARN_ON(IS_ERR(rpc)))
>  		return -EIO;
> =20
>  	rpc->params.hRoot =3D client->object.handle;
>  	rpc->params.hObjectParent =3D 0;
>  	rpc->params.hObjectOld =3D object->handle;
>  	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);

[Severity: High]
This isn't a bug introduced by this patch, but since this commit is
cleaning up error handling around GSP RPC interactions, does
nvkm_gsp_rpc_wr() also have an error handling issue that hides critical
failures?

Looking at drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c, if the
GSP sends an RPC message where rpc->length > max_rpc_size,
r535_gsp_msgq_recv() returns NULL without advancing the message queue read
pointer:

r535_gsp_msgq_recv()
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

This NULL propagates to nvkm_gsp_rpc_wr() in
drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h, which translates it into
a false success:

nvkm_gsp_rpc_wr()
    ...
    if (IS_ERR(repv))
        return PTR_ERR(repv);
    return 0;

Since repv is NULL, IS_ERR(repv) evaluates to false, causing the function
to silently return 0.

Could this cause the caller to proceed assuming the RPC succeeded,
potentially leading to an invalid state or use-after-free, while the
unadvanced read pointer permanently wedges the message queue for all
subsequent reads?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D3
