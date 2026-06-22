Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4D8CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDF310E211;
	Mon, 22 Jun 2026 02:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cmbbwqka";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B331B10E211
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:27:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D19E431FE;
 Mon, 22 Jun 2026 02:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1511F000E9;
 Mon, 22 Jun 2026 02:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782095229;
 bh=ZW+PEVkCQqO5yN67duYNKad25WJ0UHlT3R88OqCXejs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cmbbwqkaZVLSMncl71W7/fnJ/lgHM/EpYMumm/2n2AlyyvPlXPBJRk0/2PBJNxWJM
 vLd/eMGSr8cwrgFARDxJXeB+a5Gs8IoKpt1Z10EL7tW9sITzY5FG0lOR4vlcJjvn/R
 GBKjIdo/YDNd+K+E9IiYkLlWwCdrv449vVw9NcxqjO5xpfSIu+Bb5+/V3ktqCassXF
 /2YCR2IKZhs2AcoinCfieRIhr9U/ngAKwzaDB8tcG21Z2FGxYj1/CXjy3jxtLqiP21
 SyVnk/khNVJsoD/Z8FOiNMKGnxb4+Kw1ka6tnsG6p3IVmouNP68FksDH+UGO/BdvyU
 1jcoFSB/oex6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622021207.14764-5-zenghongling@kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <20260622021207.14764-5-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:27:09 +0000
Message-Id: <20260622022709.5B1511F000E9@smtp.kernel.org>
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
- [Medium] The original GSP message wrapper (`msg`) is leaked on error path=
s when pushing large RPC payloads.
--

commit 983901af13a13a0d204f00f3cb9a175b176bf22f
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage

r535_bar_bar2_update_pde() calls nvkm_gsp_rpc_get() which never
returns NULL, only valid pointers or error pointers. Clean up by
using IS_ERR() instead, matching the actual return value contract.

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

[Severity: Medium]
This isn't a bug introduced by this patch, but does the GSP message wrapper
leak on error paths when pushing large RPC payloads?

In drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push(=
):

	if (payload_size > max_payload_size) {
		...
		/* Send initial RPC. */
		next =3D r535_gsp_rpc_get(gsp, fn, max_payload_size);
		if (IS_ERR(next)) {
			repv =3D next;
			goto done;
		}
		...
		repv =3D r535_gsp_rpc_send(gsp, next, NVKM_GSP_RPC_REPLY_NOWAIT, 0);
		if (IS_ERR(repv))
			goto done;
		...
		/* Wait for reply. */
		repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
						 sizeof(*rpc));
		if (!IS_ERR(repv))
			kvfree(msg);
	} else {

If a payload exceeds max_payload_size, the original msg wrapper is retained
while the payload is sent in chunks using new messages. The chunks are
properly freed by the inner r535_gsp_cmdq_push(), but the original msg is
only freed at the end if no error occurred.

If an error occurs at any point (e.g., r535_gsp_rpc_get() fails,
r535_gsp_rpc_send() fails, or the final reply is an error pointer), the
function exits without freeing msg.

Callers such as r535_gsp_rpc_rm_ctrl_push() clear their pointers on error:

	if (IS_ERR_OR_NULL(rpc)) {
		*params =3D NULL;
		return PTR_ERR(rpc);
	}

so they cannot free the message either, which appears to result in a memory
leak on these error paths.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D4
