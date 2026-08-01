Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2798C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0330810E33C;
	Sat,  1 Aug 2026 15:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBrKgqX0";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A108B10E33C
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:48:38 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso32038965ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599318; x=1786204118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
 b=RBrKgqX0vhMnowGaTqbl5ka34DtRHWR2mNz81V02gMsMDoLI4IPztGmWUBGmh6CGNh
 x9GYk61/ZlUqzMluMKD6tnZhmxc0qvWDEPIPdbaRDU54Y63epaAIWLqOcSzBKkhrozC0
 oex7uHCjkIB9g7mIzjavJoLEmoLh5N1NPVsj5hF8WaAJ2B+qqQ91UzK3Tww9DfG7bwSo
 0MHXVHgObFf8ByDFTFivQNgek95+6/AV0d1kq1/KfsvHSTDCarGEnVtOVgZcBICS3Le3
 WM6F9WkSJAFJHJXeKFAHWyeNoib9RM/uEF+BhiW5+eWBKDBLBt5euBduxY5kEWwa0Nzd
 QCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599318; x=1786204118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
 b=K/eASF3/UV2CV+kenid0jsNXsmsIHzrp8xkam9f/rY791n3iYC2DG2qQTd98jPSJOq
 CYrO6pYelq02rpJuSkVXAQMtbgXUhve2K+1dd8QpEUrwZQfqC39QAxuXnwIaOvWxOQO8
 ImdyyU1TCZ8+5IKk/UDM02tu1NayVVhhc+/nzI8Ussr11cop9K4c4ClqpSh2HI/q9lWx
 r7EYRznxKYa/6ePZNBItZ0Az6JPPQx6mL/Spyf+hqofLg0B+67+W5iExex3i4RQYF+/z
 yCCa8zmFq3xT+2vaei6EKOzo+kXKqyRDJ3H7rsBWOiWUdQesuli5niWxPgP/P61pzO6z
 O91Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RozHkTfpK85o9c7ER2x23XMlvtcb0uY4j2ZFF6PK/bTbXq+zsbLiAOdq1qc9tZ/7ynArUGvJvE15EY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYwDHnlwwaNd7HDwHIkt8xKjMN9CbcyLnCplFOdYJbVEBdMZ1T
 hDSbfw/2M4A6vV+ifxQZpRN11zpXL96ogtx0MTDf2H5zdQxqG7jUX6MJ
X-Gm-Gg: AR+sD11JdElXMirBf5i91dlBdKm1hDEveHpNJvVbHFg4WbogMPzMCIfGOvJJXgRWsER
 NkpTLCZSt2Va73RODmvgi8dEHSUlVsPt5rm0yu86Q7zQkY+sU3gv3GTjRA2xl4lx41+ryC+M+Yh
 sNgulwVJueYQpQDRL5+I1N3OdBnbmmlPGqmr6y++6ZmlCQ0yc96NkLeg3JP1r3TEIVWzkj0UVMj
 EEwGws8l1LaUfuAK4ua8NWwOL0EYLZX8t/3R3rVN+GC+/JRewtKKRIrgFhAkohjTjVQw/fpUljq
 kV6T0z12dX+Y8pLtAy5UaJKUVRDBh0y0YlGd9d3JUXRziWTnBaA/6WbegeKDJqlprMxr0lghMLi
 /Ywdf2ApI0hd6F65Tx3lqU/rr2kGGN2YQ4jrDabwg5cYWJcEKj8ZFF9brgFeRq555o/ZbLlXWhC
 e/moW/diNmKs9iIrfKQat9TJNlgEIIj0+IouuBBj9rhO8uiINgDZZffaDYLp6BDGiKfgmTHCPf2
 Kj+sBxOENCDk7pB+lPuT531wqEnHgQoP3ySaa939XxLvmI=
X-Received: by 2002:a17:903:2c0d:b0:2c7:f5c6:c4a6 with SMTP id
 d9443c01a7336-2d0535b3b1amr33657505ad.7.1785599318082; 
 Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:48:37 -0700 (PDT)
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
Subject: [PATCH v5 05/16] block: move bvec init into __bio_clone
Date: Sat,  1 Aug 2026 16:46:17 +0100
Message-ID: <6ecfe8f9b1c6bfb8665fba7daf55d9ad7a8a3243.1785596451.git.asml.silence@gmail.com>
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

Consolidate bi_io_vec assignment for cloning in __bio_clone to keep any
further changes in one place.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4074a0496b93..00f99d03ac91 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,6 +860,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -902,8 +903,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -923,7 +922,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.54.0

