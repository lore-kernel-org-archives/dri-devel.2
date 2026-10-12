Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C51CA9EDC
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EF010E78F;
	Mon, 12 Oct 2026 04:15:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D483710E5D3;
 Mon, 12 Oct 2026 04:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778552; x=1823314552;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yd7CPOABnHglbQnbVlxtpcV4tBk2nBV/I/x76ge3IWc=;
 b=ReF98xpjQNFnSu5/6oy2JqAW/siqFaTxuDzg3tX4RwX/HIYrz0puDa/l
 MRIhgj5nR+7HvmyVWdsUuFzmjpc3J6JWk+TAPDggHoe9+9WsjqU/8DPEZ
 L62PI8AtldTLChyTsr6m/d7A7Bz60C/dRF76DsBH0Zx+CI4ergZWB8CZN
 2ACSieqT8T9vhyfWodCWwdcWCXXO7O34Q/CsYWJma6beEYWq7S0iLxbLG
 NTToyJRNCrt0uZsNS1RxQ72XNx/YXNv3uLmNeRXnm67FYVwEFbWyYr+xW
 7CxF0H94bE9L+3Uex2WuxRwL/QGcrmnXwxQsMgC3d9U51F6W2uaOPmyrN w==;
X-CSE-ConnectionGUID: URLHfMX3QWmlwIVJs4ZuRg==
X-CSE-MsgGUID: 0K0ZPKrARta8UBqUtdTFtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380941"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380941"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:51 -0700
X-CSE-ConnectionGUID: xhCnNyOuQUmBoM92VtbvgQ==
X-CSE-MsgGUID: EE6t5Cq0SU6GmiO3MvHcJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256681"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:50 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 43/56] drm/i915/hdmi: Compute FRL Link M/N
Date: Mon, 12 Oct 2026 09:27:52 +0530
Message-ID: <20261012035806.3361439-44-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

For HDMI FRL, the transcoder Link M/N carries the ratio of the average
tribyte rate (ftb_avg) to the FRL div18 clock, unlike the pixel/link
clock ratio used for DP.

Compute link_m/link_n from ftb_avg and the required FRL rate, reduced by
their gcd. As PIPE_LINK_M1/N1 are 32-bit wide, scale both down preserving
the ratio until they fit, and store them in crtc_state.

v2: Use full 32 bits for LINK_M/N for HDMI2.1.

Bspec: 68848
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_display_regs.h |  1 +
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 38 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 1abd221f966b..7e1c12560a00 100644
--- a/drivers/gpu/drm/i915/display/intel_display_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
@@ -863,6 +863,7 @@
 #define  TU_SIZE(x)		REG_FIELD_PREP(TU_SIZE_MASK, (x) - 1) /* default size 64 */
 #define  DATA_LINK_M_N_MASK	REG_GENMASK(23, 0)
 #define  DATA_LINK_N_MAX	(0x800000)
+#define  HDMI_FRL_LINK_M_N_MAX	REG_GENMASK(31, 0)
 
 #define _PIPEA_DATA_N_G4X	0x70054
 #define _PIPEB_DATA_N_G4X	0x71054
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index c5f25d2d6331..ce6ad9e28bee 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gcd.h>
 #include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
@@ -2308,6 +2309,38 @@ static int intel_hdmi_compute_tmds_clock(struct intel_encoder *encoder,
 	return 0;
 }
 
+static void
+compute_frl_mn(struct intel_crtc_state *crtc_state, u32 ftb_avg_k)
+{
+	u64 ftb_avg, div_18_clk, gcd_val;
+	u64 link_m, link_n;
+
+	ftb_avg = (u64)ftb_avg_k * 1000;
+	div_18_clk = mult_frac(1000000000, crtc_state->frl.required_rate, 18);
+	gcd_val = gcd(ftb_avg, div_18_clk);
+
+	link_m = DIV_ROUND_UP_ULL(ftb_avg, gcd_val);
+	link_n = DIV_ROUND_UP_ULL(div_18_clk, gcd_val);
+
+	/*
+	 * PIPE_LINK_M1/N1 are 32-bit for HDMI2.1. Scale both
+	 * down preserving the ratio until they fit the register width.
+	 *
+	 * #TODO check if intel_reduce_m_n_ratio() can be exported.
+	 */
+	while (link_m > HDMI_FRL_LINK_M_N_MAX ||
+	       link_n > HDMI_FRL_LINK_M_N_MAX) {
+		link_m >>= 1;
+		link_n >>= 1;
+	}
+
+	crtc_state->frl.link_m = (u32)link_m;
+	crtc_state->frl.link_n = (u32)link_n;
+
+	/* Frl div 18 stored in Khz */
+	crtc_state->frl.div18 = DIV_ROUND_UP_ULL(div_18_clk, 1000);
+}
+
 static int
 intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
 			      struct intel_crtc_state *crtc_state)
@@ -2378,6 +2411,11 @@ intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
 	else
 		crtc_state->frl.tb_threshold_min = 492;
 
+	compute_frl_mn(crtc_state, frl_dfm.params.ftb_avg_k);
+	drm_dbg_kms(display->drm, "FRL Clock: link_m = %dHz, link_n = %dHz, div18 = %dKHz\n",
+		    crtc_state->frl.link_m, crtc_state->frl.link_n,
+		    crtc_state->frl.div18);
+
 	/*
 	 * TODO
 	 * 1. Calculate condition for Reseource based scheduling enable.
-- 
2.50.1

