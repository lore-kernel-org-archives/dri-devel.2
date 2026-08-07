Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E51C5ACAC
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6097410F34F;
	Fri,  7 Aug 2026 04:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q8RywNL7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AD910F342;
 Fri,  7 Aug 2026 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077090; x=1817613090;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e0P7AKuUX1LvMAIFwgeEgC2jXHbS9qzRUOL0AFOOdfA=;
 b=Q8RywNL7gqI2d+fM+J1xz3UWNtmKcDmFluyH73flTTLlvYKQ4CdVdPzE
 dyLIoMMHhgC9nxXGz8+ewYAFnK1zUWOxZEnkxamL7277+RP8OtPhIyIdc
 Dukyaq9Bgs5yGt5JD9e/4cRztqfEFtUvp+YA3gF0Q7ryr/oXyrFPIhEzN
 Z+nl3hAA0D+ouXLfNbJ+drDJL6TCLXfq2840ZywdGFtWVRAzIRUecCFct
 m9Ibk75rSZj3Zpd8bzYmWYjakvd4BEFCQTGhIZdaiuTA6DO2M2SBBCxeL
 iysmV4dzh8wwsNXWw5sVW+0Wlavo4P6s8Df7z4V5BkLd7Wns5WUrrY2Bk w==;
X-CSE-ConnectionGUID: X2opfasBR1+rUtjykrmS4Q==
X-CSE-MsgGUID: jXpHX9GmQIqTHdlxpfnMww==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619233"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:29 -0700
X-CSE-ConnectionGUID: 7g0v9c7MSTmqbW5ZB8JoTw==
X-CSE-MsgGUID: jNCFWTleQOiZEkNxJN1wCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666026"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:27 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 01/44] drm/i915/hdmi: Parse frl max link rate from vbt
Date: Fri,  7 Aug 2026 09:43:46 +0530
Message-ID: <20260807041430.229038-2-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_bios.c     | 53 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
 drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 +++
 3 files changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
index 97cbae2e547e..6354fa4041dc 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.c
+++ b/drivers/gpu/drm/i915/display/intel_bios.c
@@ -2734,6 +2734,43 @@ static bool is_port_valid(struct intel_display *display, enum port port)
 	return true;
 }
 
+static int _intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *devdata)
+{
+	struct intel_display *display = devdata->display;
+
+	if (display->vbt.version >= 237 &&
+	    devdata->child.hdmi_max_frl_rate_valid) {
+		switch (devdata->child.hdmi_max_frl_rate) {
+		default:
+		case HDMI_MAX_FRL_RATE_PLATFORM:
+			drm_dbg_kms(display->drm,
+				    "HDMI limited to support only TMDS modes\n");
+			return 0;
+		case HDMI_MAX_FRL_RATE_3G:
+			return 3000000;
+		case HDMI_MAX_FRL_RATE_6G:
+			return 6000000;
+		case HDMI_MAX_FRL_RATE_8G:
+			return 8000000;
+		case HDMI_MAX_FRL_RATE_10G:
+			return 10000000;
+		case HDMI_MAX_FRL_RATE_12G:
+			return 12000000;
+		}
+	}
+
+	/*
+	 * When hdmi_max_frl_rate_valid is 0
+	 * Don't consider the hdmi_max_frl_rate for
+	 * limiting the FRL Rates on FRL-capable displays
+	 */
+	if (display->vbt.version >= 237 &&
+	    display->platform.meteorlake)
+		return 12000000;
+
+	return 0;
+}
+
 static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
 {
 	struct intel_display *display = devdata->display;
@@ -2741,6 +2778,7 @@ static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
 	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt, supports_typec_usb, supports_tbt;
 	int dp_boost_level, dp_max_link_rate, hdmi_boost_level, hdmi_level_shift, max_tmds_clock;
 	enum port port;
+	int hdmi_max_frl_rate;
 
 	port = intel_bios_encoder_port(devdata);
 	if (port == PORT_NONE)
@@ -2806,6 +2844,12 @@ static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
 			    "Port %c VBT DP max link rate: %d\n",
 			    port_name(port), dp_max_link_rate);
 
+	hdmi_max_frl_rate = _intel_bios_hdmi_max_frl_rate(devdata);
+	if (hdmi_max_frl_rate)
+		drm_dbg_kms(display->drm,
+			    "VBT HDMI max frl rate for port %c: %d\n",
+			    port_name(port), hdmi_max_frl_rate);
+
 	/*
 	 * FIXME need to implement support for VBT
 	 * vswing/preemph tables should this ever trigger.
@@ -3879,3 +3923,12 @@ void intel_bios_debugfs_register(struct intel_display *display)
 	debugfs_create_file("i915_vbt", 0444, display->drm->debugfs_root,
 			    display, &intel_bios_vbt_fops);
 }
+
+int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	const struct intel_bios_encoder_data *devdata;
+
+	devdata = intel_bios_encoder_data_lookup(display, encoder->port);
+	return _intel_bios_hdmi_max_frl_rate(devdata);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
index 75dff27b4228..53d46c9fa6e1 100644
--- a/drivers/gpu/drm/i915/display/intel_bios.h
+++ b/drivers/gpu/drm/i915/display/intel_bios.h
@@ -102,6 +102,7 @@ int intel_bios_hdmi_max_tmds_clock(const struct intel_bios_encoder_data *devdata
 void intel_bios_for_each_encoder(struct intel_display *display,
 				 void (*func)(struct intel_display *display,
 					      const struct intel_bios_encoder_data *devdata));
+int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder);
 
 void intel_bios_debugfs_register(struct intel_display *display);
 
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

