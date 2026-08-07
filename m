Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB327C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0223110F326;
	Fri,  7 Aug 2026 04:31:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AKjNoLun";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D864A10F326;
 Fri,  7 Aug 2026 04:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077088; x=1817613088;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=eUhWUcXQTutgORprU3xdfeDnD5Wma5+eHKz1FjriSfE=;
 b=AKjNoLunnmi3eo9g+Fklli5324DSitfqMgFgpQDaMk2cWqo6Ajr4R0OW
 yoTn0uoaOUTIKMABsR5SCRag//dZGcDmSxKWS4L5PmFHp6TakTOMfsCix
 yJbNjtcMBYsXxAvs1vcHbnS20M/Ce9kumPfwKUnMTIko9wYZgvGkGrb4E
 hM/tWTEXSE786ch0dIBcHfd9wkQauKMHo5bbA6nhDnUBFjTl5oxGT2GXt
 Z6xosvDr31LJKyEx0Ob7xYP4tkP0ezWaGf9IcO0sUo4+iU8KV0v/GoX+M
 PKuCD1WLUtCsxCVNo+/AgfvR5fHwivfGRqn0GXM536i/oOHRPeX7JPItu A==;
X-CSE-ConnectionGUID: wOw4BsoLR4eMneEX2fDhjw==
X-CSE-MsgGUID: vD+O/EniSf6mtibhrMDnoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619229"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619229"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:27 -0700
X-CSE-ConnectionGUID: YUfP3+mPQp62TbhziOJ2BA==
X-CSE-MsgGUID: 9bNQ05+hRXyl23/6L1Bjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666022"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:24 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 00/44] Enable HDMI FRL for MTL+
Date: Fri,  7 Aug 2026 09:43:45 +0530
Message-ID: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

This series adds support for HDMI Fixed Rate Link (FRL) on MTL+ platforms.
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

Ankit Nautiyal (28):
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
  drm/i915/hdmi_frl_dfm: Add function to compute FRL DFM config
  drm/i915/hdmi: Add FRL clock computation based on DFM
  drm/i915/hdmi: Add support for sending uevent to user for FRL training
    failure
  drm/i915/ddi: Wire FRL into the HDMI DDI enable/disable path
  drm/i915/hdmi: Add read out for FRL state
  drm/i915/display: Add FRL members to the state checker
  drm/i915/hdmi: Compute output format for HDMI FRL mode

Suraj Kandpal (7):
  drm/i915/hdmi: Introduce intel_hdmi_frl_level() for per-lane TxFFE
  drm/i915/hdmi: Drive per-lane TxFFE during FRL link training
  drm/i915/ltphy: Add PLL tables for HDMI FRL
  drm/i915/ltphy: Add safegaurd when calculation HDMI FRL state
  drm/i915/ltphy: Calculate port clock for HDMI FRL
  drm/i915/ltphy: Verify HDMI FRL tables
  drm/i915/ddi_buf: Add Vswing table for HDMI FRL

Vandita Kulkarni (9):
  drm/i915/hdmi: Parse frl max link rate from vbt
  drm/i915/hdmi: Rename port clock limit to specify tmds clock
  drm/i915/hdmi: Rename port clock valid to specify tmds clock
  drm/i915/hdmi: Add FRL port and mode clock valid
  drm/i915/hdmi_frl_dfm_regs: Define DFM registers
  drm/i915/hdmi_frl_dfm: Define frl_dfm structure
  drm/i915/hdmi_frl_dfm: Add non dsc frl capacity computation helpers
  drm/i915/hdmi_frl_dfm: Handle FRL Link M/N
  drm/i915/hdmi: Enable FRL based mode clock valid

 drivers/gpu/drm/display/drm_scdc_helper.c     | 212 +++++
 drivers/gpu/drm/i915/Makefile                 |   1 +
 drivers/gpu/drm/i915/display/intel_bios.c     |  53 ++
 drivers/gpu/drm/i915/display/intel_bios.h     |   1 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |  23 +
 drivers/gpu/drm/i915/display/intel_cx0_phy.h  |   1 +
 .../gpu/drm/i915/display/intel_cx0_phy_regs.h |   1 +
 drivers/gpu/drm/i915/display/intel_ddi.c      | 162 +++-
 .../drm/i915/display/intel_ddi_buf_trans.c    |  25 +
 drivers/gpu/drm/i915/display/intel_display.c  |   9 +
 .../gpu/drm/i915/display/intel_display_regs.h |  26 +
 .../drm/i915/display/intel_display_types.h    |  38 +
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 808 +++++++++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.h     |  14 +-
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 892 ++++++++++++++++++
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h | 126 +++
 .../i915/display/intel_hdmi_frl_dfm_regs.h    |  36 +
 drivers/gpu/drm/i915/display/intel_lt_phy.c   | 315 ++++++-
 drivers/gpu/drm/i915/display/intel_lt_phy.h   |   1 +
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |   7 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 include/drm/display/drm_scdc.h                |  26 +
 include/drm/display/drm_scdc_helper.h         |  22 +
 23 files changed, 2704 insertions(+), 96 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h

-- 
2.50.1

