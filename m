Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84CAC982C7
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF10310ED25;
	Tue, 15 Sep 2026 18:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Tyh2a7Lw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB3810E884;
 Tue, 15 Sep 2026 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497558; x=1821033558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DjECLiaImBRSgUFSzxUG4hQNKDR/iBe0ttBpiJ6+Qqs=;
 b=Tyh2a7LwyUKxld0lBkJ2X2o3t7TS5vHnlJSDb/DOVMt6eZcNLBQsCop9
 YyM3mg1h13jKYLcNrqTxSnhBRWb9HRYUEadsf6mDX4Hpq+Y4pmGlHd52U
 ELALSkP4t+9pfPlfwSVrFxctHkRpL7jX9svo5xn+GZfrRinUv5qwrnuZi
 LH8JafJQVLNZNHzu0YNBrGU6lTrsq8VAX+Zzl6kEjScicascDWq0dSgQk
 RPDlVM/zjlWvzUBGl0Rl4xLHQzKY0EAghsEdKSVN4gdGpzcn5wOImHzqB
 7R/WNTEEz02FDpsxrCV+EKsiVYwIDj0NrbUhN7itr7sR4nKf+Z18/P8A9 A==;
X-CSE-ConnectionGUID: Kfs619rNReWXW28k4D296A==
X-CSE-MsgGUID: z5sUIsQaTYOB3YKBm8GghQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380292"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:18 -0700
X-CSE-ConnectionGUID: Wxnd5G4cSNOkYvIVel3P/w==
X-CSE-MsgGUID: 9OYyrS0BRpS232Mh1zxIsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148489"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:15 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 07/18] drm/i915/alpm: Modify AUX_LESS_WAKE_TIME bitfield
 for xe3lpd
Date: Tue, 15 Sep 2026 23:34:38 +0530
Message-Id: <20260915180449.277933-8-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

The AUX_LESS_WAKE_TIME bitfield in ALPM_CTL is widened from 6 bits to
8 bits starting from xe3lpd (display version 35). Add the register mask
and field macro for the wider bitfield and program the wake time using
the appropriate macro based on the display version.

v2: Modify AUX_LESS_WAKE_TIME bitfield for xe3lpd. [Suraj]
v3: Separate out AUX_LESS_WAKE_TIME bitfield change into its own
patch. [Jouni]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 8 ++++++--
 drivers/gpu/drm/i915/display/intel_psr_regs.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 924fa8dd4638..dc025058a626 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -610,8 +610,12 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
 		alpm_ctl = ALPM_CTL_ALPM_ENABLE |
 			ALPM_CTL_ALPM_AUX_LESS_ENABLE |
-			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS |
-			ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_less_wake_lines);
+			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS;
+
+		if (DISPLAY_VER(display) < 35)
+			alpm_ctl |= ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_less_wake_lines);
+		else
+			alpm_ctl |= ALPM_CTL_AUX_LESS_WAKE_TIME_XE3LPD(crtc_state->alpm_state.aux_less_wake_lines);
 
 		if (intel_dp->as_sdp_supported)
 			intel_alpm_configure_pr_as_sdp(intel_dp, crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index bb577e7e3bbd..016ce24944dc 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -301,7 +301,9 @@
 #define  ALPM_CTL_EXTENDED_FAST_WAKE_MIN_LINES		5
 #define  ALPM_CTL_EXTENDED_FAST_WAKE_TIME(lines)	REG_FIELD_PREP(ALPM_CTL_EXTENDED_FAST_WAKE_TIME_MASK, (lines) - ALPM_CTL_EXTENDED_FAST_WAKE_MIN_LINES)
 #define  ALPM_CTL_AUX_LESS_WAKE_TIME_MASK		REG_GENMASK(5, 0)
+#define  ALPM_CTL_AUX_LESS_WAKE_TIME_MASK_XE3LPD	REG_GENMASK(7, 0)
 #define  ALPM_CTL_AUX_LESS_WAKE_TIME(val)		REG_FIELD_PREP(ALPM_CTL_AUX_LESS_WAKE_TIME_MASK, val)
+#define  ALPM_CTL_AUX_LESS_WAKE_TIME_XE3LPD(val)	REG_FIELD_PREP(ALPM_CTL_AUX_LESS_WAKE_TIME_MASK_XE3LPD, val)
 
 #define _ALPM_CTL2_A	0x60954
 #define ALPM_CTL2(dev_priv, tran)	_MMIO_TRANS2(dev_priv, tran, _ALPM_CTL2_A)
-- 
2.29.0

