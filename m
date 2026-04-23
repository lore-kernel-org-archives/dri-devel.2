Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29882FAD41B
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CF810EEA3;
	Thu, 23 Apr 2026 05:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="chFmj9F3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FEA10E2F2;
 Thu, 23 Apr 2026 05:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776923823; x=1808459823;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=btSIhHvrWGgObDTIWzYNVZ+z5jS6qcYXkXNJRF89AZY=;
 b=chFmj9F3U7Or0aq1ks6HOCDmgLZKxxo4hRZpN8AUjiPlarVAzfFWbz3O
 MJ9TFmi//CnIL1p1weC+m+Md9hIUUQQr+TS0CcKxdJhiGUQHvfJPKf7DM
 /rfpSjj3LFTFyn3b/BP3jVBlziSGCYki/lFJtcV99rxvPNvJZq5hHSFHI
 p9jBBYzdHshi1ooKDoFSHTHqUrYq6aJcXCYYHLYjqNHdUG6cruC2fqCV9
 NOAJO3mlXtJ7kb1mj68GRO9OewqWvWcaWjg67zUXGFGIxE1jZlbs7SF5d
 iCgB/QJj8ChhD0UsP0eyjaNbw48pwoz71yIcabJwZiD8HZOPmKNqTgbqe Q==;
X-CSE-ConnectionGUID: webMSgdRQY+q5JvEsXYPMg==
X-CSE-MsgGUID: U4/LjU0kSOC8GE5NmRmQpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="89273751"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="89273751"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:02 -0700
X-CSE-ConnectionGUID: +hy0CQC5SiyNHR1QZ8u+FA==
X-CSE-MsgGUID: /E9ZSBlsTNWKC4NsB1t8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="255853889"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 22:57:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
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
Subject: [PATCH v2 0/5] mm, drm/ttm,
 drm/xe: Avoid reclaim/eviction loops under fragmentation
Date: Wed, 22 Apr 2026 22:56:51 -0700
Message-Id: <20260423055656.1696379-1-matthew.brost@intel.com>
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

[1] https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

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
  mm: Introduce zone_appears_fragmented()
  drm/ttm: Issue direct reclaim at beneficial_order
  drm/ttm: Introduce ttm_bo_shrink_kswap_fragmented()
  drm/xe: Set TTM device beneficial_order to 9 (2M)
  drm/xe: Avoid shrinker reclaim from kswapd under fragmentation

 drivers/gpu/drm/ttm/ttm_bo_util.c | 34 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_pool.c    |  4 ++--
 drivers/gpu/drm/xe/xe_device.c    |  3 ++-
 drivers/gpu/drm/xe/xe_shrinker.c  |  3 +++
 include/drm/ttm/ttm_bo.h          |  2 ++
 include/linux/vmstat.h            | 13 ++++++++++++
 6 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.34.1

