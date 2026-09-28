Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE75C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAED10E8B7;
	Mon, 28 Sep 2026 13:46:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JF7hblBd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D3A10E8B7
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:46:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F9B74019C;
 Mon, 28 Sep 2026 13:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF781F000FF;
 Mon, 28 Sep 2026 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603190;
 bh=h+JF53NjR7RFRCpUx8+15+uAHLqchP+HksRZYy3+vGs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JF7hblBdcWJ8moqNBIB/Ks6MBg/EqG34DWXGSgFkvxXPWd+o202nSJ6DvVYV+aKPE
 nV4p2pHFbqqyOHPZ/S27BzAz0MSN69et8iQ6MDXyH/JRkKXHNiLcuX7zK7lv5CLLa4
 PCo1Z1IeB8UmH2CxBJiC3+sNCbRuQ2QVKLzYpwe9UobRMY9ARuSYHUZkJwWLIMHzG2
 V361wNrE/PBcJT/ldB4ioysZU7HBvtIF8WHyYRQZLexOGdc5lHdgpDMWBzNKdWd4Bn
 x4gVHqDHjV290/FjvH7zg3bDXRmcHrcG6wljjimhtDww1K22TJDyRCkupl7flPjHEV
 SGSOSu0aDwlyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <c33046bbadce5a2f14aa1874270ec2d10def58ef.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <c33046bbadce5a2f14aa1874270ec2d10def58ef.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:46:29 +0000
Message-Id: <20260928134630.2CF781F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma-buf: map leak and deadlock on invalid min_seg_shift
- [Medium] dma-buf: memory leak in dma_buf_io_ctx_create() dev_ops validati=
on
--

commit cebbd64805f3eac146806ef3dc1344fdf0a76c98
Author: Pavel Begunkov <asml.silence@gmail.com>

dma-buf: introduce initial file I/O infrastructure

This patch adds basic building blocks serving as an API between drivers and
upper layer subsystems to natively use dma-buf in the IO paths. It introduc=
es
the dma_buf_io_ctx and dma_buf_io_map structures to handle mapping, unmappi=
ng,
and invalidation operations.

> diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma-buf/dma-buf-io.c
[ ... ]
> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
> +{
[ ... ]
> +	map =3D ctx->dev_ops->map(ctx);
> +	if (!IS_ERR(map)) {
> +		atomic_inc(&ctx->active_maps);
> +		atomic_inc(&ctx->all_maps);
> +	}
> +	dma_resv_unlock(dmabuf->resv);
> +
> +	if (IS_ERR(map))
> +		return map;
> +	if (WARN_ON_ONCE(!map->min_seg_shift))
> +		return ERR_PTR(-EFAULT);

[Severity: High]
Does this error path leak the map and deadlock the system?

If map->min_seg_shift evaluates to 0 (for example, if an odd-length DMA
segment causes __ffs() to return 0), the WARN_ON_ONCE check will trigger.

Since atomic_inc(&ctx->active_maps) and atomic_inc(&ctx->all_maps) have
already executed for a valid map, returning ERR_PTR(-EFAULT) here skips
dropping the map's percpu_ref count and leaves the atomic counters
permanently elevated.=20

Could subsequent cleanup calls to dma_buf_io_wait_active_maps() or
dma_buf_io_wait_maps() then block forever waiting for the counters to reach
zero?

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

[Severity: Medium]
Can this early return leak the context and the dma-buf reference?

If the init_dma_buf_io_ctx callback succeeds but fails to populate the
required dev_ops, this path returns -EINVAL immediately.

It appears to skip the kfree(ctx) and dma_buf_put(dmabuf) teardown
operations that are present in the preceding error handling block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790602223.gi=
t.asml.silence@gmail.com?part=3D1
