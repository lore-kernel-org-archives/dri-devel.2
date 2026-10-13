Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD5DCC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7737010F9A5;
	Tue, 13 Oct 2026 20:55:27 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A478F10F9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:21 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so27772195e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924920; x=1792529720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=h+S8L2xBNrnr0YT78RImM94QxCqZy4qPShHWWmuaJjz5IJBOG5zGHEUIKGIvlX3nf0
 i/zPFsCqxJOH0QPyYBf0QmcYiHa0DbsrAKbWxlcAcvrrMCTwu8HCUZlOG166CzRdTX7m
 S7pjWSrGXJoNumI9AaASqZ1vqIuCQygBwfr+FsQuvkX+EJY/RvUkinGGYZZRr3JPuP4u
 CJrJgcrZCr8Vhb6oa3Ze/kvj/eQt8LrW++iGzx1YQLEgArqqJRTaLMsUxO4uE5sQGmvG
 wcWkn9+XmQtyfEabrgj2AjrxqxXm3Eur9Fp/BiIGSZlRrMDdYTfNzMPeKSGm7hi0lvXd
 ukCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924920; x=1792529720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=rR2GoF8MD842U4HnI5z+rruFXjSNXXEXkgO6+Kr5USK/KU+5iyK+ZH0s4Xi1tEHLZR
 ObwAJoon2qME6KOQsfy4rVRDvsd4EQCWgSg+Kic372gFSM1gyUj9OkuEr3XzgBIof992
 q+HIddgQilA3sn/uJGy2zJ9zfLRVu9YlhXpbbfelYefYMbIFTbgJ3eocdAOVngs8epbO
 grHqKQYdTzFxP4qSQutA7oQxC9TfeA/jHCms94Sf5tC8qxfA9zvbmW7SOg5uTDDfANbc
 sPZfmC2oRvhwbW7rujDN9ceEBJQSwHTRDdP9F3d41zZ8izMPFp1hkJ8Z373aB13vdvMO
 Kd6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtaNjUBUyG8cv/7A1fB96veApp5hoRtkIj/o7GJf+pQbMAvXQb9X0hxwUrNhdRljSF+kHCszPzpBA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJp0ETX3wDzMX/uOUg1hYnPnt8Bs2rBjESust8aBFEQjjG7F7xM
 ljdcOqxE/CMoL+fUbmfZAu17izmVsyCDIV07FQoUe4WU5OxU+3daSJ4J
X-Gm-Gg: AYBFou2CsXxYwG3IIHwztgFZBdW0D2732D55+cePVOS9E2Xau1OkhoU3XTaO2y7R8wF
 r5lMjcmKLw2/xib0RUrXJRPbkku9NmJr2yNhL1KDBisNMZd7KsYBzLCh94tKZCQ6RdJSAvTciQ0
 lMcGAPF0DUjXJ82HXyDIyRrn6RBRXiXuU0GJZuxU7GuNFIqs20vwsK/V46qPhcwsXcwp1//qKes
 W36qK+VKW6VF2cabqCoFBc+qkVJwwR+EdfkSl3W/DnvFmn0+WxFWIgPiIWyKXon2vSt0L1BXefD
 LLLXBKmoOo136FCktn49YW3uQD+zRTglpUspSpgK0vXCRUCvUvb4PE8NB7eFsjWlcJNkyvWrKh1
 p4wJzosVHRvtT2G4dCERITDNXOUtTsk5HghUu13pJPkItnAJ+sP7IeCgr6hSGEOxw8P8hpchPfn
 IczVotONBgqC9APFYscuowqG+g6EF3CU6LyK+c6jvr8Y89eGZxCMJLXizI9Vi5SSY1VUl2jueDN
 R2MsjWRnTJU+JcU3KHzpkavqKSDcaXgPl67sydRZR6AJEt+txL1aHHew60AGqCGma277rmZUV4U
X-Received: by 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id
 5b1f17b1804b1-4a18e446880mr243665015e9.3.1791924919983; 
 Tue, 13 Oct 2026 13:55:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:18 -0700 (PDT)
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
Subject: [PATCH v10 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Tue, 13 Oct 2026 21:54:47 +0100
Message-ID: <007fe19ad4e949ec70ee74ef5cb05774656c62e2.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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

