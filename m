Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E1CCD3425
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65EC610EEEE;
	Thu, 30 Apr 2026 19:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LcVpwXBv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77BD10E165;
 Thu, 30 Apr 2026 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777576695; x=1809112695;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L42AqUAT3K2YUIBwfKldplRFGyIb5HBQqwcfYoydKXo=;
 b=LcVpwXBvnHH2vKrYfd1r6JMcX7wWMq8gJzNtgmelOUMpN9b6oOPKGJH9
 nC9MUUPfl1zS143RqXObM1o6ElFgfuK32v8MRXMhI2bvuKVm7EPHDFHIK
 4Yjy7voALTgrPAw/B1TTfc7lkhEyTKHMSd3UhiPRLXyoy0fRwZEIlVtVe
 5FSpUHWq947w9OjnUlqITsQObGr8qIWn2u2RudjTtHINdQ3kOUIib2a6j
 tDiYrKOP6nogmzBGdEXJgRqOWtssJ4yeGGp7qb/oUeKfGC5jejNc0JaSW
 2J4ZMguY93OPwLCE/o9KfTfRQdgXjzuDOq6+BNlMFuoqtNRGpUSlngXSb A==;
X-CSE-ConnectionGUID: o6ioT+yzSTaJVEIIog5EtQ==
X-CSE-MsgGUID: CXv25bn0RfqTsP/idfre2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77706722"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="77706722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:14 -0700
X-CSE-ConnectionGUID: GvPf6uxBSM6MkFg5UrhPnA==
X-CSE-MsgGUID: dEMwV383Q5yUPDG4MwmODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233801143"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 12:18:14 -0700
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
Subject: [PATCH v4 0/6] mm, drm/ttm,
 drm/xe: Avoid reclaim/eviction loops under fragmentation
Date: Thu, 30 Apr 2026 12:18:03 -0700
Message-Id: <20260430191809.2142544-1-matthew.brost@intel.com>
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

This series addresses the issue in two ways:

TTM: Restrict direct reclaim to beneficial_order. Larger allocations
use __GFP_NORETRY to fail quickly rather than triggering reclaim.

Xe: Introduce a heuristic in the shrinker to avoid eviction when
running under kswapd and the system appears memory-rich but
fragmented.

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

[1] https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

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

Matthew Brost (6):
  mm: Wire up order in shrink_control
  mm: Introduce zone_maybe_fragmented_in_shrinker()
  drm/ttm: Issue direct reclaim at beneficial_order
  drm/ttm: Introduce ttm_bo_shrink_kswap_maybe_fragmented()
  drm/xe: Set TTM device beneficial_order to 9 (2M)
  drm/xe: Avoid shrinker reclaim from kswapd under fragmentation

 drivers/gpu/drm/ttm/ttm_bo_util.c | 38 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_pool.c    |  4 ++--
 drivers/gpu/drm/xe/xe_device.c    |  3 ++-
 drivers/gpu/drm/xe/xe_shrinker.c  |  3 +++
 include/drm/ttm/ttm_bo.h          |  2 ++
 include/linux/shrinker.h          |  3 +++
 include/linux/vmstat.h            | 12 ++++++++++
 mm/internal.h                     |  4 ++--
 mm/shrinker.c                     | 13 +++++++----
 mm/vmscan.c                       |  7 +++---
 10 files changed, 76 insertions(+), 13 deletions(-)

-- 
2.34.1

