Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECCFCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD2A10E59D;
	Mon, 22 Jun 2026 09:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KTM91jez";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9678810E5A0
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:20:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80B844441D;
 Mon, 22 Jun 2026 09:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A6A1F000E9;
 Mon, 22 Jun 2026 09:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120018;
 bh=vo6H2OSHjszlNWh7/fRYc3SR1uC+cL/OAxORUBr3H6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KTM91jezjT032+3mEtcBRoYBIb58g5o3W57dIgeadP/Easr6OIF3SIcIOaRXFQEgH
 jIfoX45/jBeKRlapYut3yb8ZYsXjruTtdfL5WZ2Bss9EQZPkUCUzmKK98MCEJ6Llmm
 XVrl5nSQauPpwu1GfoVaOkeSX2apODfyD1hmZG3tqcAosYU54wPX1MwY2PvGp/98fB
 6H2amADc68bSbAuY4MfEbSfI37qvzzGN3+acGI3rIFhVblejyn+BuKKUc16zTq9VYx
 9/wWTQVl0wJTyNfNq1uuZ2hE8b3z6o/bafs+hw5VxDV4ZYWi1a4lZ01NSCXZ2LWvIw
 rcaEZxNK3NIpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] nouveau/gsp/rpc: Document RPC function return
 value  contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119054239712.17995.seg@mailgw.kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <1782119054239712.17995.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:20:17 +0000
Message-Id: <20260622092018.44A6A1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The newly added kernel-doc claims that several high-level RPC fu=
nctions only return ERR_PTR on error, but they can actually propagate NULL.

Pre-existing issues:
- [High] Returning NULL on an invalid RPC message length causes a queue dea=
dlock and subsequent NULL pointer dereferences in downstream callers that o=
nly check IS_ERR().
--

commit db05356d173cc7558f718a62efd7f0f223cf7152
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Document RPC function return value contracts

This commit adds kernel-doc comments to document the return value semantics
of RPC functions in the nouveau GSP code to clarify which functions can
return error pointers or NULL.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..35272c1538699 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c

[ ... ]

> @@ -283,6 +300,15 @@ r535_gsp_msgq_recv_one_elem(struct nvkm_gsp *gsp,
>  	return buf;
>  }
> =20
> +/**
> + * r535_gsp_msgq_recv - Receive RPC message(s) from GSP queue
> + * @gsp: GSP device
> + * @gsp_rpc_len: Expected RPC length
> + * @retries: Retry counter
> + *
> + * Return: Pointer to received buffer on success, ERR_PTR() on error,
> + *         or NULL if RPC length is invalid.
> + */
>  static void *
>  r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)

[Severity: High]
This is a pre-existing issue, but does returning NULL here on an invalid RPC
message length cause issues for callers?

When r535_gsp_msgq_recv() encounters an invalid length, it returns NULL
without advancing the queue read pointer:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
        if (WARN_ON(rpc->length > max_rpc_size))
                return NULL;
        ...
}

This NULL return propagates up to API wrappers like nvkm_gsp_rpc_rd() and
nvkm_gsp_rpc_wr(). Downstream callers such as r535_gsp_get_static_info()
check for errors using IS_ERR(). Since IS_ERR(NULL) is false, the error che=
ck
is bypassed. This leads to silent successes (like PTR_ERR(NULL) =3D=3D 0) or
immediate NULL pointer dereferences when the payload is accessed.

Also, since the queue read pointer is not advanced, wouldn't subsequent rea=
ds
process the same invalid message and deadlock the queue?

[ ... ]

> @@ -450,6 +476,20 @@ r535_gsp_msg_dump(struct nvkm_gsp *gsp, struct nvfw_=
gsp_rpc *msg, int lvl)
>  	}
>  }
> =20
> +/**
> + * r535_gsp_msg_recv - Receive RPC message from GSP message queue
> + * @gsp: GSP device
> + * @fn: Expected RPC function number (0 to accept any)
> + * @gsp_rpc_len: Expected RPC length (0 for POLL mode)
> + *
> + * Return: Pointer to RPC message on success, ERR_PTR() on error.
> + *         When fn!=3D0: retries until timeout, returns ERR_PTR(-ETIMEDO=
UT)
> + *                    if no match found (never returns NULL for timeout).

[Severity: Medium]
Is this documentation accurate regarding error returns?

The kernel-doc states this function returns ERR_PTR() on error, but it
can actually propagate the NULL returned by r535_gsp_msgq_recv() when an
invalid RPC length is encountered:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msg_recv() {
        ...
        rpc =3D r535_gsp_msgq_recv(gsp, gsp_rpc_len, &retries);
        if (IS_ERR_OR_NULL(rpc))
                return rpc;
        ...
}

Could this mislead developers into incorrectly replacing IS_ERR_OR_NULL()
checks with IS_ERR() in the callers?

[ ... ]

> @@ -628,6 +703,16 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 p=
ayload_size)
>  	return rpc->data;
>  }
> =20
> +/**
> + * r535_gsp_rpc_push - Push RPC message to GSP and wait for reply
> + * @gsp: GSP device
> + * @payload: RPC payload to send
> + * @policy: Reply policy (NOWAIT, NOSEQ, RECV, or POLL)
> + * @gsp_rpc_len: Expected RPC length in the reply
> + *
> + * Return: NULL when policy is NOWAIT/NOSEQ (no reply expected),
> + *         pointer to reply data on success, or ERR_PTR() on error.
> + */
>  static void *
>  r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload,

[Severity: Medium]
Does this documentation also hide a potential NULL return on error?

Similar to r535_gsp_msg_recv() above, this function can return NULL on error
if an invalid RPC length propagates up from the reply handler. Should the
documentation reflect that NULL can be returned as an error state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D1
