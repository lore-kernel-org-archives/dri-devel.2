Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA90CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DD4910E41F;
	Mon, 22 Jun 2026 02:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KWUa1UKo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AB710E41F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:27:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEE516001A;
 Mon, 22 Jun 2026 02:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E941F00A3A;
 Mon, 22 Jun 2026 02:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782095275;
 bh=31V5DF112jOIyDIlqHUFzFc8f9V/xCSYpQOj5O1nY64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KWUa1UKowN7HSn+iOnSB98NoShpr2Ip2zQhALjKUWNuc+zCTh1w3yhXTVlWuoOGEu
 NOVer/IbmIVjrFOuKuhpfZtn3IHVkrwgnf/dlvT27jUJ+lHkUONYzJ2Q2GNVt3+lj/
 CA+xMBZDd8VEvoz9ndAHXajdUcIvg3bl2xT38OOBrCsW7t5hxX/yzuCyevOsAnK2CP
 4y5dtD7Vl+yjmltlsDkoxrXONYiHu5G3e61bJ84Iw/+Bd2sFbfKqwn70TfFds/njKR
 SdaLwGWNO7Viv91CMtpxW/1z8bymKasSNVjRtIAkI4uHl23yiv0ZKq76VTJkZuTeTj
 SEyF0hrCc/qrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622021207.14764-3-zenghongling@kylinos.cn>
References: <20260622021207.14764-1-zenghongling@kylinos.cn>
 <20260622021207.14764-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:27:55 +0000
Message-Id: <20260622022755.52E941F00A3A@smtp.kernel.org>
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
- [Critical] Missing lower and relative bounds validation for GSP RPC messa=
ge lengths leads to multiple severe memory corruption vulnerabilities, incl=
uding out-of-bounds reads, massive integer/buffer underflows, and kernel he=
ap overflows.
- [Critical] Incorrect destination offset calculation when receiving a wrap=
-around continuation element leaves a 32-byte gap in the payload and causes=
 a 32-byte heap buffer overflow.
- [High] Returning `NULL` instead of an `ERR_PTR` on abnormally large `rpc-=
>length` causes silent failure propagation, leading to NULL pointer derefer=
ences in caller functions and queue deadlocks.
- [Medium] Large payload requests are leaked on error paths in `r535_gsp_rp=
c_push()`.
--

commit 849e62a17ca943158f16f67ef2b39000a10c58b6
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c

Clean up incorrect IS_ERR_OR_NULL() usage for functions that never
return NULL:
- r535_gsp_msgq_peek() never returns NULL
- r535_gsp_msgq_recv_one_elem() never returns NULL

These functions should be checked with IS_ERR() instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 35272c1538699..25d3adbc13550 100644
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
This is a pre-existing issue, but does r535_gsp_msgq_recv() correctly handle
returning NULL?

Earlier in r535_gsp_msgq_recv(), if the length exceeds the maximum, it retu=
rns
NULL:

    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

When this NULL is propagated to callers like r535_gsp_rpc_rm_ctrl_push(), it
can translate to a 0 (success) return code because PTR_ERR(NULL) is 0. This
can lead to silent failure propagation and queue deadlocks. Would it be bet=
ter
to return an ERR_PTR() instead?

[Severity: Critical]
This is also a pre-existing issue, but does rpc->length need a lower bounds
check?

In r535_gsp_msgq_recv(), the code verifies rpc->length <=3D max_rpc_size, b=
ut
doesn't verify if it is smaller than sizeof(struct nvfw_gsp_rpc).=20

If the length is smaller than the struct size, calculations like=20
len - sizeof(struct nvfw_gsp_rpc) in r535_gsp_msgq_recv_one_elem() can
underflow. Could this lead to an out-of-bounds read and massive buffer
underflows during memcpy?

>  			kvfree(buf);
>  			return rpc;
>  		}
> @@ -359,7 +359,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		info.continuation =3D true;
> =20
>  		rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);
> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {

[Severity: Critical]
This isn't a bug introduced by this patch, but does
r535_gsp_msgq_recv_one_elem() calculate the destination offset correctly for
continuation elements?

When info.continuation is true and the message wraps around the ring buffer,
the second memcpy() writes to buf + len:

r535_gsp_msgq_recv_one_elem() {
    ...
    if (expected) {
        mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + 0x1000 + 0 * 0x1000);
        memcpy(buf + len, mqe, expected);
    }
    ...
}

Since len isn't adjusted for the sizeof(struct nvfw_gsp_rpc) that was skipp=
ed
in the first memcpy, does this leave an uninitialized gap and cause a heap
buffer overflow by writing past the end of the kvmalloc-allocated buffer?

>  			kvfree(buf);
>  			return rpc;
>  		}

[ ... ]

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

[Severity: Medium]
While reviewing these changes, I noticed another pre-existing issue. Does
r535_gsp_rpc_push() leak the msg buffer on error paths?

In r535_gsp_rpc_push(), msg is explicitly freed on success:

r535_gsp_rpc_push() {
    ...
    if (!IS_ERR(repv))
        kvfree(msg);
    ...
}

However, if any intermediate chunk fails to send or if handling the reply
fails, the code jumps to the done: label and returns an error without freei=
ng
msg. Should msg be freed on these error paths as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622021207.1476=
4-1-zenghongling@kylinos.cn?part=3D2
