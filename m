Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2E7CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4FC11A2CC;
	Thu,  4 Jun 2026 20:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ApNSUNV4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E83D11A2CC
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:02:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F1C56001A;
 Thu,  4 Jun 2026 20:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E501F00893;
 Thu,  4 Jun 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780603364;
 bh=SiJUjS10JQKZxe/cU/29KmkEjhgmWAOcawa7qp2LCcc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ApNSUNV4YoUKVgT4SQSsGwwC794U6D4/hMaGte+z4pW2bGSIFSyxSH2HHJCHNbAVu
 VmCgkDjz3jT1rc/CMBWEPZDX3l7PiygtVntKxM9p4Zoi+JtZVyv13hrUOW0VihfUsc
 H/Z5hNRJf5Sdco2VqVAeM11jF4MBNaccEQP5Q0Dum3koLryH0Mmyf8iYDRumxRFoOq
 hxcyf2kiLeWdI+HqZ2IeQ1cUHVOSZcfuUptzHnE8OeXa3xUkU4BqVwXc3fg4vWnyhp
 qZ5OQqqoXFvJwc7Je1fGGP/wS00qK1Qemw4mo8rD6+ZqI0r/+mKVIIJ1GZVWPqya4P
 bNlER1mP67Cvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] misc: fastrpc: Add cache maintenance for
 non-coherent platforms
To: "Abhinav Parihar" <abhinav.parihar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com>
References: <20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:02:43 +0000
Message-Id: <20260604200244.19E501F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] `fastrpc_inv_args()` incorrectly passes `DMA_TO_DEVICE` to `dma_bu=
f_end_cpu_access()` after beginning access with `DMA_FROM_DEVICE`.
- [High] Missing cache maintenance for output buffers before DSP execution.
- [High] The return value of `dma_buf_begin_cpu_access()` is ignored.
- [High] Misuse of `dma_buf_begin_cpu_access()` to perform cache maintenanc=
e for the DSP.
- [High] Cache maintenance is incorrectly skipped for shared IN/OUT buffers=
 due to flawed overlap logic.
- [Medium] The overlap check in `fastrpc_inv_args()` incorrectly compares a=
 kernel virtual address with a user-space virtual address, making it imposs=
ible to match.

Pre-existing issues:
- [Critical] `fastrpc_context_free()` leaks memory for DMA maps associated =
with handle arguments.
- [Critical] Untrusted pointers read from a DSP-shared DMA buffer are used =
directly as source pointers in `copy_to_user`, allowing arbitrary kernel me=
mory leak.
--

commit 3ae5f11901e70743ac3aeecf63b6007d21fbb3e3
Author: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

misc: fastrpc: Add cache maintenance for non-coherent platforms

This patch introduces helper functions to flush input buffers and invalidate
output buffers for fastrpc argument buffers on non-coherent platforms. It u=
ses
the dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() APIs to perform
the cache operations.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a3..043b6a5548fb5 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> +static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra =3D ctx->rpra;
> +	int i, inbufs, outbufs;
> +
> +	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> +	outbufs =3D REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +
> +	for (i =3D 0; i < inbufs + outbufs; ++i) {
> +		int raix =3D ctx->olaps[i].raix;
> +		struct fastrpc_map *map =3D ctx->maps[raix];
> +
> +		if (raix + 1 > inbufs)
> +			continue;

[Severity: High]
Are output buffers missing cache maintenance before DSP execution?

Before a device performs a DMA write to an output buffer, the CPU cache must
be invalidated (or cleaned and invalidated) to prevent dirty cache lines fr=
om
being asynchronously evicted and overwriting the device's DMA writes in RAM.

Here, output buffers are explicitly skipped, leaving them vulnerable to evi=
ction
corruption during DSP execution.

> +		if (!map || !map->buf)
> +			continue;
> +
> +		if (rpra[raix].buf.len && ctx->olaps[i].mstart) {

[Severity: High]
Does this overlap logic cause skipped cache maintenance for shared IN/OUT
buffers?

When an IN/OUT buffer is passed as both an inbuf and an outbuf pointing to =
the
same memory, fastrpc_get_buff_overlaps() sorts them and assigns mstart =3D =
0 to
the completely overlapping second element.

Because sort() is not stable, the OUT buffer could be sorted first and the =
IN
buffer second, resulting in mstart =3D 0 for the IN buffer. Since OUT buffe=
rs are
already skipped above, skipping the IN buffer here when mstart =3D 0 causes=
 the
flush to be completely bypassed.

> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);

[Severity: High]
Could dma_buf_begin_cpu_access() fail here and bypass fence waits?

dma_buf_begin_cpu_access() can return an error code like -ERESTARTSYS or
-ENOMEM. Ignoring the return value silently bypasses fence waits and cache
synchronization.

[Severity: High]
Is the CPU access API being misused to proxy DSP cache maintenance?

Calling dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() back-to-back
to trigger device cache maintenance within the exporter appears to bypass t=
he
native DMA API. This broadcasts the sync operation to all attached devices =
and
should likely be handled natively via dma_sync_sg_for_device().

> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
> +		}
> +	}
> +}
> +
> +static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra =3D ctx->rpra;
> +	int i, inbufs, outbufs;
> +
> +	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> +	outbufs =3D REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +
> +	for (i =3D 0; i < inbufs + outbufs; ++i) {
> +		int raix =3D ctx->olaps[i].raix;
> +		struct fastrpc_map *map =3D ctx->maps[raix];
> +
> +		if (raix + 1 <=3D inbufs)
> +			continue;
> +		if (!rpra[raix].buf.len)
> +			continue;
> +		if (!map || !map->buf)
> +			continue;
> +
> +		/*
> +		 * Skip invalidation if the argument overlaps with the
> +		 * RPC control header page.
> +		 */
> +		if (((uintptr_t)rpra & PAGE_MASK) =3D=3D
> +			((uintptr_t)rpra[raix].buf.pv & PAGE_MASK))

[Severity: Medium]
Does this overlap check incorrectly compare a kernel virtual address with a
user-space virtual address?

The rpra array is a kernel virtual address, but rpra[raix].buf.pv contains a
user-space virtual address for mapped buffers (ctx->args[i].ptr). Comparing
their page masks will almost never match, rendering this check essentially
dead code.

> +			continue;
> +
> +		if (ctx->olaps[i].mstart) {

[Severity: High]
Similar to the issue in fastrpc_flush_args(), could the OUT buffer get
mstart =3D 0 due to the unstable sort in fastrpc_get_buff_overlaps()?

If the IN buffer is sorted first, the OUT buffer gets mstart =3D 0 and is
skipped, bypassing the invalidation.

> +			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);

[Severity: High]
Is the return value of dma_buf_begin_cpu_access() ignored here as well?

This can lead to severe race conditions or silent data corruption if the ca=
ll
fails and implicit fences are not waited on.

> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);

[Severity: High]
Should this be DMA_FROM_DEVICE instead of DMA_TO_DEVICE?

The DMA-BUF API requires the direction passed to the end access function to
match the begin function. Passing DMA_TO_DEVICE after DMA_FROM_DEVICE cause=
s a
cache clean instead of completing the cache invalidation. This can overwrite
the fresh DSP output data in RAM with stale CPU cache lines.

> +		}
> +	}
> +}

[ ... ]

>  static void fastrpc_context_free(struct kref *ref)
>  {
>  	struct fastrpc_invoke_ctx *ctx;
>  	struct fastrpc_channel_ctx *cctx;
>  	unsigned long flags;
>  	int i;
> =20
>  	ctx =3D container_of(ref, struct fastrpc_invoke_ctx, refcount);
>  	cctx =3D ctx->cctx;
> =20
>  	for (i =3D 0; i < ctx->nbufs; i++)
>  		fastrpc_map_put(ctx->maps[i]);

[Severity: Critical]
This is a pre-existing issue, but does fastrpc_context_free() leak memory f=
or
DMA maps associated with handle arguments?

fastrpc_create_maps() allocates and initializes up to ctx->nscalars map
objects, which includes handles (indices >=3D ctx->nbufs). However, this lo=
op
only cleans up from 0 to ctx->nbufs - 1. The maps corresponding to handles =
are
never released, permanently leaking map objects and pinning DMA buffers.

[ ... ]

>  static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>  			    u32 kernel)
>  {
>  	union fastrpc_remote_arg *rpra =3D ctx->rpra;
[ ... ]
>  	for (i =3D inbufs; i < ctx->nbufs; ++i) {
>  		if (!ctx->maps[i]) {
>  			void *src =3D (void *)(uintptr_t)rpra[i].buf.pv;
>  			void *dst =3D (void *)(uintptr_t)ctx->args[i].ptr;
>  			u64 len =3D rpra[i].buf.len;
> =20
>  			if (!kernel) {
>  				if (copy_to_user((void __user *)dst, src, len)) {

[Severity: Critical]
This is a pre-existing issue, but does this pass untrusted pointers read fr=
om
a DSP-shared DMA buffer directly as source pointers to copy_to_user()?

The rpra array is mapped bidirectionally to the DSP via the shared ctx->buf.
A compromised or malicious DSP could overwrite rpra[i].buf.pv and
rpra[i].buf.len with arbitrary kernel addresses.

Since this code blindly passes this attacker-controlled address as the src =
to
copy_to_user(), can the DSP leak arbitrary kernel memory to user space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604194811.2437=
567-1-abhinav.parihar@oss.qualcomm.com?part=3D1
