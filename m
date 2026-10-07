Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9017DCA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D529A10E350;
	Wed,  7 Oct 2026 01:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BH93QKgU";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BEA10E1F1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:15 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso15399035e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336734; x=1791941534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=BH93QKgUxpnaUxu7mi9eaqWP/RY4C4iYN032GAfCp25F+oYKRAyLwkzwYgdCxPAEIO
 fo/1VVDHI789ufr9ofFnddP4jumfIhGfOiBZ/qpbxdFqLonVLVUk/0Cz2op9kABxaAAF
 4xex12gNUi8LmEn0ze9T8aRtCQEaXQiHM5sJ7JP9Grb2Ck9Y09DMxmxr3jMFIVE6MqKM
 0FMV6Lw4iw9ZFbF4FRmARliyH9woYKqqfxl/2XaRI0b6byRkddGxwOOIm+3I42P5pZWL
 QtkKbbW8zP47gAy5O7gjixuzw9GiK5M0+84J3JT1ZS76yr7UKpSis15IawaJDAJSq13B
 sEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336734; x=1791941534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
 b=jQV0Q5GM+sxqaVVhjzQhNTCcvhz65T+k3hDWOKwpqJc5B2mFtDKRDfoa2acbvSzGzo
 Fac/+qLZ1TRaf0Vyhid+JHhXviwg1ojpHA1B5jRpV8xShHvGXki+UdkRUBGWvmN5lBkA
 vIpLH8wt7d5HQPO0yME50mcKqqNTQzDIn9n/bVrocMFk7upSBiWRhFKBeSumSPup02N6
 Ihs5kizvvT4QGe9fWnv4//eE7H1QctHVNFe1uHSTn7OViTlXNMh2PycsWlW2LuVOVI1i
 aE6oCnfENFDjGMsQxJHPDVaFRMQTE2xn/A05I7DlazFMMHVSEca3h/AEcSZOP7Gg/aWs
 6vEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZttWYe79nc8D9qSyvJC9Os7fgmVD+lWZKSTwgBn25A+GckABfwR4Hd3QPBZQ3GZm0uABSB9JRCsI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nC5PMlL/1CkNkT7FlFmIlcgr9Ne/6TTUa0TT/CiITieoQZJSm/
 I212OGkYt1bDbzM4BcxZStERXtTCS4HDPYjY6yWniMu+hHJdo106JDG/
X-Gm-Gg: AYBFou2wIuKfE2qkjDVNzK87rh839ZM80T79W/UHq8nEXEVF/eGSmpX2e6CAcfI+ihZ
 ZlcRCfMSIDnc28oicpM6yx6qkg1TMIQwtOkFx7QqZpAbp//Gh70S5+DAgAXOmx8TA3TWwZ17drw
 m5CTVGw3QmtBHlaDweZyhdONlzXUAeglHzQcXX0sM+/blP6qE0QgJ/cFEMTXboUMeMIPXNkDqPg
 5IFD3caoO0jvB4kxPWQBR0A3WwtaE3dkYbRlCFKFvqXU5ZlYuxfv3xSeLEc3gE+IXQ0eKK5IZTp
 SedGepapV1/NRDk5y1A5hCIwJrQbMnohZf5hyheHK+zxRzxtHzmRhQYEwYjxVUDS+Wi7s8LC8Ib
 LxxbBhuxXmrWwIxoNnEvrR3P8LKeDh7zXRaOGC/06khPkSl6H99Xxkt7nhWKB8jEGcHziRgHlyM
 NhNgTiUv1p690fsq+xIla99ZwktJJM1JnJ3iL6F88em5fcLorEnPly9iZWmUFZzda9hiW/rS7jx
 bHJwCQ4onKYb1JGZIPGCmDoz2fdgt9hEEzeYEjDRPlIifX7G3x6C5Id+WyCgP0tfVn/jWOv7A8/
 PUARu786hgY=
X-Received: by 2002:a05:600c:810c:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a180422b6fmr8623225e9.8.1791336734141; 
 Tue, 06 Oct 2026 18:32:14 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:13 -0700 (PDT)
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
Subject: [PATCH v8 01/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed,  7 Oct 2026 02:31:44 +0100
Message-ID: <beec7303891dac21cd620d2a47842f843b391192.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
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

