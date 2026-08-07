Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A335C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EA510F379;
	Fri,  7 Aug 2026 04:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fh3UNXkH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD1E10F374;
 Fri,  7 Aug 2026 04:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077120; x=1817613120;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SJjYj+cwciV6L7j2NqmudzdcXqRohI9TRB843iuokIA=;
 b=Fh3UNXkHTzgPOjOm7jF/mkzFQyRRVccmpP0ad7tiO+6RRWzyUrZTjv4Q
 XFepdzsD/vGzQDPyA1fym15g43wj6pbleQ14V2rPmTZcGQ29nNzzxGAro
 IjsGoZtF72JLlqCxJ3EwBpRsZrLEgvA6vfu03WTlAFZsI4SSVdDVw2T/M
 NMrQYc6GfhTMKScILlJQSmZIn5OP+0X/deQFeQLIqisxvWF+2lcgPFxVW
 KiGz5FvMz08KEH+9E0pWco1Mv2eSau+UKXxMd+coVz19u2/+RbFEU74T9
 YKGgxDzLqSSlp2+J0zQqUJJfdHhZIwPU6Rx+AD95s+3jjFSOmUg5d6xXV g==;
X-CSE-ConnectionGUID: Yzhwr60HSGWb6E4Cfb3hwg==
X-CSE-MsgGUID: m3bvCGcVTcCvezcqfTM/kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619265"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:00 -0700
X-CSE-ConnectionGUID: 6OznZIEUTo62cOIWBdsZ2g==
X-CSE-MsgGUID: AaZxgEcRQ9eE8Gu/NOZnGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666146"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:57 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 13/44] drm/i915/hdmi: Add function to prepare registers for
 FRL mode
Date: Fri,  7 Aug 2026 09:43:58 +0530
Message-ID: <20260807041430.229038-14-ankit.k.nautiyal@intel.com>
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

Add intel_hdmi_prepare_for_frl_mode() to arm the FRL function and reset
the training pattern to the default LTP1 on all active lanes, before the
Link training sequence starts.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b0534fba4e5f..96542869740e 100644
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

