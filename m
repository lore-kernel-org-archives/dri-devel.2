Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F97FF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEE710F09B;
	Wed, 29 Apr 2026 15:26:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pmUNoIP0";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8246B10F07E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-446fea16729so1612768f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476393; x=1778081193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
 b=pmUNoIP0E67vcdd9/VdbDYOricsCYDgupE8l4ZsAA0buowphmIMK6Da+qQ8dXCmEQA
 fNXiBEdG9uO4RCGEXxyQvadnymEWV99A0ySQjobfxvriupzrm+BObJvkg6oDTJUtKwZT
 iyd5PfdLmVJaTheGfocNdUg14hXjvqEnzUSUOzseFBe+kybiUB4dhTvUyUKXIQM7Dh1i
 E4uXRziChihwwNR+gN2JDpQEeJFRX2iULxyrJfVE5a5wSA3B/+8q18Pfs0Di04itBE/A
 CyJcTL0e1G6O61KkIq0CzQ0QSzdWHyoD5Pc2exm4/bmUiPgyXtxpMzxcJWi8vlrmdczL
 6I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476393; x=1778081193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
 b=GM4aBBZwED1bqY9rh1/RB57jPCM2OJUbfugFkH3mfAqZ6+fyKz2YmvhSUnMUtEn1eY
 Ix+fuV495PqsmguxkNhaQ+InZ0m5zJDevyBxma1bEe/6nUNv5DSDxrztLa9uDMAlWpO/
 IKAICe0gYhgA7dvgC5KXW3B2skd55NSchXHLCJNxzib6j/dfYuVeKwgnpy72c3Q4Jm9i
 v4Qkta1XMz8+rkUd4kLjFoDqZDSy7ov6oNhOD5rPMRChs3u+nivYdKikqDjt7itjYZm2
 qO/bp5hhErIJ8qayBfo51w5ICOTAnw9WVXLmDTMze/hnzaZreRVWZ/qCwsLp2GZjAiHg
 uj4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9APUW+/1fMEfMye4q1syGIBKH07jSZVNk8w5EsAOepgSwSzxLS6nTJ6Xwib9oLHnViT0uENiMGT0Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEFPGduqgQ/7PLiXNbRmh07QgyDRF9mDvLyToSRk8y53SUYbKN
 wXxza4MMKHu7RoWAC2fwxzPEhplbuyiMezpINHbQt39mu/475OpWTw3n
X-Gm-Gg: AeBDieu5dGGoD5q/Hh+v3olC6Yq/rF3WhpL3tHCOJHxgav/LzXZ29UxbLOPkgAoTyWc
 dM9AhgRpx8p4ghMqu4JeieEPx1W1LS0dmdgN4NS44r/75MD6HeG7vdZZ29BqBRCDOKC8zAblYcI
 oLNp66odChihUT0WzMNqQG71LhY4JrDJMQzdoWCm8StJeUH5Ifba08+s/fe2fdQJTf1blSilHcH
 Vvweo9NIKoKFYX7OF0R8U6Gfene0u2EfAuyPZGrITzoUJNqu5sY7JHTPx65K8/hSzCcHGmdI3JP
 jYwazpRRYo4TFA+oI0p6+fE3S+6mCqjjmrwINTiuWiaSGbYdfDQYg1Tj1Bvt1v6utI8H34wpgnn
 joQmHHjhZDG8qofqI3pLvN2acmL9rGdNDv+WHbIYtWjky+VvvqGZdykoyhuBIxYz5+VeUZiOs3p
 9yFQaj0XsNEhwm9+Z5Sggcbcq7kCpqi0mxaUKAo502o0HTj8Ul0fsigelYUOAuKySiTTsduNocx
 FxDgaj4+Tujtfc5sdLCMlpuOUdJs8Gmg3zDTB318MUx
X-Received: by 2002:a05:6000:250f:b0:43f:e41d:85f2 with SMTP id
 ffacd0b85a97d-4464839c9bcmr15101656f8f.2.1777476392719; 
 Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
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
Subject: [PATCH v3 03/10] block: move bvec init into __bio_clone
Date: Wed, 29 Apr 2026 16:25:49 +0100
Message-ID: <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
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

To quote Cristoph: "Historically __bio_clone itself does not clone the
payload, just the bio. But we got rid of the callers that want to clone
a bio but not the payload long time ago". So let's move ->bi_io_vec
assignment into __bio_clone(), so we have a single point where it's set.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d46af0cd256..0734b50d4992 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -893,8 +894,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -914,7 +913,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.53.0

