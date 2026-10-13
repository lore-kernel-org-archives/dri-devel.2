Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FCBCC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8D510F9E6;
	Tue, 13 Oct 2026 20:55:51 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D5410F9DD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:39 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b0584ad71so1974194f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924938; x=1792529738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jun/zHGshv7Ie+bKLV3PJNKMmcdIRnJjgz+qOkaWbDg=;
 b=IWW6+6rDbPFVSZ/VB+dFQchTefMFcDaGp9Ida21tvAaZtELJ3+JFqtNiWf7kxpZG+r
 6p51hM+aDvAjX6YgzgEeGEGWBEwq18MogWJ/RwVsIAv3r9ubFoD72+99s7TBWtyV4QCz
 VjfHy1JDaiFGHF8V8NKP95+XyerbQu4oFMS4gc5BoyRcQGJl9RL86Lbf98sBkIMmFpou
 hlpjtwHbdTNs9k40ZfVI8qjQGx2MxcT1cWSMCnozvIDIMciamc5feijbGiRPjzOg3axW
 WbWZAC2YAVKV/30GjxlXx/1h943/3jszqRjOBMSJ2dyWHl2DodjSb/832TSy+Ca5D9k/
 6D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924938; x=1792529738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jun/zHGshv7Ie+bKLV3PJNKMmcdIRnJjgz+qOkaWbDg=;
 b=vSNg0MSSMoIH+lV4JFYbgDPLkkYK/PPLOLeLFIjsXMQ2YT8n6qNOLiSQs2fsDIBPxP
 3ZEXsCdgelJp+DJYWQXKcKqx8GuzxN4iOEGN/bD2GMQnhlK3FC8fFMSezmkv5aEgNQ/3
 SjEyD8MvN/FW25GA49tn9F/aIWEFla57+7d9gMkgoP23/RdGi8ukpL2mkNwO8qiDYQtR
 KPyTXZ58PLwJ5gVh+bMOStZ8YmNAY2iN8epwr2ENKlD/Qw9O3dFwmh3swRBVWPmO0bPF
 eT7WhoPDUc9Im2MRYkRx0Rd2gBFtiD+R+hzGCl/Pc3/2NdoHSs4K3hydvNeDVFdRcZC7
 8ZKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMBRjWNnNo21+U6vFWO13dkw1l1Qa3e6X4Qk1P7RGf63G72z6oISQpN0QkFvSlxMRilGYBCfuvlvA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJOyxcsI0S8bwS610rxto9B+s+xzjmDhKbNJs7m9AW/A9k+KBOC
 AmFPcOSIrr0PU1/pTLl2VlhjO0P831OYo9KKDWNKvuyMx024vZ9a9+HW
X-Gm-Gg: AYBFou3nLE40JPSzq3MPk1XYyGsW8jXHBourkUvt95ck/cxWfDnmf/zHVDh61W39tsd
 nKh4EFdUrcqtLw0rYfCy3RfOhVuDwpXGuJ4dp0bLtd797eRfxVKemNul4+bgawAEXfGfigeVU1+
 eEHtgcbyfUdlSi55UYwsUnVqyakvu/XVLvhuAZyr0b3NutWsFqChR7OcPESm6BPIe9KbrOkbdzh
 u63eQA3U5Kuu/FsrzfxYJk3zYvyZvZGU2t7TLuIA5E/rDauWEfcPWt+6quRu3kJxUrlzNDVDo/v
 Z64tSZnAWQc94UZ59ABlnNvb/IEwazfaZR9WXoMXSiIkgUTtC0hA8wG162ax2TsFF7n6NYwM2RZ
 +vmZ4pux0jJkHxfEI+kcjN4+5aOrRR8AzinBhxS7YE3cdUrfGNC7gjGKqQJhgRMCsBGjnPSIqHC
 1z4aCxa9/fYnXJuccIrcwt+3PkHfx+4Y8hFI0+vBCI3r0dZ8iI2LJCZudp/oQr+6w+7mjxMR8fQ
 KSmMjq2dOB5E0Doiw6PjgQS+vI6q/hGrdZfY+oiFQ/RAUPCscCAMsUvoAitr4SEzoRTepup8qNT
X-Received: by 2002:adf:f704:0:b0:488:894d:20b0 with SMTP id
 ffacd0b85a97d-48dbad336a7mr19927039f8f.44.1791924938291; 
 Tue, 13 Oct 2026 13:55:38 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:37 -0700 (PDT)
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
Subject: [PATCH v10 10/13] io_uring/rsrc: extend buffer update
Date: Tue, 13 Oct 2026 21:54:54 +0100
Message-ID: <0ebd979544306d60e98e9e1afb1c7147fa5da6c1.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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
 io_uring/rsrc.c               | 68 +++++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index b42b66b424a7..abb590833a0f 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -791,13 +791,38 @@ struct io_uring_rsrc_update {
 
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
index 7234dcdb8372..54774729ee67 100644
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
@@ -340,6 +338,8 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 		return -ENXIO;
 	if (up->offset + nr_args > ctx->file_table.data.nr)
 		return -EINVAL;
+	if (up->flags)
+		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
 		u64 tag = 0;
@@ -399,9 +399,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -410,29 +409,49 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -443,10 +462,6 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -481,7 +496,7 @@ int io_register_files_update(struct io_ring_ctx *ctx, void __user *arg,
 	memset(&up, 0, sizeof(up));
 	if (copy_from_user(&up, arg, sizeof(struct io_uring_rsrc_update)))
 		return -EFAULT;
-	if (up.resv || up.resv2)
+	if (up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, IORING_RSRC_FILE, &up, nr_args);
 }
@@ -495,7 +510,7 @@ int io_register_rsrc_update(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 	if (copy_from_user(&up, arg, sizeof(up)))
 		return -EFAULT;
-	if (!up.nr || up.resv || up.resv2)
+	if (!up.nr || up.resv2)
 		return -EINVAL;
 	return __io_register_rsrc_update(ctx, type, &up, up.nr);
 }
@@ -595,12 +610,9 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
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
@@ -901,9 +913,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 
 	if (uaddr != desc->uaddr || size != desc->size)
 		return ERR_PTR(-EOVERFLOW);
+	if (desc->type >= __IO_REGBUF_TYPE_MAX)
+		return ERR_PTR(-EINVAL);
+	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)) || desc->flags)
+		return ERR_PTR(-EINVAL);
 
-	if (!uaddr) {
-		if (size)
+	if (desc->type == IO_REGBUF_TYPE_EMPTY) {
+		if (uaddr || size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
-- 
2.54.0

