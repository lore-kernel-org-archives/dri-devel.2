Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CA5CA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF32D10EC7B;
	Mon, 12 Oct 2026 04:16:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBEDE10E4DB;
 Mon, 12 Oct 2026 04:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778574; x=1823314574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oB4L2j9QVOBAJkaGQuBdqBZVBK5Lu8/vtAXoYJ0IA5E=;
 b=b00+VJf1QlEAmIaCA95oIACFKaBKJEqfOOW76XTFWAwIo6t1K3R1Q3K8
 wzPi66NvgbOovtfSxLmnuIZ/WVOSpBmxVJu/5N8hAhMITUiqw0Ki9CEaV
 yS3sdyYhnSYEWbh4Kq0fHf+XyIZL1xqfkq9Lb68I9Qcx9Sl4VgCe7AHKO
 5yfK1XQTRPEQUxncRC49zbxrpDZTMNyJhrsPfOmYVi+KwFDrJwBFKQTxP
 yGoBd1JrHftye1tEZR+2itL58NkTakdyXroyViJGN8UYe0du0eyK1h5Tq
 AxoLfViJnv9vAH0OaEhpZ4fcqXs7gD+lZfBima2MmwUdXJzP6LqaxB2eI w==;
X-CSE-ConnectionGUID: mEamMfTzQkCpyqYvbltKpA==
X-CSE-MsgGUID: 5eEn+UUNTiySU68ykerUXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366212"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:14 -0700
X-CSE-ConnectionGUID: bh5+iYfnQkGrhwaFNThZiw==
X-CSE-MsgGUID: X6Kny3NzSMG3zoj9PHWbzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256798"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:12 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 52/56] drm/i915/joiner: Move joiner candidate helpers to
 intel_joiner.c
Date: Mon, 12 Oct 2026 09:28:01 +0530
Message-ID: <20261012035806.3361439-53-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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

Move intel_dp_joiner_candidate_valid() and the max hdisplay helper to
intel_joiner.c so any encoder can use them.
Replace the DP-only check with intel_joiner_connector_can_join(),
which uses connector type, allowing HDMI to be added later.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  |  6 ++--
 drivers/gpu/drm/i915/display/intel_dp.c       | 36 -------------------
 drivers/gpu/drm/i915/display/intel_dp.h       |  9 -----
 drivers/gpu/drm/i915/display/intel_joiner.c   | 35 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_joiner.h   |  9 +++++
 5 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3e302f23f247..7c0864ed0384 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -43,6 +43,7 @@
 #include "intel_hdcp.h"
 #include "intel_hdmi.h"
 #include "intel_hotplug.h"
+#include "intel_joiner.h"
 #include "intel_link_bw.h"
 #include "intel_panel.h"
 #include "intel_pps.h"
@@ -1352,12 +1353,9 @@ void intel_connector_debugfs_add(struct intel_connector *connector)
 				    connector, &i915_dsc_fractional_bpp_fops);
 	}
 
-	if ((connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
-	     connector_type == DRM_MODE_CONNECTOR_eDP) &&
-	    intel_dp_has_joiner(intel_attached_dp(connector))) {
+	if (intel_joiner_connector_can_join(connector))
 		debugfs_create_file("i915_joiner_force_enable", 0644, root,
 				    connector, &i915_joiner_fops);
-	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_DSI ||
 	    connector_type == DRM_MODE_CONNECTOR_eDP ||
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 49e4c77b5142..ba724c2e16f6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1243,11 +1243,6 @@ intel_dp_sink_format_valid(struct intel_connector *connector,
 	}
 }
 
-int intel_dp_max_hdisplay_per_pipe(struct intel_display *display)
-{
-	return DISPLAY_VER(display) >= 30 ? 6144 : 5120;
-}
-
 bool intel_dp_has_dsc(const struct intel_connector *connector)
 {
 	struct intel_display *display = to_intel_display(connector);
@@ -1268,18 +1263,6 @@ bool intel_dp_has_dsc(const struct intel_connector *connector)
 	return true;
 }
 
-static
-bool intel_dp_can_join(struct intel_dp *intel_dp,
-		       int num_joined_pipes)
-{
-	struct intel_display *display = to_intel_display(intel_dp);
-
-	if (num_joined_pipes > 1 && !intel_dp_has_joiner(intel_dp))
-		return false;
-
-	return intel_joiner_valid_primary_pipe_mask(display, num_joined_pipes);
-}
-
 bool intel_dp_dotclk_valid(struct intel_display *display,
 			   int target_clock,
 			   int htotal,
@@ -7515,25 +7498,6 @@ int intel_dp_sdp_min_guardband(const struct intel_crtc_state *crtc_state,
 	return sdp_guardband;
 }
 
-bool intel_dp_joiner_candidate_valid(struct intel_connector *connector,
-				     int hdisplay,
-				     int num_joined_pipes)
-{
-	struct intel_display *display = to_intel_display(connector);
-	struct intel_dp *intel_dp = intel_attached_dp(connector);
-
-	if (!intel_dp_can_join(intel_dp, num_joined_pipes))
-		return false;
-
-	if (hdisplay > num_joined_pipes * intel_dp_max_hdisplay_per_pipe(display))
-		return false;
-
-	if (connector->force_joined_pipes && connector->force_joined_pipes != num_joined_pipes)
-		return false;
-
-	return true;
-}
-
 u8 intel_dp_as_sdp_transmission_time(void)
 {
 	/*
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 17b6e270b05e..26d2313f2662 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -221,20 +221,11 @@ int intel_dp_compute_config_late(struct intel_encoder *encoder,
 				 struct drm_connector_state *conn_state);
 int intel_dp_sdp_min_guardband(const struct intel_crtc_state *crtc_state,
 			       bool assume_all_enabled);
-int intel_dp_max_hdisplay_per_pipe(struct intel_display *display);
 bool intel_dp_dotclk_valid(struct intel_display *display,
 			   int target_clock,
 			   int htotal,
 			   int dsc_slice_count,
 			   int num_joined_pipes);
-bool intel_dp_joiner_candidate_valid(struct intel_connector *connector,
-				     int hdisplay,
-				     int num_joined_pipes);
-
-#define for_each_joiner_candidate(__connector, __mode, __num_joined_pipes) \
-	for ((__num_joined_pipes) = 1; (__num_joined_pipes) <= (I915_MAX_PIPES); (__num_joined_pipes)++) \
-		for_each_if(intel_dp_joiner_candidate_valid(__connector, (__mode)->hdisplay, __num_joined_pipes))
-
 u8 intel_dp_as_sdp_transmission_time(void);
 
 int intel_dp_link_init(struct intel_dp *intel_dp);
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.c b/drivers/gpu/drm/i915/display/intel_joiner.c
index b9d7c9bfd1a6..4c50f226199d 100644
--- a/drivers/gpu/drm/i915/display/intel_joiner.c
+++ b/drivers/gpu/drm/i915/display/intel_joiner.c
@@ -20,3 +20,38 @@ bool intel_joiner_needs_dsc(struct intel_display *display,
 	return (!HAS_UNCOMPRESSED_JOINER(display) && num_joined_pipes == 2) ||
 		num_joined_pipes == 4;
 }
+
+static
+int intel_joiner_max_hdisplay_per_pipe(struct intel_display *display)
+{
+	return DISPLAY_VER(display) >= 30 ? 6144 : 5120;
+}
+
+bool intel_joiner_connector_can_join(struct intel_connector *connector)
+{
+	switch (connector->base.connector_type) {
+	case DRM_MODE_CONNECTOR_DisplayPort:
+	case DRM_MODE_CONNECTOR_eDP:
+		return intel_dp_has_joiner(intel_attached_dp(connector));
+	default:
+		return false;
+	}
+}
+
+bool intel_joiner_candidate_valid(struct intel_connector *connector,
+				  int hdisplay,
+				  int num_joined_pipes)
+{
+	struct intel_display *display = to_intel_display(connector);
+
+	if (hdisplay > num_joined_pipes * intel_joiner_max_hdisplay_per_pipe(display))
+		return false;
+
+	if (connector->force_joined_pipes && connector->force_joined_pipes != num_joined_pipes)
+		return false;
+
+	if (num_joined_pipes > 1 && !intel_joiner_connector_can_join(connector))
+		return false;
+
+	return intel_joiner_valid_primary_pipe_mask(display, num_joined_pipes);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.h b/drivers/gpu/drm/i915/display/intel_joiner.h
index a091eab2f86d..85e19ed1527f 100644
--- a/drivers/gpu/drm/i915/display/intel_joiner.h
+++ b/drivers/gpu/drm/i915/display/intel_joiner.h
@@ -8,9 +8,18 @@
 
 #include <linux/types.h>
 
+struct intel_connector;
 struct intel_display;
 
 bool intel_joiner_needs_dsc(struct intel_display *display,
 			    int num_joined_pipes);
+bool intel_joiner_connector_can_join(struct intel_connector *connector);
+bool intel_joiner_candidate_valid(struct intel_connector *connector,
+				  int hdisplay,
+				  int num_joined_pipes);
+
+#define for_each_joiner_candidate(__connector, __mode, __num_joined_pipes) \
+	for ((__num_joined_pipes) = 1; (__num_joined_pipes) <= (I915_MAX_PIPES); (__num_joined_pipes)++) \
+		for_each_if(intel_joiner_candidate_valid(__connector, (__mode)->hdisplay, __num_joined_pipes))
 
 #endif /* __INTEL_JOINER_H__ */
-- 
2.50.1

