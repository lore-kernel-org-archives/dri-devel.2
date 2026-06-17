Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1707CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 03:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEBD110E90B;
	Wed, 17 Jun 2026 03:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="inB0RHD+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880CE10E7FE;
 Wed, 17 Jun 2026 03:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781666547; x=1813202547;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=84O97qTDilDn95yjtESFooPy0tR2mZAlQQWrqQIVeU8=;
 b=inB0RHD+y40yJUFyLTylnI8e1+IxemFlaTnLT9Si7lByIvAlX+c+2/Pp
 UQkIHTtZhEgvTIwpdp6vd8Os9YPPGX1LG5WFnNYwir1EHw1bgUdY0QYC9
 jKhKJWOS4gOgH9aviMh0Xeusaa7WGRWanj+NSZjaQxur/Mgr0oyS7L2BS
 CWnJv7vER7dMTm0kp5uzKTiPKq0mjnStt3aGY2ESbYnX/aQ3t8jL0hbDl
 OVjnJvbiSrzuhyf7mwBM44tQ7FzAhZ4ztrGznLqgpFzQXVhiALz+dRK2h
 +4pZSLFIa+HP5y7iqi/vrP+IhCMKnlS9qnf+3MSDt7+JCWtFFPJThEleY Q==;
X-CSE-ConnectionGUID: VypuMcsoQ2WRYCIB2/pYJw==
X-CSE-MsgGUID: m5rs3gVZSsqSsdOsOR9iVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="107914535"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="107914535"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 20:22:26 -0700
X-CSE-ConnectionGUID: 9z/ROdvTT3aAhlYNvsMV2A==
X-CSE-MsgGUID: 4foYZTSmQPiUg06iRxuMUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="248017805"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 20:22:26 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v6 0/2] mm,
 drm/xe: Avoid reclaim/eviction loops under fragmentation
Date: Tue, 16 Jun 2026 20:22:16 -0700
Message-Id: <20260617032218.1165929-1-matthew.brost@intel.com>
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

Continuation of [1].

TTM allocations at higher orders can drive Xe into a pathological
reclaim loop when memory is fragmented:

kswapd → shrinker → eviction → rebind (exec ioctl) → repeat

In this state, reclaim is triggered despite substantial free memory,
but fails to produce contiguous higher-order pages. The Xe shrinker then
evicts active buffer objects, increasing faulting and rebind activity
and further feeding the loop. The result is high CPU overhead and poor
GPU forward progress.

This issue was first reported in [2] and independently observed
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

This series addresses the issue in two layers:

MM: Introduce an opportunistic_compaction hint in shrink_control.
kswapd folds the gfp flags of its wakers into a per-pgdat tri-state
(see enum kswapd_opportunistic_compaction_type) and forwards it to
shrinkers. The hint is set when every waker for a kswapd run is a
failable high-order allocation (__GFP_NORETRY or __GFP_RETRY_MAYFAIL,
without __GFP_NOFAIL) — i.e. callers that would rather see the
allocation fail than have working sets torn down to satisfy it. Any
order-0 or non-failable waker clears the hint for that run, so normal
memory pressure is unaffected. Similarly direct recliam sets the
opportunistic_compaction hint based caller's gfp_mask and order.

Xe: Consume shrink_control::opportunistic_compaction in the Xe
shrinker. When the hint is set for a high-order pass, the shrinker
skips advertising and performing TTM backup work — which operates at
native page order and would not help compaction — and avoids tearing
down active GPU working sets.

With these changes, the reclaim/eviction loop is eliminated. The same
workload improves to ~10 FPS per tab (Ubuntu 24.04) or ~15 FPS per tab
(Ubuntu 24.10), and kswapd activity subsides.

Buddyinfo after applying this series shows restored higher-order
availability:

Count: 8526 7067 3092 1959 1292 660 194 28 20 13 1

In addition various 3D benchmarks show signicant improvement memory is
fragmented.

v2:
 - Layer with core MM / TTM helpers (Thomas)
v4:
 - Fix build (CI)
v5:
 - Use shrinker based heurstics (Dave Chinner, Thomas's GFP idea)
 - Rename lazy_compaction → opportunistic_compaction
v6:
 - Drop order in shrink_control rely only on opportunistic_compaction
   hint (Testing)
 - Set opportunistic_compaction in direct reclaim (Testing)
 - Drop unrelated TTM which merged independently

[1] https://patchwork.freedesktop.org/series/165329/
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

Matthew Brost (2):
  mm: Introduce opportunistic_compaction concept to vmscan and shrinkers
  drm/xe: Make use of shrink_control::opportunistic_compaction hint

 drivers/gpu/drm/xe/xe_shrinker.c | 20 ++++++-
 include/linux/mmzone.h           | 40 ++++++++++++++
 include/linux/shrinker.h         | 20 +++++++
 mm/internal.h                    |  2 +-
 mm/shrinker.c                    | 13 +++--
 mm/vmscan.c                      | 95 +++++++++++++++++++++++++++++---
 6 files changed, 174 insertions(+), 16 deletions(-)

-- 
2.34.1

