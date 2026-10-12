Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD6BCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516D210EBA2;
	Mon, 12 Oct 2026 04:16:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D4D10EB4B;
 Mon, 12 Oct 2026 04:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778572; x=1823314572;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yBwAkkqBz2zTMbrwZ/psfDbgRNpmiwchxhRYZr9teQ4=;
 b=SWf1CMDCf6dcJ8wBTuAXgEAvOoeFVlF1dzizqC+Ck3jEQGiIsUHE5E0B
 Ebl+2HBFbiQrmrXf1E/OrDjlRKgXddvg1mc6yjCeBlPUuiYe1l6jffrnF
 XEANYETkyVbItjqMWlhzvO90dkpCd78YHjCsBKBbNbfb+PXrFzHm3CuD3
 qwO7tHt+XkjATwVaT8Hotj0WlvsFDfZtc2nLq32EQhhR2a5t373vNYy+y
 a0beSAlvijQwaS9Ec9mcIExsu3Y+tyiMtNZ+YdLQkOjevg1GxoE1HhUaB
 JvPCpfC5W0H150PnJGxEXcrEjZls8s761YQhifWkESSPLNNzimle4ZEHQ Q==;
X-CSE-ConnectionGUID: PWMS2LFCT+6yy3N7BUsgGg==
X-CSE-MsgGUID: QgN6PjHxTKWFrWMZGZuV5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366209"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:11 -0700
X-CSE-ConnectionGUID: eAfStZVZSTqx/txC9e6nWA==
X-CSE-MsgGUID: 2ARiJYmRT1yHMSDs5M2KZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256785"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:09 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 51/56] drm/i915/joiner: Prepare to move joiner helpers to a
 new file
Date: Mon, 12 Oct 2026 09:28:00 +0530
Message-ID: <20261012035806.3361439-52-ankit.k.nautiyal@intel.com>
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

Currently pipe-joiner is supported only for DP. To enable higher resolution
for HDMI, joiner support is required for HDMI also.

Create a new file intel_joiner.c to have the common joiner helpers that
can be used by any encoder.

Start with moving intel_dp_joiner_needs_dsc() helper from intel_dp.c
to the new file.

In subsequent changes other joiner helpers will follow.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/Makefile               |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c     | 18 +++--------------
 drivers/gpu/drm/i915/display/intel_dp.h     |  2 --
 drivers/gpu/drm/i915/display/intel_dp_mst.c |  5 +++--
 drivers/gpu/drm/i915/display/intel_joiner.c | 22 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_joiner.h | 16 +++++++++++++++
 drivers/gpu/drm/xe/Makefile                 |  1 +
 7 files changed, 46 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_joiner.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_joiner.h

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index d6abb79d5696..be5fe25ca314 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -369,6 +369,7 @@ i915-y += \
 	display/intel_gmbus.o \
 	display/intel_hdmi.o \
 	display/intel_hdmi_frl_dfm.o \
+	display/intel_joiner.o \
 	display/intel_lspcon.o \
 	display/intel_lt_phy.o \
 	display/intel_lvds.o \
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d8c0d9381471..49e4c77b5142 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -86,6 +86,7 @@
 #include "intel_hdmi.h"
 #include "intel_hotplug.h"
 #include "intel_hotplug_irq.h"
+#include "intel_joiner.h"
 #include "intel_lspcon.h"
 #include "intel_lvds.h"
 #include "intel_modeset_lock.h"
@@ -1390,7 +1391,7 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 			}
 		}
 
-		if (intel_dp_joiner_needs_dsc(display, num_joined_pipes) && !dsc) {
+		if (intel_joiner_needs_dsc(display, num_joined_pipes) && !dsc) {
 			status = MODE_CLOCK_HIGH;
 			continue;
 		}
@@ -2794,19 +2795,6 @@ int intel_dp_config_required_rate(const struct intel_crtc_state *crtc_state)
 				      link_bpp_x16, 0);
 }
 
-bool intel_dp_joiner_needs_dsc(struct intel_display *display,
-			       int num_joined_pipes)
-{
-	/*
-	 * Pipe joiner needs compression up to display 12 due to bandwidth
-	 * limitation. DG2 onwards pipe joiner can be enabled without
-	 * compression.
-	 * Ultrajoiner always needs compression.
-	 */
-	return (!HAS_UNCOMPRESSED_JOINER(display) && num_joined_pipes == 2) ||
-		num_joined_pipes == 4;
-}
-
 static int
 intel_dp_compute_link_for_joined_pipes(struct intel_encoder *encoder,
 				       struct intel_crtc_state *pipe_config,
@@ -2826,7 +2814,7 @@ intel_dp_compute_link_for_joined_pipes(struct intel_encoder *encoder,
 
 	intel_dp_dsc_reset_config(pipe_config);
 
-	joiner_needs_dsc = intel_dp_joiner_needs_dsc(display, num_joined_pipes);
+	joiner_needs_dsc = intel_joiner_needs_dsc(display, num_joined_pipes);
 
 	dsc_needed = joiner_needs_dsc || intel_dp->force_dsc_en ||
 		     !intel_dp_compute_config_limits(intel_dp, conn_state, pipe_config,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 04fae203bb69..17b6e270b05e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -125,8 +125,6 @@ int intel_dp_effective_data_rate(int pixel_clock, int bpp_x16,
 				 int bw_overhead);
 int intel_dp_max_link_data_rate(struct intel_dp *intel_dp,
 				int max_dprx_rate, int max_dprx_lanes);
-bool intel_dp_joiner_needs_dsc(struct intel_display *display,
-			       int num_joined_pipes);
 bool intel_dp_has_joiner(struct intel_dp *intel_dp);
 bool intel_dp_needs_vsc_colorimetry(const struct intel_crtc_state *crtc_state,
 				    const struct drm_connector_state *conn_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 7023619aaaba..89f107b8271c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -55,6 +55,7 @@
 #include "intel_dpio_phy.h"
 #include "intel_hdcp.h"
 #include "intel_hotplug.h"
+#include "intel_joiner.h"
 #include "intel_link_bw.h"
 #include "intel_pfit.h"
 #include "intel_psr.h"
@@ -652,7 +653,7 @@ static int mst_stream_compute_link_for_joined_pipes(struct intel_encoder *encode
 
 	intel_dp_dsc_reset_config(pipe_config);
 
-	joiner_needs_dsc = intel_dp_joiner_needs_dsc(display, num_joined_pipes);
+	joiner_needs_dsc = intel_joiner_needs_dsc(display, num_joined_pipes);
 
 	dsc_needed = joiner_needs_dsc || intel_dp->force_dsc_en ||
 		!mst_stream_compute_config_limits(intel_dp, conn_state,
@@ -1621,7 +1622,7 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 							   bw_overhead_flags);
 		}
 
-		if (intel_dp_joiner_needs_dsc(display, num_joined_pipes) && !dsc) {
+		if (intel_joiner_needs_dsc(display, num_joined_pipes) && !dsc) {
 			*status = MODE_CLOCK_HIGH;
 			continue;
 		}
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.c b/drivers/gpu/drm/i915/display/intel_joiner.c
new file mode 100644
index 000000000000..b9d7c9bfd1a6
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_joiner.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include "intel_display_core.h"
+#include "intel_display_types.h"
+#include "intel_dp.h"
+#include "intel_joiner.h"
+
+bool intel_joiner_needs_dsc(struct intel_display *display,
+			    int num_joined_pipes)
+{
+	/*
+	 * Pipe joiner needs compression up to display 12 due to bandwidth
+	 * limitation. DG2 onwards pipe joiner can be enabled without
+	 * compression.
+	 * Ultrajoiner always needs compression.
+	 */
+	return (!HAS_UNCOMPRESSED_JOINER(display) && num_joined_pipes == 2) ||
+		num_joined_pipes == 4;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.h b/drivers/gpu/drm/i915/display/intel_joiner.h
new file mode 100644
index 000000000000..a091eab2f86d
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_joiner.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef __INTEL_JOINER_H__
+#define __INTEL_JOINER_H__
+
+#include <linux/types.h>
+
+struct intel_display;
+
+bool intel_joiner_needs_dsc(struct intel_display *display,
+			    int num_joined_pipes);
+
+#endif /* __INTEL_JOINER_H__ */
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index b950ea6bb303..a920db3232e0 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -313,6 +313,7 @@ xe-$(CONFIG_DRM_XE_DISPLAY) += \
 	i915-display/intel_hotplug_irq.o \
 	i915-display/intel_hti.o \
 	i915-display/intel_initial_plane.o \
+	i915-display/intel_joiner.o \
 	i915-display/intel_link_bw.o \
 	i915-display/intel_lspcon.o \
 	i915-display/intel_lt_phy.o \
-- 
2.50.1

