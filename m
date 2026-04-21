Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF009F5A8D1
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 01:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E72F10E795;
	Tue, 21 Apr 2026 01:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nqk6Xf1q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E61910E0E0;
 Tue, 21 Apr 2026 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776734775; x=1808270775;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xPODyy7SzvTSNwjlALlA8TaMiw0qaao3Be2hp2hnIkM=;
 b=nqk6Xf1qVxJPjzKMYKJOA3IF4TYTP9wVHSWJk2LdJvYmwLnqso3YLSfG
 6cJERWE8h58zxiKKU6wlfMQNcld3HJuMWMnWCEQsXYFmlGtYRHu/D+pdy
 O12wVInYR5J8lnVtgRqE6tAFvzudVrnUGqYOVjJO3JAP+8OTCiGP8oieU
 YceGo1ZwHBqw+GaVmp2lCF+9kYUxfsC5iAO/Crs8tWLz66Sle1KH1ewBQ
 R0JvCswxjb5evfmwNWwgcHG4qzZZ/UidCZvKOXUWuUJT/9HS1UTmyBHO3
 BLWeNZe74m3khq/wFSFkBHCWun9tEkLOuvhi06TUmYp8qgP0fQkTU4NOt A==;
X-CSE-ConnectionGUID: HrhOYSI3QJWAejzPm/o8Ig==
X-CSE-MsgGUID: hGfzIFn2R62prxQO8S4nKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88280321"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="88280321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:15 -0700
X-CSE-ConnectionGUID: hUmDbGclTL6nzb8MEK3jNw==
X-CSE-MsgGUID: uvecCOauSoKPsCgPkMVnBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="236872337"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 18:26:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Colascione <dancol@dancol.org>
Subject: [PATCH 0/3] drm/ttm,
 drm/xe: Avoid reclaim/eviction loops under fragmentation
Date: Mon, 20 Apr 2026 18:26:05 -0700
Message-Id: <20260421012608.1474950-1-matthew.brost@intel.com>
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
PTL.

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
workload improves to ~10 FPS per tab, and kswapd activity subsides.

Buddyinfo after applying this series shows restored higher-order
availability:

Count: 8526 7067 3092 1959 1292 660 194 28 20 13 1

Matt

[1] https://patchwork.freedesktop.org/patch/716404/?series=164353&rev=1

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

Matthew Brost (3):
  drm/ttm: Issue direct reclaim at beneficial_order
  drm/xe: Set TTM device beneficial_order to 9 (2M)
  drm/xe: Avoid shrinker reclaim from kswapd under fragmentation

 drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
 drivers/gpu/drm/xe/xe_device.c   |  3 ++-
 drivers/gpu/drm/xe/xe_shrinker.c | 13 +++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.34.1

