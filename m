Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88049C5ACAB
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D1DD10F3C8;
	Fri,  7 Aug 2026 04:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YmBxSWhG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC05610F3C4;
 Fri,  7 Aug 2026 04:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077167; x=1817613167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q/CO48RKPJZEEshQDKTZLqo8s8yeeNMIrn+vky/xxXw=;
 b=YmBxSWhGuuzTzjNYtkuUm4eyYPB+6FI/1cbgmRX1MFc3WXx5sZYllbJI
 CO+WsS0XMQXyyiJwN2tpyvhyfDZnn5JQB8gzf0MRXycyhzJPMYcBFCw8S
 CaVlZhgRL+eXTyLLALKZ3dsGNUXwLw/3ixPDMQONMTxHWgbp5oJl81HG4
 fwnRoiUkY8yV7V7GeloLiHJvM4U0joLSxInlgro9E2uwG8FO8YdOktN2U
 fWM/L0neaqcwvEA6M9c0TIQvVI9wzbec0ZUB+ayy7kuhY7zigRxJxNJkT
 LNEaasnV7gl3t8GtAbZ0toy1H7D/emDQPhvITSjpitVWpGzQEXv/WTLdM w==;
X-CSE-ConnectionGUID: reTxBaoyRACBTJozULjyEA==
X-CSE-MsgGUID: YXn5hfjYQlqmGMBxZpEKLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619362"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619362"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:47 -0700
X-CSE-ConnectionGUID: iULlpt5BQ+m+mm0SUYz1AA==
X-CSE-MsgGUID: bCY0uSAaR72TPnd5fbhapw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666481"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:44 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 31/44] drm/i915/hdmi_frl_dfm: Define frl_dfm structure
Date: Fri,  7 Aug 2026 09:44:16 +0530
Message-ID: <20260807041430.229038-32-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Define frl_dfm structure to hold frl characteristics
needed for frl capacity computation in order to
meet the data flow metering requirement.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
new file mode 100644
index 000000000000..c619073eef9b
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: MIT
+ * Copyright © 2022 Intel Corp
+ */
+
+#ifndef __INTEL_HDMI_FRL_DFM_H__
+#define __INTEL_HDMI_FRL_DFM_H__
+
+#include <linux/types.h>
+
+/* All the input config needed to compute DFM requirements */
+struct intel_hdmi_frl_dfm_input_config {
+	/*
+	 * Pixel clock rate kHz, when FVA is
+	 * enabled this rate is the rate after adjustment
+	 */
+	u32 pixel_clock_nominal_khz;
+
+	/* active pixels per line */
+	u32 hactive;
+
+	/* Blanking pixels per line */
+	u32 hblank;
+
+	/* Bits per component */
+	u32 bpc;
+
+	/* Pixel encoding */
+	u32 color_format;
+
+	/* FRL bit rate in kbps */
+	u32 bit_rate_kbps;
+
+	/* FRL lanes */
+	u32 lanes;
+
+	/* Number of audio channels */
+	u32 audio_channels;
+
+	/* Audio rate in Hz */
+	u32 audio_hz;
+
+	/* Selected bpp target value */
+	u32 target_bpp_16;
+
+	/*
+	 * Number of horizontal pixels in a slice.
+	 * Equivalent to PPS parameter slice_width
+	 */
+	u32 slice_width;
+};
+
+/* Computed dfm parameters for FRL */
+struct intel_hdmi_frl_dfm_params {
+	/*
+	 * Link overhead in percentage
+	 * multiplied by 1000 (efficiency multiplier)
+	 */
+	u32 overhead_max;
+
+	/* Maximum pixel rate in kHz */
+	u32 pixel_clock_max_khz;
+
+	/* Minimum video line period in nano sec */
+	u32 line_time_ns;
+
+	/* worst case slow frl character rate in kbps */
+	u32 char_rate_min_kbps;
+
+	/* minimum total frl charecters per line period */
+	u32 cfrl_line;
+
+	/* Average tribyte rate in khz */
+	u32 ftb_avg_k;
+
+	/* Audio characteristics */
+
+	/*  number of audio packets needed during hblank */
+	u32 num_audio_pkts_line;
+
+	/*
+	 *  Minimum required hblank assuming no control period
+	 *  RC compression
+	 */
+	u32 hblank_audio_min;
+
+	/* Number of tribytes required to carry active video */
+	u32 tb_active;
+
+	/* Total available tribytes during the blanking period */
+	u32 tb_blank;
+
+	/*
+	 * Number of tribytes required to be transmitted during
+	 * the hblank period
+	 */
+	u32 tb_borrowed;
+
+	/* DSC frl characteristics */
+
+	/* Tribytes required to carry the target bpp */
+	u32 hcactive_target;
+
+	/* tribytes available during blanking with target bpp */
+	u32 hcblank_target;
+};
+
+/* FRL DFM structure to hold data involved in DFM computation */
+struct intel_hdmi_frl_dfm {
+	struct intel_hdmi_frl_dfm_input_config config;
+	struct intel_hdmi_frl_dfm_params params;
+};
+
+#endif
-- 
2.50.1

