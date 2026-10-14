Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8713CC6B24
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2B510FCF7;
	Wed, 14 Oct 2026 11:02:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D9310FCEE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso9329565e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975756; x=1792580556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
 b=FbL+LJ9/M6PMHZ01fqeLXYFd6w/t9OHO57H9U0mf3JV+v96EQQ2UEGkYmCgsVT6o6a
 czbVTInDw5pnyDVfM6+7p9isSwzakGMzwKu/VRd+KOszdT4dXibeSTHSA6LGohaBYWiN
 fC3/vOgAQmaLXx/YgBgixUF/QYy1HRZxI/NXCNEsl6+NLR/X1cXaep6YN1WVWdM+mbqa
 dY3QOyOqyVRjRvnGDMwJmTsqppXbjv6XSuXlA7thTsVyHsmMV60IyCkaQk3XR+95jM6T
 AIz3pHQmuNa9ewWtLrkMkA1v8BjkMsG3zqsgjd9DUtg3LdCrT4Cfg0HB2OGvp4KcUA6i
 UjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975756; x=1792580556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XniK4D9I5IxaguHxPaSeNTaZUyaBimf3PNveaq2tpgg=;
 b=l/KTQJP0WaXW6/rGyWubcMTmO15E2+hG/T68QxsR29f9rfL1qMDfhuj5kB4et9baed
 AsCdUH77cuON7dy6iiDPpPofxvE4sJtTrKkTQUsMuk6F/SAr2NERL0FcT9KW6klXe5ti
 x3IsSCFYnKWT9xWXBuBek4/nH3VEfSOFv4eAlisQnZNj+jF1jrC76k1suMwws9VTu903
 YKBeC7NoKfx1bubVj7vGEQaNQyRKxxb4V6M6ufqMQfEupcAGQeh/ffj2Vj3MIIiuEefv
 aO9sKNr1d3Wc9lqno7r8ZABcNBZblxso+betzz+0xTgU3rc+hqYzZROJCdzE352bNgPk
 RO/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVv+PbIDDrLh8UxBFX51MkXx72uUXvSUEdkOiylJ6Q4My2kbojMtMnSu8jBwuiW/EXENLEieI/07k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLgQa2xfz8mPbAtmtfIUh8Kl9z6L7+O3BCyaJmh0IFPKnJmKNki
 JYnzTrMlorB+DdYRFDTNq5A55oUvtPYu0NrvZj2HtOrovB17EOXi95xM
X-Gm-Gg: AYBFou3PX5pq6btNjWiCsS1q92C9ImUWx8MbhV0WEJD7fKm67MpyAGZGyrQCxG1AOGp
 JcLUSSS6EKJq66QmbCOl1FnxWHgVg16aURl6g6nGonfn4qb5aZ5pL1nndcjFyg3eVhqKhhrNnfT
 vaFblEU8C2XnfC9U83pzMrzNfrL58yVqU9266jonhJB5K2yzlqWhiwYLC95Og6ceR0quVw/nkmZ
 aG/LbcMLmzrRR9i5E32slNidxRQVRldU0rF9D/y3TKrvvcsIaKg5VJysSwJf9IsBYM7sO2V4Ko2
 QkaQknmTyMt5WIaOaxAYKzg8ZHMzT9uzQ8QHqw+oOWhIWqOxsOREV2w5LHyHWqOM2eREemdcyo3
 TCDm8Fa7zJ3khLN0SAWWsYBBdxYKk4qGbfZ7ozvfmH1XKIdkiDy5WBKrZHdKJDJN6LkeFHecV8a
 O14PH8VL2e0teQzye/zWyDXLXdvJ3w0dg4xHxPEHix9Wf0tYGcKqR5XuPqZMm6S97KuCzZOXttP
 uQkaxap3pXysxEnYzAMjmBSNYONcDeH4NboDuZu5W6q3lJ3rBnXQYM12nzo3KSG2RAh060F1X37
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id
 5b1f17b1804b1-4a18e491051mr343632765e9.17.1791975755701; 
 Wed, 14 Oct 2026 04:02:35 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:35 -0700 (PDT)
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
Subject: [PATCH v11 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed, 14 Oct 2026 12:02:07 +0100
Message-ID: <178bbcbc7a0a9cf017284e8b15d5434fb546fcaf.1791975048.git.asml.silence@gmail.com>
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 50 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7234dcdb8372 100644
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
@@ -398,6 +412,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -411,7 +426,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
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
@@ -870,26 +887,29 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
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
+	if (uaddr != desc->uaddr || size != desc->size)
+		return ERR_PTR(-EOVERFLOW);
+
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
 
@@ -898,8 +918,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +940,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -934,7 +952,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1004,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1028,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
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

