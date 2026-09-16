Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC2DC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A02310E0A2;
	Wed, 16 Sep 2026 19:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hHhU4x9m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D5F10E0A2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:09:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95ED7601EF;
 Wed, 16 Sep 2026 19:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2329B1F000FF;
 Wed, 16 Sep 2026 19:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789585745;
 bh=AMcO2iLuYe0RqQ1IiPTE/T6y5x4Ll1izgQ/KZY/ilnM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hHhU4x9mU3ku723pP87RoJ5WzjQ0yVHv/4ZKRJShcj4syvRLCmEqK6zGymrZtt6SP
 huX5ohB4ytQT6obVYi7k66CagvqCWw9EfYbuw7LtGjRTqaT7SLmb+fHC/YWAyl4Ooi
 xyYxiM2fqBBMAsrEf3mnUuyeY4XEZWO8MshUnhwB31Jqz+c1NlK5ue2iq2wvTtP0XY
 C+IDXyfZyWFl8WZc8t4arSEvG0ugKPM34iMvp6doRzx3ZzmAFM3KZeMSvOehhJoSPL
 g0nKfSpkag40yE8ArTgG7QYUM5c0J3eFLPThKPMzRMPRmdkaKWAuC14ZfhoXEsFO7D
 lZuMPiIduYPEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
To: "Abhinav Parihar" <abhinav.parihar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
References: <20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 19:09:04 +0000
Message-Id: <20260916190905.2329B1F000FF@smtp.kernel.org>
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
- [High] misc: fastrpc: missing error handling for dma_buf_begin_cpu_access=
()
- [High] misc: fastrpc: cache coherency bypass due to user pointer overlap =
detection
- [High] misc: fastrpc: missing max_raix update causes incorrect do_cmo eva=
luation
- [Low] misc: fastrpc: dead code in RPC control header overlap check
--

commit 131a71612f32d48a67415e31fef5d7317be532ce
Author: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
Subject: misc: fastrpc: Add cache maintenance for non-coherent platforms

This commit adds cache maintenance for fastrpc argument buffers on
non-coherent platforms. It introduces fastrpc_flush_args() and
fastrpc_inv_args() to flush input buffers and invalidate output buffers bas=
ed
on the "dma-coherent" property.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca867..83d04b9d2ea02 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -675,6 +679,9 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_=
invoke_ctx *ctx)
>  			if (ctx->olaps[i].end > max_end) {
>  				max_end =3D ctx->olaps[i].end;

[Severity: High]
Does this code miss updating max_raix when max_end is extended?

If a partially overlapping buffer extends max_end, max_raix remains stale.
Subsequent fully subsumed buffers might then evaluate their boundary crossi=
ng
(do_cmo) against this stale max_raix, potentially skipping necessary cache
maintenance.

>  			} else {
> +				if ((max_raix < inbufs && ctx->olaps[i].raix + 1 > inbufs) ||
> +					(ctx->olaps[i].raix < inbufs && max_raix + 1 > inbufs))
> +					ctx->olaps[i].do_cmo =3D true;
>  				ctx->olaps[i].mend =3D 0;
>  				ctx->olaps[i].mstart =3D 0;
>  			}
[ ... ]
> @@ -1067,6 +1075,64 @@ static int fastrpc_create_maps(struct fastrpc_invo=
ke_ctx *ctx)
>  	return 0;
>  }
> =20
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
> +		if (!map || !map->buf)
> +			continue;
> +
> +		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || ctx->olaps[i].do_cm=
o)) {

[Severity: High]
Can cache maintenance be incorrectly skipped here due to relying on mstart?

The fastrpc_get_buff_overlaps() function calculates overlaps and sets mstart
using the user-provided virtual address (ctx->args[i].ptr), rather than the
underlying dma-buf identity.=20

If a user passes the same ptr value for two distinct dma-buf fds, the overl=
ap
logic merges them and sets mstart =3D 0 for the second buffer. Additionally=
, if
ptr =3D=3D 0, mstart also evaluates to 0. This could allow untrusted usersp=
ace to
bypass cache maintenance, leading to silent data corruption or coherency
issues.

> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);

[Severity: High]
Is it safe to ignore the return value of dma_buf_begin_cpu_access() here?

This function can fail (e.g., returning -ERESTARTSYS if interrupted by a
signal while waiting on fences).=20

Ignoring the failure causes the driver to proceed with unstabilized buffers
(which could lead to data corruption) and unconditionally calls
dma_buf_end_cpu_access() on the error path, violating API pairing and
potentially causing exporter crashes or state corruption.

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
> +			continue;

[Severity: Low]
Does this code perform a meaningless comparison?

The overlap check compares a kernel virtual address (rpra) with a user-space
virtual address (rpra[raix].buf.pv).=20

Because of the `if (!map || !map->buf) continue;` check above it, this code
is only reached for explicit user dma-buf mappings, where pv is explicitly =
set
to the user-space ptr. These addresses will virtually never match, making t=
his
dead code.

> +
> +		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
> +			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);

[Severity: High]
Should this check the return value of dma_buf_begin_cpu_access() and handle
errors appropriately before proceeding and calling dma_buf_end_cpu_access()?

> +			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916185850.3686=
010-1-abhinav.parihar@oss.qualcomm.com?part=3D1
