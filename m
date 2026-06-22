Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E001CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8B410E676;
	Mon, 22 Jun 2026 12:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nwgu9944";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FFA010E677
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:09:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F556600AF;
 Mon, 22 Jun 2026 12:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB5C1F000E9;
 Mon, 22 Jun 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782130151;
 bh=eDpcbW0he+17x/UFTqafsfroyzwaK3aUmvw/uE1MHJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nwgu9944FPm+OR5zNbBo8lTtUIrxwm6NTcjXSaHh/NjKZzPt7fC3bW1WY0cIuPRSt
 fzZUoZLAgpuFbD2Ng811TFsjyAwRSKCWf3OSA/iUoZdbizUJ40xEq/AO2yd6WnXJ21
 nXOJVoRDr6rKeaQLLHpZzRN0BdczboscG+B4yOBcuIYJFTJ2/OtnkfRCHD9BQiekLU
 frwrHg50Sw3tomTNEMMYGDEpCOwCaArfCkQw2OB6NMwHnwU3bJ0UDCiB0lKV0FblfA
 UwUiKl6KiKBjlnMMgmRQIassYJY6Vx1mT5O3HerVRpTTMgJtZYN94JbgpROBH4KvPS
 PIwbhyrlATxLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119054234413.17986.seg@mailgw.kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <1782119054234413.17986.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 12:09:10 +0000
Message-Id: <20260622120910.EDB5C1F000E9@smtp.kernel.org>
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
- [High] The commit message explains that `nvkm_gsp_rpc_push()` should not =
return `NULL` for RECV policies, but this assumption is incorrect, leaving =
callers vulnerable to NULL pointer dereferences.
- [Medium] Memory leak of large RPC payloads in `r535_gsp_rpc_push()` on er=
ror paths.
--

commit 1659548cc5b32b66b3c5a9f4367151960bb1562d
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
This isn't a bug introduced by this patch, but is this description accurate?

If the RPC reply has an invalid length, r535_gsp_msgq_recv() returns NULL:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
...
	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;
...
}

This NULL propagates up through r535_gsp_msg_recv() and
r535_gsp_rpc_handle_reply(), causing nvkm_gsp_rpc_push() to return NULL even
with the RECV policy.

Since callers like r535_gsp_get_static_info() only check IS_ERR(), won't th=
ey
dereference the NULL pointer?

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c:r535_gsp_get_static_i=
nfo() {
...
	rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_STATIC_INFO, 0);
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);

	gsp->internal.client.object.client =3D &gsp->internal.client;
	gsp->internal.client.object.parent =3D NULL;
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

[Severity: Medium]
This is a pre-existing issue, but does r535_gsp_rpc_push() leak memory on
error paths for large payloads?

If a large RPC payload fails to send, the kvfree(msg) call is skipped:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
...
		/* Wait for reply. */
		repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
						 sizeof(*rpc));
		if (!IS_ERR(repv))
			kvfree(msg);
	} else {
		repv =3D r535_gsp_rpc_send(gsp, payload, policy, gsp_rpc_len);
	}
...
}

Since small RPCs unconditionally free msg via r535_gsp_cmdq_push(), callers
assume the RPC layer consumes the buffer. Will this leak the large staging
buffer if r535_gsp_rpc_get(), r535_gsp_rpc_send(), or
r535_gsp_rpc_handle_reply() fails and returns an error pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D5
