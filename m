Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81519CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C0110E5DA;
	Mon, 18 May 2026 14:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a9gVuZfP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65BB10E5DA;
 Mon, 18 May 2026 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779113698; x=1810649698;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tR0KxukUXrz2IgbVSJNBiQdUnGpksWcRCLl4DzgPNZE=;
 b=a9gVuZfP538cYe6oF4Fp9KmT+cSp2PiCOVh1xZOFWnzQHuA7K74v7bkp
 mR125Z/LQz5TkdadFPqZqAeOl7trFCbCjqccwua3+URF0NX8404qtqFFS
 DLqo9UqTg6VNyC21pZCLoIW5zeSzUj0J84NFlS/Gabwbp2gBwRFPvx/au
 D7jTMte4eIeORvCBCTux2iLxALT5hGSxEnSvaptBU8TKyMbHk9sdBEvZx
 nd10PsiobRTpps5y3W8P/StEnKmrSI/4/fiKLWuvpNMFRHDMEMb3QrgD1
 NShMpyt1SQFKT522VRGZOluz7Ar1HFVO2l0dooXmtmMkglKvK/bLpQfGw g==;
X-CSE-ConnectionGUID: fZnmRhszTaOCKW/aLb1ktg==
X-CSE-MsgGUID: dLiUmSKsRESvF47f6PXxmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79105893"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="79105893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:14:58 -0700
X-CSE-ConnectionGUID: 63s+UT/nTb6ss9JSzLX8Sg==
X-CSE-MsgGUID: M3AHzj8NQxqlepRx1jWVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="244417238"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.244.73])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:14:56 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 0/5] gpu/buddy: Per-order free and used block scoreboards
Date: Mon, 18 May 2026 16:14:25 +0200
Message-ID: <20260518141446.124508-1-francois.dugast@intel.com>
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

 drivers/gpu/buddy.c         | 104 ++++++++++++++++++++++--------------
 drivers/gpu/drm/drm_buddy.c |  30 +++++------
 include/linux/gpu_buddy.h   |  15 ++++++
 3 files changed, 90 insertions(+), 59 deletions(-)

-- 
2.43.0

