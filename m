Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F187606A331
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RhSpFLOX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9937010EA35;
	Fri,  6 Nov 2026 13:26:54 +0000 (UTC)
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0511810EA4C
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:26:48 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ojgBXCCljWWMx/by6O5nBZ1cYADUOJnAnHqRvmqKFno=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971607; v=1; x=1794576407;
 b=RhSpFLOXLObPYfOZQizN/gUVaieND1gF8il/wL44FULXzU6xQgZ1CEaCqDf0xtyhdrnS5YOV
 fhLMVB6HjXgwd4PBzZ5RROoU60te8y81kQbD/7CaUZx+Dy61yP7A19mS2FG3Kto8yPtCIhhukbj
 B092ZGe2PRc/VpSxHHXvPZ6Q=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id fd2f547758ebbf7f;
 Fri, 06 Nov 2026 13:20:43 +0000
X-Mizu-Trace-ID: fd2f547758ebbf7f
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
Subject: [PATCH 6/7] io_uring: account the ring context and SQPOLL thread data
 to memcg
Date: Fri,  6 Nov 2026 21:18:28 +0800
Message-ID: <20261106131829.3228926-7-cui.tao@linux.dev>
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

The io_ring_ctx and the SQPOLL io_sqd are the last per-ring allocations
made with plain GFP_KERNEL.  The larger surfaces around them are
already charged: io_mapped_ubuf and io_rsrc_node since commit
075d5837bafc ("io_uring/rsrc: charge buffer arrays and nodes to memcg"),
the tctx node and its XArrays since commit 0b34e7b20a48 ("io_uring:
charge tctx nodes and personalities").

Charge the context and the SQPOLL thread data the same way.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 io_uring/io_uring.c | 2 +-
 io_uring/rsrc.c     | 3 ++-
 io_uring/sqpoll.c   | 2 +-
 io_uring/tctx.c     | 4 ++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 03724419c4e1..d39cdde49a9f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -229,7 +229,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	int hash_bits;
 	bool ret;
 
-	ctx = kzalloc_obj(*ctx);
+	ctx = kzalloc_obj(*ctx, GFP_KERNEL_ACCOUNT);
 	if (!ctx)
 		return NULL;
 
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index e0345c3e764e..9a971c983686 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -825,7 +825,8 @@ static bool io_coalesce_buffer(struct page ***pages, int *nr_pages,
 	unsigned i, j;
 
 	/* Store head pages only*/
-	new_array = kvmalloc_objs(struct page *, nr_folios);
+	new_array = kvmalloc_objs(struct page *, nr_folios,
+				  GFP_KERNEL_ACCOUNT);
 	if (!new_array)
 		return false;
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index d387488db2de..b82d3a285337 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -172,7 +172,7 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p,
 			return sqd;
 	}
 
-	sqd = kzalloc_obj(*sqd);
+	sqd = kzalloc_obj(*sqd, GFP_KERNEL_ACCOUNT);
 	if (!sqd)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index b4fecea3ea47..6673393100ec 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -23,7 +23,7 @@ static struct io_wq *io_init_wq_offload(struct io_ring_ctx *ctx,
 	mutex_lock(&ctx->uring_lock);
 	hash = ctx->hash_map;
 	if (!hash) {
-		hash = kzalloc_obj(*hash);
+		hash = kzalloc_obj(*hash, GFP_KERNEL_ACCOUNT);
 		if (!hash) {
 			mutex_unlock(&ctx->uring_lock);
 			return ERR_PTR(-ENOMEM);
@@ -85,7 +85,7 @@ __cold struct io_uring_task *io_uring_alloc_task_context(struct task_struct *tas
 	struct io_uring_task *tctx;
 	int ret;
 
-	tctx = kzalloc_obj(*tctx);
+	tctx = kzalloc_obj(*tctx, GFP_KERNEL_ACCOUNT);
 	if (unlikely(!tctx))
 		return ERR_PTR(-ENOMEM);
 
-- 
2.43.0

