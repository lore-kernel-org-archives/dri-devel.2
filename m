Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5241DCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1AC10EA42;
	Mon, 28 Sep 2026 13:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/QMcGSL";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027EF10EA42
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:32:49 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so2313623f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602368; x=1791207168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
 b=S/QMcGSLiz8Oxud4sxdKThte2dl1RPMBoXFrcFC073t4ncPSe7miCyX2Xn6k01o2sL
 RE8if6/zJfs+9MakjqXYECKi8BY9AenXkuLwVIjknuRjim7RXv9TpHjZz9d9ZTS8oM5p
 mttQw8RLORVGe3D+l2vP7Qb1tzys8kLiO6nbWMVsLmDxaDjlknzKG5rbcyauPOENlrnk
 exYSSPNtkXTe2Qp/FC31+kGEVlwEzY2V9X/2xwpLHxM2lTQCE8oWEO5zO6pTG0USJJ1c
 l9Z6935nFUfGPXDIUft1SlNhv5sSrWoSmSMs6YJxDlEK53UInRTx4vaW/IGkTz+BXlCg
 /I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602368; x=1791207168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
 b=asa5sCW4iyufqNGcg61Nypevg6BvfsCypsVXkw1CzoCJJNp55YkIhG8yPt8tuf/KTj
 YXHG6om7/ZPq/ff5Sk3/LVWH6kVRuScnSdVk6VdlgjJM5OgXqYiSWbXiqBdcyeVlJnB+
 MwzgP+YN88WE977rZXm5LCyzJx/nc/vm+EkaRGGpNH/R4tC+UfqE7ueGmSolByrh/11W
 tJqEz1vpLQrgZgtVjpPpcq+MAAfU5t3Rm6IqFs3K27rYECyyau8BoVVickCMgdSHEsRO
 lvk4jziz9+oM9nhcAH3M506e/JK3hDtFTwaXpmAWNJX+8eERuyQD68Xl7yVOreOF02WG
 p4Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2K1Dd4Efjbq8UFQkbvXoV7RDhGNPQHoWLMTPTYHHne1LwvIsKhSk8hfQEYl/yDnNJCVaQbtOdZSg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK5WTftY2pHcnSJHXaYTozZUCRj7/FfuFBeILVmeUiy30E0R15J
 3Q7s0Q8r89LAZEcueUccmsxvvPqcyLz13OXIg4SeI3joFLQQ2/fHZXyB
X-Gm-Gg: AYBFou2uJ3utxTUVMlGTDQdG3EN5/nuMIXY2QrCAcVdpaX/djcHBCYjU8ofTE0OQs5n
 DBfh0S0oUYMLKreTI21VkeuMP4Y0CLIZ9ueFco5aVt3GdjKOVRv5sfgvngY/9pn17AEPTrXD83q
 LqaTJ9LfL1UW7gcOR4cixMOqA9IDhS28Dng7ZQDIvpfsdEftzuoc4moDiWauYG/CPvJyGC8xDqC
 v2YKglmfWJVWY8PIhfaRKyMjpk26hbaMFLqwQl+HxKVcPxHYFVjVcK/jccUXV/Z30HRTK1UuuHG
 buh1aYUaMpTw/U/ARTvyngLuD8sGRoXdvbgKBjTwscvu2pikd1uJFbM2IF8crDmKG0p++uOyfan
 La9LsJJlrQsU2seY/RfKQi5MNbqPMZ1RA4A+pfOL0XPknD+PfrPnIC0AVz8k/k30uraEwnrQrzk
 DDi7CkcHHbstOo11QUUSkUwNgNWC6X+EgvZYFkBFycFpPzwl9wQKnxcDAdvK0TqsAqhes6efBIs
 27DZO9GnEky7vqCyBskYO3r3Ja9ey5K+5Se/zcVDrbhI0OejKsOZFCl1UBf6Q==
X-Received: by 2002:adf:e19c:0:b0:487:11c3:b004 with SMTP id
 ffacd0b85a97d-488719760c4mr23422853f8f.52.1790602368298; 
 Mon, 28 Sep 2026 06:32:48 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:32:47 -0700 (PDT)
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
Subject: [PATCH v7 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Mon, 28 Sep 2026 14:32:19 +0100
Message-ID: <39b4cb178513b33726c8d2ee0824f7324e84828e.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
index 75f8086351c0..10ece05cbf43 100644
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

