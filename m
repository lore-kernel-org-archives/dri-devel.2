Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AEBCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8282F10E544;
	Wed, 14 Oct 2026 11:27:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA70310E544
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:26:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 38C7B60514;
 Wed, 14 Oct 2026 11:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE101F000FF;
 Wed, 14 Oct 2026 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791977217;
 bh=LyS9eBpdLSKZlQrNtaoz2Tpt3nh2vk0rJBU4eYpcwHk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kmh0ibCc4OE4ocSJIeMvl/RNJn2p4b8DM4qDeio8haErRzs+a/1KSXkltNje51tDi
 nVAzMlqxxmDr2vmP7MUP8WICR9FKKJxfTCKp69AmtBd019zGUBiaeKt6DI+ttXaEPN
 0rTedXGaiPryb5oiMpU+HUJjsD/ZQp0qVXWmKmeyI8IMJuzyjLXI0RJBKm7mwpCVt/
 lrQa1WcxPOturFaUfq7d+MiLFiSx7F2amSIt1NgBJoqOjDbSi6L5po4FcbXkFvoZhH
 ppqGmLq48OaoT902DWeIlXjYpTdQiGgnmb6mhLeZ8wP3lGuyryuxjuCohK2Rou2rPe
 GpjpQ90VRHkgA==
Message-ID: <sashiko-outbox-171198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/13] nvme-pci: implement dma-buf backed requests
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <9540e74b5d2dd1a5dc0d436bc0c2a6f5e18fc389.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
 <9540e74b5d2dd1a5dc0d436bc0c2a6f5e18fc389.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:26:57 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] nvme: heap buffer overflow in nvme_dma_buf_io_map() on oversiz=
ed sg_table
--

commit c0ad27ffb27d58a9a9cd8c22288b3a3645727e63
Author: Pavel Begunkov <asml.silence@gmail.com>

nvme-pci: implement dma-buf backed requests
   =20
This commit adds support for DMA-buf backed requests in the NVMe PCI host
driver. On registration, the dma-buf is mapped and stored as a prp list to
initialize requests. All attached contexts are stored in a new list
synchronized with a mutex.

> diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabu=
f.c
> new file mode 100644
> index 0000000000000..161e4ffa6919b
> --- /dev/null
> +++ b/drivers/nvme/host/pci-dmabuf.c
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
> +	if (ctx->dmabuf->size % NVME_CTRL_PAGE_SIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	map =3D kvmalloc_flex(*map, dma_list, nr_entries);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +	map->nr_entries =3D nr_entries;
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
> +		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
> +		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +		while (sg_len) {
> +			map->dma_list[i++] =3D dma_addr;

[Severity: Critical]
Could this lead to a heap buffer overflow?

The flex array map->dma_list is allocated with a fixed capacity of
nr_entries, which is derived strictly from ctx->dmabuf->size.
However, this loop populates the array based on the total length of the
sg_table returned by dma_buf_map_attachment().

Because dma_buf_map_attachment() does not enforce that the returned
sg_table's length matches dmabuf->size, a buggy or malicious exporter
could return a larger table. In that case, i would exceed nr_entries
without any bounds check, leading to an out-of-bounds write. This
could allow memory corruption triggerable by unprivileged users capable
of creating and exporting dmabufs.

> +			dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +			sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791975048.gi=
t.asml.silence@gmail.com?part=3D7
