Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB813FF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4066410F074;
	Wed, 29 Apr 2026 15:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cU5PhYxy";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406F410F074
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:27:01 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so9974261f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476420; x=1778081220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Okho95RNKRmNJtlBZrtRfvb3jbBLTZKlsmbr0Q4pBPI=;
 b=cU5PhYxyhQiqxosFDUpNmcLRJkD0ZWtUSGqU6W5inpCLHhaiL2OBm9HnMAnR1kJ4Ap
 dJ6ruK6VhZY2iJ3jrl7BibMXDmSyFL1gb9V9OmYx30Iy3qO1Q8KkuyhGDJUVmb4t5Pjw
 pIM1R3Jl1A8hKNP22kKH8JftdeXO2iUSkyYvmpBrPnURcLKm/KHYeIxjyT+nB8mYydsv
 uVT4/eAn1GN3/U2JHH715wShfTp/vDOAN0VYkwxwONgzC7NpQNvRI86XrenmPaE8EAbs
 s9HsjNyr+yLHyR7JCtIHyFHIIErXnB9xZBBv5v6bwHfBCIpdExEoYrFdptQFjA/Ojb+b
 EW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476420; x=1778081220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Okho95RNKRmNJtlBZrtRfvb3jbBLTZKlsmbr0Q4pBPI=;
 b=eJ5Vx3CnL0q86r2DM0u2J2+YjrZiITCf7o36SQsFeEZhlWUH/ckWta3scTUlmaywDP
 0X3tbvluw8f+5OLI5/FhZY3QqYqAo2dnfEo2UaG4Q/MRGkLbOrKXF/5F8ZAEIhvi2oO/
 spUrrebuzRi/4TSPjk0ntmt0sfh1HvO8sEvdT9f3cOQXq3cW2TzMkywkiXBHNIlYZ5V3
 Fnt/h1fayGxpj9kiXFSPDhOR6giapx8uZFu/oTWSACyfaITv2oFt9NVgxwkwsSTPhQBd
 CgkY6Usc/J+4//lR1dx/V+V/4ewUNiKEveHf6P23Gey0PyrNEfkroEyjAB1WNRhc47eB
 gu2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/q1JdbDotvS49T0X2ob4Vuksl+XSLchdGziG5ugZo4jqzQxdPP/Z8VZymQ1KJVGKP6xWjp3mG+X7A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaVtNo3EfbLuCwRDwk33gyX51BZMQ8POtcqJyIzFiSciB7WTP5
 eX4gjNBLHpNtb0rnvN6kFiGicWzbTTvNAaezFum87ntPWMnBvzxVgvJK
X-Gm-Gg: AeBDietp026RjelBl5LkPnrW+/3vAOEA9tOKE/Vti9U5tu28M2/WP8DtlIZn4vYGePI
 3k90D3bJgGEZL10MA6+2lYeDz941v2lZXYexrXJHv/GnQBSKrcwRJHSsSF4pU+wpXAnZf6xi5Yq
 k523nuq5h2/xYhyRxTLwHlo7nEz+//49WcQaRglA1K4qePpZHjgK6r/h54AOQKw4tjl2SGtpXCX
 L7+0SmLpABWjAREUcX/5htbfZF5fQmQPbZj/9pLWzAh1iUhZP9ixJBfLdh1oTBu+h5uZZdcM0sd
 3rrASuTO9TlkHiZfhFiA5RNmcK1Jn3OVjK2Dmz3Xhn8qr78YlOBAdr5KxZA9f2/+qcLDMVjDCk6
 xvGs4MJ7scOIdPeXPxyw2CPAInDo+bz0iwpgstj+467edFzwqVt8PRI9khAGDdZZraNadG+mYqC
 Xd+k3kuEN3wqU2GBbs1LDOZwOsrynuVotkIRIzHyFiCK2zAFlffwlW2kO4k6tWkIYTlLEyDuWwb
 j+DB5CbBlOe33Mq3iOwfIy15ah1CG4kopXoEEufIili
X-Received: by 2002:a05:6000:1a89:b0:43d:7d6f:f529 with SMTP id
 ffacd0b85a97d-44790a325e5mr7826316f8f.31.1777476419464; 
 Wed, 29 Apr 2026 08:26:59 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:58 -0700 (PDT)
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
Subject: [PATCH v3 08/10] io_uring/rsrc: introduce buf registration structure
Date: Wed, 29 Apr 2026 16:25:54 +0100
Message-ID: <881422d8d613a8370ed98b158d2b57b46bb37230.1777475843.git.asml.silence@gmail.com>
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

In preparation to following changes, instead of passing an iovec for
buffer registration introduce a new structure. It'll be moved to uapi
later, but for now it's initialised early from a user provided iovec.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index c4a7a77d1ee9..ba00238941ed 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -27,8 +27,14 @@ struct io_rsrc_update {
 	u32				offset;
 };
 
+struct io_uring_regbuf_desc {
+	__u64 uaddr;
+	__u64 size;
+};
+
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-			struct iovec *iov, struct page **last_hpage);
+					struct io_uring_regbuf_desc *desc,
+					struct page **last_hpage);
 
 /* only define max */
 #define IORING_MAX_FIXED_FILES	(1U << 20)
@@ -36,6 +42,15 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 
 #define IO_CACHED_BVECS_SEGS	32
 
+static void io_iov_to_regbuf_desc(const struct iovec *iov,
+				  struct io_uring_regbuf_desc *desc)
+{
+	*desc = (struct io_uring_regbuf_desc) {
+		.uaddr = (u64)iov->iov_base,
+		.size = iov->iov_len,
+	};
+}
+
 int __io_account_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	unsigned long page_limit, cur_pages, new_pages;
@@ -291,6 +306,7 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	for (done = 0; done < nr_args; done++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -304,7 +320,9 @@ static int __io_sqe_buffers_update(struct io_ring_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			err = PTR_ERR(node);
 			break;
@@ -760,27 +778,27 @@ bool io_check_coalesce_buffer(struct page **page_array, int nr_pages,
 }
 
 static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
-						   struct iovec *iov,
-						   struct page **last_hpage)
+					struct io_uring_regbuf_desc *desc,
+					struct page **last_hpage)
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
 
@@ -789,8 +807,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENOMEM);
 
 	ret = -ENOMEM;
-	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
-				&nr_pages);
+	pages = io_pin_pages(uaddr, size, &nr_pages);
 	if (IS_ERR(pages)) {
 		ret = PTR_ERR(pages);
 		pages = NULL;
@@ -812,10 +829,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
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
@@ -825,7 +841,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
 
-	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	off = uaddr & ~PAGE_MASK;
 	if (coalesced)
 		off += data.first_folio_page_idx << PAGE_SHIFT;
 
@@ -878,6 +894,7 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 		memset(iov, 0, sizeof(*iov));
 
 	for (i = 0; i < nr_args; i++) {
+		struct io_uring_regbuf_desc desc;
 		struct io_rsrc_node *node;
 		u64 tag = 0;
 
@@ -901,7 +918,8 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			}
 		}
 
-		node = io_sqe_buffer_register(ctx, iov, &last_hpage);
+		io_iov_to_regbuf_desc(iov, &desc);
+		node = io_sqe_buffer_register(ctx, &desc, &last_hpage);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			break;
-- 
2.53.0

