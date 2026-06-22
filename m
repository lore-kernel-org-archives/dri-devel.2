Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1B5CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1096B10E597;
	Mon, 22 Jun 2026 09:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I8K7jrA9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6A910E597
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:19:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B567241841;
 Mon, 22 Jun 2026 09:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775191F000E9;
 Mon, 22 Jun 2026 09:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782119944;
 bh=TT52c2MTp70HyIOBs7kXItddOp6WjjA2oIOh2sLwpzA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I8K7jrA9JuHnkavV3/F27sNmZ9R5i6iQKVNiMFhjzTMjnSm/nxRTdxNMyOrehWT0q
 ec6Unq3M5NHbBQUiQo/wJoN6hr2juiew+bUPTtbKytn21Mz5SHWAxtxlVJoNt0mCL9
 mrqgD0Ot2i5ym3e7FPV78UekQVA/vBD5uRBU9wTKBoCNAP6b0VejKMN5S79WxFlIDH
 ZEByrRsSdiglYfVekEuT72+U9A3ndoRsZ+9v/mflcrxzxtPFG4n+XVGRcoFXxL2nzd
 qmMEfDIDensVpYVqEQ14QOf6puK9JBOfllKr0o37I2lzS+/v82xBQIdbl/opEIiYGi
 KccXQRH4SKXVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in  rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119053310796.17264.seg@mailgw.kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <1782119053310796.17264.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:19:04 +0000
Message-Id: <20260622091904.775191F000E9@smtp.kernel.org>
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
- [High] Returning NULL on oversized RPC messages causes a permanent queue =
stall and a NULL pointer dereference in callers.
- [High] Missing lower-bound validation on `rpc->length` causes massive int=
eger underflows, leading to out-of-bounds memory accesses and kernel heap c=
orruption.
- [High] Incorrect destination offset when copying wrapped continuation pay=
loads causes a 32-byte gap of uninitialized memory and a buffer overwrite.
- [High] Time-Of-Check to Time-Of-Use (TOCTOU) race when reading `rpc->leng=
th` from shared memory allows kernel heap buffer overflow.
--

commit 91659e1846d19fb0409c6de8d1d0817e283454ef
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c

This commit cleans up incorrect IS_ERR_OR_NULL() usage for functions that
never return NULL, replacing them with IS_ERR() instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 2ca6de4094e63..0a00c7d831c91 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> @@ -350,7 +350,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		u32 size;
> =20
>  		rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), info.retries);
> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {

[Severity: High]
This isn't a bug introduced by this patch, but since you are cleaning up
error checking in r535_gsp_msgq_recv(), what happens when an incoming
message's length exceeds max_rpc_size?

Earlier in r535_gsp_msgq_recv(), the code does this:

    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

Returning NULL here skips advancing the queue's read pointer (*gsp->msgq.rp=
tr),
which seems like it could permanently stall the message queue as subsequent
reads will hit the exact same malformed message.

Additionally, this NULL return propagates back to callers like
r535_gsp_get_static_info(), which only check IS_ERR(rpc):

    rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO,
                          sizeof(*rpc));
    if (IS_ERR(rpc))
        return PTR_ERR(rpc);
   =20
    gsp->internal.client.object.handle =3D rpc->hInternalClient;

Will this cause a NULL pointer dereference when accessing rpc->hInternalCli=
ent?

[Severity: High]
This is a pre-existing issue, but could the direct read of rpc->length from
shared memory lead to a Time-Of-Check to Time-Of-Use (TOCTOU) race?

In r535_gsp_msgq_recv(), rpc->length is read and validated to determine the
allocation size:

    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

    buf =3D kvmalloc(max_t(u32, rpc->length, expected), GFP_KERNEL);

However, it is read again from shared memory shortly after without READ_ONC=
E()
or caching the previously validated value:

    info.gsp_rpc_len =3D rpc->length;

If the value in shared memory is modified after the validation but before t=
he
second read, could this bypass the size validation and result in a massive
out-of-bounds memcpy() into an undersized heap buffer?

>  			kvfree(buf);
>  			return rpc;
>  		}
> @@ -359,7 +359,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		info.continuation =3D true;
> =20
>  		rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);

[Severity: High]
This is a pre-existing issue, but does r535_gsp_msgq_recv_one_elem() handle
wrapped continuation payloads correctly?

When a continuation message wraps around the end of the ring buffer, the co=
de
skips the 32-byte RPC header for the first part:

    if (info->continuation)
        memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
               len - sizeof(struct nvfw_gsp_rpc));

However, for the wrapped part, it uses buf + len:

    expected -=3D len;
    if (expected) {
        mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + 0x1000 + 0 * 0x1000);
        memcpy(buf + len, mqe, expected);
    }

Since the first memcpy skipped 32 bytes of header, wouldn't using buf + len
leave a 32-byte gap of uninitialized memory in the destination buffer, and
subsequently overwrite past the end of the allocated buffer by 32 bytes?

> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of a minimum
size check on rpc->length allow an integer underflow?

If the GSP provides an rpc->length that is smaller than the RPC header size
(sizeof(struct nvfw_gsp_rpc) which is 32 bytes), wouldn't the subtraction
in r535_gsp_msgq_recv_one_elem():

    len - sizeof(struct nvfw_gsp_rpc)

underflow to a massive unsigned integer, passing an enormous size to memcpy=
()
and causing an out-of-bounds read?

>  			kvfree(buf);
>  			return rpc;
>  		}
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
This is a pre-existing issue, but is there a similar underflow risk here in
r535_gsp_msg_recv() when calling notification callbacks?

Later in r535_gsp_msg_recv(), the length is subtracted again:

    if (ntfy->func)
        ntfy->func(ntfy->priv, ntfy->fn, rpc->data,
                   rpc->length - sizeof(*rpc));

Without a lower-bound validation on rpc->length, could this also underflow
and pass a massive size to the notification callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D2
