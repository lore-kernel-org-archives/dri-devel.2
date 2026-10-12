Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25858CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6C10E443;
	Mon, 12 Oct 2026 04:15:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE2810E498;
 Mon, 12 Oct 2026 04:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778504; x=1823314504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=unixOwxnnO3gDHnJqSQkJ1LL14V0e4zVUic7gf4q+uE=;
 b=mbsyqfnykjQl+T6a3MCOkWTDhDzFe4Qg+Qo++TpAPgm7GADYuok06YC6
 wm3j+gFwqudAbe6mOG/CgmwEMO/HcF4N43XyX437hLi+fTKctZar/A/04
 iKjSZGbBZ53ojouduP9qezrlRH2jCeGSLm5qdbcO332n/4JnBazD9ug/Z
 NFl9UbfoeUnkEWmVd6/kOghVmaYt7L4tPXyIGfHZA+olztjU6orbbgTtP
 sHRFFuSMlLmxKmd1g/ygWRWkSfW/BCST7fxrVg5taWkMdCATujivot72N
 urDJ4MAI4qZb4womj7MYnkkDEGzNYdOxK0qi1VHrE7SPNQ5Gbq5E8mo/x Q==;
X-CSE-ConnectionGUID: HxgUr/FJSVmNkxibKR5hyw==
X-CSE-MsgGUID: vo9fkTSQRK++T5/j56kfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380861"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:59 -0700
X-CSE-ConnectionGUID: nNCbKzFdQ5GpI4ICprvUuw==
X-CSE-MsgGUID: +YfYS22yQ2qKvqweM/8BYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256435"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:58 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 20/56] drm/i915/ltphy: Add safegaurd when calculation HDMI
 FRL state
Date: Mon, 12 Oct 2026 09:27:29 +0530
Message-ID: <20261012035806.3361439-21-ankit.k.nautiyal@intel.com>
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

intel_lt_phy_pll_calc_state() will also take into account the
HDMI FRL tables and use them when the DPLL matches. We
still add a safegaurd to not calculate hdmi pll state if we are
using HDMI FRL.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 61bad87eefec..0e2ebd550bc5 100644
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

