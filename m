Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB19C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC71B10E33D;
	Sat,  1 Aug 2026 15:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JDRe+k7z";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C2410E33C
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:48:17 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cace91f112so21799345ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599297; x=1786204097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
 b=JDRe+k7zHHQlKwlfPxcKwhnWfBM/T4OJCnhjeM+/q60MoX3O5M9sIISSYD1PZCdDvA
 LdKqxRaVZyKCpX6uwR7Dm6AA4ljBfpxBbKOqtZGqz1T1/z9XlOe3diw9CYHJAxCa4mZv
 Q5HK47021xYPvZQASAegJnMIhkV40M5NJnu97BgxJoZcPgymXYQxcK0MhD1moIPtuEbt
 RvVrIHqrhcayoJHXxHXTw1frLcSoNRN7KNXqlSTjXWaIstbrN+yQEfXUuyqP3xrPfgTG
 PLuyFRDm8bipF1X3ltwmESTHMA9fOKvnc7XsCp0i/TDObtZqXyNaoOmT+sFg67A1Mc5X
 0Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599297; x=1786204097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0GcIDTsY2CDASlyPqk465WOkbyFB/dgtSdtycnJJZM=;
 b=HWbnHlttjVmZdFvf0DQuShhplpkOPuBK7ceZw3nlUGMy+QcOU2Abfgn3Ah8SKHPpKf
 JnF4hlX+8l2DHY+Fi4vMU09Ri6N4PHT7uf4IKTEMpGvcRJblfF0FU1XR2Pkj4HcNJfII
 Yk/zMr9LmRX08YeYzVbhS8O8E5BJReE6WIx3bB/uyvfiKwW5cUKYi7bjVwddNqUDgg/x
 kT3/lYyOJiCWklVAtdhdFbIQmSVQbzKKd4uIzSdh4VLYvoc5hOnP2GbQAYAMJRTzcIty
 4TMs4xy3wpc7PNaZCjePavAI5sji9RV/dTMebTJ567TPRkCDnJDSAWFFuRIrML+dv/OG
 m2XA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmiS6UhsVfJpglXehsxaTKK0J6XnkUI7MEUvkHCOn1Vjg1cCBnQlpoVPkFHPKtT3F6kEuS/6ut5IE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCW4DsL7a2l7ry4MfVN7REokOy6lGG9drIGlUlXufXedPI+J+9
 HhoFNVR3Of4zVXmOuU6e3ddrgWNkZTiKkfDapZpRBm8DvlxAiYu9Cq3U
X-Gm-Gg: AR+sD12DY3Ct6WSiEC/KbLA+PjCrYuSmXotGLxJPh59VXQ9x6KlaRvF0fGcuayipsOM
 90iL5wyePLuHMeUMlJqFbUdPAabNKmxvXA54+t9ykAyK6yWyK943HlX8VrGzTX9pUZ/0WisCeNs
 q6d/gayA/M9TSCWDJYr+kU0PZhcqQvOXgi8J1omlVuNyit32zVbSK/bdiQMVwYHKCq8mGLGhuod
 8+bfi4W4nZIcvtQlyQ3gcL6JqpZuxOdfWlCb4gYu3qhNidae/7a/Ojjx7Mrh+W5vtnlr2xKfeCH
 eRmcSLAM9dYP54EiTQpjcmlq6L+XWfyQ4V2Fu7fs/HM4TqQe6FLQypl1T3ftlT7YljxKX1kFQLP
 lWtHnVw5SGzStCeFZ1NCT5BIdQyq+JD9xBVUkRAPn83FEopZuFh2WvNVN8QKb4Q+Wpesr5Nai78
 2dmFdorb4S+bjGGeLBDyMRp+ECao+agndXhUw8Xt12g6XloOakYkZLl+NQeggumtKQdX7d9eZi7
 dwn4jBSWr5kN1OSHA1KFEgjWsYZfcEdzil00PFm8IDqpUo=
X-Received: by 2002:a17:903:22c3:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2d0521bcb54mr36749555ad.2.1785599297067; 
 Sat, 01 Aug 2026 08:48:17 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:48:16 -0700 (PDT)
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
Subject: [PATCH v5 04/16] block: always adjust bi_offset on bio_advance_iter
Date: Sat,  1 Aug 2026 16:46:16 +0100
Message-ID: <64f559a1d1ac43880149de5950187beee6bc2aaf.1785596451.git.asml.silence@gmail.com>
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
index 0445ecba3b24..f9b8903c6a87 100644
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

