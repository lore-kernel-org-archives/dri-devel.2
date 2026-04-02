Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB17CCC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C8910EFE9;
	Thu,  2 Apr 2026 08:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mdTK/3Fq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A81310EFE9;
 Thu,  2 Apr 2026 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775117975; x=1806653975;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=W9owIGjcC7llsJtQZAFgyj+cMGoUo/WPtFSRWkF/e3o=;
 b=mdTK/3FqgvwijGYvNkI5gDYtp6d41e3WtRla+W4fRYovOp5Tk28Pql85
 E9k7p2uY8l9VGjDra0UowULfwRyLDYKhKwjEe5/uhaRP9iI5ykp4R+CUB
 3Gh763s0HGNlqjtG4Uw5X90Y2+oPsDLbrCOAApikgBKO8lAllbG9TdnuI
 mlaauLwIdmpucOb8y0+WofhgDahczIAraA1HgjcsR1Y+ry3SbMt0iMncw
 lFbMh+EmnknFakuJa+t2mwK7uahjE2NAK0QL1Ouq97Chh42Ty5jtcrz9n
 bSiY0ZiBxLWEY3T9kNYSWcl6t5ILS4IF/9E4bNMj4Zm4cLhoNUWkhIZ5Y w==;
X-CSE-ConnectionGUID: tI9Vm3UxSZ24xs62xAsotg==
X-CSE-MsgGUID: 7F+ANPZOQbaF8qE3uPzJ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060359"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060359"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:35 -0700
X-CSE-ConnectionGUID: dqxKGwPpTFG6+UZyjqsKNQ==
X-CSE-MsgGUID: eHYLjnwCR/6XtnWMoPBQag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776088"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:19:33 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 00/23] Fix Adaptive Sync SDP for PR with Link ON + Auxless ALPM
Date: Thu,  2 Apr 2026 13:34:00 +0530
Message-ID: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
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

Rev4:
 - Add new member coasting vtotal in struct drm_dp_as_sdp and program
   the coasting vtotal in AS SDP.
 - Add new helper to get async timing support during PR active.
 - Correct the patches to write Panel Replay Config DPCDs.
 - Ensure either PR/VRR have potential to use AS SDP before enabling
   AS SDP, even though we may not be enabling them at modeset.
 - Other correction and changes suggested by Ville.

Ankit Nautiyal (23):
  drm/dp: Rename and relocate AS SDP payload field masks
  drm/dp: Clean up DPRX feature enumeration macros
  drm/dp: Add bits for AS SDP FAVT Payload Fields Parsing support
  drm/dp: Add DPCD for configuring AS SDP for PR + VRR
  drm/dp: Store coasting vtotal in struct drm_dp_as_sdp
  drm/i915/dp: Fix readback for target_rr in Adaptive Sync SDP
  drm/i915/vrr: Avoid vrr for PCON with HDMI2.1 sink
  drm/i915/dp: Account for AS_SDP guardband only when enabled
  drm/i915/dp: Add a helper to decide if AS SDP can be used
  drm/i915/dp: Skip AS SDP for DP branch devices
  drm/i915/dp: Use revision field of AS SDP data structure
  drm/i915/dp: Include all relevant AS SDP fields in comparison
  drm/i915/psr: Add helper to get Async Video timing support in PR
    active
  drm/i915/dp: Add member to intel_dp to store AS SDP v2 support
  drm/i915/dp: Allow AS SDP only if v2 is supported
  drm/i915/psr: Write the PR config DPCDs in burst mode
  drm/i915/display: Add helper for AS SDP transmission time selection
  drm/i915/psr: Program Panel Replay CONFIG3 using AS SDP transmission
    time
  drm/i915/dp: Set relevant Downspread Ctrl DPCD bits for PR + Auxless
    ALPM
  drm/i915/dp: Program AS SDP DB[1:0] for PR with Link off
  drm/i915/dp: Split AS SDP computation between compute_config and
    compute_config_late
  drm/i915/dp: Compute and include coasting vtotal for AS SDP
  drm/i915/dp: Always enable AS SDP if supported by source + sink

 drivers/gpu/drm/display/drm_dp_helper.c       |   1 +
 drivers/gpu/drm/i915/display/intel_alpm.c     |  20 ++-
 drivers/gpu/drm/i915/display/intel_display.c  |   9 +-
 .../drm/i915/display/intel_display_types.h    |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 165 ++++++++++++++----
 drivers/gpu/drm/i915/display/intel_dp.h       |   2 +
 .../drm/i915/display/intel_dp_link_training.c |  12 +-
 .../drm/i915/display/intel_dp_link_training.h |   3 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |   2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  37 ++--
 drivers/gpu/drm/i915/display/intel_psr.h      |   1 +
 drivers/gpu/drm/i915/display/intel_vrr.c      |  10 ++
 include/drm/display/drm_dp.h                  |  20 ++-
 include/drm/display/drm_dp_helper.h           |   1 +
 14 files changed, 226 insertions(+), 58 deletions(-)

-- 
2.45.2

