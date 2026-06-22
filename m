Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603FDCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C532910E5AC;
	Mon, 22 Jun 2026 09:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cwp0ijmD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0497410E5AC
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:30:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBD9D40700;
 Mon, 22 Jun 2026 09:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0131F000E9;
 Mon, 22 Jun 2026 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120626;
 bh=D5zsdHc3bIHfdi9KXbc4E1ScOk0IFSivBGjVwcWEr3E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cwp0ijmD7v2EHJNqhlpJ9voCvQyjEF0LDrkhDSpAkfWTxuWNR1UPmo2VH+6iZam2x
 KDinsWhaT1MO1SoK/RAp50rutr0h02lLD+ovvoWprnqDAeNejm9uP8Vnm4Fj2xjC12
 MP52jgYD/DuQhfMWq+aOwLe3fzWCbej6+YEN8vLSr8W1umAhjTki3vDHSEZZhZcHcb
 KkCPWZ6B30cuj62zeNZC1gJ3yAScnUqN/8/rds5flf7ApHTcHmk9XqbUqG8Dxr48R9
 Z6d7t7+dRF/rZ9qySYtBN/YdqgjvR8Sw0rkoUDgw7QlVHUXyurPnzc+WkIEvKpMEHL
 5PlqvHHVzElLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119051174100.14287.seg@mailgw.kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <1782119051174100.14287.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:30:26 +0000
Message-Id: <20260622093026.8A0131F000E9@smtp.kernel.org>
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
- [High] `r535_gsp_msgq_recv()` incorrectly returns `NULL` instead of an `E=
RR_PTR` when receiving a message exceeding `max_rpc_size`, leading to NULL =
pointer dereferences in upstream callers.
- [Medium] In `r535_gsp_rpc_push()`, when a large RPC payload encounters an=
 error during transmission or waiting for a reply, the original message buf=
fer is leaked.
--

commit c28b7cbd3dab1fd32a31ef4df86d6f6aaf9ad40b
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage

This commit updates r535_bar_bar2_update_pde() to use IS_ERR() instead of
IS_ERR_OR_NULL() when checking the return value of nvkm_gsp_rpc_get(). This
aligns with the function's contract of never returning NULL.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> index fae08ac3b18c7..9cd68f8622d36 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> @@ -55,7 +55,7 @@ r535_bar_bar2_update_pde(struct nvkm_gsp *gsp, u8 page_=
shift, u64 pdbe)
>  	rpc_update_bar_pde_v15_00 *rpc;
> =20
>  	rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_UPDATE_BAR_PDE, size=
of(*rpc));
> -	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
> +	if (WARN_ON(IS_ERR(rpc)))
>  		return -EIO;
> =20
>  	rpc->info.barType =3D NV_RPC_UPDATE_PDE_BAR_2;

[Severity: High]
This is a pre-existing issue, but there is a case where the GSP RPC
infrastructure incorrectly returns a NULL pointer. If the message queue
receives an unexpectedly large message:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
	mqe =3D r535_gsp_msgq_get_entry(gsp);
	rpc =3D (struct nvfw_gsp_rpc *)mqe->data;

	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;
...
}

This NULL return value propagates up through r535_gsp_msg_recv() and
r535_gsp_rpc_handle_reply(), causing nvkm_gsp_rpc_rd() to return NULL.

Does this lead to a NULL pointer dereference in callers like
r535_gsp_get_static_info() since they only validate the result with IS_ERR(=
)?

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c:r535_gsp_get_static_i=
nfo() {
	rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, siz=
eof(*rpc));
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);

	gsp->internal.client.object.client =3D &gsp->internal.client;
...
	gsp->internal.client.object.handle =3D rpc->hInternalClient;
...
}

[Severity: Medium]
This is also a pre-existing issue, but does the slow path in
r535_gsp_rpc_push() leak the original message buffer when an error occurs?

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
...
	if (payload_size > max_payload_size) {
...
		/* Send initial RPC. */
		next =3D r535_gsp_rpc_get(gsp, fn, max_payload_size);
		if (IS_ERR(next)) {
			repv =3D next;
			goto done;
		}
...
		/* Wait for reply. */
		repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
						 sizeof(*rpc));
		if (!IS_ERR(repv))
			kvfree(msg);
	} else {
...
done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;
}

In the fast path, r535_gsp_cmdq_push() takes ownership and unconditionally
frees the buffer. However, in the chunked sending path above, if there is an
error getting a chunk (IS_ERR(next)) or receiving a reply (IS_ERR(repv)),
execution jumps to the done label without calling kvfree(msg). Could this
permanently leak the large payload buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D4
