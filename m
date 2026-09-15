Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF0BC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2951A10ED20;
	Tue, 15 Sep 2026 18:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TYHiY0xK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F4E710ED18;
 Tue, 15 Sep 2026 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497561; x=1821033561;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RbfkNIQHg7wSl/6+61JFRNCxIZ/YBQDabgbU8jtMobY=;
 b=TYHiY0xKKE0Ra41VdRodunwA+Jvo6/U1fQaJlP0TY512TBm/W3fxo9CK
 cd6AVvW9PTFqp+eVZsftsxIhsYCp5C5Pw3/MLSNM0t1u2KnEg6e8C2icD
 nFziUWxyKO3QAvzQf3TbXEfhOIOlbIiIz0gvMIH8FNU2T9YLs3+gZZ3me
 MMTFcDvQvFkfPdPJsas10iiOEf6tR22vn92/AUQWGGTIbNn8asQie5ZVt
 2QDUh0UcqoPU9BEaEyyvNAuqBrmTN5RPXSJd0DUaVUKWKrjkrmJeNRqct
 6KTUPmgfA5c7rt07yjpB0zZv/wb/0da6XsqcuGBcFJ7SeYGW82Z6BBhhp w==;
X-CSE-ConnectionGUID: 4gB3pgzwR/KtxVtr5VltWg==
X-CSE-MsgGUID: ZasgtjsUTLucMoCh0LHfNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380297"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380297"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:21 -0700
X-CSE-ConnectionGUID: exlYGZBTSwK0P6h5N9SWFw==
X-CSE-MsgGUID: O/m0/sRjTRumufyuTYomWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148496"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:18 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 08/18] drm/i915/alpm: table based establishment period
Date: Tue, 15 Sep 2026 23:34:39 +0530
Message-Id: <20260915180449.277933-9-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

Only use the table when the link rate is listed (idx valid)
and the LTTPR count is within the table bounds. A zero entry
means the rate has no tabulated value, so fall back to the
computed establishment period below.

Note: The table and its values are taken from DP2.1 vesa spec.

v2: Add check for negative error codes from drm_dp_lttpr_count(). [sashiko]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 95 +++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index dc025058a626..cb24bba801a1 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -122,6 +122,92 @@ static int get_dp_link_symbol_size(const struct intel_crtc_state *crtc_state)
 	return intel_dp_is_uhbr(crtc_state) ? 32 : 10;
 }
 
+#define DEFAULT_MAX_LTTPR_COUNT 7
+#define MAX_SUPPORTED_DP_LINK_RATES 12
+
+static const u32 establishment_periods[DEFAULT_MAX_LTTPR_COUNT][MAX_SUPPORTED_DP_LINK_RATES] = {
+	/* 1620, 2160, 2430, 2700, 3240, 4320, 5400, 6750, 8100, 10000, 13500, 20000 */
+	/* No Retimers */
+	{ 61070, 0, 0, 56710, 0, 0, 53450, 0, 52360, 59050, 56750, 54620 },
+	/*  1 Retimer  */
+	{ 155670, 0, 0, 151310, 0, 0, 148050, 0, 146960, 153650, 151350, 149220 },
+	/*  2 Retimers */
+	{ 181160, 0, 0, 172450, 0, 0, 165910, 0, 163740, 177120, 172520, 168220 },
+	/*  3 Retimers */
+	{ 206650, 0, 0, 193580, 0, 0, 183780, 0, 180510, 200590, 193690, 187290 },
+	/*  4 Retimers */
+	{ 232140, 0, 0, 214710, 0, 0, 201650, 0, 197290, 224060, 214860, 206320 },
+	/*  5 Retimers */
+	{ 257620, 0, 0, 235850, 0, 0, 219510, 0, 214070, 247530, 236030, 225360 },
+	/*  6 Retimers */
+	{ 283110, 0, 0, 256980, 0, 0, 237380, 0, 230850, 271000, 257200, 244390 },
+};
+
+enum link_rate_idx {
+	LINK_RATE_INVALID = -1,
+	LINK_RATE_1,
+	LINK_RATE_2,
+	LINK_RATE_3,
+	LINK_RATE_4,
+	LINK_RATE_5,
+	LINK_RATE_6,
+	LINK_RATE_7,
+	LINK_RATE_8,
+	LINK_RATE_9,
+	LINK_RATE_10,
+	LINK_RATE_11,
+	LINK_RATE_12
+};
+
+static int get_link_rate_index(int port_clock)
+{
+	int link_rate_index;
+
+	switch (port_clock) {
+	case 162000:
+		link_rate_index = LINK_RATE_1;	// Rate_1 (RBR) - 1.62 Gbps/Lane
+		break;
+	case 216000:
+		link_rate_index = LINK_RATE_2;	// Rate_2       - 2.16 Gbps/Lane
+		break;
+	case 243000:
+		link_rate_index = LINK_RATE_3;	// Rate_3       - 2.43 Gbps/Lane
+		break;
+	case 270000:
+		link_rate_index = LINK_RATE_4;	// Rate_4 (HBR) - 2.70 Gbps/Lane
+		break;
+	case 324000:
+		link_rate_index = LINK_RATE_5;	// Rate_5 (RBR2)- 3.24 Gbps/Lane
+		break;
+	case 432000:
+		link_rate_index = LINK_RATE_6;	// Rate_6       - 4.32 Gbps/Lane
+		break;
+	case 540000:
+		link_rate_index = LINK_RATE_7;	// Rate_7 (HBR2)- 5.40 Gbps/Lane
+		break;
+	case 675000:
+		link_rate_index = LINK_RATE_8;	// Rate_8       - 6.75 Gbps/Lane
+		break;
+	case 810000:
+		link_rate_index = LINK_RATE_9;	// Rate_9 (HBR3)- 8.10 Gbps/Lane
+		break;
+	case 1000000:
+		link_rate_index = LINK_RATE_10;	// Rate_10 (UHBR10) - 10.0 Gbps/Lane
+		break;
+	case 1350000:
+		link_rate_index = LINK_RATE_11;	// Rate_11 (UHBR13.5) - 13.5 Gbps/Lane
+		break;
+	case 2000000:
+		link_rate_index = LINK_RATE_12;	// Rate_12 (UHBR20) - 20.0 Gbps/Lane
+		break;
+	default:
+		link_rate_index = LINK_RATE_INVALID;
+		break;
+	}
+
+	return link_rate_index;
+}
+
 static int get_establishment_period(struct intel_dp *intel_dp,
 				    const struct intel_crtc_state *crtc_state)
 {
@@ -138,8 +224,17 @@ static int get_establishment_period(struct intel_dp *intel_dp,
 	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
 		tcds = (7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1) * tml_phy_lock;
 	} else {
+		int idx = get_link_rate_index(crtc_state->port_clock);
+
 		tcds = 7 * tml_phy_lock;
 		lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
+
+		if (idx != LINK_RATE_INVALID && lttpr_count >= 0 &&
+		    lttpr_count < DEFAULT_MAX_LTTPR_COUNT &&
+		    establishment_periods[lttpr_count][idx]) {
+			establishment_period = establishment_periods[lttpr_count][idx];
+			return establishment_period;
+		}
 	}
 
 	if (lttpr_count > 0) {
-- 
2.29.0

