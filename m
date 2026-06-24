Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D67CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0509A10F014;
	Wed, 24 Jun 2026 19:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AE99TYoH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D320310F014
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:12:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4271360018;
 Wed, 24 Jun 2026 19:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0BA1F000E9;
 Wed, 24 Jun 2026 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782328322;
 bh=wZlYI+K7qJ4TLIfHtxdHbieFPRrkgwgAZEdYe2Hr8XI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AE99TYoH9RG19DAeM6sWAxaMTDCTHaGglUdYFlIQNfeUn3+uX195nmh7JKxSJbxBR
 Ip9sDBD5q3piM3fp3Y1zZCuqcjfaz2MK18mSDH0qzhyczaH1TseY/Ek8Fh9svWsKgT
 jyg5PbLdBL+f3HuB2L3vX82EpVs8AcSv2B67rgzdd+XY/O+LF6k0y6Rrvxi6STrzRM
 zk0c3YYEnokrYqpM1rhI8axJMdQ8NfzRy6rRNI4l+PxEs6bvvJY+k6NZizSl7iOXqr
 kTBZzyc5L6rmGWwaRGnqQUAKDawFcs+96gQ1Vj2syM/d5KCthrSL2JtRL4nPS05r6X
 xJCddcycZeRBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: reject oversized inline invoke payloads
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624185549.1669-1-alhouseenyousef@gmail.com>
References: <20260624185549.1669-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:12:01 +0000
Message-Id: <20260624191201.CE0BA1F000E9@smtp.kernel.org>
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
- [Critical] Integer overflow in `fastrpc_get_payload_size()` accumulator l=
eads to undersized DMA buffer and massive heap out-of-bounds write.
- [Critical] Heap buffer underflow via overlaps between mapped and unmapped=
 buffers in `fastrpc_get_buff_overlaps()`.
- [High] SMMU isolation bypass via unverified VMA offset calculations.
- [High] Resource leak of `fastrpc_map` objects and DMA attachments for inp=
ut/output handles.
- [High] Implicit integer truncation to heap buffer overflow on 32-bit arch=
itectures.
--

commit a53ab016dbb10f6c8573b1c5e13acf7acf361b1d
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: reject oversized inline invoke payloads

fastrpc_get_args() computes inline payload spans from 64-bit user
buffer ranges, but stores each span in an int before comparing it with
the remaining DMA buffer space. A large span can truncate before the bounds
check and advance the DMA write cursor by the wrong amount. This patch keeps
the span 64-bit and fails the invoke when the serialized payload would exce=
ed
the buffer.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..c60bab4f45c01 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1067,7 +1067,7 @@ static int fastrpc_get_args(u32 kernel, struct fast=
rpc_invoke_ctx *ctx)
>  	ctx->rpra =3D rpra;
> =20
>  	for (oix =3D 0; oix < ctx->nbufs; ++oix) {
> -		int mlen;
> +		u64 mlen;

[Severity: High]
This isn't a bug introduced by this patch, but does the use of 64-bit sizes
lead to truncation issues on 32-bit architectures?

When pkt_size is passed to dma_alloc_coherent() via __fastrpc_buf_alloc(),
the 64-bit size is implicitly truncated to a 32-bit size_t. This can result
in a small kernel allocation for values exceeding 4GB.

The bounds checks use the untruncated 64-bit lengths, and copy_from_user()
will truncate the 64-bit len to a 32-bit unsigned long. Could coordinating
these lengths to wrap around the 32-bit boundary cause copy_from_user() to
copy a large payload into the truncated DMA buffer allocation?

> =20
>  		i =3D ctx->olaps[oix].raix;
>  		len =3D ctx->args[i].length;

[Severity: High]
This is a pre-existing issue, but is there a risk of SMMU isolation bypass
for mapped buffers?

For mapped DMA buffers, fastrpc_get_args() computes the physical address
offset by subtracting the VMA start address:

drivers/misc/fastrpc.c:fastrpc_get_args() {
    ...
			vma =3D vma_lookup(current->mm, ctx->args[i].ptr);
			if (vma)
				pages[i].addr +=3D (ctx->args[i].ptr & PAGE_MASK) -
						 vma->vm_start;
    ...
}

Does the code verify that the resolved VMA actually corresponds to the
underlying dma_buf, or that offset + len is within the map's size? If not,
could an attacker forge an arbitrary IOVA offset using a large anonymous VMA
to read or write arbitrary memory mapped within the shared SMMU domain?

[ ... ]

> @@ -1107,8 +1107,10 @@ static int fastrpc_get_args(u32 kernel, struct fas=
trpc_invoke_ctx *ctx)
> =20
>  			mlen =3D ctx->olaps[oix].mend - ctx->olaps[oix].mstart;
> =20
> -			if (rlen < mlen)
> +			if (rlen < mlen) {
> +				err =3D -EOVERFLOW;
>  				goto bail;

[Severity: Critical]
This is a pre-existing issue, but does rlen bypass this check if pkt_size
wraps around and rlen underflows?

In fastrpc_get_payload_size(), size accumulates the buffer lengths without
checking for wrap-around. An attacker could supply lengths such that the sum
exceeds U64_MAX, resulting in a small positive pkt_size and causing an
undersized DMA allocation.

Then in fastrpc_get_args():
    rlen =3D pkt_size - metalen;

If pkt_size is smaller than metalen, rlen underflows to a massive 64-bit
value, which trivially bypasses this rlen < mlen check. Could this lead to
copy_from_user() copying the untruncated len into the undersized heap
allocation?

[Severity: High]
This is a pre-existing issue, but could this early exit leak DMA map
attachments for scalar handles?

In fastrpc_create_maps(), map objects are created and attached for all
arguments up to ctx->nscalars. However, when the context is freed:

drivers/misc/fastrpc.c:fastrpc_context_free() {
    ...
	for (i =3D 0; i < ctx->nbufs; i++)
		fastrpc_map_put(ctx->maps[i]);
    ...
}

The cleanup loop only iterates up to ctx->nbufs, failing to drop references
for handle maps (i >=3D ctx->nbufs). If this goto bail is hit, do the maps =
for
scalar handles remain pinned in the user process's list, potentially
exhausting kernel memory and DMA allocations?

> +			}
> =20
>  			rpra[i].buf.pv =3D args - ctx->olaps[oix].offset;

[Severity: Critical]
This is a pre-existing issue, but can this address underflow to a location
before the allocated heap buffer?

If fastrpc_get_buff_overlaps() processes an unmapped inline buffer that
overlaps entirely within a preceding mapped buffer, it sets mstart and
mend to 0, and offset to the distance from the mapped buffer's start.

Because args would not have advanced for this buffer, could subtracting
offset from args here result in an address pointing before
ctx->buf->virt, leading to an out-of-bounds write when copy_from_user()
is called later in fastrpc_get_args()?

>  			pages[i].addr =3D ctx->buf->dma_addr -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624185549.1669=
-1-alhouseenyousef@gmail.com?part=3D1
