Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004CBC982F0
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050C310E78A;
	Mon, 21 Sep 2026 13:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZB18aI4M";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9019610E758
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:56 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso26284215e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997995; x=1790602795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FutSyws4EmX9/QkptnDh8TTYgLLGT7M1LNenj3p2Roc=;
 b=ZB18aI4M5fPwn1AxVs7wmHdbG9oJ/D1Yr16TK3ABZtaAwAq4beeO2sHR1pPNN9N+Py
 fLoVSzc4t1pRvEyHWFLt5R+mbkZggIcs+1ZV/sJ91Qb4QkrGS/IBeGi1Dsrp3zlB0QXi
 PIqsavPJCQpM/R3hjFCK4eJFUYFo3qp8B33u69aKSX8F5c6jX9saaj7jFiB73EMTBXzH
 V9ylVcD4/ej95qUrtLyltYdfk0Ek17JHN2BS+biEpDY2RkqWdhiBzL8KvvHj/eJP5VNW
 CWTeIsK+/KqGgMS51mkJlh47Og1zX9jbc6j2maF92gU/5OuK3PHIwleucEklVzrTcOvl
 bbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997995; x=1790602795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FutSyws4EmX9/QkptnDh8TTYgLLGT7M1LNenj3p2Roc=;
 b=jBHdEMDDUS5Ln9pOTyx/URD02X6Oj5bQ8ZAQsxEBffmAZZyq1egDNOzcfTJ1KgJTHt
 89Dev9BjAT7Pky5Mk2YiZTEq6+674uuy6+tX9RB4Y69PLDW7pLbFEdrJm39rd2Z+nz7M
 vkAPLC+J+CptD0K2UPxocdHEgO9MtZ0/3ydYBICVkVUhlG0D7ZJXTgT5AxRWmxwwL6De
 1gJdWekrWNms3RznVUs+gWXSwHbSNo03bu53GwzLcH6+5NN9rzQ0E50YMzx513oaAQlR
 KlPvw8hDpbmDE9A3PkzsYGebvrQbbMKEqJtyiLjNQgD5EXkdezTxTKZBTmz2deP+I/GL
 qvhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqFbJ+QkRtSa5nNaGehi8r2koGaguJoGvxzER+H1L3JVO79kZ5B4Y2BkQ90c8JQKDDXdg//luSX+0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlzNKOv0FfqS3uZST4LLQE90ZBbLBDTQkZ/x+fzQuvT5qfvJr7
 GRalStl+rDFeHMwUFPrZWuwAPZmOe+/L/G9HC38uK+GpOT3WHttLJppg
X-Gm-Gg: AYBFou31BbDwZAqaGcOwkrzFznrb4z9TXj1PRMSmYTtj15mLwkgnmWaJIPjB2AWNtfR
 ckJ2kzv2E9DNoQKsXSmUvY72LuZRuX8YFdr3ySJbCNFAC06t2QWEubWFGZlrzn5UTpgDMhCrv+R
 t8l5K/LAK44qxHEYrTxpm4lto4SOo/z0kBF6BBKGGO2AeEJ5MXtelFpibipEUFEiPTCJBmPg5w6
 CzgDGmstZ50Ab13H+ZlQQtjRhNHuqO9Rd94H2yKmdGHAkct9TUesXCjnQK+xzbweF/+AR7HRqE2
 Ox7OyWFK8gvgaIltfnnn/T/0QqQTV4byJB1qWUt7EyRF5ILbsL13s832JyfUI325xQgmHD+15c5
 1kPnFvp9TLJrPPOYmb32mej1XMQWO7lTC8l+A9rLMLDN89DjBgYASE+tKrWTMwBG7ZyCYzgscjD
 djMwFYCOlwVEJkQVDnxz2ghJU4UO+N7PgOoYGsQuuTqwKNlp25/Ym8iWHKjGmDnwiQmPaVR32dG
 qsy+lAqQJSi/yhXU+tapFf6cpBe+L8g8HKSsHdoAAYaFPJFjx9L+A5a1iOszkchGdvGUdFLGERM
 4i475G6wJ1fiFez+R51h3hbp4Pgq2Z0=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49fc574a9bcmr133446705e9.25.1789997994878; 
 Mon, 21 Sep 2026 06:39:54 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:54 -0700 (PDT)
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
Subject: [PATCH v6 10/13] io_uring/rsrc: extend buffer update
Date: Mon, 21 Sep 2026 14:38:54 +0100
Message-ID: <947ff623f7e6844af4435f258ad939fa2192c0e4.1789997898.git.asml.silence@gmail.com>
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

We need to pass more information to buffer registration than we can fit
into a single struct iovec. This patch allows users to optionally pass
struct io_uring_regbuf_desc. Apart from having more space for future use
cases, it also introduces registration types.

Currently, the type can be either of IO_REGBUF_TYPE_UADDR, which mirrors
the iovec path, or IO_REGBUF_TYPE_EMPTY for leaving a buffer table slot
empty. The next patch introduces a dmabuf backed type, and can be useful
for other extensions like splicing a list of user addresses (i.e.
iovec[]), interoperability with zcrx, kernel allocated memory like was
brough up by Cristoph. Note, the type only represents a registration
option, which is distinct from how io_uring internally stores it.

The flags field is not used yet but always useful to have, e.g. we can
encode read-only / write-only restrictions using it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/uapi/linux/io_uring.h | 27 +++++++++++++-
 io_uring/rsrc.c               | 69 ++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..98b259901185 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -790,13 +790,38 @@ struct io_uring_rsrc_update {
 
 struct io_uring_rsrc_update2 {
 	__u32 offset;
-	__u32 resv;
+	__u32 flags;
 	__aligned_u64 data;
 	__aligned_u64 tags;
 	__u32 nr;
 	__u32 resv2;
 };
 
+/* struct io_uring_rsrc_update2::flags */
+enum io_uring_rsrc_reg_flags {
+	/*
+	 * Use the extended descriptor format for buffer updates,
+	 * see struct io_uring_regbuf_desc
+	 */
+	IORING_RSRC_UPDATE_EXTENDED		= 1U << 1,
+};
+
+/* Buffer registration type, passed in struct io_uring_regbuf_desc::type */
+enum io_uring_regbuf_type {
+	IO_REGBUF_TYPE_EMPTY,
+	IO_REGBUF_TYPE_UADDR,
+
+	__IO_REGBUF_TYPE_MAX,
+};
+
+struct io_uring_regbuf_desc {
+	__u32 type; /* enum io_uring_regbuf_type */
+	__u32 flags;
+	__u64 size;
+	__u64 uaddr;
+	__u64 __resv[7];
+};
+
 /* Skip updating fd indexes set to this value in the fd table */
 #define IORING_REGISTER_FILES_SKIP	(-2)
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index da767b34eb55..83a7ad9f5bc7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,11 +27,6 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
-struct io_uring_regbuf_desc {
-	__u64 uaddr;
-	__u64 size;
-};
-
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 						   struct io_uring_regbuf_desc *desc);
 
@@ -90,9 +85,12 @@ static void io_iov_to_regbuf_desc(const struct iovec *iov,
 				  struct io_uring_regbuf_desc *desc)
 {
 	*desc = (struct io_uring_regbuf_desc) {
+		.type = IO_REGBUF_TYPE_UADDR,
 		.uaddr = (u64)(uintptr_t)iov->iov_base,
 		.size = iov->iov_len,
 	};
+	if (!desc->uaddr)
+		desc->type = IO_REGBUF_TYPE_EMPTY;
 }
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
@@ -323,6 +321,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
+	if (up->flags)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		u64 tag = 0;
@@ -382,9 +382,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 				   struct io_uring_rsrc_update2 *up,
 				   unsigned int nr_args)
 {
+	bool extended = up->flags & IORING_RSRC_UPDATE_EXTENDED;
 	u64 __user *tags = u64_to_user_ptr(up->tags);
-	struct iovec fast_iov, *iov;
-	struct iovec __user *uvec;
 	u64 user_data = up->data;
 	__u32 done;
 	int i, err;
@@ -393,29 +392,49 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->buf_table.nr)
 		return -EINVAL;
+	if (up->flags & ~IORING_RSRC_UPDATE_EXTENDED)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
-		uvec = u64_to_user_ptr(user_data);
-		iov = iovec_from_user(uvec, 1, 1, &fast_iov, io_is_compat(ctx));
-		if (IS_ERR(iov)) {
-			err = PTR_ERR(iov);
-			break;
-		}
 		if (tags && copy_from_user(&tag, &tags[done], sizeof(tag))) {
 			err = -EFAULT;
 			break;
 		}
 
-		io_iov_to_regbuf_desc(iov, &desc);
+		if (extended) {
+			if (copy_from_user(&desc, u64_to_user_ptr(user_data),
+					   sizeof(desc))) {
+				err = -EFAULT;
+				break;
+			}
+			user_data += sizeof(desc);
+		} else {
+			struct iovec __user *uvec = u64_to_user_ptr(user_data);
+			struct iovec fast_iov, *iov;
+
+			if (io_is_compat(ctx))
+				user_data += sizeof(struct compat_iovec);
+			else
+				user_data += sizeof(struct iovec);
+
+			iov = iovec_from_user(uvec, 1, 1, &fast_iov, io_is_compat(ctx));
+			if (IS_ERR(iov)) {
+				err = PTR_ERR(iov);
+				break;
+			}
+			io_iov_to_regbuf_desc(iov, &desc);
+		}
+
 		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
 		}
+
 		if (tag) {
 			if (!node) {
 				err = -EINVAL;
@@ -426,10 +445,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		i = array_index_nospec(up->offset + done, ctx->buf_table.nr);
 		io_reset_rsrc_node(ctx, &ctx->buf_table, i);
 		ctx->buf_table.nodes[i] = node;
-		if (io_is_compat(ctx))
-			user_data += sizeof(struct compat_iovec);
-		else
-			user_data += sizeof(struct iovec);
 	}
 	return done ? done : err;
 }
@@ -464,7 +479,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -478,7 +493,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -578,12 +593,9 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_uring_rsrc_update2 up2;
 	int ret;
 
+	memset(&up2, 0, sizeof(up2));
 	up2.offset = up->offset;
 	up2.data = up->arg;
-	up2.nr = 0;
-	up2.tags = 0;
-	up2.resv = 0;
-	up2.resv2 = 0;
 
 	if (up->offset == IORING_FILE_INDEX_ALLOC) {
 		ret = io_files_update_with_index_alloc(req, issue_flags);
@@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!uaddr) {
-		if (size)
+	if (desc->type >= __IO_REGBUF_TYPE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)) || desc->flags)
+		return ERR_PTR(-EINVAL);
+
+	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
+		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
-- 
2.54.0

