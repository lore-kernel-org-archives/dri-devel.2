Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E97DC9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADA610EABE;
	Mon, 28 Sep 2026 14:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BTaRot/Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A63710EAA9
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:02:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B917600CB;
 Mon, 28 Sep 2026 14:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C56B1F000FF;
 Mon, 28 Sep 2026 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790604128;
 bh=BOa3sIAG7r2EuI4F9nzIg8VrPUo/oQJA+Galf14HOsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BTaRot/YtNOtkIPFG0j5W9lFu+AG++el3qopIo3RMW6zp2WeY8+Fq8WDF1MNbhzvu
 6xgi4MQk3ZXW3oD5NU0Hm4TeII9IVbPfhgECKgC8TqriQlYwCzAobD2YNEC2yBzYwW
 NT4MiOOteYbCpa/ohsmt0PcMti/HwVgODhC8wiw9R4fchqa5Z9B5CtH2WIYesy8Oh1
 sGmkp87r0+0OuySU+YdYXleGBU+vLRr1PK/YHd98OnGWV+nxtV8YNF9T5xsTMN/+lb
 /H+SdzgaPd2T455gZsRvm6IgPNcLqQsyode02VoznN4UfifBm2fez3PD6b1e3aoUgh
 rTHUKrF8nkefA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:02:07 +0000
Message-Id: <20260928140208.0C56B1F000FF@smtp.kernel.org>
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
- [Critical] block: out-of-bounds heap read in nvme_rq_setup_dmabuf_map all=
ows arbitrary DMA
- [High] mm: invalid kfree() on kvmalloc_flex() allocation in nvme_dma_buf_=
io_map
- [High] mm: heap buffer overflow in nvme_dma_buf_io_map due to truncated n=
r_entries
- [High] mm: double free of PRP lists on nvme_rq_setup_dmabuf_map error path
--

commit 0b541f35b5346961c2c0d5b3cd4aa8c755c332a2
Author: Pavel Begunkov <asml.silence@gmail.com>

nvme-pci: implement dma-buf backed requests

Enable BIO_DMABUF_MAP backed requests. On registration we map the
dma-buf and store it as a prp list, which is then used to initialise
requests. All attached contexts are stored in a new list dmabuf_ctxs,
and additions/removals are synchronised with dmabuf_lock.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

[ ... ]

> +static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
> +		struct request *req)
> +{
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +
> +	nvme_dmabuf_map_sync_for_cpu(dev, req);
> +
> +	if (iod->nr_descriptors)
> +		nvme_free_descriptors(req);
> +}

[ ... ]

> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
> +		struct nvme_queue *nvmeq)
> +{
> +	struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +	struct bio *bio =3D req->bio;
> +	struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf_map);
> +	unsigned bvec_done =3D bio->bi_iter.bi_offset;
> +	unsigned map_idx =3D bvec_done / NVME_CTRL_PAGE_SIZE;
> +	unsigned offset =3D bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
> +	int length =3D blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offse=
t);
> +	dma_addr_t *dma_list =3D map->dma_list;
> +	u64 prp1_dma =3D dma_list[map_idx++] + offset;
> +	u64 dma_addr, prp2_dma;
> +	dma_addr_t prp_dma;
> +	__le64 *prp_list;
> +	unsigned i;
> +
> +	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
> +
> +	if (length <=3D 0) {
> +		prp2_dma =3D 0;
> +		goto done;
> +	}
> +
> +	if (length <=3D NVME_CTRL_PAGE_SIZE) {
> +		prp2_dma =3D dma_list[map_idx];

[Severity: Critical]
Is map_idx checked against map->nr_entries here?

If dmabuf->size is 4608 bytes, nr_entries is truncated to 1, allocating 1
array element. Userspace could submit a 4608-byte IO. The driver calculates
'length' up to 4608 and advances 'map_idx' to 1 for the remaining 512 bytes.
It reads 'dma_list[1]' (which is out-of-bounds) and uses it as 'prp2_dma',
potentially resulting in arbitrary physical DMA (read or write).

> +		goto done;
> +	}

[ ... ]

> +free_prps:
> +	iod->cmd.common.dptr.prp1 =3D cpu_to_le64(prp1_dma);
> +	iod->cmd.common.dptr.prp2 =3D cpu_to_le64(prp2_dma);
> +	nvme_free_descriptors(req);
> +	return BLK_STS_RESOURCE;

[Severity: High]
Does this code leave iod->nr_descriptors greater than 0 on the error path?

If dma_pool_alloc() fails in nvme_rq_setup_dmabuf_map(), it jumps to
'free_prps:', which calls nvme_free_descriptors() but leaves
'iod->nr_descriptors' unchanged. The block layer may requeue the failed
request.

If the queue is subsequently torn down, the cancellation path invokes
nvme_unmap_data() -> nvme_rq_clean_dmabuf_map(). Seeing the non-zero
'nr_descriptors', it calls nvme_free_descriptors() again, resulting in a
double free.

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
> +	map =3D kvmalloc_flex(*map, dma_list, nr_entries);
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
> +		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
> +		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +		while (sg_len) {
> +			map->dma_list[i++] =3D dma_addr;

[Severity: High]
Does this loop overflow dma_list[]?

'nr_entries' is computed via integer division of dmabuf->size. If the dmabuf
size is not page-aligned (e.g., 4097 bytes), nr_entries truncates down (to =
1).
However, exporters often pad sg_table allocations to full pages (e.g., 8192
bytes).

The loop unconditionally writes all sg_len chunks to 'dma_list', exceeding =
the
allocated 'nr_entries' capacity.

> +			dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +			sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +		}
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

[Severity: High]
Is it safe to free a kvmalloc_flex() allocation with kfree()?

If the dmabuf setup fails, the code jumps to the 'err' label and executes
kfree(map). Calling kfree() on memory allocated via vmalloc() causes undefi=
ned
behavior, typically a kernel panic.

> +	return ERR_PTR(ret);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790602223.gi=
t.asml.silence@gmail.com?part=3D6
