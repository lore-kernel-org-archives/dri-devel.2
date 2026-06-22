Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B64CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE8510E5C9;
	Mon, 22 Jun 2026 09:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mMQIbGK6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A485610E5C9
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:47:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F91E40467;
 Mon, 22 Jun 2026 09:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473EC1F000E9;
 Mon, 22 Jun 2026 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782121675;
 bh=sEkpS5Z49CmNXb98ztjN2qs5CWnfNvWW/wtg2hWkwB8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mMQIbGK6q02dCr+zx3UpyLJSk6jUF+GBveGeUAhmHZNFuOIwsDG8P0UEYKJKpNXHM
 q8Zu8NJc8Ue0q/tCrGkCLbjLQu+xJ23Imvhh7oAG3MvO5DNLBGurKiSwKqPDXB2cQY
 FGpcSwV82lJji6SQOamGHqxFJgEwejVr/VllVhfdBf4SvKc3XWTLI6cPxTglXb2lTE
 zwj6ifQMOe5kQAbP7mXmjFUzMZ7fvCtcR2adWsPZSqQ+FpcxKHCj9G4GTTT5aaeu+8
 M1AcPnFQd+Nv1sTvYgEsXsEUVSwdqvU0gWXne79zVp0EhEqEh46kTQ4TRzDGXvdax2
 iokWZArOEMBww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119054236227.17989.seg@mailgw.kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <1782119054236227.17989.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:47:54 +0000
Message-Id: <20260622094755.473EC1F000E9@smtp.kernel.org>
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
- [Critical] Double fetch of `rpc->length` from untrusted GSP shared memory=
 allows bypassing size validation and causing a heap buffer overflow.
- [Critical] Integer underflow in `r535_gsp_msgq_recv_one_elem()` when copy=
ing continuation records with a small length.
- [Critical] Missing validation of continuation chunk sizes in `r535_gsp_ms=
gq_recv()` leads to heap buffer overflow and integer underflow.
- [High] Silent failure when GSP firmware sends a corrupted RPC reply for a=
n allocation request.
- [High] Memory leak of the RPC reply payload when `nvkm_gsp_rpc_wr()` is u=
sed with `NVKM_GSP_RPC_REPLY_RECV`.
- [High] Large RPC message buffer leak on error paths in `r535_gsp_rpc_push=
()`.
--

commit 80c014f86c2f1ac065ff1b0e24d2eb0c508a2e4a
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage

This commit cleans up the usage of IS_ERR_OR_NULL in r535_gsp_rpc_rm_free().
It updates the check for nvkm_gsp_rpc_get() to only use IS_ERR(), matching
its actual return value contract.

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
> =20
>  	rpc->params.hRoot =3D client->object.handle;
>  	rpc->params.hObjectParent =3D 0;
>  	rpc->params.hObjectOld =3D object->handle;
>  	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);

[Severity: High]
This is a pre-existing issue, but I noticed nvkm_gsp_rpc_wr() returns 0 on
success and drops the reply buffer allocated by nvkm_gsp_rpc_push().

When nvkm_gsp_rpc_wr() is called with NVKM_GSP_RPC_REPLY_RECV, the reply
is returned via:

drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h:nvkm_gsp_rpc_wr() {
    ...
    void *repv =3D nvkm_gsp_rpc_push(gsp, argv, policy, 0);

    if (IS_ERR(repv))
        return PTR_ERR(repv);

    return 0;
}

Since the caller here doesn't receive the reply buffer, and nvkm_gsp_rpc_wr=
()
doesn't free it, does this leak memory every time r535_gsp_rpc_rm_free()
is called?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error
handling for RPCs, I see that r535_gsp_rpc_rm_alloc_push() can return NULL:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c:r535_gsp_rpc_rm_all=
oc_push() {
    ...
    if (IS_ERR_OR_NULL(rpc))
        return rpc;
    ...
}

However, nvkm_gsp_rm_alloc_wr() only checks for IS_ERR(repv) and then
returns 0 (success) if it is not an error:

drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h:nvkm_gsp_rm_alloc_wr() {
    ...
    if (IS_ERR(repv))
        return PTR_ERR(repv);

    return 0;
}

Since IS_ERR() evaluates to false for NULL, does this incorrectly mask
failures and treat them as successful allocations?

[Severity: High]
This is a pre-existing issue, but in r535_gsp_rpc_push(), if the final
reply yields an error, the code skips kvfree(msg):

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
    ...
    repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
                                     sizeof(*rpc));
    if (!IS_ERR(repv))
        kvfree(msg);
    ...
}

If an error occurs or the code branches to the done label, does this leak
the large RPC message buffer?

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at
r535_gsp_msgq_recv(), the length is read from shared memory directly:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

    buf =3D kvmalloc(max_t(u32, rpc->length, expected), GFP_KERNEL);
    ...
    info.gsp_rpc_len =3D rpc->length;
}

Since the length is read again after kvmalloc(), which acts as a compiler
barrier, can the GSP firmware change rpc->length between the validation
and the second fetch, bypassing the size check?

[Severity: Critical]
This is a pre-existing issue, but in r535_gsp_msgq_recv_one_elem(), there
is a size calculation without validation:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv_on=
e_elem() {
    ...
    if (info->continuation)
        memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
               len - sizeof(struct nvfw_gsp_rpc));
}

If the provided length is smaller than sizeof(struct nvfw_gsp_rpc), will
this underflow and copy an excessive amount of data out-of-bounds?

[Severity: Critical]
This isn't a bug introduced by this patch, but when processing multi-part
messages in r535_gsp_msgq_recv(), the code subtracts chunk size from expect=
ed
without validation:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
    ...
    size =3D info.gsp_rpc_len - sizeof(*rpc);
    expected -=3D size;
    info.gsp_rpc_buf +=3D size;
}

If size is larger than the remaining expected amount, does expected underfl=
ow
and cause the buffer pointer to advance out of bounds on subsequent chunks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D3
