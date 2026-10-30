Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A8606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q26zlfWB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D2911278D;
	Fri, 30 Oct 2026 12:03:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806C510E115;
 Fri, 30 Oct 2026 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793361806; x=1824897806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nCuAF8xQYj1yCE1wcYgX3BUs9X+aPkAT9gmcbfg7QzE=;
 b=Q26zlfWB9N0LrSiKTZEELYprDLXxCliyjNB7PKIiulhLqOmMjMb2IA7V
 f95Fz8490jzPBRlrXN2aef3P3knfVC2k2eOXu6BjFPo+GVFJiYNSIgIkM
 7lYinYWULF0IvWLdC/AgCseKv7j7OovrLd19PFuDgPNYhHv+arCX966Yf
 hybCS7mzxiUFSCK2n3SDevBt3da1c1yaiCyG+Gdjhr36A3F1KRFUi9GQL
 GKovHsB88P6yo6P7Q0Z4FDIb+ZsLzesx5jiGRGqVYDYGj6cRqNgbz0Imi
 RBZg4rgJ87U8e7viqHEUgvrPUjqNZrYd5hmP2UCRuY+Fb/FWXflhJaNQf g==;
X-CSE-ConnectionGUID: BOxNQxeARtOeusV+8TSalg==
X-CSE-MsgGUID: 1T5aQ9kwQn+ozOSd2fKpWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2226486"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2226486"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:25 -0700
X-CSE-ConnectionGUID: I0NHBZTRQaSD2ATcai6D3w==
X-CSE-MsgGUID: tz1K+2tAQVu0Iwbww7wHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7210972"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 05:03:23 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: jani.nikula@intel.com
Subject: [PATCH 01/13] drm/dp: pass struct drm_printer to
 drm_dp_downstream_debug()
Date: Fri, 30 Oct 2026 14:03:04 +0200
Message-ID: <4469a3881155f067bd127fcaa21b7b2ec8d2fb48.1793361738.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

struct drm_printer is more versatile than struct seq_file, and allows
the use of drm_printer helpers. Switch to it.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c       | 36 +++++++++----------
 .../drm/i915/display/intel_display_debugfs.c  |  3 +-
 include/drm/display/drm_dp_helper.h           |  3 +-
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 488fd123a01a..166a77091abe 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1660,14 +1660,14 @@ EXPORT_SYMBOL(drm_dp_downstream_id);
 
 /**
  * drm_dp_downstream_debug() - debug DP branch devices
- * @m: pointer for debugfs file
+ * @p: pointer to drm printer
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
  * @drm_edid: EDID
  * @aux: DisplayPort AUX channel
  *
  */
-void drm_dp_downstream_debug(struct seq_file *m,
+void drm_dp_downstream_debug(struct drm_printer *p,
 			     const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			     const u8 port_cap[4],
 			     const struct drm_edid *drm_edid,
@@ -1683,7 +1683,7 @@ void drm_dp_downstream_debug(struct seq_file *m,
 	int type = port_cap[0] & DP_DS_PORT_TYPE_MASK;
 	bool branch_device = drm_dp_is_branch(dpcd);
 
-	seq_printf(m, "\tDP branch device present: %s\n",
+	drm_printf(p, "\tDP branch device present: %s\n",
 		   str_yes_no(branch_device));
 
 	if (!branch_device)
@@ -1691,60 +1691,60 @@ void drm_dp_downstream_debug(struct seq_file *m,
 
 	switch (type) {
 	case DP_DS_PORT_TYPE_DP:
-		seq_puts(m, "\t\tType: DisplayPort\n");
+		drm_puts(p, "\t\tType: DisplayPort\n");
 		break;
 	case DP_DS_PORT_TYPE_VGA:
-		seq_puts(m, "\t\tType: VGA\n");
+		drm_puts(p, "\t\tType: VGA\n");
 		break;
 	case DP_DS_PORT_TYPE_DVI:
-		seq_puts(m, "\t\tType: DVI\n");
+		drm_puts(p, "\t\tType: DVI\n");
 		break;
 	case DP_DS_PORT_TYPE_HDMI:
-		seq_puts(m, "\t\tType: HDMI\n");
+		drm_puts(p, "\t\tType: HDMI\n");
 		break;
 	case DP_DS_PORT_TYPE_NON_EDID:
-		seq_puts(m, "\t\tType: others without EDID support\n");
+		drm_puts(p, "\t\tType: others without EDID support\n");
 		break;
 	case DP_DS_PORT_TYPE_DP_DUALMODE:
-		seq_puts(m, "\t\tType: DP++\n");
+		drm_puts(p, "\t\tType: DP++\n");
 		break;
 	case DP_DS_PORT_TYPE_WIRELESS:
-		seq_puts(m, "\t\tType: Wireless\n");
+		drm_puts(p, "\t\tType: Wireless\n");
 		break;
 	default:
-		seq_puts(m, "\t\tType: N/A\n");
+		drm_puts(p, "\t\tType: N/A\n");
 	}
 
 	memset(id, 0, sizeof(id));
 	drm_dp_downstream_id(aux, id);
-	seq_printf(m, "\t\tID: %s\n", id);
+	drm_printf(p, "\t\tID: %s\n", id);
 
 	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_HW_REV, &rev[0], 1);
 	if (!len)
-		seq_printf(m, "\t\tHW: %d.%d\n",
+		drm_printf(p, "\t\tHW: %d.%d\n",
 			   (rev[0] & 0xf0) >> 4, rev[0] & 0xf);
 
 	len = drm_dp_dpcd_read_data(aux, DP_BRANCH_SW_REV, rev, 2);
 	if (!len)
-		seq_printf(m, "\t\tSW: %d.%d\n", rev[0], rev[1]);
+		drm_printf(p, "\t\tSW: %d.%d\n", rev[0], rev[1]);
 
 	if (detailed_cap_info) {
 		clk = drm_dp_downstream_max_dotclock(dpcd, port_cap);
 		if (clk > 0)
-			seq_printf(m, "\t\tMax dot clock: %d kHz\n", clk);
+			drm_printf(p, "\t\tMax dot clock: %d kHz\n", clk);
 
 		clk = drm_dp_downstream_max_tmds_clock(dpcd, port_cap, drm_edid);
 		if (clk > 0)
-			seq_printf(m, "\t\tMax TMDS clock: %d kHz\n", clk);
+			drm_printf(p, "\t\tMax TMDS clock: %d kHz\n", clk);
 
 		clk = drm_dp_downstream_min_tmds_clock(dpcd, port_cap, drm_edid);
 		if (clk > 0)
-			seq_printf(m, "\t\tMin TMDS clock: %d kHz\n", clk);
+			drm_printf(p, "\t\tMin TMDS clock: %d kHz\n", clk);
 
 		bpc = drm_dp_downstream_max_bpc(dpcd, port_cap, drm_edid);
 
 		if (bpc > 0)
-			seq_printf(m, "\t\tMax bpc: %d\n", bpc);
+			drm_printf(p, "\t\tMax bpc: %d\n", bpc);
 	}
 }
 EXPORT_SYMBOL(drm_dp_downstream_debug);
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 00d207bfb71d..93e80b5e7ce8 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -219,12 +219,13 @@ static void intel_dp_info(struct seq_file *m, struct intel_connector *connector)
 {
 	struct intel_encoder *intel_encoder = intel_attached_encoder(connector);
 	struct intel_dp *intel_dp = enc_to_intel_dp(intel_encoder);
+	struct drm_printer p = drm_seq_file_printer(m);
 
 	seq_printf(m, "\tDPCD rev: %x\n", intel_dp->dpcd[DP_DPCD_REV]);
 	seq_printf(m, "\taudio support: %s\n",
 		   str_yes_no(connector->base.display_info.has_audio));
 
-	drm_dp_downstream_debug(m, intel_dp->dpcd, intel_dp->downstream_ports,
+	drm_dp_downstream_debug(&p, intel_dp->dpcd, intel_dp->downstream_ports,
 				connector->detect_edid, &intel_dp->aux);
 }
 
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe174..f497c9f3a550 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -32,6 +32,7 @@
 struct drm_device;
 struct drm_dp_aux;
 struct drm_panel;
+struct drm_printer;
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
@@ -744,7 +745,7 @@ struct drm_display_mode *drm_dp_downstream_mode(struct drm_device *dev,
 						const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 						const u8 port_cap[4]);
 int drm_dp_downstream_id(struct drm_dp_aux *aux, char id[6]);
-void drm_dp_downstream_debug(struct seq_file *m,
+void drm_dp_downstream_debug(struct drm_printer *p,
 			     const u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			     const u8 port_cap[4],
 			     const struct drm_edid *drm_edid,
-- 
2.47.3

