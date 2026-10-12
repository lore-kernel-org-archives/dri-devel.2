Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2624ACA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38C110E3DB;
	Mon, 12 Oct 2026 04:14:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731FF10E102;
 Mon, 12 Oct 2026 04:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778457; x=1823314457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=19gL4w8mizjW7xFE0BzSLOsZxs4sanxT3zmqmehV9Zk=;
 b=Nt7jyiNHQFxGWXX6Ca5GwgBs7G67ak8wXiCNhNNF+kCZ0JJ0l4Z4DaVd
 Xd/E6CricnNb+vPrxsz/XQKB7UFN1CFIIswO/Fms8yU3hZvag+6R9o8sp
 e0IzukswPFbQzXE7g6WOFJAGVChNWUEmX+ChCug3GhS5nzY8wIF3jg8z0
 ar+USRSOUDCWX8Mk/L142+xmjLtCNqpGAQlPq4S0ycV789p9TORilNxbq
 FzmeeQffXNBJkyMqT5ZnrxgHKdsx1DDmD+QT7uTC/6c74z9cUdj8YRFJD
 uMgt/6Sbivr8sUGWkzzBg9D45Nqpxtn3iVBJYvXy9FQrOsrLAIyZrKpIK g==;
X-CSE-ConnectionGUID: mi1HMbHVSxiqk85sDGl0sA==
X-CSE-MsgGUID: Hbk1jOxZR9KxOQVvj2Z/CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380803"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380803"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:16 -0700
X-CSE-ConnectionGUID: p1hF9R6PQACmouaZJ5r2pg==
X-CSE-MsgGUID: FAQ8FtwQRzGdJoNwMsGKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256310"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:15 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 01/56] drm/i915/hdmi: Parse FRL max link rate from VBT
Date: Mon, 12 Oct 2026 09:27:10 +0530
Message-ID: <20261012035806.3361439-2-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Parse the maximum FRL link rate from VBT and store it for use
during FRL mode selection and link training.

v3:
- Bail out early for VBT version < 237 and resolve the max FRL rate in a
  single switch, handling hdmi_max_frl_rate_valid == 0 up front. (Jani)
- Drop the intel_bios_hdmi_max_frl_rate() encoder wrapper and take the
  encoder devdata directly. (Jani)
- Use the standard VBT debug message format. (Jani)
- Spell FRL and VBT in caps in the subject and debug message. (Suraj, Jani)
- Move the hdmi_max_frl_rate_valid == 0 comment onto the check it
  describes. (Suraj)
- Add Bspec reference. (Suraj)

Bspec: XXXXX
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c     | 39 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 ++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 7b6a6f8c3cf1..7181237508b3 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -2788,12 +2788,45 @@ static bool is_port_valid(struct intel_display *display, enum port port)
 	return true;
 }
 
+int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *devdata)
+{
+	struct intel_display *display = devdata->display;
+
+	if (display->vbt.version < 237)
+		return 0;
+
+	/*
+	 * When hdmi_max_frl_rate_valid is 0 the VBT does not specify a maximum
+	 * FRL rate, so don't use it to limit the FRL rate on FRL-capable
+	 * platforms.
+	 */
+	if (!devdata->child.hdmi_max_frl_rate_valid)
+		return display->platform.meteorlake ? 12000000 : 0;
+
+	switch (devdata->child.hdmi_max_frl_rate) {
+	default:
+	case HDMI_MAX_FRL_RATE_PLATFORM:
+		return 0;
+	case HDMI_MAX_FRL_RATE_3G:
+		return 3000000;
+	case HDMI_MAX_FRL_RATE_6G:
+		return 6000000;
+	case HDMI_MAX_FRL_RATE_8G:
+		return 8000000;
+	case HDMI_MAX_FRL_RATE_10G:
+		return 10000000;
+	case HDMI_MAX_FRL_RATE_12G:
+		return 12000000;
+	}
+}
+
 static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
 {
 	struct intel_display *display = devdata->display;
 	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt, supports_typec_usb, supports_tbt;
 	int dp_boost_level, dp_max_link_rate, hdmi_boost_level, hdmi_level_shift, max_tmds_clock;
 	enum port port;
+	int hdmi_max_frl_rate;
 
 	port = intel_bios_encoder_port(devdata);
 	if (port == PORT_NONE)
@@ -2863,6 +2896,12 @@ static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
 		drm_dbg_kms(display->drm,
 			    "Port %c VBT DP max link rate: %d\n",
 			    port_name(port), dp_max_link_rate);
+
+	hdmi_max_frl_rate = intel_bios_hdmi_max_frl_rate(devdata);
+	if (hdmi_max_frl_rate)
+		drm_dbg_kms(display->drm,
+			    "Port %c VBT HDMI max FRL rate: %d\n",
+			    port_name(port), hdmi_max_frl_rate);
 }
 
 static void parse_ddi_port(struct intel_bios_encoder_data *devdata)
diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
index 196b8b3f434f..b89f72d90c1f 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -112,6 +112,7 @@ int intel_bios_hdmi_boost_level(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_ddc_pin(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_level_shift(const struct intel_bios_encoder_data *devdata);
 int intel_bios_hdmi_max_tmds_clock(const struct intel_bios_encoder_data *devdata);
+int intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *devdata);
 
 void intel_bios_for_each_encoder(struct intel_display *display,
 				 void (*func)(struct intel_display *display,
diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
index 0dc13d080e8a..db7484542dc0 100644
--- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
+++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
@@ -381,6 +381,13 @@ struct bdb_general_features {
 #define HDMI_MAX_DATA_RATE_340		4			/* 249+ */
 #define HDMI_MAX_DATA_RATE_300		5			/* 249+ */
 
+#define HDMI_MAX_FRL_RATE_PLATFORM	0			/* 237 */
+#define HDMI_MAX_FRL_RATE_3G		1			/* 237 */
+#define HDMI_MAX_FRL_RATE_6G		2			/* 237 */
+#define HDMI_MAX_FRL_RATE_8G		3			/* 237 */
+#define HDMI_MAX_FRL_RATE_10G		4			/* 237 */
+#define HDMI_MAX_FRL_RATE_12G		5			/* 237 */
+
 #define LEGACY_CHILD_DEVICE_CONFIG_SIZE		33
 
 /* DDC Bus DDI Type 155+ */
-- 
2.50.1

