Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD3606A336
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMR/Uqkg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413DD10E211;
	Wed, 25 Nov 2026 01:56:35 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04F610E211
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:56:28 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-385d8a00598so7657598eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 17:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795571788; x=1796176588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/Axsil06Uw3TQSM2F+PfB83Z6W7eFuNuQr7+FxvC2/c=;
 b=rMR/Uqkgx5wQmJ/A4pdTQUx6e7HIq+nrNthn1cvWhqM9F3F7+YYLRUWNlNWJmfAHHm
 +OkCgVE3moR3gjQM0u06zCK9N0t7Wl0h2iPx6kaX9lVwGp/gpp9qLuQIJN362S1QIiia
 TEazeP0s3buzd2+dMHUx+yZnD5xSpt2zw8FqIywyJoCkP67uHuJTJl+ppm1+0pXoUr0J
 RfLyZgrQb/I+dUSMRDcLVs8r3wZEB1LPqXWcvV9D6BLTAliBLGF4EIiGQo+IKGx6JeeH
 BaX5gkegDk+AYmyf08dvcIlqDagUVlfmYzIAt1KXCXo3BLw/UpI0fiMrCH/Wi+mqU9Te
 oevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795571788; x=1796176588;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/Axsil06Uw3TQSM2F+PfB83Z6W7eFuNuQr7+FxvC2/c=;
 b=VoOuMJzCVxJ6r+6ZCarhH4phAu7QJZfNjig6GbpRq9vUPJ8hGI3c3e9cC3jkwCZL7S
 zatvClUxT6mBbeCH8zCIk+ocPnHXorYp9gK8hNyWfaQL/mIFDeDNEtDLMK3CtHJf1kbW
 vsWfzsGF47bBa3LP2D4Y4A/6v6w/eUmDuQRSfdfeblg4Rb4KmOAL9tvo09HO4vN4jHks
 Lc07DiwO70QpljQY6XldiaUhZFnKh8LF79yLCMKTs1PKnY2/pVb+pgoGbxDEU19fN4/2
 r/flf5juKUlOHM2hrWRj4uOkiGdks4Q0sWClX3qsFYqX/bfSZ6Xb8mxsUZVDdHT7agEr
 XXPw==
X-Gm-Message-State: APuU4Z8iIynvWEhIEuh1vtFONPFP3NBOfDueMwitmpjCDB6+O9P9u82n
 oS6q0dUb1si3dLrxVEUF/7xU0qKvDjz2zO2xnupVDK6uyuAGRyu5cN8O/9zMjS+WWeo=
X-Gm-Gg: AZFdTZcUg46jDg2lgHN0pMqIRCXAtvnCkkmMP7vErMtfqhlDvRNGs/KJlE1NLFq450Y
 fENpKE1nYZyWE1fBPSNCWZNet6TymdsRZTvQ+jXz8k+lomo3m39gKwp9nBsZST1eeJVzo/cacJW
 vYVkfTxF4wjOdy9MCtcfZrylA8hhitUu3qiMksO+VTcsdqDVafrU1AWmh+OqD/r9nZtngp2jWBE
 FzzlMAmvhY+o7uya+zGK3pOd3sYsGOx2qTUE/f9NPdhosCMftxINLoJ5PlONepf/axTZsN08TuV
 sS9uncCTWBQyX8VzE9ndUDYQ3oib/yvHVjwDDCV25ScTkJFfokHJqOB1/UWh5FQ3IlloR+qDUJi
 Sg7QD3e1fqt9f598puCXMqtakBNihZhmoq6CDEi822OPz348UNw685ehLiVtVKdIlfsnIcq3m3t
 /24RegRbBpPXWJsRKpPTF8Xxs5t4TCL3tb5vYauRUjOtGApDokZo1KEUsuVNrCwBTn/IEbvvFy8
 ND5hpUTNM8rJtrs5h0Pz1jQQm2c4+XWD1VG1BKvWjyvsBTbpXCwD6CGtVN3sjtDV2uKZ8RNU73H
 YJzHWTStDhudN4M1rsH0SzOixw4RHgVWJrmOyA==
X-Received: by 2002:a05:693c:62d4:b0:386:ad86:21a9 with SMTP id
 5a478bee46e88-386ad862c8emr8228166eec.13.1795571787522; 
 Tue, 24 Nov 2026 17:56:27 -0800 (PST)
Received: from eduapps ([2804:f04:9074:7a00:7473:b089:726c:885])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm59237740eec.11.2026.11.24.17.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 17:56:27 -0800 (PST)
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
Subject: [RFC PATCH v2] drm/ttm: reclaim excess pooled pages after a fixed
 delay
Date: Tue, 24 Nov 2026 22:56:13 -0300
Message-ID: <20261125015613.127297-1-eduardoprocopiogomez@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Pages returned to the TTM pool can remain cached while the pool stays
below its hard limit and the memory-pressure shrinker is not invoked.
On a 32 GiB Intel Xe desktop, this left several GiB in the pool after
the GPU workloads that returned them had exited.

When a return leaves a NUMA node above its reserve, queue reclaim
after a fixed delay of five seconds by default. Further returns
leave the pending deadline unchanged so ongoing activity cannot
keep postponing reclaim. Retain a default target of 128 MiB per node,
clamped to the node limit. Reclaim under memory pressure can still
go below that target.

Bound each delayed pass by the initial excess and consecutive scans
without progress. Requeue if excess remains. In ttm_pool_free(),
use the same counter snapshot to check the node limit and calculate
the excess so concurrent reclaim cannot underflow the shrink request.

In QEMU, an initial 768 MiB pool fell to 128–160 MiB while a second
workload continued cycling 32 MiB allocations and settled at
128 MiB after those returns stopped.

Signed-off-by: Eduardo P. Gomez <eduardoprocopiogomez@gmail.com>
---
Changes since v1:
- Combine the earlier two-patch RFC into one patch.
- Start a fixed five-second delay once the pool is above its reserve.
- Bound scans without progress and calculate the hard-limit excess from
  a single counter read.

AI assistance: OpenAI Codex helped analyze and implement the TTM
reclaim changes and run the QEMU reproducer.

 drivers/gpu/drm/ttm/ttm_pool.c | 104 +++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bf37023f..09766496d 100644
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
@@ -322,6 +337,21 @@ static void ttm_pool_unmap(struct ttm_pool *pool, dma_addr_t dma_addr,
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
+	ttm_pool_note_return(nid);
 }
 
 static enum lru_status take_one_from_lru(struct list_head *item,
@@ -452,7 +485,8 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
 }
 
 /* Free pages using the per-node shrinker list */
-static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
+static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free,
+				    unsigned long page_budget)
 {
 	LIST_HEAD(dispose);
 	struct ttm_pool_type *pt;
@@ -464,6 +498,10 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
 	list_move_tail(&pt->shrinker_list, &shrinker_list);
 	spin_unlock(&shrinker_lock);
 
+	/* A list entry represents a whole compound allocation. */
+	if (page_budget)
+		num_to_free = min(num_to_free, ((page_budget - 1) >> pt->order) + 1);
+
 	num_pages = list_lru_walk_node(&pt->pages, nid, pool_move_to_dispose_list, &dispose, &num_to_free);
 	num_pages *= 1 << pt->order;
 
@@ -473,6 +511,46 @@ static unsigned int ttm_pool_shrink(int nid, unsigned long num_to_free)
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
@@ -978,13 +1056,14 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
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
 
@@ -1309,7 +1388,7 @@ static unsigned long ttm_pool_shrinker_scan(struct shrinker *shrink,
 	unsigned long num_freed = 0;
 
 	do
-		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan);
+		num_freed += ttm_pool_shrink(sc->nid, sc->nr_to_scan, 0);
 	while (num_freed < sc->nr_to_scan &&
 	       atomic_long_read(&allocated_pages[sc->nid]));
 
@@ -1492,8 +1571,11 @@ static inline u64 ttm_get_node_memory_size(int nid)
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
@@ -1551,6 +1633,8 @@ void ttm_pool_mgr_fini(void)
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

