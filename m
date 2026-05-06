Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F8CD3440
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 03:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A80E10E4F5;
	Wed,  6 May 2026 03:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hQgimQ0V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F1F10E144;
 Wed,  6 May 2026 03:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778038388; x=1809574388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=81vapQm0G2+s7Q9rjkTUxp8N8diOM+t3xvAi5oamm8g=;
 b=hQgimQ0VBR+3Zh6wyVIBbmGq7k4jVw1Q1o/g3sno3C+McUPK7MoMXxt5
 AtGkmVwvgskofR0t+HDThvX5AURSU27xvdtGD3oqfdu4moZXh5DHH/FVt
 0xeNVRBijcOTd/QtRQFae+2/874KqWY7fH51h+55Rne6EHkgtRy7dXtj4
 /s5tDFSpBfz7pmwCi8MxylW/BLCiEeBljp3ovaLs5e3zlxGM8BKwHKrnG
 v7TF0Niv90bK3lYqg//Fle6fhCaXFv9Bq+TzpXT93pUwjcns/Sq4urLQ3
 nt6ZuhnwHmUWdVeKeG5i58Ce087zTg6Kn9zAu217Ny2NjlQlJFtUwoSPq g==;
X-CSE-ConnectionGUID: P/xmPgJHQ1C6VZh39fIvyA==
X-CSE-MsgGUID: IGjp/6cyQZqlBof+YPbnEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78829032"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78829032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:07 -0700
X-CSE-ConnectionGUID: nIPvi29BS/e4PKxK3VvyMQ==
X-CSE-MsgGUID: 7ksHOWx2SLuT43UQAcKJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="266342146"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v5 1/5] mm: Wire up order in shrink_control
Date: Tue,  5 May 2026 20:32:56 -0700
Message-Id: <20260506033300.3534883-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506033300.3534883-1-matthew.brost@intel.com>
References: <20260506033300.3534883-1-matthew.brost@intel.com>
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

Pass the allocation order through shrink_control so shrinkers have
visibility into the order that triggered reclaim.

This allows shrinkers to implement better heuristics, such as detecting
high-order allocation pressure or fragmentation and avoiding eviction
of working sets when reclaim is invoked from kswapd.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kairui Song <kasong@tencent.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/shrinker.h |  3 +++
 mm/internal.h            |  4 ++--
 mm/shrinker.c            | 13 ++++++++-----
 mm/vmscan.c              |  7 ++++---
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 1a00be90d93a..7072f693b9be 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -37,6 +37,9 @@ struct shrink_control {
 	/* current node being shrunk (for NUMA aware shrinkers) */
 	int nid;
 
+	/* Allocation order we are currently trying to fulfil. */
+	s8 order;
+
 	/*
 	 * How many objects scan_objects should scan and try to reclaim.
 	 * This is reset before every call, so it is safe for callees
diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..ff8671dccf7b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1759,8 +1759,8 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
-unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
-			  int priority);
+unsigned long shrink_slab(gfp_t gfp_mask, int nid, s8 order,
+			  struct mem_cgroup *memcg, int priority);
 
 int shmem_add_to_page_cache(struct folio *folio,
 			    struct address_space *mapping,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 76b3f750cf65..c83f3b3daa08 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -466,7 +466,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 }
 
 #ifdef CONFIG_MEMCG
-static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid, s8 order,
 			struct mem_cgroup *memcg, int priority)
 {
 	struct shrinker_info *info;
@@ -528,6 +528,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct shrink_control sc = {
 				.gfp_mask = gfp_mask,
 				.nid = nid,
+				.order = order,
 				.memcg = memcg,
 			};
 			struct shrinker *shrinker;
@@ -587,7 +588,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 	return freed;
 }
 #else /* !CONFIG_MEMCG */
-static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid, s8 order,
 			struct mem_cgroup *memcg, int priority)
 {
 	return 0;
@@ -598,6 +599,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
  * @nid: node whose slab caches to target
+ * @order: order of allocation
  * @memcg: memory cgroup whose slab caches to target
  * @priority: the reclaim priority
  *
@@ -614,8 +616,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
  *
  * Returns the number of reclaimed slab objects.
  */
-unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
-			  int priority)
+unsigned long shrink_slab(gfp_t gfp_mask, int nid, s8 order,
+			  struct mem_cgroup *memcg, int priority)
 {
 	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
@@ -628,7 +630,7 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 	 * oom.
 	 */
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
-		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
+		return shrink_slab_memcg(gfp_mask, nid, order, memcg, priority);
 
 	/*
 	 * lockless algorithm of global shrink.
@@ -656,6 +658,7 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
+			.order = order,
 			.memcg = memcg,
 		};
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bd1b1aa12581..a54d14ecad25 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -412,7 +412,7 @@ static unsigned long drop_slab_node(int nid)
 
 	memcg = mem_cgroup_iter(NULL, NULL, NULL);
 	do {
-		freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
+		freed += shrink_slab(GFP_KERNEL, nid, 0, memcg, 0);
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
 	return freed;
@@ -5068,7 +5068,8 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 
 	success = try_to_shrink_lruvec(lruvec, sc);
 
-	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
+	shrink_slab(sc->gfp_mask, pgdat->node_id, sc->order, memcg,
+		    sc->priority);
 
 	if (!sc->proactive)
 		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
@@ -6170,7 +6171,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		shrink_lruvec(lruvec, sc);
 
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
+		shrink_slab(sc->gfp_mask, pgdat->node_id, sc->order, memcg,
 			    sc->priority);
 
 		/* Record the group's reclaim efficiency */
-- 
2.34.1

