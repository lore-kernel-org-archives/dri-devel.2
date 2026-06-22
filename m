Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFABCCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2804710E456;
	Mon, 22 Jun 2026 04:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CIxp2Lh2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B120910E456
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:08:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35F4B601E1;
 Mon, 22 Jun 2026 04:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56151F000E9;
 Mon, 22 Jun 2026 04:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782101306;
 bh=kVJzd3iFNrkKy6yZVuWwduEjcYP9dHkrKXB+M6aLLXc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CIxp2Lh2AqmgSSh7uZEfNN1/uqEn4YTAjv0qucnZot1gt54sYNemZ8HMXeMw5619S
 pvGR4LeYv4jErRCsrpktiQ/xMaeqctI4ynfNeAvdp8u/N+AOR0RTumLPalqjwulAPf
 FUXlL9xwbA27PXeinLVySsWegI9AA6CaHbZYvnquT4Kfl6I+fr+GfEYa/TFLyYfymg
 2aJ/D/HVeHEsu3LDueG2ohXpBFtpVAemiqkzR60fq3pe5j2tzVC8JSCS/0QXlhoAAV
 33kyfMwZ3L6HwfNI4bHWG1x24ib58iIwslyUyXBoH+OJkppAEaDk8VJkFHll7Rpjoo
 XEwlh0DZMcrBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] nouveau/gsp/rpc: Document RPC function return
 value contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622035454.28003-2-zenghongling@kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <20260622035454.28003-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:08:26 +0000
Message-Id: <20260622040826.C56151F000E9@smtp.kernel.org>
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
- [Medium] The documentation for r535_gsp_rpc_done() incorrectly states tha=
t it frees a payload returned by r535_gsp_rpc_get().

Pre-existing issues:
- [High] The newly added documentation for RPC functions introduces contrad=
ictory return value contracts that mask a pre-existing NULL pointer derefer=
ence bug on error paths. Specifically, `r535_gsp_msgq_recv()` returns `NULL=
` when the RPC length is invalid, which propagates up and causes a NULL poi=
nter dereference in higher-level callers, contradicting the newly added doc=
s that claim `ERR_PTR()` is returned on error.
- [High] Large RPC payloads (`payload_size > max_payload_size`) leak the or=
iginal `msg` memory if an error occurs during chunk sending or reply handli=
ng.
--

commit ebdd2cc2dbf735e60a62853951f275c61160e93f
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp/rpc: Document RPC function return value contracts

This commit adds kernel-doc comments to document the return value semantics=
 of
RPC functions in r535/rpc.c. It clarifies which functions can return NULL or
error pointers.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..2ca6de4094e63 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c

[ ... ]

> @@ -663,6 +663,11 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payloa=
d,
>  	return r535_gsp_rpc_handle_reply(gsp, fn, policy, gsp_rpc_len);
>  }
> =20
> +/**
> + * r535_gsp_rpc_done - Free an RPC message
> + * @gsp: GSP device
> + * @repv: Pointer to RPC payload data returned by r535_gsp_rpc_get()
> + */
>  static void
>  r535_gsp_rpc_done(struct nvkm_gsp *gsp, void *repv)

[Severity: Medium]
Is this parameter description accurate?

The payload returned by r535_gsp_rpc_get() is the request, which is
automatically freed upon transmission in functions like r535_gsp_cmdq_push(=
).

It appears r535_gsp_rpc_done() is intended to be used by callers to free
the reply payload returned by r535_gsp_rpc_push() or nvkm_gsp_rm_ctrl_rd().

Could documenting this as freeing the request payload encourage
callers to explicitly free it after sending, leading to a double-free?

[ ... ]

> @@ -704,6 +704,17 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 p=
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
> + * Return: NULL when policy is NOWAIT/NOSEQ (no reply expected) or
> + *         POLL (successful message processing), pointer to reply data
> + *         on success, or ERR_PTR() on error.
> + */
>  static void *
>  r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload,
>  		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)

[Severity: High]
This is a pre-existing issue, but does this documentation mask an underlying
NULL pointer dereference?

r535_gsp_msgq_recv() can return NULL when the RPC length is invalid:

r535_gsp_msgq_recv() {
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;
}

This NULL propagates up to r535_gsp_rpc_push() which the documentation
states will return ERR_PTR() on error. However, if r535_gsp_rpc_push()
returns NULL on an error path, callers like r535_gsp_rpc_rm_ctrl_push()
evaluate PTR_ERR(NULL) as 0 (success):

r535_gsp_rpc_rm_ctrl_push() {
    if (IS_ERR_OR_NULL(rpc)) {
        *params =3D NULL;
        return PTR_ERR(rpc);
    }
}

This causes callers like r535_disp_get_static_info() to assume success
and dereference the NULL pointer:

r535_disp_get_static_info() {
    ctrl =3D nvkm_gsp_rm_ctrl_rd(...);
    if (IS_ERR(ctrl))
        return PTR_ERR(ctrl);
    disp->wndw.mask =3D ctrl->windowPresentMask;
}

Should the documentation note this, or should the underlying NULL
propagation be fixed to return an error pointer?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the
documentation for this function, it appears there is a memory leak
for large RPC payloads in r535_gsp_rpc_push().

When payload_size is greater than max_payload_size, the code allocates
smaller chunks and sends them sequentially. If any chunk fails to send,
the code takes the goto done path:

r535_gsp_rpc_push() {
    ...
    next =3D r535_gsp_rpc_get(gsp, fn, max_payload_size);
    if (IS_ERR(next)) {
        repv =3D next;
        goto done;
    }
    ...
}

At the end of the chunking block, the original msg is only freed if
repv is not an error pointer:

    repv =3D r535_gsp_rpc_handle_reply(...);
    if (!IS_ERR(repv))
        kvfree(msg);

Since callers expect the function to consume the payload and do not free
it on error, doesn't this permanently leak the original msg memory on
these error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D1
