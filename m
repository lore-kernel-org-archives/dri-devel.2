Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7821CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4221110EA7A;
	Mon, 28 Sep 2026 13:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KMoASj9b";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBA610EA42
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:32:47 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-488615e6cfcso2031729f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602366; x=1791207166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=huu8rtooY5bex1ADru0xT42aS1Jtedee7w+CWw922aM=;
 b=KMoASj9bSsL9hj0B7Fc2IAIKlNtJBGo3Pdl5xCEFtoWFck8IIEXcBzrjezp8vmXoZU
 o2kR68faeIIDbHPBnzOmWCqAg0qRzQT09gDIKM05siHLtQO0+YdNHIPzOWCUvPDIpJPN
 eoahghOYo78c/i52D94QlbAyI8inEZORQEgv76p8pZmEWpkLHLFUumEZRP49RKR/h6OG
 q8MRgpl1nZbqSTWouYNviamgkp/n2L1YAZOaceA/sYQb/iDfBoXUyZJ6No1hMFyIPBsu
 AO5e6mS6YEy53GmYO9iUsAqNxjLPHbTGlAOvt2HHrzv1EPKY3hQTNG5oJoyRw+klfSqb
 cbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602366; x=1791207166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=huu8rtooY5bex1ADru0xT42aS1Jtedee7w+CWw922aM=;
 b=nK4lMsKcH6sZAmHfa2Hcid/S+6JxzKAeOI9ZvfY74B6H4CFH+WkiGVP6Wr5fJdiMyw
 JHY6khiKIjnXLikLdv1GCthJWNcPVTrtsqin2YaG9FW41xdi/CLb17nkzNSa2YGmsPk/
 4lMShXFD1Q7sWHUs+/35vA7VEb7tQhiK99QcVvcWACOtkPPCAAyaYAIV+ObyZ9hte1wI
 1gSD+3adCGkCBHV8HO+5eGchXzjsWG/9eSz0xLFLf55pD95ZFsCsax9HAQlF4JpwzD5V
 cxVId2Dvlz7TtT6W/aSRKNP4aX3mNRrz9ysZz85jw3LdRNzLAuU4kvniEBPuTMBrggAo
 HuaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2T2jOHJGHuP+Rf0/Flc72HXzZzNW6wHX/9lXdoI7Uk/E+qnhLwZGs8IMQvMtsfaH9WGyHv4h56Ds=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8NAtP8WkRkYYKQuheq2xDp7L5uGu9BL5ihPcwg+k5+E7PAedx
 COHVBFxXcZRFbrWOJMRzPO3OQidUOoGFiC2rOidRc0uUsjpctwjV5o5N
X-Gm-Gg: AYBFou2KSNJAMzKDCVt1+VwL7SoGHRbIroyVz2IkPtR39pzwqtxIOT4yQ5SUEsj3J7B
 UsqMgOpdctPo5h8Y+YJgCZBgtOd4/mtjocaCVI8yilx6VJ3IkZPvrdmhpYs9ARQ+ixyoOLBJbk0
 12GKwIEtGQCqGxe9X+KpORnf3lV6Si9zJ+10Tz+AdJf1blmJTVlcd55a4QJwUHdeqtcf2DEDAxC
 vudahjBjFWgVLjMYGu+5Rm8yMu2v553djZoCzLGM/wpDLGFmXYmV8JJwozcW/4wqOGobeUa+qu9
 8BOnVbV1MCuumgrap2CsRNvbqRSZNXsLND9VbcPiDDB+kZbBirUwaXvMgjjOgG+VczQC/4El6Sj
 5ReGpS4bMQELccqZXSAFEPGX/pKzHWRJu8JElMCBNNIjHauoVAC8dPmu8WjhwqH9MVwt3wuJUvp
 +bBwQS85t9YGA94cd47wXUVws4G8X2MD3xLpurFFlKzvyszX12kudzEQjn8Ai+h9kOs22bOFqqx
 F0APYmDsbozdMRgXTsdjmcD+9uZ2W/7rpJtjlQaAwsgBh/s6D6bms4D1Y/2r/aqIBD+izlwiQVy
X-Received: by 2002:a05:6000:2406:b0:488:868a:1b88 with SMTP id
 ffacd0b85a97d-488868a1bd3mr13642177f8f.5.1790602365500; 
 Mon, 28 Sep 2026 06:32:45 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:32:44 -0700 (PDT)
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
 Phil Cayton <phil.cayton@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v7 01/13] dma-buf: introduce initial file I/O infrastructure
Date: Mon, 28 Sep 2026 14:32:17 +0100
Message-ID: <c33046bbadce5a2f14aa1874270ec2d10def58ef.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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

The goal is to be able to natively use dma-buf in the read-write / IO
path. This patch adds basic building blocks serving as a glue and API
between drivers and upper layer subsystems providing the uAPI. Later
patches implement it for NVMe raw block devices and expose it to the
user space via io_uring.

There are two main objects. struct dma_buf_io_ctx and struct
dma_buf_io_map. The ctx is used during initial registration and serves
as an interface between the upper layer user like io_uring and to the
importer subsystem / driver. The map represents the actual dma map
established for the target device[s] with dma_buf_map_attachment() and
stored in a device specific format. The context is created via a new
file operation ->init_dma_buf_io_ctx.

The ctx-map separation exists to support map invalidation (see
dma_buf_io_invalidate_mappings()). A ctx can create
multiple maps during its lifetime, but there can only be no more than
one (active) map attached to it. Invalidation drops the active map
if present, and the next map will only be attempted to be created
once there is a new request that wants to use the dma-buf IO ctx.

The primary task of the dma_buf_io_map object is to count requests
using it and to wait for their completion when we want to destroy the
DMA map.

[un]mapping and any work with dma addresses is delegated to the
importer driver via an ops table stored in the ctx, see struct
dma_buf_io_ops. Only the target driver / subsystem knows about devices
it wants to use the dma-buf with, especially in case of multi-device
filesystems or stacking in the future.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/Makefile     |   2 +-
 drivers/dma-buf/dma-buf-io.c | 230 +++++++++++++++++++++++++++++++++++
 include/linux/dma-buf-io.h   | 117 ++++++++++++++++++
 include/linux/fs.h           |   2 +
 4 files changed, 350 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma-buf/dma-buf-io.c
 create mode 100644 include/linux/dma-buf-io.h

diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index b25d7550bacf..523731b0f83e 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o dma-fence-chain.o \
-	 dma-fence-unwrap.o dma-resv.o dma-buf-mapping.o
+	 dma-fence-unwrap.o dma-resv.o dma-buf-mapping.o dma-buf-io.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
 obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
new file mode 100644
index 000000000000..420379a8db81
--- /dev/null
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -0,0 +1,230 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common infrastructure for supporing dma-buf in the I/O path.
+ *
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+#include <linux/dma-buf-io.h>
+#include <linux/dma-resv.h>
+
+static void dma_buf_io_put_ctx(struct dma_buf_io_ctx *ctx)
+{
+	might_sleep();
+
+	if (!refcount_dec_and_test(&ctx->refs))
+		return;
+	if (WARN_ON_ONCE(rcu_dereference_protected(ctx->map, true)))
+		return;
+
+	ctx->dev_ops->release(ctx);
+
+	dma_buf_put(ctx->dmabuf);
+	mutex_destroy(&ctx->map_mutex);
+	mutex_destroy(&ctx->map_create_mutex);
+	kfree(ctx);
+}
+
+static void dma_buf_io_map_release_work(struct work_struct *work)
+{
+	struct dma_buf_io_map *map = container_of(work, struct dma_buf_io_map,
+						  release_work);
+	struct dma_buf_io_ctx *ctx = map->ctx;
+	struct dma_buf *dmabuf = ctx->dmabuf;
+
+	percpu_ref_exit(&map->refs);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	ctx->dev_ops->unmap(ctx, map);
+	dma_resv_unlock(dmabuf->resv);
+
+	atomic_dec(&ctx->all_maps);
+	wake_up(&ctx->maps_wq);
+	dma_buf_io_put_ctx(ctx);
+}
+
+static void dma_buf_io_map_release_rcu(struct rcu_head *rcu)
+{
+	struct dma_buf_io_map *map = container_of(rcu, struct dma_buf_io_map, rcu);
+
+	INIT_WORK(&map->release_work, dma_buf_io_map_release_work);
+	queue_work(system_percpu_wq, &map->release_work);
+}
+
+static void dma_buf_io_map_refs_release(struct percpu_ref *ref)
+{
+	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
+	struct dma_buf_io_ctx *ctx = map->ctx;
+
+	/* There are no more requests using the map. */
+	atomic_dec(&ctx->active_maps);
+	wake_up(&ctx->maps_wq);
+	/* The map might still be visible via ctx->map */
+	call_rcu(&map->rcu, dma_buf_io_map_release_rcu);
+}
+
+static void dma_buf_io_wait_active_maps(struct dma_buf_io_ctx *ctx)
+{
+	wait_event(ctx->maps_wq, atomic_read(&ctx->active_maps) == 0);
+}
+
+static void dma_buf_io_wait_maps(struct dma_buf_io_ctx *ctx)
+{
+	wait_event(ctx->maps_wq, atomic_read(&ctx->all_maps) == 0);
+}
+
+int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
+			struct sg_table *sgt)
+{
+	unsigned seg_shift = ~0U;
+	struct scatterlist *sg;
+	unsigned long tmp;
+	int ret;
+
+	for_each_sgtable_dma_sg(sgt, sg, tmp)
+		seg_shift = min(seg_shift, __ffs(sg_dma_len(sg)));
+
+	ret = percpu_ref_init(&map->refs, dma_buf_io_map_refs_release, 0,
+			      GFP_KERNEL);
+	if (ret)
+		return ret;
+	map->min_seg_shift = seg_shift;
+	map->ctx = ctx;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_init_map, "DMA_BUF");
+
+struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf *dmabuf = ctx->dmabuf;
+	struct dma_buf_io_map *map;
+	long ret;
+
+	guard(mutex)(&ctx->map_create_mutex);
+
+	scoped_guard(mutex, &ctx->map_mutex) {
+		if (ctx->maps_killed)
+			return ERR_PTR(-ENOENT);
+		/* recheck under the lock in case it has already been re-created */
+		map = __dma_buf_io_get_map(ctx);
+		if (map)
+			return map;
+	}
+
+	dma_buf_io_wait_active_maps(ctx);
+
+	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (ret <= 0) {
+		if (!ret)
+			ret = -EAGAIN;
+		dma_resv_unlock(dmabuf->resv);
+		return ERR_PTR(ret);
+	}
+
+	map = ctx->dev_ops->map(ctx);
+	if (!IS_ERR(map)) {
+		atomic_inc(&ctx->active_maps);
+		atomic_inc(&ctx->all_maps);
+	}
+	dma_resv_unlock(dmabuf->resv);
+
+	if (IS_ERR(map))
+		return map;
+	if (WARN_ON_ONCE(!map->min_seg_shift))
+		return ERR_PTR(-EFAULT);
+
+	refcount_inc(&ctx->refs);
+	/* get a reference for the caller */
+	percpu_ref_get(&map->refs);
+
+	scoped_guard(mutex, &ctx->map_mutex)
+		rcu_assign_pointer(ctx->map, map);
+	return map;
+}
+
+static void dma_buf_io_kill_maps(struct dma_buf_io_ctx *ctx, bool final)
+{
+	struct dma_buf_io_map *map;
+
+	scoped_guard(mutex, &ctx->map_mutex) {
+		if (final)
+			ctx->maps_killed = true;
+
+		map = rcu_dereference_protected(ctx->map,
+					lockdep_is_held(&ctx->map_mutex));
+		if (!map)
+			return;
+		rcu_assign_pointer(ctx->map, NULL);
+		percpu_ref_kill(&map->refs);
+	}
+}
+
+void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_kill_maps(ctx, false);
+	dma_buf_io_wait_active_maps(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_invalidate_mappings, "DMA_BUF");
+
+void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
+{
+	/* Remove and wait for the last map, there should be no new ones. */
+	dma_buf_io_kill_maps(ctx, true);
+	dma_buf_io_put_ctx(ctx);
+}
+
+int dma_buf_io_ctx_create(struct file *file,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir,
+			   struct dma_buf_io_ctx **out_ctx)
+{
+	struct dma_buf_io_ctx *ctx;
+	int ret;
+
+	if (!file->f_op->init_dma_buf_io_ctx)
+		return -EOPNOTSUPP;
+
+	ctx = kmalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dir = dir;
+	ctx->dmabuf = dmabuf;
+	get_dma_buf(dmabuf);
+	mutex_init(&ctx->map_mutex);
+	mutex_init(&ctx->map_create_mutex);
+	atomic_set(&ctx->active_maps, 0);
+	atomic_set(&ctx->all_maps, 0);
+	refcount_set(&ctx->refs, 1);
+	init_waitqueue_head(&ctx->maps_wq);
+
+	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
+	if (ret) {
+		kfree(ctx);
+		dma_buf_put(dmabuf);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!ctx->dev_ops ||
+			 !ctx->dev_ops->map ||
+			 !ctx->dev_ops->unmap ||
+			 !ctx->dev_ops->release))
+		return -EINVAL;
+
+	*out_ctx = ctx;
+	return 0;
+}
+
+void dma_buf_io_detach(struct dma_buf_io_ctx *ctx)
+{
+	guard(mutex)(&ctx->map_create_mutex);
+
+	dma_buf_io_kill_maps(ctx, true);
+	dma_buf_io_wait_maps(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_detach, "DMA_BUF");
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
new file mode 100644
index 000000000000..9964526cc245
--- /dev/null
+++ b/include/linux/dma-buf-io.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DMA_BUF_IO_H__
+#define __DMA_BUF_IO_H__
+
+#include <linux/dma-buf.h>
+
+struct dma_buf_io_ctx;
+struct dma_buf_io_map;
+
+struct dma_buf_io_ops {
+	/*
+	 * Create a new map for the given ctx. Called with the reservation
+	 * lock held.
+	 */
+	struct dma_buf_io_map *(*map)(struct dma_buf_io_ctx *ctx);
+
+	/*
+	 * Clean up device specific parts of the @map. Called with the
+	 * reservation lock held.
+	 */
+	void (*unmap)(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map);
+
+	/*
+	 * The user tries to destroy the ctx. Release all device specific
+	 * parts of the token.
+	 */
+	void (*release)(struct dma_buf_io_ctx *);
+};
+
+struct dma_buf_io_map {
+	/*
+	 * Counts attached requests and other users. Device specific unmapping
+	 * is deferred until all refs are dropped.
+	 */
+	struct percpu_ref		refs;
+	/*
+	 * Shift for the minimum segment size of the mapping.
+	 */
+	unsigned			min_seg_shift;
+
+	struct dma_buf_io_ctx		*ctx;
+	union {
+		struct work_struct		release_work;
+		struct rcu_head			rcu;
+	};
+};
+
+struct dma_buf_io_ctx {
+	struct dma_buf_io_map __rcu		*map;
+	struct dma_buf				*dmabuf;
+	enum dma_data_direction			dir;
+
+	/* synchronises map reassignment */
+	struct mutex				map_mutex;
+	struct mutex				map_create_mutex;
+	refcount_t				refs;
+	/* maps that may still be in use. */
+	atomic_t				active_maps;
+	atomic_t				all_maps;
+	struct wait_queue_head			maps_wq;
+	bool					maps_killed;
+
+	void					*dev_priv;
+	const struct dma_buf_io_ops		*dev_ops;
+};
+
+int dma_buf_io_ctx_create(struct file *file,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir,
+			   struct dma_buf_io_ctx **ctx);
+void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx);
+
+struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx);
+
+static inline struct dma_buf_io_map *
+__dma_buf_io_get_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+
+	guard(rcu)();
+
+	map = rcu_dereference(ctx->map);
+	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
+		return NULL;
+
+	return map;
+}
+
+static inline struct dma_buf_io_map *
+dma_buf_io_get_map(struct dma_buf_io_ctx *ctx, bool nowait)
+{
+	struct dma_buf_io_map *map;
+
+	map = __dma_buf_io_get_map(ctx);
+	if (likely(map))
+		return map;
+
+	if (nowait)
+		return ERR_PTR(-EAGAIN);
+	return dma_buf_io_create_map(ctx);
+}
+
+static inline void dma_buf_io_map_drop(struct dma_buf_io_map *map)
+{
+	percpu_ref_put(&map->refs);
+}
+
+/*
+ * Device API
+ */
+
+void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx);
+int dma_buf_io_init_map(struct dma_buf_io_ctx *ctx, struct dma_buf_io_map *map,
+			struct sg_table *sgt);
+void dma_buf_io_detach(struct dma_buf_io_ctx *ctx);
+
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c5d7301f16f9..fa8ee0943cd4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1914,6 +1914,7 @@ struct dir_context {
 #define COPY_FILE_SPLICE		(1 << 0)
 
 struct io_uring_cmd;
+struct dma_buf_io_ctx;
 struct offset_ctx;
 
 struct file_operations {
@@ -1960,6 +1961,7 @@ struct file_operations {
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
 	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
-- 
2.54.0

