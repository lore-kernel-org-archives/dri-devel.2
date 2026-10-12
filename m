Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726FCCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD5F10E46F;
	Mon, 12 Oct 2026 04:14:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1EA110E467;
 Mon, 12 Oct 2026 04:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778484; x=1823314484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+0DVlJde+lEMkJbTZuD7n3GWC62KXrzInOGhEBLGsTI=;
 b=IrV6TJiX46TDZ0MwMMEYS+PCrpnGBGtdtlx4//x7ckKZAdtrsd28wT0r
 5u40ZOJpLMscputrl/A+WWJC8+wLG5y3o7Le1k5MCF8++oJ9RTw2vG/4s
 Znl//9lQroelPjJhVbyp6EDGCWRkVLrnlHqcXDaT9pGsNRbEgw8fTmXIe
 vxT+f92VhfwPEv0hSovOKLE/MLFJYorN7dCLgJrSSRfZUoooAi94NGfRx
 TZ3DerSJ8oTe2OWvt1sXAK3Z5aY12cpjTP83VUzgtldoj+om+jhkc3Kkv
 SfKNp439lWlGHTgprAiqQgoeTbG/RvPf63roeg17jLkUkvfVachMrbpup A==;
X-CSE-ConnectionGUID: +cCu1sK0Q3qnFP0LgGfyWQ==
X-CSE-MsgGUID: oNRoZQywSyeUFAR2+Nyzjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380846"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380846"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:43 -0700
X-CSE-ConnectionGUID: 0KtbW7EZRNucvVCCS8L5Zg==
X-CSE-MsgGUID: LJhoDyZISDOhPQzlj/w/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256388"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:42 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 13/56] drm/i915/hdmi: Add function to prepare registers for
 FRL mode
Date: Mon, 12 Oct 2026 09:27:22 +0530
Message-ID: <20261012035806.3361439-14-ankit.k.nautiyal@intel.com>
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

Add intel_hdmi_prepare_for_frl_mode() to arm the FRL function and reset
the training pattern to the default LTP1 on all active lanes, before the
Link training sequence starts.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ac655d9e4d79..692480311c74 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3501,3 +3501,25 @@ int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector)
 
 	return max_lanes * rate_per_lane;
 }
+
+void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder trans = crtc_state->cpu_transcoder;
+	int num_lanes = crtc_state->frl.required_lanes;
+	u32 write_buf = 0;
+	int lane;
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, trans),
+		     TRANS_HDMI_FRL_TRAINING_COMPLETE,
+		     TRANS_HDMI_FRL_ENABLE);
+
+	/* Reset Training Pattern to default 0x1 */
+	for (lane = 0; lane < num_lanes; lane++)
+		write_buf |= TRANS_HDMI_FRL_LTP(0x1, lane);
+
+	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index c95ed37bcc0c..6283305b5274 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -63,7 +63,7 @@ int intel_hdmi_dsc_get_num_slices(const struct drm_display_mode *mode,
 				  int hdmi_max_slices, int hdmi_throughput);
 int intel_hdmi_dsc_get_slice_height(int vactive);
 bool intel_hdmi_is_frl(u32 clock);
-
+void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state);
 void hsw_write_infoframe(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state,
 			 unsigned int type,
-- 
2.50.1

