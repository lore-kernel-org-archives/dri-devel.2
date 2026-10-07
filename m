Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6F5CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 02:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123CB10E2DD;
	Wed,  7 Oct 2026 02:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gl/J9+zx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05AE210E2DD
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 02:01:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DD1C4167D;
 Wed,  7 Oct 2026 02:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A51F0089B;
 Wed,  7 Oct 2026 02:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791338517;
 bh=cwCzXgdXDbOTAVO/hibPFr1g7ahNuTRsP7eYdl0FAII=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gl/J9+zxi6frVpJlTgp/o1EgrD9JcjCjuwAvaFycHUN9NvhdyPHaH367Ra/mQrgg2
 l1hUXlL5Cchh4KMT1WWij1DrSOuqpDTCpAa2SAWB/e20f+Be1QW/Zz4aNXNlrguOH7
 ZxeFDJG5ipAp0i7/Uxe20GOG4SVPR+SpRLIVbD1Q5E83imEj12NPuJTb/h9gMaGiU/
 1TpI0MbZAMMV4pazzaHyk5ggnBfuEQhqKqfXu4e1BctU5gN/xwJXsG2BByE+kqlGXx
 zUhqgzZLiW/tzppgl67IlvkdaOTJQZk3bWkCfIbKd+xT8HtsTpfxmHXBTaRWPonWsA
 2Hdaysf0Q0vjw==
Message-ID: <sashiko-outbox-162578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/13] nvme-pci: implement dma-buf backed requests
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <624ec2c9b2118a97b4e5f425f0951e09c118deb5.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <624ec2c9b2118a97b4e5f425f0951e09c118deb5.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 02:01:56 +0000
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
- [High] block: nvme: heap buffer overflow in nvme_dma_buf_io_map() due to =
missing bounds check
--

commit 6ab5bd531acb81cbd400d2dec375c79d1f832e58
Author: Pavel Begunkov <asml.silence@gmail.com>

nvme-pci: implement dma-buf backed requests

This patch enables BIO_DMABUF_MAP backed requests. On registration, it maps
the dma-buf and stores it as a prp list used to initialize requests. All
attached contexts are stored in a new list dmabuf_ctxs, and synchronized
with dmabuf_lock.

> diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabu=
f.c
> new file mode 100644
> index 0000000000000..d58a38a75d673
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

[Severity: High]
Does this code overflow the map->dma_list[] flex array if the total mapped
length exceeds the calculated ctx->dmabuf->size?

nvme_dma_buf_io_map() calculates the number of flex array entries (nr_entri=
es)
based strictly on ctx->dmabuf->size. However, the loop that populates
map->dma_list is bounded by the total sg_dma_len(sg) across all entries in =
the
scatterlist returned by dma_buf_map_attachment().

The DMA mapping API explicitly allows the mapped DMA length (sg_dma_len) to=
 be
larger than the original buffer size. For instance, this can occur when an
IOMMU coalesces entries or aligns sizes to a larger IOMMU page size. A buggy
exporter could also supply a larger-than-expected scatterlist.

Without bounds-checking i against nr_entries, writing to map->dma_list[i++]
could result in a heap buffer overflow.

> +			dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +			sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D7
