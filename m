Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258AAC44528
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE1010E652;
	Mon, 20 Jul 2026 05:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ur4X9zEX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A8010E0BB;
 Mon, 20 Jul 2026 05:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524534; x=1816060534;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Bor3Snf0+8fXie6EP3F3N8OGVWxl9ZJLoZwXzQh8Pm0=;
 b=Ur4X9zEXvyrev7shnM64qLyUICWdpZqYa7a6fZNxz/ntJWq+TSEudyy6
 eR63VY/KpJ1g71Hzx0Lt2qCZRjjAGOTeiownSdgI+M7koGids2GovKvn2
 HYY5DBEju9tDgU7fkJ7vuHrIK9hTJb5Jr//CNsIf29Wm7djkIjIGAmI8r
 WT4s84cbSBW+90kkbF+gSUJ13MZm//ccca6UvLk1whBdqVzVV2xpvCU8z
 PVgN1Q02Uyc0NArsr0wWaX8wcZgkH6OvgpHjFvXROTwALKyWf1KQVoodO
 z97HMLVjulkMNcH5cgDLyIXg+UDQmHM9pq7U5N+PSUMrFTAfdWi2Bec1q w==;
X-CSE-ConnectionGUID: /uKYBEGpSbaviHS/HXxtEQ==
X-CSE-MsgGUID: tkapwXDoT0eIQWk+chmoFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133389"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133389"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:33 -0700
X-CSE-ConnectionGUID: Dq46ZkHDQIy4UrbuGq8itQ==
X-CSE-MsgGUID: w/tRIeosR9KeSo4DILn9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419757"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:30 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Uma Shankar <uma.shankar@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@intel.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Pranay Samala <pranay.samala@intel.com>,
 Swati Sharma <swati2.sharma@intel.com>,
 Naveen Kumar <naveen1.kumar@intel.com>
Subject: [v5 00/14] drm/i915/color: Enable SDR plane color pipeline
Date: Mon, 20 Jul 2026 10:21:17 +0530
Message-Id: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This series adds color pipeline support for SDR planes in i915 and
exposes the functionality to userspace through the DRM colorop
framework.

In contrast to HDR planes, SDR planes have LUTs with smaller sizes
and a fixed function CSC block in contrast to a programmable CTM.

The series first introduces a new DRM colorop type,
DRM_COLOROP_FIXED_MATRIX, which represents fixed-function CSC blocks where
userspace selects predefined hardware conversion modes instead of
programming arbitrary matrices. It also adds the YUV correction HW block.
With this the color pipeline can accept both limited range and full range
YUV framebuffers.

With that, the SDR plane color pipeline looks like.

[YUV Range Correct] -> [1D LUT] -> [CSC] -> [1D LUT]

v2:
 - Naming changes [Pekka]
 - Adds YUV color range correct block

v3:
 - Fix NC matrix enum name and string [Melissa]
 - Extract and simplify glk_plane_color_ctl_input_csc into
   helpers (new prep patches)
 - Restructure SDR pre/post-CSC LUT loops to match HDR function
   pattern
 - Drop HDR pre-CSC LUT clamping fix (submitted separately)
 - Rebase

v4:
 - For CI
 - Rebase

v5:
- Do not skip programming legacy property if color pipeline is not set.
  Support for YUV buffers in color pipeline uAPI is a work in progress.
  Therefore, color-pipeline-aware userspace might still use the legacy
  COLOR_RANGE and COLOR_ENCODING property while keeping the color
  pipeline to Bypass. Therefore, skip programming based on legacy
  properties only when a color pipeline is set.


IGT series (needs update): https://patchwork.freedesktop.org/series/165021/
A rough updated IGT implementation with some additional test can be found here.
https://github.com/ckborah/igt-sandbox/tree/color/sdr-sw-ref

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@intel.com>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Pranay Samala <pranay.samala@intel.com>
Cc: Swati Sharma <swati2.sharma@intel.com>
Cc: Naveen Kumar <naveen1.kumar@intel.com>

Chaitanya Kumar Borah (10):
  drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
  drm/i915/color: Add CSC on SDR plane color pipeline
  drm/i915/display: extract glk_plane_color_ctl_input_csc helper
  drm/i915/display: simplify glk_plane_color_ctl_input_csc
  drm/i915/display: Track CSC mode in intel plane state
  drm/i915/display: Program input CSC on SDR planes
  drm/i915/color: Add YCbCr limited-to-full range color block support
  drm/i915/color: Add YUV range correction to SDR plane pipeline
  drm/i915/color: Add support for 1D LUT in SDR planes
  drm/i915/color: Add color pipeline support for SDR planes

Pranay Samala (4):
  drm/i915/color: Extract HDR pre-CSC LUT programming to helper function
  drm/i915/color: Program Pre-CSC registers for SDR
  drm/i915/color: Extract HDR post-CSC LUT programming to helper
    function
  drm/i915/color: Program Plane Post CSC registers for SDR planes

 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
 drivers/gpu/drm/drm_colorop.c                 | 106 +++++++++++++
 drivers/gpu/drm/i915/display/intel_color.c    | 140 +++++++++++++++---
 .../drm/i915/display/intel_color_pipeline.c   |  43 +++++-
 .../drm/i915/display/intel_display_limits.h   |   2 +
 .../drm/i915/display/intel_display_types.h    |   3 +
 drivers/gpu/drm/i915/display/intel_plane.c    |  15 +-
 .../drm/i915/display/skl_universal_plane.c    |  81 +++++++---
 include/drm/drm_colorop.h                     |  84 +++++++++++
 include/uapi/drm/drm_mode.h                   |  12 ++
 11 files changed, 445 insertions(+), 52 deletions(-)

-- 
2.25.1

