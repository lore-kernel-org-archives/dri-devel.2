Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E638606EE30
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LRZULkw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B91A10E690;
	Fri, 13 Nov 2026 07:14:04 +0000 (UTC)
Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44B710E690
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:13:58 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=wlo9vUd47ggH1TaP4OgfLMAqjSMe1zHTjJ3E73DhNZo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794554037; v=1; x=1795158837;
 b=LRZULkw5Ua4B9igcXyL1JSWbQOyf5mo52EHNIrlY490C1JkAJXS56KAYOHaZm4TMk8f7BJzM
 YAZVUiKX50Xchn+WCwwoqtyWHIMptVjo9gJ14QtXuhzzQ8/VB6YBmfcGpLAwoUi4lRxZzMAj6h2
 2a05N3zgcG+R8BOjsVavi9uU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c98b5bb3fe46bebc;
 Fri, 13 Nov 2026 07:07:52 +0000
X-Mizu-Trace-ID: c98b5bb3fe46bebc
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj1072538@gmail.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com,
 Philipp Stanner <phasta@kernel.org>, Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, asml.silence@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Li Wang <liwang@kylinos.cn>, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: [RFC PATCH v2 4/8] blk-mq: factor out a dma-buf bio refusal helper
Date: Fri, 13 Nov 2026 15:06:17 +0800
Message-ID: <20261113070621.273953-5-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>

Move the dma-buf integrity check out of blk_mq_submit_bio() into
bio_dmabuf_should_reject(), so that such checks have one place to grow.

No functional change.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 block/blk-mq.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ae22d556540..887d5cc5bb5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3099,6 +3099,20 @@ static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
 	return false;
 }
 
+/*
+ * A dma-buf bio carries a driver-private map instead of pages, so the block
+ * layer cannot generate or verify integrity metadata for it.  Only reject when
+ * it would have to do that itself, not if the submitter attached its own
+ * payload or if generation or verification is turned off for the device.
+ */
+static bool bio_dmabuf_should_reject(struct bio *bio)
+{
+	if (!op_is_dmabuf(bio->bi_opf))
+		return false;
+	return bdev_has_integrity_csum(bio->bi_bdev) &&
+	       (bio_integrity_action(bio) & BI_ACT_CHECK);
+}
+
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -3160,15 +3174,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
 	}
 
-	/*
-	 * The block layer cannot generate or verify PI for a dma-buf bio, as
-	 * that walks the data pages.  Only fail the bio if it needs that, not
-	 * if the submitter attached its own integrity payload or if PI
-	 * generation or verification is turned off for the device.
-	 */
-	if (unlikely(op_is_dmabuf(bio->bi_opf) &&
-		     bdev_has_integrity_csum(bio->bi_bdev) &&
-		     (bio_integrity_action(bio) & BI_ACT_CHECK))) {
+	if (unlikely(bio_dmabuf_should_reject(bio))) {
 		bio_endio_status(bio, BLK_STS_NOTSUPP);
 		goto queue_exit;
 	}
-- 
2.43.0

