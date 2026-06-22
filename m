Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E463DCDB470
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:36:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2370C10E8B8;
	Mon, 22 Jun 2026 21:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lDPMKuPp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2DA10E871;
 Mon, 22 Jun 2026 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782164169; x=1813700169;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BIfpUsn/0OSrfLZGMqDoPrNmWunHZK6NnheRC5tKfDU=;
 b=lDPMKuPptY6WNW4caDsNlwro5MiQsyBzN100SbgwVSbwwFAVxgWnAT3I
 uNHAEuBRdDT1VDw8PMmcxsIt3GkbNZ6adx+X+kjz4jrXV5X5jHkNSNsD0
 VSaToMPwF75zFiROGmM6WjIGz2skrejtxnRAmw+d8p2CrrysKwFrN2pUL
 +XbPx4QJeC6UPUebD+n4oYZx4CP46+7OVxIaMiGDJJHGj9ohcjhw5mAsw
 OUK13pJzmCaynAN1BSMV9tuAJt1yJCiJbIC2Iwt5ogvzoAgAILBWt1oeE
 jwVrPlqE5/+6xieUEEHpUssEeioIsrEZYOHiscYpBgtcMhWULG8IYFHS7 w==;
X-CSE-ConnectionGUID: Mb75aceAS1GgoezdqrQwCg==
X-CSE-MsgGUID: bjQGQOFfRu6MmZdvP9CfMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86812055"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="86812055"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 14:36:08 -0700
X-CSE-ConnectionGUID: SfiLt37+TbmlPekVkdVimA==
X-CSE-MsgGUID: vG+sxAf3TA+oE5F4x+eKKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="253229744"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.160])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 14:36:06 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v2 0/5] drm/i915: Work harder to enable VRR based refresh rate
 changes on eDP
Date: Tue, 23 Jun 2026 00:35:57 +0300
Message-ID: <20260622213602.7244-1-ville.syrjala@linux.intel.com>
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

v2: Cleaner split for VRR vs. fixed refresh rate fixed mode
    selection to avoid some corner cases

Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

Ville Syrjälä (5):
  drm/i915/panel: Split VRR vs. fixed refresh rate fixed mode selection
    into separate stages
  drm/modes: Add DRM_MODE_MATCH_TIMINGS_VRR
  drm/i915: Pass the full atomic state to .compute_config()
  drm/i915/panel: Adjust intel_panel_compute_config() calling convention
  drm/i915/panel: Attempt VRR based refresh rate change for
    !allow_modeset

 drivers/gpu/drm/drm_modes.c                   |  23 +++
 drivers/gpu/drm/i915/display/g4x_dp.c         |   5 +-
 drivers/gpu/drm/i915/display/g4x_hdmi.c       |   4 +-
 drivers/gpu/drm/i915/display/icl_dsi.c        |   5 +-
 drivers/gpu/drm/i915/display/intel_crt.c      |   9 +-
 drivers/gpu/drm/i915/display/intel_ddi.c      |   8 +-
 drivers/gpu/drm/i915/display/intel_display.c  |   4 +-
 .../drm/i915/display/intel_display_types.h    |   6 +-
 drivers/gpu/drm/i915/display/intel_dp.c       |   6 +-
 drivers/gpu/drm/i915/display/intel_dp.h       |   3 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |   8 +-
 drivers/gpu/drm/i915/display/intel_dvo.c      |   5 +-
 drivers/gpu/drm/i915/display/intel_lvds.c     |   5 +-
 drivers/gpu/drm/i915/display/intel_panel.c    | 167 +++++++++++++-----
 drivers/gpu/drm/i915/display/intel_panel.h    |   6 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |   7 +-
 drivers/gpu/drm/i915/display/intel_tv.c       |   5 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c        |   5 +-
 include/drm/drm_modes.h                       |   1 +
 19 files changed, 203 insertions(+), 79 deletions(-)

-- 
2.53.0

