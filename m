Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7913C982C5
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A3310F031;
	Tue, 15 Sep 2026 18:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QBY7/LfS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A011B10F05C;
 Tue, 15 Sep 2026 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497569; x=1821033569;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=17Fg+wkx6pJ6SMfjsjEUXtEj2XIapRvjcltOsXcu+Sk=;
 b=QBY7/LfSRRl3NYSOTuUKsfrwrOyiNlj2ak22PpMaVxe7jHIJJmfilph2
 svgZud3cJVQx8qsXvDihzgT1RSWjIQKxbcSijrEynBU1sL1yqX3s+bI5i
 s+3pmQmQKXxKImEHA+9mmnX6gjMv13IZAkm1YaViFqvoppW+b67pRNPml
 NMKJl3Kn9Pw4EpPj87qcNIylNgSFyTOael9uHmsIVpVne2WiwNxfKBYmR
 BPWiWQfLMObe8s2CWqOo8D6D8or9nwtecLHmga2qEW6gQzGyAvFM/KcE2
 Xt0IvOqtd+ErFKdK8uPk2Co8+lkB2sQ6DbBsKZwmQ8IwloLR9odu/Lmtg A==;
X-CSE-ConnectionGUID: tNOhP/OqSQqpC/cdg/rOTg==
X-CSE-MsgGUID: jc2v4ZMXQ3yTVI4fH/IfBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380309"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:29 -0700
X-CSE-ConnectionGUID: BrPbDdl3Ss+O6xOm0UBJTw==
X-CSE-MsgGUID: qw3sD3aMTMSG72jziJuIGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148514"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:27 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 11/18] drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield for
 xe3lpd
Date: Tue, 15 Sep 2026 23:34:42 +0530
Message-Id: <20260915180449.277933-12-animesh.manna@intel.com>
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

The LFPS_CYCLE_COUNT bitfield in PORT_ALPM_LFPS_CTL is widened from
4 bits (27:24) to 7 bits (30:24) starting from xe3lpd. Add the wider
register mask and field macro, and program the cycle count using the
appropriate macro based on the display version.

v2: Split in a separate patch. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 11 ++++++++++-
 drivers/gpu/drm/i915/display/intel_psr_regs.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 22ed341763fa..da653a407e97 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -784,12 +784,21 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 		return;
 
 	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+		int lfps_cycle = get_lfps_cycle_count(crtc_state);
+		u32 lfps_cycle_val;
+
+		if (DISPLAY_VER(display) >= 35)
+			lfps_cycle_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_XE3LPD(lfps_cycle);
+		else
+			lfps_cycle_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(lfps_cycle);
+
 		alpm_ctl_val = PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE |
 			PORT_ALPM_CTL_MAX_PHY_SWING_SETUP(15) |
 			PORT_ALPM_CTL_MAX_PHY_SWING_HOLD(0) |
 			PORT_ALPM_CTL_SILENCE_PERIOD(
 				crtc_state->alpm_state.silence_period_sym_clocks);
-		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(get_lfps_cycle_count(crtc_state)) |
+
+		lfps_ctl_val = lfps_cycle_val |
 			PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(
 				crtc_state->alpm_state.lfps_half_cycle_num_of_syms) |
 			PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(
diff --git a/drivers/gpu/drm/i915/display/intel_psr_regs.h b/drivers/gpu/drm/i915/display/intel_psr_regs.h
index 016ce24944dc..8f60b671755a 100644
--- a/drivers/gpu/drm/i915/display/intel_psr_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_psr_regs.h
@@ -335,8 +335,10 @@
 #define PORT_ALPM_LFPS_CTL(port)				_MMIO_PORT(port, _PORT_ALPM_LFPS_CTL_A, _PORT_ALPM_LFPS_CTL_B)
 #define  PORT_ALPM_LFPS_CTL_LFPS_START_POLARITY			REG_BIT(31)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK		REG_GENMASK(27, 24)
+#define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK_XE3LPD	REG_GENMASK(30, 24)
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN		7
 #define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(val)		REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
+#define  PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_XE3LPD(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MASK_XE3LPD, (val) - PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT_MIN)
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(20, 16)
 #define  PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(val)	REG_FIELD_PREP(PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION_MASK, val)
 #define  PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION_MASK	REG_GENMASK(12, 8)
-- 
2.29.0

