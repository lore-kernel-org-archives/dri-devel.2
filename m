Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62699CC6B2C
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D8C10FCFB;
	Wed, 14 Oct 2026 11:02:56 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D1110FCEB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:46 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso209850f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975765; x=1792580565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Az43PS/qS00pmQNyOpOlhDk/xvxDJzb8VYH9IXe9HrU=;
 b=Y+51SJKbjnqxK9tOvQ01ZEg+jjmNH3xlpXRo1GWWv8GF7yRolzCzdhlPySVu6feHPs
 lSVh78WY4Gq9AssppvJQ6gUnt5WwptojPFNyQtQU7nurJjEvmZFpeGvws0nhJsIh7pX4
 6NusWQ4NAcqo5MckAyE0/aAa5x5argLKyckBViVs+RRPqbHmHfqLAUihHKlOV8TlSxTw
 SVzSv5oSJx+BApk0whBp8YUqkZNAIPuJ6eJB0ueXgtmIXe+kCGT1CR2/tI6R4rCodQgx
 MJEGJ4JTBglNvR95swc72w8VIB3y1RMtEBIvqQ0xwXyri7Adstcrtq7vU+8baSFaHPCm
 UNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975765; x=1792580565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Az43PS/qS00pmQNyOpOlhDk/xvxDJzb8VYH9IXe9HrU=;
 b=Ns1oV9NhDELHqnBNeUCET7mH4L8fBhEmmKA+d4DbvTzMCL4xmnoz3+rtesr+fBxCLx
 mCHqPr7Pf1YASE6fLr9Un+TmXs0h3fBGPcc6NJvc+uvLiMhoQBKfqJ+SyKHTNHODL6Pt
 jN3XMIYTHqwhKAZASCcfH1IhVf4sLwbhmvnbze4U0BRqkSduYYFGvJ6tGzWW8GKNR8kD
 /IhstdzwPbkGngUgqav9+OvvUHHnudULj7SSNGtRTUjL1xyf9RpCx7xU1Sar1pXgGR+N
 xicGrcniEBwKMUByqF5f3zwoJRQYgN6GPe9CZkfki5d9RlRmMdLSq40QRF6Qq99yHMEE
 T9jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/x69IPJHhxGOjTa2uWgcYZenJJXCcg1OIHm3573EfAbJMtQR/Om+XTIUMC12eyIG93R0xZv+pJSA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK5+BNh9wlaftHKR3pKZTv54FPb/BHekPZB0VmTRc1NB+fbeJ5O
 sDBy41MV8g81T1WxrRQywS1T7mWjDus/FWPJfiyX46yL6YGCBwczVXUa
X-Gm-Gg: AYBFou1MG+Mr1G+silexjEcJul7VAjFbNgAS6ApU/hThyQCgYEseXctS83hzEzCUuFO
 EKJXeY5OUIbD5eqfJLd8WzOl69akP3YHbhLWPh5aBMkzpd7i8PzEfXiPZ7RBSmWhfubR1O/HtgF
 nAXR+BJSTy9j3NnxNl0gIZVfULUTL7U8D0K3Ck6j0hbyEUoJ6wXBZhApObHXZRJi0UoKhxapchL
 WgXCY0oRyKIgWHTNlK6GOkL3TuHu50vqCZLMIbr63+zrIZdXksZP4zeM6MmfzGu5DhEUdOnppjf
 5OdIM8Z1/99b37hF64sFXuJY59MjCVzGH5E8lDvYQnBWjoxn8vJJacMm/iqSWM8AABebB5A4nLx
 I2wVVm5negbMrtlkqbzNlAhy+O86zY0Px93kgYGXAjUaeOpC6cO5T2MfpihzBlYDdxuyB4d8hFs
 4cDhenl6kSaGnQ5QN1NRDf7YG7ydPFbwxk48RvCdxksymx6XpBtqnKpLDUjgOXHwWPWMJOMTtW4
 Lz8z1sP4qJ5i5p5i4V9TNmXEfSxKzTXmaEjL5ZbNY5UpAXezeO9x+O8u3tbG8kpuomGAVLt/rE7
 LILv6h4YZlI=
X-Received: by 2002:a05:600c:e547:20b0:4a1:946c:953d with SMTP id
 5b1f17b1804b1-4a1946c968cmr174343455e9.27.1791975765052; 
 Wed, 14 Oct 2026 04:02:45 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:44 -0700 (PDT)
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
Subject: [PATCH v11 13/13] io_uring/rsrc: add dmabuf backed registered buffers
Date: Wed, 14 Oct 2026 12:02:11 +0100
Message-ID: <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
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
 io_uring/dma-buf.c             | 66 +++++++++++++++++++++++++++++
 io_uring/dma-buf.h             | 76 ++++++++++++++++++++++++++++++++++
 io_uring/rsrc.c                | 59 ++++++++++++++++++++++++--
 io_uring/rsrc.h                |  5 +++
 io_uring/rw.c                  | 33 +++++++++++----
 8 files changed, 237 insertions(+), 14 deletions(-)
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
index 000000000000..1a1a88640823
--- /dev/null
+++ b/io_uring/dma-buf.c
@@ -0,0 +1,66 @@
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
+int __io_register_dmabuf(struct io_ring_ctx *ctx,
+			struct io_uring_regbuf_desc *desc,
+			struct io_mapped_ubuf *imu)
+{
+	struct io_buf_dma *bd = NULL;
+	struct file *target_file = NULL;
+	struct dma_buf *dmabuf = NULL;
+	int ret;
+
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
+	imu->flags = IO_REGBUF_F_DMABUF | IO_REGBUF_F_UNCLONEABLE;
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
index 000000000000..a876a9e5e272
--- /dev/null
+++ b/io_uring/dma-buf.h
@@ -0,0 +1,76 @@
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
+int __io_register_dmabuf(struct io_ring_ctx *ctx,
+			struct io_uring_regbuf_desc *desc,
+			struct io_mapped_ubuf *imu);
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
+static inline int io_register_dmabuf(struct io_ring_ctx *ctx,
+			struct io_uring_regbuf_desc *desc,
+			struct io_mapped_ubuf *imu)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return -EOPNOTSUPP;
+	return __io_register_dmabuf(ctx, desc, imu);
+}
+
+#endif /* IOU_DMA_BUF_H */
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f42d201738cd..2e89e091afbb 100644
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
@@ -918,6 +952,12 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -1242,9 +1282,12 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
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
@@ -1264,6 +1307,11 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
+	if (imu->flags & IO_REGBUF_F_DMABUF) {
+		if (!(import_flags & IO_REGBUF_IMPORT_ALLOW_DMABUF))
+			return -EFAULT;
+		return io_import_dmabuf_map(req, ddir, iter, imu, len, offset);
+	}
 	if (imu->flags & IO_REGBUF_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
@@ -1326,7 +1374,8 @@ int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	node = io_find_buf_node(req, issue_flags);
 	if (!node)
 		return -EFAULT;
-	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
+	return io_import_fixed(req, ddir, iter, node->buf, buf_addr, len,
+				issue_flags, import_flags);
 }
 
 static int io_buffer_acct_cloned_hpages(struct io_ring_ctx *ctx,
@@ -1753,7 +1802,9 @@ int __io_import_reg_vec(int ddir, struct iov_iter *iter,
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

