Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E774CA600A
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E8A10F453;
	Wed,  7 Oct 2026 01:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hngeZRy7";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FACA10F455
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so10404015e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337411; x=1791942211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AjaJJwSiXABKG4NCfZGo8+QcLw4s+XE18k+6NEd6iPM=;
 b=hngeZRy7lyYOz4dMFSvuhMaxDRW1on4QOiVw0ftfIq3DlWU902AYeAjtqnWLczv/ME
 WHgsizkKop693f4FVMGBNrlTPXKVKIhGWNstqDNCnKsdjaUoYiq4QK9m7RJ4VyLj1uGN
 Q45/LJgY3or9n6L05Zq8mW5EHA6y/B+11r7JfBJMMgRaLneOUY02L4ztnEm2y2kXx0PL
 0ZW0eqZZAdobA/j12pND+hbfOWPwcufOt/KQs0bzBSiDBU3mOdv6+70yDPDSat71aSZS
 z+f8D6m6biA69i5SuaahJjvqcwlsiulBXShoreBU1O/cRskmZ8H4es5+TVClN/xcaSH0
 /5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337411; x=1791942211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AjaJJwSiXABKG4NCfZGo8+QcLw4s+XE18k+6NEd6iPM=;
 b=Ky3xbxrfWaF6Gk0x+BUCjmF9iJyGcCyhVMmQWwjcgLoDdrho/HTo/tQhRbHU7MnGL9
 3Jj9c1pKl6HPKrdLeubRKW5L2+LqRNs6psx9LwcUeESj5wEcG1JTx3IN2fvqXJw/KuaS
 qbhf3qErBsk4a6rpHxAgcVl5W93u4Kzskz6ATvsn8FkdzjivibgvYmc65lTCmjpqqLHS
 jM7gSJ2+WWYbu0596rZ0c/0RuXeYKCifojOpyVVhQfyLlcWEcvGNdNYOa6dTZbcFvAQB
 WGSqos92fLhYq0pnwmFsPWiwB4ohynOqQrHsqJIEs+z43AVcyW5gCQwkc3Hx6bxEjqNR
 9eYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6MgpeONWFETzfch3ucO39+7PU00feg9dIzM3h9kdmAlqbCfCGIqxpBVYeVHRhoPh/V6osEmPFYjk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMsI90ttWIyvLZCKzslSP9cIAeifYgnvKHVNlHfcfgI2feHpYi
 2QvnXGNezXSq5ABUtqbXq0lZq6AHtyb00dN8Vda7XYty02ANO0DXLxdQ
X-Gm-Gg: AYBFou13Ch4Bv3Vr+DuMwi1rSugRfhx05le9sCR+X1t7jAZ0Eh22OtL7k5XKK7SzuyG
 rS+tf/0WpOWNY5ll6QSvSbvrZXykzzPoXjZZvsNuGsScsOAIUZkPBFlBZnUBP/ZyZhEFmgEhTyj
 PBLy84H62BRbEu5VCPX6M15PzdnaQBPYGlTL1PfyTn+nK2Nh28VgakRu2eWuYyca74WiP4JR5VV
 5Dl6NraGBdyMgw15b6LQq3H2FOZtnxbtad4wi0OGfmr7IAwkPg+YcYl0zXr38geDUShR6D6cnCt
 IANIW8qU5Yo7AMJepuZ5KIDARAWWj2j97Z/FLvUhU4O4eV360IBGCgfKwMM8F5ggluR3dIC0dph
 Kx/7dYeJNPEDpWNHxXSXlcxxmLay29oNIr3YfJhr9eZE5N2sPR748A8JhizKRgCqapOaROVItfe
 WFR6FK5kbhucQmhfgvEIb/t7daUZdytFlzgLB7w6C1tN483tEYZUB5qXJenk4VxhKNste+hriuB
 m3wKmkxdgyt7OyMMwwezq9YsykxToNRCnVa8xpuZHo8mNNJow9Ic4Y4aAoNrEsen7Or6h3XgdB8
X-Received: by 2002:a05:600c:810a:b0:49f:f0bd:1e40 with SMTP id
 5b1f17b1804b1-4a1804557b3mr6510895e9.23.1791337410612; 
 Tue, 06 Oct 2026 18:43:30 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:29 -0700 (PDT)
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
Subject: [PATCH v9 13/13] io_uring/rsrc: add dmabuf backed registered buffers
Date: Wed,  7 Oct 2026 02:42:56 +0100
Message-ID: <a71d400980af9de2724bcc5d201040a930eecaf4.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
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

Implement dmabuf backed registered buffers. To register them, the user
should specify IO_REGBUF_TYPE_DMABUF for the regitration and pass the
desired dmabuf fd and a file for which it should be registered.

From there, it can be used with io_uring read/write requests
IORING_OP_{READ,WRITE}_FIXED) as normal. The requests should be issued
against the file specified during registration, and otherwise they'll be
failed. The user should also be prepared to handle spurious -EAGAIN by
reissuing the request.

Internally, dmabuf registered buffers is an optin feature for io_uring
request opcodes and they should pass a special flag on import to use it.

Suggested-by: David Wei <dw@davidwei.uk>
Suggested-by: Vishal Verma <vishal1.verma@intel.com>
Suggested-by: Tushar Gohad <tushar.gohad@intel.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h |  5 +++
 include/uapi/linux/io_uring.h  |  6 ++-
 io_uring/Makefile              |  1 +
 io_uring/dma-buf.c             | 68 ++++++++++++++++++++++++++++++++++
 io_uring/dma-buf.h             | 67 +++++++++++++++++++++++++++++++++
 io_uring/rsrc.c                | 59 +++++++++++++++++++++++++++--
 io_uring/rsrc.h                |  5 +++
 io_uring/rw.c                  | 33 ++++++++++++-----
 8 files changed, 230 insertions(+), 14 deletions(-)
 create mode 100644 io_uring/dma-buf.c
 create mode 100644 io_uring/dma-buf.h

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 90fea94ad202..73cd11d173df 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -11,6 +11,7 @@
 
 struct iou_loop_params;
 struct io_uring_bpf_ops;
+struct dma_buf_io_map;
 
 enum {
 	/*
@@ -610,6 +611,7 @@ enum {
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
 	REQ_F_IOPOLL_BIT,
+	REQ_F_DMABUF_BIT,
 
 	/* not a real bit, just to check we're not overflowing the space */
 	__REQ_F_LAST_BIT,
@@ -705,6 +707,8 @@ enum {
 	REQ_F_SQE_COPIED	= IO_REQ_FLAG(REQ_F_SQE_COPIED_BIT),
 	/* request must be iopolled to completion (set in ->issue()) */
 	REQ_F_IOPOLL		= IO_REQ_FLAG(REQ_F_IOPOLL_BIT),
+	/* there is a dma map attached to request that needs to be dropped */
+	REQ_F_DMABUF		= IO_REQ_FLAG(REQ_F_DMABUF_BIT),
 };
 
 struct io_tw_req {
@@ -827,6 +831,7 @@ struct io_kiocb {
 	/* custom credentials, valid IFF REQ_F_CREDS is set */
 	const struct cred		*creds;
 	struct io_wq_work		work;
+	struct dma_buf_io_map		*dmabuf_map;
 
 	struct io_big_cqe {
 		u64			extra1;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index abb590833a0f..b456f45fa8de 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -811,6 +811,7 @@ enum io_uring_rsrc_reg_flags {
 enum io_uring_regbuf_type {
 	IO_REGBUF_TYPE_EMPTY,
 	IO_REGBUF_TYPE_UADDR,
+	IO_REGBUF_TYPE_DMABUF,
 
 	__IO_REGBUF_TYPE_MAX,
 };
@@ -820,7 +821,10 @@ struct io_uring_regbuf_desc {
 	__u32 flags;
 	__u64 size;
 	__u64 uaddr;
-	__u64 __resv[7];
+
+	__s32 dmabuf_fd;
+	__s32 target_fd;
+	__u64 __resv[6];
 };
 
 /* Skip updating fd indexes set to this value in the fd table */
diff --git a/io_uring/Makefile b/io_uring/Makefile
index c54e328d1410..965bb60e9f7b 100644
--- a/io_uring/Makefile
+++ b/io_uring/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_PROC_FS) += fdinfo.o
 obj-$(CONFIG_IO_URING_MOCK_FILE) += mock_file.o
 obj-$(CONFIG_IO_URING_BPF) += bpf_filter.o
 obj-$(CONFIG_IO_URING_BPF_OPS) += bpf-ops.o
+obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf.o
diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
new file mode 100644
index 000000000000..f40c9d87ed8a
--- /dev/null
+++ b/io_uring/dma-buf.c
@@ -0,0 +1,68 @@
+#include "dma-buf.h"
+
+static inline void io_release_dmabuf(void *priv)
+{
+	struct io_buf_dma *bd = priv;
+
+	fput(bd->target_file);
+	dma_buf_io_ctx_release(bd->ctx);
+	kfree(bd);
+}
+
+int io_register_dmabuf(struct io_ring_ctx *ctx,
+			struct io_uring_regbuf_desc *desc,
+			struct io_mapped_ubuf *imu)
+{
+	struct io_buf_dma *bd = NULL;
+	struct file *target_file = NULL;
+	struct dma_buf *dmabuf = NULL;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+	if (ctx->flags & IORING_SETUP_IOPOLL)
+		return -EOPNOTSUPP;
+	if (desc->uaddr || desc->size)
+		return -EINVAL;
+
+	bd = kzalloc(sizeof(*bd), GFP_KERNEL);
+	if (!bd)
+		return -ENOMEM;
+
+	target_file = fget(desc->target_fd);
+	if (!target_file) {
+		ret = -EBADF;
+		goto err;
+	}
+	dmabuf = dma_buf_get(desc->dmabuf_fd);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		dmabuf = NULL;
+		goto err;
+	}
+	ret = io_validate_user_buf_range(0, dmabuf->size);
+	if (ret)
+		goto err;
+
+	ret = dma_buf_io_ctx_create(target_file, dmabuf, DMA_BIDIRECTIONAL,
+				    &bd->ctx);
+	if (ret)
+		goto err;
+
+	bd->target_file = target_file;
+	imu->len = dmabuf->size;
+	imu->release = io_release_dmabuf;
+	imu->priv = bd;
+	imu->flags = IO_REGBUF_F_DMABUF;
+	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
+	dma_buf_put(dmabuf);
+	return 0;
+err:
+	kfree(bd);
+	if (target_file)
+		fput(target_file);
+	if (dmabuf)
+		dma_buf_put(dmabuf);
+	return ret;
+}
+
diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
new file mode 100644
index 000000000000..10d2efdd8c9f
--- /dev/null
+++ b/io_uring/dma-buf.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef IOU_DMA_BUF_H
+#define IOU_DMA_BUF_H
+
+#include <linux/dma-buf-io.h>
+#include <linux/io_uring_types.h>
+
+#include "rsrc.h"
+
+struct io_buf_dma {
+	struct dma_buf_io_ctx		*ctx;
+	struct file			*target_file;
+};
+
+static inline void io_detach_dmabuf_map(struct io_kiocb *req)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return;
+	if (!(req->flags & REQ_F_DMABUF) || !req->dmabuf_map)
+		return;
+	dma_buf_io_map_drop(req->dmabuf_map);
+	req->dmabuf_map = NULL;
+}
+
+static inline int io_attach_dmabuf_map(struct io_kiocb *req,
+					struct iov_iter *iter,
+					unsigned issue_flags)
+{
+	bool nowait = issue_flags & IO_URING_F_NONBLOCK;
+	struct dma_buf_io_map *map;
+	struct io_buf_dma *bd;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+	if (!(req->flags & REQ_F_DMABUF))
+		return 0;
+
+	bd = req->buf_node->buf->priv;
+	map = dma_buf_io_get_map(bd->ctx, nowait);
+	if (unlikely(IS_ERR(map)))
+		return PTR_ERR(map);
+	req->dmabuf_map = map;
+	iter->dmabuf_map = map;
+	return 0;
+}
+
+static inline int io_import_dmabuf_map(struct io_kiocb *req,
+				int ddir, struct iov_iter *iter,
+				struct io_mapped_ubuf *imu,
+				size_t len, size_t offset)
+{
+	struct io_buf_dma *bd = imu->priv;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+	if (req->file != bd->target_file)
+		return -EBADF;
+	req->flags |= REQ_F_DMABUF;
+	iov_iter_dmabuf_map(iter, ddir, NULL, offset, len);
+	return 0;
+}
+
+int io_register_dmabuf(struct io_ring_ctx *ctx,
+			struct io_uring_regbuf_desc *desc,
+			struct io_mapped_ubuf *imu);
+
+#endif /* IOU_DMA_BUF_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 6e4fe70b316f..d6f7cbf731eb 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -10,6 +10,7 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/dma-buf-io.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -19,6 +20,7 @@
 #include "rsrc.h"
 #include "memmap.h"
 #include "register.h"
+#include "dma-buf.h"
 
 struct io_rsrc_update {
 	struct file			*file;
@@ -898,6 +900,38 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 	return true;
 }
 
+static struct io_rsrc_node *io_register_dmabuf_desc(struct io_ring_ctx *ctx,
+						    struct io_uring_regbuf_desc *desc)
+{
+	struct io_rsrc_node *node = NULL;
+	struct io_mapped_ubuf *imu = NULL;
+	int ret;
+
+	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	imu = io_alloc_imu(ctx, 0);
+	if (!imu) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memset(imu, 0, sizeof(*imu));
+	refcount_set(&imu->refs, 1);
+
+	ret = io_register_dmabuf(ctx, desc, imu);
+	if (ret)
+		goto err;
+	node->buf = imu;
+	return node;
+err:
+	if (imu)
+		io_free_imu(ctx, imu);
+	if (node)
+		io_cache_free(&ctx->node_cache, node);
+	return ERR_PTR(ret);
+}
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct io_uring_regbuf_desc *desc)
 {
@@ -916,6 +950,12 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)) || desc->flags)
 		return ERR_PTR(-EINVAL);
 
+	if (desc->type == IO_REGBUF_TYPE_DMABUF)
+		return io_register_dmabuf_desc(ctx, desc);
+
+	if (desc->dmabuf_fd || desc->target_fd)
+		return ERR_PTR(-EINVAL);
+
 	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
 		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
@@ -1240,9 +1280,12 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
 	return 0;
 }
 
-static int io_import_fixed(int ddir, struct iov_iter *iter,
+static int io_import_fixed(struct io_kiocb *req,
+			   int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
-			   u64 buf_addr, size_t len)
+			   u64 buf_addr, size_t len,
+			   unsigned issue_flags,
+			   unsigned import_flags)
 {
 	const struct bio_vec *bvec;
 	size_t folio_mask;
@@ -1262,6 +1305,11 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
+	if (imu->flags & IO_REGBUF_F_DMABUF) {
+		if (!(import_flags & IO_REGBUF_IMPORT_ALLOW_DMABUF))
+			return -EFAULT;
+		return io_import_dmabuf_map(req, ddir, iter, imu, len, offset);
+	}
 	if (imu->flags & IO_REGBUF_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
@@ -1324,7 +1372,8 @@ int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	node = io_find_buf_node(req, issue_flags);
 	if (!node)
 		return -EFAULT;
-	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
+	return io_import_fixed(req, ddir, iter, node->buf, buf_addr, len,
+				issue_flags, import_flags);
 }
 
 static int io_buffer_acct_cloned_hpages(struct io_ring_ctx *ctx,
@@ -1751,7 +1800,9 @@ int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 	iovec_off = vec->nr - nr_iovs;
 	iov = vec->iovec + iovec_off;
 
-	if (imu->flags & IO_REGBUF_F_KBUF) {
+	if (imu->flags & IO_REGBUF_F_DMABUF) {
+		return -EOPNOTSUPP;
+	} else if (imu->flags & IO_REGBUF_F_KBUF) {
 		int ret = io_kern_bvec_size(iov, nr_iovs, imu, &nr_segs);
 
 		if (unlikely(ret))
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 351995b61e68..d893cc5e580a 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -28,6 +28,11 @@ struct io_rsrc_node {
 enum {
 	IO_REGBUF_F_KBUF		= 1 << 0,
 	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
+	IO_REGBUF_F_DMABUF		= 1 << 3,
+};
+
+enum {
+	IO_REGBUF_IMPORT_ALLOW_DMABUF		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 999d9a1cc5a5..d33b925a848e 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -23,6 +23,7 @@
 #include "rsrc.h"
 #include "poll.h"
 #include "rw.h"
+#include "dma-buf.h"
 
 static void io_complete_rw(struct kiocb *kiocb, long res);
 static void io_complete_rw_iopoll(struct kiocb *kiocb, long res);
@@ -358,13 +359,18 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	struct io_async_rw *io = req->async_data;
 	int ret;
 
-	if (io->bytes_done)
-		return 0;
+	if (!io->bytes_done) {
+		ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+					  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
+		if (ret)
+			return ret;
+		iov_iter_save_state(&io->iter, &io->iter_state);
+	}
 
-	ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-				issue_flags);
-	iov_iter_save_state(&io->iter, &io->iter_state);
-	return ret;
+	ret = io_attach_dmabuf_map(req, &io->iter, issue_flags);
+	if (ret)
+		return ret;
+	return 0;
 }
 
 int io_prep_read_fixed(struct io_kiocb *req, const struct io_uring_sqe *sqe)
@@ -577,6 +583,8 @@ static void io_complete_rw(struct kiocb *kiocb, long res)
 	struct io_rw *rw = container_of(kiocb, struct io_rw, kiocb);
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
+	io_detach_dmabuf_map(req);
+
 	/* ring owner may block in freeze_super() before task_work runs */
 	if (kiocb->ki_flags & IOCB_WRITE)
 		io_req_end_write(req);
@@ -698,7 +706,7 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 	    !(kiocb->ki_filp->f_flags & O_NONBLOCK))
 		return -EAGAIN;
 	if ((req->flags & REQ_F_BUF_NODE) &&
-	     (req->buf_node->buf->flags & IO_REGBUF_F_KBUF))
+	     (req->buf_node->buf->flags & (IO_REGBUF_F_KBUF|IO_REGBUF_F_DMABUF)))
 		return -EFAULT;
 
 	ppos = io_kiocb_ppos(kiocb);
@@ -1226,7 +1234,10 @@ int io_read_fixed(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		return ret;
 
-	return io_read(req, issue_flags);
+	ret = io_read(req, issue_flags);
+	if (ret != -EIOCBQUEUED)
+		io_detach_dmabuf_map(req);
+	return ret;
 }
 
 int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags)
@@ -1237,7 +1248,11 @@ int io_write_fixed(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		return ret;
 
-	return io_write(req, issue_flags);
+	ret = io_write(req, issue_flags);
+	if (ret != -EIOCBQUEUED)
+		io_detach_dmabuf_map(req);
+	return ret;
+
 }
 
 void io_rw_fail(struct io_kiocb *req)
-- 
2.54.0

