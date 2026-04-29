Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB06CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808B110F077;
	Wed, 29 Apr 2026 15:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJITT6Wd";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8048910F073
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:45 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so10404900f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476404; x=1778081204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GR5ndKNNRfx4IwKN9v/ALZWj8JN4jvbZ2IeaIPIqzHs=;
 b=pJITT6WdO84Vt3NpLXxf+uhvik9uIDZQ00JVauKPwkmWe3a1ykaxT/4PGMbTbjtP3z
 GfGbp9wudoiT4v+cSeRfKi17Vh7QKWHTdgoET75jO/WthDXx0lNoXl4LFsVE7Jg8pG3U
 mC6GiDPCeJrMsauFfElfXySrM6cBfrUpGmPKTwULQ01CCKE2uoBMxZs6+zDxcaDkf8vv
 xAVn9MUQo3z1Cn8RPjd0eIA+mcuQLIMs5H4c76MN4qLSZRn/hX6c4Tww/VIHcoIV6LRK
 t2UT4WN4ZQ6cJBsHM6yX8BWw/uk44cAg4X6DGEb8rlN4lNxGBHrjRBe9OKjt0Q4vf2wg
 pI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476404; x=1778081204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GR5ndKNNRfx4IwKN9v/ALZWj8JN4jvbZ2IeaIPIqzHs=;
 b=sV21zB8VivFk+FLIp6NOgsuNYY4O/F9F/oGkSAXeDqdg4LQM1D+XuK31sSeCh6hX/Y
 gMET1ucx344Ao4vOF63DjnzD1pnk2C+fsZevosuRJVuA6gLN+8eJfWs0HcWplRx+71mG
 CeeFprjce2nC5oFCPKxVEKjxbl3V9QbczIlVmc3JcjjGYJknmhndFe/kmQM9ut/6RzS5
 dsBGtZyPkt0gmw0pyOMt4IyvQo7jFAGl4+7rT+60AX0G2myvi/2VVq4IPNXFCkCAs2ZM
 JHkktuxGX+tXXAlIyS+cojHSSa6Umj1TEUYydvv0e3ND4/LDotgnJPoVUDf/umSQB9Lj
 iEiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+bBwgzvVIw72hPrBg9pltjzy5QL2+4Yrz1JWz0DZYveSxV8n1T2BeyR+RASan17NPdG9ZrcjWjYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwphHm9KdJyTWZxrE2q1T0zbDqVdqHr2obrhSHGOr52BFRTnAXJ
 C5V/Y5Pk/FAxEsd4R7r8N4gAglDeIEF46ka99lidfvI1HrIQELcj7+QV
X-Gm-Gg: AeBDieuNqALfWsSwaHGZzpThAm7iNWgE1vb+CekuIYHvH/kORJKidmTxbxkplHDGr5X
 DjCXczdizRmcoXPJsx+QEqHdGW4I4B4jlJz1xEGbDbdVkRySCK4Q2JAuBj5w6UqlPf9yhGIyZOF
 67Sz2MkAnPj8o2992DMTzMpnl/84zJTVEjXSIOjicMShEN0lhgKQNFnXhIAVazj8r9M6ir60UFI
 yPDFPU3Se3c+N3JBBhNmsIkxFAnmsR2uP3tk6+g6gB+XsCUrz3B0ThVwoCSgvVmiDZWg18p2bap
 cD20S+Vjx2+XQjoS5HlgRtit9ZXOY+uLBJYClvNuU82ekoaNtk4V3qXdnQoOc9wkck4XgbBDN3y
 LEgzIRka95lDDHXvzuzT1JloE5iM1VGRGPFsjD5ZTGsQ5ED6hu3pZvTQXgAblO35YiBMc4cPs/E
 ABDZBC0Pm6Phh51101CEZBYkXrHLugJwPc6JHfi2CoHzIbrwRzjqb6CCZgh1Niv3QyApcekHnKn
 5ElcgxplGpk1nExLhcUD+ApgyfFMdMgenjEkzh4IHa9
X-Received: by 2002:a05:6000:2681:b0:441:1ca1:6404 with SMTP id
 ffacd0b85a97d-4478ee6236amr7736191f8f.18.1777476403705; 
 Wed, 29 Apr 2026 08:26:43 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:43 -0700 (PDT)
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
Subject: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Date: Wed, 29 Apr 2026 16:25:51 +0100
Message-ID: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
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

There are two main objects. struct io_dmabuf_token and struct
io_dmabuf_map. The token is used during initial registration and serves
as an interface between the upper layer user like io_uring and to the
importer subsystem / driver. io_dmabuf_map represens the actual dma map
established for the target device[s] with dma_buf_map_attachment() and
stored in a device specific format.

The separation into two different objects exists to support map
invalidation (see dma_buf_invalidate_mappings()). A token can create
multiple maps during its lifetime, but there can only be one (active)
map attached to it. It's aslo possible to not have an active map.
Invalidation drops the active map if present, and the next map will
only be attempted to be created once there is a new request that
wants to use the token.

The primary task of the io_dmabuf_map object is to count all requests
currently using it, which is done with percpu refcounts. When a map is
invalidated, we remove it from the token, so there can be no new
requests, then it adds a fence to the dmabuf reservation object. Once
all the requests complete, we signal the fence and unmap it.

[un]mapping and any work with dma addresses is delegated to the
importer driver via an ops table stored in the token, see struct
io_dmabuf_token_dev_ops. That's required because the generic layer
doesn't have knowledge about the device it's going to be use with,
and there will be more complex use cases with multiple devices.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_dmabuf_token.h |  92 +++++++++++
 lib/Kconfig                     |   4 +
 lib/Makefile                    |   2 +
 lib/io_dmabuf_token.c           | 272 ++++++++++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 include/linux/io_dmabuf_token.h
 create mode 100644 lib/io_dmabuf_token.c

diff --git a/include/linux/io_dmabuf_token.h b/include/linux/io_dmabuf_token.h
new file mode 100644
index 000000000000..b94bda684812
--- /dev/null
+++ b/include/linux/io_dmabuf_token.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_DMA_TOKEN_H
+#define _LINUX_DMA_TOKEN_H
+
+#include <linux/dma-buf.h>
+
+struct io_dmabuf_fence;
+struct io_dmabuf_token;
+struct io_dmabuf_map;
+
+struct io_dmabuf_token_dev_ops {
+	/*
+	 * Create a new map for the given token. It should be initialised
+	 * with io_dmabuf_init_map(). The callback is executed with the
+	 * reservation lock held.
+	 */
+	struct io_dmabuf_map *(*map)(struct io_dmabuf_token *);
+
+	/*
+	 * Clean up device specific parts of the map. The callback is
+	 * executed with the reservation lock held.
+	 */
+	void (*unmap)(struct io_dmabuf_token *, struct io_dmabuf_map *);
+
+	/*
+	 * The user tries to destroy the token. Release all device specific
+	 * parts of the token.
+	 */
+	void (*release)(struct io_dmabuf_token *);
+};
+
+struct io_dmabuf_map {
+	/*
+	 * Counts attached requests and other users. Device specific unmapping
+	 * is deferred until all refs are dropped.
+	 */
+	struct percpu_ref		refs;
+
+	struct work_struct		release_work;
+	struct io_dmabuf_fence		*fence;
+	struct io_dmabuf_token		*token;
+};
+
+struct io_dmabuf_token {
+	struct io_dmabuf_map __rcu	*map;
+	struct dma_buf			*dmabuf;
+	enum dma_data_direction		dir;
+
+	atomic_t			fence_seq;
+	u64				fence_ctx;
+	struct work_struct		release_work;
+	refcount_t			refs;
+
+	void					*dev_priv;
+	const struct io_dmabuf_token_dev_ops	*dev_ops;
+};
+
+int io_dmabuf_token_create(struct file *file,
+			   struct io_dmabuf_token *token,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir);
+void io_dmabuf_token_release(struct io_dmabuf_token *token);
+
+struct io_dmabuf_map *io_dmabuf_create_map(struct io_dmabuf_token *token);
+
+static inline struct io_dmabuf_map *io_dmabuf_get_map(struct io_dmabuf_token *token)
+{
+	struct io_dmabuf_map *map;
+
+	guard(rcu)();
+
+	map = rcu_dereference(token->map);
+	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
+		return NULL;
+
+	return map;
+}
+
+static inline void io_dmabuf_map_drop(struct io_dmabuf_map *map)
+{
+	percpu_ref_put(&map->refs);
+}
+
+/*
+ * Device API
+ */
+
+void io_dmabuf_token_invalidate_mappings(struct io_dmabuf_token *token);
+int io_dmabuf_init_map(struct io_dmabuf_token *token, struct io_dmabuf_map *map);
+
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 0f2fb9610647..853f10bf8e1a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -636,3 +636,7 @@ config UNION_FIND
 
 config MIN_HEAP
 	bool
+
+config DMABUF_TOKEN
+	def_bool y
+	depends on DMA_SHARED_BUFFER
diff --git a/lib/Makefile b/lib/Makefile
index ea660cca04f4..4a42cfcaa80c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -246,6 +246,8 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
 
 obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 
+obj-$(CONFIG_DMABUF_TOKEN) += io_dmabuf_token.o
+
 # stackdepot.c should not be instrumented or call instrumented functions.
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
diff --git a/lib/io_dmabuf_token.c b/lib/io_dmabuf_token.c
new file mode 100644
index 000000000000..808b5ad33dbc
--- /dev/null
+++ b/lib/io_dmabuf_token.c
@@ -0,0 +1,272 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common infrastructure for supporing dma-buf in the I/O path.
+ *
+ * Copyright (C) 2026 Pavel Begunkov <asml.silence@gmail.com>
+ */
+#include <linux/io_dmabuf_token.h>
+#include <linux/dma-resv.h>
+
+struct io_dmabuf_fence {
+	struct dma_fence base;
+	spinlock_t lock;
+};
+
+static const char *io_dmabuf_fence_drv_name(struct dma_fence *fence)
+{
+	/* default fence release kfree's the base pointer */
+	BUILD_BUG_ON(offsetof(struct io_dmabuf_fence, base));
+
+	return "DMABUF token";
+}
+
+static const char *io_dmabuf_fence_timeline_name(struct dma_fence *fence)
+{
+	return "DMABUF token";
+}
+
+const struct dma_fence_ops io_dmabuf_fence_ops = {
+	.get_driver_name = io_dmabuf_fence_drv_name,
+	.get_timeline_name = io_dmabuf_fence_timeline_name,
+};
+
+static void io_dmabuf_token_destroy_work(struct work_struct *work)
+{
+	struct io_dmabuf_token *token = container_of(work, struct io_dmabuf_token,
+				  release_work);
+
+	if (WARN_ON_ONCE(refcount_read(&token->refs)))
+		return;
+
+	token->dev_ops->release(token);
+	dma_buf_put(token->dmabuf);
+	kfree(token);
+}
+
+static void io_dmabuf_map_release_work(struct work_struct *work)
+{
+	struct io_dmabuf_map *map = container_of(work, struct io_dmabuf_map,
+					         release_work);
+	struct io_dmabuf_fence *fence = map->fence;
+	struct io_dmabuf_token *token = map->token;
+	struct dma_buf *dmabuf = token->dmabuf;
+
+	/* the release path must wait for fences */
+	if (WARN_ON_ONCE(refcount_read(&token->refs) == 0))
+		return;
+
+	/* Prevent from destoying the token while unmapping */
+	refcount_inc(&token->refs);
+
+	/*
+	 * There are no more requests using the map, we can signal the fence.
+	 * It should be done before taking the resv lock as someone could be
+	 * waiting for the fence while holding the lock.
+	 */
+	dma_fence_signal(&fence->base);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	token->dev_ops->unmap(token, map);
+	dma_resv_unlock(dmabuf->resv);
+
+	dma_fence_put(&fence->base);
+	percpu_ref_exit(&map->refs);
+	kfree(map);
+
+	if (refcount_dec_and_test(&token->refs)) {
+		/*
+		 * Destruction needs to wait for I/O and dma fences. Defer it to
+		 * simplify locking.
+		 */
+		INIT_WORK(&token->release_work, io_dmabuf_token_destroy_work);
+		queue_work(system_wq, &token->release_work);
+	}
+}
+
+static void io_dmabuf_map_refs_release(struct percpu_ref *ref)
+{
+	struct io_dmabuf_map *map = container_of(ref, struct io_dmabuf_map, refs);
+
+	/* might sleep, use a worker */
+	INIT_WORK(&map->release_work, io_dmabuf_map_release_work);
+	queue_work(system_wq, &map->release_work);
+}
+
+int io_dmabuf_init_map(struct io_dmabuf_token *token, struct io_dmabuf_map *map)
+{
+	struct io_dmabuf_fence *fence = NULL;
+	int ret;
+
+	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence)
+		return -ENOMEM;
+
+	ret = percpu_ref_init(&map->refs, io_dmabuf_map_refs_release, 0, GFP_KERNEL);
+	if (ret) {
+		kfree(fence);
+		return ret;
+	}
+
+	spin_lock_init(&fence->lock);
+	dma_fence_init(&fence->base, &io_dmabuf_fence_ops, &fence->lock,
+			token->fence_ctx, atomic_inc_return(&token->fence_seq));
+	map->fence = fence;
+	map->token = token;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(io_dmabuf_init_map, "DMA_BUF");
+
+struct io_dmabuf_map *io_dmabuf_create_map(struct io_dmabuf_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct io_dmabuf_map *map;
+	long ret;
+
+retry:
+	/*
+	 * ->dmabuf_map() will be calling dma_buf_map_attachment(), for which
+	 * we'll need to wait for fences. Do a bit nicer and try to wait
+	 * without the resv lock first.
+	 */
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    true, MAX_SCHEDULE_TIMEOUT);
+	if (!ret)
+		ret = -EAGAIN;
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	map = io_dmabuf_get_map(token);
+	if (map) {
+		ret = 0;
+		goto out;
+	}
+
+	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				  true, 0) < 0) {
+		dma_resv_unlock(dmabuf->resv);
+		goto retry;
+	}
+
+	map = token->dev_ops->map(token);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out;
+	}
+
+	percpu_ref_get(&map->refs);
+	rcu_assign_pointer(token->map, map);
+out:
+	dma_resv_unlock(dmabuf->resv);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	return map;
+}
+
+static void io_dmabuf_drop_map(struct io_dmabuf_token *token)
+{
+	struct dma_buf *dmabuf = token->dmabuf;
+	struct io_dmabuf_map *map;
+	int ret;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	map = rcu_dereference_protected(token->map,
+					dma_resv_held(dmabuf->resv));
+	if (!map)
+		return;
+	rcu_assign_pointer(token->map, NULL);
+
+	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
+	if (WARN_ON_ONCE(ret)) {
+		struct dma_fence *fence = &map->fence->base;
+
+		dma_fence_get(fence);
+		percpu_ref_kill(&map->refs);
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+		return;
+	}
+
+	dma_resv_add_fence(dmabuf->resv, &map->fence->base,
+			   DMA_RESV_USAGE_KERNEL);
+	/*
+	 * Delay destruction until all inflight requests using the map are
+	 * gone. It'll also signal the fence then.
+	 */
+	percpu_ref_kill(&map->refs);
+}
+
+void io_dmabuf_token_invalidate_mappings(struct io_dmabuf_token *token)
+{
+	io_dmabuf_drop_map(token);
+}
+EXPORT_SYMBOL_NS_GPL(io_dmabuf_token_invalidate_mappings, "DMA_BUF");
+
+static void io_dmabuf_token_release_work(struct work_struct *work)
+{
+	struct io_dmabuf_token *token = container_of(work, struct io_dmabuf_token,
+						  release_work);
+	struct dma_buf *dmabuf = token->dmabuf;
+	long ret;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	/* Remove the last map, there should be no new ones going forward. */
+	io_dmabuf_drop_map(token);
+	dma_resv_unlock(dmabuf->resv);
+
+	/* Wait until all maps are destroyed. */
+	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
+				    false, MAX_SCHEDULE_TIMEOUT);
+
+	if (WARN_ON_ONCE(ret <= 0))
+		return;
+	if (WARN_ON_ONCE(rcu_dereference_protected(token->map, true)))
+		return;
+
+	if (refcount_dec_and_test(&token->refs))
+		io_dmabuf_token_destroy_work(&token->release_work);
+}
+
+void io_dmabuf_token_release(struct io_dmabuf_token *token)
+{
+	/*
+	 * Destruction needs to wait for I/O and dma fences. Defer it to
+	 * simplify locking.
+	 */
+	INIT_WORK(&token->release_work, io_dmabuf_token_release_work);
+	queue_work(system_wq, &token->release_work);
+}
+
+int io_dmabuf_token_create(struct file *file,
+			   struct io_dmabuf_token *token,
+			   struct dma_buf *dmabuf,
+			   enum dma_data_direction dir)
+{
+	int ret;
+
+	if (!file->f_op->create_dmabuf_token)
+		return -EOPNOTSUPP;
+
+	memset(token, 0, sizeof(*token));
+	token->fence_ctx = dma_fence_context_alloc(1);
+	token->dir = dir;
+	token->dmabuf = dmabuf;
+	refcount_set(&token->refs, 1);
+	get_dma_buf(dmabuf);
+
+	ret = file->f_op->create_dmabuf_token(file, token);
+	if (ret) {
+		memset(token, 0, sizeof(*token));
+		dma_buf_put(dmabuf);
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!token->dev_ops ||
+			 !token->dev_ops->map ||
+			 !token->dev_ops->unmap ||
+			 !token->dev_ops->release))
+		return -EINVAL;
+
+	return ret;
+}
-- 
2.53.0

