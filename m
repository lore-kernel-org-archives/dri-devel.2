Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64535CD3430
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 13:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD58910E701;
	Mon,  4 May 2026 13:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="oDUKslU4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D913710E6FF;
 Mon,  4 May 2026 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777902840; x=1809438840;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FzY8uE6pN4uhpQEukplO4gg6rd09SrP4c9OsvoLwbWM=;
 b=oDUKslU4IKHuqpKoK3CDIul49+szT50sNgRrrkTTwS2WYjAhjQNvmmyR
 pvrYZg9v7FVLhCMYbtBOmlh1hVAklAASPeApAWaWfunc+cOMizdbYa9mO
 H8JFI4hop21rhcFpjRFfmZ9ZvWTyVGWpaqepcSuYtNDHnGINhUleLqEHQ
 tFZeUjnBH0KlyOM5t9x2h8T65bDhA3vhI5+WdBboYcxDQeLyo5AD+SQcK
 SZagHOsuHfbiUrqNckSa9fHfXysKyzaKmZK7M7+aWEN++YPg3TSHasjwQ
 RzEDcJoiJkqmEpriWh//87hjd02+M7aFS7bQNwoNK+pKv+eFn6B8JTrEm Q==;
X-CSE-ConnectionGUID: zvepVLu/RRi15XMM9n8V/w==
X-CSE-MsgGUID: aIN/QBMESAaUzfAR5CGgIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89065436"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="89065436"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:54:00 -0700
X-CSE-ConnectionGUID: E9g2Fx7BSc+dzWNoBRvu1Q==
X-CSE-MsgGUID: Oub21O4ZTxqBetKWzNeHGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="230930213"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.245.110])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 06:53:58 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH 0/2] gpu/buddy: Per-order free and used block scoreboards
Date: Mon,  4 May 2026 15:52:40 +0200
Message-ID: <20260504135343.1797869-1-francois.dugast@intel.com>
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

Francois Dugast (2):
  gpu/buddy: Track per-order free blocks with a scoreboard
  gpu/buddy: Track per-order used blocks with a scoreboard

 drivers/gpu/buddy.c         | 60 +++++++++++++++++++++++++------------
 drivers/gpu/drm/drm_buddy.c | 20 ++++---------
 include/linux/gpu_buddy.h   | 15 ++++++++++
 3 files changed, 61 insertions(+), 34 deletions(-)

-- 
2.43.0

