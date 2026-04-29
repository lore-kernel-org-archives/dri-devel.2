Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8D7FF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC5210F07E;
	Wed, 29 Apr 2026 15:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVZezDQu";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F294010F07D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:27:04 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so7925322f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476423; x=1778081223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=;
 b=UVZezDQuR/rY7gDBWzwldLAju0bcC4BBTlquyK0NuOkTRSnVzRAriXcSHZtuBjodKq
 Ujr7AspUgcoWnUHjKLT288a1Wz8qrKR+qrb9GYBSn0j0eua/tZBiVb0k6+mopOmw3X7k
 ZSgM6raA4KWUbySzYyXYAcpm/XLzDqitSqh95q5DQ9vBx7cJqAZM3V6pduqpVtBCfh+H
 /oBD+bSDpoO6YqhzEZ6CkL+jfaCWVZm+3uoXrNu8iOmbQUpRpidjiWlYMpIZnDnHi6n/
 XtlY/lbIGSTfOgNNn1uP64HuQjVkA1mSWkdaVsgNHLvX9OQcNK0AREovaZCkLkFegAYw
 QYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476423; x=1778081223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lUujl6+MDkMLMC27AkxpxJZzY2/aRxcdD8WLm5JxhAU=;
 b=cZGiS0ggyM3WG7m8g84OXzn1PSoq8dXukG7k8VYzaZJ4wraNqSBAWtnlpzYZnYzXGi
 31K1Hal1n0E3TE7g1JgmK9+wK+CfgyB0pDCCHR6lnQZmhthM/V+ytLGsYSehkNlZ3qyQ
 F3EZqOnbbQ4FoWXvrBa0s5Ymmm8iwTGapFI4m8NWvKUXulyetjmxCEOSuYL6240qtq/c
 g3fLybTkvMAI6Xf1j+QdPebj843LlU9Y2COVv5S9J/LWMfzH0xLu0TnsG+f0vzBFfIjf
 KISMCClMR+0if8SykJfNZKGSS/1qNuIeey2OLG++VMWtd1jwgO2Zm/AbrXKtWjS+ol0B
 QRNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ82zTburHPIy1YhDfjUr26r2L5InEaWZmbyZMntHQjyGmZuYmSgs3OFajMEYlLRp8ZlFx0wFWuyQo4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywrx1sHR3r/XZh+7ObnLEBbvRO0xNE18Jp1G7FgsnBwXQaaqH6V
 0Azkt1M4faxRnC9z7PdZWLDluKAYtVM3F/DjBd61uY9eNfwVCB8XYAsy
X-Gm-Gg: AeBDietJX9lgkzEYfl8Ti/entLrKnkNuw+jOaCP2zZt22W6KBLDDeM1UQcIEsZPBjP6
 8ZtA+BgL8tH2TsBLqwKKD1Y46rmg+AyDVhTdVBbA8OMqxJuhOGAfzKb2DVzEQ/n5ULZ9BSwCWyU
 IMTLAlZ/r/13xn9C3BpYX4L7aTi2np1nITvXR/DaECcIMZF3UyuB2KuhbdVD7U4z95M8F7nG7KY
 G/vxWUB5UlqxzHGJk17lvu2QPCpQ+p6cl32L/PRHLp0JIkjL+ImrxfLNFp1wQwWLau3T9srNP3+
 0ZPU+gdRPtnsRTW2jcS2CD1rmkKhI2cLG0L5MYs6tUkT9xmrce+5Nq1Yw4Hd0VoACWQxlLW81wY
 4ZRhyOxR8wRRFw2/aEofKMiI2tC8N8yJhf2d6TgnPOyE2Zc/QpUfUYAYAcWSCLdnOi6QiDQHIM7
 0c3o2XQQefXa5QzOCnUegiSnV+sGp70fC2b6x0vipCuQUHf5CJJBYH3JxQUCKg+vrrUro8OvZJ0
 u7d1004LVZtbiRCdIB3/dmuzKAq2tSS+EqXds3s3S6U
X-Received: by 2002:a05:6000:2903:b0:43d:4b00:9ee7 with SMTP id
 ffacd0b85a97d-4464b1b8722mr14754743f8f.33.1777476423217; 
 Wed, 29 Apr 2026 08:27:03 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:27:02 -0700 (PDT)
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
Subject: [PATCH v3 09/10] io_uring/rsrc: extend buffer update
Date: Wed, 29 Apr 2026 16:25:55 +0100
Message-ID: <a97e2d1338029380995653824dea6bbb09d71775.1777475843.git.asml.silence@gmail.com>
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
index 17ac1b785440..05c3fd078767 100644
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
index ba00238941ed..f8696b01cb54 100644
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
 					struct io_uring_regbuf_desc *desc,
 					struct page **last_hpage);
@@ -46,9 +41,12 @@ static void io_iov_to_regbuf_desc(const struct iovec *iov,
 				  struct io_uring_regbuf_desc *desc)
 {
 	*desc = (struct io_uring_regbuf_desc) {
+		.type = IO_REGBUF_TYPE_UADDR,
 		.uaddr = (u64)iov->iov_base,
 		.size = iov->iov_len,
 	};
+	if (!desc->uaddr)
+		desc->type = IO_REGBUF_TYPE_EMPTY;
 }
 
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
@@ -236,6 +234,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
+	if (up->flags)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		u64 tag = 0;
@@ -292,10 +292,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 				   struct io_uring_rsrc_update2 *up,
 				   unsigned int nr_args)
 {
+	bool extended = up->flags & IORING_RSRC_UPDATE_EXTENDED;
 	u64 __user *tags = u64_to_user_ptr(up->tags);
-	struct iovec fast_iov, *iov;
 	struct page *last_hpage = NULL;
-	struct iovec __user *uvec;
 	u64 user_data = up->data;
 	__u32 done;
 	int i, err;
@@ -304,29 +303,49 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
 		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
 		}
+
 		if (tag) {
 			if (!node) {
 				err = -EINVAL;
@@ -337,10 +356,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -375,7 +390,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -389,7 +404,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -489,12 +504,9 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
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
@@ -791,8 +803,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!uaddr) {
-		if (size)
+	if (desc->type >= __IO_REGBUF_TYPE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
+		return ERR_PTR(-EINVAL);
+
+	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
+		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
-- 
2.53.0

