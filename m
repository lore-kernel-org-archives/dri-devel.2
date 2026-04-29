Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB97FFF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1A010F07F;
	Wed, 29 Apr 2026 15:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jk08ytMQ";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57FA810F07D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:27:09 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so7264925f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476428; x=1778081228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBiinN/v9OplpViyP3kAACFhmG1eMp4XWQQRH+zMTH4=;
 b=jk08ytMQ7TTToqXMY2pEUC5chMFUnH46wPEYV/T0r/uS9YGS14/AkojiDF5MtpghM2
 bzi/Qph6YMoipZ2lVZYOTGmg59pSkoYo0pPCedhdGdJE1bw4tExNRdeDNKlXIN5WBW/y
 ktENSfb13Kl7eFr+PBOy2q2uVcXwjxqJiV5BfSo8WZnHzAkJcBbFSfr0BkCKbKIMhYlt
 82trbSvIGCMvKb/7Ql682xpCY3SJfEiFNl/2h00FdG1hXPtLTo7RxxjulK7tKHf1FrXL
 INpYId0rbWsg0BC1zxoopcIlDziL8xymocxOlX91FmZ1e9Jh6bDtGwc+HNhUTmPNG219
 X8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476428; x=1778081228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kBiinN/v9OplpViyP3kAACFhmG1eMp4XWQQRH+zMTH4=;
 b=FLCkYlQMViuc0ztFtwXs+MVudKFezoHSYr9dvh9teES8yCouZwf7GbJflLKO2qUvJS
 7l/C22NsYNPKFR2PIkKRzQq6nGGQTzkQwhmCYlKqRVKPsy/pvR2QKNIS/J33hRF5eU7W
 4vRH6sakXdQaSGgQXVZkxhUunAkvre7HADG9IYWvN3pLWA2WmckusISn9FX/VeM/AbAy
 Spxw/YvaUQndtsYnXsUuQk/7MYKpYWbn0y47kpoOF7TXrP5zozmvZk5Wfoc1AzkmRCte
 rS+VaLt6FkFMCPT3mlK+rVkUteoUVJSEDFwELxH5bq4p7I10svm/tEAqJ215SDtfJwO3
 /UVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VukuVkfmaCGf1R5KToIBvQUBFwvLt+oq6DdGatj4KRCGD0jW8076CKbbje9Owqg+bO68u49lFlu0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYeNKxSHaDcRxXoWIroiBb6jS9sm3rzdSJ3OPCCO4guTBApmUj
 /VBiauCdZ4EC4sUdKITpL86YpWxG/8VGwk4/3xycvWHyVcPDXh3WTxSU
X-Gm-Gg: AeBDietO5oXsZJt0ryWSdH4jSK0gA3yHuZ39NQQNZDVUPu8H0Q9epIPsfEMVDjXRT1C
 ZSkir8jq63UfEl71fyevRBRrVuPfIe4sPoVcbrm969jFDBMKRp0P2E51JsH5wpP4/ZHQoCVL2zZ
 h3Y4VDhCLVYKB2/pUKgfaRNXBHBYJ2A4eDJd6g3AsgWWzoNlEV4WkZs9XeJEHkE+coA2RZnmvHx
 uOtJabSvNCZNSzuHCgnD9z+2Qg8WWuXCZ7nBR8vzDcCz5D/siScqtiwzfy5JwIx5mODst7e8ce6
 gLO4OWSD8k/1J81A2pdKSo1Ey3h05DStoeCDAS7wGo5/cGjb8kgV5CSEQOr9aKp8NFZbvAGVii1
 2I/TUbGHuSkmWq1GynomcW8xgSivANTVZTZLkUK97FI75ADjDrVvKj1b0bkdOYoXFyLfqmgQaoE
 1gblQx13WTK2RpnlcwS898nFvCJeUWVApglf4JFfOD5X6H8g+It37klAciLZb3lI0eEP2l18nJN
 8fZzlVu9BL89AQQaqNC+vT0HC1l9w7OG6tA85bDbGvS
X-Received: by 2002:a05:6000:2f85:b0:43b:8f38:3b88 with SMTP id
 ffacd0b85a97d-446494ea255mr14984759f8f.25.1777476427532; 
 Wed, 29 Apr 2026 08:27:07 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:27:06 -0700 (PDT)
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
Subject: [PATCH v3 10/10] io_uring/rsrc: add dmabuf backed registered buffers
Date: Wed, 29 Apr 2026 16:25:56 +0100
Message-ID: <0040156480814237fc099878756fa0fb079e14d2.1777475843.git.asml.silence@gmail.com>
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
 include/linux/io_uring_types.h |   5 +
 include/uapi/linux/io_uring.h  |   6 +-
 io_uring/io_uring.c            |   3 +-
 io_uring/rsrc.c                | 163 +++++++++++++++++++++++++++++++--
 io_uring/rsrc.h                |  30 +++++-
 io_uring/rw.c                  |   4 +-
 6 files changed, 200 insertions(+), 11 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 7aee83e5ea0e..f9a33099421a 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -10,6 +10,7 @@
 
 struct iou_loop_params;
 struct io_uring_bpf_ops;
+struct io_dmabuf_map;
 
 enum {
 	/*
@@ -567,6 +568,7 @@ enum {
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
 	REQ_F_IOPOLL_BIT,
+	REQ_F_DROP_DMABUF_BIT,
 
 	/* not a real bit, just to check we're not overflowing the space */
 	__REQ_F_LAST_BIT,
@@ -662,6 +664,8 @@ enum {
 	REQ_F_SQE_COPIED	= IO_REQ_FLAG(REQ_F_SQE_COPIED_BIT),
 	/* request must be iopolled to completion (set in ->issue()) */
 	REQ_F_IOPOLL		= IO_REQ_FLAG(REQ_F_IOPOLL_BIT),
+	/* there is a dma map attached to request that needs to be dropped */
+	REQ_F_DROP_DMABUF	= IO_REQ_FLAG(REQ_F_DROP_DMABUF_BIT),
 };
 
 struct io_tw_req {
@@ -786,6 +790,7 @@ struct io_kiocb {
 	/* custom credentials, valid IFF REQ_F_CREDS is set */
 	const struct cred		*creds;
 	struct io_wq_work		work;
+	struct io_dmabuf_map		*dmabuf_map;
 
 	struct io_big_cqe {
 		u64			extra1;
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 05c3fd078767..3cd6ce28f9f5 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -810,6 +810,7 @@ enum io_uring_rsrc_reg_flags {
 enum io_uring_regbuf_type {
 	IO_REGBUF_TYPE_EMPTY,
 	IO_REGBUF_TYPE_UADDR,
+	IO_REGBUF_TYPE_DMABUF,
 
 	__IO_REGBUF_TYPE_MAX,
 };
@@ -819,7 +820,10 @@ struct io_uring_regbuf_desc {
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
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6068448a5aaa..e8a8eef45c3f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -108,7 +108,7 @@
 
 #define IO_REQ_CLEAN_SLOW_FLAGS (REQ_F_REFCOUNT | IO_REQ_LINK_FLAGS | \
 				 REQ_F_REISSUE | REQ_F_POLLED | \
-				 IO_REQ_CLEAN_FLAGS)
+				 IO_REQ_CLEAN_FLAGS | REQ_F_DROP_DMABUF)
 
 #define IO_TCTX_REFS_CACHE_NR	(1U << 10)
 
@@ -1115,6 +1115,7 @@ static void io_free_batch_list(struct io_ring_ctx *ctx,
 				io_queue_next(req);
 			if (unlikely(req->flags & IO_REQ_CLEAN_FLAGS))
 				io_clean_op(req);
+			io_req_drop_dmabuf(req);
 		}
 		io_put_file(req);
 		io_req_put_rsrc_nodes(req);
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index f8696b01cb54..bb61de308543 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -10,6 +10,7 @@
 #include <linux/compat.h>
 #include <linux/io_uring.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/io_dmabuf_token.h>
 
 #include <uapi/linux/io_uring.h>
 
@@ -789,6 +790,93 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 	return true;
 }
 
+struct io_regbuf_dma {
+	struct io_dmabuf_token		token;
+	struct file			*target_file;
+};
+
+static void io_release_reg_dmabuf(void *priv)
+{
+	struct io_regbuf_dma *db = priv;
+
+	fput(db->target_file);
+	io_dmabuf_token_release(&db->token);
+}
+
+static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
+						struct io_uring_regbuf_desc *desc)
+{
+	struct io_rsrc_node *node = NULL;
+	struct io_mapped_ubuf *imu = NULL;
+	struct io_regbuf_dma *regbuf = NULL;
+	struct file *target_file = NULL;
+	struct dma_buf *dmabuf = NULL;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
+		return ERR_PTR(-EOPNOTSUPP);
+	if (desc->uaddr || desc->size)
+		return ERR_PTR(-EINVAL);
+
+	ret = -ENOMEM;
+	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+	imu = io_alloc_imu(ctx, 0);
+	if (!imu)
+		goto err;
+	regbuf = kzalloc(sizeof(*regbuf), GFP_KERNEL);
+	if (!regbuf)
+		goto err;
+
+	ret = -EBADF;
+	target_file = fget(desc->target_fd);
+	if (!target_file)
+		goto err;
+
+	dmabuf = dma_buf_get(desc->dmabuf_fd);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		dmabuf = NULL;
+		goto err;
+	}
+	if (dmabuf->size > SZ_1G) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = io_dmabuf_token_create(target_file, &regbuf->token, dmabuf,
+				     DMA_BIDIRECTIONAL);
+	if (ret)
+		goto err;
+
+	regbuf->target_file = target_file;
+	imu->nr_bvecs = 1;
+	imu->ubuf = 0;
+	imu->len = dmabuf->size;
+	imu->folio_shift = 0;
+	imu->release = io_release_reg_dmabuf;
+	imu->priv = regbuf;
+	imu->flags = IO_REGBUF_F_DMABUF;
+	imu->dir = IO_BUF_DEST | IO_BUF_SOURCE;
+	refcount_set(&imu->refs, 1);
+	node->buf = imu;
+	dma_buf_put(dmabuf);
+	return node;
+err:
+	kfree(regbuf);
+	if (imu)
+		io_free_imu(ctx, imu);
+	if (node)
+		io_cache_free(&ctx->node_cache, node);
+	if (target_file)
+		fput(target_file);
+	if (dmabuf)
+		dma_buf_put(dmabuf);
+	return ERR_PTR(ret);
+}
+
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 					struct io_uring_regbuf_desc *desc,
 					struct page **last_hpage)
@@ -808,6 +896,12 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
 		return ERR_PTR(-EINVAL);
 
+	if (desc->type == IO_REGBUF_TYPE_DMABUF)
+		return io_register_dmabuf(ctx, desc);
+
+	if (desc->dmabuf_fd || desc->target_fd)
+		return ERR_PTR(-EINVAL);
+
 	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
 		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
@@ -1134,9 +1228,57 @@ static int io_import_kbuf(int ddir, struct iov_iter *iter,
 	return 0;
 }
 
-static int io_import_fixed(int ddir, struct iov_iter *iter,
+void io_drop_dmabuf_node(struct io_kiocb *req)
+{
+	struct io_mapped_ubuf *imu;
+
+	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
+		return;
+	if (WARN_ON_ONCE(req->buf_node->type != IORING_RSRC_BUFFER))
+		return;
+	imu = req->buf_node->buf;
+	if (WARN_ON_ONCE(!(imu->flags & IO_REGBUF_F_DMABUF)))
+		return;
+	io_dmabuf_map_drop(req->dmabuf_map);
+}
+
+static int io_import_dmabuf(struct io_kiocb *req,
+			   int ddir, struct iov_iter *iter,
 			   struct io_mapped_ubuf *imu,
-			   u64 buf_addr, size_t len)
+			   size_t len, size_t offset,
+			   unsigned issue_flags)
+{
+	struct io_regbuf_dma *db = imu->priv;
+	struct io_dmabuf_map *map;
+
+	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
+		return -EOPNOTSUPP;
+	if (!len)
+		return -EFAULT;
+	if (req->file != db->target_file)
+		return -EBADF;
+
+	map = io_dmabuf_get_map(&db->token);
+	if (unlikely(!map)) {
+		if (!(issue_flags & IO_URING_F_UNLOCKED))
+			return -EAGAIN;
+		map = io_dmabuf_create_map(&db->token);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
+	}
+
+	req->dmabuf_map = map;
+	req->flags |= REQ_F_DROP_DMABUF;
+	iov_iter_dmabuf_map(iter, ddir, map, offset, len);
+	return 0;
+}
+
+static int io_import_fixed(struct io_kiocb *req,
+			   int ddir, struct iov_iter *iter,
+			   struct io_mapped_ubuf *imu,
+			   u64 buf_addr, size_t len,
+			   unsigned issue_flags,
+			   unsigned import_flags)
 {
 	const struct bio_vec *bvec;
 	size_t folio_mask;
@@ -1156,6 +1298,12 @@ static int io_import_fixed(int ddir, struct iov_iter *iter,
 
 	offset = buf_addr - imu->ubuf;
 
+	if (imu->flags & IO_REGBUF_F_DMABUF) {
+		if (!(import_flags & IO_REGBUF_IMPORT_ALLOW_DMABUF))
+			return -EFAULT;
+		return io_import_dmabuf(req, ddir, iter, imu, len, offset,
+					issue_flags);
+	}
 	if (imu->flags & IO_REGBUF_F_KBUF)
 		return io_import_kbuf(ddir, iter, imu, len, offset);
 
@@ -1209,16 +1357,17 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
 	node = io_find_buf_node(req, issue_flags);
 	if (!node)
 		return -EFAULT;
-	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
+	return io_import_fixed(req, ddir, iter, node->buf, buf_addr, len,
+				issue_flags, import_flags);
 }
 
 /* Lock two rings at once. The rings must be different! */
@@ -1577,7 +1726,9 @@ int io_import_reg_vec(int ddir, struct iov_iter *iter,
 	iovec_off = vec->nr - nr_iovs;
 	iov = vec->iovec + iovec_off;
 
-	if (imu->flags & IO_REGBUF_F_KBUF) {
+	if (imu->flags & IO_REGBUF_F_DMABUF) {
+		return -EOPNOTSUPP;
+	} else if (imu->flags & IO_REGBUF_F_KBUF) {
 		int ret = io_kern_bvec_size(iov, nr_iovs, imu, &nr_segs);
 
 		if (unlikely(ret))
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8d48195faf9d..005a273ba107 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -25,6 +25,11 @@ struct io_rsrc_node {
 
 enum {
 	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_DMABUF		= 2,
+};
+
+enum {
+	IO_REGBUF_IMPORT_ALLOW_DMABUF		= 1,
 };
 
 struct io_mapped_ubuf {
@@ -60,9 +65,19 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir,
+			unsigned issue_flags, unsigned import_flags);
+
+static inline
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
+			unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir,
+				   issue_flags, 0);
+}
+
 int io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
 			unsigned nr_iovs, unsigned issue_flags);
@@ -147,4 +162,17 @@ static inline void io_alloc_cache_vec_kasan(struct iou_vec *iv)
 		io_vec_free(iv);
 }
 
+void io_drop_dmabuf_node(struct io_kiocb *req);
+
+static inline void io_req_drop_dmabuf(struct io_kiocb *req)
+{
+	if (!IS_ENABLED(CONFIG_DMABUF_TOKEN))
+		return;
+	if (!(req->flags & REQ_F_DROP_DMABUF))
+		return;
+	if (WARN_ON_ONCE(!(req->flags & REQ_F_BUF_NODE)))
+		return;
+	io_drop_dmabuf_node(req);
+}
+
 #endif
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 20654deff84d..d50da5fa8bb9 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -380,8 +380,8 @@ static int io_init_rw_fixed(struct io_kiocb *req, unsigned int issue_flags,
 	if (io->bytes_done)
 		return 0;
 
-	ret = io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
-				issue_flags);
+	ret = __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
+				  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
 	iov_iter_save_state(&io->iter, &io->iter_state);
 	return ret;
 }
-- 
2.53.0

