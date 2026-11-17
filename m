Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12209606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e/laa4WZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D60610E5FD;
	Tue, 17 Nov 2026 15:54:39 +0000 (UTC)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9EF10E5FD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:54:33 +0000 (UTC)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210a12765eso13019936d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794930872; x=1795535672;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+exUxtgPdVBwoKR5r/DiwCvHxmnKqLuiNXXsjqjObOo=;
 b=e/laa4WZ1FiOUydJMK1ZpHzRNM+D2JWIXWtF08hQ1sXDZcn5ypESzzQqEI1WO/8LIo
 6F3qRL/RUxZjUY66WOyE3s7ajDoH6cWimpxlCzFEWIaZItTofQ2M9p/dwFoUgJHdL0HG
 RwScxdBnLqm4lw+ve8KR9VBRzKBUFR/xdZ+2B5gBxTzjMwFWlC1tYsj8nezZmYHp2hS6
 7mZ15ueLXLGKH6swVD3b9Ntu7D52HwopdMEckL38NYvPd2QaII/G+1q1dOrFqwvklGhh
 jnyX5OhWLUXhaxfAdsvdGcfx/s7YZojCda32VCq+FNRViGqO9mXqqaHDnx+8ulxH2kkc
 pGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930872; x=1795535672;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+exUxtgPdVBwoKR5r/DiwCvHxmnKqLuiNXXsjqjObOo=;
 b=TrdLT378jIDu4c4KvGThxX//WnYhc26RteftCs1swxHx8hSM52vF8GPdb8ejle0uD3
 4WdtrAtCKPAEcnJ1pVzoEzTaPZ+/Rp5WbGGQHUqUnFza6riJgAmnx8tYhhh54lgkAq1L
 NpUjebmBMD7yieLRmtv8m6h6r8tpWdfND8MpiNHbwMwYtA8/wTI0JTpIbB/d2m5owuU4
 blFtsX7/YW7dqt3JTQbZX1alZRVETijPJ/E9KWQyKQ5IwI86NJP8iWgto6UESxarUWCf
 Qztzhv+Oe0cM9BKpCE3w+zqUqVEHV+1z9zWvVkp173ZSxsFLQfqK/TLLKJ7WKxG7YzQQ
 OjTA==
X-Forwarded-Encrypted: i=1;
 AL+hErGKMrhjvI6WQNbZAKa/gl3/sx36BJkjlpkRpHaiyQf+A4mIbh/wj1+CnqGwo5Bga09Kc2LXyZEDwtM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/dddZEpL9N9hkaXVNNPn0W2o5fjsLW1/SNr75WrbWJE3bAfccr
 ZQIZ/bD6CCVXLcUq9q5dfJsv6pWgUMgXbKKvhqzuYDXJY7JumFxsom2XYV30O1Gag03l5VOIm3L
 AVpJm7g+hx2xfmZdCWQ==
X-Received: from qvbpe4.prod.google.com ([2002:a05:6214:4944:b0:91f:2759:c36b])
 (user=eagleshaw job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5cec:0:b0:91f:2abb:a791 with SMTP id
 6a1803df08f44-91f2abbad25mr212446406d6.20.1794930871987; 
 Tue, 17 Nov 2026 07:54:31 -0800 (PST)
Date: Tue, 17 Nov 2026 15:54:31 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117155431.1654298-1-eagleshaw@google.com>
Subject: [PATCH] dma-buf: heaps: system: zero pages after
 set_memory_decrypted()
From: Ying Xiao <eagleshaw@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 "T . J . Mercier" <tjmercier@google.com>, Jiri Pirko <jiri@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, 
 Jacob Moroni <jmoroni@google.com>, Xuehao Hu <xuehaohu@google.com>, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Ying Xiao <eagleshaw@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

system_heap_allocate() allocates pages via order_flags[] with __GFP_ZERO
while the direct map still has the memory encryption bit set. For the
system_cc_shared heap, set_memory_decrypted() subsequently clears the
encryption bit without re-zeroing, leaving ciphertext in DRAM on
confidential computing (CoCo) guests instead of plaintext zeros.

Skip __GFP_ZERO during alloc_pages() for cc_shared allocations, and zero
the pages once in system_heap_set_page_decrypted() after
set_memory_decrypted() succeeds.

Fixes: 78b30c50a7ac ("dma-buf: heaps: system: add system_cc_shared heap for explicitly shared memory")
Reviewed-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Ying Xiao <eagleshaw@google.com>
---
 drivers/dma-buf/heaps/system_heap.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index c8959eadc71d..5f98d0df11e7 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -72,11 +72,19 @@ static int system_heap_set_page_decrypted(struct page *page)
 	int ret;
 
 	ret = set_memory_decrypted(addr, nr_pages);
-	if (ret)
+	if (ret) {
 		pr_warn_ratelimited("dma-buf system heap: failed to decrypt page at %p\n",
 				    page_address(page));
+		return ret;
+	}
 
-	return ret;
+	/*
+	 * Clearing the encryption bit does not clear DRAM, leaving ciphertext
+	 * from when the page was encrypted. Zero it now that it is decrypted.
+	 */
+	memset((void *)addr, 0, (size_t)nr_pages << PAGE_SHIFT);
+
+	return 0;
 }
 
 static int system_heap_set_page_encrypted(struct page *page)
@@ -376,7 +384,8 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 };
 
 static struct page *alloc_largest_available(unsigned long size,
-					    unsigned int max_order)
+					    unsigned int max_order,
+					    bool cc_shared)
 {
 	struct page *page;
 	int i;
@@ -388,6 +397,12 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 		flags = order_flags[i];
+		/*
+		 * Zeroing while encrypted is wasted since decryption leaves
+		 * ciphertext; system_heap_set_page_decrypted() zeroes instead.
+		 */
+		if (cc_shared)
+			flags &= ~__GFP_ZERO;
 		if (mem_accounting)
 			flags |= __GFP_ACCOUNT;
 		page = alloc_pages(flags, orders[i]);
@@ -438,7 +453,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 			goto free_buffer;
 		}
 
-		page = alloc_largest_available(size_remaining, max_order);
+		page = alloc_largest_available(size_remaining, max_order,
+					       cc_shared_buffer(buffer));
 		if (!page)
 			goto free_buffer;
 
-- 
2.56.0.679.gc527c65306-goog

