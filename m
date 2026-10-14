Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2544BCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817C410E98E;
	Wed, 14 Oct 2026 11:02:42 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2B410FCEB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:33 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1ad2e2391so12573555e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975752; x=1792580552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgD4ZRKr/dSiiTwqauwPBK2KpAxV+NZiR9fa1tWOdeA=;
 b=j4qRDgrJ10ddQm27hShNn/3wHrZWccMzhUg0fviR1XZym7qNJb9rrfH8AG3wYJnGFB
 hLmjnnXv8vqYa92yAxvWLF/52krIoxk6nRsgD08vLY943tEiya7TDDx2bLqARdJRPYF1
 1e+WW13cw7uFxCskNaB1GpCJOH/0MpUa7K5z2NXQUE4XqgbhwgrrVFPNiSejIRV17p2g
 3KLjKhapL2xX9eMMo9qKAKlQSYcZUNKC+xD4I5mZWT7Tp42ICN2jODFybUceaRmTwxZs
 G9Hc5SZAU0zLb/7brtpHeQ51o9x6BA3fibIfzNxm2xzVYv3zAFwyF11WvIcGyouKJznm
 wivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975752; x=1792580552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dgD4ZRKr/dSiiTwqauwPBK2KpAxV+NZiR9fa1tWOdeA=;
 b=YOg00znkjbeS9uGmtoMab+E+snqzZ32/IDc3BGjbcjKFH8CzHB8+FB8RAMhVRgdLmH
 dQ9bumKOwaykfyosh13y/zqJt4/8Brx6Fo2b3ijtDN0y+Ri20g4o/qTUhk28NDMnOl7L
 LZL1aJR9LESj0ATWOm0aAP2RqAZSTRlTKg83aHNnpz5FeFSGZnKTA7MZ2TKvCaqsC4B8
 2WXxGD1c5xCILJrq3ks/8FAYDoqNwgzZY8aGfBKadMrEMOhHI2oR+qylzKspswo6BB9U
 Rr/66PBF0uui0x0nQhoLY3L+FcJ1ztJCIvs7Dh3Kv9CSNPWDuclMXZXzD2+DdsN+U5ag
 u9qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvZgQMfebDd2EU3PaqD0Vqvdz8aPum5OMo9D3b/Rd0ixbrfDN8IOPqdmKhbR38nvR04MTsD54m+5A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+msSbq6aD1bmxJW1GxXe3IjEzfX8zbdH+dFooVp9G0ShyIhl+
 cXwE3bNA4AScoFnHiaeAhH02JeAhtN3fXBM4u+7+8yBIF1SGam0rdGBO
X-Gm-Gg: AYBFou0ZXSRPWCsyQBAH5HS8jEZ5J8lS/EY9UDYU00EFs8WzGGMD74UGbPrdO+50To5
 h7VNvaTfev9BHKLA8nTvjHYfNAJigGt07Ets7AUApNnfw6mnoGmqgfqKdsQaBZTrs8UAe9v1ZeM
 Iqyq/Juz3O7PFd9GO+42WBbpUQpk4Jhp1iYP6pvPvgFANqLQwHPrfqJajI3lnTMCwE53ipP49Sd
 Nx0+sP2duwatrLKzmXUg/v6sZy8JcvB0EOQkFbbRCLFNlKDfoIOBGLvU0ZbfWnjiRGBjgroPbkK
 oKYApH2Z6H80R2EMKZOg79xYxk0hBmYZdg/RlhXdHIdqGax7HLh0iEufZK+Ds3nnK7EckhbuSY5
 m7vyOHCps2Qq7s/5q/fe6qCkvHLRxZbuQlc/S8gVT1M8TvKSUF51d/bZfpnoVT+1v3gAj9iIb0j
 RoOz88vZcEDjxN9CQXcLVWXGRccIxueV2RURFUNvEUUTfonm1jg7fGg3AtteyzFIAN4oYxUjZGV
 nuONeBRTwx+muwMMlYZteNfYXhhLrZ6GYcYesGNFRa653yxKZAIJh6L50uen3Fmk//m7wiKmFPq
X-Received: by 2002:a05:600c:4e11:b0:4a1:7f41:b9dc with SMTP id
 5b1f17b1804b1-4a18e4d67famr306600635e9.23.1791975751569; 
 Wed, 14 Oct 2026 04:02:31 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:30 -0700 (PDT)
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
Subject: [PATCH v11 07/13] nvme-pci: implement dma-buf backed requests
Date: Wed, 14 Oct 2026 12:02:05 +0100
Message-ID: <9540e74b5d2dd1a5dc0d436bc0c2a6f5e18fc389.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
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
 drivers/nvme/host/Makefile     |   1 +
 drivers/nvme/host/core.c       |  12 +++
 drivers/nvme/host/nvme.h       |   2 +
 drivers/nvme/host/pci-dmabuf.c | 169 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/pci-dmabuf.h |  75 +++++++++++++++
 drivers/nvme/host/pci.c        |  93 ++++++++++++++++++
 6 files changed, 352 insertions(+)
 create mode 100644 drivers/nvme/host/pci-dmabuf.c
 create mode 100644 drivers/nvme/host/pci-dmabuf.h

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 67563a69f7dc..8288b986d713 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -21,6 +21,7 @@ nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 nvme-core-$(CONFIG_NVME_HOST_AUTH)	+= auth.o
 
 nvme-y					+= pci.o
+nvme-$(CONFIG_DMA_SHARED_BUFFER)	+= pci-dmabuf.o
 
 nvme-fabrics-y				+= fabrics.o
 
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
 
diff --git a/drivers/nvme/host/pci-dmabuf.c b/drivers/nvme/host/pci-dmabuf.c
new file mode 100644
index 000000000000..161e4ffa6919
--- /dev/null
+++ b/drivers/nvme/host/pci-dmabuf.c
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Code for supporting dma-buf I/O maps in the NVMe driver.
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+
+#include <linux/dma-resv.h>
+
+#include "pci-dmabuf.h"
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
+static void nvme_dma_buf_io_release(struct dma_buf_io_ctx *base_ctx)
+{
+	struct nvme_dma_buf_io_ctx *ctx = base_ctx->dev_priv;
+	struct nvme_dma_buf_list *buf_list = ctx->buf_list;
+
+	mutex_lock(&buf_list->lock);
+	if (!list_empty(&ctx->list)) {
+		dma_buf_detach(ctx->base->dmabuf, ctx->attach);
+		list_del_init(&ctx->list);
+	}
+	mutex_unlock(&buf_list->lock);
+
+	nvme_put_ctrl(ctx->ctrl);
+	kfree(ctx);
+}
+
+void __nvme_pci_remove_dmabuf(struct nvme_dma_buf_list *list)
+{
+	struct nvme_dma_buf_io_ctx *ctx, *tmp;
+
+	mutex_lock(&list->lock);
+	list->dead = true;
+	list_for_each_entry_safe(ctx, tmp, &list->ctxs, list) {
+		dma_buf_io_detach(ctx->base);
+		dma_buf_detach(ctx->base->dmabuf, ctx->attach);
+		list_del_init(&ctx->list);
+	}
+	mutex_unlock(&list->lock);
+}
+
+const struct dma_buf_io_ops nvme_dma_buf_io_ops = {
+	.map		= nvme_dma_buf_io_map,
+	.unmap		= nvme_dma_buf_io_unmap,
+	.release	= nvme_dma_buf_io_release,
+};
+
+static int nvme_init_io_ctx_locked(struct nvme_ctrl *ctrl,
+		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_dma_buf_io_ctx *nvme_ctx;
+	struct dma_buf_attachment *attach;
+
+	if (buf_list->dead)
+		return -ENODEV;
+
+	nvme_ctx = kzalloc_obj(*nvme_ctx);
+	if (!nvme_ctx)
+		return -ENOMEM;
+
+	attach = dma_buf_dynamic_attach(ctx->dmabuf, ctrl->dev,
+					&nvme_dmabuf_importer_ops, ctx);
+	if (IS_ERR(attach)) {
+		kfree(nvme_ctx);
+		return PTR_ERR(attach);
+	}
+
+	nvme_get_ctrl(ctrl);
+	list_add(&nvme_ctx->list, &buf_list->ctxs);
+	nvme_ctx->attach = attach;
+	nvme_ctx->base = ctx;
+	nvme_ctx->ctrl = ctrl;
+	nvme_ctx->buf_list = buf_list;
+	ctx->dev_priv = nvme_ctx;
+	ctx->dev_ops = &nvme_dma_buf_io_ops;
+	return 0;
+}
+
+int __nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_io_ctx *ctx)
+{
+	int ret;
+
+	mutex_lock(&buf_list->lock);
+	ret = nvme_init_io_ctx_locked(ctrl, buf_list, ctx);
+	mutex_unlock(&buf_list->lock);
+	return ret;
+}
diff --git a/drivers/nvme/host/pci-dmabuf.h b/drivers/nvme/host/pci-dmabuf.h
new file mode 100644
index 000000000000..b3c9fd485878
--- /dev/null
+++ b/drivers/nvme/host/pci-dmabuf.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+
+#ifndef _NVME_PCI_DMABUF_H
+#define _NVME_PCI_DMABUF_H
+
+#include <linux/dma-buf-io.h>
+
+#include "nvme.h"
+
+struct nvme_dma_buf_list {
+	struct list_head ctxs;
+	struct mutex lock;
+	bool dead;
+};
+
+struct nvme_dma_buf_io_ctx {
+	struct dma_buf_attachment *attach;
+	struct nvme_dma_buf_list *buf_list;
+	struct dma_buf_io_ctx *base;
+	struct nvme_ctrl *ctrl;
+	struct list_head list;
+};
+
+struct nvme_dmabuf_map {
+	struct dma_buf_io_map base;
+	struct sg_table *sgt;
+	unsigned nr_entries;
+	dma_addr_t dma_list[] __counted_by(nr_entries);
+};
+
+static inline struct nvme_dmabuf_map *to_nvme_dmabuf_map(
+	struct dma_buf_io_map *map)
+{
+	return container_of(map, struct nvme_dmabuf_map, base);
+}
+
+static inline struct nvme_dmabuf_map *nvme_req_to_map(struct request *req)
+{
+	struct dma_buf_io_map *map = req->bio->bi_dmabuf_map;
+
+	return to_nvme_dmabuf_map(map);
+}
+
+void __nvme_pci_remove_dmabuf(struct nvme_dma_buf_list *list);
+int __nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_io_ctx *ctx);
+
+static inline void nvme_pci_remove_dmabuf(struct nvme_dma_buf_list *list)
+{
+	if (IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		__nvme_pci_remove_dmabuf(list);
+}
+
+static inline int nvme_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct nvme_dma_buf_list *buf_list,
+		struct dma_buf_io_ctx *ctx)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+	return __nvme_init_dma_buf_io_ctx(ctrl, buf_list, ctx);
+}
+
+static inline void nvme_init_buf_list(struct nvme_dma_buf_list *buf_list)
+{
+	INIT_LIST_HEAD(&buf_list->ctxs);
+	mutex_init(&buf_list->lock);
+	buf_list->dead = false;
+}
+
+
+#endif /* _NVME_PCI_DMABUF_H */
\ No newline at end of file
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a65b77726e4b..a0506c93fa16 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -30,6 +30,7 @@
 
 #include "trace.h"
 #include "nvme.h"
+#include "pci-dmabuf.h"
 
 #define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
 #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
@@ -318,6 +319,7 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 	mempool_t *dmavec_mempool;
+	struct nvme_dma_buf_list dmabufs;
 
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
@@ -865,6 +867,76 @@ static void nvme_free_descriptors(struct request *req)
 	}
 }
 
+static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
+		struct nvme_queue *nvmeq)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dmabuf_map *map = nvme_req_to_map(req);
+	unsigned bvec_done = req->bio->bi_iter.bi_offset;
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
@@ -943,6 +1015,9 @@ static void nvme_unmap_data(struct request *req)
 	struct device *dma_dev = nvmeq->dev->dev;
 	unsigned int attrs = 0;
 
+	if (blk_mq_rq_is_dmabuf(req))
+		goto out_free_desc;
+
 	if (iod->flags & IOD_SINGLE_SEGMENT) {
 		static_assert(offsetof(union nvme_data_ptr, prp1) ==
 				offsetof(union nvme_data_ptr, sgl.addr));
@@ -967,6 +1042,7 @@ static void nvme_unmap_data(struct request *req)
 			nvme_free_prps(req, attrs);
 	}
 
+out_free_desc:
 	if (iod->nr_descriptors)
 		nvme_free_descriptors(req);
 }
@@ -1257,6 +1333,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	struct blk_dma_iter iter;
 	blk_status_t ret;
 
+	if (blk_mq_rq_is_dmabuf(req))
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
 	 * significantly improves performances for small I/O sizes.
@@ -3357,6 +3436,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_unquiesce_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
+
+	if (shutdown)
+		nvme_pci_remove_dmabuf(&dev->dmabufs);
 }
 
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
@@ -3564,6 +3646,14 @@ static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
+static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
+		struct dma_buf_io_ctx *ctx)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	return nvme_init_dma_buf_io_ctx(ctrl, &dev->dmabufs, ctx);
+}
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -3579,6 +3669,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.print_device_info	= nvme_pci_print_device_info,
 	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
 	.get_virt_boundary	= nvme_pci_get_virt_boundary,
+	.init_dma_buf_io_ctx	= nvme_pci_init_dma_buf_io_ctx,
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
@@ -3701,6 +3792,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
+	nvme_init_buf_list(&dev->dmabufs);
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
@@ -4346,5 +4438,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0");
 MODULE_DESCRIPTION("NVMe host PCIe transport driver");
+MODULE_IMPORT_NS("DMA_BUF");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
2.54.0

