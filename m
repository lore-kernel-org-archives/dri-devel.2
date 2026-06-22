Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC872CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B02110E5B7;
	Mon, 22 Jun 2026 09:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gFq6VX8L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4321C10E5B7
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:33:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5ADA60051;
 Mon, 22 Jun 2026 09:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E591F000E9;
 Mon, 22 Jun 2026 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120834;
 bh=tt4Cx99a80v8jmM6c5A3iYN2KKzO8VDV7kccuRZnxNA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gFq6VX8LicdJoZ7zV00v4MsOhoSLzgFrktuP6u8xuXAoG856wcIT49JcbgLMaDAWx
 vqGdM2dlT//05F0f16F173GcbVGjU7y225WLW9Vf7zZjHn1C6LBhcbdjpJrAtjdW+R
 hSzSAgQx6+fded2672XLIeud8Z6ItIR+M0Sc/f1U2dV042f/GdykTsyNmKhInTTTUi
 0xZQHygQJpy11YW/lcQK53M6PbJ9xSAWY68yU+PSos8SORn4FD8yLxCoKZTVwC90IR
 OWbpL6DeD2eKYKepyGHwjwd5MGCqrZIVwrIJ+RTXHrZvt8OpjNsA9bvVnKTz6gbOb0
 9vZvAPUM19LtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in  rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119054238429.17993.seg@mailgw.kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <1782119054238429.17993.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:33:53 +0000
Message-Id: <20260622093354.49E591F000E9@smtp.kernel.org>
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
- [Critical] Missing validation of `rpc->length` from untrusted GSP firmwar=
e leads to integer underflows and massive out-of-bounds memory accesses.
- [High] Incorrect destination offset when a continuation message wraps aro=
und the ring buffer leads to payload corruption and an out-of-bounds write.
- [High] `r535_gsp_msgq_recv()` returns `NULL` on oversized RPC messages, l=
eading to NULL pointer dereferences in callers.
--

commit c55dadd139cb2f5047a2ad1948afcbd89e5133ab
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c
   =20
Clean up incorrect IS_ERR_OR_NULL() usage for functions that never
return NULL:
- r535_gsp_msgq_peek() never returns NULL
- r535_gsp_msgq_recv_one_elem() never returns NULL
   =20
These functions should be checked with IS_ERR() instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 35272c1538699..25d3adbc13550 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c

[ ... ]

> @@ -359,7 +359,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		info.continuation =3D true;
> =20
>  		rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);
> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {
>  			kvfree(buf);
>  			return rpc;
>  		}

[Severity: Critical]
This is a pre-existing issue, but does r535_gsp_msgq_recv() validate the
size of rpc->length coming from the untrusted GSP firmware?

If a compromised GSP sends an rpc->length less than sizeof(*rpc) (32 bytes),
wouldn't the size calculation immediately following this block underflow:

                size =3D info.gsp_rpc_len - sizeof(*rpc);
                expected -=3D size;
                info.gsp_rpc_buf +=3D size;

Could this result in info.gsp_rpc_buf pointing to massively out-of-bounds
addresses and cause arbitrary memory corruption?

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds
write inside r535_gsp_msgq_recv_one_elem() when handling wrapped
continuation messages?

For continuation messages, the first part of the copy skips the 32-byte
header, but the destination offset for the second part appears to be
incorrect:

        if (info->continuation)
                memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
                       len - sizeof(struct nvfw_gsp_rpc));
        else
                memcpy(buf, mqe->data, len);

        expected -=3D len;

        if (expected) {
                mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + ...);
                memcpy(buf + len, mqe, expected);

Since len isn't reduced by sizeof(struct nvfw_gsp_rpc) for the offset,
won't buf + len leave a 32-byte uninitialized hole and push the remainder
copy 32 bytes past the end of the allocated buffer?

> @@ -499,7 +499,7 @@ r535_gsp_msg_recv(struct nvkm_gsp *gsp, int fn, u32 g=
sp_rpc_len)
> =20
>  retry:
>  	rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), &retries);
> -	if (IS_ERR_OR_NULL(rpc))
> +	if (IS_ERR(rpc))
>  		return rpc;
> =20
>  	rpc =3D r535_gsp_msgq_recv(gsp, gsp_rpc_len, &retries);

[Severity: High]
This is a pre-existing issue, but could r535_gsp_msgq_recv() return NULL
on oversized RPC messages?

Looking at r535_gsp_msgq_recv(), it returns NULL instead of an error
pointer when the WARN_ON triggers:

        if (WARN_ON(rpc->length > max_rpc_size))
                return NULL;

Many callers expect either a valid pointer or an ERR_PTR, and only check
for errors using IS_ERR(). For example, in r535_gsp_get_static_info():

        rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_IN=
FO, ...);
        if (IS_ERR(rpc))
                return PTR_ERR(rpc);

        gsp->internal.client.object.client =3D &gsp->internal.client;
        gsp->internal.client.object.parent =3D NULL;
        gsp->internal.client.object.handle =3D rpc->hInternalClient;

Since IS_ERR(NULL) is false, won't this result in a NULL pointer
dereference? Should r535_gsp_msgq_recv() return ERR_PTR(-E2BIG) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D2
