Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80055CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE29E10E5B2;
	Mon, 22 Jun 2026 09:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f+O8MhIs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE3910E5B2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:32:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3537443A4C;
 Mon, 22 Jun 2026 09:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E616E1F00A3A;
 Mon, 22 Jun 2026 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120752;
 bh=aaWh5S1hiFU3C3HyGMri8UsXGqAxJ02WqfwLXwL2rDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f+O8MhIscjW2HTl4aWelTaurWuR6ySi+FTSHa678kwRNyvwMhMOKWnk4NE1i+qioa
 qMrCKkF5G8S+JtW44NStbWpsGac511862airACkFZnoy3EqNKGV2admxH6zS/xvXPH
 SNVkovGyv00ZSa9MLTh3I8aFkpMhD4EfyCinmjU79l5qnTVqeLIt3k/Kqn5i1NSheY
 9Q+PUIPk44xFvlpTIe0QEygYKjkK+pDpIhGMeGjhztoJBPTbHoqWl7ItmfNd5SC7hO
 ySeptii9pZuCJ8jjssIIAGrTbKAr/r/aMGqzSCEIx+VaHBvaMPZzmRruGJyaA62aNt
 5ffqQT4bvD6UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119051171515.14283.seg@mailgw.kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <1782119051171515.14283.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:32:31 +0000
Message-Id: <20260622093231.E616E1F00A3A@smtp.kernel.org>
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
- [High] NULL pointer dereference when GSP firmware sends a malformed messa=
ge with invalid length.
- [Medium] Memory leak of large RPC request buffers on error paths.
--

commit 71d7ed95d2b3f836cf2bbe162c7b67d89c46964e
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

This patch changes nvkm_gsp_rpc_rd() to check IS_ERR() instead of
IS_ERR_OR_NULL() for the return value of nvkm_gsp_rpc_get(). It also
notes that nvkm_gsp_rpc_push() should return error pointers, not NULL,
when using the RECV policy.

> Note: nvkm_gsp_rpc_push() can return NULL when policy is NOWAIT or
> NOSEQ, but nvkm_gsp_rpc_rd() uses RECV policy which expects a reply.
> If the RPC fails to get a reply, it should return an error pointer,
> not NULL.
>
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

[Severity: High]
This is a pre-existing issue, but is the assumption in the commit message
accurate?

Looking at r535_gsp_msgq_recv() in rpc.c, if a malformed message is
received, it explicitly returns NULL:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;
	...
}

This NULL propagates through the reply handlers to nvkm_gsp_rpc_push(),
which returns it to the caller.

Because callers like r535_gsp_get_static_info() only check IS_ERR(),
this leads to a NULL pointer dereference:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c:r535_gsp_get_static_i=
nfo() {
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);

	gsp->internal.client.object.client =3D &gsp->internal.client;
	...
}

Other callers like r535_gsp_rpc_rm_ctrl_push() implicitly convert this NULL
return to 0 (success) via PTR_ERR(rpc), masking the failure.

Should the underlying r535_gsp_msgq_recv() be modified to return an
ERR_PTR to match the expected contract?

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
        ^^^^

[Severity: Medium]
This is a pre-existing issue, but does r535_gsp_rpc_push() leak the msg
buffer on error paths?

Looking at r535_gsp_rpc_push() in rpc.c, when payload_size > max_payload_si=
ze,
the large msg buffer is freed only on success:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
	...
done:
	if (!IS_ERR(repv))
		kvfree(msg);

	return repv;
}

If any intermediate chunk allocation fails, or if the final reply results
in an error pointer, could this leak the large RPC request buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D5
