Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9977C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F7A10E68B;
	Mon, 20 Jul 2026 05:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TrlHCd0K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A5710E67B;
 Mon, 20 Jul 2026 05:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524556; x=1816060556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AOXW8hpfBPAlRCpckC1QA77FRTJg53CFTUFQtoMqKR4=;
 b=TrlHCd0KQx9mmtnXQOSP7ACJMBsg4IpZIFMQ82H8nXuWxlFlMWM0UDnA
 nekXOE3sws8OTRCsFH2lPnsxMZ8y6gtddekcGfjyObDNzYtffQjfcprF1
 a/4UUP9KHF1Qqy4TKUvNeeG6Y0CvFBvAw/Sgx38MXPT9jc+Zn859eJ2ZO
 5R0e7m5JZzqHAq+RaPaV/AWGR6d+IkTflXYpbpFzjANqJSSQ5YqtWh+yv
 yhIpKuA1rRRGQR4J6j8bO7IZcf+cYa0AV8kVfwegmewKYJPudJ3JeYinf
 sA7uPgA3PYyfk7QabXxLqHcT53uF4lodBV4zh8wtLNqbC0mG5yW2wA4TS g==;
X-CSE-ConnectionGUID: HObEOgVLRv2saP8JlpzP5A==
X-CSE-MsgGUID: SfyleN+aTnms+nFEYZCvfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133425"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133425"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:56 -0700
X-CSE-ConnectionGUID: OhnaA+E+Ti6cp4O6vig1vg==
X-CSE-MsgGUID: UbTsGeQhTnCM+2WfzJiF4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419837"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:55 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Pranay Samala <pranay.samala@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 13/14] drm/i915/color: Program Plane Post CSC registers for SDR
 planes
Date: Mon, 20 Jul 2026 10:21:30 +0530
Message-Id: <20260720045131.971650-14-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
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

From: Pranay Samala <pranay.samala@intel.com>

Implement plane post-CSC LUT support for SDR planes.

v2:
- Restructure loop to match HDR function pattern

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Co-developed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 360046979556..be2e1d8ce0e6 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -4082,6 +4082,45 @@ xelpd_load_hdr_post_csc_lut(struct intel_display *display,
 	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX_ENH(pipe, plane, 0), 0);
 }
 
+static void
+xelpd_load_sdr_post_csc_lut(struct intel_display *display,
+			    struct intel_dsb *dsb,
+			    enum pipe pipe,
+			    enum plane_id plane,
+			    const struct drm_color_lut32 *post_csc_lut)
+{
+	int i, lut_size = 32;
+	u32 lut_val;
+
+	/*
+	 * First 3 planes are HDR, so reduce by 3 to get to the right
+	 * SDR plane offset
+	 */
+	plane = plane - 3;
+
+	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX(pipe, plane, 0),
+			   PLANE_PAL_PREC_AUTO_INCREMENT);
+
+	for (i = 0; i < lut_size + 3; i++) {
+		if (post_csc_lut) {
+			if (i < lut_size)
+				lut_val = drm_color_lut32_extract(post_csc_lut[i].green, 16);
+			/* else duplicate last lut_val */
+		} else {
+			if (i < lut_size)
+				lut_val = (i * ((1 << 16) - 1)) / (lut_size - 1);
+			else
+				lut_val = 1 << 16;
+		}
+
+		intel_de_write_dsb(display, dsb,
+				   PLANE_POST_CSC_GAMC_DATA(pipe, plane, 0),
+				   lut_val);
+	}
+
+	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX(pipe, plane, 0), 0);
+}
+
 static void
 xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 				 const struct intel_plane_state *plane_state)
@@ -4095,6 +4134,8 @@ xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 
 	if (icl_is_hdr_plane(display, plane))
 		xelpd_load_hdr_post_csc_lut(display, dsb, pipe, plane, post_csc_lut);
+	else
+		xelpd_load_sdr_post_csc_lut(display, dsb, pipe, plane, post_csc_lut);
 }
 
 static void
-- 
2.25.1

