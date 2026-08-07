Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EC4C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A49C10F39C;
	Fri,  7 Aug 2026 04:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VQnZgjZ2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACC510F399;
 Fri,  7 Aug 2026 04:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077144; x=1817613144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MipMHDTwiaP9bUFDdI7lNOQnDb8HgLtsuMRKbgrfRJg=;
 b=VQnZgjZ2Z7nN+IMArCwa6p3SqMaVs1UwTvdunjyBgOLsLTVKmHOtB3Ec
 GLsyy6M0JFFPEEvGEClAz9c9o3v3/2uWL2fdMi/Z2kGoaKzP6T3uZyNRR
 n8PrbLZrO0PnDY9jSoPthKEkCC71x+mfSov9w/+NPxA0S0BqMatvAaYuk
 H1GIcWXqWK95MIeDXxNoUk2Bge0h1kV7e10G5esOd5qwKr2qRdnDyfQSs
 kO7AuP45I0qm+vV6ep5unaFfSC+elbKGCzVHLTIWod+4BrFbQnE1+DUI6
 ZJEXjTpbP0Tg61jjhfV7/ztWCewHykN/mHT6Ph8Y8U0lbTLY0LXFXx0p5 w==;
X-CSE-ConnectionGUID: PS94jEh/Qc+F1BgL1CAMsA==
X-CSE-MsgGUID: +/7VoCNsR4KnSbo3jueKnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619339"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619339"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:22 -0700
X-CSE-ConnectionGUID: I8+f1lOgRtSPigfjiTWtWQ==
X-CSE-MsgGUID: tkzVIGULQQmgiBj8X03Kxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666275"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:19 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 21/44] drm/i915/ltphy: Calculate port clock for HDMI FRL
Date: Fri,  7 Aug 2026 09:44:06 +0530
Message-ID: <20260807041430.229038-22-ankit.k.nautiyal@intel.com>
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
index 88b86510e28a..918ecb14fb5c 100644
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

