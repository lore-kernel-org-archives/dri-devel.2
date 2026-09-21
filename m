Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F988C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68FC10E563;
	Mon, 21 Sep 2026 13:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cJtQBWO1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629F410E78F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:53:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C1CF4049E;
 Mon, 21 Sep 2026 13:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035B81F000FF;
 Mon, 21 Sep 2026 13:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789998824;
 bh=l4+5u4KzXAeivN3jLwJ+e5/X/nuZpZ36v928dff9mqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cJtQBWO1GGE9tOmGJfCm6SDmCUvDyWpyxa1BRH5nEkgU6WG3mlhu8flJnKhzhk3A4
 wjGSZX3QQXrYwZMaM0v+qSJd6oXJdgOlMLOtINiq6gA9rXNFl8F2I38+ZW2pvmxMdn
 xCx0KTOzfsOOmUzZYepti9jGyM5/jZ/ECCxfYQTBgDmql6OHAco+W6Hi2fbad3oJgc
 qasSrYRmAEuGc/lpEtkYqwLpXCj3dsv94eONdLtCSQsguA6bOH1gOQVjR5i/Ug29DK
 YwPVYCsWqPJ0ys/dH7Q81tCexjwWMER+tq2ULibFe2JgTJMET6cBa/oLPRqHI7CgEK
 vKyoidTuZETiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:53:43 +0000
Message-Id: <20260921135344.035B81F000FF@smtp.kernel.org>
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
- [Critical] dma-buf: TOCTOU race allows a stale map to escape concurrent i=
nvalidation
- [High] dma-buf: Use-After-Free of ctx in waitqueue due to race condition
- [High] dma-buf: GFP_KERNEL allocation performed while holding dmabuf->res=
v ww_mutex
- [Medium] dma-buf: Hardcoded kfree(map) restricts driver structure embeddi=
ng
- [Medium] dma-buf: Memory leak of ctx and dmabuf reference on incomplete d=
ev_ops error path
- [Medium] dma-buf: Memory leak of map structure and DMA mappings on min_se=
g_shift validation error
--

commit b9251fd88ee105b166b558434c10ce6e3b106691
Author: Pavel Begunkov <asml.silence@gmail.com>
Subject: dma-buf: introduce initial file I/O infrastructure

This commit adds basic building blocks serving as a glue and API between
drivers and upper layer subsystems providing the uAPI. It introduces
struct dma_buf_io_ctx and struct dma_buf_io_map, allowing dma-buf to be
natively used in the read-write / IO path.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> new file mode 100644
> index 0000000000000..8312637a299f6
> --- /dev/null
> +++ b/drivers/dma-buf/dma-buf-io.c
[ ... ]
> @@ -22,17 +22,17 @@ static void dma_buf_io_map_release_work(struct work_s=
truct *work)
>  {
>  	struct dma_buf_io_map *map =3D container_of(work, struct dma_buf_io_map,
>  						  release_work);
>  	struct dma_buf_io_ctx *ctx =3D map->ctx;
>  	struct dma_buf *dmabuf =3D ctx->dmabuf;
> =20
>  	dma_resv_lock(dmabuf->resv, NULL);
>  	ctx->dev_ops->unmap(ctx, map);
>  	dma_resv_unlock(dmabuf->resv);
> =20
>  	percpu_ref_exit(&map->refs);
>  	kfree(map);

[Severity: Medium]
Since drivers allocate this map object (often embedding it in a larger
structure), does this unconditional kfree(map) restrict where drivers can
embed the structure?

If a driver needs to use vmalloc or embed the map at a non-zero offset,
this will cause a panic. Could a .free callback be provided for safe
lifecycle management?

> =20
>  	atomic_dec(&ctx->all_maps);
>  	wake_up(&ctx->maps_wq);

[Severity: High]
Can this sequence lead to a use-after-free on ctx?

If atomic_dec(&ctx->all_maps) drops the count to 0, a concurrent thread
blocked in dma_buf_io_wait_maps() can wake up, return, and free the ctx via
dma_buf_io_ctx_release():

Thread 1 (waiter):
dma_buf_io_ctx_release()
  dma_buf_io_wait_maps()
    wait_event() unblocks since atomic_read(&ctx->all_maps) =3D=3D 0.
  dma_buf_io_put_ctx() is called and frees ctx.

Thread 2 (worker here):
Proceeds to call wake_up(&ctx->maps_wq) on the now-freed ctx memory.

>  }
[ ... ]
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
> +	ret =3D percpu_ref_init(&map->refs, dma_buf_io_map_refs_release, 0,
> +			      GFP_KERNEL);

[Severity: High]
Does this GFP_KERNEL allocation violate DMA-buf locking rules?

dma_buf_io_create_map() calls ctx->dev_ops->map(ctx) while holding the
dmabuf->resv ww_mutex. If the driver then calls dma_buf_io_init_map() under
this lock, the GFP_KERNEL allocation could deadlock if memory reclaim
attempts to acquire dma_resv locks.

> +	if (ret)
> +		return ret;
> +	map->min_seg_shift =3D seg_shift;
> +	map->ctx =3D ctx;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(dma_buf_io_init_map, "DMA_BUF");
> +
> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
> +{
> +	struct dma_buf *dmabuf =3D ctx->dmabuf;
> +	struct dma_buf_io_map *map;
> +	long ret;
> +
> +	guard(mutex)(&ctx->map_create_mutex);
> +
> +	scoped_guard(mutex, &ctx->map_mutex) {
> +		if (ctx->maps_killed)
> +			return ERR_PTR(-ENOENT);
> +		/* recheck under the lock in case it has already been re-created */
> +		map =3D __dma_buf_io_get_map(ctx);
> +		if (map)
> +			return map;
> +	}
> +
> +	dma_buf_io_wait_active_maps(ctx);
> +
> +	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				    true, MAX_SCHEDULE_TIMEOUT);
> +	if (ret <=3D 0) {
> +		if (!ret)
> +			ret =3D -EAGAIN;
> +		dma_resv_unlock(dmabuf->resv);
> +		return ERR_PTR(ret);
> +	}
> +
> +	map =3D ctx->dev_ops->map(ctx);
> +	dma_resv_unlock(dmabuf->resv);
> +
> +	if (IS_ERR(map))
> +		return map;
> +	if (WARN_ON_ONCE(!map->min_seg_shift))
> +		return ERR_PTR(-EFAULT);

[Severity: Medium]
If this validation fails and we return -EFAULT, do we leak the map structure
and the underlying device DMA mappings?

It looks like we are bypassing ctx->dev_ops->unmap() and the corresponding
map structure freeing here.

[Severity: Critical]
Does this sequence create a TOCTOU race with dma_buf_io_invalidate_mappings=
()?

The map is created under dmabuf->resv lock, but we unlock it before updating
ctx->map and ctx->active_maps.=20

If an exporter triggers an invalidation:

1. dma_buf_io_create_map() calls ctx->dev_ops->map(ctx).
2. It then calls dma_resv_unlock(dmabuf->resv).
3. The exporter acquires the dmabuf->resv lock and calls
   dma_buf_io_invalidate_mappings().
4. dma_buf_io_kill_maps() and dma_buf_io_wait_active_maps() observe
   no active maps and finish the invalidation.
5. dma_buf_io_create_map() resumes, increments active_maps, and publishes
   the now-stale map to ctx->map.

This allows the stale physical memory mapping to escape to the caller.

> +
> +	atomic_inc(&ctx->active_maps);
> +	atomic_inc(&ctx->all_maps);
> +	/* get a reference for the caller */
> +	percpu_ref_get(&map->refs);
> +
> +	scoped_guard(mutex, &ctx->map_mutex)
> +		rcu_assign_pointer(ctx->map, map);
> +	return map;
> +}
[ ... ]
> +int dma_buf_io_ctx_create(struct file *file,
> +			   struct dma_buf *dmabuf,
> +			   enum dma_data_direction dir,
> +			   struct dma_buf_io_ctx **out_ctx)
> +{
> +	struct dma_buf_io_ctx *ctx;
> +	int ret;
> +
> +	if (!file->f_op->init_dma_buf_io_ctx)
> +		return -EOPNOTSUPP;
> +
> +	ctx =3D kmalloc_obj(*ctx);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	memset(ctx, 0, sizeof(*ctx));
> +	ctx->dir =3D dir;
> +	ctx->dmabuf =3D dmabuf;
> +	get_dma_buf(dmabuf);
> +	mutex_init(&ctx->map_mutex);
> +	mutex_init(&ctx->map_create_mutex);
> +	atomic_set(&ctx->active_maps, 0);
> +	atomic_set(&ctx->all_maps, 0);
> +	init_waitqueue_head(&ctx->maps_wq);
> +
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

[Severity: Medium]
If this check fails, does it leak the allocated ctx and the dmabuf referenc=
e?

The previous error path handles cleanup via kfree(ctx) and dma_buf_put(dmab=
uf),
but this one bails out without cleaning up.

> +
> +	*out_ctx =3D ctx;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D1
