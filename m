Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AEEC61DE4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758AE10E1B4;
	Mon, 31 Aug 2026 03:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="ZGPoTm7v";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCA910E1B4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=KURj71ZYjBbTCMiCfw2Oo07gKLQA9zu3iI3ERtxukf4=; b=ZGPoTm7vZH2PsKgf+bZ2XXvxFW
 PWhaeL8r1qRisw0FfG091LDSnTdIwurCq/pp3ojWXU+8ZC90r7og1rncBbwp4RSR66BwRVrngsI3K
 n8I+neOd23H8M9wC87nI3pycUAfr6477nmPiVfDZcEiF7yhhiwEMXlM725NYHmlis7EWGvBrsD/p7
 igWgQBMNgmHgYejYucXUAWQzRLG437YyZqmAmclhcPfQnTvUufmBDtz9iDJ5aqsgqwGJdneGJ8+Qk
 sQ1P2OmmWnsKqqlVTWhEowgtnrorNyu/cthM3XRQVOMmWPqzMOxO7b1OB0rMLa6o1JpOPNwHuOQ9p
 vonzEDSg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x0sYu-00000008OhA-3pqG; Mon, 31 Aug 2026 03:19:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] dma-buf: fix some kernel-doc warnings
Date: Sun, 30 Aug 2026 20:19:53 -0700
Message-ID: <20260831031956.3410813-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

- drop Excess description of @lock from kernel-doc
- add missing function/macro short descriptions

WARNING: include/linux/dma-fence-array.h:47 Excess struct member 'lock' description in 'dma_fence_array'
WARNING: include/linux/dma-fence-chain.h:48 Excess struct member 'lock' description in 'dma_fence_chain'
Warning: include/linux/dma-fence-chain.h:82 missing initial short description on line:
 * dma_fence_chain_alloc
Warning: include/linux/dma-fence-chain.h:94 missing initial short description on line:
 * dma_fence_chain_free

Fixes: 5943243914b9 ("dma-buf: use inline lock for the dma-fence-array")
Fixes: a408c0ca0c41 ("dma-buf: use inline lock for the dma-fence-chain")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend; add Andrew to Cc: list

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

 include/linux/dma-fence-array.h |    1 -
 include/linux/dma-fence-chain.h |    9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

--- linux-next-20260828.orig/include/linux/dma-fence-array.h
+++ linux-next-20260828/include/linux/dma-fence-array.h
@@ -28,7 +28,6 @@ struct dma_fence_array_cb {
 /**
  * struct dma_fence_array - fence to represent an array of fences
  * @base: fence base class
- * @lock: spinlock for fence handling
  * @num_fences: number of fences in the array
  * @num_pending: fences in the array still pending
  * @fences: array of the fences
--- linux-next-20260828.orig/include/linux/dma-fence-chain.h
+++ linux-next-20260828/include/linux/dma-fence-chain.h
@@ -20,7 +20,6 @@
  * @prev: previous fence of the chain
  * @prev_seqno: original previous seqno before garbage collection
  * @fence: encapsulated fence
- * @lock: spinlock for fence handling
  */
 struct dma_fence_chain {
 	struct dma_fence base;
@@ -81,9 +80,8 @@ dma_fence_chain_contained(struct dma_fen
 }
 
 /**
- * dma_fence_chain_alloc
- *
- * Returns a new struct dma_fence_chain object or NULL on failure.
+ * dma_fence_chain_alloc - Returns a new &struct dma_fence_chain object or
+ * %NULL on failure.
  *
  * This specialized allocator has to be a macro for its allocations to be
  * accounted separately (to have a separate alloc_tag). The typecast is
@@ -93,7 +91,8 @@ dma_fence_chain_contained(struct dma_fen
 		kmalloc_obj(struct dma_fence_chain)
 
 /**
- * dma_fence_chain_free
+ * dma_fence_chain_free - Frees an allocated but not used
+ * &struct dma_fence_chain object.
  * @chain: chain node to free
  *
  * Frees up an allocated but not used struct dma_fence_chain object. This
