Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F54CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4FB10E591;
	Mon, 22 Jun 2026 09:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QjY2gxkX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B49410E591
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:18:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 207E060051;
 Mon, 22 Jun 2026 09:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE9A1F00A3A;
 Mon, 22 Jun 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119933;
 bh=aib2t0mrMNk3e8Cm64nUBMJHuxvZM+l0c9/kF2bypnw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QjY2gxkXsw5LVg9q3HqHxaIRmTZyo2Kk8BqcwbXUpwzGuyN3BQLiVzMx8i+JyjMmA
 7mFdMEBQe8d7crIVGJDUaX4Y/WJN+HXdbzSIJiXBkSqFHqp7MU1CyS22eh7G74ne1J
 ZVq+NhffiOvTIG8UzFPf82Gk44raqK4eEay3ZX3geANiKmqncUw811o4nmGRyd7ELq
 5VNmGzMRKrqR1eHtL48tWFx1LX2zVGA1yTweiPkqpL8nNcNyoa89QMLw2bWb0FTVyS
 sb6Zb7Zj0SeIsiSwgoyyEFu+lAQDThx2hsERymw1VVh8Tu3fJT3U7K3Yv7YbITXFEY
 Wittv6H8RrFWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119053307777.17259.seg@mailgw.kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <1782119053307777.17259.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:18:53 +0000
Message-Id: <20260622091853.AEE9A1F00A3A@smtp.kernel.org>
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
- [High] NULL pointer dereference and error masking when GSP firmware sends=
 a malformed RPC message.
--

commit 3c4145ccdcc776937c8bd4a94334b6cf663fc7eb
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()
   =20
nvkm_gsp_rpc_rd() calls nvkm_gsp_rpc_get() which never returns NULL,
only valid pointers or error pointers. Clean up by using IS_ERR()
instead, matching the actual return value contract.
   =20
> Note: nvkm_gsp_rpc_push() can return NULL when policy is NOWAIT or
> NOSEQ, but nvkm_gsp_rpc_rd() uses RECV policy which expects a reply.
> If the RPC fails to get a reply, it should return an error pointer,
> not NULL.

[Severity: High]
This isn't a bug introduced by this patch, but the commit message asserts
that nvkm_gsp_rpc_push() will return an error pointer instead of NULL under
the RECV policy. Is this assertion accurate?

If the GSP firmware sends a malformed message with an invalid size, the
receive path can return NULL even for RECV policies:

r535_gsp_msgq_recv() {
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;
    ...
}

This NULL propagates up through r535_gsp_msg_recv() and
r535_gsp_rpc_handle_reply() to nvkm_gsp_rpc_push().

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

Since this function returns the result of nvkm_gsp_rpc_push() directly, it
can return NULL.

Since callers of nvkm_gsp_rpc_rd() typically only check IS_ERR(rpc), wouldn=
't
this result in a NULL pointer dereference?

For example:

r535_gsp_get_static_info() {
    rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO,
                          sizeof(*rpc));
    if (IS_ERR(rpc))
        return PTR_ERR(rpc);

    ...
    gsp->internal.client.object.handle =3D rpc->hInternalClient;
}

Furthermore, in r535_gsp_rpc_rm_ctrl_push(), a NULL return triggers an
IS_ERR_OR_NULL check but incorrectly translates to a 0 (success) return via
PTR_ERR(rpc), masking the error completely.

Should r535_gsp_msgq_recv() be updated to return an ERR_PTR(-EIO) instead of
NULL when a malformed RPC size is encountered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D5
