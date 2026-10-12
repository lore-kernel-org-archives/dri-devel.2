Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87720CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8C310E4A2;
	Mon, 12 Oct 2026 04:15:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3F210E4C1;
 Mon, 12 Oct 2026 04:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778523; x=1823314523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q/CO48RKPJZEEshQDKTZLqo8s8yeeNMIrn+vky/xxXw=;
 b=PIQP8TCvncDMlz8MG5Ev/oNNsolGOYf+9lPaeq/9MVwECnZ6hRrw8QFE
 UaV/27F6vAMDbTS8ypqVQql68/ILO0AVdz70DBX8OduBIMVoIwidn3JW3
 ucek2VjVeG45qn86oloFHLZpFvxBS4iQ30U6uclag7herz5pnpwrKkXQQ
 TngNT5oFXxN8LQ/gd44IJTV9+ncEEScLtkDcuar1+HFftbKq7smsT6zbk
 5nbbm6CLlCxm/+IvxncxX7kap8kRjZ6BsY/5zEStn8Pl1MYfR5CWwLECI
 l+sBX5SMLTjWUMBX2t+wlitNJ6fsFuhhiNlFK/Bv6sn2KO7qJUPfUC9pE w==;
X-CSE-ConnectionGUID: lY/de9ngTGW5AvdbLHqcdw==
X-CSE-MsgGUID: gXUIM7p+Q3+SylbvziX0gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380909"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380909"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:17 -0700
X-CSE-ConnectionGUID: 6z10dNRSTsGar5EV5ph9UQ==
X-CSE-MsgGUID: qqZ1AnKETUCAf0qCTEiqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256531"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:16 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 28/56] drm/i915/hdmi_frl_dfm: Define frl_dfm structure
Date: Mon, 12 Oct 2026 09:27:37 +0530
Message-ID: <20261012035806.3361439-29-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

