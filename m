Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAA0C55173
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C52B10E335;
	Sat,  1 Aug 2026 15:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d50W5YjE";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB4D10E335
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:47:35 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d0407aedd6so21216225ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599255; x=1786204055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlAMfxnCI+4aukUkFCGEvLd7cna91lGu4ajCL8U6GrU=;
 b=d50W5YjEVk+IiVhjPqvvIa8RCJvl4AGHw3jmjTE5+wIo3GVVF+uQ/Jgm+/PKcEp+d+
 zk4973MXtRxQ+eeuz0j29ael1Y6mlz1er74tCXVIgaoWEOipnkMmeB2tu1Chcv7xQ2qM
 OqEpAj9cFXyEzkMY7+BrFS+T9XZrvVRE5tEuKmFoQeVIjp0skppAPTgsMSnOSaDb4iGq
 KrGNcr36ZwNYjvAkK8QQ2uu51z8u+2JTQ0boaNO8HDj+qnK6Ds0cRZ2va01tPCMc0hgr
 qnNQxHeAUeCMWe7cjHoKuYA30lIRbiU7v6ka9U9E1LRFrjM92Iqp4Mt5fZYUQA9gY7pk
 7KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599255; x=1786204055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlAMfxnCI+4aukUkFCGEvLd7cna91lGu4ajCL8U6GrU=;
 b=a3yd88ADImHObQxzuxz323O+NeXHNVS2hAhR/5Lwspq4Q2BbhpPwJqtJJQQtvT38sM
 V9OZ6LuyZNo1PrZI0w3QxQ/1iVfe8EO/U7lnP0kAthJfw83Pp2gTn8op3PpedmQCuZM6
 tOIYx4Q3+Y/5dgVJ7ViJM1/UYmUgJ+EYYBEOPzPOpJHT2qwClyFQXCs6k6slWA98A97J
 gKfshxjeuPLKpfmEQNvjysQs2shJQUTvTkAVlKaCza/zdbT+CTOzIxKTpGE6WG1B8vwo
 8lq/pgCQSo4AkfPe3x8rlUh42ez0axgmD6srbOO0XYh/Tar7NDGm3C1Oj73qYTLDY653
 V0rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqB5FKGMLXMotl4AQDcPV4Ay/v5D9wZ5RSIfd3RimwHleHcTl3zWUVmBy77szyJuZaDa8GfuDehEY4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx4YpSYCdjbJWKRvE//ShrnBOWJo40kWP95JBA+l0HtV8aWl7Q
 l+a3ekHQ07Du+9pVI6BVMfpiJUhNC1DPGax3qekOt7UeXPPYWgD/Yu1r
X-Gm-Gg: AR+sD13E/ozJRBLMJZCkuOlLcyU3YmgPF0LspEXH/r9Ivo/6R68TjUZyyC1tS8PtIpW
 hta6zvufnVnZvWR3gF+ugBN5sYYYwyvE3nRS8aylmZDQaLpQrpfkHgtlTQMSoKASM08nfUk0WRh
 m4MRBcl9k3H+h0eB8SnyJGzgT4/I/pnvahtd6d6fWHteS9ROD/e3GiZkDlRDEJKtHate/HLaiU5
 fV2c6ywKqtrhqUg9/0j2w9xTZMAgeGjYTNaXeUrcEiiemUm4iKY5YduIaLPgP/flCO+svFn6ODS
 LxyqncbAPB1aTinzKxjVzvsRnoSIlj37bmkd1o1aX32BTHYt6wapkZzpa1q+WOFmo5thnt0/Azd
 45E4NeoHotYOMnHdrZ7kC2ewik3HNhMScAWW1rdXu6x1LPymqc5/5ASJDoZcZssVWP1FCojptzL
 lnYo4KAaORvD2D8pkNmG37dtXI3fbECht2KQTsB7Gu5ADMF+WpKEikYUaR/pDHdYlB763VjH79k
 Sbycja1LnOvssaFeKEp6mSNp7Djm85qHRQk4N6Z+opQR+KiOUacFZO5tkE=
X-Received: by 2002:a17:902:d2c4:b0:2ca:e5c:7fba with SMTP id
 d9443c01a7336-2d0524da9d3mr35313785ad.39.1785599254851; 
 Sat, 01 Aug 2026 08:47:34 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:47:34 -0700 (PDT)
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
Subject: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
Date: Sat,  1 Aug 2026 16:46:14 +0100
Message-ID: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
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

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index fe2e985d74d2..638c1116e912 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct dma_buf_io_map;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -29,6 +30,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMABUF_MAP,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +73,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_buf_io_map *dmabuf_map;
 			};
 			size_t count;
 		};
@@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMABUF_MAP;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			struct dma_buf_io_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 34a52e9ba9e1..de5c1040a4a0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dmabuf_map(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dmabuf_map(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			 struct dma_buf_io_map *map,
+			 loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMABUF_MAP,
+		.data_source = direction,
+		.dmabuf_map = map,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dmabuf_map(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.54.0

