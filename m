Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C7ACD13D2
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2382F10F087;
	Wed, 29 Apr 2026 15:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDZKbOa8";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBB310F074
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:56 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so8567425f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476415; x=1778081215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tNLlPR5H1MSAY4d3fHMpPecWT4SmT3leRzkE1JmSrg=;
 b=QDZKbOa829qSeIpzN9/b+mHd+dF7rpv+Z4gM6/vKPNRzwKn7m72J9Vm/OgwCrUt4Ue
 zVondTgM+kPTM9FIylT01g88LYtV/PXSLYzZUEo6cnCLls2pxpHZ1M3mILAXtsRtLOMW
 iHcOIKfE5IFEqzkZEOz/qLMtBIHKBUkO7p0t2Pu3fj39LRaLdGsOPBN3anSed9owRcfB
 Io4NGCbgW4N2DKBqUSi1mIPGYhIFQWJ5CJYjl6qZI6exyJiXTMJveQlGYxMuuEbBqthL
 7eGX+emaiU4kSk/7sncXmGHjG13ykUG8G6nUZ7HIA+od8K9KCEHtY6gUcG1nSb9SoXDn
 c6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476415; x=1778081215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5tNLlPR5H1MSAY4d3fHMpPecWT4SmT3leRzkE1JmSrg=;
 b=dujmh3I3myL9cWgi1BFTI+2JPrS14HQyGj70d1nJPS6hngOOR9mBwB9rh7xysnADgo
 8rIuVGzQ9Mu0lUoUHepfSueURb9c8Y+DGxKyvJWSBK3VhYlIsTQVXnD3nVDVFzxccZOq
 vJLbATH/3rfKztJeMwhOmZx8FegWE/lKilLauxpW4dMdfQM02ruOIvC7IHiWHAalKFZC
 qqalCrXx8NFZ4vcnmXBbdbvEwX3SVJUsiFFaA/tstkEtnnEB7lecw8E2mZQH47r4kk8/
 3XcEJtCa1c1pL4qq1QNds5lvikB1pP8BWk8aUbAtOohJdJOmpLspaBGIyETx4EXEssrl
 cvRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hkbtGRw4N/Vr9Z9l8XKz8qnSXidI6T8AdfeZ4Zveqtxly84zPVE1noGkZaDJEm3dR3CDWc46y3SI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJmxc96uQTTz6gf7JXHNa92a0c65PLiOpKXe+Q9wibAeM1sQ8o
 cWEQW9PC+kw6Ez1MZ+4z5PxinJdI6Vni3aKjLtzfjFhAeNDedKCqHk5/YyFHmSAq
X-Gm-Gg: AeBDiesTHaiinp4mN6um/Lb7svhfOsU54XfvNJXjU0G0v+cAIdYYaxOPAPAOe9Ybgrx
 4jhM9nH9LLBv6Zgb//m/qX5V1+feyfuVW6h0FM7XqVEzD+qj/53wh885YHCRJC4dGklyCiqS2e1
 KXlzMoIIOr+S2itrwwYGdXX6E6+9QcdYqG8d1V9gmwkMMS8fZRDheML3Cxu46Rxf9aZJs0hoXyo
 tUgvtA8XwxsY8MS+2T9nQ+op5SVN7wwNv52r2H0/g3/puxMDNzfbEC7LBc7/Yn9CRuS7/uBpPhi
 YV1tkEkhmNVyRCiGc22o4ToMBclQkyS1j2JiLZBx4i3eI2lGkaWJsNEtavajJZnOJL/CB5trrT8
 MP87VEEb6bfQUo9e8Y6RKXLY9HLeTGZwv5W9+eB9+1Y2FXWPzeFZb35hCL3xuh51rTYJHw6VffR
 XFXZ8uqv+ckwD+DlIoOQQT/ZFdOfAerV2YSHgro9Pm1ME6TGzqrC7KlYOw07wENKCS7/1VUQTCw
 UeSYI9L9hj6IBIhAiwaG2KePVQpY+lNgHhNNC5/mFZH
X-Received: by 2002:a05:6000:601:b0:43f:e22d:9a73 with SMTP id
 ffacd0b85a97d-44647808b94mr14223288f8f.2.1777476415006; 
 Wed, 29 Apr 2026 08:26:55 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
Date: Wed, 29 Apr 2026 16:25:53 +0100
Message-ID: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
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

Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
dmabuf when it's mapped, which is then used to initialise requests.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 282 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf6627..d2629853a972 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -27,6 +27,8 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
+#include <linux/io_dmabuf_token.h>
+#include <linux/dma-resv.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -393,6 +395,17 @@ struct nvme_queue {
 	struct completion delete_done;
 };
 
+struct nvme_dmabuf_token {
+	struct dma_buf_attachment *attach;
+};
+
+struct nvme_dmabuf_map {
+	struct io_dmabuf_map base;
+	dma_addr_t *dma_list;
+	struct sg_table *sgt;
+	unsigned nr_entries;
+};
+
 /* bits for iod->flags */
 enum nvme_iod_flags {
 	/* this command has been aborted by the timeout handler */
@@ -854,6 +867,134 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static void nvme_dmabuf_map_sync(struct nvme_dev *nvme_dev, struct request *req,
+				 bool for_cpu)
+{
+	int length = blk_rq_payload_bytes(req);
+	struct device *dev = nvme_dev->dev;
+	enum dma_data_direction dma_dir;
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map;
+	dma_addr_t *dma_list;
+	int offset, map_idx;
+
+	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
+	dma_list = map->dma_list;
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	length += offset & (NVME_CTRL_PAGE_SIZE - 1);
+
+	while (length > 0) {
+		u64 dma_addr = dma_list[map_idx++];
+
+		if (for_cpu)
+			__dma_sync_single_for_cpu(dev, dma_addr,
+						  NVME_CTRL_PAGE_SIZE, dma_dir);
+		else
+			__dma_sync_single_for_device(dev, dma_addr,
+						     NVME_CTRL_PAGE_SIZE,
+						     dma_dir);
+		length -= NVME_CTRL_PAGE_SIZE;
+	}
+}
+
+static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
+				      struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	nvme_dmabuf_map_sync(dev, req, true);
+
+	if (!(iod->flags & IOD_SINGLE_SEGMENT))
+		nvme_free_descriptors(req);
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
+					     struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int length = blk_rq_payload_bytes(req);
+	u64 dma_addr, prp1_dma, prp2_dma;
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map;
+	dma_addr_t *dma_list;
+	dma_addr_t prp_dma;
+	__le64 *prp_list;
+	int i, map_idx;
+	int offset;
+
+	nvme_dmabuf_map_sync(nvmeq->dev, req, false);
+
+	map = container_of(bio->dmabuf_map, struct nvme_dmabuf_map, base);
+	dma_list = map->dma_list;
+
+	offset = bio->bi_iter.bi_bvec_done;
+	map_idx = offset / NVME_CTRL_PAGE_SIZE;
+	offset &= (NVME_CTRL_PAGE_SIZE - 1);
+	prp1_dma = dma_list[map_idx++] + offset;
+
+	length -= (NVME_CTRL_PAGE_SIZE - offset);
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
+	nvme_free_descriptors(req);
+	return BLK_STS_RESOURCE;
+}
+
+static inline bool nvme_rq_is_dmabuf_attached(struct request *req)
+{
+	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
+		return false;
+	return req->bio && bio_flagged(req->bio, BIO_DMABUF_MAP);
+}
+
 static void nvme_free_prps(struct request *req, unsigned int attrs)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -932,6 +1073,11 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (nvme_rq_is_dmabuf_attached(req)) {
+		nvme_rq_clean_dmabuf_map(nvmeq->dev, req);
+		return;
+	}
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -1222,6 +1368,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
+	if (nvme_rq_is_dmabuf_attached(req))
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
 	 * significantly improves performances for small I/O sizes.
@@ -2238,6 +2387,134 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	return result;
 }
 
+#ifdef CONFIG_DMABUF_TOKEN
+static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *attach)
+{
+	struct io_dmabuf_token *token = attach->importer_priv;
+
+	io_dmabuf_token_invalidate_mappings(token);
+}
+
+const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
+	.invalidate_mappings	= nvme_dmabuf_invalidate_mappings,
+	.allow_peer2peer	= true,
+};
+
+static struct io_dmabuf_map *nvme_dmabuf_token_map(struct io_dmabuf_token *token)
+{
+	struct nvme_dmabuf_token *data = token->dev_priv;
+	struct dma_buf_attachment *attach = data->attach;
+	dma_addr_t *dma_list = NULL;
+	unsigned long tmp, i = 0;
+	struct nvme_dmabuf_map *map;
+	struct scatterlist *sg;
+	struct sg_table *sgt;
+	unsigned nr_entries;
+	int ret;
+
+	dma_resv_assert_held(token->dmabuf->resv);
+
+	map = kmalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	nr_entries = token->dmabuf->size / NVME_CTRL_PAGE_SIZE;
+	dma_list = kmalloc_array(nr_entries, sizeof(dma_list[0]), GFP_KERNEL);
+	if (!dma_list) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	sgt = dma_buf_map_attachment(attach, token->dir);
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
+		if (sg_len % NVME_CTRL_PAGE_SIZE) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		while (sg_len) {
+			dma_list[i++] = dma_addr;
+			dma_addr += NVME_CTRL_PAGE_SIZE;
+			sg_len -= NVME_CTRL_PAGE_SIZE;
+		}
+	}
+
+	ret = io_dmabuf_init_map(token, &map->base);
+	if (ret)
+		goto err;
+	map->nr_entries = nr_entries;
+	map->dma_list = dma_list;
+	map->sgt = sgt;
+	return &map->base;
+err:
+	if (sgt)
+		dma_buf_unmap_attachment(attach, sgt, token->dir);
+	kfree(map);
+	kfree(dma_list);
+	return ERR_PTR(ret);
+}
+
+static void nvme_dmabuf_token_unmap(struct io_dmabuf_token *token,
+				 struct io_dmabuf_map *map_base)
+{
+	struct nvme_dmabuf_token *data = token->dev_priv;
+	struct nvme_dmabuf_map *map = container_of(map_base,
+						struct nvme_dmabuf_map, base);
+
+	dma_resv_assert_held(token->dmabuf->resv);
+
+	dma_buf_unmap_attachment(data->attach, map->sgt, token->dir);
+	kfree(map->dma_list);
+}
+
+static void nvme_dmabuf_token_release(struct io_dmabuf_token *token)
+{
+	struct nvme_dmabuf_token *data = token->dev_priv;
+
+	dma_buf_detach(token->dmabuf, data->attach);
+	kfree(data);
+}
+
+const struct io_dmabuf_token_dev_ops nvme_dma_token_ops = {
+	.map		= nvme_dmabuf_token_map,
+	.unmap		= nvme_dmabuf_token_unmap,
+	.release	= nvme_dmabuf_token_release,
+};
+
+static int nvme_create_dmabuf_token(struct request_queue *q,
+				 struct io_dmabuf_token *token)
+{
+	struct nvme_dmabuf_token *data;
+	struct dma_buf_attachment *attach;
+	struct nvme_ns *ns = q->queuedata;
+	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
+	struct dma_buf *dmabuf = token->dmabuf;
+
+	data = kzalloc(sizeof(data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	token->dev_priv = data;
+	token->dev_ops = &nvme_dma_token_ops;
+
+	attach = dma_buf_dynamic_attach(dmabuf, dev->dev,
+					&nvme_dmabuf_importer_ops, token);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+	data->attach = attach;
+	return 0;
+}
+#endif
+
 static const struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_pci_complete_rq,
@@ -2256,6 +2533,10 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
+
+#ifdef CONFIG_DMABUF_TOKEN
+	.create_dmabuf_token = nvme_create_dmabuf_token,
+#endif
 };
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -4289,5 +4570,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("NVMe host PCIe transport driver");
+MODULE_IMPORT_NS("DMA_BUF");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
2.53.0

