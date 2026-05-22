Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F74CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 09:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E1010E030;
	Fri, 22 May 2026 09:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TprRCqWe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B256810E030;
 Fri, 22 May 2026 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779441985; x=1810977985;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fpdI/kdpJLU6d22ws62mELIpMUvkwY1SwaF5wqLgGZw=;
 b=TprRCqWeoXMSTApCXWzMGJsiTOOA/7oAqiaqCsratOEAVe1RzYKOtke9
 O/X86HJEfJJZfeqiY3D0nvwwYE0d7/4fqudSKRYiSGJ9sDWKTuUgcpr8X
 L3w+bnlpwAs0giJfIqCtlJ72rv9lB92i7TY1ihddcyVYkrmQIDvFMTfaX
 dz8x5556/P7AN9qOMKi+d0SK4HgsHiSH8HthDdgg7cGWSjGCSm1xuIhNi
 qjIpdgKJbRlhJGW59tQGXS0Q+xbVwaAtTa2j6Hx/xbIS/D8nQq1gqvX9B
 Tg9+admnbVyZMBgJZypypFPorJ92aTunQPS5lQHsxqe8eJ5ySgPTyuUM5 w==;
X-CSE-ConnectionGUID: pCnkVPIIQDS8jys275FTfQ==
X-CSE-MsgGUID: CqW+a3rUQ3K3QKsH5Udw5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67895297"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="67895297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:24 -0700
X-CSE-ConnectionGUID: Bxnv5z69Q4qYUpP2D0wQew==
X-CSE-MsgGUID: UcTQ+CAkT3GTYkjjPVNQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="237830291"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.244.230])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 02:26:23 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Arunpravin.PaneerSelvam@amd.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v4 0/5] gpu/buddy: Per-order free and used block scoreboards
Date: Fri, 22 May 2026 11:25:27 +0200
Message-ID: <20260522092600.32818-1-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
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

drm_buddy_print() currently reports per-order free block counts by
walking all rbtrees, which is O(n) in the total number of free blocks
and holds the allocator lock for the duration. On large VRAM heaps with
many small fragments this becomes expensive.

This series replaces the rbtree walk with two lightweight scoreboard
arrays — free_scoreboard and used_scoreboard — indexed by order and
maintained incrementally at the points where block state transitions
occur. The print functions become simple array lookups, and drivers
reading debugfs (/sys/kernel/debug/dri/0/tile0/vram_mm) now get both
free and used counts per order at O(1) cost.

v4: Assert used_scoreboard is empty at fini()

v3: Add __gpu_buddy_undo_splits() helper as suggested by Matt

v2: Add first patch to fix bug reported by Sashiko [1] then update
    following patches accordingly

Francois Dugast (5):
  gpu/buddy: Fix use-after-free in split_block() call sites
  gpu/buddy: Remove redundant condition in alloc_from_freetree() error
    path
  gpu/buddy: Introduce __gpu_buddy_undo_splits() helper
  gpu/buddy: Track per-order free blocks with a scoreboard
  gpu/buddy: Track per-order used blocks with a scoreboard

 drivers/gpu/buddy.c         | 107 ++++++++++++++++++++++--------------
 drivers/gpu/drm/drm_buddy.c |  30 ++++------
 include/linux/gpu_buddy.h   |  15 +++++
 3 files changed, 93 insertions(+), 59 deletions(-)

-- 
2.43.0

