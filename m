Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D4EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EB010E5F7;
	Tue, 28 Jul 2026 21:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qs6a7sl6";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F3210E5F7
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:29:51 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so173946f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785274190; x=1785878990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
 b=qs6a7sl63LS9KaV+W/F5ak7nPrk/jNDkZ6yp4+oSsgBwgD/9hGqnPp3xdJfT603xNR
 Ees+aW+7U3yUxrzi+1ufJYLSgkYC4+PgznIV8hyMEFQV3bpdXKhGRrdk20v0drAfoYLN
 7rxgbLI3ZXBfOaXX34nLZKMBxTTcT9KdkHgXzD6Cvnq6Hsd10IuU/3PB9cWGwoY+eUc+
 NP3WjH6p0TK9/4RFTRGy9aU2DsL/sFWEbB+LMkYa00IMi626TT+A9IPAk11T6fjlX+bD
 zMkdHE+K5z+QhrlxuINJ12UnxiDb+aE/B/B6xE/SzH42b8Rs3DJqLqYDBNJ/p8L+k+qC
 yeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274190; x=1785878990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
 b=k4g+o3Bds3Ae+i6OWcxZsuTHunEJb38aEwhL8PoxyqsF5c1uP9MRSOpC53PtpvnOHj
 DCmR0diUULERkmN0HgSR6HeJqmxKPo9JHrZdeHCZ6+ommeOH/m2j5CKxjDLOaLzJb8Ca
 rHGWvfEFbxzdkDra/g5XLHoD6+XyFwqJI3xMYR2+QktRl9wKxgdWYb5pwj4bipPZQOge
 gvqOR2dpLrcGNSWLKVjiQXgBYcPkxTAPN2TgQZTdoOCFFcCgVpVlZ7Jw/4FKtb2nhvwE
 iiIqs6GFQ3KOAgGIZPIcE2ZftfYHyEYeH4DU0XO4C9WU/Rdf1b8PEQ4P1UMvZRcGW7Oi
 RR6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1wuHbiNrv2+ek6fwuBxSFNQP5BOGKoAtXowdZ5MTNN3edBEWSYfHetT4CvF8eRzf5a8+lxMex0wc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqreyFVMAlX5Xg64cqpm4QPbry0AJtiu87p2xvWj8Vc2fT/4L+
 cX2SyqNjj6kvIys+gAGUb4LsToJPWfjHCzPYPu61en0OhUXqeQ1JnqpM
X-Gm-Gg: AR+sD10M6DHGKDztIXplbB9tcZuHAvG7c+tqHQmlqWzaQh9W8k+AeOpjjU11gQjyL8P
 7PnmShETr/FSqaeMXqv9SuyvDw6F02gAw0Mj5A/+NdUiJwo3FPylPTHdJNWWZPsUl2w0Elt+NVN
 Sa9MSZMuVUUET6DW3UitZ4B1mKA3j6w2nTe1Tb9n7gGMvH47Mu+5xyb1WOwec1QG8dCZrttttLP
 n9bk7R0i6IucGBWj5qiLzHtGrJMSsjR/mKqOZ6JUQvPZ1TieGUprOmGg3neA3hfDm+G6ycDITAS
 ig/HT781dBYO9B76dtFciDpMg+EBvO4aKnDwzj6LoM86zKDGul5+0baKad3bchcPuPDh+elZflf
 lJRho6GNSeKYUg69bSaYyfo4qxHdlxlHgXohcEkS/6BRagcXIx7esKSF+Go8c446KDzAMNzlFrL
 3B5nHfH/H/5Xn3C2TcKuoMInQQwqWSMjYOEmlBYLOA2pOrLcjdwkub2ptcELP3C5qmq4kLvX4zY
 duacKJk
X-Received: by 2002:a5d:584e:0:b0:47f:95ec:a49b with SMTP id
 ffacd0b85a97d-47fb1ea7d64mr4772853f8f.34.1785274190146; 
 Tue, 28 Jul 2026 14:29:50 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:29:48 -0700 (PDT)
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
Subject: [PATCH v4 04/14] block: always adjust bi_offset on bio_advance_iter
Date: Tue, 28 Jul 2026 22:29:16 +0100
Message-ID: <8d4f786e3cb9ac6002bde5f3271dcb6d22c498b0.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
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

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 8f33f717b14f..dea9f567379d 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0

