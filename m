Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F394BCD98D9
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7707910F5A3;
	Fri, 12 Jun 2026 14:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LUnzlvY0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1AD10F584;
 Fri, 12 Jun 2026 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781275329; x=1812811329;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2YOagCYi0IYeJMZzYtNNKERNuUNkrmae2rtTf13pKWY=;
 b=LUnzlvY05qV8HQdrStdDgskUQdbvmrBkC7Q8yw1n6xyLXJR4l9yl/HL7
 2ciZ2/7MFzuCMnkWFVhpVz46BHIZD1PHzKPiv0/QA4/5zt4bM5Pqam6Zu
 jxxC1vCmTQgt5PQ67MkdlplAZMfrh92ds4RP3UBmpzyE/6Cu0EeuTKJYH
 d4quNQOA5Bo6vAN7iYvk+nrUrIbJUD5ieOMrm7mhUQhDgCQees9WSN7Md
 KB6mEMDdNKZQ4SfdgNPrdhONWYlPZmdcR31pUcFaBkp4/Ij/w9sZSLcXV
 IlJcXJoCoYjg2Aza8huO9qvnkH3SFJWjvtVlAz0VWJV/5yohDJqxYjxoV w==;
X-CSE-ConnectionGUID: 2FvuJZ5pQOS8K5HypZ43YA==
X-CSE-MsgGUID: oQYMzw+jQx+BV56Jb6QuSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93598212"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="93598212"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 07:42:09 -0700
X-CSE-ConnectionGUID: UM72L1gARkC+UwyaCIM9lw==
X-CSE-MsgGUID: WlgPhU32TR6xCOTogZLmgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245732726"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 07:42:08 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh rate
 changes on eDP
Date: Fri, 12 Jun 2026 17:41:59 +0300
Message-ID: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Tweak the eDP fixed mode selection algorithm to allow
userspace to do refresh rate changes on VRR capable
eDP panels without full modesets.

Ville Syrjälä (4):
  drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
  drm/i915: Pass the full atomic state to .compute_config()
  drm/i915/panel: Adjust intel_panel_compute_config() calling convention
  drm/i915/panel: Attempt VRR based refresh rate change for
    !allow_modeset

 drivers/gpu/drm/drm_modes.c                   | 23 +++++++
 drivers/gpu/drm/i915/display/g4x_dp.c         |  5 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c       |  4 +-
 drivers/gpu/drm/i915/display/icl_dsi.c        |  5 +-
 drivers/gpu/drm/i915/display/intel_crt.c      |  9 ++-
 drivers/gpu/drm/i915/display/intel_ddi.c      |  8 ++-
 drivers/gpu/drm/i915/display/intel_display.c  |  4 +-
 .../drm/i915/display/intel_display_types.h    |  6 +-
 drivers/gpu/drm/i915/display/intel_dp.c       |  6 +-
 drivers/gpu/drm/i915/display/intel_dp.h       |  3 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  8 +--
 drivers/gpu/drm/i915/display/intel_dvo.c      |  5 +-
 drivers/gpu/drm/i915/display/intel_lvds.c     |  5 +-
 drivers/gpu/drm/i915/display/intel_panel.c    | 61 ++++++++++++++++---
 drivers/gpu/drm/i915/display/intel_panel.h    |  6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |  7 ++-
 drivers/gpu/drm/i915/display/intel_tv.c       |  5 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c        |  5 +-
 include/drm/drm_modes.h                       |  1 +
 19 files changed, 131 insertions(+), 45 deletions(-)

-- 
2.53.0

