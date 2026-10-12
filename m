Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A079CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB0A510E49E;
	Mon, 12 Oct 2026 04:15:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E5010E493;
 Mon, 12 Oct 2026 04:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778508; x=1823314508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oYhl2e+gvglyZ5AND+pC2QZKqQUjnLfs27CK2y3vXLM=;
 b=YzXabHVmCQe3oixACMB/jrqISjCJLJurIprXoRs6QAswsVTMgDNlnO55
 HIUmS50W8aADFtI9QTJK6omnHO4Zr8o/UInDzh8ytugxujWzhYcWHoRHl
 ey4yLIGp2R7TdoqBiiJtb6Wv6IgdhFL1ztjJMwJkMQKGTQD2AtI9RhlEI
 tlOd9eKbfoBn8nY2PtyiWpxN47a5uAzDiYChJADY6VL79dWF3g0YINwKH
 nf5zVFxyBHELtCk3lZafmECTQ2jvdz2OPIrJeGbNe3ODNaQPGbgnyV2Hq
 53jTuSDoMSyqSTJnKWo3oMV8yae1RMtHJN0rM4yajZRTUZ6lKnK5E5pG6 w==;
X-CSE-ConnectionGUID: sIE0ggU6QFKz+xSffm1AMw==
X-CSE-MsgGUID: yu1w7g04Su2PHscf1XMzqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380886"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380886"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:02 -0700
X-CSE-ConnectionGUID: iVT8G6bIQO698mrbkVbpEw==
X-CSE-MsgGUID: HLuvZxAaShScoG4nWONXJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256450"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:01 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 21/56] drm/i915/ltphy: Calculate port clock for HDMI FRL
Date: Mon, 12 Oct 2026 09:27:30 +0530
Message-ID: <20261012035806.3361439-22-ankit.k.nautiyal@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

Define function to get the port clock after we read VDR0_CONFIG.
This helps us determine the port clock for HDMI FRL use case in LT
PHY.

Bspec: 74667, 74500
Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 23 +++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 0e2ebd550bc5..7ac0888cdf45 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -1501,6 +1501,25 @@ intel_lt_phy_program_port_clock_ctl(struct intel_encoder *encoder,
 		     XELPDP_SSC_ENABLE_PLLB, val);
 }
 
+static u32 intel_lt_phy_get_hdmi_frl_clock(u8 rate)
+{
+	switch (rate) {
+	case 0:
+		return 300000;
+	case 1:
+		return 600000;
+	case 2:
+		return 800000;
+	case 3:
+		return 1000000;
+	case 4:
+		return 1200000;
+	default:
+		MISSING_CASE(rate);
+		return 0;
+	}
+}
+
 static u32 intel_lt_phy_get_dp_clock(u8 rate)
 {
 	switch (rate) {
@@ -2000,6 +2019,10 @@ intel_lt_phy_calc_port_clock(struct intel_display *display,
 		rate = REG_FIELD_GET8(LT_PHY_VDR_RATE_ENCODING_MASK,
 				      lt_state->config[0]);
 		clk = intel_lt_phy_get_dp_clock(rate);
+	} else if (mode == MODE_HDMI_FRL) {
+		rate = REG_FIELD_GET8(LT_PHY_VDR_RATE_ENCODING_MASK,
+				      lt_state->config[0]);
+		clk = intel_lt_phy_get_hdmi_frl_clock(rate);
 	} else if (mode == MODE_HDMI_20) {
 		clk = intel_lt_phy_calc_hdmi_port_clock(display, lt_state);
 	} else {
-- 
2.50.1

