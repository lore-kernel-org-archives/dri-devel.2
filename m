Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB91CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC1610E938;
	Tue, 13 Oct 2026 21:06:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5DD10EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:06:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FF49601DB;
 Tue, 13 Oct 2026 21:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B021F00893;
 Tue, 13 Oct 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791925593;
 bh=uhIG7MWKcqA6Em35BA+Y7koBZ58xu5PL8JQog20qCTo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AWJUnSPVw+QHK7ehFc21JG0x4khL7HouS++xvr3Jd6SDM6JTz1vJe1Tl+nJHgau5e
 UQtyDdQRZVPYQ/DJUV60xYSSqkiyinWq+JXvYZ3MwOcYUxW9dkZ4IDQhABm32CYnye
 7IV879VNl5V1G4It4HBRM+bkN7o8Qg9o6COWFZX5mQttM1afUxkyYFXDKqdFnFihS9
 0T4qOCMmNUPey1MQ8F2d/R7T96OBKMw7wqAusfkaAWAG26HYA69uTVbzeRPk3lvYkn
 1cwGe2hi/68OaR+x7R9rl2G1smhG0BO3PWXM+4lFFDi3Hdg0i+AbBTfCaD+mw0XZnH
 EhlMMN5oCFRIg==
Message-ID: <sashiko-outbox-170510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <1caebf340d205f6d4c5137e7a8a548ea3cf3b87d.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
 <1caebf340d205f6d4c5137e7a8a548ea3cf3b87d.1791924581.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:06:32 +0000
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
- [High] dma-buf: memory and reference leak in dma_buf_io_ctx_create missin=
g dev_ops
- [High] dma-buf: map leaked on invalid min_seg_shift in __dma_buf_io_creat=
e_map
- [High] dma-buf: deadlock risk by blocking on I/O inside dma_resv lock
- [Medium] dma-buf: resource leak in dma_buf_io_ctx_release() on map check =
failure
--

commit 420452d61f9f92ad48f07cea0dcd04c4e4a65bac
Author: Pavel Begunkov <asml.silence@gmail.com>
Subject: dma-buf: introduce initial file I/O infrastructure

This commit introduces the initial file I/O infrastructure for natively usi=
ng
dma-buf in the read-write path. It adds building blocks like dma_buf_io_ctx
and dma_buf_io_map to serve as an interface between upper layer subsystems
and the importer driver. Operations like mapping and unmapping are delegated
to the importer driver via dma_buf_io_ops.

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
Does this block indefinitely on hardware I/O completion while holding the
dmabuf->resv lock?

dma_buf_io_kill_map() is called from the invalidate_mappings callback. If t=
he
exporter calls invalidate_mappings while holding the dma_resv lock during m=
emory
reclaim, waiting synchronously for all in-flight I/O requests to drop their
references could cause an ABBA deadlock. Memory reclaim might try to acquire
the same dma_resv lock.

Additionally, dynamic importer rules dictate that invalidate_mappings must =
not
block indefinitely, but should instead detach or set fences so the exporter=
 can
wait on them.

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

[Severity: High]
Does this error path leak the map structure?

When map->min_seg_shift is zero, the function returns ERR_PTR directly. It
looks like this skips invoking dma_buf_io_map_release(map) or
ctx->dev_ops->unmap(ctx, map), which might permanently leak the map structu=
re,
its initialized percpu_ref, and any associated hardware DMA mappings.

> +
> +	ret =3D dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
> +				    true, MAX_SCHEDULE_TIMEOUT);

[Severity: High]
Can this wait cause a deadlock by blocking other lockers like shrinkers?

Since __dma_buf_io_create_map() holds the dma_resv lock, synchronously wait=
ing
on dma_resv_wait_timeout() with MAX_SCHEDULE_TIMEOUT might block any other
dma_resv locker while waiting for hardware fences to signal.

> +	if (ret <=3D 0) {
> +		if (!ret)
> +			ret =3D -EAGAIN;
> +		dma_buf_io_map_release(map);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* get a reference for the caller */
> +	percpu_ref_get(&map->refs);
> +	rcu_assign_pointer(ctx->map, map);
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

[Severity: High]
Does returning directly here leak the context and the dma_buf reference?

After allocating the context and getting a reference to dmabuf, if any of t=
he
required device operations are missing, the function returns -EINVAL direct=
ly.
This appears to leave the allocated ctx unfreed and the dmabuf reference
unreleased, without calling any cleanup like kfree() or dma_buf_put(), nor =
any
driver-specific release.

> +
> +	*out_ctx =3D ctx;
> +	return 0;
> +}
> +
> +void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
> +{
> +	dma_buf_io_ctx_shutdown(ctx);
> +
> +	if (WARN_ON_ONCE(rcu_dereference_protected(ctx->map, true)))
> +		return;

[Severity: Medium]
Does returning early from the destructor leak the context and pin the dma_b=
uf?

If the ctx->map is still populated during release, returning early here ski=
ps
the final ctx->dev_ops->release(ctx), dma_buf_put(ctx->dmabuf), and
kfree(ctx). Teardown functions shouldn't silently leak resources when they
encounter an invalid state.

> +
> +	ctx->dev_ops->release(ctx);
> +	dma_buf_put(ctx->dmabuf);
> +	kfree(ctx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791924581.gi=
t.asml.silence@gmail.com?part=3D1
