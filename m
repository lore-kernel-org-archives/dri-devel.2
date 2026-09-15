Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75400C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACAA10E59D;
	Tue, 15 Sep 2026 18:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UcaHnmjj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206B010E4C0;
 Tue, 15 Sep 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497538; x=1821033538;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=he/XPig/uPsUn21JLshRP4nbLaHW1ZtzvlAQ5TaIbRs=;
 b=UcaHnmjjluFEYAJq4C1KQLJvXRbMCKjuJdBbkbdDZYOy5WBgzcCtQKGU
 0fPeltzWzupJuKLKZmXCqMjNZY4PeiT8TyjHCMXjFybTDXmr3s9IjvR1y
 sUxKz9K2F9ZSK8DjCmcwyzOMtxTESYoxZbqGlSz983I1d3zbc6jFSTnKv
 0vqd9j4KXgd/fYkavErFy5rPFMgqL8mGgKs8BVIv7zJYPK64Xruly9OGy
 kRI1hrMruqEDo4UiUOFK3fxRxPMJb9tLVuGmOQG2jg33TrD2pxDsatvla
 24g3GL8OnXzP208N3/kn332Ipgb0WJcXnsi58Jfl7pHSgtDAAmdAxU/5A w==;
X-CSE-ConnectionGUID: mwFaa1+sQh2NXfgNQbEYbQ==
X-CSE-MsgGUID: d8n/MYrYTf+UdxC2Azt2ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380252"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380252"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:38:56 -0700
X-CSE-ConnectionGUID: +9lQygFMROe4dNrCEm4+mw==
X-CSE-MsgGUID: /RoUaHHtTEO3mH096GRd/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148436"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:38:54 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 00/18] Enable DP2.1 alpm
Date: Tue, 15 Sep 2026 23:34:31 +0530
Message-Id: <20260915180449.277933-1-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
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

ALPM support added on DP2.1 and xe3p will support DP2.1 alpm.
This patch series extending alpm supoort for DP2.1.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>

Animesh Manna (18):
  drm/i915/alpm: Add DPCD definition for DP2.1 ALPM capability
  drm/i915/alpm: Move alpm sink capability readout into a separate
    function
  drm/i915/alpm: alpm_init() for DP2.1
  drm/i915/alpm: Enable debugfs for DP2.1
  drm/i915/alpm: Refactor Auxless wake time calculation
  drm/i915/alpm: Auxless wake time calculation for Xe3p
  drm/i915/alpm: Modify AUX_LESS_WAKE_TIME bitfield for xe3lpd
  drm/i915/alpm: table based establishment period
  drm/i915/alpm: Half LFPS cycle calculation
  drm/i915/alpm: Modify LFPS cycle count for DP ALPM
  drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield for xe3lpd
  drm/i915/alpm: Program LTTPR count for DP 2.1 ALPM
  drm/i915/alpm: Enable MAC Transmitting LFPS for LT PHY
  drm/i915/alpm: Replace is_edp() with alpm_is_possible()
  drm/i915/alpm: Introduce has_alpm to decouple from pr/psr2/lobf
  drm/i915/alpm: Compute and program switch to active latency
  drm/i915/alpm: Program zero-based LFPS half cycle duration
  drm/i915/alpm: Disallow ALPM for UHBR link rate

 drivers/gpu/drm/i915/display/intel_alpm.c     | 359 +++++++++++++++---
 drivers/gpu/drm/i915/display/intel_alpm.h     |   7 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |   6 +-
 drivers/gpu/drm/i915/display/intel_ddi.c      |   5 +-
 .../drm/i915/display/intel_display_types.h    |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  15 +-
 .../drm/i915/display/intel_dp_link_training.c |  21 +
 drivers/gpu/drm/i915/display/intel_lt_phy.c   |  27 ++
 drivers/gpu/drm/i915/display/intel_lt_phy.h   |   2 +
 .../gpu/drm/i915/display/intel_lt_phy_regs.h  |   3 +
 drivers/gpu/drm/i915/display/intel_psr.c      |  48 ++-
 drivers/gpu/drm/i915/display/intel_psr.h      |   1 -
 drivers/gpu/drm/i915/display/intel_psr_regs.h |  16 +-
 include/drm/display/drm_dp.h                  |   4 +-
 14 files changed, 433 insertions(+), 83 deletions(-)

-- 
2.29.0

