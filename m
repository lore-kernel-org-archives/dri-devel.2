Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906A3CD13D2
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0664810F061;
	Wed, 29 Apr 2026 15:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGUo/69V";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E95B10F093
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:43 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso3178557f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476402; x=1778081202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swjDqvfsydtMCDgC1VH/dViD3xm2NdukCe3jlmQ9xuA=;
 b=dGUo/69VBD5PeUQHDDru2KO1JOFWttrh2RcSRwa61ixEKyBa/Db8PiISXHxLVdYSaQ
 rXXRvPjgd+2W4/M3B3/UewBWKBLMrXW88yx7cq9LJfQ8BB+pF+5NPW4sqVyFqRNBhDFZ
 TKjLMvhpRVMXkrOANX33jpC3sGX707mCu3B7KYVmvIxV8PROM8i9MOPZ7wXOdssrdGlh
 xWSFflLvhazXdy/462Sl3b1gI8ZiWImY/XJY/XvouT6Tccer5TJkR1X66LBlSgg4hbUQ
 YxuhCIuWz6aaTIiFTD90K2whpliw9BZ7Dn5UrAw76TpevnCXDWNRLDXgd5G5Hn0KfoZo
 MDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476402; x=1778081202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=swjDqvfsydtMCDgC1VH/dViD3xm2NdukCe3jlmQ9xuA=;
 b=IQUZL4t63gwyJqZHkl6/d9sG3/REe8weeZ3DcaeTZ969d83H8ohHqNBGlfW+E67NKM
 DEWFU/dIuzcJKFxOHhoe0e6Th9o2JWscLy5akVHUoeM4PXn+bjqCix2GY+2yECApteiQ
 0cZcIcBwSJQXN030E1y4kUmHME9q6zWcBQokrS5zsYC3RjFiDrgEEzlwSpLqhwd7OYaR
 Zz8xFKQK/on7ba2H9iVO1TiwEvoeeptOvO+6JqUENzs2Z8QRRuX1SJBeKziJ7NhK4nC4
 D1ydzPWs+RP252Hj4O785tVA0byJ+EmvZGQxYj+g4CSiqbpHzOSt+BlSpLVWAOk3ks0E
 i9Aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SXEYP2gmnRyi/UgBL/WXrfr1GmvQLlPRZebCbLKQaocpV/tLsZKLqbiBlJYqublH61oPB2lfxZLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoWygrYN3lCNNy9FwHprsaxsPy1Kp1pVNmsxGCZVj6gspCPhPK
 ikxECSyvultFYuOk7SQM+U1/tCFK0t2YC7DJ/kd+Hnz2qOKJLmuF3wYh
X-Gm-Gg: AeBDiet8yt0DmaMZOnHkh/aWl1bEFWDwLy2j37Mx0zr4jF6XOuYyypfET25ULycrJe9
 M2R3hgKsz4vrtLbbBeNRoA53G+wFV/TTc+CwnZj0zWUt6o7vaeRzII9iQDLlkf14BW4ebTTZznA
 zm1LedIs7BZUQWKmnfNhWTEM/p0Cd3slIC/+3DP3aD5TNtclkF8MbvnYGRmxeycx5mqyIKDr+Vn
 e0yHCRvOP8T24IaPHfZ/lB4bSVFVfv6OoNqQKl2oGzuDoXkc/beyFYgqPuGch1v2AgdZqADPIT8
 cgu3rXmHtCG2NagEIRyaX0gLgUAgC4mK9/sRfeZS7xR3zfZ8sLD3m/Q0T8EIhFfILFOU+AB+68s
 3ScOXsVC3fgGyEhZAMnYUcNu2R460/QDuFXXNOy5lb7M89HYMTLNvYoNAr+FRCRKzLQVAs2u8/V
 ylCZS4KA+k1WqmOSh4CJjr2JHcPymYhmvL6PU6TojOI3Wxan9U4MKSCzlBws84ttftS0XKtMxVI
 tzLz2iBQFdrpUjPPwgkguxx8qHfKVYsUt8A3zsQi+f/
X-Received: by 2002:a05:6000:1888:b0:43f:debd:feb1 with SMTP id
 ffacd0b85a97d-44649ba18b5mr14136832f8f.39.1777476397928; 
 Wed, 29 Apr 2026 08:26:37 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:37 -0700 (PDT)
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
Subject: [PATCH v3 04/10] block: introduce dma map backed bio type
Date: Wed, 29 Apr 2026 16:25:50 +0100
Message-ID: <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
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

Premapped buffers don't require a generic bio_vec since these have
already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
maps as they are mutually exclusive.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c               | 25 ++++++++++++++++++++++++-
 block/blk-merge.c         | 14 ++++++++++++++
 block/blk.h               |  3 ++-
 block/fops.c              |  2 ++
 include/linux/bio.h       | 19 ++++++++++++++++---
 include/linux/blk_types.h |  8 +++++++-
 6 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0734b50d4992..bdc91777c288 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,7 +851,13 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
-	bio->bi_io_vec = bio_src->bi_io_vec;
+
+	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
+		bio->bi_io_vec = bio_src->bi_io_vec;
+	} else {
+		bio->dmabuf_map = bio_src->dmabuf_map;
+		bio_set_flag(bio, BIO_DMABUF_MAP);
+	}
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -1183,6 +1189,18 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
+void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter)
+{
+	WARN_ON_ONCE(bio->bi_max_vecs);
+
+	bio->dmabuf_map = iter->dmabuf_map;
+	bio->bi_vcnt = 0;
+	bio->bi_iter.bi_bvec_done = iter->iov_offset;
+	bio->bi_iter.bi_size = iov_iter_count(iter);
+	bio->bi_opf |= REQ_NOMERGE;
+	bio_set_flag(bio, BIO_DMABUF_MAP);
+}
+
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1252,6 +1270,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 		return 0;
 	}
+	if (iov_iter_is_dmabuf_map(iter)) {
+		bio_dmabuf_map_set(bio, iter);
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
+		return 0;
+	}
 
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index fcf09325b22e..fc2c0c428001 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -348,6 +348,19 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
 	}
 
+	if (bio_flagged(bio, BIO_DMABUF_MAP)) {
+		nsegs = 1;
+
+		if ((bio->bi_iter.bi_bvec_done & lim->dma_alignment) ||
+		    (bio->bi_iter.bi_size & len_align_mask))
+			return -EINVAL;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			goto split;
+		}
+		goto out;
+	}
+
 	bio_for_each_bvec(bv, bio, iter) {
 		if (bv.bv_offset & start_align_mask ||
 		    bv.bv_len & len_align_mask)
@@ -378,6 +391,7 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		bvprvp = &bvprv;
 	}
 
+out:
 	*segs = nsegs;
 	bio->bi_bvec_gap_bit = ffs(gaps);
 	return 0;
diff --git a/block/blk.h b/block/blk.h
index b998a7761faf..b4b09abebce8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -424,7 +424,8 @@ static inline struct bio *__bio_split_to_limits(struct bio *bio,
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
-		if (bio_may_need_split(bio, lim))
+		if (bio_may_need_split(bio, lim) ||
+		    bio_flagged(bio, BIO_DMABUF_MAP))
 			return bio_split_rw(bio, lim, nr_segs);
 		*nr_segs = 1;
 		return bio;
diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..713a3ba3f457 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -349,6 +349,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		 * bio_iov_iter_get_pages() and set the bvec directly.
 		 */
 		bio_iov_bvec_set(bio, iter);
+	} else if (iov_iter_is_dmabuf_map(iter)) {
+		bio_dmabuf_map_set(bio, iter);
 	} else {
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97d747320b35..0c43fa6b0900 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -108,16 +108,26 @@ static inline bool bio_next_segment(const struct bio *bio,
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
 
+static inline void bio_advance_iter_dmabuf_map(struct bvec_iter *iter,
+					       unsigned int bytes)
+{
+	iter->bi_bvec_done += bytes;
+	iter->bi_size -= bytes;
+}
+
 static inline void bio_advance_iter(const struct bio *bio,
 				    struct bvec_iter *iter, unsigned int bytes)
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+	} else if (bio_flagged(bio, BIO_DMABUF_MAP)) {
+		bio_advance_iter_dmabuf_map(iter, bytes);
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -129,6 +139,8 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
+	else if (bio_flagged(bio, BIO_DMABUF_MAP))
+		bio_advance_iter_dmabuf_map(iter, bytes);
 	else
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
 }
@@ -391,7 +403,7 @@ static inline void bio_wouldblock_error(struct bio *bio)
  */
 static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 {
-	if (iov_iter_is_bvec(iter))
+	if (iov_iter_is_bvec(iter) || iov_iter_is_dmabuf_map(iter))
 		return 0;
 	return iov_iter_npages(iter, max_segs);
 }
@@ -471,6 +483,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 		unsigned len_align_mask);
 
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
+void bio_dmabuf_map_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..d5ad085b701d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -233,7 +233,12 @@ struct bio {
 	atomic_t		__bi_remaining;
 
 	/* The actual vec list, preserved by bio_reset() */
-	struct bio_vec		*bi_io_vec;
+	union {
+		struct bio_vec		*bi_io_vec;
+		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
+		struct io_dmabuf_map	*dmabuf_map;
+	};
+
 	struct bvec_iter	bi_iter;
 
 	union {
@@ -322,6 +327,7 @@ enum {
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_PLUGGING, /* bio handled through zone write plugging */
 	BIO_EMULATES_ZONE_APPEND, /* bio emulates a zone append operation */
+	BIO_DMABUF_MAP, /* Using premmaped dma buffers */
 	BIO_FLAG_LAST
 };
 
-- 
2.53.0

