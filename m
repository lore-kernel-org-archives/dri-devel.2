Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2547CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C49410F459;
	Wed,  7 Oct 2026 01:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxumN2Jy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613CC10F459
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:52:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C0A9601FA;
 Wed,  7 Oct 2026 01:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D91A1F0089B;
 Wed,  7 Oct 2026 01:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791337953;
 bh=e4bPUPk6+AIHl/KpxhadlIeHjLXr+PKv/lu47U6U66M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dxumN2JyB3ZKTkEUrpfr+9/0zkj/hSXNi88QNwjZ2wBfE9VqU3q7BZsUXutFwbNVf
 5/tZtL70Ig03XekQf6oyaE3xFp2iq+oGwjm0MGQHJFyiNXDXbU3uHoXQLiUoSWNoz3
 nRWxQJZnnCpNtdwkBkm3fcKgE+6MK2iwFW7uuw+3B0Gt8m3TlTdSeyhWak0rktevUx
 3wO6yr+Iusm3c21+yOHUPvy2r0r01hBxcrGS+1HaHpke5gHi/F6Z4EEHAkepjGd/No
 C0Eaz/bmbhBOJpEl9BEfkV4bF2pEidFVY5fJYrg3vqI6/Q9kN+8oPKPWggoIT3SnWt
 k/CiaLDxYxqqA==
Message-ID: <sashiko-outbox-162572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <b44df9fed6e346110c504ee312bb0083c7e75574.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <b44df9fed6e346110c504ee312bb0083c7e75574.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:52:32 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] dma-buf: memory leak in dma_buf_io_ctx_create() on dev_ops validat=
ion failure
- [High] dma-buf: GFP_KERNEL allocation while holding dma_resv lock causes =
reclaim deadlocks
- [High] dma-buf: deadlock when waiting for I/O completion with dma_resv lo=
ck held
- [Medium] dma-buf: memory leak of map object in __dma_buf_io_create_map() =
on min_seg_shift failure
- [Medium] dma-buf: memory leak when ctx->dev_ops validation fails
- [Medium] dma-buf: map and percpu_ref leak when min_seg_shift is zero
--

commit 942b5b5c2d4bd9e70cda186064a1b0a1f705440a
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf: introduce initial file I/O infrastructure

This commit introduces the basic building blocks (dma_buf_io_ctx and
dma_buf_io_map) to support using dma-buf natively in read-write / IO paths.
It provides an API between upper layer subsystems (like io_uring) and impor=
ter
drivers to facilitate map creation and invalidation.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> new file mode 100644
> index 0000000000000..9ba9c17f900af
> --- /dev/null
> +++ b/drivers/dma-buf/dma-buf-io.c
> @@ -0,0 +1,183 @@
[ ... ]
> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
> +{
> +	struct dma_buf_io_map *map;
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
[ ... ]
> +	rcu_assign_pointer(ctx->map, NULL);
> +	percpu_ref_kill(&map->refs);
> +	/* make sure the map is not visible via ctx->map */
> +	synchronize_rcu_expedited();
> +	wait_for_completion(&map->drained);

[Severity: High]
Does waiting for I/O completion here risk a deadlock with memory reclaim?

Since dma_buf_io_kill_map() is called with the dma_resv lock held (and
asserted above), waiting synchronously for unbounded in-flight I/O via
wait_for_completion() could block memory shrinkers.=20

If the active I/O operation itself requires memory allocation, it creates an
ABBA deadlock where the I/O needs memory, the shrinker needs the dma_resv
lock, and this function holds the lock while waiting for the I/O.

This is especially problematic when called through
dma_buf_io_invalidate_mappings() from an exporter's invalidate_mappings
callback during memory pressure.

> +	dma_buf_io_map_release(map);
> +}
> +
> +int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_ma=
p *map,
> +			struct sg_table *sgt)
> +{
> +	unsigned seg_shift =3D ~0U;
> +	struct scatterlist *sg;
> +	unsigned long tmp;
> +	int ret;
> +
> +	for_each_sgtable_dma_sg(sgt, sg, tmp)
> +		seg_shift =3D min(seg_shift, __ffs(sg_dma_len(sg)));
> +
> +	ret =3D percpu_ref_init(&map->refs, dma_buf_io_map_refs_cb, 0, GFP_KERN=
EL);

[Severity: High]
Can this GFP_KERNEL allocation trigger a reclaim deadlock?

dma_buf_io_init_map() initializes the percpu_ref using GFP_KERNEL, which
permits direct memory reclaim. This function is invoked from the driver's
map callback via __dma_buf_io_create_map().

However, the caller dma_buf_io_create_map() acquires the dma_resv lock
before executing this sequence:

dma_buf_io_create_map() {
	ret =3D dma_resv_lock_interruptible(ctx->dmabuf->resv, NULL);
	...
	map =3D __dma_buf_io_create_map(ctx);
}

Because GPU and other dma-buf shrinkers attempt to acquire dma_resv locks
to evict buffers, doing a GFP_KERNEL allocation while holding this lock
creates an ABBA deadlock vulnerability. Should this use GFP_NOWAIT or
be moved outside the lock?

> +	if (ret)
> +		return ret;
[ ... ]
> +static struct dma_buf_io_map *__dma_buf_io_create_map(struct dma_buf_io_=
ctx *ctx)
> +{
[ ... ]
> +	map =3D ctx->dev_ops->map(ctx);
> +	if (IS_ERR(map))
> +		return map;
> +
> +	if (WARN_ON_ONCE(!map->min_seg_shift))
> +		return ERR_PTR(-EFAULT);

[Severity: Medium]
If map->min_seg_shift is zero, does this leak the map object?

The early return -EFAULT happens after the driver successfully allocates
and initializes the map via ctx->dev_ops->map(ctx). Returning here bypasses
releasing the map and its percpu_ref initialized in dma_buf_io_init_map(),
as well as any driver-specific resources.

> +
> +	ret =3D dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
[ ... ]
> +int dma_buf_io_ctx_create(struct file *file,
> +			   struct dma_buf *dmabuf,
> +			   enum dma_data_direction dir,
> +			   struct dma_buf_io_ctx **out_ctx)
> +{
[ ... ]
> +	ret =3D file->f_op->init_dma_buf_io_ctx(file, ctx);
> +	if (ret) {
> +		kfree(ctx);
> +		dma_buf_put(dmabuf);
> +		return ret;
> +	}
> +
> +	if (WARN_ON_ONCE(!ctx->dev_ops ||
> +			 !ctx->dev_ops->map ||
> +			 !ctx->dev_ops->unmap ||
> +			 !ctx->dev_ops->release))
> +		return -EINVAL;

[Severity: High]
If the dev_ops validation fails here, do we leak ctx and the dmabuf
reference?

This early return abandons the ctx object and dmabuf reference without
cleaning them up. It skips freeing ctx, dropping the dmabuf reference
acquired earlier by get_dma_buf(dmabuf), and executing any driver-specific
cleanup that might have occurred during init_dma_buf_io_ctx().

> +
> +	*out_ctx =3D ctx;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D1
