Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C984BCA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E8C710F1E6;
	Tue,  6 Oct 2026 05:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L8oU33J+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D1F10E312;
 Tue,  6 Oct 2026 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791265221; x=1822801221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nJ2LtpLu+r/oZaXSNKvL97Ztxd8bfk8jaLGm5eyfgoY=;
 b=L8oU33J+26YCwJQKI4sD3IDt7owg0VDedG4V5F37m9AUsXrjI8M/uH4V
 VGkIkvRR3RcOo3tR1dbtDRK0PEfA9id0FN3P817qrN4iLmj1TxxvxwEe1
 0UDGTRQBEuQFejaRz8QuzeTRQsBkynBbwqw5HAsZ4bRBWVhDl+TbDBIsd
 0vSxKdngG/31VzAl7Giw/OtL+BwrfR1r0EyNXs0hziLv1ysR+l0VysHzZ
 am1Y/XOSCRzKpBokLc1g+Ccmeb2hToIVDTnNHCFjh64Z234cDjyF+CSXG
 BgtleShjzvZBNxW/lDE4bFxepko1K2jk7WYCqf06foP3Kl9z179hXtXFV w==;
X-CSE-ConnectionGUID: N4hmpWRoQB+VGKZsLkepIA==
X-CSE-MsgGUID: HYkBzCyCQX2OXjaN9m67oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109434282"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="109434282"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 22:40:20 -0700
X-CSE-ConnectionGUID: boNfyRYSROqyEb9kkyT7Rg==
X-CSE-MsgGUID: nCsGQ94dTlKU/UWDoj+FRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="285160507"
Received: from pranay-x299-aorus-gaming-3-pro.iind.intel.com ([10.223.74.54])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 22:40:18 -0700
From: Pranay Samala <pranay.samala@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: chaitanya.kumar.borah@intel.com, sameer.lattannavar@intel.com,
 pranay.samala@intel.com
Subject: [PATCH v2 2/2] drm/i915/debugfs: Add HDR status to i915_display_info
Date: Tue,  6 Oct 2026 11:10:04 +0530
Message-ID: <20261006054004.285744-3-pranay.samala@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006054004.285744-1-pranay.samala@intel.com>
References: <20261006054004.285744-1-pranay.samala@intel.com>
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

i915_display_info prints per-connector state but not the current HDR
status. Add HDR details for each connector to the same debugfs file.

The HDR details are shown in three parts: sink capability, whether
userspace has set HDR_OUTPUT_METADATA, and whether the driver has
actually enabled HDR output.

Assisted-by: LLM
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
---
 .../drm/i915/display/intel_display_debugfs.c  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3e302f23f247..23c2f71f10eb 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/hdmi.h>
 #include <linux/string_choices.h>
 #include <linux/string_helpers.h>
 
@@ -243,6 +244,93 @@ static void intel_hdmi_info(struct seq_file *m,
 	seq_printf(m, "\taudio support: %s\n", str_yes_no(has_audio));
 }
 
+static void intel_hdr_sink_info(struct drm_printer *p,
+				struct drm_connector *connector)
+{
+	const struct hdr_static_metadata *hdr =
+		&connector->display_info.hdr_sink_metadata.hdmi_type1;
+	const struct drm_luminance_range_info *lum =
+		&connector->display_info.luminance_range;
+	int i;
+
+	/*
+	 * Any transfer function other than the mandatory traditional gamma
+	 * SDR one means the sink is declaring HDR support.
+	 */
+	drm_printf_indent(p, 1, "HDR sink capable: %s\n",
+			  str_yes_no(hdr->eotf &
+				     ~BIT(HDMI_EOTF_TRADITIONAL_GAMMA_SDR)));
+	if (!hdr->eotf)
+		return;
+
+	drm_printf_indent(p, 2, "supported EOTFs:\n");
+	for (i = HDMI_EOTF_TRADITIONAL_GAMMA_SDR; i <= HDMI_EOTF_BT_2100_HLG; i++)
+		if (hdr->eotf & BIT(i))
+			drm_printf_indent(p, 3, "%s\n", hdmi_eotf_get_name(i));
+
+	drm_printf_indent(p, 2, "static metadata type1: %s\n",
+			  str_yes_no(hdr->metadata_type &
+				     BIT(HDMI_STATIC_METADATA_TYPE1)));
+
+	/*
+	 * The luminance fields are optional, and an EDID that omits them is
+	 * indistinguishable from one declaring zero. luminance_range is only
+	 * populated when they are actually present.
+	 */
+	if (!lum->max_luminance) {
+		drm_printf_indent(p, 2, "luminance range: not specified\n");
+		return;
+	}
+
+	drm_printf_indent(p, 2, "luminance range: %u-%u nits\n",
+			  lum->min_luminance, lum->max_luminance);
+	drm_printf_indent(p, 2, "EDID max_cll: %u, max_fall: %u, min_cll: %u\n",
+			  hdr->max_cll, hdr->max_fall, hdr->min_cll);
+}
+
+static void intel_hdr_output_info(struct drm_printer *p,
+				  struct drm_connector *connector)
+{
+	const struct drm_connector_state *conn_state = connector->state;
+	const struct intel_crtc_state *crtc_state;
+	const struct hdmi_drm_infoframe *frame;
+
+	if (!conn_state || !conn_state->crtc)
+		return;
+
+	crtc_state = to_intel_crtc_state(conn_state->crtc->state);
+
+	drm_printf_indent(p, 1, "HDR output metadata blob: %s\n",
+			  str_yes_no(conn_state->hdr_output_metadata));
+
+	/*
+	 * Both HDMI and DP fill in infoframes.drm, but HDMI transmits it as a
+	 * DRM InfoFrame and DP as a gamut metadata SDP, each with its own
+	 * enable bit.
+	 */
+	if (!(crtc_state->infoframes.enable &
+	      (intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_DRM) |
+	       intel_hdmi_infoframe_enable(HDMI_PACKET_TYPE_GAMUT_METADATA)))) {
+		drm_printf_indent(p, 1, "HDR output: off\n");
+		return;
+	}
+
+	frame = &crtc_state->infoframes.drm.drm;
+
+	drm_printf_indent(p, 1, "HDR output: on, EOTF: %s, metadata type: %d\n",
+			  hdmi_eotf_get_name(frame->eotf), frame->metadata_type);
+	drm_printf_indent(p, 2, "primaries: r(%u,%u) g(%u,%u) b(%u,%u) wp(%u,%u)\n",
+			  frame->display_primaries[0].x, frame->display_primaries[0].y,
+			  frame->display_primaries[1].x, frame->display_primaries[1].y,
+			  frame->display_primaries[2].x, frame->display_primaries[2].y,
+			  frame->white_point.x, frame->white_point.y);
+	drm_printf_indent(p, 2, "mastering luminance: max %u nits, min %u (0.0001 nits)\n",
+			  frame->max_display_mastering_luminance,
+			  frame->min_display_mastering_luminance);
+	drm_printf_indent(p, 2, "max_cll: %u nits, max_fall: %u nits\n",
+			  frame->max_cll, frame->max_fall);
+}
+
 static void intel_connector_info(struct seq_file *m,
 				 struct drm_connector *connector)
 {
@@ -264,6 +352,7 @@ static void intel_connector_info(struct seq_file *m,
 	seq_printf(m, "\tsubpixel order: %s\n",
 		   drm_get_subpixel_order_name(connector->display_info.subpixel_order));
 	seq_printf(m, "\tCEA rev: %d\n", connector->display_info.cea_rev);
+	intel_hdr_sink_info(&p, connector);
 
 	switch (connector->connector_type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
@@ -288,6 +377,7 @@ static void intel_connector_info(struct seq_file *m,
 	intel_hdcp_info(m, intel_connector);
 
 	seq_printf(m, "\tmax bpc: %u\n", connector->display_info.bpc);
+	intel_hdr_output_info(&p, connector);
 
 	intel_panel_info(m, intel_connector);
 
-- 
2.53.0

