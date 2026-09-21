Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D95C982F0
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B003E10E737;
	Mon, 21 Sep 2026 13:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aIjujm3B";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237D910E729
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:32 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so14023475e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997970; x=1790602770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=aIjujm3Bu3/GnWY3JmYByHHl9uuIj4y8nz4kC1hYe/8TClh9kVlwIiDppfrFrUy9Wo
 Pyd6SV2Hv2G4CrO9dPI8geDv2qst/ePryJ6yEWIwIBp9Br9GBEIKs89I4yQjL6OyfL7N
 Ico47LTou/7C5h4BnA+T8KIlfNFAOa9idDgl5gC11QNRW7vfD67165IsmQCTkmBHNmC0
 0PbSDXXXPa2cid2iNcxLTN1KRkPllX/ZfqM6UJoQ2TgaAn0dvXDGKQ8Qf1YdxLKB2dN5
 QdecrIdmxgTcvM8lm2yUjLbPMB5emCL+InME8TkQoc+RrBvVFOzARaw+8tM8cUEnSyD9
 oi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997970; x=1790602770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=iuYjVtds9Cn6zZXxTJd01CIHZZF10wLqxA2OitIsRxuH1yqqj+AudOJSI1kK+kkugw
 e1ZmOBY99vNVwCnLbpTR3DCdEX+909kmzPBV7UAOMptHlEyO7wVl4yNeA0OCaB5T73ls
 zJuJcA+bVjIFfwJz5mjMUTAVUtfpgHsTtbO1cS28y5shK0FS133NJJf+UQ+eCjt1oxG4
 X7Oti4TwILmRaUg04vfEJVHITIGowFPpK8ZUAHLeyoL8XMgbERAGZWu5jSqn+LT5GP+D
 1WaK/O4OfQvsnrmO+WsOVS2HaergSWZqeTiNTE9DP0cEQlm8HAQlWWEth9ZMd+5L3Wsa
 VkJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP3OunpQRXazW0I3d7+gX6lK8orQcVCesy85gNtGBfM8IgCzuIkzC9FfxAOHPFFLGosm97uvda7yg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgL3b85sAVyKR9cmN6fKiB4GIQ42FTL4jHH8XNqBnYQz+dGuaL
 5mthlAG31IAhGyFp7iKnlyqxzzTVWe0Dl6LPKY7g3J4A910M4ALjyOQK
X-Gm-Gg: AYBFou2LMU+lA+1EAiIqTteiykydlwrrOzC34wEtmvi69tbGraRr1KYOIii61cegusd
 4uSY2F+MyJII8RMLCS9idmZ++GaUKlxNKdXplYzYQeuMayzcTkZ9Kzta1sW7jHGCyWa03YzRXL/
 Sd0wnVZPYgPxhWnIwDHtV9WJj6hhj2r2TxTpjPYNi/fHphxBPLzcVEm/I64XgKrz2nuMHABNic0
 r1yq7ADhYZZ+njBVgVMBJ3s8JOdlp/nsis+Huoip8m5yfcYkqrSRbYjfMt6V9kux5tJZRiSEJVM
 whELkw6P7VJkXoNu0aVkyl4pwbS9cgu5V6PcRajzPXpMRhhVJAQaB95tXpt3AdBYoYS4gCUhAGY
 2qfaYfehaZvWmEgqj1+Om7ju963odw2jLYrFSNp2lqqcTl1z12oYRrlR9gFzucGCW9Vv2dNTzoG
 ybKnx9k+WVsOzQU7aT6xJ3dLgRolhRHChGifamzygh2pkW/PuSGkS7Nh5PxmB6FBNrduVU9q2ZD
 lynljBK1QSFOYL3EvRaIiqBicjN3Tc3UCLodaeCIeKMjIRBV6GB50i/M3uQ7qf7GPC5sGcZdltv
 r5H4j80PPDwXlAx8mjyyW7ENxcqZUg==
X-Received: by 2002:a05:600c:c0c3:10b0:49e:823a:9dec with SMTP id
 5b1f17b1804b1-49fc5a10b5fmr145292005e9.3.1789997970323; 
 Mon, 21 Sep 2026 06:39:30 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:29 -0700 (PDT)
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
 Phil Cayton <phil.cayton@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v6 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Mon, 21 Sep 2026 14:38:47 +0100
Message-ID: <f3c6132b313e7bc6e237e1a16ae8750be5988a40.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 17944e44b584..892ca469c570 100644
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

