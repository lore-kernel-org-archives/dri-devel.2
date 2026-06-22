Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62999CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AA410E532;
	Mon, 22 Jun 2026 08:25:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9vb9tss";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD9510E532
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:25:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EE6B6001A;
 Mon, 22 Jun 2026 08:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1909F1F000E9;
 Mon, 22 Jun 2026 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782116754;
 bh=Cc49zNhK4hWbFm77j3mle89X5vudqaoq0ROWjL8gaFw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B9vb9tssFIpwMrve33uhgBGjQ+qTjAd3ZnUQxZG/utmPlNHfBPtFd/Q/bBBbJnS1D
 BWILWFX3Mbx0CsQOlVfOHRzJlsR2KJ5ZIP6dqDqKH+nMOoYJemoFUaezFKCAViL7a/
 vDH9Wpwnx7jLkKcybAG7XQ1xCTAs3A/0dbH/nGZkhZ56nYLwWa7YQ8Lpit8CA1fSI0
 Tj4ru/7QyoYUyO9aG3b+/Jazz/B5FI1b1NROhQBc/7GSj5ScnAuTSGQAFD+nj4ox3C
 16IlBvEIxlp7iNK+OnMyOxdwAANzgWRp7B2gBZqAW1PvAh19HQ0V0iADPNxWN4Dgef
 atiDlx9n/1VLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622081136.61695-4-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <20260622081136.61695-4-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:25:53 +0000
Message-Id: <20260622082554.1909F1F000E9@smtp.kernel.org>
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
- [High] Silent failure and kernel panic when GSP RPC payload length exceed=
s max size
--

commit 3ec8c0b86229f7768cd026a5fe2006cc70c81806
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage

r535_gsp_rpc_rm_free() calls nvkm_gsp_rpc_get() which never returns
NULL, only valid pointers or error pointers. Clean up by using IS_ERR()
instead, matching the actual return value contract.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c b/dr=
ivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> index 46e3a29f2ad7f..c9f86c0e9b255 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> @@ -35,7 +35,7 @@ r535_gsp_rpc_rm_free(struct nvkm_gsp_object *object)
>  		   client->object.handle, object->handle);
> =20
>  	rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_FREE, sizeof(*rpc));
> -	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
> +	if (WARN_ON(IS_ERR(rpc)))
>  		return -EIO;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this cleanup
of IS_ERR_OR_NULL(), I noticed a pre-existing issue where NULL pointers can
be returned and dereferenced in the GSP RPC receive paths.

If the GSP firmware returns an RPC message with an invalid length,
r535_gsp_msgq_recv() detects this but returns NULL instead of an error
pointer:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
        ...
        if (WARN_ON(rpc->length > max_rpc_size))
                return NULL;
        ...
}

This NULL propagates through functions like r535_gsp_rpc_rd(). Because call=
ers
like r535_gsp_get_static_info() only check IS_ERR(), they will attempt to
dereference the NULL pointer:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c:r535_gsp_get_static_i=
nfo() {
        ...
        rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_IN=
FO, sizeof(*rpc));
        if (IS_ERR(rpc))
                return PTR_ERR(rpc);

        gsp->internal.client.object.client =3D &gsp->internal.client;
        gsp->internal.client.object.parent =3D NULL;
        gsp->internal.client.object.handle =3D rpc->hInternalClient;
        ...
}

Could this NULL return also cause silent state corruption elsewhere? In
r535_gsp_rpc_rm_alloc_push(), a NULL return from nvkm_gsp_rpc_push() is
treated as a success condition:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c:r535_gsp_rpc_rm_all=
oc_push() {
        ...
        rpc =3D nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, sizeof=
(*rpc));
        if (IS_ERR_OR_NULL(rpc))
                return rpc;
        ...
}

This means the length error could be silently converted into a false succes=
s,
leaving the object initialized in software but unallocated in hardware.

Should r535_gsp_msgq_recv() be updated to return an error pointer like
ERR_PTR(-EIO) instead of NULL to prevent these panics and false successes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D3
