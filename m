Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685BDCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:08:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3ED10E454;
	Mon, 22 Jun 2026 04:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2ruZT3V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7610E454
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:08:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A471B6008A;
 Mon, 22 Jun 2026 04:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6811F000E9;
 Mon, 22 Jun 2026 04:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782101301;
 bh=4qNiHp5NM/7o74nWJk97EaaO2ib4HbxUQwJLmjW1mXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J2ruZT3VeQBDaWNorE0Bcf7PhPwl6GjAxw098cRgSQqBxCyhOf/VpFWr+9hfdBH+S
 U0UbRWXk7YjEbiw2qv2NzlGDRkqr3/VxT/fNMs8xMn9z9+ND3rmWFdjCKplNfh38Ad
 sVuwedc22TnfRutmSHM1JJiXoJeyQ874uujIm8hCFeFfeeEhOUDEi0iKieQn6TCm5u
 cqHW6w8K9jUweA5u+TsKEW3He0uNwRwL36TYNmIa0TOJOsbeDW96CwrMUZ/PVMURqE
 SrC7hFgHkwj1PmZIjsMuUWDysAsv9UVGebPzYyzs3fkOg6CzAdt5kQFVU8K1a9jKzN
 fxKtdkuu5kHwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] nouveau/gsp/rpc: Cleanup incorrect
 IS_ERR_OR_NULL in rpc.c
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622035454.28003-3-zenghongling@kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <20260622035454.28003-3-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:08:20 +0000
Message-Id: <20260622040821.3F6811F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of GSP RPC message lengths from firmware can le=
ad to integer underflow and massive kernel memory corruption.
- [High] Silent failure when rpc is NULL results in caller NULL pointer der=
eference.
- [High] Buffer overflow and uninitialized memory gap when a continuation G=
SP RPC chunk wraps around the message queue ring buffer.
- [High] Silent infinite stall of the GSP message queue when an oversized m=
essage is encountered.
- [High] Missing read memory barrier (`rmb()`) between reading the shared m=
emory write pointer and reading the message payload.
- [High] Time-of-Check to Time-of-Use race condition on `rpc->length` bypas=
ses bounds checks.
- [High] Trusting the CPU read pointer (`rptr`) from shared memory leads to=
 arbitrary memory access.
--

commit 45236a2b4542b6f23a9a07cab6b6a3cd3588738d
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rpc: Cleanup incorrect IS_ERR_OR_NULL in rpc.c

Clean up incorrect IS_ERR_OR_NULL() usage for functions that never
return NULL:
- r535_gsp_msgq_peek() never returns NULL
- r535_gsp_msgq_recv_one_elem() never returns NULL

These functions should be checked with IS_ERR() instead.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> index 2ca6de4094e63..0a00c7d831c91 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c
> @@ -350,7 +350,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)

[Severity: High]
This is a pre-existing issue, but earlier in r535_gsp_msgq_recv(),
returning NULL when an oversized message is encountered seems to stall the
queue:

r535_gsp_msgq_recv() {
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;
    ...
}

Does returning NULL here without advancing the queue read pointer cause an
unrecoverable infinite stall, since subsequent reads would encounter the
exact same oversized message?

[Severity: High]
This isn't a bug introduced by this patch, but there also appears to be a
Time-of-Check to Time-of-Use race condition on rpc->length:

r535_gsp_msgq_recv() {
    ...
    if (WARN_ON(rpc->length > max_rpc_size))
        return NULL;

    buf =3D kvmalloc(max_t(u32, rpc->length, expected), GFP_KERNEL);
    ...
}

Since rpc points directly to DMA coherent memory shared with the GSP, could
the length be overwritten in shared memory between the check and its use in
kvmalloc() or info.gsp_rpc_len, bypassing the validation?

>  		u32 size;
> =20
>  		rpc =3D r535_gsp_msgq_peek(gsp, sizeof(*rpc), info.retries);
> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {
>  			kvfree(buf);
>  			return rpc;
>  		}
> @@ -359,7 +359,7 @@ r535_gsp_msgq_recv(struct nvkm_gsp *gsp, u32 gsp_rpc_=
len, int *retries)
>  		info.continuation =3D true;
> =20
>  		rpc =3D r535_gsp_msgq_recv_one_elem(gsp, &info);

[Severity: High]
This is a pre-existing issue, but in r535_gsp_msgq_recv_one_elem() called
here, is there a potential integer underflow?

r535_gsp_msgq_recv_one_elem() {
    ...
    if (info->continuation)
        memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
               len - sizeof(struct nvfw_gsp_rpc));
    ...
}

If the continuation message length read directly from shared memory is less
than sizeof(struct nvfw_gsp_rpc) (32 bytes), does this calculation underflow
and lead to a massive out-of-bounds read and write?

[Severity: High]
This is another pre-existing issue in r535_gsp_msgq_recv_one_elem(). Could
a continuation chunk wrapping around the ring buffer cause an out-of-bounds
write?

r535_gsp_msgq_recv_one_elem() {
    ...
    if (expected) {
        mqe =3D (void *)((u8 *)gsp->shm.msgq.ptr + 0x1000 + 0 * 0x1000);
        memcpy(buf + len, mqe, expected);
    }
    ...
}

If the first copy only advanced the buffer logically by len - 32 due to
skipping the header, would writing the second part at buf + len leave a
32-byte gap of uninitialized memory and overflow the end of the allocated
buffer by 32 bytes?

[Severity: High]
This isn't a bug introduced by this patch, but does the underlying
r535_gsp_msgq_wait() function lack a required memory barrier?

r535_gsp_msgq_wait() {
    ...
    u32 wptr =3D *gsp->msgq.wptr;
    ...
}

When polling the shared memory write pointer, does the host CPU need an rmb=
()
after observing the updated write pointer?

Without it, could the CPU speculatively fetch stale payload data before the
pointer update is fully observed?

[Severity: High]
This is a pre-existing issue, but does r535_gsp_msgq_get_entry() safely
handle the CPU read pointer?

r535_gsp_msgq_get_entry() {
    u32 rptr =3D *gsp->msgq.rptr;
    return (void *)((u8 *)gsp->shm.msgq.ptr + GSP_PAGE_SIZE +
                    rptr * GSP_PAGE_SIZE);
}

Since gsp->msgq.rptr points to DMA coherent memory, could a compromised GSP
modify this pointer to an arbitrarily large value and force the host to read
out-of-bounds host memory?

> -		if (IS_ERR_OR_NULL(rpc)) {
> +		if (IS_ERR(rpc)) {
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

[Severity: High]
This isn't a bug introduced by this patch, but when r535_gsp_msgq_recv()
returns NULL (for example, when encountering an oversized message), does
this result in a silent failure upstream?

The NULL propagates out to r535_gsp_rpc_rm_ctrl_push(), which handles it
like this:

r535_gsp_rpc_rm_ctrl_push() {
    ...
    if (IS_ERR_OR_NULL(rpc)) {
        *params =3D NULL;
        return PTR_ERR(rpc);
    }
    ...
}

Since PTR_ERR(NULL) is 0 (success), does this mask the failure and cause
upstream callers to dereference a NULL pointer thinking the call succeeded?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D2
