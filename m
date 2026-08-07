Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC03C5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34E5D10F397;
	Fri,  7 Aug 2026 04:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lYarMRmO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3966910F391;
 Fri,  7 Aug 2026 04:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077142; x=1817613142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kB/ATi8JpHA7usLNOeNpylb4tWRufyjTNngeMSpfQVw=;
 b=lYarMRmO68KFgk+qTPUzlIbXMxrs8Nl7cZHb8tU3DeVYfktzr4jtq5ZY
 2VLTVdOmQus35WkvwJShrZWinnFzCp6ZabCldDr/iV2/xPlgqQCiUUNBU
 QUgnWZEwj8IpktCHMuL6lbMOle4vL7yIGMOIcGT2fO343dWyHfj9rtyXI
 LVxzQKbCkn9Cbzhg2RWQ/94FWO5/giSJxD6WybMJlzz/Py15o7fqLIGbT
 t9ZDuqRH1o7DP3HiXswZC9ZYYrMdejVzw/gSqbrEPj5UJSHY9pKDmIPpG
 i8BfxvMGHg5pPVgbASWiPP9G0QRfCTTrYLVXA6Kl8yZglMkHeXsXOj6sl Q==;
X-CSE-ConnectionGUID: Zssvs9UXS92jtdQSQ982pA==
X-CSE-MsgGUID: cVgGy2lwSpSGQPObzNm+rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619321"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619321"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:19 -0700
X-CSE-ConnectionGUID: UsJUPJiVRDa1Zj1vGhuObA==
X-CSE-MsgGUID: ZHHYS0gVTLC9NDllYzI17g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666236"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:17 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 20/44] drm/i915/ltphy: Add safegaurd when calculation HDMI FRL
 state
Date: Fri,  7 Aug 2026 09:44:05 +0530
Message-ID: <20260807041430.229038-21-ankit.k.nautiyal@intel.com>
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

intel_lt_phy_pll_calc_state() will also take into account the
HDMI FRL tables and use them when the DPLL matches. We
still add a safegaurd to not calculate hdmi pll state if we are
using HDMI FRL.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index a16401e42ed9..88b86510e28a 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2042,7 +2042,8 @@ intel_lt_phy_pll_calc_state(struct intel_crtc_state *crtc_state,
 		}
 	}
 
-	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI)) {
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI) &&
+	    !intel_hdmi_is_frl(crtc_state->port_clock)) {
 		hw_state->ltpll.lane_count = crtc_state->lane_count;
 		return intel_lt_phy_calculate_hdmi_state(&hw_state->ltpll,
 							 crtc_state->port_clock);
-- 
2.50.1

