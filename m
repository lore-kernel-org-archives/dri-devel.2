Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445A6CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AF810E5A3;
	Mon, 22 Jun 2026 09:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HMXIwcem";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8329310E59D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:19:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD3A060051;
 Mon, 22 Jun 2026 09:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715821F000E9;
 Mon, 22 Jun 2026 09:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119986;
 bh=gbf9TV36saUkZjvoF/iR0QLMgzN1KfkptuapVz2fInA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HMXIwcemr9SxoWg2vH50r2r4JT4ZCm7MOtal8kQyioIO8quMOp/MAVaxNoYSW925h
 OutzUX+dp6/gfQJ/ChV2xYekS/rxihJfh+ASVtaIjNaY6Mhhyc3O5U3q51CMef1FGl
 uZHiVm7K8w5Ea3LyYP4fjW23mRZlOQpxX7TUKe8Js8kobdXy2oddOiO3X+USSf31vD
 QgMuDy14QuHgmwhQyljrqT0EIqsViTfmy4rkAj9XCtR89tubIN6FUWMBcB1XpO/ZNq
 XUZ3SjJtG7Z8Z9JWVJiU78N/mNFahL+hwNvmqFqt+6/+FIDrDic5ySyW1rGEzyn7aG
 iD7OSaOLBcemg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] nouveau/gsp/rpc: Document RPC function return
 value  contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119053312460.17267.seg@mailgw.kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <1782119053312460.17267.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:19:46 +0000
Message-Id: <20260622091946.715821F000E9@smtp.kernel.org>
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
- [High] Returning NULL on an invalid RPC message length deadlocks the mess=
age queue and causes downstream wrappers to treat errors as success, leadin=
g to NULL pointer dereferences.
- [High] Lack of bounds checking on continuation chunks allows a malformed =
or malicious GSP message to cause integer underflows and heap buffer overfl=
ows.
- [High] The original split RPC message buffer is leaked on error paths whe=
n the payload exceeds max_payload_size.
--

commit b2d404f83fcf801450f3eade502dc33e20d3fbe6
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp/rpc: Document RPC function return value contracts

This commit adds kernel-doc comments to document the return value semantics
of RPC functions in the Nouveau GSP RM r535/rpc.c file.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..2ca6de4094e63 100644
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
>  {

[Severity: High]
This is a pre-existing issue, but does returning NULL here when the RPC
length is invalid cause the message queue to deadlock and trigger NULL
pointer dereferences downstream?

Looking at r535_gsp_msgq_recv(), it returns NULL without advancing the read
pointer:

	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;

Several downstream functions seem to mishandle this NULL return. For
example, in r535_gsp_rpc_rm_ctrl_push():

	if (IS_ERR_OR_NULL(rpc)) {
		*params =3D NULL;
		return PTR_ERR(rpc);
	}

This converts IS_ERR_OR_NULL(NULL) to PTR_ERR(NULL) =3D=3D 0, signaling
success to the caller while setting *params to NULL.

Similarly, nvkm_gsp_rm_alloc_wr() checks IS_ERR(repv) and returns success
since IS_ERR is false for NULL. Callers like r535_gsp_get_static_info()
then check the reply with IS_ERR() instead of IS_ERR_OR_NULL(), leading
directly to a NULL pointer dereference.


[Severity: High]
This is also a pre-existing issue in r535_gsp_msgq_recv(), but can a
malformed GSP message cause integer underflows and heap overflows during
continuation chunk processing?

In the continuation loop:

	info.gsp_rpc_len =3D rpc->length;
	info.continuation =3D true;

	rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);
	...
	size =3D info.gsp_rpc_len - sizeof(*rpc);
	expected -=3D size;

If rpc->length is less than sizeof(*rpc), the subtraction for size will
underflow to a massive value, which then appears to cause an out-of-bounds
memcpy in r535_gsp_msgq_recv_one_elem(). Is there a missing bounds check
against the remaining expected capacity and the minimum header size?

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
>  		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)

[Severity: High]
This is a pre-existing issue, but does this function leak the original
split RPC message buffer on error paths?

In r535_gsp_rpc_push(), when the payload exceeds max_payload_size, it is
chunked and sent iteratively. If an intermediate chunk fails to send, the
code jumps to the done label:

			repv =3D r535_gsp_rpc_send(gsp, next, NVKM_GSP_RPC_REPLY_NOWAIT, 0);
			if (IS_ERR(repv))
				goto done;
...
		if (!IS_ERR(repv))
			kvfree(msg);

done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;

Because kvfree(msg) is only executed if the operations are successful
(!IS_ERR(repv)), does the original msg buffer remain permanently leaked
when an error occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D1
