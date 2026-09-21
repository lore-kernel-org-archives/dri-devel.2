Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E660C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F23410E843;
	Mon, 21 Sep 2026 13:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mp1S23D7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D37810E7EE
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:58:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 79424600C8;
 Mon, 21 Sep 2026 13:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB61F000FF;
 Mon, 21 Sep 2026 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789999103;
 bh=QteMOKNqp9usRKtIPXBEWzrfEOAUeF6CeCuBZEhLIG4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mp1S23D7dRKeGuOEUZPUKhZOwC+5p/JaBnIzo1kM2V+y2ZAdEYAHg1/ToqmMi6b+5
 H4T7dx0CmbaUi/pfWK7+ZUsjZFY9tbEAM+jjou6bEgSGU+b1/gGC8UOjrfgjou02Wk
 X8i1PwwAKO+uJXi7NmM9tZVBCDlR+pktQmhLZtlfI/dyGztiRDBn9b89ce/b38UDY9
 vEKEoLcJmVLGVv1kuW7heGDvgq+z5yABWbTeDwC2rKB7qon/Y2x9bLKOkiqbBXWHNY
 EbzLkC+1gcR89OnqPUQCOMJzdrMvZlGokOWdZU1YjAo7XL+PwBKRdwwzmX3NUVqmyf
 jdZ2I1liLkN+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:58:22 +0000
Message-Id: <20260921135823.05EB61F000FF@smtp.kernel.org>
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
- [Critical] nvme: deadlock in nvme_dev_disable() during device removal
- [High] nvme: illegal use of single-mapping sync API on sg-mapped dmabuf
- [High] nvme: heap buffer overflow in nvme_dma_buf_io_map()
- [High] nvme: memory leak of dmabuf map in unmap path
- [High] nvme: controller reset permanently breaks dmabuf registrations
--

commit 1bee4d32dec1291a7dc832efe4620264ba2425af
Author: Pavel Begunkov <asml.silence@gmail.com>

nvme-pci: implement dma-buf backed requests

Enable BIO_DMABUF_MAP backed requests. On registration we map the
dma-buf and store it as a prp list, which is then used to initialise
requests. All attached contexts are stored in a new list dmabuf_ctxs,
and additions/removals are synchronised with dmabuf_lock.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a953c0697f994..5a45710a1daf2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

[ ... ]

> @@ -865,6 +876,140 @@ static void nvme_free_descriptors(struct request *r=
eq)
> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
> +		struct request *req)
> +{

[ ... ]

> +	while (length > 0) {
> +		dma_sync_single_for_cpu(dev, dma_list[map_idx++],
> +					NVME_CTRL_PAGE_SIZE, dma_dir);
> +		length -=3D NVME_CTRL_PAGE_SIZE;
> +	}
> +}

[Severity: High]
Does this code unlawfully use the single-mapping sync API on an sg-mapped
address?

The dmabuf memory is mapped using dma_buf_map_attachment() which uses
dma_map_sg(). The driver then illegally syncs sub-pages of this scatterlist
using dma_sync_single_for_cpu() in nvme_dmabuf_map_sync_for_cpu() and
dma_sync_single_for_device() in nvme_dmabuf_map_sync_for_device().

This violates the DMA API. On platforms with SWIOTLB, this can crash or
cause silent data corruption because the bounce buffer metadata expects the
exact original dma_addr_t and size mapped by the sg API, not piecemeal
chunks.

> +
> +static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
> +		struct request *req)
> +{

[ ... ]

> +	while (length > 0) {
> +		dma_sync_single_for_device(dev, dma_list[map_idx++],
> +					   NVME_CTRL_PAGE_SIZE, dma_dir);
> +		length -=3D NVME_CTRL_PAGE_SIZE;
> +	}
> +}

[ ... ]

> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx =
*ctx)
> +{
> +	unsigned nr_entries =3D ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
> +	struct nvme_dma_buf_io_ctx *nvme_ctx =3D ctx->dev_priv;
> +	struct dma_buf_attachment *attach =3D nvme_ctx->attach;
> +	unsigned long tmp, i =3D 0;
> +	struct nvme_dmabuf_map *map;
> +	struct scatterlist *sg;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +	map =3D kmalloc_flex(*map, dma_list, nr_entries);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sgt =3D dma_buf_map_attachment(attach, ctx->dir);
> +	if (IS_ERR(sgt)) {
> +		ret =3D PTR_ERR(sgt);
> +		sgt =3D NULL;
> +		goto err;
> +	}
> +
> +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +		dma_addr_t dma_addr =3D sg_dma_address(sg);
> +		unsigned long sg_len =3D sg_dma_len(sg);
> +
> +		if (sg_len % NVME_CTRL_PAGE_SIZE) {
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +		while (sg_len) {
> +			map->dma_list[i++] =3D dma_addr;
> +			dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +			sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +		}

[Severity: High]
Can an attacker controlling the dmabuf size trigger a heap buffer overflow
here?

In nvme_dma_buf_io_map(), nr_entries is calculated as
ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE, truncating down if the size is
unaligned. The flex array map is allocated for nr_entries.

The sg_table returned by the exporter covers the rounded-up size. The loop
iterates based on sg_len and writes unconditionally to map->dma_list. If
size was unaligned, sg_len will exceed the truncated calculated size,
causing the loop to write past the end of the kmalloc_flex allocation.

> +	}
> +
> +	ret =3D dma_buf_io_init_map(ctx, &map->base, sgt);
> +	if (ret)
> +		goto err;
> +	map->nr_entries =3D nr_entries;
> +	map->sgt =3D sgt;
> +	return &map->base;
> +err:
> +	if (sgt)
> +		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> +	kfree(map);
> +	return ERR_PTR(ret);
> +}
> +
> +static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
> +		struct dma_buf_io_map *map_base)
> +{
> +	struct nvme_dma_buf_io_ctx *nvme_ctx =3D ctx->dev_priv;
> +	struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(map_base);
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +	dma_buf_unmap_attachment(nvme_ctx->attach, map->sgt, ctx->dir);
> +}

[Severity: High]
Does this code leak the memory of the map structure and percpu data on every
unmap operation?

nvme_dma_buf_io_map() allocates the map structure using kmalloc_flex().
The framework calls dev_ops->unmap (nvme_dma_buf_io_unmap) when the map is
released. nvme_dma_buf_io_unmap() unmaps the attachment but fails to call
kfree(map) and percpu_ref_exit(&map->refs).

[ ... ]

> +static void nvme_pci_remove_dmabuf(struct nvme_dev *dev)
> +{
> +	struct nvme_dma_buf_io_ctx *ctx, *tmp;
> +
> +	mutex_lock(&dev->dmabuf_lock);
> +	list_for_each_entry_safe(ctx, tmp, &dev->dmabuf_ctxs, list) {
> +		dma_buf_io_detach(ctx->ctx);
> +		dma_buf_detach(ctx->ctx->dmabuf, ctx->attach);
> +		list_del_init(&ctx->list);
> +	}
> +	mutex_unlock(&dev->dmabuf_lock);
> +}

[Severity: High]
Does this permanently break dmabuf registrations across transient
transport resets?

During a transient controller reset (e.g. from an IO timeout),
nvme_dev_disable() calls nvme_pci_remove_dmabuf(). This permanently
detaches the dmabuf and marks the context's maps as killed.

The NVMe controller resets and comes back online, but the userspace
registered buffers are permanently destroyed and will return -ENODEV. This
breaks the intended transparency of NVMe resets, causing IO submissions
using registered dmabufs to fail unrecoverably until userspace re-registers
them.

[ ... ]

> @@ -3316,6 +3633,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, =
bool shutdown)
>  	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
>  	bool dead;
> =20
> +	nvme_pci_remove_dmabuf(dev);
> +
>  	mutex_lock(&dev->shutdown_lock);

[Severity: Critical]
Could this sequence result in an ABBA deadlock preventing device recovery?

nvme_dev_disable() calls nvme_pci_remove_dmabuf(dev) before calling
nvme_cancel_tagset(). nvme_pci_remove_dmabuf() calls dma_buf_io_detach()
which blocks waiting for all active dmabuf IOs to complete.

Since the device is dead or resetting, the hardware won't complete the IOs.
The IOs must be aborted by nvme_cancel_tagset(), but the thread is
permanently blocked waiting for them. This was not resolved in subsequent
patches in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D6
