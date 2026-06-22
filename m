Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EA0CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED5910E428;
	Mon, 22 Jun 2026 02:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOO6XGfI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C05810E428
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:28:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4414743C11;
 Mon, 22 Jun 2026 02:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028621F000E9;
 Mon, 22 Jun 2026 02:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782095318;
 bh=k3qxz3QHedtW/QZaJT9hoQH5y3BKD2ExibEaHlHBs7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GOO6XGfIGvwfZ7OCg/sLPZXJpZRToPz9gj/c3R9gq9PzBPb2UVpkwovbYf2+4rqa0
 qpoNdgTgzMn8SQDOA4hUWEX+ETxM3O8G7CaruImseau/S3eTW5noUZ4ZElEFTqWusE
 U8mEDhLd0RpgD3MghOmxvab5RWpaeFE7m1jQRcLhkZRo+brVB3QmeyeIF57Hvt9WRq
 I86hTpDFs/HMG31fJceVYa96lVSirzxJxwEnKP/jm7ZptcCfWUxNx+YrHWXLbXO9gR
 6vCXbr/m/yJTg5ZapyREgwW2NPLMQR+SXiRZ/EYXc4lPxqMo6TXDMwBcodfS3cb/ZU
 Y6h+/1DRN/ywA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622021207.14764-6-zenghongling@kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <20260622021207.14764-6-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:28:37 +0000
Message-Id: <20260622022838.028621F000E9@smtp.kernel.org>
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
- [High] A malformed GSP message size causes r535_gsp_msgq_recv() to return=
 NULL, which propagates through nvkm_gsp_rpc_rd() and leads to a NULL point=
er dereference in its callers.
--

commit 604de241374540fdccd3d8af5fec3fe8ff826d71
Author: Hongling Zeng <zenghongling@kylinos.cn>

    nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

    This commit cleans up nvkm_gsp_rpc_rd() by replacing IS_ERR_OR_NULL()
    with IS_ERR(). The commit message notes that nvkm_gsp_rpc_push() expects
    a reply under the RECV policy and should return an error pointer rather
    than NULL if the RPC fails.

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
This is a pre-existing issue, but does nvkm_gsp_rpc_push() strictly return
an error pointer instead of NULL on failure under the RECV policy?

If the GSP firmware returns an RPC message with an invalid length,
r535_gsp_msgq_recv() triggers a WARN_ON and returns NULL:

r535_gsp_msgq_recv() in drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc=
.c:

	...
	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;
	...

This NULL propagates up through r535_gsp_msg_recv() and
r535_gsp_rpc_handle_reply() to nvkm_gsp_rpc_push(), which is then returned
directly by nvkm_gsp_rpc_rd() here.

Since callers like r535_gsp_get_static_info() only check IS_ERR(), could th=
is
lead to a NULL pointer dereference?

r535_gsp_get_static_info() in drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r5=
35/gsp.c:

	...
	rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, siz=
eof(*rpc));
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);

	gsp->internal.client.object.client =3D &gsp->internal.client;
	gsp->internal.client.object.parent =3D NULL;
	gsp->internal.client.object.handle =3D rpc->hInternalClient;
	...

Similarly, does r535_gsp_rpc_rm_ctrl_push() mishandle this NULL?

r535_gsp_rpc_rm_ctrl_push() in drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r=
535/ctrl.c:

	...
	repv =3D nvkm_gsp_rpc_push(gsp, rpc, repc ? NVKM_GSP_RPC_REPLY_RECV :
					   NVKM_GSP_RPC_REPLY_NOWAIT, repc);
	if (IS_ERR_OR_NULL(repv)) {
		*params =3D NULL;
		return PTR_ERR(repv);
	}
	...

If nvkm_gsp_rpc_push() returns NULL, PTR_ERR(repv) evaluates to 0 (success),
which causes it to return success while passing a NULL pointer back to call=
ers
like r535_gsp_intr_get_table().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D5
