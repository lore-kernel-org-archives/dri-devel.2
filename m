Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE2ACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4851310E54A;
	Mon, 22 Jun 2026 08:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M06rDlHy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E533D10E53E
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:21:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 449B96001A;
 Mon, 22 Jun 2026 08:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A1E1F000E9;
 Mon, 22 Jun 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782116517;
 bh=AOaq6TcXM9yXQyqmPbEcKZ3rqtjfjky/8YWYlLsTo0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M06rDlHy0Aay+xo0kOabjb0SCO0Q1M7BpmGC02kYQgPCQTJRXadcKWkqEQCsPA6Zg
 l/ujQyVe99avrjRtZ9CiNTlvx8WHEgRrBfZyzy2bOJGKOcDK2SRWJZOiTV6A4K6sAV
 SgA5/o4nC9lKHAKaK0ilM770V5BqxQDZLW0Zh0nLqxn4JFRkQdqloMjFvN3/iEO0E3
 ZLykHQwnjCgklW+d4SQHkp+NLWqcBM1LTQJAGq8icfc+6HvdB3OPgct3FqiB1Eoj0n
 62f58vaPaYjI/klbURG5os6vgnvbx4rn1u/6YxxxJFxJUIC3QoPQz4oulHvltpIuVE
 TSX2Rm5ru9Mcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] nouveau/gsp/rpc: Document RPC function return
 value  contracts
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622081136.61695-2-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <20260622081136.61695-2-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:21:56 +0000
Message-Id: <20260622082156.D2A1E1F000E9@smtp.kernel.org>
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
- [High] RPC error path propagates NULL instead of ERR_PTR(), leading to si=
lent failures and NULL pointer dereferences.
--

commit 79a7510afd6195ece62a51a8ba00ae15d75a0ac9
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Document RPC function return value contracts

Add kernel-doc comments to document the return value semantics of
RPC functions in r535/rpc.c. This clarifies which functions can return
NULL, error pointers, or both.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 3ca3de8f43408..b4b2b5c00ab4e 100644
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

[Severity: High]
This is a pre-existing issue, but does documenting NULL as a valid return
for an invalid RPC length mask an existing bug in the error path?

Currently, r535_gsp_msgq_recv() returns NULL when the length is invalid:

	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;

This NULL propagates up through r535_gsp_msg_recv() and=20
r535_gsp_rpc_handle_reply() to callers like r535_gsp_get_static_info(),
which only checks for an error pointer:

	rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, siz=
eof(*rpc));
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);
=09
	gsp->internal.client.object.handle =3D rpc->hInternalClient;

Since IS_ERR(NULL) evaluates to false, this leads to an immediate NULL
pointer dereference.

In other cases like r535_gsp_rpc_rm_ctrl_push(), the error is silently
swallowed:

	rpc =3D nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
	if (IS_ERR_OR_NULL(rpc)) {
		*params =3D NULL;
		return PTR_ERR(rpc);
	}

Because PTR_ERR(NULL) evaluates to 0, the function incorrectly returns
success on a failed RPC message.

Should r535_gsp_msgq_recv() be changed to return an error pointer like
ERR_PTR(-EIO) instead of NULL, and the documentation updated to reflect
that failure mode?

>  static void *
>  r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_len, int *retries)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D1
