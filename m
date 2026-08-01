Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135B7C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F5510E34B;
	Sat,  1 Aug 2026 15:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DFVRM14E";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B0510E34B
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:51:06 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2caed617615so25875215ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599466; x=1786204266; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6LlJ8gBFfbSI101GpfmueMUxhwNSOZCGEsyX/W5uwU=;
 b=DFVRM14E4ZQQvIkSbKe/PYc+RCdvyIgvNGF6Xb+wbEOP3PNXwYzYTmXUTePCT/1yN3
 db6Wu8VSbpT1fCcY99d976rkUf9Iou4htcmSSIextYoq9hFPDUd6SaG+5LRViyfjEfvF
 RMackSp4waYAPsZNVQCO7xzG6lQyQ6rnuNyoh+F5H7/YWwF/9E5VjcjPS7DOQ/EMyXZT
 ct9SHXpHMR5A3wSg7RbDKLZXmjL9BkuXVmqa/8ouQTq6xZiU6+06RqwCZZUpp3JlOnDR
 IkAPLk0TBHoEcF4RXwSEsk/RaTa6N37BkG24s1UQ6xtfUcAUrQAq9hPOBjpwlcmIKJzg
 Eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599466; x=1786204266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6LlJ8gBFfbSI101GpfmueMUxhwNSOZCGEsyX/W5uwU=;
 b=oRsjqWktcA3vPABF/AQvttpeJH/ewH836NyjULoaa5Xty9jo8AXUo4HyU66Mtz+eS2
 0sP3QUH+VWkUxS20e7uF+aABPKrYvSpNQHgJ6EjI4Zs8BaXwisxJofExthpIXhcQwDSH
 H0K6en/Hy301Bjf0MqIswj8uXtzkNCOzF5jEOr75XmE06kFQ9ksbmlUjQOX6RJBA36J5
 7hmdYUtB5bfvJnS2PaEsrM4J2mGWnTqJ84WT8NW6l0unRXgNRDtCqNP3z7u6+gJ849QX
 NuoQ+2WJ5BvDB4SLEAL/TnhIC8J16XDRKC8Rgg5LK7rqZTAbuZhy/6Yshjp4RytMa4i1
 mItw==
X-Forwarded-Encrypted: i=1;
 AHgh+RovEv887Xj31Rk8WM1kckePVh7alwwvlnHpke7wGCPuDouSGMNKpAET/YFNs7KxV6G027sjAZiR7N4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzHUXpEvNXafiZcRKysfx1//AgU1mId+qxS2v00ZEKfluzbVWq
 Ex+4kYL2nhSNsLeKIj3SzcNFbtnZmAbbkfwiDAqHLCmWYCoUIP211qyF
X-Gm-Gg: AR+sD107ThDXaoDL6iFEvJenFX3Dlbsyibuv19aJLojLzL5RubT+DfBBT90Z41ccxm0
 gD8TuC36WV3mtPpNRnEJRBFmCFzRDeFk4X6FyTXzD2nMjacHQ9S/2rKh60lrgw+jt+/yK9KSiAK
 PRLmK7uBf+0c9Y2iuZw2l3pljw3j47KK0C9kPHZrcRfQBMHrRv05LXqKd+0uuCMajE7VcvVvmI1
 vzh12asarZTZQyR82D3Zn/NOxvEvVvDzxkGuZWfixLPUOQwHIGktiL5Bo7o+elcDs7qNFsf/4vV
 uz/efzlbkX4FRYVYjOQ5Yo2D1Zirho1/hrRhM4jELX6cK2Zhn4dzv7j7lWadRlUsNhztXP+U3KN
 A7w3FBhPChl1sFldt1n66A1Zb/X1ewH1aq84sjWjbwV47LICZlSGYAguv0o9N2vZoMOY+FG8vKf
 lIi+bmtm5Pj4jj+Wr1AT7MpU3D8wA3Id/T0ZigD2hiPOKNX5fZfwpEIF8g5OlP+dN6o79fIC/up
 u+/S+2SFma8SS65iNk3RCfrIjlYzT/t0mlwHLWYFDzi8oc=
X-Received: by 2002:a17:902:d544:b0:2cf:b330:e0e8 with SMTP id
 d9443c01a7336-2d0521bc383mr40814585ad.10.1785599466354; 
 Sat, 01 Aug 2026 08:51:06 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:51:05 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
Subject: [PATCH v5 12/16] io_uring/rsrc: introduce buf registration structure
Date: Sat,  1 Aug 2026 16:46:24 +0100
Message-ID: <d98dda2783b62151880ed463eaa0e9b1c90af3bc.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 8d0f2ee24e0c..8af371ba6c06 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,13 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov);
+						   struct io_uring_regbuf_desc *desc);
 
 static int hpage_acct_ref(struct io_ring_ctx *ctx, struct page *hpage,
 			  bool *acct_new)
@@ -81,6 +86,15 @@ static bool hpage_acct_unref(struct io_ring_ctx *ctx, struct page *hpage)
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)(uintptr_t)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -381,6 +395,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -394,7 +409,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -853,26 +870,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov)
+						   struct io_uring_regbuf_desc *desc)
 {
+	unsigned long uaddr = (unsigned long)desc->uaddr;
+	size_t size = desc->size;
 	struct io_mapped_ubuf *imu = NULL;
 	struct page **pages = NULL;
 	struct io_rsrc_node *node;
 	unsigned long off;
-	size_t size;
 	int ret, nr_pages, i;
 	struct io_imu_folio_data data;
 	bool coalesced = false;
 
-	if (!iov->iov_base) {
-		if (iov->iov_len)
+	if (!uaddr) {
+		if (size)
 			return ERR_PTR(-EFAULT);
 		/* remove the buffer without installing a new one */
 		return NULL;
 	}
 
-	ret = io_validate_user_buf_range((unsigned long)iov->iov_base,
-					 iov->iov_len);
+	ret = io_validate_user_buf_range(uaddr, size);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -881,8 +898,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -904,10 +920,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	if (ret)
 		goto done;
 
-	size = iov->iov_len;
 	/* store original address for later verification */
-	imu->ubuf = (unsigned long) iov->iov_base;
-	imu->len = iov->iov_len;
+	imu->ubuf = uaddr;
+	imu->len = size;
 	imu->folio_shift = PAGE_SHIFT;
 	imu->release = io_release_ubuf;
 	imu->priv = imu;
@@ -917,7 +932,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -969,6 +984,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -992,7 +1008,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.54.0

