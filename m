Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225F9CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B7BD10E5A2;
	Mon, 22 Jun 2026 09:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eS3tOTzW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719AF10E5A2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:22:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE7EF6008A;
 Mon, 22 Jun 2026 09:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600A21F000E9;
 Mon, 22 Jun 2026 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120138;
 bh=RORknzvJJNYxZgeauSNLrgNzZ2uZCZVSeZpQf522iG4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eS3tOTzW3Hj2j4igXcn5n2SIxBWsoRMMb4hUpb8BUJLpP1LmSlT8vmzgDGaGvkxV9
 a8isW2qlrY9YIO7d32bRPPjPGJYZSl6pentNLWVN8t5eLYkSwfxlXv9Kiziw0XEV2s
 926ke+7kChERD9yPn9xAe812IVKSIDypUfKCbdhxhQTwKJBYo2vnFFvF9e2vFkUpJ2
 DJckB5T9t9p1dpk6zXXj2MPkSMg18aBqA3BIZ9im1p4jrdTknLrAEczjbizLPnrTYQ
 +O3X8VrW8xn0DhRPYruxCHqtIaSlQGmvk+llY35Tdv7I4+8Wp+gNE6Xn5Fj+DwEi9Y
 x3ThKaP7ZZHnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in  rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119051176431.14291.seg@mailgw.kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <1782119051176431.14291.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:22:17 +0000
Message-Id: <20260622092218.600A21F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The driver blindly trusts the `length` field of GSP messages a=
nd continuation records, leading to multiple integer underflows and massive=
 out-of-bounds memory copies.
- [Critical] Missing bounds check on GSP continuation message length allows=
 a heap buffer overflow.
- [High] Returning `NULL` on oversized GSP messages leads to infinite loops=
 in the message queue worker and a false success bubbling up to callers, ca=
using subsequent NULL pointer dereferences.
- [High] A continuation message wrapping around the message queue ring buff=
er causes memory corruption and an overrun due to incorrect pointer math.
- [High] Missing read memory barrier (rmb or dma_rmb) after reading the rin=
g buffer write pointer.
--

commit b655637a9811533563a43c05f87d130fe957a519
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c

This commit cleans up IS_ERR_OR_NULL() usage for functions that supposedly
never return NULL. It changes the checks after r535_gsp_msgq_peek(),
r535_gsp_msgq_recv_one_elem(), and r535_gsp_msgq_recv() to use IS_ERR()
instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index b4b2b5c00ab4e..5b89c8835a2e4 100644
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
This is a pre-existing issue, but does the polling loop in
r535_gsp_msgq_wait() need a read memory barrier?

r535_gsp_msgq_peek() calls r535_gsp_msgq_wait(), which polls the GSP write
pointer *gsp->msgq.wptr from DMA coherent memory:

    while (rptr =3D=3D wptr || ...) {
        ...
        wptr =3D *gsp->msgq.wptr;
    }
   =20
Without an rmb() or dma_rmb() before returning, could weakly ordered CPUs
speculatively fetch the payload data before the write pointer read is
ordered, resulting in stale data being read from the ring buffer?

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
This isn't a bug introduced by this patch, but does the firmware's
message length need to be validated to prevent integer underflows?

If rpc->length is smaller than sizeof(struct nvfw_gsp_rpc), does
this underflow the length calculations and cause an out-of-bounds memcpy()?

In r535_gsp_msgq_recv_one_elem(), the payload length calculation uses:

    if (info->continuation)
        memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
               len - sizeof(struct nvfw_gsp_rpc));
              =20
Additionally, in this loop in r535_gsp_msgq_recv(), the offset underflows:

    size =3D info.gsp_rpc_len - sizeof(*rpc);
    expected -=3D size;
    info.gsp_rpc_buf +=3D size;
   =20
There is a similar underflow in r535_gsp_msg_dump():

    msg->length - sizeof(*msg)
   =20
Could a malicious or buggy firmware send a small length and cause these
calculations to wrap around, leading to massive memory corruption?

[Severity: Critical]
This is a pre-existing issue, but does this code check if the continuation
message actually fits within the remaining allocated buffer?

The buffer was allocated based on the initial expected message length.
If a continuation chunk payload (info.gsp_rpc_len - sizeof(*rpc)) is
larger than the remaining capacity (expected), does this overwrite the
bounds of the kvmalloc'd buffer?

[Severity: High]
This isn't a bug introduced by this patch, but is there a miscalculation
when a continuation message wraps around the ring buffer?

In r535_gsp_msgq_recv_one_elem(), the code copies a wrapped continuation
payload in two parts. The first part writes len - sizeof(struct nvfw_gsp_rp=
c)
bytes. However, for the second part it copies:

    if (expected) {
        mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + 0x1000 + 0 * 0x1000);
        memcpy(buf + len, mqe, expected);
    }

Should the destination pointer be buf + len - sizeof(struct nvfw_gsp_rpc)
instead of buf + len? Does using buf + len leave a gap of uninitialized
memory and subsequently overrun the allocated buffer by
sizeof(struct nvfw_gsp_rpc) bytes?

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
This is a pre-existing issue, but is it safe for r535_gsp_msgq_recv() to
return NULL when a message is oversized?

r535_gsp_msgq_recv() has the following check:

    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;
       =20
If an oversized message is received, this returns NULL instead of advancing
the message queue read pointer and returning an error pointer like
ERR_PTR(-EIO).

Does this cause the message queue worker to get stuck in an infinite loop
repeatedly processing the same invalid message? Also, could this NULL bubble
up as a false success to callers that check for errors via IS_ERR(), causing
subsequent NULL pointer dereferences?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D2
