Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9596606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XhkFmg5k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A1610E8DA;
	Wed, 25 Nov 2026 02:46:58 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3025610E8DA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:46:51 +0000 (UTC)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-5eac7220e9cso2044309e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795574810; x=1796179610; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lvuiHeraEsIPjv1j24eW+FCh8EDOAQqBNRz1QyN2azM=;
 b=XhkFmg5kI4f5uhTDEDTUX32jeGu8VtXHsQU9arUOvaokprDBwU5LL6CRy68fxJzhun
 DyepTAqkNhxiE1RHgmo6bCcQF8v4ks5SLhzgTNfd5K3JWDIULWG78GaawwDhvLiJpDtJ
 sA6N1dCw67pVAVIpyuhuGJ061xCJpLnrKUBk6xiMrr/5yS31fD7hS+YXUpnOVsEbdQYn
 YM10oq4HrB1DovQhIRfCeXLS+UpdFD76fqqYAZL2ExrnLQzPxqp+8REwB8oidO705Hfa
 8UkAorMQqUkMoiH0p9IKZzZBl26KevISDcyHzk7xciA8ka9nqC0ZtvqODEZsTqHYNiXT
 XGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795574810; x=1796179610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lvuiHeraEsIPjv1j24eW+FCh8EDOAQqBNRz1QyN2azM=;
 b=wdCnBlCjEVIsah3nj86/zCq6hlr77/8YCjZNGSM37q5Cp05JnC0wWjKjOykg7wbTtC
 6zkC0md2oQQZiiJV65xMx8l800G90yceVrclPY4aAIg6nT/IjCvSlNKXGdA0FWZ6cfXo
 FJv7WL1W0rpDVa7TfCDdlsldGWbrnsopdbRGaff17tloZmOVpUOIr9gPsNzBEXZX/JUy
 3BFus8aM0+kSKjv1RFnTovA1bcLbtdn5ydJwmunb0FIamGJMnPfsTjxPUB9iwSMP7/7z
 i60axeGjfcQA0WZghOiNdQyLaaHCngJwkZq5rDLgPuCY9bavirypvTVp6YRkztS4wGzO
 vGNQ==
X-Gm-Message-State: APuU4Z8oXQFpd1putQHEor0d61N3BtI0h3PKzfXVsJyL5KAjgu76g2Np
 QYFxg0oKUegpNwiXmZ5FLzLa0/p4MP3TXtMcErKBtyK6pTqzJRmaSG/9ZFq5Z85o+7g=
X-Gm-Gg: AZFdTZd2bPGr612PzXxTfXF8LxtiX5O3UoUgUMAPiR2t49XIKdNzJtiRsFcgir/P8gg
 WDy4QF6edywCTRnFieX6XyVJRUyXvXrZ1RNxn0ku5YlRMKmPXyiHscRuktBHrYBnYWfo+pNzJit
 FSF/MOJmNgwuepeTAu2iYcGswa2cHx6l4lX/eO021/SO9YuIWBA8mlmmObTYRlhyoFtn82Hp8A0
 8nDlaGy6lKVRDMnQl2lnSaCy5L754o938nH4Ph9ehjN5iwjAjOb02CKL/kJQdLKeTSZg+kQVMNJ
 nwPn/IifGEo2NHccObg3Dkqj/n6jaGhN0DLPMkkiG9QjiyRd2ythvAEUTH39YRGR7nCqB/zugdx
 ab3yvwcn0ywkth63lkgoI26MmQHOWIvNvHPnbzzjQge/3Sfs0PmsVwhj3C++KGLDnsIKn7NcYio
 KsQC7fBNAq+LQuB5h/iRXbGJHWOTGJIHUFkz+whaqxhS/KHQQ9IxnydcIubmVyeEzY+NwNV+P0k
 33lbwwuF2tJpQJ34g9q//IDXWmbZNOHlFeDhGqjYdrX71+zNiPy3Eq+kJLxw8UenMELouflUZR3
 opaZ6DlGvl7zOaJTYBl2r+6Q7xXJbEJtVR0RaJpIKx8=
X-Received: by 2002:a05:6122:288a:b0:5c9:c60e:3a40 with SMTP id
 71dfb90a1353d-5ee8af56a83mr10701470e0c.18.1795574809785; 
 Tue, 24 Nov 2026 18:46:49 -0800 (PST)
Received: from eduapps.lan ([2804:f04:9074:7a00:7473:b089:726c:885])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee8b556db7sm15768298e0c.4.2026.11.24.18.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 18:46:49 -0800 (PST)
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Subject: [RFC PATCH v3] drm/ttm: reclaim excess pooled pages with batched
 write-back
Date: Tue, 24 Nov 2026 23:46:30 -0300
Message-ID: <20261125024630.257843-1-eduardoprocopiogomez@gmail.com>
X-Mailer: git-send-email 2.55.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pages returned to the TTM pool can remain cached below its hard
limit when there is no memory pressure. On a 32 GiB Intel Xe
desktop, this left several GiB cached after the GPU workload exited.

Queue reclaim when a return leaves a node above its reserve. Use a
fixed five-second delay by default so further returns cannot
postpone pending reclaim. Retain a 128 MiB target per NUMA node,
clamped to the node limit. The memory-pressure shrinker can still
reclaim below that target.

Limit each delayed pass by the initial excess and consecutive scans
without progress. Requeue if excess remains. In ttm_pool_free(),
use a single counter snapshot for the hard-limit comparison and
subtraction so concurrent reclaim cannot underflow the request.

On x86, reclaim can restore write-back caching and flush remote TLBs
once for every order-0 WC or UC page. Restore write-back for up to 32
eligible pages per call before freeing them. Use the individual path
if the array conversion fails or a page is ineligible.

In a two-vCPU QEMU guest, reclaiming 128 MiB of 4 KiB WC pages took
1,024 write-back calls and 2,048 CPA TLB callbacks, down from 32,768
calls and 65,536 callbacks without batching. A separate run drained
a 768 MiB burst while 32 MiB allocations and returns continued.

Signed-off-by: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>
---
Changes since v2:
- Batch write-back conversion for order-0 WC/UC pages on x86.
- Verify the reduction in CPA TLB callbacks in a two-vCPU QEMU guest.

v2: https://lore.kernel.org/r/20261125015613.127297-1-eduardoprocopiogomez@gmail.com/


 drivers/gpu/drm/ttm/ttm_pool.c | 157 ++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023f..3c1457759 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -36,7 +36,10 @@
 #include <linux/dma-mapping.h>
 #include <linux/debugfs.h>
 #include <linux/highmem.h>
+#include <linux/jiffies.h>
 #include <linux/sched/mm.h>
+#include <linux/sizes.h>
+#include <linux/workqueue.h>
 
 #ifdef CONFIG_X86
 #include <asm/set_memory.h>
@@ -134,8 +137,20 @@ static unsigned long page_pool_size;
 MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool per NUMA node");
 module_param(page_pool_size, ulong, 0644);
 
+static unsigned int page_pool_idle_ms = 5000;
+
+MODULE_PARM_DESC(page_pool_idle_ms, "TTM page pool reclaim delay in ms (0 disables it)");
+module_param(page_pool_idle_ms, uint, 0444);
+
+static unsigned long page_pool_idle_reserve = SZ_128M / PAGE_SIZE;
+
+MODULE_PARM_DESC(page_pool_idle_reserve, "Target pages to retain per NUMA node after delayed reclaim");
+module_param(page_pool_idle_reserve, ulong, 0444);
+
 static unsigned long pool_node_limit[MAX_NUMNODES];
 static atomic_long_t allocated_pages[MAX_NUMNODES];
+static struct delayed_work pool_idle_work;
+static unsigned long pool_idle_delay;
 
 static struct ttm_pool_type global_write_combined[NR_PAGE_ORDERS];
 static struct ttm_pool_type global_uncached[NR_PAGE_ORDERS];
@@ -243,9 +258,6 @@ static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
 	void *vaddr;
 
 #ifdef CONFIG_X86
-	/* We don't care that set_pages_wb is inefficient here. This is only
-	 * used when we have to shrink and CPU overhead is irrelevant then.
-	 */
 	if (caching != ttm_cached && !PageHighMem(p))
 		set_pages_wb(p, 1 << order);
 #endif
@@ -322,6 +334,21 @@ static void ttm_pool_unmap(struct ttm_pool *pool, dma_addr_t dma_addr,
 		       DMA_BIDIRECTIONAL);
 }
 
+/* Start one reclaim window for the shared pool when a node exceeds its reserve. */
+static void ttm_pool_note_return(int nid)
+{
+	unsigned long reserve = min(page_pool_idle_reserve, pool_node_limit[nid]);
+	long pages;
+
+	if (!pool_idle_delay || delayed_work_pending(&pool_idle_work))
+		return;
+
+	pages = atomic_long_read(&allocated_pages[nid]);
+	if (pages > 0 && pages > reserve)
+		queue_delayed_work(system_dfl_long_wq, &pool_idle_work,
+				   pool_idle_delay);
+}
+
 /* Give pages into a specific pool_type */
 static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
 {
@@ -335,14 +362,17 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt, struct page *p)
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
+	ttm_pool_note_return(nid);
 }
 
 static enum lru_status take_one_from_lru(struct list_head *item,
@@ -398,9 +428,59 @@ static enum lru_status pool_move_to_dispose_list(struct list_head *item,
 	return LRU_REMOVED;
 }
 
+#ifdef CONFIG_X86
+/* Restore one batch before returning its pages to the allocator. */
+static void ttm_pool_free_wb_batch(struct ttm_pool_type *pt,
+				   struct page **pages, unsigned int nr)
+{
+	bool restored = !set_pages_array_wb(pages, nr);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		struct page *p = pages[i];
+
+		atomic_long_dec(&allocated_pages[page_to_nid(p)]);
+		if (restored)
+			__free_pages_gpu_account(p, 0, true);
+		else
+			ttm_pool_free_page(NULL, pt->caching, 0, p, true);
+	}
+}
+
+/* Batch normal order-0 pages using a bounded array without allocating memory. */
+static void ttm_pool_dispose_wb(struct ttm_pool_type *pt,
+			       struct list_head *dispose)
+{
+	struct page *pages[32];
+	struct page *p, *next;
+	unsigned int nr = 0;
+
+	list_for_each_entry_safe(p, next, dispose, lru) {
+		if (PageHighMem(p))
+			continue;
+
+		list_del_init(&p->lru);
+		pages[nr++] = p;
+		if (nr == ARRAY_SIZE(pages)) {
+			ttm_pool_free_wb_batch(pt, pages, nr);
+			nr = 0;
+		}
+	}
+
+	if (nr)
+		ttm_pool_free_wb_batch(pt, pages, nr);
+}
+#endif
+
 static void ttm_pool_dispose_list(struct ttm_pool_type *pt,
 				  struct list_head *dispose)
 {
+#ifdef CONFIG_X86
+	if (!pt->order && pt->caching != ttm_cached &&
+	    (!pt->pool || !ttm_pool_uses_dma_alloc(pt->pool)))
+		ttm_pool_dispose_wb(pt, dispose);
+#endif
+
 	while (!list_empty(dispose)) {
 		struct page *p;
 		p = list_first_entry(dispose, struct page, lru);
@@ -452,7 +532,8 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
 }
 
 /* Free pages using the per-node shrinker list */
-static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
+static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free,
+				    unsigned long page_budget)
 {
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
@@ -464,6 +545,10 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	list_move_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
 
+	/* A list entry represents a whole compound allocation. */
+	if (page_budget)
+		num_to_free = min(num_to_free, ((page_budget - 1) >> pt->order) + 1);
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -473,6 +558,46 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	return num_pages;
 }
 
+/* Trim excess pooled pages when the fixed reclaim window expires. */
+static void ttm_pool_shrink_idle(struct work_struct *work)
+{
+	const unsigned long batch = 1UL << (MAX_PAGE_ORDER / 2);
+	size_t nr_types;
+	int nid;
+
+	spin_lock(&shrinker_lock);
+	nr_types = list_count_nodes(&shrinker_list);
+	spin_unlock(&shrinker_lock);
+
+	for_each_node_state(nid, N_MEMORY) {
+		unsigned long reserve = min(page_pool_idle_reserve,
+					    pool_node_limit[nid]);
+		long pages = atomic_long_read(&allocated_pages[nid]);
+		unsigned long budget;
+		size_t empty = 0;
+
+		if (pages <= 0 || pages <= reserve)
+			continue;
+
+		/* Bound freed pages and scans that make no progress. */
+		budget = pages - reserve;
+		while (budget && empty < nr_types && pages > 0 && pages > reserve) {
+			unsigned long freed;
+
+			freed = ttm_pool_shrink(nid, batch, min(budget, pages - reserve));
+			budget -= min(budget, freed);
+			empty = freed ? 0 : empty + 1;
+			cond_resched();
+			pages = atomic_long_read(&allocated_pages[nid]);
+		}
+
+		/* Concurrent returns or scans of empty lists can leave excess. */
+		if (pages > 0 && pages > reserve)
+			queue_delayed_work(system_dfl_long_wq, &pool_idle_work,
+					   pool_idle_delay);
+	}
+}
+
 /* Return the allocation order based for a page */
 static unsigned int ttm_pool_page_order(struct ttm_pool *pool, struct page *p)
 {
@@ -978,13 +1103,14 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
 void ttm_pool_free(struct ttm_pool *pool, struct ttm_tt *tt)
 {
 	int nid = ttm_pool_nid(pool);
+	unsigned long limit = pool_node_limit[nid];
+	long pages;
 
 	ttm_pool_free_range(pool, tt, tt->caching, 0, tt->num_pages);
 
-	while (atomic_long_read(&allocated_pages[nid]) > pool_node_limit[nid]) {
-		unsigned long diff = atomic_long_read(&allocated_pages[nid]) - pool_node_limit[nid];
-		ttm_pool_shrink(nid, diff);
-	}
+	while ((pages = atomic_long_read(&allocated_pages[nid])) > 0 &&
+	       pages > limit)
+		ttm_pool_shrink(nid, pages - limit, 0);
 }
 EXPORT_SYMBOL(ttm_pool_free);
 
@@ -1309,7 +1435,7 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 	unsigned long num_freed = 0;
 
 	do
-		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan);
+		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan, 0);
 	while (num_freed < sc->nr_to_scan &&
 	       atomic_long_read(&allocated_pages[sc->nid]));
 
@@ -1492,8 +1618,11 @@ static inline u64 ttm_get_node_memory_size(int nid)
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
@@ -1551,6 +1680,8 @@ void ttm_pool_mgr_fini(void)
 {
 	unsigned int i;
 
+	disable_delayed_work_sync(&pool_idle_work);
+
 	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
 		ttm_pool_type_fini(&global_write_combined[i]);
 		ttm_pool_type_fini(&global_uncached[i]);

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.55.0

