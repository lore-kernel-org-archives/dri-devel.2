Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727A1CD4840
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD4510E832;
	Mon, 11 May 2026 16:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QvFHh5NV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9034E10E556;
 Mon, 11 May 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778517751; x=1810053751;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YWYwOFvj4ruAMyqhJydQSYHbtjEA3Coey9HRK1X1L68=;
 b=QvFHh5NVLejdue6E/LhIzw37uOnl36Wk1mYsLI6KJfV3jO1m1P2kCkJw
 s3+L7PS6IcVbEwfnAFQZmXNlWIM0HUbDylmnM61A3yvJ0HVKNBPAtzY3P
 FF6s7KUlDNPvuifj8fyQnuULDGnQI85hlipg4jBGSJtyyDnUYFhyIDriH
 nx5/y1ZTyMzV/SbdcsXKxw4+6tcFaY1ihvYKOMDHgjuEoVaZIGNpuVvnc
 AU+qdO8MS3cAo2MAoAW/OnnzXO0yMArr5lJJifAxgS5IoETz5ylkUWS3H
 uVA4+m96PTomrxZ6SOUYJcRQg/4Tctr/t7C1OPW8DlIAXc2OU0ElGHSK4 w==;
X-CSE-ConnectionGUID: hhUworZsSOmrvtT3xPIF+A==
X-CSE-MsgGUID: +g2QUy8VS/OKRhlJtRx1hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79593716"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="79593716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:42:30 -0700
X-CSE-ConnectionGUID: nuBmSYpRQfC5hzEjiJH8Sw==
X-CSE-MsgGUID: tHeh8wTxSVGPROzpTgAYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="231111051"
Received: from slindbla-desk.ger.corp.intel.com (HELO fdugast-desk.home)
 ([10.245.245.34])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 09:42:28 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v2 0/3] gpu/buddy: Per-order free and used block scoreboards
Date: Mon, 11 May 2026 18:41:03 +0200
Message-ID: <20260511164217.150237-1-francois.dugast@intel.com>
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

v2: Add first patch to fix bug reported by Sashiko [1] then update
    following patches accordingly

[1] https://sashiko.dev/#/patchset/20260504135343.1797869-1-francois.dugast%40intel.com

Francois Dugast (3):
  gpu/buddy: Fix use-after-free in split_block() call sites
  gpu/buddy: Track per-order free blocks with a scoreboard
  gpu/buddy: Track per-order used blocks with a scoreboard

 drivers/gpu/buddy.c         | 86 ++++++++++++++++++++++++++-----------
 drivers/gpu/drm/drm_buddy.c | 30 ++++++-------
 include/linux/gpu_buddy.h   | 15 +++++++
 3 files changed, 88 insertions(+), 43 deletions(-)

-- 
2.43.0

