Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD5606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ovVoMRPu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D8410EA4C;
	Fri,  6 Nov 2026 13:27:09 +0000 (UTC)
Received: from mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB3210EA4C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:27:02 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=dKQ/3LCCVbNcrSr0Tnyt8Yullo0Ku/Vkln3W2FNUdns=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971620; v=1; x=1794576420;
 b=ovVoMRPufikfF8t3AU342AFskr9QUkRkRKydE5FcGCNjk73hL6yWc7NUdcm0TobQCVJOvG3u
 cWdc9yP888j6qAmXHu6ewxbrTVjkE805urzQ/9kcRI/KFVj7Jh10ti0JMfmYJ18wHzwXgcY8hW0
 36Tcbt6W+jdZ9jtcoR7a1Ops=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 178d9492481963cf;
 Fri, 06 Nov 2026 13:20:55 +0000
X-Mizu-Trace-ID: 178d9492481963cf
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
 loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk
Cc: linux-mm@kvack.org, James.Bottomley@HansenPartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cui.tao@linux.dev, cuitao@kylinos.cn
Subject: [PATCH 7/7] io_uring: account the remaining per-object allocations to
 memcg
Date: Fri,  6 Nov 2026 21:18:29 +0800
Message-ID: <20261106131829.3228926-8-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106131829.3228926-1-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

A handful of io_uring allocations still scale with user controlled
counts on plain GFP_KERNEL: the per-ring io-wq and its workers, the
alloc cache entry arrays, the provided buffer peek and import iovec
arrays, and the registered eventfd contexts.  The tctx side is covered
by commit 0b34e7b20a48 ("io_uring: charge tctx nodes and
personalities").

Charge what is left.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 io_uring/alloc_cache.c | 3 ++-
 io_uring/eventfd.c     | 2 +-
 io_uring/io-wq.c       | 4 ++--
 io_uring/kbuf.c        | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/io_uring/alloc_cache.c b/io_uring/alloc_cache.c
index 58423888b736..f41df1878633 100644
--- a/io_uring/alloc_cache.c
+++ b/io_uring/alloc_cache.c
@@ -22,7 +22,8 @@ bool io_alloc_cache_init(struct io_alloc_cache *cache,
 			 unsigned max_nr, unsigned int size,
 			 unsigned int init_bytes)
 {
-	cache->entries = kvmalloc_array(max_nr, sizeof(void *), GFP_KERNEL);
+	cache->entries = kvmalloc_array(max_nr, sizeof(void *),
+				      GFP_KERNEL_ACCOUNT);
 	if (!cache->entries)
 		return true;
 
diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index 63fe6e5d79ba..52f5d5b85f30 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -132,7 +132,7 @@ int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (copy_from_user(&fd, fds, sizeof(*fds)))
 		return -EFAULT;
 
-	ev_fd = kmalloc_obj(*ev_fd);
+	ev_fd = kmalloc_obj(*ev_fd, GFP_KERNEL_ACCOUNT);
 	if (!ev_fd)
 		return -ENOMEM;
 
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 92df54c6f50c..98f3aa378baf 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -981,7 +981,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wq_acct *acct)
 
 	__set_current_state(TASK_RUNNING);
 
-	worker = kzalloc_obj(*worker);
+	worker = kzalloc_obj(*worker, GFP_KERNEL_ACCOUNT);
 	if (!worker) {
 fail:
 		atomic_dec(&acct->nr_running);
@@ -1358,7 +1358,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	if (WARN_ON_ONCE(!bounded))
 		return ERR_PTR(-EINVAL);
 
-	wq = kzalloc_obj(struct io_wq);
+	wq = kzalloc_obj(struct io_wq, GFP_KERNEL_ACCOUNT);
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index abf44f5dba26..bc6e552a91dd 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -288,7 +288,7 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 	 * a speculative peek operation.
 	 */
 	if (arg->mode & KBUF_MODE_EXPAND && nr_avail > nr_iovs && arg->max_len) {
-		iov = kmalloc_objs(struct iovec, nr_avail);
+		iov = kmalloc_objs(struct iovec, nr_avail, GFP_KERNEL_ACCOUNT);
 		if (unlikely(!iov))
 			return -ENOMEM;
 		arg->iovs = iov;
-- 
2.43.0

