Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D743CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7473410FD06;
	Wed, 14 Oct 2026 11:02:32 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2866610E98E
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:26 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so31348595e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975744; x=1792580544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=E+VYgapy0f5YtVCziZlMgtqFUiT3maaP5KCccQ3rHYkNq0Z3XZECqByY1h70ekZLRC
 gbCKKvj1gYMcgtBNoXYad+fbukNk+2aESPgANX75EsaIr7VDSmLfEFJe1QIKpIz9oSa+
 Qg5LuTz4MH8zLoUWd5dZe/vVg7/yiReBmqTUHFee6A3zEwP3pyzhBt8Sf/SrlSOUHeQ0
 5jyeImXKRBWx09M0ZCPDo/89kPfGXPsbeA22RjIPHzrqrqnQ6A+ordC6ulIT0bUxKU8G
 FpPxNJYkh6xiIWJPOYgD49o8cADYjnnlzb/8kZMcNDA+H11MXEIOGmIvKdojNmp1mwEG
 ke+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975744; x=1792580544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=f/B69YtG3IomchZ3UG0vEBWSt7hrocBvC8kObmH1g9KhxKHXA7tOe4OuZTpyjLMHIN
 y3roNik/G2tG9t8lfYnkw8/BGDMwROKhx2dnsXCGMQrPwSe/0n4Dx8k4nf0zvPfts7vb
 hSd0jr6IopOfdyXOlA94r1yFP37lWLZX9DJby/YPD8yQYt1JCifqN05zqxCdk49Dd6yU
 YKIzurhj29FXg+WFrLeLUbsHIcCfQmNgBoosbwZ7JKVj2AfIvvj7bmF+Bx8IXzTdS6Sz
 i87yCA8FbujYdi1MSR+jP4c6SfRRXq6SRLjgbtGGnjxBjcn9cqh2a74hfGIzQCyWiW93
 N87Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTYNizahsjtCTaOO3KvJZRC45a0i/GXVwzcNvcsSUGihuSjz3uDZCW8paluRalPx+szpzYOWgEeuI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKDewxNBVF38/hF+f5mr2/8Z+jj1bzL6/5Idw9acf5pxXOLOKhS
 kNLOAUoF5OJRxJjTT9RyMS5P0HMaCrPsUjx7abn9o5VB+JnBp9evjYet
X-Gm-Gg: AYBFou1TE3N3ChFY6ZYTOUXXfD9211MRoyH7rEB8HYxUHsmoKIMSmEUimbZUKaqFtBl
 Dqy/0s+p4ui2IouNDCpz2yDeDb2nWdptwlKnuyhcZHmXBPbvO+I4CbXDU7HPLuNPLK93dT4v3dA
 5raDrnW1ylu0fd/3SLB+NVfUwqG+J9X+robVlwegU2MGcPPUE+uscbcz/srVND48/lSWMs4C72J
 RxdjaLxUdN9/X5TqI08owlBIbHoxiMj47RZqR8eC8BKyffTL6OL1pZeyeEckR6YmVRGvUiKauOB
 QNWucSPl0LCgfhplo9dGQd7SiMOn/jl8tF6JR6pRG+JPDP5e9DJJxkuTlF2Rddw98WfpVMLdhS8
 7aM7EJQO05+FoYn2qCERyHQeWwiioYbqZEJKpcQnnAx8ow3OJMhBAgbJOv9PMkgF6YwzAbg9r08
 MogQOSk8HveywJhrwp3LOb7pF4vkK0KPlElD78h1US2wG7WMoUEFVaNebSpywv0LcffBxGZ4GkW
 p4Ro8bUXG/RqFRMqD14MAkgIEejNJCK9PJ5m1hCLfH1M18vY5d4vVrY4DA5V0kp57AFnjSPFeQe
 ew==
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id
 5b1f17b1804b1-4a18e49c331mr307406695e9.14.1791975744203; 
 Wed, 14 Oct 2026 04:02:24 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:23 -0700 (PDT)
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
Subject: [PATCH v11 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed, 14 Oct 2026 12:02:01 +0100
Message-ID: <8e5a67c2f84b6df99ff57a7b3bf7b289999e0468.1791975048.git.asml.silence@gmail.com>
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

