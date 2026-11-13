Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D4A606A897
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eYKG14tA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC19E10E62A;
	Fri, 13 Nov 2026 07:13:48 +0000 (UTC)
Received: from mta0.migadu.com (out-150.mta0.migadu.com [91.218.175.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3B810E62A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:13:41 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=FEKih65dVLqip/qvv/nnGzIKP8TulmlEVfQQ2ZV1WNs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794554020; v=1; x=1795158820;
 b=eYKG14tAA3C/UH8Q+5jOsZGIhVMPN7HFNO6mrr2zbHII6y6aHgXWOZEWa/s9twgVE+UeWbZM
 ymjo7G8RQq0ALenam15jiYB7PwPEZMN0O1afUwjiMj2kTGJrv13s2/Lzo/2cshmK6uVxaatR1ZH
 VojjXQNFLYanqcb9MdSZARRQ=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 399a8e2f5a148472;
 Fri, 13 Nov 2026 07:07:35 +0000
X-Mizu-Trace-ID: 399a8e2f5a148472
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
Subject: [RFC PATCH v2 3/8] iomap: don't ask for a buffered fallback for
 dma-buf iterators
Date: Fri, 13 Nov 2026 15:06:16 +0800
Message-ID: <20261113070621.273953-4-mengmeng.zhao@linux.dev>
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

-ENOTBLK tells the caller to retry with buffered I/O.  A dma-buf iterator
has no pages to copy, so the callers refuse that fallback, which would
turn the error into a successful transfer of zero bytes.

Report the reason instead: a busy folio becomes -EAGAIN, which the caller
can retry, any other invalidation failure keeps its error code, and
-ENOTBLK from ->iomap_begin() becomes -EOPNOTSUPP when nothing was
transferred.  A partial direct I/O still reports its progress.  Both
branches are reachable only through a file that opted into dma-buf I/O,
which ext4 does in the last patch.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 .../filesystems/iomap/operations.rst          |  3 +++
 fs/iomap/direct-io.c                          | 20 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index da982ca7e413..ca59716d225c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,9 @@ Return Values
    cache before issuing the I/O to storage.
    The ``->iomap_begin`` or ``->iomap_end`` functions may also return
    this value.
+   A dma-buf iterator cannot fall back to buffered I/O, so it gets
+   ``-EAGAIN`` when the failure is retryable and ``-EOPNOTSUPP`` when no
+   data could be transferred.
 
  * ``-EIOCBQUEUED``: The asynchronous direct I/O request has been
    queued and will be completed separately.
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4a2b0f9df5a7..83fda6973bb9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -706,7 +706,9 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
  * completing partial requests asynchronously.
  *
  * Returns -ENOTBLK In case of a page invalidation invalidation failure for
- * writes.  The callers needs to fall back to buffered I/O in this case.
+ * writes.  The callers needs to fall back to buffered I/O in this case.  A
+ * dma-buf iterator cannot use that fallback, so it gets -EAGAIN when the
+ * failure is retryable and -EOPNOTSUPP when nothing was transferred.
  */
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
@@ -806,7 +808,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
-		 * buffered I/O.
+		 * buffered I/O unless the iterator cannot be handled there.
 		 */
 		ret = kiocb_invalidate_pages(iocb, iomi.len);
 		if (ret) {
@@ -820,6 +822,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 					 * the caller tries again.
 					 */
 					ret = -EAGAIN;
+				} else if (iov_iter_is_dmabuf_map(iter)) {
+					/*
+					 * A dma-buf iterator has no buffered
+					 * fallback, so -ENOTBLK would hide the
+					 * real failure.  A busy folio is retryable.
+					 */
+					if (ret == -EBUSY)
+						ret = -EAGAIN;
 				} else {
 					/* fall back to buffered write */
 					ret = -ENOTBLK;
@@ -867,6 +877,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret == -ENOTBLK) {
 		wait_for_completion = true;
 		ret = 0;
+		/*
+		 * A dma-buf iterator cannot use that fallback.  Anything
+		 * already transferred is still reported as a short I/O.
+		 */
+		if (!dio->size && iov_iter_is_dmabuf_map(iter))
+			ret = -EOPNOTSUPP;
 	}
 	if (ret < 0)
 		iomap_dio_set_error(dio, ret);
-- 
2.43.0

