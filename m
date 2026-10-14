Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D360CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7EA210FCE6;
	Wed, 14 Oct 2026 11:13:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F3610FCE6
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:13:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0799602C8;
 Wed, 14 Oct 2026 11:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3AB1F00893;
 Wed, 14 Oct 2026 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791976424;
 bh=LQMzyowZAE//N9MEdWMHDQipQMtotf10OHZMv3vCopo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e6freusK05+cEkSGL66R6zOg5cMTqtryDSkJF7xL/C1MnqD9gvpknqKj0PlSfK/px
 KpVfJLI0SwBCGsiSjE+seYOMhC47BW8QkF2oph36LxoYp3A2lm4IDxdFAGxqqFOROE
 P1ONKgziiVTOKw7ICJdMexPGeBf+Yt+xpT115yUhC0c0ZJg5Qy4/u8RtJ4Y6genYZx
 gsKF8I0zK5hj0biIo5GcTg8Y7y3CgmBKKBeXaYZe0q0gLeb4620wyGYVGIisfXllpM
 O5jOH9NUTxNXEwCnQeSltkl65ohKqsZ09zZqj0UtQP8K4lqVD3FHdNny5naogWYHpR
 yuQE/lgcuuWJg==
Message-ID: <sashiko-outbox-171183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
 <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:13:44 +0000
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
- [High] dma-buf: deadlock due to synchronous wait for I/O in invalidate_ma=
ppings
- [Medium] dma-buf: memory leak in dma_buf_io_ctx_create() on invalid dev_o=
ps
- [Medium] dma-buf: memory leak of dma_buf_io_map in __dma_buf_io_create_ma=
p()
- [Medium] dma-buf: memory leak in dma_buf_io_ctx_release() due to early re=
turn
--

commit 8fdf381fa2ecf3131c663cbe675d98398bdf985e
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf: introduce initial file I/O infrastructure

This commit introduces basic building blocks (dma_buf_io_ctx and
dma_buf_io_map) to natively use dma-buf in the read-write/IO path.
It provides the initial API for drivers and upper layer subsystems
to interact with the buffers.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma-buf/dma-buf-io.c

[ ... ]

> +static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
> +{
> +	struct dma_buf_io_map *map;
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +	map =3D rcu_dereference_protected(ctx->map,
> +				dma_resv_held(ctx->dmabuf->resv));
> +	if (!map)
> +		return;
> +
> +	rcu_assign_pointer(ctx->map, NULL);
> +	percpu_ref_kill(&map->refs);
> +	/* make sure the map is not visible via ctx->map */
> +	synchronize_rcu_expedited();
> +	wait_for_completion(&map->drained);

[Severity: High]
Does this synchronously block on I/O completion while holding the
dma_resv lock?

dma_buf_io_invalidate_mappings() is intended as an invalidation callback
which is invoked while holding the dma_resv lock to evict or move the
dma-buf.

The dynamic importer contract (include/linux/dma-buf.h) states that
importers should set fences for any access they can't disable immediately
rather than blocking indefinitely. Since block I/O can be delayed or depend
on memory allocation, waiting for it in the memory reclaim/eviction path
could potentially cause a deadlock.

> +	dma_buf_io_map_release(map);
> +}

[ ... ]

> +static struct dma_buf_io_map *__dma_buf_io_create_map(struct dma_buf_io_=
ctx *ctx)
> +{
> +	struct dma_buf *dmabuf =3D ctx->dmabuf;
> +	struct dma_buf_io_map *map;
> +	long ret;
> +
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	if (ctx->is_dead)
> +		return ERR_PTR(-ENOENT);
> +
> +	map =3D __dma_buf_io_get_map(ctx);
> +	if (map)
> +		return map;
> +
> +	map =3D ctx->dev_ops->map(ctx);
> +	if (IS_ERR(map))
> +		return map;
> +
> +	if (WARN_ON_ONCE(!map->min_seg_shift))
> +		return ERR_PTR(-EFAULT);

[Severity: Medium]
If this min_seg_shift check fails, does it leak the newly allocated map
structure?

It appears to return ERR_PTR(-EFAULT) directly without invoking
dma_buf_io_map_release(map) or the driver's unmap callback.

> +
> +	ret =3D dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				    true, MAX_SCHEDULE_TIMEOUT);

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
> +	ctx =3D kzalloc_obj(*ctx);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->dir =3D dir;
> +	ctx->dmabuf =3D dmabuf;
> +	get_dma_buf(dmabuf);
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
Could this error path leak the context and the dma-buf reference?

The early return bypasses kfree(ctx) and dma_buf_put(dmabuf). It also
doesn't seem to provide a way for the driver to clean up any internal
resources it might have allocated during the init_dma_buf_io_ctx() call.

> +
> +	*out_ctx =3D ctx;
> +	return 0;
> +}

[ ... ]

> +void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
> +{
> +	dma_buf_io_ctx_shutdown(ctx);
> +
> +	if (WARN_ON_ONCE(rcu_dereference_protected(ctx->map, true)))
> +		return;

[Severity: Medium]
Could this early return cause a memory leak?

If the warning triggers, the function returns immediately and skips the
final teardown, meaning ctx->dev_ops->release(ctx), dma_buf_put(ctx->dmabuf=
),
and kfree(ctx) won't be executed.

> +
> +	ctx->dev_ops->release(ctx);
> +	dma_buf_put(ctx->dmabuf);
> +	kfree(ctx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791975048.gi=
t.asml.silence@gmail.com?part=3D1
