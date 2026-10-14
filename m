Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E88CC6B24
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7141B10FCEC;
	Wed, 14 Oct 2026 11:02:29 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2111B10FCE3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1af482519so13099945e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975741; x=1792580541; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2mkSqDyENes6nJoSVFzqdx//VmH5Dkg6GQfLEw4/f/g=;
 b=Sda5duijAk1otmiBO4u+ipQvcP2ahmd3U16XIOsSrZhd+sMDYTzM57MKNqczhRQUwg
 9krD7ms8obOm3eHrOxeai/NGp9KQ/0LqNw7fKM9AFceWURJge85HtWh7QHwQR536zXE+
 Ff9DHnhLLrsCg//gNSLCVimuziCXokwYvyf9aKA24urwJdPngJjYIma6tIIQl5N0sKyt
 yeRp4vtA7SV4FpdI/FUGR1vo5llULC9SPRaN4dwDWRuWpMTdEudmwTgrntAXe7DRvDPo
 HxFwkPx2w3tP6MoOTMlY1vNwquh2W70TUUYTjxIvD1SqX2/Yl6e2dab5qDRNG061gmPU
 9UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975741; x=1792580541;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2mkSqDyENes6nJoSVFzqdx//VmH5Dkg6GQfLEw4/f/g=;
 b=Sh8IOqziUZMskTEST8JtE9MGBGYCrOM5d4uYLFBYGOsrbIbLq6s0o/ys9xLbBo9SN3
 PiKoBCYpZVjf7OHyeW+hG1wyJsxkX5OT5o58f1/WQyVMA1bfZyNpyk1pGj8wsloJKiwM
 XDkTQYB8cXx79/qVP5oVd7K5rxZU3+Ycne4jkce1meicJvcwnvx7ya+JttDD6jmDY7Gz
 yjvms/Wf0P+sspPq6g7A0/ArbjN39EYQVojfuvYwJYgY7kTHxorMizDEb+jfHl7N+Ab7
 5vGvyV1BtZ4kTfO/SaatFVNqWVjOF9HXUz8F3mgon702W5HW/w+gRT+JHzxDtYw5aoHf
 xiCg==
X-Forwarded-Encrypted: i=1;
 AKwUvByF7cR13q/xootR8V6KYiSreqal8LhLJWV9/xVArivs22vgMifCnD6Brt/Vri5QBpL2n+gHBtP59Lg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJA3eKP84wNzy4kJY91U5NrG9jur+4qx11JOXRN+i5Jacwr/p0+
 mz2+j3j7lU8jqIf18qnfYWiaFqzJHwTJrKqJP1LhBy4Kq0okp3xUCsKR
X-Gm-Gg: AYBFou0ZDW9/PNXzZCakSQ8+t3u+7ovBV8myZXJg2G9MOUbZ1LpfQE4ppOPbWQliUbQ
 LErI5zgOiiwO2j11uKrC9AUAzbMFoNR0KNHjUvXsnmNEw9+R2oUu2qgPzr38OAbFk4hv2ASFMdg
 h0sfQQGFknK47vjfwwPiVQcHK0gIzqu8NInyIhY6CKI9yeAR23LQOi9HzO28I5FOWef45sydur3
 9E8LJoqIdMOYgyrCGUC72bZTgrU6BQjbStcSLkIZ83syNnLuqg5aUD5R6vkB61Ni+pRs8N4sk4t
 8PHVgUSXOHJtp3f6w96a0kRxQUju2j5WSPF3cXIFbtf1BEhvfjj8ZkijuTRzZLRWhU/ns/XkaU/
 wF+kVPWq7tsss1s1Xdmlyh3Th9ldNkZURcP772PBXl1VYgStKZYhokMRWat+ntmocFfTDPjGjuW
 7FMJZXpCxJx/kWNifq3ZZF1Y0qurVA9yKcIqPACM7jefN04l1GncXktBFeDw/6hqDU0Fkv8qoSk
 yXCiyGQ6eJUbPFnWmjrdyeZxQJS+yVKx0V69tPdx+HTaFxVXt6qYvINOi4EUYKXR9lc+vk5vuY7
X-Received: by 2002:a05:600c:46ca:b0:4a1:7a1e:6910 with SMTP id
 5b1f17b1804b1-4a18e48363amr311310525e9.4.1791975741146; 
 Wed, 14 Oct 2026 04:02:21 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:19 -0700 (PDT)
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
Subject: [PATCH v11 01/13] dma-buf: introduce initial file I/O infrastructure
Date: Wed, 14 Oct 2026 12:01:59 +0100
Message-ID: <49e24334953262e85d5616c9afde88c680e4f3a3.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ctx-map separation exists to facilitate map invalidation (see
dma_buf_io_invalidate_mappings()). A ctx can create
multiple maps during its lifetime, but there can only be no more than
one (active) map attached to it. Invalidation drops the active map
if present, and any new I/O request will try to create a new one.

The primary task of dma_buf_io_map is to count requests using it
and wait for their completion when we want to destroy the DMA map.

[un]mapping and any work with dma addresses is delegated to the
importer driver via an ops table stored in the ctx, see struct
dma_buf_io_ops. Only the target driver / subsystem knows about devices
it wants to use the dma-buf with, especially in case of multi-device
filesystems or stacking in the future.

Acked-by: Matthew Brost <matthew.brost@intel.com>
Tested-by: Matthew Brost <matthew.brost@intel.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/Makefile     |   2 +-
 drivers/dma-buf/dma-buf-io.c | 229 +++++++++++++++++++++++++++++++++++
 include/linux/dma-buf-io.h   | 125 +++++++++++++++++++
 include/linux/fs.h           |   2 +
 4 files changed, 357 insertions(+), 1 deletion(-)
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
index 000000000000..21296bd3dde1
--- /dev/null
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common infrastructure for supporing dma-buf in the I/O path.
+ *
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+#include <linux/dma-buf-io.h>
+#include <linux/dma-resv.h>
+
+static void dma_buf_io_map_release(struct dma_buf_io_map *map)
+{
+	struct dma_buf_io_ctx *ctx = map->ctx;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	percpu_ref_exit(&map->refs);
+	ctx->dev_ops->unmap(ctx, map);
+}
+
+static void dma_buf_io_map_refs_cb(struct percpu_ref *ref)
+{
+	struct dma_buf_io_map *map = container_of(ref, struct dma_buf_io_map, refs);
+
+	complete(&map->drained);
+}
+
+static void dma_buf_io_kill_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+
+	dma_resv_assert_held(ctx->dmabuf->resv);
+
+	map = rcu_dereference_protected(ctx->map,
+				dma_resv_held(ctx->dmabuf->resv));
+	if (!map)
+		return;
+
+	rcu_assign_pointer(ctx->map, NULL);
+	percpu_ref_kill(&map->refs);
+	/* make sure the map is not visible via ctx->map */
+	synchronize_rcu_expedited();
+	wait_for_completion(&map->drained);
+	dma_buf_io_map_release(map);
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
+	ret = percpu_ref_init(&map->refs, dma_buf_io_map_refs_cb, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+	init_completion(&map->drained);
+	map->min_seg_shift = seg_shift;
+	map->ctx = ctx;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_init_map, "DMA_BUF");
+
+static struct dma_buf_io_map *__dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf *dmabuf = ctx->dmabuf;
+	struct dma_buf_io_map *map;
+	long ret;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (ctx->is_dead)
+		return ERR_PTR(-ENOENT);
+
+	map = __dma_buf_io_get_map(ctx);
+	if (map)
+		return map;
+
+	map = ctx->dev_ops->map(ctx);
+	if (IS_ERR(map))
+		return map;
+
+	if (WARN_ON_ONCE(!map->min_seg_shift))
+		return ERR_PTR(-EFAULT);
+
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (ret <= 0) {
+		if (!ret)
+			ret = -EAGAIN;
+		dma_buf_io_map_release(map);
+		return ERR_PTR(ret);
+	}
+
+	/* get a reference for the caller */
+	percpu_ref_get(&map->refs);
+	rcu_assign_pointer(ctx->map, map);
+	return map;
+}
+
+/**
+ * dma_buf_io_create_map - Create a new or reference an existing map.
+ * @ctx:	[in]	dma-buf I/O context
+ *
+ * A slow path part of dma_buf_io_get_map() and shouldn't be used directly.
+ * Behaves in the same way but allowed to block.
+ *
+ * Returns a map on success, or ERR_PTR encoded errno otherwise.
+ */
+struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
+{
+	struct dma_buf_io_map *map;
+	int ret;
+
+	ret = dma_resv_lock_interruptible(ctx->dmabuf->resv, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	map = __dma_buf_io_create_map(ctx);
+	dma_resv_unlock(ctx->dmabuf->resv);
+	return map;
+}
+
+static void dma_buf_io_ctx_shutdown(struct dma_buf_io_ctx *ctx)
+{
+	dma_resv_lock(ctx->dmabuf->resv, NULL);
+	ctx->is_dead = true;
+	dma_buf_io_kill_map(ctx);
+	dma_resv_unlock(ctx->dmabuf->resv);
+}
+
+/*
+ * dma_buf_io_ctx_create - create a new dma-buf I/O context for the given file.
+ * @file: 	[in]	file for which the context is created
+ * @dmabuf:	[in]	buffer to create a context from
+ * @dir:	[in]	direction of DMA transfers
+ * @out_ctx	[out]	resulting ctx
+ *
+ * Create a new I/O context from the given DMA buffer for the given file.
+ * It only works with files implementing ->init_dma_buf_io_ctx and fails
+ * with -EOPNOTSUPP otherwise. Once created, the user can create a map
+ * and use it to issue I/O like read / write requests to @file.
+ */
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
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->dir = dir;
+	ctx->dmabuf = dmabuf;
+	get_dma_buf(dmabuf);
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
+/**
+ * dma_buf_io_ctx_release - destroy the I/O context
+ * @ctx:	[in]	dma-buf I/O context
+ *
+ * Destroy the context. It makes sure all maps are waited on and destroyed,
+ * and can block for I/O to complete. It detaches from the importer and
+ * destroys all its resources via the ->release callback, and frees the
+ * context.
+ */
+void dma_buf_io_ctx_release(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_ctx_shutdown(ctx);
+
+	if (WARN_ON_ONCE(rcu_dereference_protected(ctx->map, true)))
+		return;
+
+	ctx->dev_ops->release(ctx);
+	dma_buf_put(ctx->dmabuf);
+	kfree(ctx);
+}
+
+/**
+ * dma_buf_io_invalidate_mappings - invalidate the current map
+ * @ctx: 	[in]	dma-buf I/O context
+ *
+ * Importer's helper for invalidating the current map. Waits for all I/O
+ * using the map to complete and destroyes the map. Called with the
+ * dma-buf reservation lock held.
+ */
+void dma_buf_io_invalidate_mappings(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_kill_map(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_invalidate_mappings, "DMA_BUF");
+
+/**
+ * dma_buf_io_detach - detach the @ctx from the importer.
+ * @ctx:	[in]	dma-buf I/O context
+ *
+ * Importer's helper for removing the I/O ctx. It kills all maps and
+ * prevents creation of new ones. Upon return it's safe for the importer
+ * to release all its resources such as dma-buf attachments.
+ */
+void dma_buf_io_detach(struct dma_buf_io_ctx *ctx)
+{
+	dma_buf_io_ctx_shutdown(ctx);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_io_detach, "DMA_BUF");
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
new file mode 100644
index 000000000000..b9bbeca1744f
--- /dev/null
+++ b/include/linux/dma-buf-io.h
@@ -0,0 +1,125 @@
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
+	struct completion		drained;
+};
+
+struct dma_buf_io_ctx {
+	struct dma_buf_io_map __rcu		*map;
+	struct dma_buf				*dmabuf;
+	enum dma_data_direction			dir;
+	bool					is_dead;
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
+/**
+ * dma_buf_io_get_map - Create a new or reference an existing map.
+ * @ctx:	[in]	dma-buf I/O context
+ * @nowait:	[in]	specifies whether it's allowed to block
+ *
+ * Create a new or acquire an existing map. When succeeds, it returns
+ * a referenced map, which should eventually be put down with
+ * dma_buf_io_map_drop(). If @nowait is set and the function would block,
+ * it return -EAGAIN, and the caller is expected to retry from a context
+ * where blocking is allowed.
+ *
+ * Returns a map on success, or ERR_PTR encoded errno otherwise.
+ */
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
+/**
+ * dma_buf_io_map_drop - Drop the map.
+ * @map:	[in]	dma-buf I/O map
+ *
+ * Put down a reference for the @map acquired via dma_buf_io_get_map().
+ * Should be called as soon as I/O is completed.
+ */
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

