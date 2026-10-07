Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651C5CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9355210F44E;
	Wed,  7 Oct 2026 01:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXymvWmj";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBF610F449
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:26 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso9552025e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337405; x=1791942205; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
 b=UXymvWmjfwCrfDd2VpjMeGd1W366Co+GbjCy+sX+L5xEcf/5O8APThen6W+3+NhDcK
 C8tRal77o+Rr80woYKGdkh0mdp15AH39n9h1kY0A8BbpmFoNPM03ot/V6nFGGK+qhyJh
 ENmW2jlxy9QNfx7PYskJT3ISxTy/gwpOWM0wCcV/zLxi7eyctRReQ60j8NwpP59vF/yt
 VHk//hoiyigEgHoN3JR48gI9Xd22FzC0pdO/JliQSfF/VD9VqX5hkBtB6BkqeUD9Vv8z
 w24FgxzOTxBIyh6TxaJHt3XPP9MYWYZFEbAFthOMkqS8p+laA09ZFK3m1sNVAi2m6804
 VIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337405; x=1791942205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TBD7LAGhjErBgJ6Wm5F1SHztZSPVsK9gsGPfOw+QBug=;
 b=pC5OddHZqqFfhShovKTOYHz+9POy8BxiKUJhqXdeCDWUpAEJOih1HmqY2WQUYo9a0r
 Rf+imSgnPN+wx3eoKwzZ5SdpwuIaSrz0bLyjqNe5r+EwzwEXm8AQt8QL42GHbIf37vJv
 bw1VtAsuuynwA5vfSL3m3EpOWDAMwDTrx1pffGkR5FYCMD0SnDhbB5cAvnpwYbFJG2Yt
 ZY0J03tX+7ltftUQb/Q4mOS1qOzM/bgq45GWUFURzmP8nSH7U6A1vN36Nyqlo4vz+Pad
 SdonMDbSnmqenW9bRXFe9XfFvGeIbh02jxk3DpLk6K7kNdRgdY3mYkeSVKZvbnK9IPV8
 sXGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAC1tdSbR8DNCPtolUkYNuv2NPUbxydxSIryxsrCeqTb9G8tDM62R2RTVJQyXz0omarkdZLuUh8fc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kLH6elR5KlgrMQfHezEn9wJgD7+rCillKfEaP556DQaWCCP75I
 FXDmrOr9c0ojnoKCn2MWaLXzdLjT34j9EseQbbwuEG7LhpjmlIPrEJop
X-Gm-Gg: AYBFou0QblgQeUz5vGIg41uc6lhL7XBCwbMUbhVqRl5Op1chNROy2p8yHdnIQ8MNJia
 TrX0Di6v2qUGAY5TcyNXXLDd2vtCz5zgcxR5upGdc6s7Ei7Rrz70zAw5aA7fAs6pM/69a2NANnH
 oRLxQwhADEwzWuuobL0sIu7laPP+KoW0lxgS+LoocOJMT8gXE6cOWeBYn36I5Lvjq0puG27mp9h
 5f25+vzxuiWzcvVzneUss6y8r36ME4OhxvLrDZu5WH+RtiVOhn4eVqFKCEkN2+OMKSlTW86I8LW
 6wWUa+LuJ29lNOInJoRVev4sDSI98/6ax2O9Dc419SuyYLIbwWCQLMVhQk24nS6nsgKoioxk9Ac
 dQHrh76qd8fDrw+QEL1o6tXfoBA1yDrkzdPodiviSmTSO6UFvggQd2BQFpkmrC2ZClLNfNLTk/D
 wwHJhtpPP1eBoIjVeWwwBbwh3cNCHYKTDCpL1O1pXACXtspjLTGZneQaIiDf4y48szN4x80ojA9
 0F0wTg74dGfTIGS5sS8U1Zmn3EwumgH3EyI0SbMhQncDv3HQEp+FViTS15ZCI5bfsg+9UuUj6EH
X-Received: by 2002:a05:600c:3e16:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-4a1806649afmr7712265e9.30.1791337405094; 
 Tue, 06 Oct 2026 18:43:25 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:23 -0700 (PDT)
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
Subject: [PATCH v9 09/13] io_uring/rsrc: introduce buf registration structure
Date: Wed,  7 Oct 2026 02:42:52 +0100
Message-ID: <82a5ed8b6de7015b9ec3c6aac51ec2597749a1df.1791336930.git.asml.silence@gmail.com>
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 1efaf29514e8..7e58e9d96055 100644
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
@@ -870,26 +887,26 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
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
 
@@ -898,8 +915,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -921,10 +937,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -934,7 +949,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -986,6 +1001,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -1009,7 +1025,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
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

