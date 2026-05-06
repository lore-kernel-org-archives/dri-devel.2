Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD9DCD342F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 03:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241D910EC67;
	Wed,  6 May 2026 03:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KpVYpxhL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F009010E4EB;
 Wed,  6 May 2026 03:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778038390; x=1809574390;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hKs2r/SZ8fBLPzoHgcugkqcKmbZtBIMZ80SyreZA8i4=;
 b=KpVYpxhLI3W+TzglCakLBs2ZvUATeK+jE9MgNe4PW3mQO3SNyua6b7KL
 cjX6Milyg/n9ojSN/t0ObQ52KA59BYHOQs7OPMcc7Vt5gPfB8HjHMNxRd
 4cZpi+CdINKidaZV/7rAcSJ10FUMW9Fg8j2H/G7oGxTHw1nmXLD8iNWql
 9mEcR18jNZNaMXeDx3yxgSOqUABDKPE5CfQJfFZ6oA2fxcYpWW2ryqZDB
 T9Fbf9+pcelEhwfJVRBXHD+o98HcEEXZafi+W+NhFic+N5AFdO66F58ja
 k8cI1AUGFm/n9n1r8FN11nBZ0IubWBG+z1uAO/8ppJcm2K1e28x3fjRig Q==;
X-CSE-ConnectionGUID: olAZmR0xRP+yo+eNgCcqUw==
X-CSE-MsgGUID: 8s9xu6IkTDSVA+cD82wAnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78829088"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78829088"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:07 -0700
X-CSE-ConnectionGUID: 7i4b2G9rRAKaRcC7Cv6/qw==
X-CSE-MsgGUID: El8a7KdFSaqIsFbWl9ZtuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="266342154"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:07 -0700
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] drm/xe: Make use of
 shrink_control::opportunistic_compaction hint
Date: Tue,  5 May 2026 20:33:00 -0700
Message-Id: <20260506033300.3534883-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506033300.3534883-1-matthew.brost@intel.com>
References: <20260506033300.3534883-1-matthew.brost@intel.com>
MIME-Version: 1.0
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

Xe/TTM backup reclaim can be extremely expensive under fragmentation
pressure as reclaim may migrate or destroy actively used GPU working
sets despite the system still having substantial free memory available.

Under high-order opportunistic reclaim, repeatedly backing up GPU
memory can lead to reclaim/rebind ping-pong behavior where active GPU
working sets are continuously torn down and reconstructed without
materially improving allocation success.

Use the new shrink_control::opportunistic_compaction hint to avoid Xe
backup reclaim during fragmentation-driven high-order reclaim attempts.
In this mode the shrinker skips advertising backup-backed reclaimable
memory and avoids initiating backup operations entirely.

Order-0 and non-opportunistic reclaim behavior remain unchanged, so
Xe backup reclaim still participates normally during genuine memory
pressure.

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
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_shrinker.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
index 83374cd57660..4646b0f5b82b 100644
--- a/drivers/gpu/drm/xe/xe_shrinker.c
+++ b/drivers/gpu/drm/xe/xe_shrinker.c
@@ -139,10 +139,17 @@ static unsigned long
 xe_shrinker_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	struct xe_shrinker *shrinker = to_xe_shrinker(shrink);
-	unsigned long num_pages;
+	unsigned long num_pages = 0;
 	bool can_backup = !!(sc->gfp_mask & __GFP_FS);
 
-	num_pages = ttm_backup_bytes_avail() >> PAGE_SHIFT;
+	/*
+	 * Skip accounting backup-able pages when this is an opportunistic
+	 * high-order pass: TTM backup work shrinks at native page granularity
+	 * and is unlikely to produce the contiguous block the caller wants,
+	 * so don't advertise it as reclaimable for this hint.
+	 */
+	if (!sc->order || !sc->opportunistic_compaction)
+		num_pages = ttm_backup_bytes_avail() >> PAGE_SHIFT;
 	read_lock(&shrinker->lock);
 
 	if (can_backup)
@@ -233,7 +240,14 @@ static unsigned long xe_shrinker_scan(struct shrinker *shrink, struct shrink_con
 	}
 
 	sc->nr_scanned = nr_scanned;
-	if (nr_scanned >= nr_to_scan || !can_backup)
+	/*
+	 * Stop after the purge pass for opportunistic high-order reclaim:
+	 * the subsequent backup/writeback pass works at native page order
+	 * and is unlikely to free a contiguous high-order block, so doing
+	 * it here would just churn working sets for no compaction benefit.
+	 */
+	if (nr_scanned >= nr_to_scan || !can_backup ||
+	    (sc->order && sc->opportunistic_compaction))
 		goto out;
 
 	/* If we didn't wake before, try to do it now if needed. */
-- 
2.34.1

