Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA503CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C2110E3B8;
	Mon, 12 Oct 2026 04:14:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC5F810E1F5;
 Mon, 12 Oct 2026 04:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778455; x=1823314455;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EtmyNP5JZJWG6GUGh0givmVgUxtANfXLY0bCtTWm50Q=;
 b=P9zq9/EHOzoOt/BBTWeXYKIznmmYjtjPRq/yfLUQV9hfWv0Tvdc3Ellw
 c3H1u/loDNAqvEAW1rhddWfzw9rOj2b1/1p5QkfM4+ExQ5SN7Qek/w24I
 V85+/q+8PnGr4UMzLVZiNUEh3yi4fX5pXIYRIjg4O02qOesBU7IJSG4wM
 9UQwkOJyIFHjdYOO70CElfTjtxH6sgSeiOY+uNbQq5MBah2yVk76He0Hh
 OuJ+Ox78UUlEwU3mQwjW4Nxaje8TWTyCygaVzFFKGeJ2NQBpgAMBTmGz1
 Wasyxkly3x2B1SIUUAqaQjADMbsdHISDmXfaIYMSqHppZPb/8BuGzavqg Q==;
X-CSE-ConnectionGUID: UMcV5SEoRmOOi91Cl2XnAg==
X-CSE-MsgGUID: 6lIeNEpQQmi70RuGY47G7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380796"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380796"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:14 -0700
X-CSE-ConnectionGUID: aEdjQ0yFRJaUrEcfwXl2YA==
X-CSE-MsgGUID: AoENctSMSTm16O1MhBLX3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256305"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:13 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 00/56] Enable HDMI FRL for MTL+
Date: Mon, 12 Oct 2026 09:27:09 +0530
Message-ID: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

FRL is a high-bandwidth transmission mode required for modes that exceed
the TMDS bandwidth limit.

The series covers the core enabling:
- SCDC helper additions for FRL link training
- FRL link training state machine (LTS:2, LTS:3, LTS:P)
- DDI enable/disable sequence updates for FRL mode
- DFM (Data Flow Metering) computation and register programming
- PHY (CX0/LT PHY) support for FRL rates
- Mode validation and clock computation for FRL

This is a work in progress. The primary goal at this stage is to get the
overall design reviewed and the foundational patches landed before building
on top.

Lightly tested on PTL. Modes like 4K@120 are working. Higher resolution
modes (e.g. 8K) require DSC which is not yet covered in this series, that
work is ongoing.

Testing on other MTL+ platforms is also ongoing.
Known gaps:
- DSC over FRL not yet supported
- Testing limited to MTL, PTL so far

Feedback on the design and approach is welcome.

Rev 2:
- Addressed review comments from Jani and Suraj on VBT parsing.
- Added pipe joiner support for HDMI.
- Added audio pruning for HDMI FRL mode.
- Tweaked the vswing presets and removed test-only presets.
- Fixed potential integer overflows in FRL DFM calculations.
- Tested on MTL, PTL, NVL with AORUS FO32U2P HDMI 2.1 panel.

Note: DSC support is WIP. Working patches are available in my public tree:
https://github.com/aknautiyal/tip/tree/hdmi21_dev  (based on drm-tip, may be rebased)
Tested working for most modes.

Ankit Nautiyal (38):
  drm/i915/hdmi: Add new data members for FRL configuration
  drm/i915/hdmi: Add FRL link rate cap
  drm/drm_scdc_helper: Add SCDC helper funcs for FRL
  drm/i915/display: Add registers for HDMI FRL configuration
  drm/i915/display: Add new members in crtc_state for FRL configuration
  drm/i915/intel_cx0_phy_regs: Add HDMI FRL SHIFT EN bit in
    PORT_BUF_CTL_1
  drm/i915/ddi: Update Transcoder/DDI registers with the frl bits
  drm/i915/hdmi: Enable Scrambling only for TMDS mode
  drm/i915/ddi: Simplify intel_ddi_enable()
  drm/i915/ddi: Factor out common transcoder/vblank enable sequence
  drm/i915/ddi: Update HDMI modeset sequence for MTL+
  drm/i915/hdmi: Add function to prepare registers for FRL mode
  drm/i915/hdmi: Add functions for FRL training state machine
  drm/i915/intel_hdmi: Add helper to disable FRL
  drm/i915/hdmi: Reduce FRL rate cap on rate change during training
  drm/i915/hdmi: Add provision for FRL mode while computing output
    format
  drm/i915/cx0: Add helper to check if the FRL rate is valid
  drm/i915/lt_phy: Add helper to check if the FRL rate is valid
  drm/i915/hdmi_frl_dfm: Add support for DFM calculation with DSC
  drm/i915/hdmi: Add helper to write FRL CFG register
  drm/i915/hdmi_frl_dfm: Add helpers to read/write FRL DFM registers
  drm/i915/hdmi: Validate FRL modes in mode_valid using the FRL DFM
  drm/i915/hdmi: Add FRL clock computation based on DFM
  drm/i915/hdmi: Add support for sending uevent to user for FRL training
    failure
  drm/i915/ddi: Wire FRL into the HDMI DDI enable/disable path
  drm/i915/ltphy: Fix HDMI FRL per-lane TX mapping
  drm/i915/hdmi: Add read out for FRL state
  drm/i915/hdmi: Use the real pixel clock as crtc_clock for FRL
  drm/i915/display: Add FRL members to the state checker
  drm/i915/hdmi: Compute output format for HDMI FRL mode
  drm/i915/hdmi: Add a helper to check non DSC audio support for HDMI
    FRL
  drm/i915/audio: Add the mode pruning logic for HDMI FRL
  drm/i915/joiner: Prepare to move joiner helpers to a new file
  drm/i915/joiner: Move joiner candidate helpers to intel_joiner.c
  drm/i915/joiner: Move joiner pipe mask helper to intel_joiner.c
  drm/i915/hdmi: Iterate through joiner candidates in compute_config
    path
  drm/i915/hdmi: Iterate through joiner candidates in mode_valid path
  drm/i915/hdmi: Allow Pipe joiner for HDMI

Suraj Kandpal (7):
  drm/i915/hdmi: Introduce intel_hdmi_frl_level() for per-lane TxFFE
  drm/i915/hdmi: Drive per-lane TxFFE during FRL link training
  drm/i915/ltphy: Add PLL tables for HDMI FRL
  drm/i915/ltphy: Add safegaurd when calculation HDMI FRL state
  drm/i915/ltphy: Calculate port clock for HDMI FRL
  drm/i915/ltphy: Verify HDMI FRL tables
  drm/i915/ddi_buf: Add Vswing table for HDMI FRL

Vandita Kulkarni (11):
  drm/i915/hdmi: Parse FRL max link rate from VBT
  drm/i915/hdmi_frl_dfm_regs: Define DFM registers
  drm/i915/hdmi_frl_dfm: Define frl_dfm structure
  drm/i915/hdmi_frl_dfm: Add non dsc frl capacity computation helpers
  drm/i915/hdmi: Rename port clock limit to specify tmds clock
  drm/i915/hdmi: Rename port clock valid to specify tmds clock
  drm/i915/hdmi: Rename mode clock valid to specify tmds clock
  drm/i915/hdmi: Add FRL port clock valid
  drm/i915/hdmi: Compute FRL Link M/N
  drm/i915/hdmi_frl_dfm: Write and read back FRL Link M/N
  drm/i915/hdmi: Enable FRL based mode clock valid

 drivers/gpu/drm/display/drm_scdc_helper.c     |  109 ++
 drivers/gpu/drm/i915/Makefile                 |    2 +
 drivers/gpu/drm/i915/display/intel_audio.c    |   14 +-
 drivers/gpu/drm/i915/display/intel_bios.c     |   39 +
 drivers/gpu/drm/i915/display/intel_bios.h     |    1 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |   23 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |    1 +
 .../gpu/drm/i915/display/intel_cx0_phy_regs.h |    1 +
 drivers/gpu/drm/i915/display/intel_ddi.c      |  159 ++-
 .../drm/i915/display/intel_ddi_buf_trans.c    |   17 +
 drivers/gpu/drm/i915/display/intel_display.c  |   55 +-
 .../drm/i915/display/intel_display_debugfs.c  |    6 +-
 .../gpu/drm/i915/display/intel_display_regs.h |   27 +
 .../drm/i915/display/intel_display_types.h    |   38 +
 drivers/gpu/drm/i915/display/intel_dp.c       |   54 +-
 drivers/gpu/drm/i915/display/intel_dp.h       |   11 -
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |    5 +-
 drivers/gpu/drm/i915/display/intel_dpll.c     |    2 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 1051 ++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.h     |   16 +-
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c |  787 ++++++++++++
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h |  123 ++
 .../i915/display/intel_hdmi_frl_dfm_regs.h    |   36 +
 drivers/gpu/drm/i915/display/intel_joiner.c   |  108 ++
 drivers/gpu/drm/i915/display/intel_joiner.h   |   27 +
 drivers/gpu/drm/i915/display/intel_lt_phy.c   |  348 +++++-
 drivers/gpu/drm/i915/display/intel_lt_phy.h   |    1 +
 .../drm/i915/display/intel_modeset_verify.c   |   18 +
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |    7 +
 drivers/gpu/drm/xe/Makefile                   |    2 +
 include/drm/display/drm_scdc.h                |    3 +
 include/drm/display/drm_scdc_helper.h         |   23 +
 32 files changed, 2886 insertions(+), 228 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_joiner.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_joiner.h

-- 
2.50.1

