Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C8ACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC4410E599;
	Mon, 22 Jun 2026 09:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQCfiTWE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5F310E591
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D52F60051;
 Mon, 22 Jun 2026 09:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4421F000E9;
 Mon, 22 Jun 2026 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119902;
 bh=2/Q0nglIACrmBkS62rybEAKEm8rOWzNArvYdUBreeUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQCfiTWEZ2zMWSJ6VBQ+RdVLMgj6pVb9snxKxQ+WKC5uEJGGPcBhBq6jE/gx6V/oy
 maZNmeBqinh6Q54+Poalvu7j4B1SNqZ2YScA/1A0T/HUJKjSvGqv5fB6EK7lG8Lqbw
 lpZ5tucjsNDD172S2/3ph5TxLWcpkKlDElt34VfHCwJTZu1B91XB8LpR/TntQ0InZI
 nyGqwUpU8Xwz6V13Ejav6RtzOI1Gq0O1jpTcj4YdFZ4evuGG31H9IPYEfAV9nrzb3s
 7/ZLT/M9Qkc1W3SYp0/PN+//OZ9/9ce+TGEohBvfJaE275IhJ0IdZq2iuywhXKlF/Y
 RnbQ/YZhIehtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] nouveau/gsp/rpc: Document RPC function return
 value  contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119051178129.14294.seg@mailgw.kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <1782119051178129.14294.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:18:21 +0000
Message-Id: <20260622091822.1B4421F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Missing bounds check on a continuation record's length leads t=
o massive integer underflow and a kernel panic.
- [High] Memory leak in `r535_gsp_rpc_push()` when an error occurs while ha=
ndling a large payload that requires chunking.
- [High] The `r535_gsp_msgq_recv` function returns `NULL` on an invalid RPC=
 length, which is incorrectly propagated as a success state.
- [High] Data corruption and uninitialized memory gaps occur when a large c=
ontinuation record wraps around the message queue ring buffer.
--

commit 1bc0e8927764cf75b9678605ae80d0c1fd535eb5
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp/rpc: Document RPC function return value contracts

This commit adds kernel-doc comments to document the return value semantics
of RPC functions in r535/rpc.c. It clarifies which functions return NULL,
error pointers, or both to help validate future changes.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..b4b2b5c00ab4e 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c

[ ... ]

> @@ -229,6 +238,14 @@ struct r535_gsp_msg_info {
>  static void
>  r535_gsp_msg_dump(struct nvkm_gsp *gsp, struct nvfw_gsp_rpc *msg, int lv=
l);
> =20
> +/**
> + * r535_gsp_msgq_recv_one_elem - Receive one message element from GSP qu=
eue
> + * @gsp: GSP device
> + * @info: Message queue information
> + *
> + * Return: Pointer to received buffer on success, or ERR_PTR() on error.
> + *         Never returns NULL.
> + */
>  static void *
>  r535_gsp_msgq_recv_one_elem(struct nvkm_gsp *gsp,

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check on the
continuation record length here?

In r535_gsp_msgq_recv(), the length of a continuation record is read
directly from the hardware:

    info.gsp_rpc_len =3D rpc->length;
    info.continuation =3D true;

If a compromised or buggy GSP firmware returns a length smaller than
sizeof(struct nvfw_gsp_rpc) (32 bytes), len becomes less than 32 in
r535_gsp_msgq_recv_one_elem(). The subtraction:

    len - sizeof(struct nvfw_gsp_rpc)

will underflow to a massive positive value, causing memcpy() to attempt
an out-of-bounds copy and panic the kernel.

[Severity: High]
This is another pre-existing issue in this function, but does this code
cause data corruption when a continuation record wraps around the ring
buffer?

When copying a continuation record, the 32-byte header is stripped in the
first memcpy():

    memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
           len - sizeof(struct nvfw_gsp_rpc));

However, if the element wraps around, the second memcpy() writes to
buf + len:

    if (expected) {
            mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + 0x1000 + 0 * 0x1000);
            memcpy(buf + len, mqe, expected);
    }

Should this second memcpy() be writing to buf + len - sizeof(struct nvfw_gs=
p_rpc)
instead? Writing to buf + len leaves a 32-byte gap of uninitialized memory
and shifts the tail data forward, which will be overwritten by the next
continuation payload.

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

[Severity: High]
This isn't a bug introduced by this patch, but does the documentation here
cement a flawed design?

If rpc->length > max_rpc_size, r535_gsp_msgq_recv() returns NULL. This
propagates through r535_gsp_msg_recv() and r535_gsp_rpc_handle_reply().
Because NULL is also the expected success return value for POLL mode,
callers like r535_gsp_rpc_poll() treat the invalid length error as a
success. Other callers expecting ERR_PTR on error might dereference NULL.

>  static void *
>  r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)

[ ... ]

> @@ -628,6 +704,17 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u32 fn, u32 p=
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

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak memo=
ry
on the error path for large payloads?

When payload_size > max_payload_size, the original msg buffer is not passed
to r535_gsp_cmdq_push(), which would normally free it. Instead, it is manua=
lly
freed at the end of the chunking process:

    if (!IS_ERR(repv))
            kvfree(msg);

If any step fails during the chunking process, such as r535_gsp_rpc_send()
returning an ERR_PTR(), the code branches to the done label:

    if (IS_ERR(repv))
            goto done;

This bypasses the kvfree(msg) check at the end of the block, permanently
leaking the msg allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D1
