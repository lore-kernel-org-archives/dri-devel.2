Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0522606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UZc54iDG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30765112D43;
	Fri,  6 Nov 2026 13:25:51 +0000 (UTC)
Received: from mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C86112D43
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:25:44 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=55Gu1BuWJQRvJsCcgFgbtSGQhBxGx47gTgITgbn0eiI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971543; v=1; x=1794576343;
 b=UZc54iDGmGz8csSAUXIYGu0XBUJnBivbI1Mx9SdtrcgYQicToH3DiM/zuDUXEoNK/02hk473
 SzivAlXdYOSUWKKJx5A1d3IZAlbUCiUNhC0bw071hsKBKZG5/p1ME63KD1YH8EtArm24zRScGIO
 n66LMEbJN1mlSKpS4hRy4xBY=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 2231816b5623e6c8;
 Fri, 06 Nov 2026 13:19:38 +0000
X-Mizu-Trace-ID: 2231816b5623e6c8
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
Subject: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
Date: Fri,  6 Nov 2026 21:18:24 +0800
Message-ID: <20261106131829.3228926-3-cui.tao@linux.dev>
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

udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
data pages keep the accounting of the memfd they were instantiated in,
but the bookkeeping around them does not: the page pointer array and
the pinned_folios array, both sized by the buffer page count, plus the
transient folios array sized by the memfd folio count, are plain
GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
memory, and size_limit_mb defaults to INT_MAX.

Charge the three kvmalloc allocations so the creator pays for the
metadata it induces.  The system heap in the same subsystem already
accounts its buffer allocation; the data pages here stay with the
memfd.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/dma-buf/udmabuf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd0046242..40182c82df6b 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,11 +190,12 @@ static void unpin_all_folios(struct udmabuf *ubuf)
 
 static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
+	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt, GFP_KERNEL_ACCOUNT);
 	if (!ubuf->pages)
 		return -ENOMEM;
 
-	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
+	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt,
+					    GFP_KERNEL_ACCOUNT);
 	if (!ubuf->pinned_folios)
 		return -ENOMEM;
 
@@ -387,7 +388,7 @@ static long udmabuf_create(struct miscdevice *device,
 	if (ret)
 		goto err;
 
-	folios = kvmalloc_objs(*folios, max_nr_folios);
+	folios = kvmalloc_objs(*folios, max_nr_folios, GFP_KERNEL_ACCOUNT);
 	if (!folios) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.43.0

