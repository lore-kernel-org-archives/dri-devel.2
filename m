Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E9C55184
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBF310E144;
	Tue,  4 Aug 2026 12:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l97IDUcV";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3024710E144;
 Tue,  4 Aug 2026 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848101; x=1817384101;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IXjlgo6HpnwLHgWz7EQ0ryHAqlC5Qz9uv6WqFlK4L6c=;
 b=l97IDUcVg2KNhf61kGSNkRT+QsBwN2OA5vTeJmef/8dIAEVvU4NY4zjd
 tm8D3agBQDkLZ53zwxojT3HpAFxVAveotrxNbiJnr9Avh/uXDv3sIhYOn
 TwjhMbxFcld0EPZfvgT/YoNNVD6qua2IQ+blFB/VhccJJvf0MkFjQBlKn
 Wlw14lPVGRFtvZd3+3BPCZvVnfgxIf5AeJlBH3p+t+OsVLupdHLUPltMy
 IhicyewiLvvaZKtM1ofFxegjo8sdElJr/Kt2k5cUPBbvzHapa4rWSJ9y1
 4HM0vW3MfKRZY/d0iFOVOlI3h16BiHLO1iXnXyR0AXpS1Z4npkhLT6hlm w==;
X-CSE-ConnectionGUID: yaiD3aBQSbWxoWzWA24MzA==
X-CSE-MsgGUID: 4wlbxc1ATL+gVbxkb7DfMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073186"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073186"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:00 -0700
X-CSE-ConnectionGUID: OBkRCkMJRdmYBi2ERZ+Vig==
X-CSE-MsgGUID: KKGKtxxQT0+dR/9/33fC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108215"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:54:55 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
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
 Naveen Kumar <naveen1.kumar@intel.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [v6 0/9] drm/i915/color: Enable SDR plane color pipeline
Date: Tue,  4 Aug 2026 18:00:58 +0530
Message-ID: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.50.1
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

v6:
- Drop YCbCr limited-to-full and RGB709-to-RGB2020 matrices
  until there is a non-IGT userspace implementation. [Robert]
- Drop pre-CSC LUT and YUV range correct blocks from the
  pipeline in favor of a simpler [CSC] -> [1D LUT] pipeline.
  The Fixed Matrix CSC handles both full and limited range
  YCbCr conversions internally.


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
Cc: Robert Mader <robert.mader@collabora.com>

Chaitanya Kumar Borah (7):
  drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
  drm/i915/color: Add CSC on SDR plane color pipeline
  drm/i915/display: extract glk_plane_color_ctl_input_csc helper
  drm/i915/display: simplify glk_plane_color_ctl_input_csc
  drm/i915/display: Program CSC on SDR planes based on Fixed Matrix
    Colorop
  drm/i915/color: Add support for 1D LUT in SDR planes
  drm/i915/color: Add color pipeline support for SDR planes

Pranay Samala (2):
  drm/i915/color: Extract HDR post-CSC LUT programming to helper
    function
  drm/i915/color: Program Plane Post CSC registers for SDR planes

 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
 drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
 drivers/gpu/drm/i915/display/intel_color.c    |  76 ++++++++---
 .../drm/i915/display/intel_color_pipeline.c   |  30 ++++-
 .../drm/i915/display/intel_display_limits.h   |   1 +
 .../drm/i915/display/intel_display_types.h    |   1 +
 drivers/gpu/drm/i915/display/intel_plane.c    |  53 +++++++-
 .../drm/i915/display/skl_universal_plane.c    |  42 +++---
 include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
 include/uapi/drm/drm_mode.h                   |  12 ++
 11 files changed, 420 insertions(+), 40 deletions(-)

-- 
2.50.1

