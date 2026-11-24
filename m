Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A05606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HfwRd7mG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB5F10F55F;
	Tue, 24 Nov 2026 12:38:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A68510F564
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:38:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 720466127B;
 Tue, 24 Nov 2026 12:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C791F000C4;
 Tue, 24 Nov 2026 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523909;
 bh=kGZ0j820wJZg2fsoyuw4zYTxSPUEXsHQdtUFOFOSy/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HfwRd7mGHMyuYmbzqAlrfPAV/OEOXnpDKLLsT4YmDmXwsvraJNQXRrAznyTHt7nKE
 g0dMOGGVyXUehF4yPeVN+ZufBwdisicPdxKu8IsUZvzTH/SW7fmZH2oX0ogRQQWbs4
 6X5QOXi0xGR0hrrg4BSW3XS3+lL2hhPw/e0TMlQC/9orR2a0VuUdHUDDAIqPDUUvRh
 8bPZ79L1tB0HKtDg4otf4dCGuh4grG46ojAp2ePqEY3TBPvo6zwQ9lLKhTIZxXH0Pv
 vZsgPcdF1z+4zvCAu7Gb2gNwY9OsRIEGl0ewNFS2FYgkUtEuI5vIY59UnBZsKKo83j
 i7NObS8Fzvc1A==
Message-ID: <sashiko-outbox-231159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: Add cache maintenance for
 non-coherent platforms
To: "Abhinav Parihar" <abhinav.parihar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124120604.2640046-1-abhinav.parihar@oss.qualcomm.com>
References: <20261124120604.2640046-1-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:38:28 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] misc: fastrpc: skipped dma_buf cache maintenance due to mstart
  and overlap
- [Medium] misc: fastrpc: unchecked dma_buf_begin_cpu_access() in cache
  helpers
- [Medium] misc: fastrpc: redundant full-buffer cache passes in
  fastrpc_inv_args()
- [Medium] misc: fastrpc: repeated full-dma_buf cache flushes for shared
  dma_buf args
--

commit 38d28b3641886dcb390560c25b96a33e1bd0dc19
Author: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

misc: fastrpc: Add cache maintenance for non-coherent platforms

This commit adds DMA-buf cache flush and invalidation helpers for RPC
argument buffers on platforms whose session device is not DMA-coherent.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9e760f68bcaf2..39ad0ab88aec3 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -666,7 +668,9 @@ static int olaps_cmp(const void *a, const void *b)
>  static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  {
>  	u64 max_end =3D 0;
> +	int max_raix =3D -1;
>  	int i;
> +	int inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> =20
>  	for (i =3D 0; i < ctx->nbufs; ++i) {
>  		ctx->olaps[i].start =3D ctx->args[i].ptr;
> @@ -685,7 +689,10 @@ static void fastrpc_get_buff_overlaps(struct fastrpc=
_invoke_ctx *ctx)
> =20
>  			if (ctx->olaps[i].end > max_end) {
>  				max_end =3D ctx->olaps[i].end;
> +				max_raix =3D ctx->olaps[i].raix;
>  			} else {
> +				if ((max_raix < inbufs) !=3D (ctx->olaps[i].raix < inbufs))
> +					ctx->olaps[i].do_cmo =3D true;
>  				ctx->olaps[i].mend =3D 0;
>  				ctx->olaps[i].mstart =3D 0;
>  			}
> @@ -695,6 +702,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_=
invoke_ctx *ctx)
>  			ctx->olaps[i].mstart =3D ctx->olaps[i].start;
>  			ctx->olaps[i].offset =3D 0;
>  			max_end =3D ctx->olaps[i].end;
> +			max_raix =3D ctx->olaps[i].raix;
>  		}
>  	}
>  }

[Severity: High]
Can fastrpc_get_buff_overlaps() leave both mstart and do_cmo as zero for
mapped DMA-buf arguments that still require cache maintenance in
fastrpc_flush_args() and fastrpc_inv_args()?

First, for a mapped DMA-buf argument passed with args[i].ptr =3D=3D 0 and a
non-zero length (such as in fastrpc_init_create_process() when init.file is
0, or in fastrpc_get_args() where vma_lookup() is optional), the non-overlap
branch sets mstart =3D start =3D 0 and leaves do_cmo =3D false.  Because
fastrpc_flush_args() and fastrpc_inv_args() check
(ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) rather than a non-empty rang=
e,
cache maintenance is skipped whenever mstart is 0.

Second, overlaps are computed solely from user virtual addresses across all
arguments without checking whether overlapping entries share the same DMA-b=
uf
FD or even have a map, and only a single max_raix is tracked.  If an inline
buffer or a different DMA-buf of the same direction encloses a mapped DMA-b=
uf
range, or if an input DMA-buf is partially overlapped by an output buffer
that advances max_end and overwrites max_raix before an enclosed output ran=
ge
referencing the first DMA-buf is checked, mstart is zeroed and do_cmo remai=
ns
false, skipping the flush or invalidation and leaving stale data between the
CPU and DSP.

[ ... ]

> @@ -1078,6 +1086,54 @@ static int fastrpc_create_maps(struct fastrpc_invo=
ke_ctx *ctx)
>  	return 0;
>  }
> =20
> +static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra =3D ctx->rpra;
> +	int i, inbufs;
> +
> +	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> +
> +	for (i =3D 0; i < ctx->nbufs; ++i) {
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
> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);

[Severity: Medium]
Should fastrpc_flush_args() and fastrpc_inv_args() check the return value of
dma_buf_begin_cpu_access() and propagate errors to their callers?
dma_buf_begin_cpu_access() can fail (for example with -ERESTARTSYS while
waiting interruptibly on reservation fences in __dma_buf_begin_cpu_access()=
),
and ignoring the failure unconditionally calls dma_buf_end_cpu_access() and
proceeds with the RPC on unsynchronized buffers.

> +		}
> +	}
> +}

[Severity: Medium]
Does iterating over ctx->nbufs without deduplicating by map->buf flush or
invalidate the entire parent dma_buf multiple times when several argument
slices share one DMA-buf FD?

dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() synchronize the full
dma_buf scatterlist rather than the argument sub-range, so K non-enclosed (=
or
do_cmo) slices carved from the same dma_buf trigger K full-buffer cache wal=
ks
in fastrpc_flush_args() and fastrpc_inv_args().

> +
> +static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra =3D ctx->rpra;
> +	int i, inbufs;
> +
> +	inbufs =3D REMOTE_SCALARS_INBUFS(ctx->sc);
> +
> +	for (i =3D 0; i < ctx->nbufs; ++i) {
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
> +		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
> +			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
> +			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
> +		}
> +	}
> +}
[ ... ]
> @@ -1387,6 +1446,8 @@ static int fastrpc_internal_invoke(struct fastrpc_u=
ser *fl,  u32 kernel,
>  	if (err)
>  		goto bail;
> =20
> +	if (!fl->sctx->coherent)
> +		fastrpc_inv_args(ctx);
>  	/* make sure that all CPU memory writes are seen by DSP */
>  	dma_wmb();
>  	/* Send invoke buffer to remote dsp */
> @@ -1407,6 +1468,9 @@ static int fastrpc_internal_invoke(struct fastrpc_u=
ser *fl,  u32 kernel,
> =20
>  	/* make sure that all memory writes by DSP are seen by CPU */
>  	dma_rmb();
> +	if (!fl->sctx->coherent)
> +		fastrpc_inv_args(ctx);

[Severity: Medium]
Why does fastrpc_inv_args() call both dma_buf_begin_cpu_access() and
dma_buf_end_cpu_access() both before and after the RPC invocation?

In standard DMA-buf exporters (such as system_heap and cma_heap),
begin_cpu_access(DMA_FROM_DEVICE) syncs the buffer for the CPU (cache
invalidate on arm64) and end_cpu_access(DMA_FROM_DEVICE) syncs it for the
device (cache clean on arm64).  Calling fastrpc_inv_args() before
fastrpc_invoke_send() and again after fastrpc_wait_for_completion() performs
four full-buffer cache passes per output buffer instead of syncing for the
device before the RPC and syncing for the CPU after completion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120604.2640=
046-1-abhinav.parihar@oss.qualcomm.com?part=3D1
