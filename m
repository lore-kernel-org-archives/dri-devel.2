Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D13606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fR7aD2y8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A39110E45A;
	Wed, 25 Nov 2026 08:41:25 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F68D10F0D3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:29:04 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-9906870a9baso2606140241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795559343; x=1796164143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PoOj+my22IFHd/VtbAjuDS6sJG0ydal9flflm2eSZtE=;
 b=fR7aD2y8TPr9sU6YT5OWMHIu3mIq84CkfSmPhtc8iPtdTcJdxIAkl98oeJcsCNn3Jq
 m5xNW5p9EWURgKyvE3y5fEdZTKTJkawRDgB2BTSXD1DB3doaZcqaQC2slD3gkuSbXgBg
 UaO63iDvmMUPTWe6424MFhC9WJk5yPj0S08lkJrbOCkAg2HNvyLLZaVQjI7mq3mrE2RT
 0wb/C0W0YIpKV9YecEu6kxLSzh62mHURgWojF16OB4kY3M8c5JzEphmJpw1C6jl/p6wZ
 0DTfjFWKNe/dRSZ7mHYKRN+OwkLUARq+waVeNQH0Yo8rU2HRGGq+LaxaYeJyl5tFDXaj
 cnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559343; x=1796164143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PoOj+my22IFHd/VtbAjuDS6sJG0ydal9flflm2eSZtE=;
 b=bY5v5Asfm9OdLiaFrf9esowW1o9EaVqqdMNuIF2dUquRNfjctJEbQYESohClyVBcBV
 0PWbl6j3v25mCN3Ec+mBb0MJE66W/XvDz9MOvVZsIbmu6ixDlb6Y6AeiblmIHPyjULay
 jEERDBShZhlxs9U7JQPHw+hEeeBUcS6qtyRKDQffJ5o7RNs3J2xdeqQQX78SEATJ7Lu0
 pafO+i35oO4znjjdSogfqNBsV7AUbuqU+hks2saTjWHvpFvHTBhSF2niKUpLs00zf4A5
 wL++WstWjobcMOHu2AH9Iv/RXsaDYUqk1VzMpm2dHDq6Cc0BQWtL9ZW/fL4wsNjwzOMj
 xp3Q==
X-Gm-Message-State: APuU4Z+EF9o4ZTDzfxMX6pSxHYcf2+lJJYpFTS4VlCetgthzvibW6k7G
 HsAVXcnEPIBZ+27ZejITYiecQCo0ho9hfqtZ0N01SXEWoFv9Dnrb93Xi
X-Gm-Gg: AZFdTZdDcWrnZp3d9ncVPLh77hXVG53143g1qkcpDh6VeB72Luj1hMSfGSaCjWhCdh6
 iGrCu798OuV8TvvTyAXT1ZIki40802uZpthgtscLAIApyExcFYHcisZJ2ZgePEtvLZL6c0m8Txg
 neXMGbo+kTdEyGKzic7BizXGSspSRTlhigIvgcv+aZMFdQcE+nMIywEgsCUSN4E3t5F2Aixbz8Q
 mUsRkZWaxX/ff3uJ9C/wBpptlleqaWvcTiaOQmzeHDQ6v8WQmF/SJiR+3o6GT1bpFFSuXumEaY9
 7JLDxdNElJCrvkNsUufb2gTpHDNG3y1m7+iYQ69B3Sn2LW6rLZbIXnfHdPq84/PYPDIe0QBg+7x
 Rp8Rrbjp0yF92+OT44Q+qgQ1+PUOTv6AeMadEVJyHLfnwIkoFZdsCtkVWkHX51MSg4LcVC61r9s
 0/V3qMh2mglxLrMXG+q5so7mmEUjetAjz6GPLD19hdI2xxOVrSkk/oN8wSA0vyeeK1xOOX9XE5s
 5XEIcZe/c8jXoSTiM7AyriJjpBu+kdujZPnHtrZIEc64UgQhI1RuWzi6cLKnOxtwHVhwijJFg3i
 Oax9XnG2n3OWniSSANWBwLd8/nfB6AgPU5UnP0UtPWjq
X-Received: by 2002:a05:6102:41a9:b0:7c7:f976:ea9c with SMTP id
 ada2fe7eead31-7d7393aff31mr9173319137.13.1795559343183; 
 Tue, 24 Nov 2026 14:29:03 -0800 (PST)
Received: from eduapps.lan ([2804:f04:9074:7a00:92e6:2643:ce63:2792])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e822a085sm16403831137.10.2026.11.24.14.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 14:29:02 -0800 (PST)
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Subject: [RFC PATCH 1/2] drm/ttm: reclaim pooled pages after a period of
 inactivity
Date: Tue, 24 Nov 2026 19:28:11 -0300
Message-ID: <20261124222812.511867-2-eduardoprocopiogomez@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Below the pool limit, TTM can retain returned pages after a workload
exits. Use delayed work to drain the pool through the existing per-node
shrink path after five seconds without new page returns.

Update page accounting before publishing pages to the pool so
concurrent reclaim sees consistent counts. Cancel the worker before
tearing down the pool. Set ttm.page_pool_idle_ms to zero to disable idle
reclaim.

In QEMU, 768 MiB remained pooled after 60 seconds without the patch and
had returned to the allocator by the eight-second sample with it.

Signed-off-by: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 70 ++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023f..6af8a9c89 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -36,7 +36,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
 #include <linux/highmem.h>
+#include <linux/jiffies.h>
 #include <linux/sched/mm.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -134,8 +136,17 @@ static unsigned long page_pool_size;
 MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool per NUMA node");
 module_param(page_pool_size, ulong, 0644);
 
+static unsigned int page_pool_idle_ms = 5000;
+
+MODULE_PARM_DESC(page_pool_idle_ms, "TTM page pool idle timeout in ms (0 disables it)");
+module_param(page_pool_idle_ms, uint, 0444);
+
 static unsigned long pool_node_limit[MAX_NUMNODES];
 static atomic_long_t allocated_pages[MAX_NUMNODES];
+static struct delayed_work pool_idle_work;
+static DEFINE_SPINLOCK(pool_idle_lock);
+static unsigned long pool_idle_delay;
+static unsigned long pool_last_return;
 
 static struct ttm_pool_type global_write_combined[NR_PAGE_ORDERS];
 static struct ttm_pool_type global_uncached[NR_PAGE_ORDERS];
@@ -322,6 +333,25 @@ static void ttm_pool_unmap(struct ttm_pool *pool, dma_addr_t dma_addr,
 		       DMA_BIDIRECTIONAL);
 }
 
+/* Arm idle reclaim once and let the worker check for more recent returns. */
+static void ttm_pool_note_return(void)
+{
+	unsigned long now;
+
+	if (!pool_idle_delay)
+		return;
+
+	now = jiffies;
+	if (READ_ONCE(pool_last_return) != now) {
+		spin_lock(&pool_idle_lock);
+		WRITE_ONCE(pool_last_return, jiffies);
+		spin_unlock(&pool_idle_lock);
+	}
+	if (!delayed_work_pending(&pool_idle_work))
+		queue_delayed_work(system_dfl_long_wq, &pool_idle_work,
+				   pool_idle_delay);
+}
+
 /* Give pages into a specific pool_type */
 static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
 {
@@ -335,14 +365,17 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
 			clear_page(page_address(p + i));
 	}
 
+	/* Account for the pages before a concurrent shrinker can take them. */
+	atomic_long_add(num_pages, &allocated_pages[nid]);
+	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
+	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
+
 	INIT_LIST_HEAD(&p->lru);
 	rcu_read_lock();
 	list_lru_add(&pt->pages, &p->lru, nid, NULL);
 	rcu_read_unlock();
 
-	atomic_long_add(num_pages, &allocated_pages[nid]);
-	mod_lruvec_page_state(p, NR_GPU_ACTIVE, -num_pages);
-	mod_lruvec_page_state(p, NR_GPU_RECLAIM, num_pages);
+	ttm_pool_note_return();
 }
 
 static enum lru_status take_one_from_lru(struct list_head *item,
@@ -473,6 +506,30 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	return num_pages;
 }
 
+/* Return unused pool pages after the last return has aged out. */
+static void ttm_pool_shrink_idle(struct work_struct *work)
+{
+	const unsigned long batch = 1UL << (MAX_PAGE_ORDER / 2);
+	int nid;
+
+	for_each_node_state(nid, N_MEMORY) {
+		while (atomic_long_read(&allocated_pages[nid]) > 0) {
+			unsigned long now = jiffies;
+			unsigned long expires = READ_ONCE(pool_last_return) +
+						pool_idle_delay;
+
+			if (time_before(now, expires)) {
+				queue_delayed_work(system_dfl_long_wq, &pool_idle_work,
+						   expires - now);
+				return;
+			}
+
+			ttm_pool_shrink(nid, batch);
+			cond_resched();
+		}
+	}
+}
+
 /* Return the allocation order based for a page */
 static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 {
@@ -1492,8 +1549,11 @@ static inline u64 ttm_get_node_memory_size(int nid)
 int ttm_pool_mgr_init(unsigned long num_pages)
 {
 	unsigned int i;
-
 	int nid;
+
+	pool_idle_delay = msecs_to_jiffies(page_pool_idle_ms);
+	INIT_DELAYED_WORK(&pool_idle_work, ttm_pool_shrink_idle);
+
 	for_each_node(nid) {
 		if (!page_pool_size) {
 			u64 node_size = ttm_get_node_memory_size(nid);
@@ -1551,6 +1611,8 @@ void ttm_pool_mgr_fini(void)
 {
 	unsigned int i;
 
+	disable_delayed_work_sync(&pool_idle_work);
+
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
 		ttm_pool_type_fini(&global_write_combined[i]);
 		ttm_pool_type_fini(&global_uncached[i]);
-- 
2.55.0

