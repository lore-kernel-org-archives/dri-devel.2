Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0026BFF4941
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E6D10E241;
	Mon, 30 Mar 2026 04:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dDf/ZnqS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1421410E241;
 Mon, 30 Mar 2026 04:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844520; x=1806380520;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=edzzlBeL2ZqLP/MfVXz8Aa/f3M1sCWZSlJlz17VJvBs=;
 b=dDf/ZnqS1jp86gmPHNAQYQ6dQ2mccD+e+nzLzTkA/zO2j2rMamNzG85q
 ttfVUCbdS2eNe5ujILYC/w714z5sspC2vz7/We5GSOBxRVoy5JgFjKZaL
 cdgKjYqNdhe7cb2uVGq7+fu6Dzxtp6oKvFNDTs+5OQ6ulzJ6syInxfO5w
 /SaUWz+Ixn5vjKnX6pju9PkPRgNG0nu9/ZbRvmqz38Z30TqhJAk7AUkVs
 qf6pQ+FxDhE4cH11uVAhTh9Ow8uEqI6FJ6pR5T3BZoAPFmvdpcATM5O83
 YPFMtf3dLQhZPNSM6ENMKPHNO37fo404L/G7aWqx33Do66v0a/smpaiXM g==;
X-CSE-ConnectionGUID: ljkJXEuXS8ibSzkRSTT8lw==
X-CSE-MsgGUID: rdJLhxZZR+i/Vx+AGVakUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218210"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:21:59 -0700
X-CSE-ConnectionGUID: JUVFVDeHQ2Kn/Dn63aDXDA==
X-CSE-MsgGUID: cCJ2aeHATA+cJ5MTnC3LyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871021"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:21:57 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 00/19] Fix Adaptive Sync SDP for PR with Link ON + Auxless ALPM
Date: Mon, 30 Mar 2026 09:36:37 +0530
Message-ID: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
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

Enable Adaptive Sync SDP for Panel replay + auxless ALPM.
First few patches are fixes in existing AS SDP enablement.
Later patches add the support to send AS SDP for Panel replay with Link
ON and with auxless ALPM (Link-Off). 

This series is in continuation from discussions in [1] [2] and more
recent [3]:

Apart from few patches from [3] new changes include:
- Some clean up in drm/dp Macros
- Add new DPCD bit to get FAVT PAYLOAD FIELDS PARSING SUPPORT.
- Add AS SDP version and PR and VRR specific bits in drm_dp.h.
- Modify AS SDP compute config to accomodate PR with Link On and Link
  Off.
- Program Downspread Ctrl DPCD bits.
- Make way for T1 and T2 AS SDP transmission timing/position.

[1] https://lore.kernel.org/all/1b8c6c6de1e5fe0db83e6ae942dfee7e6f950767.camel@intel.com/
[2] https://lore.kernel.org/all/aPtqdAxDwiuQZbrn@intel.com/
[3] https://lore.kernel.org/intel-gfx/7c2d6f4e-69e6-452a-89cc-5fd4254430bd@intel.com/T/#m6e8beab2cc3b6ff9d61f740f107d83a2f4e08114

Rev2:
 - Drop the redundant version member for AS SDP, and use the member
   revision
 - Drop member to store AS SDP transmission time, use simple helper
   instead.
 - Use Burst mode to write Panel Replay config DPCDs.
 - Split AS SDP configuration in compute_config() and
   compute_config_late() phase.
 - Always enable AS SDP whenever supported by source + sink.

Rev3:
 - Use ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR bit also to determine AS
   SDP v2 support.
 - Drop patch to make provision to send AS SDP v1.
 - Add patch to include all relevant AS SDP fields in comparison.
 - Other refactor improvements suggested by Ville.

Ankit Nautiyal (19):
  drm/dp: Rename and relocate AS SDP payload field masks
  drm/dp: Clean up DPRX feature enumeration macros
  drm/dp: Add bits for AS SDP FAVT Payload Fields Parsing support
  drm/dp: Add DPCD for configuring AS SDP for PR + VRR
  drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP
  drm/i915/vrr: Avoid vrr for PCON with HDMI2.1 sink
  drm/i915/dp: Account for AS_SDP guardband only when enabled
  drm/i915/dp: Add a helper to decide if AS SDP can be used
  drm/i915/dp: Skip AS SDP for DP branch devices
  drm/i915/dp: Use revision field of AS SDP data structure
  drm/i915/dp: Include all relevant AS SDP fields in comparison
  drm/i915/dp: Add member to intel_dp to store AS SDP v2 support
  drm/i915/psr: Write the PR config DPCDs in burst mode
  drm/i915/display: Add helper for AS SDP transmission time selection
  drm/i915/psr: Program Panel Replay CONFIG3 using AS SDP transmission
    time
  drm/i915/dp: Set relevant Downspread Ctrl DPCD bits for PR + Auxless
    ALPM
  drm/i915/dp: Program AS SDP DB[1:0] for PR with Link off
  drm/i915/dp: Split AS SDP computation between compute_config and
    compute_config_late
  drm/i915/dp: Always enable AS SDP if supported by source + sink

 drivers/gpu/drm/i915/display/intel_alpm.c     |  20 ++-
 drivers/gpu/drm/i915/display/intel_display.c  |   6 +-
 .../drm/i915/display/intel_display_types.h    |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 147 ++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp.h       |   2 +
 .../drm/i915/display/intel_dp_link_training.c |  10 +-
 .../drm/i915/display/intel_dp_link_training.h |   3 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  30 ++--
 drivers/gpu/drm/i915/display/intel_vrr.c      |  10 ++
 include/drm/display/drm_dp.h                  |  19 ++-
 11 files changed, 194 insertions(+), 56 deletions(-)

-- 
2.45.2

