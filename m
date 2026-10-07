Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B3CA6009
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E279410E4AB;
	Wed,  7 Oct 2026 01:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jjv9eTvy";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4D810E37B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so32918105e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336740; x=1791941540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VM4YauOJNuTZG75PQ0MDVsJf+tErKDy2SLufXh7QXpM=;
 b=Jjv9eTvy1mqNagyxcDB+Qb5XCC2aAFjRY3wPtnlmi4N9rdl1gpvE6WHN69RafKGE5h
 w1vhtcdYjbdqJVnY6Dxmh2d61jGWMUk5YC221HBtcYx8e/i71I3jTCCLWtmzUKD3GFzg
 TQLisEHehqQ+Sg6VK9y4QzeOCA5J4e7SX4fFMnXBLV4q3kQDU8TX+JfWpWmpiwbCl076
 BfiBh5QgvO8hXhooKuXSyTgIPwekBPhdmkdbe+HzlDcgresKmTiVzSF3q/Da0rR0olFO
 OdtHdmzFgO/tOzyDCk5Bh4hX2QrN2WhOPfb9w0DkU9Ehz+rmwFZDwBzkmfLjvamDgakd
 705Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336740; x=1791941540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VM4YauOJNuTZG75PQ0MDVsJf+tErKDy2SLufXh7QXpM=;
 b=u6IkNehUg6yn43MPRknB/OgbcMvKV9ZaJLpJeIaHrm3/91V/CBBQ5ncHC+CISqyh5u
 wGrqQdU98hm7IQxuvXUw9dyvCxYG0SY0YyfxnCk1uPBhgl9hq4QHXOGMKPIlFR+4Lhkk
 p6ouSorImyIDN2vrF9GHTJluzQvF41MXQv2LmxFftp2m3CCRHCuzPAVMaHkVTeMsSFFp
 kw/ir0ZRQD1FwaB+dhxWQn27gVaiCnA7KbMgh1p1+xcdwEhszCw105IY4SU3JaKcx3YZ
 HBFLO8E6QAZVJRuCzAlWDIkKfVLAOfK/pa6kL5SEReS9lkqjUg/WpBjLz2Tb/ASMVTfh
 c5BQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6pY8J5rd3nodEbRsYqAo46rK9a1sUYNAIWXk62i34jzK2LWpEP4y/yHyNLihR2ijo/8zb0ebDp4Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkJduJmjX0bBNvgf+hiVtwKWJr1dnAaV2AsshYG0NDINwZDA7D
 BNyBRl7mdsU6Y/AsbwgVNkMozK6K3vVxOy0A3hFf+Md1Zo8HXQl4wnQj
X-Gm-Gg: AYBFou1wLgRr968twgyA/yr3dgkqiLMshF593K1+1PbiBuunVKOA4ngENZRC7Li1e+V
 41gCTtu6UyD9GfMrrS80tJMPo53BEuJNCb1NN7kIHaUTPLQd92K0S+X03C/fk4LHkwFcHxNKlcf
 EiZgsTEkXutWW80IAg7SaZoPnAxghQxz7H3KZVlBKxYAbpUthrW46LGlrWy/f97rSiebn6x4q09
 yuL7U44j2U4DuWam2gjmyFv6623eErqzB4pR6bxjH6Fdve5386hLnzOA2TtHFwtKsKSqf65mKBu
 z0JnpqyWFl/Bn4DM/d7BALvhu/VchSxh00WWnKKkJAQ+Efh1YwQFgc8SM3P7aDqmQCbOSLKpmGe
 LthXI8RdxM2MaP4s6U4SZFX1+sF8GTi4rPCl8Y9MNSAHJO3JNjR33OC0K14Hewql/45d7cPKOgv
 7zLNLCV4Hzte366IDRGrcto8RmBUUHzaiad3ZvrjGLtJfCLMyfITVPPNP0YdV32xvinpBVDkxQB
 wDYVQcqbAxFEy+isXeDSRGltZexdUx6Loq13VF/O5vATy6i/L1FXhAADb8yaliMwpr1wm2nDT7f
X-Received: by 2002:a05:600c:8b64:b0:4a1:6dc3:f5e2 with SMTP id
 5b1f17b1804b1-4a180650499mr7604605e9.33.1791336740292; 
 Tue, 06 Oct 2026 18:32:20 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:19 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v8 05/13] nvme-pci: implement dma-buf backed requests
Date: Wed,  7 Oct 2026 02:31:48 +0100
Message-ID: <8b348c071c53ef88cb278522e7526870f4932690.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Enable BIO_DMABUF_MAP backed requests. On registration we map the
dma-buf and store it as a prp list, which is then used to initialise
requests. All attached contexts are stored in a new list dmabuf_ctxs,
and additions/removals are synchronised with dmabuf_lock.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/core.c |  12 ++
 drivers/nvme/host/nvme.h |   2 +
 drivers/nvme/host/pci.c  | 305 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7eb0f9fe6b18..2f9b2262f77c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2708,6 +2708,17 @@ static int nvme_report_zones(struct gendisk *disk, sector_t sector,
 #define nvme_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (!ctrl->ops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
+}
+
 const struct block_device_operations nvme_bdev_ops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
@@ -2718,6 +2729,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.get_unique_id	= nvme_get_unique_id,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
+	.init_dma_buf_io_ctx = nvme_init_dma_buf_io_ctx,
 };
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a643c4723a69..be32e9a5ca5a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -668,6 +668,8 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
+				   struct dma_buf_io_ctx *ctx);
 	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
 };
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a65b77726e4b..68e0d4dcade4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
+#include <linux/dma-buf-io.h>
+#include <linux/dma-resv.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -318,6 +320,8 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 	mempool_t *dmavec_mempool;
+	struct list_head dmabuf_ctxs;
+	struct mutex dmabuf_lock;
 
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -397,6 +401,13 @@ struct nvme_queue {
 	struct completion delete_done;
 };
 
+struct nvme_dmabuf_map {
+	struct dma_buf_io_map base;
+	struct sg_table *sgt;
+	unsigned nr_entries;
+	dma_addr_t dma_list[] __counted_by(nr_entries);
+};
+
 /* bits for iod->flags */
 enum nvme_iod_flags {
 	/* this command has been aborted by the timeout handler */
@@ -865,6 +876,114 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static inline struct nvme_dmabuf_map *
+to_nvme_dmabuf_map(struct dma_buf_io_map *map)
+{
+	return container_of(map, struct nvme_dmabuf_map, base);
+}
+
+static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
+		struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+
+	dma_sync_sgtable_for_cpu(nvme_dev->dev, map->sgt, rq_dma_dir(req));
+}
+
+static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
+		struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+
+	dma_sync_sgtable_for_device(nvme_dev->dev, map->sgt, rq_dma_dir(req));
+}
+
+static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
+		struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	nvme_dmabuf_map_sync_for_cpu(dev, req);
+
+	if (iod->nr_descriptors)
+		nvme_free_descriptors(req);
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
+		struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	unsigned bvec_done = bio->bi_iter.bi_offset;
+	unsigned map_idx = bvec_done / NVME_CTRL_PAGE_SIZE;
+	unsigned offset = bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
+	int length = blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE - offset);
+	dma_addr_t *dma_list = map->dma_list;
+	u64 prp1_dma = dma_list[map_idx++] + offset;
+	u64 dma_addr, prp2_dma;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	unsigned i;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
+	if (length <= 0) {
+		prp2_dma = 0;
+		goto done;
+	}
+
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		prp2_dma = dma_list[map_idx];
+		goto done;
+	}
+
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
+		return BLK_STS_RESOURCE;
+
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
+	prp2_dma = prp_dma;
+	i = 0;
+	for (;;) {
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			__le64 *old_prp_list = prp_list;
+
+			prp_list = dma_pool_alloc(nvmeq->descriptor_pools.large,
+					GFP_ATOMIC, &prp_dma);
+			if (!prp_list)
+				goto free_prps;
+			iod->descriptors[iod->nr_descriptors++] = prp_list;
+			prp_list[0] = old_prp_list[i - 1];
+			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			i = 1;
+		}
+
+		dma_addr = dma_list[map_idx++];
+		prp_list[i++] = cpu_to_le64(dma_addr);
+
+		length -= NVME_CTRL_PAGE_SIZE;
+		if (length <= 0)
+			break;
+	}
+done:
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
+	return BLK_STS_OK;
+free_prps:
+	iod->cmd.common.dptr.prp1 = cpu_to_le64(prp1_dma);
+	iod->cmd.common.dptr.prp2 = cpu_to_le64(prp2_dma);
+	nvme_free_descriptors(req);
+	return BLK_STS_RESOURCE;
+}
+
 static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -943,6 +1062,11 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (blk_mq_rq_is_dmabuf(req)) {
+		nvme_rq_clean_dmabuf_map(nvmeq->dev, req);
+		return;
+	}
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -1257,6 +1381,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
+	if (blk_mq_rq_is_dmabuf(req))
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
 	 * significantly improves performances for small I/O sizes.
@@ -2284,6 +2411,175 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	return result;
 }
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
+
+struct nvme_dma_buf_io_ctx {
+	struct dma_buf_attachment *attach;
+	struct dma_buf_io_ctx *ctx;
+	struct nvme_dev *dev;
+	struct list_head list;
+};
+
+static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *attach)
+{
+	struct dma_buf_io_ctx *ctx = attach->importer_priv;
+
+	dma_buf_io_invalidate_mappings(ctx);
+}
+
+static const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
+	.invalidate_mappings	= nvme_dmabuf_invalidate_mappings,
+	.allow_peer2peer	= true,
+};
+
+static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
+{
+	unsigned nr_entries = ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
+	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
+	struct dma_buf_attachment *attach = nvme_ctx->attach;
+	unsigned long tmp, i = 0;
+	struct nvme_dmabuf_map *map;
+	struct scatterlist *sg;
+	struct sg_table *sgt;
+	int ret;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	if (ctx->dmabuf->size % NVME_CTRL_PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+
+	map = kvmalloc_flex(*map, dma_list, nr_entries);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+	map->nr_entries = nr_entries;
+
+	sgt = dma_buf_map_attachment(attach, ctx->dir);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		sgt = NULL;
+		goto err;
+	}
+
+	for_each_sgtable_dma_sg(sgt, sg, tmp) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		unsigned long sg_len = sg_dma_len(sg);
+
+		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
+		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
+			ret = -EINVAL;
+			goto err;
+		}
+		while (sg_len) {
+			map->dma_list[i++] = dma_addr;
+			dma_addr += NVME_CTRL_PAGE_SIZE;
+			sg_len -= NVME_CTRL_PAGE_SIZE;
+		}
+	}
+
+	ret = dma_buf_io_init_map(ctx, &map->base, sgt);
+	if (ret)
+		goto err;
+	map->sgt = sgt;
+	return &map->base;
+err:
+	if (sgt)
+		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
+	kvfree(map);
+	return ERR_PTR(ret);
+}
+
+static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
+		struct dma_buf_io_map *map_base)
+{
+	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(map_base);
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	dma_buf_unmap_attachment(nvme_ctx->attach, map->sgt, ctx->dir);
+	kvfree(map);
+}
+
+static void nvme_dma_buf_io_release(struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
+	struct nvme_dev *dev = nvme_ctx->dev;
+
+	mutex_lock(&dev->dmabuf_lock);
+	if (!list_empty(&nvme_ctx->list)) {
+		dma_buf_detach(ctx->dmabuf, nvme_ctx->attach);
+		list_del_init(&nvme_ctx->list);
+	}
+	mutex_unlock(&dev->dmabuf_lock);
+
+	nvme_put_ctrl(&dev->ctrl);
+	kfree(nvme_ctx);
+}
+
+const struct dma_buf_io_ops nvme_dma_buf_io_ops = {
+	.map		= nvme_dma_buf_io_map,
+	.unmap		= nvme_dma_buf_io_unmap,
+	.release	= nvme_dma_buf_io_release,
+};
+
+static int __nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	struct nvme_dma_buf_io_ctx *nvme_ctx;
+	struct dma_buf_attachment *attach;
+
+	nvme_ctx = kzalloc_obj(*nvme_ctx);
+	if (!nvme_ctx)
+		return -ENOMEM;
+
+	attach = dma_buf_dynamic_attach(ctx->dmabuf, dev->dev,
+					&nvme_dmabuf_importer_ops, ctx);
+	if (IS_ERR(attach)) {
+		kfree(nvme_ctx);
+		return PTR_ERR(attach);
+	}
+
+	nvme_get_ctrl(ctrl);
+	list_add(&nvme_ctx->list, &dev->dmabuf_ctxs);
+	nvme_ctx->attach = attach;
+	nvme_ctx->ctx = ctx;
+	nvme_ctx->dev = dev;
+	ctx->dev_priv = nvme_ctx;
+	ctx->dev_ops = &nvme_dma_buf_io_ops;
+	return 0;
+}
+
+static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	int ret;
+
+	mutex_lock(&dev->dmabuf_lock);
+	ret = __nvme_pci_init_dma_buf_io_ctx(ctrl, ctx);
+	mutex_unlock(&dev->dmabuf_lock);
+	return ret;
+}
+
+static void nvme_pci_remove_dmabuf(struct nvme_dev *dev)
+{
+	struct nvme_dma_buf_io_ctx *ctx, *tmp;
+
+	mutex_lock(&dev->dmabuf_lock);
+	list_for_each_entry_safe(ctx, tmp, &dev->dmabuf_ctxs, list) {
+		dma_buf_io_detach(ctx->ctx);
+		dma_buf_detach(ctx->ctx->dmabuf, ctx->attach);
+		list_del_init(&ctx->list);
+	}
+	mutex_unlock(&dev->dmabuf_lock);
+}
+#else
+static void nvme_pci_remove_dmabuf(struct nvme_dev *dev)
+{
+}
+#endif
+
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
@@ -3357,6 +3653,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_unquiesce_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
+
+	if (shutdown)
+		nvme_pci_remove_dmabuf(dev);
 }
 
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
@@ -3579,6 +3878,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.print_device_info	= nvme_pci_print_device_info,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
 	.get_virt_boundary	= nvme_pci_get_virt_boundary,
+#ifdef CONFIG_DMA_SHARED_BUFFER
+	.init_dma_buf_io_ctx	= nvme_pci_init_dma_buf_io_ctx,
+#endif
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -3701,6 +4003,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
+	INIT_LIST_HEAD(&dev->dmabuf_ctxs);
+	mutex_init(&dev->dmabuf_lock);
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
@@ -4346,5 +4650,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("NVMe host PCIe transport driver");
+MODULE_IMPORT_NS("DMA_BUF");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
2.54.0

