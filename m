Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE26C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11D310E38A;
	Mon, 21 Sep 2026 13:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Acz9Bp0f";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197D510E665
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:25 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so15447855e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997963; x=1790602763; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wbsLds5gQB7DU8emxytzuWlkdnk2zS91BnQHPN4/e+k=;
 b=Acz9Bp0fB2BRnd6SARzaTUIzT505R8OYcXtJZMDNA0A+yLQws+jq1CTms9CVo0VSwD
 hUCX6gRnGWXryaMzsR8+pqcCmzuPPpyalXbTXbECVciyt7cKG/uwQmIwPlI/c2vu62GU
 wiyQnHcAoL5EzsyYyi5AabcR/Lv6QPayn4yhcH/C0jeDZJ9RatWivlLu/3T784k7efxH
 Q1oXF5E1SITEmKBcPLX1DgbLK73CaZJ/IbSifBRlU3IhfMpl7MlqUBcDfO28PEqB1EWr
 P9KQucaACD1LaWqBUhscrRnLoEMYbt8QZtI5eFAlnilisYalvIdlAW4hrGBFSF2j7GZ/
 RhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997963; x=1790602763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wbsLds5gQB7DU8emxytzuWlkdnk2zS91BnQHPN4/e+k=;
 b=oI6zUlJfdzsPke8EHZADw8BhtyKPH1Fx5tTDrcE6kKtK2xUW9o6iSVB9dhB3uBTe8u
 nVIjngvihOfA9c5yMJSMVDpdkxASZcD6Y1wG0i+rq32eJsDL3vyJOZD+YGBI382qp3PJ
 n3WtQcpZ3B+GzM6HzkmZXCuT6C6dgRF8VrujAkkOkirUeOJnb1mUQWtOljcwLyJNKQi4
 15aF4aG1QwiS+nBHLCphN/zmbPGURjZdtylCWTOFeWXep8NjJgXs9QAk+Jn3EwBaJ/0y
 rum0sR42BEO/shNwPJK+8gK2kF4ieP6mD1GSESWzi8u/SlH1O8FkQ+8vlPn9FYtAOxqD
 T50A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVSqLCMLxkzAbXWSJI6XZJTWo0npF7ACRdEcCumg1ji5wtc6fu1ckeay26RsICBlIKlcRz8bH5hkw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nTUDZpWyinMtT6i97id+UQlNaEvOhtNRFyVbHI7pm3VA7gnIVR
 gOaAgx8asbRe8Vp8Yy89Z6JGcegofApHpSEUIBiYdMmFbvm6aciAxHvh
X-Gm-Gg: AYBFou3L4+o0JQQSR2sT+G3+kMMYVrD6hj5ckvJg9Eptj+ZXBzeZiFIFAQJL2+bHEey
 joJusKhMW6CPIfVlGf/FyBYuU8G0zkzQe10u6pXzaxxydYcE/O4TY/pe70zYTvQvkztM25O2LDs
 9QNtvNW7oiGUHK3EOEs+G4q+Trdt5z8rzExLUDzvwMGGSwoYevIzLv4zpWbB8w41+EjbBhZh7rN
 IIXjtmBmLEad096jzt0ETk+PmMdTsXs9vFAz5OF2t5SyPmnBxnyj1nGHYEZpq8uygcK5L2UAlYp
 nei2FD5BIzLp/zIeV7PmWvAa/AHgcaL7cdN6nzw0epFAeqsmUzhTQ4u50tcUHKLCJ93yJKRFXsD
 tKBXqJjzTUB/mlTCnhgnrnvGf/wr2+sIS89G99LAn3SSPYrwKOJVvyN5a0jjzyebIn7agn22q0Q
 ELGDNnRnwDm6YZwIDqwfKs1hZJIqI0Zti6h4UVljaFc/8awvzCrRf5pB6oG8NjMsr6rPGMcyQ62
 O2YgB2M5f3JKY1l0bCeSjbtTqxACtTX4FVTrfwRDe0eaBAXAe9uyiquhp2PveB/odbo7kp8HSpH
 01w45n7a5rSM//NV338niuPMSYszzw==
X-Received: by 2002:a05:600c:4e50:b0:49c:ffde:45ff with SMTP id
 5b1f17b1804b1-49fc5728f5amr140455545e9.17.1789997963087; 
 Mon, 21 Sep 2026 06:39:23 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:22 -0700 (PDT)
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
Subject: [PATCH v6 01/13] dma-buf: introduce initial file I/O infrastructure
Date: Mon, 21 Sep 2026 14:38:45 +0100
Message-ID: <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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
 drivers/dma-buf/dma-buf-io.c | 219 +++++++++++++++++++++++++++++++++++
 include/linux/dma-buf-io.h   | 113 ++++++++++++++++++
 include/linux/fs.h           |   2 +
 4 files changed, 335 insertions(+), 1 deletion(-)
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
index 000000000000..8312637a299f
--- /dev/null
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -0,0 +1,219 @@
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
+	dma_resv_lock(dmabuf->resv, NULL);
+	ctx->dev_ops->unmap(ctx, map);
+	dma_resv_unlock(dmabuf->resv);
+
+	percpu_ref_exit(&map->refs);
+	kfree(map);
+
+	atomic_dec(&ctx->all_maps);
+	wake_up(&ctx->maps_wq);
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
+
+	/* might sleep, use a worker */
+	INIT_WORK(&map->release_work, dma_buf_io_map_release_work);
+	queue_work(system_percpu_wq, &map->release_work);
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
+	dma_resv_unlock(dmabuf->resv);
+
+	if (IS_ERR(map))
+		return map;
+	if (WARN_ON_ONCE(!map->min_seg_shift))
+		return ERR_PTR(-EFAULT);
+
+	atomic_inc(&ctx->active_maps);
+	atomic_inc(&ctx->all_maps);
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
+	dma_buf_io_wait_maps(ctx);
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
index 000000000000..5ea92fc78582
--- /dev/null
+++ b/include/linux/dma-buf-io.h
@@ -0,0 +1,113 @@
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
+	struct work_struct		release_work;
+	struct dma_buf_io_ctx		*ctx;
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
index f9d1e05e8ae6..05c1ff495732 100644
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

