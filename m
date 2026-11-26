Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6C606A684
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2ZsT1LY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CA011227B;
	Thu, 26 Nov 2026 10:07:54 +0000 (UTC)
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502C5112284
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:07:47 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=GI1XpP+ljsyfP43UHLv7NCLXQmakxhCuFxYt4ZNGCiQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795687665; v=1; x=1796292465;
 b=q2ZsT1LYL7XNWQlSSK245hDe30mzFMYXHMpjfIFgyJKLOOdn7rfuNq7K2u2B01yqAx+su3Zo
 2gsrnYb6Qp0Z+NE2EwidQ/OutEvG7gnh1Zof7AhYCaS5RnUFBOJabmLvAxvr461VWbcupMUMxXW
 0BU0HA/NoGaLUfCueUC0jG7E=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 2480f8a893a63f48;
 Thu, 26 Nov 2026 10:07:44 +0000
X-Mizu-Trace-ID: 2480f8a893a63f48
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: arsenova@a7snv.com
Cc: adilger.kernel@dilger.ca, anuj1072538@gmail.com, anuj20.g@samsung.com,
 asml.silence@gmail.com, axboe@kernel.dk, brauner@kernel.org,
 christian.koenig@amd.com, corbet@lwn.net, djbw@kernel.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jack@suse.cz,
 libaokun@linux.alibaba.com, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-xfs@vger.kernel.org, liwang@kylinos.cn, mcgrof@kernel.org,
 mengmeng.zhao@linux.dev, nj.shetty@samsung.com, nvdimm@lists.linux.dev,
 ojaswin@linux.ibm.com, phasta@kernel.org, rdunlap@infradead.org,
 ritesh.list@gmail.com, skhan@linuxfoundation.org, sumit.semwal@linaro.org,
 tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org,
 yi.zhang@huawei.com, zhaomengmeng@kylinos.cn
Subject: [RFC PATCH v3 2/8] iomap: add dma-buf direct I/O guards
Date: Thu, 26 Nov 2026 18:07:21 +0800
Message-ID: <20261126100721.313677-1-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125171600.4053585-1-arsenova@a7snv.com>
References: <20261125171600.4053585-1-arsenova@a7snv.com>
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

From: Nitesh Shetty <nj.shetty@samsung.com>

Direct I/O copies data from the CPU in four places, zero-filling
holes, inline data, bounce pages and integrity metadata. A dma-buf
iterator has no pages behind it, so refuse it there.

Reads that encounter a hole or unwritten extent before i_size
therefore return -EOPNOTSUPP for the entire operation, even if I/O
for an earlier mapped extent was already submitted.

Holes that start at or beyond i_size are stepped over since reads
are truncated to i_size before completion.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Co-developed-by: Yun Wang <arsenova@a7snv.com>
Signed-off-by: Yun Wang <arsenova@a7snv.com>
Reviewed-by: Li Wang <liwang@kylinos.cn>
[Mengmeng Zhao: remove the registration helper and fold in
Yun Wang's past-EOF step-over fix]
Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
---
 fs/iomap/direct-io.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ad041ac3252a..de07a4efcbf7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -425,6 +425,11 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	unsigned int alignment;
 	ssize_t ret = 0;
 
+	/* integrity metadata is generated from the data pages */
+	if (iov_iter_is_dmabuf_map(dio->submit.iter) &&
+	    (iomap->flags & IOMAP_F_INTEGRITY))
+		return -EOPNOTSUPP;
+
 	/*
 	 * File systems that write out of place and always allocate new blocks
 	 * need each bio to be block aligned as that's the unit of allocation.
@@ -589,7 +594,24 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 
 static int iomap_dio_hole_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 {
-	loff_t copied = iov_iter_zero(iomap_length(iter), dio->submit.iter);
+	loff_t copied;
+
+	if (iov_iter_is_dmabuf_map(dio->submit.iter)) {
+		u64 length = iomap_length(iter);
+
+		/* zero-filling walks the data pages */
+		if (iter->pos < dio->i_size)
+			return -EOPNOTSUPP;
+		/*
+		 * Past EOF there is nothing to zero: the read is truncated to
+		 * i_size before it is reported, so step over the hole.
+		 */
+		iov_iter_advance(dio->submit.iter, length);
+		dio->size += length;
+		return iomap_iter_advance(iter, length);
+	}
+
+	copied = iov_iter_zero(iomap_length(iter), dio->submit.iter);
 
 	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED) {
 		loff_t aligned_copied = round_down(copied,
@@ -619,6 +641,10 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	loff_t pos = iomi->pos;
 	u64 copied;
 
+	/* inline data is copied from the CPU */
+	if (iov_iter_is_dmabuf_map(iter))
+		return -EOPNOTSUPP;
+
 	if (WARN_ON_ONCE(!inline_data))
 		return -EIO;
 
@@ -717,6 +743,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (!iomi.len)
 		return NULL;
 
+	/* bouncing copies the data from the CPU */
+	if (iov_iter_is_dmabuf_map(iter) && (dio_flags & IOMAP_DIO_BOUNCE))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	dio = kmalloc_obj(*dio);
 	if (!dio)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0

