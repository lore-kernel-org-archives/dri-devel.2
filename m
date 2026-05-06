Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D4CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 03:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888B310E4DE;
	Wed,  6 May 2026 03:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="abu83tYu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044F410E144;
 Wed,  6 May 2026 03:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778038388; x=1809574388;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kfiSeyy6TX7E2Ycbz/YAGvO5z9U19PNK24VluwAir5s=;
 b=abu83tYuYUa96rbBtFzPYbJJ3stZmcJFePIoQ1KBKJivAP4YD9836qb1
 +Htm/gnjXO46YRT0dOG7FEa2Elj74fQEYFWV1STnoKNuuMkczWtda+vtA
 JLKEfu+mHeEEeqOxyqegs14O8HDpbjXzD1PrSPEiPgjFqJTu2larhq0p5
 /LcjnBIvKvNzDmVHWXW65dhzq48/BAj18bPzKZoucQVuWCn6SGhurvzzH
 +HUtp/XhMYMRq+PAsOZ29l/1J+h8ym+S83WPBc+SpvWkL0kE3HgY5okng
 QQWPBj4fS4zl9zpUcWcekTMuyCntTydIJR2JofuHV4xDth0RLcMuUTsKO A==;
X-CSE-ConnectionGUID: G8IiSWUYTsCywExxe0JSxw==
X-CSE-MsgGUID: xzJeT25ySnGhelCzJ5PMJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78829011"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78829011"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:06 -0700
X-CSE-ConnectionGUID: WqzPK9p/RQ+MwU1h2N649A==
X-CSE-MsgGUID: Yugi3qNSSg28Cd6KFmMrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="266342145"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 20:33:06 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] mm, drm/ttm,
 drm/xe: Avoid reclaim/eviction loops under fragmentation
Date: Tue,  5 May 2026 20:32:55 -0700
Message-Id: <20260506033300.3534883-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

Alternative approach to [1].

TTM allocations at higher orders can drive Xe into a pathological
reclaim loop when memory is fragmented:

kswapd → shrinker → eviction → rebind (exec ioctl) → repeat

In this state, reclaim is triggered despite substantial free memory,
but fails to produce contiguous higher-order pages. The Xe shrinker then
evicts active buffer objects, increasing faulting and rebind activity
and further feeding the loop. The result is high CPU overhead and poor
GPU forward progress.

This issue was first reported in [1] and independently observed
internally and by Google.

A simple reproducer is:

- Boot an iGPU system with mem=8G
- Launch 10 Chrome tabs running the WebGL aquarium demo
- Configure each tab with ~5k fish

Under this workload, ftrace shows a continuous loop of:

xe_shrinker_scan (kswapd)
xe_vma_rebind_exec

Performance degrades significantly, with each tab dropping to ~2 FPS on
PTL (Ubuntu 24.04).

At the same time, /proc/buddyinfo shows substantial free memory but no
higher-order availability. For example, the Normal zone:

Count: 4063 4595 3455 3400 3139 2762 2293 1655 643 0 0

This corresponds to ~2.8GB free memory, but no order-9 (2MB) blocks,
indicating severe fragmentation.

This series addresses the issue in three layers:

MM: Introduce an opportunistic_compaction hint in shrink_control.
kswapd folds the gfp flags of its wakers into a per-pgdat tri-state
(see enum kswapd_opportunistic_compaction_type) and forwards it to
shrinkers. The hint is set when every waker for a kswapd run is a
failable high-order allocation (__GFP_NORETRY or __GFP_RETRY_MAYFAIL,
without __GFP_NOFAIL) — i.e. callers that would rather see the
allocation fail than have working sets torn down to satisfy it. Any
order-0 or non-failable waker clears the hint for that run, so normal
memory pressure is unaffected.

TTM: Restrict direct reclaim to beneficial_order. Larger allocations
use __GFP_NORETRY so they fail fast (and feed the opportunistic hint
above) rather than synchronously triggering reclaim that is unlikely
to produce a contiguous higher-order block.

Xe: Consume shrink_control::opportunistic_compaction in the Xe
shrinker. When the hint is set for a high-order pass, the shrinker
skips advertising and performing TTM backup work — which operates at
native page order and would not help compaction — and avoids tearing
down active GPU working sets. Order-0 and non-opportunistic reclaim
behaviour is unchanged, so the shrinker still participates fully
under genuine memory pressure.

With these changes, the reclaim/eviction loop is eliminated. The same
workload improves to ~10 FPS per tab (Ubuntu 24.04) or ~15 FPS per tab
(Ubuntu 24.10), and kswapd activity subsides.

Buddyinfo after applying this series shows restored higher-order
availability:

Count: 8526 7067 3092 1959 1292 660 194 28 20 13 1

Matt

v2:
 - Layer with core MM / TTM helpers (Thomas)
v4:
 - Fix build (CI)
v5:
 - Use shrinker based heurstics (Dave Chinner, Thomas's GFP idea)
 - Rename lazy_compaction → opportunistic_compaction

[1] https://patchwork.freedesktop.org/series/165330/#rev3
[2] https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

Cc: Dave Chinner <david@fromorbit.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kairui Song <kasong@tencent.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
CC: dri-devel@lists.freedesktop.org
Cc: Daniel Colascione <dancol@dancol.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Matthew Brost (5):
  mm: Wire up order in shrink_control
  mm: Introduce opportunistic_compaction concept to vmscan and shrinkers
  drm/ttm: Issue direct reclaim at beneficial_order
  drm/xe: Set TTM device beneficial_order to 9 (2M)
  drm/xe: Make use of shrink_control::opportunistic_compaction hint

 drivers/gpu/drm/ttm/ttm_pool.c   |  4 +-
 drivers/gpu/drm/xe/xe_device.c   |  3 +-
 drivers/gpu/drm/xe/xe_shrinker.c | 20 +++++++--
 include/linux/mmzone.h           | 40 +++++++++++++++++
 include/linux/shrinker.h         | 23 ++++++++++
 mm/internal.h                    |  5 ++-
 mm/shrinker.c                    | 23 +++++++---
 mm/vmscan.c                      | 73 +++++++++++++++++++++++++++++---
 8 files changed, 170 insertions(+), 21 deletions(-)

-- 
2.34.1

