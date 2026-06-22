Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAECCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7829110E458;
	Mon, 22 Jun 2026 04:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aoHMiaAb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31AD10E458
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:09:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F15F56008A;
 Mon, 22 Jun 2026 04:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905931F000E9;
 Mon, 22 Jun 2026 04:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782101369;
 bh=pPD+YSnpftIZvh9588fMbq3Fwk5S4UZ6G2/BlGXRtrE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aoHMiaAbK7yvviB6MFKSqthikaWcA0mu9KJI7m9ryiemMZOT+h98DpdpbPJhYd+FG
 LIM4+QXb+ri6AVWds4OSeIyfonpHjpuaiAAbFA3V1TBtcvNTbXV0cFMHQfGBjO4blD
 UzvKHBez6S85YSCVDZmH0A9uICGV+wVAumvCQE/tGW2CLwgPedG1NXdv2LwGmISczh
 88HMv4TCiCVsDZim7EIOC3tgjHY4amlroZfT+6OUrReBk+/7U68ekVm/ybnsGn638b
 p2K+ekU5VwAytULF5UNPClcAyqZVq8GEyWVOhPbadKUUYm/z3OrNelU2a7DTnjdkQH
 AS0RpwNMj+4Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622035454.28003-6-zenghongling@kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <20260622035454.28003-6-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:09:29 +0000
Message-Id: <20260622040929.905931F000E9@smtp.kernel.org>
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
- [Critical] The GSP message queue receiver lacks bounds checking on contin=
uation records, allowing a compromised GSP to overflow the host kernel heap.
- [High] `nvkm_gsp_rpc_push()` and `nvkm_gsp_rpc_rd()` can return `NULL` wh=
en expecting a reply (`RECV` policy), contrary to the commit message's clai=
ms, leading to NULL pointer dereferences in callers.
- [High] Memory leak of the original RPC payload (`msg`) in `r535_gsp_rpc_p=
ush()` when handling a large payload (`payload_size > max_payload_size`) an=
d an error occurs.
--

commit 8fadcaf9fa12c03760c8ed228ffe647df6013918
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

nvkm_gsp_rpc_rd() calls nvkm_gsp_rpc_get() which never returns NULL,
only valid pointers or error pointers. Clean up by using IS_ERR()
instead, matching the actual return value contract.

> Note: nvkm_gsp_rpc_push() can return NULL when policy is NOWAIT or
> NOSEQ, but nvkm_gsp_rpc_rd() uses RECV policy which expects a reply.
> If the RPC fails to get a reply, it should return an error pointer,
> not NULL.

[Severity: High]
This is a pre-existing issue, but the commit message states that
nvkm_gsp_rpc_push() cannot return NULL when using the RECV policy. Is this
accurate?

Looking at the call chain, it appears NULL can be returned and propagate up.
For example, r535_gsp_msgq_recv() returns NULL when the payload length
exceeds max bounds:

    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

This NULL propagates through r535_gsp_msg_recv() to
r535_gsp_rpc_handle_reply() and then to nvkm_gsp_rpc_push() before being
returned by nvkm_gsp_rpc_rd().

If callers like r535_gsp_get_static_info() only check IS_ERR(), won't they
subsequently dereference the NULL pointer?

r535_gsp_get_static_info() {
    ...
    rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, =
sizeof(*rpc));
    if (IS_ERR(rpc))
        return PTR_ERR(rpc);
   =20
    gsp->internal.client.object.handle =3D rpc->hInternalClient;
    ...
}

> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/=
gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index 64fed208e4cf8..a061779e0107b 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -293,7 +293,7 @@ nvkm_gsp_rpc_rd(struct nvkm_gsp *gsp, u32 fn, u32 arg=
c)
>  {
>  	void *argv =3D nvkm_gsp_rpc_get(gsp, fn, argc);
> =20
> -	if (IS_ERR_OR_NULL(argv))
> +	if (IS_ERR(argv))
>  		return argv;
> =20
>  	return nvkm_gsp_rpc_push(gsp, argv, NVKM_GSP_RPC_REPLY_RECV, argc);

[Severity: High]
This isn't a bug introduced by this patch, but does nvkm_gsp_rpc_push() leak
memory on error paths for large payloads?

When processing multi-part chunks in r535_gsp_rpc_push(), the original
message buffer is conditionally freed only on success:

    if (IS_ERR(next)) {
        repv =3D next;
        goto done;
    }
...
    if (!IS_ERR(repv))
        kvfree(msg);
...
done:
    mutex_unlock(&gsp->cmdq.mutex);
    return repv;

If an error occurs, the function jumps to the done label and returns an
error pointer without freeing the msg buffer. Since nvkm_gsp_rpc_rd() expec=
ts
the push operation to consume and free the payload buffer, does this result
in a persistent memory leak?

[Severity: Critical]
This is a pre-existing issue, but does the GSP message queue receiver have a
bounds checking issue that could overflow the host kernel heap?

In r535_gsp_msgq_recv(), if the first message's length is larger than the
expected size, the subtraction underflows:

    info.gsp_rpc_buf +=3D info.gsp_rpc_len;
    expected -=3D info.gsp_rpc_len;

The loop then continuously processes continuation records because expected =
is
now a large non-zero value. It peeks at the next message length and calls
r535_gsp_msgq_recv_one_elem(), which uses memcpy to blindly copy the data:

    if (info->continuation)
        memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
               len - sizeof(struct nvfw_gsp_rpc));
    else
        memcpy(buf, mqe->data, len);

Could a compromised GSP firmware exploit this to overwrite adjacent memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D5
