Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2CCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4E010E59C;
	Mon, 22 Jun 2026 09:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EHL4EpMu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9775B10E59C
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:19:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70A8641841;
 Mon, 22 Jun 2026 09:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF581F000E9;
 Mon, 22 Jun 2026 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119975;
 bh=7R/fwGBRTmeH3u2EY9pyZrqRCdHY/NcB/I462kJh2yU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EHL4EpMuBwN/Dhj4qkRtIJmm5hqZf4NlGQtE0ccO5bHQVWFbx/7acTreYAYGUKn2w
 2bbRwYmrxqcnBjWXxr1z4kFQ/1EZTmc+oFBMWS3ujnixLpbp8SE3eVY155iegr5tFT
 snvnv7yJPQJ2pvKC8FV0fSaUJP4M7xlVZp95hs7HSbZW97S9OlgDLWMjeLNFUN3C62
 yJ2Gbla//5PvE2LDSB9iHcDNaGtU5g+g9z8uVZaOsgK1n7PQO982slrqf2EYTYW8lZ
 7IYtfOsN1JsBEBic64gozNeeIZVtViseGoF42QfrpePAoEq5VQExkypZCQuGY6J6dt
 /xCPvB3H/6hwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119051174853.14288.seg@mailgw.kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <1782119051174853.14288.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:19:34 +0000
Message-Id: <20260622091935.3EF581F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Corrupt or oversized GSP messages cause NULL pointer dereferences =
or false successes because they return NULL instead of an error pointer.
- [High] Leaking the original large RPC payload message in `r535_gsp_rpc_pu=
sh()` on error paths during chunked transmission.
--

commit be006c1667937e9a2375afa2299598f63205492b
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp/rm/alloc: Cleanup IS_ERR_OR_NULL usage

This commit changes the error checking in r535_gsp_rpc_rm_free() to use
IS_ERR() instead of IS_ERR_OR_NULL() for the return value of
nvkm_gsp_rpc_get().

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c b/dr=
ivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> index 46e3a29f2ad7f..c9f86c0e9b255 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/alloc.c
[ ... ]
> @@ -35,7 +35,7 @@ r535_gsp_rpc_rm_free(struct nvkm_gsp_object *object)
>  		   client->object.handle, object->handle);
> =20
>  	rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_FREE, sizeof(*rpc));
> -	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
> +	if (WARN_ON(IS_ERR(rpc)))

[Severity: High]
This isn't a bug introduced by this patch, but while we are refining the us=
e of
IS_ERR() for RPC messages, could corrupt or oversized GSP messages cause a =
NULL
pointer dereference or false success elsewhere?

Looking at r535_gsp_msgq_recv() in
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c, if an RPC message le=
ngth
exceeds the maximum size, it issues a WARN_ON and returns NULL instead of an
ERR_PTR:

r535_gsp_msgq_recv() {
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;
    ...
}

This NULL propagates up through r535_gsp_msg_recv() and nvkm_gsp_rpc_push()
back to wrappers. Callers expecting a payload use IS_ERR() to check for err=
ors,
but since IS_ERR(NULL) is false, do these callers incorrectly treat the fai=
lure
as a success?

For example, in r535_gsp_get_static_info():

r535_gsp_get_static_info() {
    ...
    rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, =
sizeof(*rpc));
    if (IS_ERR(rpc))
        return PTR_ERR(rpc);

    gsp->internal.client.object.client =3D &gsp->internal.client;
    gsp->internal.client.object.parent =3D NULL;
    gsp->internal.client.object.handle =3D rpc->hInternalClient;
    ...
}

Could this bypass lead to a direct NULL pointer dereference, or cause silent
hardware operation failures in functions like nvkm_gsp_rpc_wr() and
nvkm_gsp_rm_alloc_wr() that similarly only check IS_ERR()?

[Severity: High]
This is also a pre-existing issue, but while reviewing the RPC push logic, =
is
there a memory leak in r535_gsp_rpc_push() for large payloads on error path=
s?

When the payload size exceeds the maximum, r535_gsp_rpc_push() splits it in=
to
continuation chunks. The original message memory, allocated by
nvkm_gsp_rpc_get(), is not passed to the command queue (which would normally
take ownership). Instead, r535_gsp_rpc_push() attempts to free it manually
only upon successful reply handling:

r535_gsp_rpc_push() {
    ...
        /* Wait for reply. */
        repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
                                         sizeof(*rpc));
        if (!IS_ERR(repv))
            kvfree(msg);
    } else {
        repv =3D r535_gsp_rpc_send(gsp, payload, policy, gsp_rpc_len);
    }

done:
    mutex_unlock(&gsp->cmdq.mutex);
    return repv;
}

If sending the chunks fails or if the reply contains an error (such as the =
GSP
rejecting the command), the function jumps to the done label and returns
without freeing the message.

Since callers typically overwrite their pointer with the return value of
nvkm_gsp_rpc_push() and assume ownership was passed, does this permanently
leak the original payload memory if userspace issues large RPCs that get
rejected?

>  		return -EIO;
> =20
>  	rpc->params.hRoot =3D client->object.handle;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D3
